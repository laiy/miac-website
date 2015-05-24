#	> File Name: album.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, December 10, 2014 AM09:58:47 CST

express = require 'express'
fs = require 'fs'
gm = require 'gm'
mongoose = require 'mongoose'
async = require 'async'
router = express.Router()
imageMagick = gm.subClass { imageMagick: true }
{ requireLogin } = require './helpers/authorization.coffee'
AlbumModel = require '../db/models/album.coffee'
MessageModel = require '../db/models/message.coffee'

###
* render 'album' when get '/album'
* find all the albums in AlbumModel
* render with albums
###
router.get '/', (req , res)->
    AlbumModel.find {}, (err, albums)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'album', albums: albums

###
* render 'createAlbum' when get '/album/createAlbum'
###
router.get '/createAlbum', requireLogin, (req, res)->
    res.render 'createAlbum'

###
* render 'childAlbum' when get '/album/:id'
* find a album with album's id
* find comments in MessageModel with album's id
* find rpelys in comment's id for each comment in comments
* render with album and comments(containing replys)
* @param id: the ObjectId of the specific album
###
router.get '/:id', (req, res)->
    id = mongoose.Types.ObjectId req.params.id
    AlbumModel.findOne { _id: id }, (err, album)->
        if err
            return res.status(500).send 'Server Error.'
        else
            MessageModel.find { replyTo: id , type: 'comment'}, (err, comments)->
                if not comments
                    res.render 'childAlbum', album: album
                else
                    async.each comments, (comment, callback)->
                        MessageModel.find { replyTo: comment._id, type: 'reply' }, (err, replys)->
                            if not replys
                                callback()
                            else
                                comment.replys = replys
                                callback()
                    , (err)->
                        res.render 'childAlbum', { album: album, comments: comments }

###
* handle when post '/album/createAlbum'
* require user's login to continue process
* if file is not image, return fail
* make a directory named album's title in server local assets
* resize image and write cover's image to album's directory
* createAlbum in AlbumModel with title, user's id as well as cover's filename
* @param req.files.cover: image that belong to album's cover
* @param title: album's title
###
router.post '/createAlbum', requireLogin, (req, res)->
    if not req.files.cover
        return res.status(500).send 'Server Error.'
    else
        { title } = req.body
        coverPath = req.files.cover.path
        coverName = req.files.cover.name
        if req.files.cover.mimetype.split('/')[0] isnt 'image'
            fs.unlink coverPath, ->
                res.json { result: 'fail', msg: 'Not a image!' }
        else
            fs.mkdir 'views/assets/img/album/' + title, ->
                imageMagick(coverPath)
                    .resize 150, 150, '!'
                    .autoOrient()
                    .write 'views/assets/img/album/' + title + '/' + coverName, (err)->
                        if err
                            return res.status(500).send 'Server Error.'
                        else
                            fs.unlink coverPath, ->
                                AlbumModel.createAlbum title, req.session.user._id, coverName, ->
                                    res.redirect '/album'

###
* handle when post '/album/addPicture'
* require user's login to continue process
* validate if the albumId is legal
* if file is not image, return fail
* find the album with albumId
* validate if the user is the one who create the album
* write the file to the directory belonging to the album and redirect to album child page
* @param req.files.picture: album's picture that user want to add
* @param albumId: the ObjectId that belong to the album that the user want to add to
###
router.post '/addPicture', requireLogin, (req, res)->
    if not req.files.picture
        return res.status(500).send 'Server Error.'
    else
        { albumId } = req.body
        if not /^(?=[a-f\d]{24}$)(\d+[a-f]|[a-f]+\d)/i.test(albumId)
            return res.json { result: 'fail', msg: 'Invalid albumId.' }
        else
            albumId = mongoose.Types.ObjectId(albumId)
            AlbumModel.findOne { _id: albumId }, (err, album)->
                if err
                    return res.status(500).send 'Server Error.'
                else
                    if req.session.user._id isnt album.createdBy.toString()
                        return res.json { result: 'fail', msg: 'U r not permitted 2 add picture 2 @ album.' }
                    else
                        path = req.files.picture.path
                        name = req.files.picture.name
                        if req.files.picture.mimetype.split('/')[0] isnt 'image'
                            fs.unlink path, ->
                                res.json { result: 'fail', msg: 'Not a image!' }
                        else
                            imageMagick(path).write 'views/assets/img/album/' + album.title + '/' + name, (err)->
                                if err
                                    return res.status(500).send 'Server Error.'
                                else fs.unlink path, ->
                                    AlbumModel.addPicture albumId, name, ->
                                        res.redirect '/album/' + albumId

###
* handle when post '/album/deleteAlbum'
* require user's login to continue process
* return fail if invalid album id occurs
* return fail if current user is not the author of the album
* @param albumId: the id of the album to be deleted
###
router.post '/deleteAlbum', requireLogin, (req, res)->
    { albumId } = req.body
    AlbumModel.findOne { _id: albumId }, (err, album)->
        if (err)
            return res.status(500).send 'Server Error.'
        else
            if not album
                return res.json { result: 'fail', msg: 'Invalid album id.' }
            else
                if album.createdBy.toString() is req.session.user._id
                    AlbumModel.deleteAlbum album._id, ->
                        res.json { result: 'success' }
                else
                    return res.json { result: 'fail', msg: 'The album is not created by current user.' }

module.exports = router


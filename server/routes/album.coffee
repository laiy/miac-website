#	> File Name: album.coffee #	> Author: LY #	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, December 10, 2014 AM09:58:47 CST

express = require 'express'
fs = require 'fs'
gm = require 'gm'
mongoose = require 'mongoose'
router = express.Router()
imageMagick = gm.subClass { imageMagick: true }
{ requireLogin } = require './helpers/authorization.coffee'
AlbumModel = require '../db/models/album.coffee'

router.get '/', (req , res)->
    AlbumModel.find {}, (err, albums)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'album', albums: albums

router.get '/:id', (req, res)->
    id = mongoose.Types.ObjectId req.params.id
    AlbumModel.findOne { _id: id }, (err, album)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'childAlbum', album: album

router.get '/createAlbum', requireLogin, (req, res)->
    res.render 'createAlbum'

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
                    .write 'views/assets/img/album/' + title + coverName, (err)->
                        if err
                            return res.status(500).send 'Server Error.'
                        else
                            fs.unlink coverPath, ->
                                AlbumModel.createAlbum title, req.session.user._id, coverName, ->
                                    res.redirect '/album'

router.post '/addPicture', requireLogin, (req, res)->
    if not req.files.picture
        return res.status(500).send 'Server Error.'
    else
        { albumId } = req.body
        if not /^(?=[a-f\d]{24}$)(\d+[a-f]|[a-f]+\d)/i.test(albumId)
            return json { result: 'fail', msg: 'U r not permitted 2 add picture 2 @ album.' }
        else
            AlbumModel.find { _id: albumId }, (err, album)->
                if err
                    return res.status(500).send 'Server Error.'
                else
                    if req.session.user._id isnt album.createdBy
                        return json { result: 'fail', msg: 'U r not permitted 2 add picture 2 @ album.' }
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

module.exports = router


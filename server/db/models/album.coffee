#	> File Name: album.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Tuesday, December 09, 2014 PM03:22:29 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

AlbumSchema = new Schema
    title: String
    createdAt: { type: Date, default: Date.now }
    createdBy: ObjectId
    pictures: [String]
    cover: String

AlbumModel = mongoose.model 'AlbumModel', AlbumSchema

###
* create a album in AlbumModel with title, user's id and cover
* @param title: album's title
* @param createdBy: user's id, to memorize who create the album
* @param cover: the name of the cover piture, so later we could get image in front-end with 'path + name'
* @param callback: the callback function that would execute when function ended
###
AlbumModel.createAlbum = (title, createdBy, cover, callback)->
    AlbumModel.create
        title: title
        createdBy: createdBy
        cover: cover
    , callback

###
* add picture's name to album's pictures
* find a album with albumId
* add picture to the array of album's pictures
* @param albumId: the ObjectId that to add picture to
* @param picture: the picture's name
* @param callback: the callback function that would execute when function ended
###
AlbumModel.addPicture = (albumId, picture, callback)->
    AlbumModel.findOne { _id: albumId }, (err, album)->
        if album
            album.pictures.push picture
            album.save ->
                callback()

###
* drop all the albums in AlbumModel
* @param callback: the callback function that would execute when function ended
###
AlbumModel.drop = (callback)->
    AlbumModel.remove {}, ->
        callback()

###
* delete album by ObjectId
* @param albumId: the id of the album to be deleted
* @param callback: the callback function that would execute when function ended
###
AlbumModel.deleteAlbum = (albumId, callback)->
    AlbumModel.remove { _id: albumId }, ->
        callback()

module.exports = AlbumModel


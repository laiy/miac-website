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
###
AlbumModel.createAlbum = (title, createdBy, cover, callback)->
    AlbumModel.create
        title: title
        createdBy: createdBy
        cover: cover
    , callback

###
* 
###
AlbumModel.addPicture = (albumId, picture, callback)->
    AlbumModel.findOne { _id: albumId }, (err, album)->
        if album
            album.pictures.push picture
            album.save ->
                callback()

###
* drop all the albums in AlbumModel
###
AlbumModel.drop = (callback)->
    AlbumModel.remove {}, ->
        callback()

module.exports = AlbumModel


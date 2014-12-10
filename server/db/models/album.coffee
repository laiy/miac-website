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

AlbumModel.createAlbum = (title, createdBy, cover, callback)->
    AlbumModel.create
        title: title
        createdBy: createdBy
        cover: cover
    , callback

AlbumModel.addPicture = (albumId, picture, callback)->
    AlbumModel.findOne { _id: albumId }, (err, album)->
        if album
            album.pictures.push picture
            album.save ->
                callback()

AlbumModel.drop = (callback)->
    AlbumModel.remove {}, ->
        callback()

module.exports = AlbumModel


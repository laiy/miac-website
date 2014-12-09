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

AlbumModel.createAlbum = (title, createdBy, pictures, cover, callback)->
    AlbumModel.create
        title: title
        createdBy: createdBy
        pictures: pictures
        cover: cover
    , callback

module.exports = AlbumModel


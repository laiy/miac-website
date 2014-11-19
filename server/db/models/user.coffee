#	> File Name: user.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:15:46 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema

userSchema = new Schema
    _id: Schema.Types.ObjectId
    username: string
    password: String
    avatar: {type: String, default: "default.jpg"}
    email: String
    createArticles: [{lastAccessTime: Date, id: Schema.Types.ObjectId}]
    createShares: [{lastAccessTime: Date, id: Schema.Types.ObjectId}]
    createDiscuss: [{lastAccessTime: Date, id: Schema.Types.ObjectId}]
    createAlbums: [{lastAccessTime: Date, id: Schema.Types.ObjectId}]
    createWorks: [{lastAccessTime: Date, id: Schema.Types.ObjectId}]



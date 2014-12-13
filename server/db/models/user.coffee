#	> File Name: user.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:15:46 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
util = require '../../common/util.coffee'

UserSchema = new Schema
    username: String
    password: String
    avatar: { type: String, default: 'default.jpg' }
    email: String
    status: { type: String, default: 'user' } # user or clubMember or admin
    createArticles: [{ lastAccessTime: Date, id: ObjectId }]
    createShares: [{ lastAccessTime: Date, id: ObjectId }]
    createDiscuss: [{ lastAccessTime: Date, id: ObjectId }]
    createAlbums: [{ lastAccessTime: Date, id: ObjectId }]
    createWorks: [{ lastAccessTime: Date, id: ObjectId }]

UserModel = mongoose.model 'UserModel', UserSchema

UserModel.createAdministrator = (callback)->
    callback = callback or ->
    UserModel.findOne { status: 'admin' }, (err, admin)->
        if not admin
            UserModel.create
                username: 'admin'
                password: util.encrypt 'miac-website'
                email: 'ly.franky@gmail.com'
                status: 'admin'
            , callback
        else
            callback()

UserModel.createUser = (username, password, email, callback)->
    UserModel.create
        username: username
        password: util.encrypt password
        email: email
        isAdmin: no
    , callback

UserModel.updateEmail = (email, userId, callback)->
    UserModel.findOne { _id: userId }, (err, user)->
        if user
            user.email = email
            user.save ->
                callback()

UserModel.updatePassword = (password, userId, callback)->
    UserModel.findOne { _id: userId }, (err, user)->
        if user
            user.password = password
            user.save ->
                callback()

UserModel.updateAvatar = (fileName, userId, callback)->
    UserModel.findOne { _id: userId }, (err, user)->
        if user
            user.avatar = fileName
            user.save ->
                callback()

UserModel.drop = (callback)->
    UserModel.remove {}, ->
        callback()

module.exports = UserModel


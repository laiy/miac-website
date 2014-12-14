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

###
* if not admin existed, then create a new administrator
* @param callback: the callback function that would execute when function ended
###
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

###
* create a user in UserModel with username, password and email
* @param username: the user's name(one and only)
* @param password: the user's password, should be encrypted before saving
* @param email: the user's email
* @param callback: the callback function that would execute when function ended
###
UserModel.createUser = (username, password, email, callback)->
    UserModel.create
        username: username
        password: util.encrypt password
        email: email
        isAdmin: no
    , callback

###
* update email of user
* find a user by userId and update email
* @param email: the email that would replace the old one
* @param userId: the user's id to update email
* @param callback: the callback function that would execute when function ended
###
UserModel.updateEmail = (email, userId, callback)->
    UserModel.findOne { _id: userId }, (err, user)->
        if user
            user.email = email
            user.save ->
                callback()

###
* update password of user
* find a user by userId and update password
* @param password: the password that would replace the old one
* @param userId: the user's id to update password
* @param callback: the callback function that would execute when function ended
###
UserModel.updatePassword = (password, userId, callback)->
    UserModel.findOne { _id: userId }, (err, user)->
        if user
            user.password = password
            user.save ->
                callback()

###
* update avatar of user
* find a user by userId and update avatar
* @param fileName: the file's name of avatar's image
* @param userId: the user's id to update avatar
* @param callback: the callback function that would execute when function ended
###
UserModel.updateAvatar = (fileName, userId, callback)->
    UserModel.findOne { _id: userId }, (err, user)->
        if user
            user.avatar = fileName
            user.save ->
                callback()

###
* drop all the user in UserModel
* @param callback: the callback function that would execute when function ended
###
UserModel.drop = (callback)->
    UserModel.remove {}, ->
        callback()

module.exports = UserModel


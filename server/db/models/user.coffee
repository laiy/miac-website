#	> File Name: user.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:15:46 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
util = require '../../common/util.coffee'


UserSchema = new Schema
    #_id: ObjectId
    username: String
    password: String
    avatar: {type: String, default: "default.jpg"}
    email: String
    isAdmin: Boolean
    createArticles: [{lastAccessTime: Date, id: ObjectId}]
    createShares: [{lastAccessTime: Date, id: ObjectId}]
    createDiscuss: [{lastAccessTime: Date, id: ObjectId}]
    createAlbums: [{lastAccessTime: Date, id: ObjectId}]
    createWorks: [{lastAccessTime: Date, id: ObjectId}]

UserModel = mongoose.model 'User', UserSchema

UserModel.createAdministrator = (callback)->
    callback = callback or ->
    UserModel.count {}, (err, count)->
        if count isnt 0 then callback?(err, count)
        createAdmin callback
        createAdmin = (callback)->
            UserModel.create {
                username: 'admin'
                password: util.encrypt 'miac-website'
                email: 'ly.franky@gmail.com'
                isAdmin: yes
            }, callback

UserModel.createUser = (username, password, email, callback)->
    UserModel.create {
        username: username
        password: password
        email: email
        isAdmin: no
    }, callback

module.exports = UserModel


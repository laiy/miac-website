#> File Name: db.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:58:31 CST

mongoose = require "mongoose"
UserModel = require "./models/user.coffee"
config = require '../config.coffee'
MessageModel = require './models/message.coffee'
ArticleModel = require './models/article.coffee'
DiscussionModel = require './models/discuss.coffee'
AlbumModel = require './models/album.coffee'

db = null

###
* init database
* create a administrator
###
init = ->
    initDB ->
        # UserModel.createAdministrator ->
        # DiscussionModel.drop ->
        # MessageModel.drop ->
        # UserModel.drop ->
        # ArticleModel.drop ->
        # AlbumModel.drop ->

###
* set database URL in mongoose
* connect database
* @param callback: callback function that would call when function ended
###
initDB = (callback)->
    if process.env.NODE_ENV is "DEV"
        mongoose.connect config.TEST_DB_URI
    else
        mongoose.connect config.PRODUCTION_DB_URI
    db = mongoose.connection
    callback()

module.exports = {db, init}


#	> File Name: db.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:58:31 CST

mongoose = require "mongoose"
User = require "./models/user.coffee"

db = null

init = ->
    initDB()

initDB = ->
    db = mongoose.connection

module.exports = {db, init}


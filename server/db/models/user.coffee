#	> File Name: user.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:15:46 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema

userSchema = new Schema
    username: string
    password: String
    avatar: {type: String, default: "default.jpg"}
    email: String

    

#	> File Name: message.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Friday, November 28, 2014 PM04:26:00 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

MessageSchema = new Schema
    replyTo: ObjectId
    

MessageModel = mongoose.model 'MessageModel', MessageSchema

module.exports = MessageModel

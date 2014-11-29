#	> File Name: message.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Friday, November 28, 2014 PM04:26:00 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

MessageSchema = new Schema
    replyTo: ObjectId
    type: String
    content: String
    createdBy: ObjectId
    createdAt: { type: Date, default: Date.now }

MessageModel = mongoose.model 'MessageModel', MessageSchema

MessageModel.createMessage = (callback)->
    MessageModel.create {
        
    }


module.exports = MessageModel

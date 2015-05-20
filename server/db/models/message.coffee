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
    avatar: { type: String, default: 'default.jpg' }
    username: String

MessageModel = mongoose.model 'MessageModel', MessageSchema

###
* create a message in MessageModel with replyTo, type, content and user's id
* @param replyTo: the ObjectId that the message is replying to, it could be article's id or discussion's id or message's id,etc
* @param type: the message's type, 'comment' or 'reply'
* @param createdBy: user's id, to memorize who create the message
* @param callback: the callback function that would execute when function ended
###
MessageModel.createMessage = (replyTo, type, content, createdBy, avatar, username, callback)->
    MessageModel.create
        replyTo: replyTo
        type: type
        content: content
        createdBy: createdBy
        createdAt: Date.now()
        avatar: avatar
        username: username
    , callback

###
* drop all the messages in MessageModel
* @param callback: the callback function that would execute when function ended
###
MessageModel.drop = (callback)->
    MessageModel.remove {}, ->
        callback()

module.exports = MessageModel

#	> File Name: message.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, November 29, 2014 AM09:40:19 CST

express = require 'express'
router = express.Router()
MessageModel = require '../db/models/message.coffee'
{requireLogin} = require './helpers/authorization.coffee'

###
* handle when post '/message/create'
* require user's login to continue process
* return fail when bad params occur
* create a new message in MessageModel with replyTo, type, content and user's id
* @param replyTo: the id that the Message is replying to, it can be a article's id or discussion's id or a message's id
* @param type: the type of the message, it could be 'comment' and 'reply'
* @param content: the content of the message
###
router.post '/create', requireLogin, (req, res)->
    {replyTo, type, content} = req.body
    createdBy = req.session.user._id
    if not replyTo or not type or not createdBy or not content
        return res.json {result: 'fail', msg: 'Info not completed.'}
    else if not /^(?=[a-f\d]{24}$)(\d+[a-f]|[a-f]+\d)/i.test(replyTo)
        return res.json {result: 'fail', msg: 'Bad ObjectId.'}
    else if type isnt 'comment' and type isnt 'reply'
        return res.json {result: 'fail', msg: 'Bad type.'}
    else
        avatar = req.session.user.avatar
        username = req.session.user.username
        MessageModel.createMessage replyTo, type, content, createdBy, avatar, username, ->
            res.json {result: 'success'}

###
* handle when post '/message/delete'
* require user's login to continue process
* return fail if invalid message id occurs
* return fail if current user is not the author of the message
* @param messageId: the id of the message to be deleted
###
router.post '/delete', requireLogin, (req, res)->
    { messageId } = req.body
    MessageModel.findOne { _id: messageId }, (err, message)->
        if err
            return res.status(500).send 'Server Error.'
        else
            if not message
                return res.json { result: 'fail', msg: 'Invalid message id.' }
            else
                if message.createdBy.toString() is req.session.user._id
                    MessageModel.deleteMessage message._id, ->
                        res.json { result: 'success' }
                else
                    return res.json { result: 'fail', msg: 'The message is not created by current user.' }

###
* handle when post '/message/updateContent'
* require user's login to continue process
* return fail if invalid message id occurs
* return fail if current user is not the author of the message
* @param messageId: the id of the message to be updated
* @param content: the content to cover the existed content
###
router.post '/updateContent', requireLogin, (req, res)->
    { messageId, content } = req.body
    MessageModel.findOne { _id: messageId }, (err, message)->
        if err
            return res.status(500).send 'Server Error.'
        else
            if not message
                return res.json { result: 'fail', msg: 'Invalid message id.' }
            else
                if message.createdBy.toString() is req.session.user._id
                    MessageModel.updateContent message._id, content, ->
                        res.json { result: 'success' }
                else
                    return res.json { result: 'fail', msg: 'The message is not created by current user.' }

module.exports = router

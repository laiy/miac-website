#	> File Name: message.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, November 29, 2014 AM09:40:19 CST

express = require 'express'
router = express.Router()
MessageModel = require '../db/models/message.coffee'
{requireLogin} = require './helpers/authorization.coffee'

router.post '/create', requireLogin, (req, res)->
    {replyTo, type, content} = req.body
    createdBy = req.session.user._id
    if not replyTo or not type or not createdBy
        return res.json {result: 'fail', msg: 'Info not completed.'}
    else if not /^(?=[a-f\d]{24}$)(\d+[a-f]|[a-f]+\d)/i.test(replyTo)
        return res.json {result: 'fail', msg: 'Bad ObjectId.'}
    else if type isnt 'comment' and type isnt 'reply'
        return res.json {result: 'fail', msg: 'Bad type.'}
    else
        ArticleModel.createArticle replyTo, type, content, createdBy, ->
            res.json {result: 'success'}

module.exports = router

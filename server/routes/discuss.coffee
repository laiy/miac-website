#	> File Name: discuss.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, December 06, 2014 AM09:09:54 CST

express = require 'express'
mongoose = require 'mongoose'
router = express.Router()
{ requireLogin } = require './helpers/authorization.coffee'
DiscussionModel = require '../db/models/discuss.coffee'

router.get '/', (req, res)->
    DiscussionModel.find {}, (err, discussions)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'discuss', discussions: discussions

router.get '/create', requireLogin, (req, res)->
    res.render 'createDiscuss'

router.post '/create', (req, res)->
    { type, title, content, answerTo } = req.body
    createdBy = req.session.user.username
    if not title or not type or not content
        return res.json { result: 'fail', msg: 'Info not completed.' }
    else if type isnt 'question' or type isnt 'answer'
        return res.json { result: 'fail', msg: 'Bad type.' }
    else if not /^(?=[a-f\d]{24}$)(\d+[a-f]|[a-f]+\d)/i.test(answerTo) and test isnt ''
        return res.json { result: 'fail', msg: 'Bad ObjectId.' }
    else
        DiscussionModel.createDiscussion type, title, content, answerTo, createdBy, ->
            res.json { result: 'success' }

router.get '/:id', (req, res)->
    id = mongoose.Types.ObjectId(req.params.id)

module.exports = router

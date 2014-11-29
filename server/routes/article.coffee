#	> File Name: article.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 PM07:09:34 CST

express = require 'express'
mongoose = require 'mongoose'
router = express.Router()
ArticleModel = require '../db/models/article.coffee'
{ requireLogin } = require './helpers/authorization.coffee'
MessageModel = require '../db/models/message.coffee'

router.get '/', (req, res)->
    ArticleModel.find {}, (err, articles)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'article', articles: articles

router.get '/create', requireLogin, (req, res)->
    res.render 'createArticle'

router.get '/:id', (req, res)->
    id = mongoose.Types.ObjectId(req.params.id)
    ArticleModel.findOne { _id: id }, (err, article)->
        if err
            return res.status(500).send 'Server Error.'
        else
            MessageModel.find { replyTo: id , type: 'comment'}, (err, comments)->
                if not comments
                    res.render 'childArticle', article: article
                else
                    setReplys = (callback)->
                        for comment in comments
                            MessageModel.find {replyTo: comment._id, type: 'reply'}, (err, replys)->
                                if replys
                                    comment.replys = replys
                                    callback()
                    setReplys ->
                        res.render 'childArticle', { article: article, comments: comments }

router.post '/create', (req, res)->
    { category, title, content } = req.body
    createdBy = req.session.user.username
    ArticleModel.findOne { title }, (err, article)->
        if article
            return res.json { result: 'fail', msg: 'Article has already existed.' }
        else if not title or not content or not createdBy
            return res.json { result: 'fail', msg: 'Info not completed.' }
        else
            ArticleModel.createArticle category, title, content, createdBy, ->
                res.json { result: 'success' }

module.exports = router

#	> File Name: article.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 PM07:09:34 CST

express = require 'express'
mongoose = require 'mongoose'
async = require 'async'
router = express.Router()
ArticleModel = require '../db/models/article.coffee'
{ requireLogin } = require './helpers/authorization.coffee'
MessageModel = require '../db/models/message.coffee'

###
* render 'article' when get '/article'
* find all the articles in ArticleModel
* render with articles
###
router.get '/', (req, res)->
    ArticleModel.find {}, (err, articles)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'article', articles: articles, name: 'article'

###
* render 'childArticle' when get '/article/create'
###
router.get '/create', requireLogin, (req, res)->
    res.render 'createArticle', name: 'createArticle'

###
* render 'childArticle' when get '/article/:id'
* find a article with the article's id
* find comments in MessageModel with album's id
* find reply in comment's id for each comment in comments
* render with article as well as comments(containing replys)
* @param id: the ObjectId of the specific article
###
router.get '/:id', (req, res)->
    id = mongoose.Types.ObjectId req.params.id
    ArticleModel.findOne { _id: id }, (err, article)->
        if err
            return res.status(500).send 'Server Error.'
        else
            MessageModel.find { replyTo: id , type: 'comment'}, (err, comments)->
                if not comments
                    res.render 'childArticle', article: article, name: 'childArticle'
                else
                    async.each comments, (comment, callback)->
                        MessageModel.find { replyTo: comment._id, type: 'reply' }, (err, replys)->
                            if not replys
                                callback()
                            else
                                comment.replys = replys
                                callback()
                    , (err)->
                        res.render 'childArticle', { article: article, comments: comments, name: 'childArticle' }

###
* handle when post '/article/create'
* require user's login to continue process
* return fail when title has already existed
* return fail when params is not completed
* create article in ArticleModel with title, content, user's id and category
* @param category: the category of article
* @param title: article's title, which is one and only
* @param content: article's content
###
router.post '/create', requireLogin, (req, res)->
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

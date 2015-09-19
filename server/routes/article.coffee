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
* find articles in the designate page from the specific tag
* if tag is none means that find all articles
* render with articles
* @param tag: the tag to specify the finding region
* @param page: the index of the page to be response to articles(one page equals 10 articles)
###
router.get '/', (req, res)->
    { tag, page } = req.query
    page = parseInt page
    if tag isnt 'Front-end' and tag isnt 'Back-end' and tag isnt 'Software_Design' and tag isnt 'Software_Engineering' and tag isnt 'Database' and tag isnt 'Other' and tag isnt ''
        return res.json { result: 'fail', msg: 'Invalid tags.' }
    if typeof(page) isnt "number"
        return res.json { result: 'fail', msg: 'Invalid page.' }
    ArticleModel.find { tags: new RegExp(tag) }, null, { sort: ['_id': -1] }, (err, articles)->
        if err
            return res.status(500).send 'Server Error.'
        else
            numbersOfArticles = articles.length
            pages = Math.ceil numbersOfArticles / 10
            pages = pages is 0 ? 1 : pages
            if page > pages
                return res.json { result: 'fail', msg: 'Invalid page.' }
            else
                articlesInAPage = []
                pageIndex = (page - 1) * 10
                while pageIndex < page * 10
                    if pageIndex < numbersOfArticles
                        articlesInAPage.push articles[pageIndex]
                    pageIndex++
                res.render 'article', articles: articlesInAPage, pages: pages

###
* render 'childArticle' when get '/article/create'
###
router.get '/create', requireLogin, (req, res)->
    res.render 'createArticle'

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
                    res.render 'childArticle', article: article
                else
                    async.each comments, (comment, callback)->
                        MessageModel.find { replyTo: comment._id, type: 'reply' }, (err, replys)->
                            if not replys
                                callback()
                            else
                                comment.replys = replys
                                callback()
                    , (err)->
                        res.render 'childArticle', { article: article, comments: comments }

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
    { category, title, content, tags } = req.body
    createdBy = req.session.user.username
    ArticleModel.findOne { title }, (err, article)->
        if article
            return res.json { result: 'fail', msg: 'Article has already existed.' }
        else if not title or not content or not createdBy
            return res.json { result: 'fail', msg: 'Info not completed.' }
        else
            tagsString = ""
            for tag in tags
                if tag isnt 'Front-end' and tag isnt 'Back-end' and tag isnt 'Software_Design' and tag isnt 'Software_Engineering' and tag isnt 'Database' and tag isnt 'Other'
                    return res.json { result: 'fail', msg: 'Invalid tags.' }
                else
                    tagsString += tag
            username = req.session.user.username
            ArticleModel.createArticle category, title, content, createdBy, username, tagsString, ->
                res.json { result: 'success' }

###
* handle when post '/article/delete'
* require user's login to continue process
* return fail if invalid article id occurs
* return fail if current user is not the author of the article
* @param articleId: the id of the article to be deleted
###
router.post '/delete', requireLogin, (req, res)->
    { articleId } = req.body
    ArticleModel.findOne { _id: articleId }, (err, article)->
        if err
            return res.status(500).send 'Server Error.'
        else
            if not article
                return res.json { result: 'fail', msg: 'Invalid article id.' }
            else
                if article.createdBy is req.session.user.username
                    ArticleModel.deleteArticle article._id, ->
                        res.json { result: 'success' }
                else
                    return res.json { result: 'fail', msg: 'The article is not created by current user.' }

###
* handle when post '/article/updateContent'
* require user's login to continue process
* return fail if invalid article id occurs
* return fail if current user is not the author of the article
* @param articleId: the id of the article to be updated
* @param content: the content to cover the existed content
###
router.post '/updateContent', requireLogin, (req, res)->
    { articleId, content } = req.body
    ArticleModel.findOne { _id: articleId }, (err, article)->
        if err
            return res.status(500).send 'Server Error.'
        else
            if not article
                return res.json { result: 'fail', msg: 'Invalid article id.' }
            else
                if article.createdBy is req.session.user.username
                    ArticleModel.updateContent article._id, content, ->
                        res.json { result: 'success' }
                else
                    return res.json { result: 'fail', msg: 'The article is not created by current user.' }

module.exports = router

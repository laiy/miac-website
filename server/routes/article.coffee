#	> File Name: article.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 PM07:09:34 CST

express = require 'express'
mongoose = require 'mongoose'
Schema = mongoose.Schema
router = express.Router()
ArticleModel = require '../db/models/article.coffee'
ObjectId = Schema.Types.ObjectId
{requireLogin} = require './helpers/authorization.coffee'

router.get '/', (req, res)->
    ArticleModel.find {}, (err, articles)->
        if err
            return res.status(500).send 'Server Error.'
        else
            console.log articles
            res.render 'article', articles: articles

router.get '/create', requireLogin, (req, res)->
    res.render 'createArticle'

router.get '/:id', (req, res)->
    ArticleModel.findOne {_id: ObjectId(req.params.id)}, (err, article)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'childArticle', article: article

router.post '/create', (req, res)->
    {category, title, content} = req.body
    createdBy = req.session.user.username
    ArticleModel.findOne {title}, (err, article)->
        if article
            res.json {result: 'fail', msg: 'Article has already existed.'}
        else if not title or not content or not createdBy
            res.json {result: 'fail', msg: 'Info not completed.'}
        else
            ArticleModel.createArticle category, title, content, createdBy, ->
                res.json {result: 'success'}

module.exports = router

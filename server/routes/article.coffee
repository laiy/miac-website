#	> File Name: article.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 PM07:09:34 CST

express = require 'express'
router = express.Router()
ArticleModel = require '../db/models/article.coffee'
ObjectId = Schema.Types.ObjectId

router.get '/:id', (req, res)->
    ArticleModel.findOne {_id: ObjectId(req.params.id)}, (err, article)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'childArticle', article=article

router.get '/', (req, res)->
    ArticleModel.find {}, (err, articles)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'article', articles = articles

router.get '/create', (req, res)->
    res.render 'createArticle'

router.post '/create', (req, res)->
    {category, title, content, tags} = req.body


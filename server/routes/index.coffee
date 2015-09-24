#	> File Name: index.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 AM10:44:10 CST

express = require 'express'
router = express.Router()
ArticleModel = require '../db/models/article.coffee'
DiscussionModel = require '../db/models/discuss.coffee'

###
* render 'index' when get '/'
###
router.get '/', (req, res)->
    ArticleModel.findOne {}, (err, article)->
        DiscussionModel.findOne {}, (err, discussion)->
            res.render 'index', article: article, discussion: discussion

###
* redirect '/home' to get '/'
###
router.get '/home', (req, res)->
    res.redirect('/')

module.exports = router

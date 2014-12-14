#	> File Name: works.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Sunday, November 30, 2014 PM02:31:56 CST

express = require 'express'
router = express.Router()

###
* render 'works' when get '/works'
###
router.get '/', (req, res)->
    res.render('works')

module.exports = router

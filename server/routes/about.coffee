#	> File Name: about.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 AM10:57:45 CST

express = require 'express'
router = express.Router()

###
* Render template 'about' when get '/about'
###
router.get '/', (req, res)->
    res.render('about')

module.exports = router

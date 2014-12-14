#	> File Name: index.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 AM10:44:10 CST

express = require 'express'
router = express.Router()

###
* render 'index' when get '/'
###
router.get '/', (req, res)->
    res.render('index')

module.exports = router

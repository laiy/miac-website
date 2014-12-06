#	> File Name: discuss.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, December 06, 2014 AM09:09:54 CST

express = require 'express'
router = express.Router()
{ requireLogin } = require './helpers/authorization.coffee'
DiscussionModel = require '../db/models/discuss.coffee'

router.get '/', (req, res)->
    DiscussionModel.find {}, (err, discussions)->


module.exports = router

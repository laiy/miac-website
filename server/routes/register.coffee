#	> File Name: register.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM02:57:38 CST

express = require 'express'
UserModel = require '../db/models/user.coffee'
router = express.Router()

router.post '/regist', (req, res)->
    {username, password, email} = req.body
    UserModel.findOne {username: username}, (err, user)->
        if user
            return res.json {result: 'fail', msg: 'Username has already existed.'}
        else
            UserModel.createUser username, password, email, ->
                res.json {result: 'success'}

module.exports = router


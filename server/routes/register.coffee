#	> File Name: register.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM02:57:38 CST

express = require 'express'
User = require '../db/models/user.coffee'
router = express.Router()

router.post'/register', (req, res)->
    {username, password, email} = req.body
    User.findOne {username}, (err, user)->
        if user
            return res.json {result: 'Username has already existed.'}
        else
            User.createUser username, password, email, ->
                res.json {result: 'success'}

module.exports = router


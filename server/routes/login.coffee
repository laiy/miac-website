#	> File Name: login.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Friday, November 21, 2014 AM09:19:00 CST

express = require 'express'
router = express.Router()
UserModel = require '../db/models/user.coffee'
util = require '../common/util.coffee'
{requireLogin, checkUserConflict} = require './helpers/authorization.coffee'

router.post '/session', checkUserConflict, (req, res)->
    {username, password} = req.body
    UserModel.findOne {username}, (err, user)->
        if err
            return res.status(500).send 'Server Error.'
        if not user
            return res.status(404).json {result: 'fail', msg: 'User is not found.'}
        if user.password isnt util.encrypt password
            return res.status(400).json {result: 'fail', msg: 'Password is not correct.'}
        req.session.isAdmin = user.isAdmin
        req.session.user = user.toJSON()
        res.json {result: 'success'}

router.delete '/session', requireLogin, (req,res)->
    req.session.destroy()
    res.json {result: 'success'}

module.exports = router

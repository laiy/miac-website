#	> File Name: log.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Friday, November 21, 2014 AM09:19:00 CST

express = require 'express'
router = express.Router()
UserModel = require '../db/models/user.coffee'
util = require '../common/util.coffee'
{requireLogin, checkUserConflict} = require './helpers/authorization.coffee'

###
* handle when post '/log/session'
* find a user with username
* return fail when no user named username
* return fail when bad params occurs
* return fail when password is not correct
* set user's session to memorize user's status
* @param username: user's name to authorize(one and only)
* @param password: password of the user
###
router.post '/session', checkUserConflict, (req, res)->
    {username, password} = req.body
    UserModel.findOne {username}, (err, user)->
        if err
            return res.status(500).send 'Server Error.'
        else if username is '' or password is ''
            return res.json {result: 'fail', msg: 'Info not complete.'}
        if not user
            return res.status(404).json {result: 'fail', msg: 'User is not found.'}
        if user.password isnt util.encrypt password
            return res.status(400).json {result: 'fail', msg: 'Password is not correct.'}
        req.session.status = user.status
        req.session.user = user.toJSON()
        res.json {result: 'success'}

###
* handle when delete '/log/session'
* destroy user's session and return success
###
router.delete '/session', requireLogin, (req,res)->
    req.session.destroy()
    res.json {result: 'success'}

###
* render 'login' when get '/log'
###
router.get '/', (req, res)->
    res.render 'login'

module.exports = router


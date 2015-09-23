#	> File Name: register.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM02:57:38 CST

express = require 'express'
gm = require 'gm'
UserModel = require '../db/models/user.coffee'
imageMagick = gm.subClass { imageMagick: true }
router = express.Router()
util = require '../common/util.coffee'

###
* handle when post '/register/regist'
* return fail when the username has already existed
* return fail when bad params occur
* create a new user with username, password and email
* create avatar named user._id + '.png'
* @param username: user's name(one and only)
* @param password: user's password
* @param email: user's email
###
router.post '/regist', (req, res)->
    {username, password, email} = req.body
    UserModel.findOne {username}, (err, user)->
        if user
            return res.json {result: 'fail', msg: 'Username has already existed.'}
        else if username is '' or password is '' or email is ''
            return res.json {result: 'fail', msg: 'Info not complete.'}
        else if password.length < 8
            return res.json {result: 'fail', msg: 'The length of password must be at least 8.'}
        else if not /^([a-zA-Z0-9\u4e00-\u9fa5]+[_|\_|\.-]?)*[a-zA-Z0-9\u4e00-\u9fa5]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/.test(email)
            return res.json {result: 'fail', msg: 'The form of email is invalid.'}
        else
            UserModel.createUser username, password, email, ->
                UserModel.findOne { username: username, password: util.encrypt(password) }, (err, user)->
                    if err or not user
                        return res.status(500).send 'Server Error.'
                    user.avatar = user._id + '.png';
                    user.save ->
                        imageMagick('views/assets/img/user/default.jpg')
                            .write 'views/assets/img/user/' + user.avatar, (err)->
                                req.session.status = user.status
                                req.session.user = user.toJSON()
                                res.json {result: 'success'}

###
* render 'register' when get '/register'
###
router.get '/', (req, res)->
    res.render 'register'

module.exports = router


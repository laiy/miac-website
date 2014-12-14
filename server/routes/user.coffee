#	> File Name: user.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Sunday, December 07, 2014 AM09:33:38 CST

express = require 'express'
gm = require 'gm'
fs = require 'fs'
mongoose = require 'mongoose'
imageMagick = gm.subClass { imageMagick: true }
router = express.Router()
{ requireLogin } = require './helpers/authorization.coffee'
UserModel = require '../db/models/user.coffee'
util = require '../common/util.coffee'

###
* render 'userInfo' when get '/user/:id'
* find a user with id
* return fail when user not existed
* render with user
* @param id: the ObjectId of the specific user
###
router.get '/:id', requireLogin, (req, res)->
    id = mongoose.Types.ObjectId req.params.id
    UserModel.findOne { _id: id }, (err, user)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'userInfo', user: user

###
* handle when post '/user/updateEmail'
* return fail when bad param occurs
* update email of user with userId(get from user's session) and email
* @param email: the new email that user would like to update
###
router.post '/updateEmail', requireLogin, (req, res)->
    { email } = req.body
    userId = req.session.user._id
    if not /^([a-zA-Z0-9\u4e00-\u9fa5]+[_|\_|\.-]?)*[a-zA-Z0-9\u4e00-\u9fa5]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/.test(email)
        return res.json { result: 'fail', msg: 'Invalid email form.' }
    else if not email or not userId
        return res.json { result: 'fail', msg: 'Info not completed.' }
    else
        UserModel.updateEmail email, userId, ->
            return res.json { result: 'success' }

###
* handle when post '/user/updatePassword'
* return fail when bad param occurs
* update password of user with userId(get from user's session) and password
* @param password: the new password that user would like to update
###
router.post '/updatePassword', requireLogin, (req, res)->
    { password } = req.body
    userId = req.session.user._id
    password = util.encrypt password
    if not password or not userId
        return res.json { result: 'fail', msg: 'Info not completed.' }
    else if password.length < 8
        return res.json { result: 'fali', msg: 'The length of password should be at least 8.' }
    else
        UserModel.updatePassword password, userId, ->
            return res.json { result: 'success' }

###
* handle when post '/user/uploadAvatar'
* if file is not image return fail
* resize image and write to server's local directory named by user's name
* update avatar of user in UserModel and return success
* @param req.filse.img: the image to replace the user's avatar
###
router.post '/uploadAvatar', requireLogin, (req, res)->
    if not req.files.img
        return res.status(500).send 'Server Error.'
    else
        path = req.files.img.path
        size = req.files.img.size
        items = req.files.img.name.split '.'
        fileName = req.session.user._id + '.' + items[items.length - 1]
        if req.files.img.mimetype.split('/')[0] isnt 'image'
            fs.unlink path, ->
                res.json { result: 'fail', msg: 'Not a image!' }
        else
            imageMagick(path)
                .resize 70, 70, '!'
                .autoOrient()
                .write 'views/assets/img/user/' + fileName, (err)->
                    if err
                        return res.status(500).send 'Server Error.'
                    else
                        fs.unlink path, ->
                            UserModel.updateAvatar fileName, req.session.user._id, ->
                                res.redirect '/user/' + req.session.user._id

module.exports = router


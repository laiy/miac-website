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

router.get '/:id', requireLogin, (req, res)->
    id = mongoose.Types.ObjectId req.params.id
    UserModel.findOne { _id: id }, (err, user)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'userInfo', user: user

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

router.post '/updatePassword', requireLogin, (req, res)->
    { password } = req.body
    userId = req.session.user._id
    password = util.encrypt password
    if not password or not userId
        return res.json { result: 'fail', msg: 'Info not completed.' }
    else
        UserModel.updatePassword password, userId, ->
            return res.json { result: 'success' }

router.post '/uploadHeadPortrait', requireLogin, (req, res)->
    path = req.files.img.path
    size = req.files.img.size
    items = req.files.img.name.split '.'
    #req.files.img.name = req.session.user._id + '.' + items[items.length - 1]
    if req.files.img.type.split('/')[0] isnt 'image'
        fs.unlink path, ->
            res.json { result: 'fail', msg: 'Not a image!' }
    else
        imageMagick(path)
            .resize 90, 90, '!'
            .autoOrient()
            .write 'views/assets/img/user/' + req.session.user._id + '.' + items[items.length - 1], (err)->
                if err
                    return res.status(500).send 'Server Error.'
                else
                    fs.unlink path, ->
                        return res.json { result: 'success' }

module.exports = router


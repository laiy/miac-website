#	> File Name: discuss.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, December 04, 2014 PM02:11:09 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

DiscussionSchema = new Schema
    type: String
    title: String
    content: String
    up: Number
    down: Number
    viewsCount: Number
    createdBy: ObjectId
    createdAt: { type: Date, default: Date.now }
    votedUsers: []
    answerTo: ObjectId

DiscussionModel = mongoose.model 'DiscussionModel', DiscussionSchema

DiscussionModel.createDiscussion = (type, title, content, createdBy, answerTo, callback)->
    DiscussionModel.create {
        type: type
        title: title
        content: content
        up: 0
        down: 0
        viewsCount: 0
        createdBy: createdBy
        answerTo: answerTo if answerTo isnt ''
    }, (err)->
        if err
            console.log err
        else
            DiscussionModel.find {}, (err, discussions)->
                console.log discussions
                callback()

DiscussionModel.up = (discussionId, createdBy, callback)->
    DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
        if err
            throw err
        else
            discussion.up++
            discussion.votedUsers.push createdBy
            callback()

DiscussionModel.down = (discussionId, createdBy, callback)->
    DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
        if err
            throw err
        else
            discussion.down--
            discussion.votedUsers.push createdBy
            callback()

DiscussionModel.addViewsCount = (discussionId, callback)->
    DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
        if err
            throw err
        else
            discussion.viewsCount++
            callback()

DiscussionModel.drop = (callback)->
    DiscussionModel.remove {}, ->
        callback()

module.exports = DiscussionModel

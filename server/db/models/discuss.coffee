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
    votedUsers: [ObjectId]

DiscussionModel = mongoose.model 'DiscussionModel', DiscussionSchema

DiscussionModel.createDiscussion = (type, title, content, createdBy, callback)->
    callback = callback or ->
    DiscussionModel.create {
        type: type
        title: title
        content: content
        up: 0
        down: 0
        viewsCount: 0
        createdBy: createdBy
    }, callback

DiscussionModel.drop = (callback)->
    DiscussionModel.remove {}, ->
        callback()

module.exports = DiscussionModel

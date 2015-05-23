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
    answerTo: ObjectId
    userVoteForUp: [ObjectId]
    avatar: { type: String, default: 'default.jpg' }
    username: String

DiscussionModel = mongoose.model 'DiscussionModel', DiscussionSchema

###
* create a discussion in DiscussionModel with type, title, content, user's id and answerTo
* @param type: discussion's type
* @param title: discussion's title
* @param content: discussion's content
* @param createdBy: user's id, to memorize who create the discussion
* @param answerTo: the discussion's id that the answer reply to if this is a answer, else answerTo is '
* @param callback: the callback function that would execute when function ended
###
DiscussionModel.createDiscussion = (type, title, content, createdBy, answerTo, avatar, username, callback)->
    DiscussionModel.create
        type: type
        title: title if title isnt ''
        content: content
        up: 0
        down: 0
        viewsCount: 0
        createdBy: createdBy
        answerTo: answerTo if answerTo isnt ''
        avatar: avatar
        username: username
    , (err)->
        if err
            console.log err
        else
            callback()

###
* find a discussion with discussionId
* add 1 to up and save
* @param discussionId: the id of the discussion to add up
* @param createdBy: the user's id to memorize who votes for it
* @param callback: the callback function that would execute when function ended
###
DiscussionModel.up = (discussionId, createdBy, callback)->
    DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
        if err
            console.log err
        else
            discussion.up++
            discussion.votedUsers.push createdBy
            discussion.userVoteForUp.push createdBy
            discussion.save ->
                callback()

###
* find a discussion with discussionId
* add 1 to down and save
* @param discussionId: the id of the discussion to add down
* @param createdBy: the user's id to memorize who votes for it
* @param callback: the callback function that would execute when function ended
###
DiscussionModel.down = (discussionId, createdBy, callback)->
    DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
        if err
            console.log err
        else
            discussion.down++
            discussion.votedUsers.push createdBy
            discussion.save ->
                callback()

###
* remove user's vote
* @param removeUp: it is a boolean, whether removeUp, or remove down
* @param discussionId: the id of the discussion to remove vote
* @param createdBy: the user's id to memorize who is removing vote
* @param callback: the callback function that would execute when function ended
###
DiscussionModel.removeVote = (removeUp, discussionId, createdBy, callback)->
    DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
        if err
            console.log err
        else
            index = 0
            while index < discussion.votedUsers.length
                if discussion.votedUsers[index].toString() is createdBy
                    discussion.votedUsers.splice(index, 1)
                    break
                index++
            if removeUp
                index = 0
                while index < discussion.userVoteForUp.length
                    if discussion.userVoteForUp[index].toString() is createdBy
                        discussion.userVoteForUp.splice(index, 1)
                        break
                    index++
                discussion.up--
            else
                discussion.down--
            discussion.save ->
                callback()

###
* find a discussion by discussionId
* add 1 to viewsCount
* @param: discussionId: the id of the discussion to add views' count
* @param callback: the callback function that would execute when function ended
###
DiscussionModel.addViewsCount = (discussionId, callback)->
    DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
        if err
            console.log err
        else
            discussion.viewsCount++
            discussion.save ->
                callback()

###
* drop all the discussions in DiscussionModel
* @param callback: the callback function that would execute when function ended
###
DiscussionModel.drop = (callback)->
    DiscussionModel.remove {}, ->
        callback()

###
* delete discussion by ObjectId
* @param discussionId: the id fo the discussion to be deleted
* @param callback: the callback function that would execute when function ended
###
DiscussionModel.deleteDiscussion = (discussionId, callback)->
    DiscussionModel.remove { _id: discussionId }, ->
        callback()

module.exports = DiscussionModel

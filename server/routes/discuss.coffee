#	> File Name: discuss.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, December 06, 2014 AM09:09:54 CST

express = require 'express'
mongoose = require 'mongoose'
async = require 'async'
router = express.Router()
{ requireLogin } = require './helpers/authorization.coffee'
DiscussionModel = require '../db/models/discuss.coffee'
MessageModel = require '../db/models/message.coffee'

###
* render 'discuss' when get '/discuss'
* find all the discussions in DiscussionModel
* render with discussions
###
router.get '/', (req, res)->
    DiscussionModel.find { type: 'question' }, (err, discussions)->
        if err
            return res.status(500).send 'Server Error.'
        else
            res.render 'discuss', discussions: discussions

###
* render 'createDiscuss' when get '/discuss/create'
* require user's login to continue process
###
router.get '/create', requireLogin, (req, res)->
    res.render 'createDiscuss'

###
* handle when post '/discuss/create'
* require user's login to continue process
* return fail when params is not completed
* return fail when some bad params occur
* create a discussion in DiscussionModel with type, title, content, user's id and answerTo
* @param type: discussion's type
* @param title: discussion's title
* @param content: discussion's content
* @param answerTo: the discussion id which is answered(if this is a answer, or answerTo is just '')
###
router.post '/create', requireLogin, (req, res)->
    { type, title, content, answerTo } = req.body
    createdBy = req.session.user._id
    if not title and type is 'question' or not type or not content
        return res.json { result: 'fail', msg: 'Info not completed.' }
    else if type isnt 'question' and type isnt 'answer'
        return res.json { result: 'fail', msg: 'Bad type.' }
    else if not /^(?=[a-f\d]{24}$)(\d+[a-f]|[a-f]+\d)/i.test(answerTo) and answerTo isnt ''
        return res.json { result: 'fail', msg: 'Bad ObjectId.' }
    else
        avatar = req.session.user.avatar
        DiscussionModel.createDiscussion type, title, content, createdBy, answerTo, avatar, ->
            res.json { result: 'success' }

###
* render 'childDiscuss' when get '/discuss/:id'
* find a discussion with discussion's id
* find answers for this discussion with discussion's id
* find replys for each answer with answer's id
* render with discussion and answers(containing replys)
* @param id: the ObjectId of the specific discussion
###
router.get '/:id', (req, res)->
    id = mongoose.Types.ObjectId req.params.id
    DiscussionModel.addViewsCount id, ->
        DiscussionModel.findOne { _id: id }, (err, discussion)->
            if err
                return res.status(500).send 'Server Error.'
            else
                DiscussionModel.find { answerTo: id, type: 'answer' }, (err, answers)->
                    if not answers
                        res.render 'childDiscuss', discussion: discussion
                    else
                        async.each answers, (answer, callback)->
                            MessageModel.find { replyTo: answer._id, type: 'reply' }, (err, replys)->
                                if not replys
                                    callback()
                                else
                                    answer.replys = replys
                                    callback()
                        , (err)->
                            res.render 'childDiscuss', { discussion: discussion, answers: answers}

###
* handle when post '/discuss/up'
* require user's login to continue process
* return fail when bad param occurs
* find a discussion with discussion's id
* if user has already voted for this discussion(down) then return fail
* if user has already voted for this discussion(up) then remove vote for up
* if user hasn't voted yet then vote for up
* all execution would use DiscussionModel's function removeVote or up to save data
* @param discussionId: the ObjectId of the discussion that user want to vote for up
###
router.post '/up', requireLogin, (req, res)->
    { discussionId } = req.body
    discussionId = mongoose.Types.ObjectId(discussionId)
    createdBy = req.session.user._id
    if not /^(?=[a-f\d]{24}$)(\d+[a-f]|[a-f]+\d)/i.test(discussionId)
        return res.json { result: 'fail', msg: 'Bad ObjectId.' }
    else
        DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
            hasVoted = false
            removeVote = false
            for user in discussion.votedUsers
                if user.toString() is createdBy
                    hasVoted = true
            if hasVoted
                for user in discussion.userVoteForUp
                    if user.toString() is createdBy
                        removeVote = true
            if removeVote and hasVoted
                DiscussionModel.removeVote true, discussionId, createdBy, ->
                    return res.json { result: 'success' }
            else if not hasVoted
                DiscussionModel.up discussionId, createdBy, ->
                    return res.json { result: 'success' }
            else
                return res.json { result: 'fail', msg: 'Bad removing.' }

###
* handle when post '/discuss/down'
* require user's login to continue process
* return fail when bad param occurs
* find a discussion with discussion's id
* if user has already voted for this discussion(up) then return fail
* if user has already voted for this discussion(down) then remove vote for down
* if user hasn't voted yet then vote for down
* all execution would use DiscussionModel's function removeVote or down to save data
* @param discussionId: the ObjectId of the discussion that user want to vote for down
###
router.post '/down', requireLogin, (req, res)->
    { discussionId } = req.body
    discussionId = mongoose.Types.ObjectId(discussionId)
    createdBy = req.session.user._id
    if not /^(?=[a-f\d]{24}$)(\d+[a-f]|[a-f]+\d)/i.test(discussionId)
        return res.json { result: 'fail', msg: 'Bad ObjectId.' }
    else
        DiscussionModel.findOne { _id: discussionId }, (err, discussion)->
            hasVoted = false
            removeVote = true
            for user in discussion.votedUsers
                if user.toString() is createdBy
                    hasVoted = true
            if hasVoted
                for user in discussion.userVoteForUp
                    if user.toString() is createdBy
                        removeVote = false
            if removeVote and hasVoted
                DiscussionModel.removeVote false, discussionId, createdBy, ->
                    return res.json { result: 'success' }
            else if not hasVoted
                DiscussionModel.down discussionId, createdBy, ->
                    return res.json { result: 'success' }
            else
                return res.json { result: 'fail', msg: 'Bad removing.' }

module.exports = router

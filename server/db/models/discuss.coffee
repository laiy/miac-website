#	> File Name: discuss.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, December 04, 2014 PM02:11:09 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

DiscussSchema = new Schema
    type: String
    title: String
    content: String
    up: Number
    down: Number
    viewsCount: Number
    createdBy: ObjectId
    createdAt: { type: Date, default: Date.now }

DiscussModel = mongoose.model 'DiscussModel', DiscussSchema

module.exports = DiscussModel

#	> File Name: article.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 AM11:11:15 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema

ArticleSchema = new Schema
    category: String
    title: String
    content: String
    createdBy: String
    createdAt: { type: Date, default: Date.now }

ArticleModel = mongoose.model 'ArticleModel', ArticleSchema

ArticleModel.createArticle = (category, title, content, createdBy, callback)->
    callback = callback or ->
    ArticleModel.create
        category: category
        title: title
        content: content
        createdBy: createdBy
    , callback

ArticleModel.drop = (callback)->
    ArticleModel.remove {}, ->
        callback()

module.exports = ArticleModel

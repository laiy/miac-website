#	> File Name: article.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 AM11:11:15 CST

mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

ArticleSchema = new Schema
    category: String
    title: String
    content: String
    createdBy: String #username
    createdAt: {type: Date, default: Date.now()}
    tags: [String]

ArticleModel = mongoose.model 'ArticleModel', ArticleSchema

ArticleModel.createArticle = (callback)->
    callback = callback or ->
    ArticleModel.create {
        category: category
        title: title
        content: content
        createdBy: createdBy
        createdAt: createdAt
        tags: tags
    }, callback

module.exports = ArticleModel

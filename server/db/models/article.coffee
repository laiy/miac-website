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

###
* create a article in ArticleModel with category, title, content and user's id and cover
* @param category: article's category
* @param title: article's title
* @param content: article's content
* @param createdBy: user's id, to memorize who create the article
* @param callback: the callback function that would execute when function ended
###
ArticleModel.createArticle = (category, title, content, createdBy, callback)->
    callback = callback or ->
    ArticleModel.create
        category: category
        title: title
        content: content
        createdBy: createdBy
    , callback

###
* drop all the articles in ArticleModel
* @param callback: the callback function that would execute when function ended
###
ArticleModel.drop = (callback)->
    ArticleModel.remove {}, ->
        callback()

module.exports = ArticleModel

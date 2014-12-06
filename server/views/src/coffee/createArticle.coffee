#	> File Name: createArticle.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 PM09:01:15 CST

$('button').click ->
    category = $('#category').val()
    title = $('#title').val()
    content = $('#content').val()
    $.post '/article/create', { category: category, title: title, content: content }, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            $(location).attr 'href', '/article'

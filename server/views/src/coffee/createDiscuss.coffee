#	> File Name: createDiscuss.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, December 06, 2014 AM10:31:24 CST

$('button').click ->
    title = $('#title').val()
    content = $('#content').val()
    $.post '/Discuss/create', { type: 'question', title: title, content: content, answerTo: '' }, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            $(location).attr 'href', '/Discuss'

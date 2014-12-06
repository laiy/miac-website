#	> File Name: childDiscuss.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, December 06, 2014 AM10:31:04 CST

$('#answer-submit').click ->
    content = $('#content').val()
    items = window.location.href.split '/'
    answerTo = items[items.length - 1]
    $.post '/discuss/create', { type: 'answer', title: '', content: content, answerTo: answerTo }, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            window.location.reload()

$('.reply-submit').click ->
    content = $(@).siblings('input').val()
    ObjectId = $(@).attr 'answer-id'
    alert content
    alert ObjectId
    $.post '/message/create', { replyTo: ObjectId, type: 'reply', content: content}, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            window.location.reload()

$('.up').click ->
    discussionId = $(@).attr('discussion-id')
    $.post '/discuss/up', { discussionId: discussionId }, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            window.location.reload()

$('.down').click ->
    discussionId = $(@).attr('discussion-id')
    $.post '/discuss/down', { discussionId: discussionId }, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            window.location.reload()

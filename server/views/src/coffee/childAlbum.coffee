#	> File Name: childAlbum.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, December 11, 2014 PM02:36:54 CST

$('#comment-submit').click ->
    content = $(@).siblings('input').val()
    items = window.location.href.split '/'
    ObjectId = items[items.length - 1]
    $.post '/message/create', { replyTo: ObjectId, type: 'comment', content: content}, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            window.location.reload()

$('.reply-submit').click ->
    content = $(@).siblings('input').val()
    ObjectId = $(@).attr 'comment-id'
    $.post '/message/create', { replyTo: ObjectId, type: 'reply', content: content}, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            window.location.reload()


$(->
    $('.adderButton').click (e)->
        e.preventDefault();
        $('#container').css "display", "block"
);


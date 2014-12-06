#	> File Name: discuss.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, December 06, 2014 PM03:36:38 CST

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


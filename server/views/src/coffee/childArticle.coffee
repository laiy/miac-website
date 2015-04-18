#	> File Name: childArticle.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Saturday, November 29, 2014 PM03:30:06 CST

$(document).ready(
    ->
        $('#comment-submit').click ->
            content = $(@).siblings('textarea').val()
            items = window.location.href.split('/')
            ObjectId = items[items.length - 1]
            alert content
            $.post '/message/create', { replyTo: ObjectId, type: 'comment', content: content}, (data)->
                alert data.result + '\n' + (data.msg if data.msg)
                if data.result is 'success'
                    window.location.reload()    

        $('.reply-submit').click ->
            content = $(@).siblings('input').val()
            ObjectId = $(@).parent('div').attr('name')
            alert(content)
            $.post '/message/create', { replyTo: ObjectId, type: 'reply', content: content}, (data)->
                alert data.result + '\n' + (data.msg if data.msg)
                if data.result is 'success'
                    window.location.reload()

)
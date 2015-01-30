#	> File Name: userInfo.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Sunday, December 07, 2014 PM12:21:39 CST

$('.password-update').click ->
    password = $(@).siblings('input').val()
    $.post '/User/updatePassword', { password: password }, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            window.location.reload()

$('.email-update').click ->
    email = $(@).siblings('input').val()
    $.post '/User/updateEmail', { email: email }, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            window.location.reload()


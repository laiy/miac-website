#	> File Name: login.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Friday, November 21, 2014 PM04:02:09 CST

$('button').click ->
    username = $('#username').val()
    password = $('#password').val()
    $.ajax
        url: '/Log/session'
        data: {username: username, password:password}
        type: 'post'
        error: (XMLHttpRequest)->
            alert XMLHttpRequest.status + ' ' + XMLHttpRequest.statusText
        success: (data)->
            alert data.result + '\n' + (data.msg if data.msg)
            if data.result is 'success'
                $(location).attr 'href', '/'



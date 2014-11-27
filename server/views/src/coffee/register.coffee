#	> File Name: register.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Friday, November 21, 2014 PM04:01:50 CST

$('button').click ->
    username = $('#username').val()
    password = $('#password').val()
    email = $('#email').val()
    $.post '/register/regist', {username: username, password: password, email: email}, (data)->
        alert data.result + '\n' + (data.msg if data.msg)
        if data.result is 'success'
            $(location).attr 'href', '/'


#	> File Name: header.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 AM10:15:11 CST

$('#logout').click ->
    $.ajax
        url: '/log/session'
        type: 'delete'
        success: (data)->
            alert data.result + '\n' + data.msg
            if data.result is 'success'
                $(location).attr 'href', '/'

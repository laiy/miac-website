#	> File Name: header.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 AM10:15:11 CST

now_arrow = 0

init = ->
    switch window.location.pathname
        when '/'
            arrow_move 0
        when '/article'
            arrow_move 1
        when '/share' 
            arrow_move 2
        when '/discuss'
           arrow_move 3
        when '/album'
            arrow_move 4
        when '/work'
            arrow_move 5
        when '/about'
            arrow_move 6

check = ->
    for index in $('.link')
        if index == $('.link')[now_arrow]
            $(index).removeClass("dark")
            $(index).addClass("light")
        else
            $(index).removeClass("light")
            $(index).addClass("dark")


arrow_move = (num)->
    now_arrow = num
    $('.triangle').css "left", (num * 93 + 37) + "px"
    check()

init()

$('#logout').click ->
    $.ajax
        url: '/log/session'
        type: 'delete'
        success: (data)->
            alert data.result + '\n' + (data.msg if data.msg)
            if data.result is 'success'
                $(location).attr 'href', '/'

$('.link').mouseover (event)->
    target = $ event.currentTarget
    arrow_move target.attr "data-num"
 
$('#links').mouseout init
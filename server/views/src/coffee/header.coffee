#	> File Name: header.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 27, 2014 AM10:15:11 CST

$ ->

    ###
    * when button 'Sign out' is clicked, AJAX to back-front to delete session and reload home page
    ###
    $('#logout').click ->
        $.ajax
            url: '/Log/session'
            type: 'delete'
            success: (data)->
                alert data.result + '\n' + (data.msg if data.msg)
                if data.result is 'success'
                    $(location).attr 'href', '/'

    ###
    * handle the logic of header-pointer's animation
    ###
    class Pointer

        ###
        * init datastructure along with event handler
        * @param $navigators: nav elements in DOM
        * @param destinations: record the destinations for pointer to go
        * @param $pointer: pointer element in DOM
        ###
        constructor: (@$navigators = $('div#header-nav a'),
        @destinations = [
            '162px',
            '245px',
            '340px',
            '433px',
            '525px',
            '613px'
        ], @$pointer = $('div#header-pointer'))->
            @add_event_handler()

        ###
        * add event 'onmouseover' to each navigator
        ###
        add_event_handler: ()->
            that = @
            for navigator, i in @$navigators
                navigator.onmouseover = do(i)->
                    ->
                        that.$pointer.css('left', that.destinations[i])

    pointer = new Pointer


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
                if data.result is 'success'
                    $(location).attr 'href', '/'
                else
                    alert 'fail!'

    ###
    * handle the logic of header-pointer's animation
    ###
    class Pointer_Animation_Handler
        ###
        * init datastructure along with event handler
        * @param $navigators: nav elements in DOM
        * @param destinations: record the destinations for pointer to go
        * @param $pointer: pointer element in DOM
        * @param $wrapper: the header wrapper in DOM
        ###
        constructor: (
            @$navigators = $('div#header-nav a'),
            @destinations = [],
            @$pointer = $('div#header-pointer'),
            @$wrapper = $('div#header-wrapper')
        )->
            @add_event_handler()

        ###
        * add event 'onmouseover' to each navigator
        ###
        add_event_handler: ()->
            that = @
            for navigator, i in @$navigators
                @destinations[i] = (navigator.offsetLeft - @$wrapper.offset().left + 50) + "px"
                navigator.onmouseover = do(i)->
                    ->
                        that.$pointer.css('left', that.destinations[i])

    pointer_animation_handler = new Pointer_Animation_Handler


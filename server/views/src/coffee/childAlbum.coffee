#	> File Name: childAlbum.coffee
#	> Author: William.D.King
#	> Mail: williamjwking@gmail.com

window.onload = ()->
    pictures = $(".picture")
    ($ '#player').modal({
        keyboard: true
        show: false
    })
    ($ '#player').modal('hide')
    # $('#screen').addClass("hidden")
    ($ '#screen').css 'width', $(window).width() * 0.9
    ($ '#screen').css 'height', $(window).height() * 0.9
    pictures.click (e)->
        url = $(e.currentTarget.firstChild).attr("src")
        $("#screen").find("#image").find("img").attr("src", url)
        ($ '#player').modal 'show'
        # $("#screen").addClass("appear")
        # $("#screen").removeClass("hidden")

        # ($ '#screen').css 'display', 'block'
        # ($ '#screen').css 'width', '600px'
        # ($ '#screen').css 'height', '600px'


    length = pictures.length
    $("#p-1").addClass("active")
    $('#pic-content').find($('.loop')).find('.prev').attr("href", "#" + length)
    if (length > 1)
        $('#pic-content').find($('.loop')).find('.next').attr("href", "#" + 2)
    else 
        $('#pic-content').find($('.loop')).find('.next').attr("href", "#" + 1)
    if length > 0
        for i in [0..(length - 1) / 12]
            page = $("<div></div>").attr("id", i + 1).attr("name", i + 1)
            for j in [0..2]
                row = $("<div></div>").attr "class", "pic-row"
                for k in [0..3]
                    if pictures[i * 12 + j * 4 + k]
                        row.append(pictures[i * 12 + j * 4 + k])
                    else
                        newBlock = $("<div class='picture'></div>").append($("<img></img>"))
                        row.append(newBlock)
                page.append row
            $("#pic-content").append page

    $("#close").click (e)->
        e.preventDefault()
        $("#container").css("display", block)

    $('.adderButton').click (e)->
        e.preventDefault()
        $('#container').css "display", "inline-block"

    $('#light').click (e)->
        e.preventDefault()
        # $('#screen').css 'height', '0'
        # $('#screen').css 'width', '0'
        # $('#screen').removeClass("appear")
        # $('#screen').addClass("hidden")
        ($ '#player').modal('hide')

    $('#screen').find('.prev').click (e)->
        url = $("#screen").find("img").attr("src")
        num = 0
        for picture in pictures
            if $(picture).find("img").attr("src") == url
                break
            ++num
        if (num > 0)
            newUrl = $(pictures[num - 1]).find("img").attr("src")
            $("#screen").find("img").attr("src", newUrl)

    $('#screen').find('.next').click (e)->
        url = $("#screen").find("img").attr("src")
        num = 0
        for picture in pictures
            if $(picture).find("img").attr("src") == url
                break
            ++num
        if (num < pictures.length - 1)
            newUrl = $(pictures[num + 1]).find("img").attr("src")
            $("#screen").find("img").attr("src", newUrl)

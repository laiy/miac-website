#	> File Name: childAlbum.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, December 11, 2014 PM02:36:54 CST

window.onload = ()->
    pictures = $(".picture") 
    pictures.click (e)->
        url = $(e.currentTarget.firstChild).attr("src")
        $("#screen").find("#image").find("img").attr("src", url)
        $("#screen").css("display", "block")
    length = pictures.length
    $("#p-1").addClass("active")
    $('.loop').find('.prev').attr("href", "#" + length)
    if (length > 1)
        $('.loop').find('.next').attr("href", "#" + 2)
    else 
        $('.loop').find('.next').attr("href", "#" + 1)
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
        $("#container").css "display", "none"

    $('.adderButton').click (e)->
        e.preventDefault()
        $('#container').css "display", "inline-block"



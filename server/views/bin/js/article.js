$(function() {
    //change to string
    String.prototype.stripHTML = function() {  
        var reTag = /<(?:.|\s)*?>/g;
        return this.replace(reTag,"");  
    }
    //remove the whitespace of the left of the text
    String.prototype.trim = function() {
        return this.replace(/(^\s*)/g,'');
    } 


    function cutstr(str) {
        var n = str.length;
        var ss = "";
        var spaceNum = 4;
        var startPos = 0;
        for (var i = startPos; i < startPos+28;) {
            if (str.substring(i, i+6) == "&nbsp;") {
                i = i + 7;
                spaceNum--;
            }
            else break;
        }
        while(spaceNum--) {
            ss += "&nbsp;";
        }
        if (n > 190) {
            ss = ss + str.substring(startPos,startPos+190);
            ss = ss + "...";
        } else {
            ss = ss + str;
        }
        return ss;
    }
    $(".content").each(function() {
        var sTest = $(this).html();
        $(this).empty();
        $(this).append(cutstr(sTest.stripHTML().trim()));
        $(this).css("visibility","visible");
        $(this).css("font-size", "14px");
    });

    $(".title a").each(function() {
        var str = this.innerHTML;
        if (str.length > 50) {
            this.innerHTML = str.substring(0,50) + "...";
        }
    });
    
    //Set the link of page button
    var length = $(".page-button").length,
        tag = url('?tag'),
        page = url('?page');
    if (tag == null) tag = '';
    if (page == null) page = "1";
    page = parseInt(page);
    if (page > 1) {
        $('#prev-page').find('a').attr("href", "/Article?page=" + (page - 1) + "&tag=" + tag);
    } else {
        $('#prev-page').find('a').attr("href", "#");
    }
    if (page < length) {
        $('#next-page').find('a').attr("href", "/Article?page=" + (page + 1) + "&tag=" + tag);
    } else {
        $('#next-page').find('a').attr("href", "#");
    }
    $(".page-button").each(function() {
        var num = $(this).find('a').text();
        $(this).find('a').attr("href", "/Article?page=" + num + "&tag=" + tag);
        if (parseInt(num) == page) {
            $(this).addClass('chosen-page');
        } else {
            $(this).removeClass('chosen-page');
        } 
    });

    //Listen to the search event
   $("#search-input").on("input propertychange", function() {
        var key = $(this).val(),
            patt = new RegExp(key);
        $(".article").each(function() {
            var title = $(this).find(".article_content").find(".title").find("a").text();
            if (!patt.test(title)) {
                $(this).addClass("invisible");
            } else {
                $(this).removeClass("invisible");
            } 
        });
    });

});

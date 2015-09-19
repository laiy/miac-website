$(function() {
    String.prototype.stripHTML = function() {  
        var reTag = /<(?:.|\s)*?>/g;  
        return this.replace(reTag,"");  
    }  


    function cutstr(str) {
    	var n = str.length;
		if (n > 200) {
			var str = str.substring(0,200);
			str = str + "...";
		}
		return str;
	}
    $(".content").each(function() {
    	var sTest = $(this).html();
    	$(this).empty();
    	$(this).append(cutstr(sTest.stripHTML()));
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

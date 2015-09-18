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
            $(this).addClass('choosen-page');
        } else {
            $(this).removeClass('choosen-page');
        }
    });

});

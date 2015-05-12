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
});
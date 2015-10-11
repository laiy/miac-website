(function() {
	$(function() {
		function cutstr(str) {
			var strNum = str.length;
			var ss = "";
			if (strNum > 200) {
				ss = ss + str.substring(0,200);
				ss = ss + "...";
			} else {
				return str;
			}
			return ss;
		} 
		$(".content").each(function() {
			var htmlContent = $(this).text();
			htmlContent = htmlContent.replace(/<\/?[^>]*>/g,''); //去除HTML tag
	        htmlContent = htmlContent.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
	        htmlContent = htmlContent.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
	        htmlContent = htmlContent.replace(/ /ig,'');//去掉 
			$(this).empty();
			$(this).append(cutstr(htmlContent));
		});
	});
}).call(this);

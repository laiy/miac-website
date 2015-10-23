$(function() {
	var number = $(".bigList-item").length;
	var lineCurrent = 1;
	var pageLine = Math.ceil(number / 7);
	$(".bigList-item").each(function() {
		var self = $(this);
		$(this).click(function() {
			if (self.css("visibility") == "visible") {
				if (self.css("left") == "0px") {
					toRight(self);
				} else if (self.css("left") == "720px") {
					toLeft(self);
				}
			}
			forClick();
		});
	});
	$(".smallList-item").each(function() {
		var self = $(this);
		$(this).click(function() {
			var imgNext = $(this).find("img").attr("class");
			var imgCurrent = $(".firstItem").length?$(".firstItem").find("img").attr("class"):$(".firstItemDir").find("img").attr("class");
			if (number == 2) {
				if (imgNext > imgCurrent) {
					toLeft($(".bigList-item").eq(1));
				} else if (imgNext < imgCurrent) {
					toRight($(".bigList-item").eq(0));
				}
			} else if (number == 3) {
				if (imgNext > imgCurrent) {
					var now = $("."+imgNext).parent().parent(".bigList-item");
					now.removeClass();
					now.addClass("bigList-item rightItem");
					var prev1 = now.prev().get(0)?now.prev():$(".bigList-item").last();
					prev1.removeClass();
					prev1.addClass("bigList-item firstItem");
					var prev2 = prev1.prev().get(0)?prev1.prev():$(".bigList-item").last();
					prev2.removeClass();
					prev2.addClass("bigList-item leftItem");
					toLeft(now);
				} else if (imgNext < imgCurrent) {
					var now = $("."+imgNext).parent().parent(".bigList-item");
					now.removeClass();
					now.addClass("bigList-item leftItem");
					var prev1 = now.prev().get(0)?now.prev():$(".bigList-item").last();
					prev1.removeClass();
					prev1.addClass("bigList-item firstItem");
					var prev2 = prev1.prev().get(0)?prev1.prev():$(".bigList-item").last();
					prev2.removeClass();
					prev2.addClass("bigList-item rightItem");
					toRight(now);
				}
			} else if (number > 3) {
				if (imgNext != imgCurrent) {
					var b = $("."+imgCurrent).parent().parent(".bigList-item");
					b.removeClass();
					b.addClass("bigList-item normal");
					var a = b.prev().get(0)?b.prev():$(".bigList-item").last();
					a.removeClass();
					a.addClass("bigList-item normal");
					var c = b.next().get(0)?b.next():$(".bigList-item").first();
					c.removeClass();
					c.addClass("bigList-item normal");
					if (imgNext > imgCurrent) {
						var now = $("."+imgNext).parent().parent(".bigList-item");
						now.removeClass();
						now.addClass("bigList-item rightItem");
						var prev1 = now.prev().get(0)?now.prev():$(".bigList-item").last();
						prev1.removeClass();
						prev1.addClass("bigList-item firstItem");
						var prev2 = prev1.prev().get(0)?prev1.prev():$(".bigList-item").last();
						prev2.removeClass();
						prev2.addClass("bigList-item leftItem");
						toLeft(now);
					} else if (imgNext < imgCurrent) {
						var now = $("."+imgNext).parent().parent(".bigList-item");
						now.removeClass();
						now.addClass("bigList-item leftItemDir");
						var next1 = now.next().get(0)?now.next():$(".bigList-item").last();
						next1.removeClass();
						next1.addClass("bigList-item firstItemDir");
						var next2 = next1.next().get(0)?next1.next():$(".bigList-item").last();
						next2.removeClass();
						next2.addClass("bigList-item rightItemDir");
						toRight(now);
					}
				}
			}
		});
	});
	$(".prev").click(function() {
		var smallpic = $("smallList-item");
		var firstItem = $(".first");
		var lastItem = $(".last");
		if (firstItem.prev().get(0)) {
			var self = firstItem.prev();
			for (var i = 0; i < 8; i++) {
				var left = self.next().css("left");
				if (i == 7) left = 787.5;
				self.animate({
					left: left
				}, 1000);
				self = self.next();
			}
			firstItem.prev().addClass("first");
			firstItem.removeClass("first");
			lastItem.prev().addClass("last");
			lastItem.removeClass("last");
		}
	});
	$(".next").click(function() {
		var smallpic = $("smallList-item");
		var firstItem = $(".first");
		var lastItem = $(".last");
		if (lastItem.next().get(0)) {
			var self = firstItem;
			for (var i = 0; i < 8; i++) {
				var left = self.prev().css("left");
				if (i == 0) left = -112.5;
				self.animate({
					left: left
				}, 1000);
				self = self.next();
			}
			firstItem.next().addClass("first");
			firstItem.removeClass("first");
			lastItem.next().addClass("last");
			lastItem.removeClass("last");
		}
	});
	function toRight(self) {
		self.removeClass();
		if (number > 3) {
			self.addClass("bigList-item firstItemDir");
			var prev = self.prev().get(0)?self.prev():$(".bigList-item").last();
			prev.removeClass();
			prev.addClass("bigList-item leftItemDir");
			var next = self.next().get(0)?self.next():$(".bigList-item").first();
			next.removeClass();
			next.addClass("bigList-item rightItemDir");
			var next1 = next.next().get(0)?next.next():$(".bigList-item").first();
			next1.removeClass();
			next1.addClass("bigList-item leaveDir normal");
		} else if (number == 3) {
			self.addClass("bigList-item firstItemDir");
			var prev = self.prev().get(0)?self.prev():$(".bigList-item").last();
			prev.removeClass();
			prev.addClass("bigList-item leftItemDir");
			var next = self.next().get(0)?self.next():$(".bigList-item").first();
			next.removeClass();
			next.addClass("bigList-item rightItemDir");
		} else {
			self.addClass("bigList-item firstItemDir");
			var prev = self.prev().get(0)?self.prev():$(".bigList-item").last();
			prev.removeClass();
			prev.addClass("bigList-item rightItemDir");
		}
	}
	function toLeft(self) {
		self.removeClass();
		if (number > 3) {
			self.addClass("bigList-item firstItem");
			var next = self.next().get(0)?self.next():$(".bigList-item").first();
			next.removeClass();
			next.addClass("bigList-item rightItem");
			var prev = self.prev().get(0)?self.prev():$(".bigList-item").last();
			prev.removeClass();
			prev.addClass("bigList-item leftItem");
			var prev1 = prev.prev().get(0)?prev.prev():$(".bigList-item").last();
			prev1.removeClass();
			prev1.addClass("bigList-item normal leave");
		}
		else if (number == 3) {
			self.addClass("bigList-item firstItem");
			var prev = self.prev().get(0)?self.prev():$(".bigList-item").last();
			prev.removeClass();
			prev.addClass("bigList-item leftItem");
			var next = self.next().get(0)?self.next():$(".bigList-item").first();
			next.removeClass();
			next.addClass("bigList-item rightItem");
		}
		else {
			self.addClass("bigList-item firstItem");
			var prev = self.prev().get(0)?self.prev():$(".bigList-item").last();
			prev.removeClass();
			prev.addClass("bigList-item leftItem");
		}
	}

	function forClick() {
		$(".firstItem").click(function() {
	      var src = $(".firstItem .pic img").attr("src");
	      $(".showPic .center .centerPic img").attr("src", src);
	      $(".showPic").slideDown();
	    });
	    $("#close").click(function() {
	      $(".showPic").slideUp();
	    });
	}
})
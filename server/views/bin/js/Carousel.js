;(function($) {
	var Carousel = function(poster) {
		var self = this;
		this.banner = poster;
		this.bannerItemContainer = poster.find("ul.banner-list");
		this.bannerItems = poster.find("li.banner-item");
		this.pBtn = poster.find(".banner-prev-btn");
		this.nBtn = poster.find(".banner-next-btn");
		this.bannerFirstItem = this.bannerItems.first();
		this.bannerLastItem = this.bannerItems.last();
		this.rotating = false;
		this.setting = {
			"width": 900,
			"height": 300,
			"bannerWidth": 600,
			"bannerHeight": 300,
			"scale":0.9,
			"speed":300
		}
		this.setSetting();
		this.setBannerPos();
		this.pBtn.click(function(){
			if (!self.rotating) {
				self.rotating = true;
				self.carouselRotate("right");
			}
		});
		this.nBtn.click(function(){
			if (!self.rotating) {
				self.rotating = true;
				self.carouselRotate("left");
			}
		});
		this.play();
		poster.hover(function() {
			window.clearInterval(self.timer);
		}, function() {
			self.play();
		});
	}

	Carousel.prototype = {
		setSetting:function() {
			this.banner.css({
				width:this.setting.width,
				height:this.setting.height
			});
			this.banner.css({
				width:this.setting.width,
				height:this.setting.height
			});
			var w = (this.setting.width - this.setting.bannerWidth)/2;
			this.pBtn.css({
				width:w,
				height:this.setting.height,
				zIndex:Math.ceil(this.bannerItems.size()/2)
			});
			this.nBtn.css({
				width:w,
				height:this.setting.height,
				zIndex:Math.ceil(this.bannerItems.size()/2)
			});
			this.bannerFirstItem.css({
				width:this.setting.bannerWidth,
				height:this.setting.bannerHeight,
				zIndex:Math.floor(this.bannerItems.size()/2),
				left:w
			});
		},
		setBannerPos:function() {
			var self = this;
			var leaveBanner = this.bannerItems.slice(1);
			var right = leaveBanner.slice(0, leaveBanner.size()/2),
				levelR = Math.floor(this.bannerItems.size()/2),
				gap = ((this.setting.width - this.setting.bannerWidth)/2)/levelR,
				rw = this.setting.bannerWidth,
				rh = this.setting.bannerHeight,
				firstLeft = (this.setting.width - this.setting.bannerWidth)/2,
				firstOffset = firstLeft + rw;
			right.each(function(i) {
				levelR--;
				rw = rw * self.setting.scale;
				rh = rh * self.setting.scale;
				var j = i;
				$(this).css({
					width: rw,
					height: rh,
					zIndex: levelR,
					opacity: 1/(++i),
					left: firstOffset + gap*(++j) - rw,
					top: (self.setting.bannerHeight - rh)/2
				});
			});
			var left = leaveBanner.slice(leaveBanner.size()/2),
				lw = right.last().width(),
				lh = right.last().height(),
				opacityPara = Math.floor(this.bannerItems.size()/2);
			left.each(function(i) {
				$(this).css({
					width: lw,
					height: lh,
					left: i*gap,
					zIndex: i,
					opacity: 1/opacityPara,
					top: (self.setting.bannerHeight - lh)/2
				});
				lw = lw/self.setting.scale;
				lh = lh/self.setting.scale;
				opacityPara--;
			});
		},
		carouselRotate:function(direction) {
			var self = this;
			if (direction == "left") {
				var zIndexArray = [];
				this.bannerItems.each(function(){
					var prev = $(this).prev().get(0)?$(this).prev():self.bannerLastItem,
						width = prev.width(),
						height = prev.height(),
						zIndex = prev.css("zIndex"),
						opacity = prev.css("opacity"),
						left = prev.css("left"),
						top = prev.css("top");
					zIndexArray.push(zIndex);
					$(this).animate({
						width:width,
						height:height,
						left:left,
						top:top,
						opacity:opacity
					},self.setting.speed,function(){
						self.rotating = false;
					});
				});
				this.bannerItems.each(function(i){
					$(this).css({
						zIndex: zIndexArray[i]
					});
				});
			} else if (direction == "right"){
				var zIndexArray = [];
				this.bannerItems.each(function(){
					var next = $(this).next().get(0)?$(this).next():self.bannerFirstItem,
						width = next.width(),
						height = next.height(),
						zIndex = next.css("zIndex"),
						opacity = next.css("opacity"),
						left = next.css("left"),
						top = next.css("top");
					zIndexArray.push(zIndex);
					$(this).animate({
						width:width,
						height:height,
						opacity:opacity,
						left:left,
						top:top
					},self.setting.speed,function(){
						self.rotating = false;
					});
				});
				this.bannerItems.each(function(i){
					$(this).css({
						zIndex: zIndexArray[i]
					});
				});
			}
		},
		play:function() {
			var self = this;
			this.timer = window.setInterval(function(){
				self.nBtn.click();
			},3000);
		}
	}
	window["Carousel"] = Carousel;

})(jQuery);
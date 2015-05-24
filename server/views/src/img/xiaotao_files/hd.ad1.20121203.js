var hudongAdsTemplate = {
	adDomain : "http://ad1.baike.com",
	options : {},
	getIndex : function(arr, obj) {
		for (var i = 0; i < arr.length; i++) {
			if (arr[i] == obj) {
				return i;
			}
		}
		return -1;
	},
	getScript : function(url) {
		var script = document.createElement("script");
		document.getElementsByTagName("body")[0].appendChild(script);
		script.src = url;
	},
	loadAds : function(adOptions) {
		if (typeof(adOptions) == "undefined" || !adOptions) {
			return;
		}
		var self = this;
		
		self.options = adOptions;
			
		var req = [self.adDomain, "/ad/preloadads?biztype=", self.options.bizType,
				"&locations=", self.options.adLocations.join(","), "&bizid=",
				self.options.bizId, "&callback=hudongAdsTemplate.showAds"];
		self.getScript(req.join(""));
	},
	showAds : function(ads) {
		var self = this;
		if (typeof(ads) == "undefined" || !ads || !(ads instanceof Array)
				|| ads.length == 0) {
			self.removeNoAdBlock(self.options.adLocations);
		}else{
			
			var noAdArr = self.options.adLocations.slice(0);
			$.each(ads, function(i, ad) {
						//给顶部横通1，2，3，正文下方8，9加样式
						if(typeof(ad.needWrapParentNode) != "undefined" && ad.needWrapParentNode){
							var holderId = self.options.adBlockPrefix.concat(ad.needWrapParentNode);
							$("#"+holderId).parent().addClass("bkbg");
							$("#"+holderId).parent().parent().addClass("words_gg");
						}
			
						if (typeof(ad.location) != "undefined" && ad.location) {
							var adindex = self.getIndex(self.options.adLocations,
									ad.location);
							if (adindex != -1) {
								try {
									self.fillAd(ad.location, adindex);
									noAdArr[adindex] = 0;
								} catch (e) {
								}
							}
						}
					});
			if (noAdArr.length > 0) {
				self.removeNoAdBlock(noAdArr);
			}
		}
	},
	
	removeNoAdBlock : function(arr) {
		var self = this;
		$.each(arr, function(i, n) {
					if (n > 0) {
						var holderId = self.options.adBlockPrefix.concat(n);
						var adholder = $("#" + holderId);
						if (adholder && adholder.length > 0) {
							adholder.remove();
						}
					}
				});
	},
	fillAd : function(location, index) {
		var self = this;
		var config = self.options.adConfigs[index];
		if (config.type == "iframe") {
			self.fillAdIframe(location, config);
		} else if (config.type == "script") {
			self.fillAdScript(location, config);
		}

	},
	fillAdIframe : function(location, config) {
		var self = this;
		var holderId = self.options.adBlockPrefix.concat(location);
		var adholder = $("#" + holderId);
		if (adholder && adholder.length > 0) {
			var iframeId = self.options.adIframePrefix.concat(location);
			var iframe = $('<iframe scrolling="no" frameborder="0" marginwidth="0" marginheight="0" height="'
					+ config.height
					+ '"  width="'
					+ config.width
					+ '" id="'
					+ iframeId + '" name="' + iframeId + '"  />');
			if (typeof(config.style) != "undefined" && config.style) {
				iframe.attr("style", config.style);
			}
			var iframeSrc = [self.adDomain, "/ad/fetchad?", "biztype=",
					self.options.bizType, "&bizid=", self.options.bizId,
					"&location=", location, "&iframeid=", iframeId,
					"&adholderid=", holderId, "&dwidth=", config.width,
					"&dheight=", config.height, "&domain=", self.options.domain];
			iframe.attr("src", iframeSrc.join("")).appendTo(adholder);
		}
	},
	fillAdScript : function(location, config) {
		var self = this;
		var req = [self.adDomain, "/ad/fetchad?biztype=", self.options.bizType,
				"&location=", location, "&bizid=", self.options.bizId];
		self.getScript(req.join(""));
	}
};
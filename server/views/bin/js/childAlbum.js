(function() {
  window.onload = function() {
    var i, j, k, length, newBlock, page, pictures, row, _i, _j, _k, _ref;
    pictures = $(".picture");
    ($('#player')).modal({
      keyboard: true,
      show: false
    });
    ($('#player')).modal('hide');
    ($('contain')).modal('hide');
    ($('#screen')).css('width', $(window).width() * 0.9);
    ($('#screen')).css('height', $(window).height() * 0.9);
    ($('.carousel')).carousel({
      interval: 7000
    });
    $(($('.item'))[0]).addClass('active');
    pictures.click(function(e) {
      var i, num, picture, url, _i, _len;
      url = $(e.currentTarget.firstChild).attr("src");
      $("#screen").find("#image").find("img").attr("src", url);
      ($('#player')).modal('show');
      pictures = $('.picture');
      num = 0;
      for (i = _i = 0, _len = pictures.length; _i < _len; i = ++_i) {
        picture = pictures[i];
        if (picture === e.currentTarget) {
          num = i;
        }
      }
      return ($('.carousel')).carousel(num);
    });
    length = pictures.length;
    $("#p-1").addClass("active");
    $('#pic-content').find($('.loop')).find('.prev').attr("href", "#" + length);
    if (length > 1) {
      $('#pic-content').find($('.loop')).find('.next').attr("href", "#" + 2);
    } else {
      $('#pic-content').find($('.loop')).find('.next').attr("href", "#" + 1);
    }
    if (length > 0) {
      for (i = _i = 0, _ref = (length - 1) / 12; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        page = $("<div></div>").attr("id", i + 1).attr("name", i + 1);
        for (j = _j = 0; _j <= 2; j = ++_j) {
          row = $("<div></div>").attr("class", "pic-row");
          for (k = _k = 0; _k <= 3; k = ++_k) {
            if (pictures[i * 12 + j * 4 + k]) {
              row.append(pictures[i * 12 + j * 4 + k]);
            } else {
              newBlock = $("<div class='picture'></div>").append($("<img></img>"));
              row.append(newBlock);
            }
          }
          page.append(row);
        }
        $("#pic-content").append(page);
      }
    }
    $("#close").click(function(e) {
      e.preventDefault();
      return $("#container").css("display", block);
    });
    $('.adderButton').click(function(e) {
      e.preventDefault();
      return $('#container').css("display", "inline-block");
    });
    $('#light').click(function(e) {
      e.preventDefault();
      return ($('#player')).modal('hide');
    });
    $('#screen').find('.prev').click(function(e) {
      var newUrl, num, picture, url, _l, _len;
      url = $("#screen").find("img").attr("src");
      num = 0;
      for (_l = 0, _len = pictures.length; _l < _len; _l++) {
        picture = pictures[_l];
        if ($(picture).find("img").attr("src") === url) {
          break;
        }
        ++num;
      }
      if (num > 0) {
        newUrl = $(pictures[num - 1]).find("img").attr("src");
        return $("#screen").find("img").attr("src", newUrl);
      }
    });
    return $('#screen').find('.next').click(function(e) {
      var newUrl, num, picture, url, _l, _len;
      url = $("#screen").find("img").attr("src");
      num = 0;
      for (_l = 0, _len = pictures.length; _l < _len; _l++) {
        picture = pictures[_l];
        if ($(picture).find("img").attr("src") === url) {
          break;
        }
        ++num;
      }
      if (num < pictures.length - 1) {
        newUrl = $(pictures[num + 1]).find("img").attr("src");
        return $("#screen").find("img").attr("src", newUrl);
      }
    });
  };

}).call(this);

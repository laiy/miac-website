(function() {
  window.onload = function() {
    var i, j, k, length, page, pictures, row, _i, _j, _k, _ref;
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
    if (pictures.length === 0) {
      length = 1;
    } else {
      length = pictures.length;
    }
    $('#pic-content').find($('.loop')).find('.prev').attr("href", "#" + 1);
    if (length > 1) {
      $('#pic-content').find($('.loop')).find('.next').attr("href", "#" + 2);
    } else {
      $('#pic-content').find($('.loop')).find('.next').attr("href", "#" + 1);
    }
    if (length > 0) {
      for (i = _i = 0, _ref = (length - 1) / 12; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        page = $("<div></div>").attr("id", i + 1).attr("name", i + 1).css("display", "none").addClass('page');
        for (j = _j = 0; _j <= 2; j = ++_j) {
          row = $("<div></div>").attr("class", "pic-row");
          for (k = _k = 0; _k <= 3; k = ++_k) {
            if (pictures[i * 12 + j * 4 + k]) {
              row.append(pictures[i * 12 + j * 4 + k]);
            }
          }
          page.append(row);
        }
        $("#pic-content").append(page);
      }
      $("#1").addClass("visible");
    }
    $("#p-1").addClass('active');
    $(".page-nav").click(function(e) {
      var currentPage, href, target, _l, _len, _ref1;
      $(".page-nav").parents().removeClass('active');
      $(e.currentTarget).parents().addClass('active');
      href = $(e.currentTarget).attr("href");
      target = $("" + href)[0];
      _ref1 = $('.page');
      for (_l = 0, _len = _ref1.length; _l < _len; _l++) {
        page = _ref1[_l];
        if (page !== target) {
          $(page).removeClass('visible');
        }
      }
      $(target).addClass('visible');
      currentPage = parseInt(target[1]);
      length = $(".picture").length;
      if (length === 0) {
        length = 1;
      }
      if (currentPage > 1) {
        $('#pic-content').find($('.loop')).find('.prev').attr("href", "#" + (cuurentPage - 1));
      } else {
        $('#pic-content').find($('.loop')).find('.prev').attr("href", "#1");
      }
      if (currentPage < length) {
        return $('#pic-content').find($('.loop')).find('.next').attr("href", "#" + (currentPage + 1));
      } else {
        return $('#pic-content').find($('.loop')).find('.next').attr("href", "#" + parseInt((length - 1) / 12 + 1));
      }
    });
    $('#pic-content').find($('.loop')).find($('a')).click(function(e) {
      var button, href, _l, _len, _ref1, _results;
      href = $(e.currentTarget).attr('href');
      _ref1 = $('.page-nav');
      _results = [];
      for (_l = 0, _len = _ref1.length; _l < _len; _l++) {
        button = _ref1[_l];
        if ($(button).attr('href') === href) {
          _results.push(button.click());
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    });
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

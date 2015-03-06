(function() {
  var arrow_move, check, init, now_arrow;

  now_arrow = 0;

  init = function() {
    switch (window.location.pathname) {
      case '/':
        return arrow_move(0);
      case '/article':
        return arrow_move(1);
      case '/share':
        return arrow_move(2);
      case '/discuss':
        return arrow_move(3);
      case '/album':
        return arrow_move(4);
      case '/work':
        return arrow_move(5);
      case '/about':
        return arrow_move(6);
    }
  };

  check = function() {
    var index, _i, _len, _ref, _results;
    _ref = $('.link');
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      index = _ref[_i];
      if (index === $('.link')[now_arrow]) {
        $(index).removeClass("dark");
        _results.push($(index).addClass("light"));
      } else {
        $(index).removeClass("light");
        _results.push($(index).addClass("dark"));
      }
    }
    return _results;
  };

  arrow_move = function(num) {
    now_arrow = num;
    $('.triangle').css("left", (num * 93 + 37) + "px");
    return check();
  };

  init();

  $('#logout').click(function() {
    return $.ajax({
      url: '/log/session',
      type: 'delete',
      success: function(data) {
        alert(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          return $(location).attr('href', '/');
        }
      }
    });
  });

  $('.link').mouseover(function(event) {
    var target;
    target = $(event.currentTarget);
    return arrow_move(target.attr("data-num"));
  });

  $('#links').mouseout(init);

}).call(this);

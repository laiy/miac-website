(function() {
  window.onload = function() {
    var i, j, k, length, newBlock, page, pictures, row, _i, _j, _k, _ref;
    pictures = $(".picture");
    pictures.click(function(e) {
      var url;
      url = $(e.currentTarget.firstChild).attr("src");
      $("#screen").find("#image").find("img").attr("src", url);
      return $("#screen").css("display", "block");
    });
    length = pictures.length;
    $("#p-1").addClass("active");
    $('.loop').find('.prev').attr("href", "#" + length);
    if (length > 1) {
      $('.loop').find('.next').attr("href", "#" + 2);
    } else {
      $('.loop').find('.next').attr("href", "#" + 1);
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
      return $("#container").css("display", "none");
    });
    return $('.adderButton').click(function(e) {
      e.preventDefault();
      return $('#container').css("display", "inline-block");
    });
  };

}).call(this);

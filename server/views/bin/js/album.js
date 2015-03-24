(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  window.onload = function() {
    var Rows, counter, domYear, domYears, getYear, index, lastRow, newyear, picture, pictures, timer, year, years, _i, _j, _len, _len1, _results;
    pictures = $(".pic");
    timer = function(a, b) {
      var timeA, timeB;
      timeA = getYear(a);
      timeB = getYear(b);
      return timeA > timeB;
    };
    getYear = function(picture) {
      return $(picture).find(".time")[0].innerHTML.split('/')[0];
    };
    pictures.sort(timer);
    years = [];
    domYears = [];
    index = 0;
    counter = 0;
    for (_i = 0, _len = pictures.length; _i < _len; _i++) {
      picture = pictures[_i];
      year = getYear(picture);
      if (!(__indexOf.call(years, year) >= 0)) {
        years.push(year);
        newyear = domYears[index++] = $("<div class='year'></div>");
        $("<header></heder>").html(year).appendTo(newyear);
        newyear.append($("<div class='row'></div>"));
        counter = 0;
      }
      Rows = domYears[index - 1].find(".row");
      lastRow = Rows[Rows.length - 1];
      $(lastRow).append(picture);
      ++counter;
      if (counter === 3) {
        counter = 0;
        domYears[index - 1].append("<div class='row'></div>");
      }
    }
    _results = [];
    for (_j = 0, _len1 = domYears.length; _j < _len1; _j++) {
      domYear = domYears[_j];
      _results.push(domYear.appendTo($('#content')));
    }
    return _results;
  };

}).call(this);

(function() {
  $('.up').click(function() {
    var discussionId;
    discussionId = $(this).attr('discussion-id');
    return $.post('/Discuss/up', {
      discussionId: discussionId
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
      if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            window.location.reload();
          };
          $("#message-confirm").bind("click", messageCallback);
      }
    });
  });

  $('.down').click(function() {
    var discussionId;
    discussionId = $(this).attr('discussion-id');
    return $.post('/Discuss/down', {
      discussionId: discussionId
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg != undefined? data.msg : ''));
      if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            window.location.reload();
          };
          $("#message-confirm").bind("click", messageCallback);
      }
    });
  });

  String.prototype.stripHTML = function() {  
        var reTag = /<(?:.|\s)*?>/g;  
        return this.replace(reTag,"");  
  }  


  function cutstr(str) {
    var n = str.length;
    if (n > 130) {
      var str = str.substring(0,130);
      str = str + "...";
    }
    return str;
  }
  $(".discussion_content").each(function() {
    var sTest = $(this).html();
    $(this).empty();
    $(this).append(cutstr(sTest.stripHTML()));
  });

    //Set the link of page button
    var length = $(".page-button").length,
        tag = url('?tag'),
        page = url('?page');
    if (tag == null) tag = '';
    if (page == null) page = "1";
    page = parseInt(page);
    if (page > 1) {
        $('#prev-page').find('a').attr("href", "/Discuss?page=" + (page - 1) + "&tag=" + tag);
    } else {
        $('#prev-page').find('a').attr("href", "#");
    }
    if (page < length) {
        $('#next-page').find('a').attr("href", "/Discuss?page=" + (page + 1) + "&tag=" + tag);
    } else {
        $('#next-page').find('a').attr("href", "#");
    }
    $(".page-button").each(function() {
        var num = $(this).find('a').text();
        $(this).find('a').attr("href", "/Discuss?page=" + num + "&tag=" + tag);
        if (parseInt(num) == page) {
            $(this).addClass('chosen-page');
        } else {
            $(this).removeClass('chosen-page');
        }
    });

    //Listen to the search event
   $("#search-input").on("input propertychange", function() {
    var key = $(this).val(),
        patt = new RegExp(key);
    $(".discuss").each(function() {
        var title = $(this).find(".discussion_title").find("a").text();
        if (!patt.test(title)) {
            $(this).addClass("invisible");
        } else {
            $(this).removeClass("invisible");
        } 
    });    
   });
}).call(this);

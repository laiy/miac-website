(function() {
  $('.up').click(function() {
    var discussionId;
    discussionId = $(this).attr('discussion-id');
    return $.post('/Discuss/up', {
      discussionId: discussionId
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return window.location.reload();
      }
    });
  });

  $('.down').click(function() {
    var discussionId;
    discussionId = $(this).attr('discussion-id');
    return $.post('/Discuss/down', {
      discussionId: discussionId
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return window.location.reload();
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

}).call(this);

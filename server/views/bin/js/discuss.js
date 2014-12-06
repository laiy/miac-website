(function() {
  $('.up').click(function() {
    var discussionId;
    discussionId = $(this).attr('discussion-id');
    return $.post('/discuss/up', {
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
    return $.post('/discuss/down', {
      discussionId: discussionId
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return window.location.reload();
      }
    });
  });

}).call(this);

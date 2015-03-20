(function() {
  $('#comment-submit').click(function() {
    var ObjectId, content, items;
    content = $(this).siblings('input').val();
    items = window.location.href.split('/');
    ObjectId = items[items.length - 1];
    return $.post('/message/create', {
      replyTo: ObjectId,
      type: 'comment',
      content: content
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return window.location.reload();
      }
    });
  });

  $('.reply-submit').click(function() {
    var ObjectId, content;
    content = $(this).siblings('input').val();
    ObjectId = $(this).attr('comment-id');
    return $.post('/message/create', {
      replyTo: ObjectId,
      type: 'reply',
      content: content
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return window.location.reload();
      }
    });
  });

  $(function() {
    return $('.adderButton').click(function(e) {
      e.preventDefault();
      return $('#container').css("display", "block");
    });
  });

}).call(this);

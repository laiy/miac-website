(function() {
  $(document).ready(function() {
    $('#comment-submit').click(function() {
      var ObjectId, content, items;
      content = $(this).siblings('textarea').val();
      items = window.location.href.split('/');
      ObjectId = items[items.length - 1];
      alert(content);
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
    return $('.reply-submit').click(function() {
      var ObjectId, content;
      content = $(this).siblings('input').val();
      ObjectId = $(this).parent('div').attr('name');
      alert(content);
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
  });

}).call(this);

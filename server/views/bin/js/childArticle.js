(function() {
  $('#comment-submit').click(function() {
    var ObjectId, content, items;
    content = $(this).siblings('input').val();
    items = window.location.href.split('/');
    ObjectId = items[items.length - 1];
    return $.post('/Message/create', {
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

  $('#delete_article').click(function() {
      var id = $(this).attr('article_id');
      return $.post('/article/delete', {
          articleId: id
      }, function(data) {
        alert(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          return $(location).attr('href', '/Article');
        }
      });
  });

  $('.delete_reply').click(function() {
    var id = $(this).attr('replyid');
    return $.post('/message/delete', {
      messageId: id
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          return window.location.reload();
        }
    });
  })

  $('.reply-submit').click(function() {
    var ObjectId, content;
    content = $(this).siblings('input').val();
    ObjectId = $(this).attr('comment-id');
    return $.post('/Message/create', {
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

  $('.delete_discussion').click(function() {
    var id = $(this).attr('messageid');
    return $.post('/message/delete', {
      messageId: id
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          return window.location.reload();
        }
    });
  });

  $('.comment').click(function() {
    $(this).children().eq(2).slideDown();
  });

  $(document).mouseup(function(e){
    var _con = $('.comment');   // 设置目标区域
    if(!_con.is(e.target) && _con.has(e.target).length === 0){ // Mark 1
      $('.hide').slideUp();   // 功能代码
    }
  });
}).call(this);

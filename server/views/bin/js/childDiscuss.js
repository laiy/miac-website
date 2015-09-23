(function() {
  $('#answer-submit').click(function() {
    var answerTo, content, items;
    content = $('#content').val();
    items = window.location.href.split('/');
    answerTo = items[items.length - 1];
    return $.post('/Discuss/create', {
      type: 'answer',
      title: '',
      content: content,
      answerTo: answerTo
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            $(location).attr('href', '/Discuss');
          };
      }
    });
  });

  $('#delete_discussion').click(function() {
    var id = $(this).attr('discussionid');
      return $.post('/discuss/delete', {
          discussionId: id
      }, function(data) {
        messageFadeIn(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            $(location).attr('href', '/Discuss');
          };
          $("#message-confirm").bind("click", messageCallback);
        }
      });
  });

  $('.delete_reply').click(function() {
    var id = $(this).attr('replyid');
    return $.post('/message/delete', {
      messageId: id
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            window.location.reload();
          };
          $("#message-confirm").bind("click", messageCallback);
        }
    });
  });

  $('.delete_answer').click(function() {
    var id = $(this).attr('answerid');
      return $.post('/discuss/delete', {
          discussionId: id
      }, function(data) {
        messageFadeIn(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            window.location.reload();
          };
          $("#message-confirm").bind("click", messageCallback);
        }
      });
  })

  $('.reply-submit').click(function() {
    var ObjectId, content;
    content = $(this).prev().children('input').val();
    ObjectId = $(this).attr('answer-id');
    return $.post('/Message/create', {
      replyTo: ObjectId,
      type: 'reply',
      content: content
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            window.location.reload();
          };
          $("#message-confirm").bind("click", messageCallback);
      }
    });
  });

  $('.up').click(function() {
    var discussionId;
    discussionId = $(this).attr('discussion-id');
    return $.post('/Discuss/up', {
      discussionId: discussionId
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg ? data.msg : void 0));
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
      messageFadeIn(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            window.location.reload();
          };
          $("#message-confirm").bind("click", messageCallback);
      }
    });
  });


  $('.hide').click(function() {
    $(this).children().eq(1).slideDown();
  });

  $(document).mouseup(function(e){
    var _con = $('.hide');   // 设置目标区域
    if(!_con.is(e.target) && _con.has(e.target).length === 0){ // Mark 1
      $('.show').slideUp();   // 功能代码
    }
  });


}).call(this);

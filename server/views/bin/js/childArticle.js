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
      $("#message-confirm").unbind("click", messageCallback);
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

  $('#delete_article').click(function() {
      var id = $(this).attr('article_id');
      return $.post('/article/delete', {
          articleId: id
      }, function(data) {
        messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
        if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            $(location).attr('href', '/Article');
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
      messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
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
    content = $(this).siblings('input').val();
    ObjectId = $(this).attr('comment-id');
    return $.post('/message/create', {
      replyTo: ObjectId,
      type: 'reply',
      content: content
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

  $('.delete_discussion').click(function() {
    var id = $(this).attr('messageid');
    return $.post('/message/delete', {
      messageId: id
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

  $('.reply_style').click(function() {
    $(this).parent().parent().parent().children().eq(2).slideDown();
  });

  $(document).mouseup(function(e){
    var _con = $('.comment');   // 设置目标区域
    if(!_con.is(e.target) && _con.has(e.target).length === 0){ // Mark 1
      $('.hide').slideUp();   // 功能代码
    }
  });

  //更新文章
  $('#update').click(function() {
    var id, content;
    id = $('#update_article').attr('article_id');
    content = tinyMCE.activeEditor.getContent();
    return $.post('/Article/updateContent', {
      articleId: id,
      content: content
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

  $('.article-editor').find('#cancel').click(function() {
    $('.article-editor').addClass('invisible');
    $('.article').removeClass('invisible');
    $('.comment_reply').removeClass('invisible');   
  });
  
  $('#update_article').click(function() {         
    var content = $('.article_page_content').text();
    tinyMCE.activeEditor.setContent(content);
    $('.article-editor').removeClass('invisible');
    $('.article').addClass('invisible');
    $('.comment_reply').addClass('invisible');   
  }); 

  $('.update_comment').click(function() {
    if ($(this).hasClass("update_comment")) {
        var content = $(this).parent().parent().parent().find('.comment_value').text();         
        var editor = $(this).parent().parent().parent().find('.comment_editor'); 
        $(this).parent().parent().parent().find('.comment_p').addClass('invisible');
        editor.val(content).removeClass('invisible');
        editor.focus();
        $(this).text("确定").removeClass("update_comment").addClass("submit_comment");
        return;
    }

    if ($(this).hasClass("submit_comment")) {
        var content = $(this).parent().parent().parent().find(".comment_editor").val(), id = $(this).attr('messageid');
        var dataCallback = (function (obj) {
            return function(data) {
                if (data.result === 'success') {
                    $(obj).parent().parent().parent().find('.comment_value').text(content);   
                    $(obj).parent().parent().parent().find('.comment_editor').addClass('invisible');
                    $(obj).parent().parent().parent().find('.comment_p').removeClass('invisible');
                } else {
                    messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
                }
            } 
        })(this);
        $.post('/message/updateContent', {
            messageId: id,
            content: content
        }, dataCallback); 
        $(this).text("编辑").removeClass("submit_comment").addClass("update_comment");
    }
  }); 

}).call(this);

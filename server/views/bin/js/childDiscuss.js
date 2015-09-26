(function() {
  $('#answer-submit').click(function() {
    var answerTo, content, items;
    content = $('#content').val();
    items = window.location.href.split('/');
    answerTo = items[items.length - 1];
    return $.post('/discuss/create', {
      type: 'answer',
      title: '',
      content: content,
      answerTo: answerTo,
      tags : ['']
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
      if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            window.location.reload();
          };
          $("#message-confirm").click(messageCallback);
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
    content = $(this).prev().children('input').val();
    ObjectId = $(this).attr('answer-id');
    return $.post('/Message/create', {
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
    if ($(this).text() == '回复') {
        $(this).parent().parent().parent().children().eq(1).slideDown();
        $(this).text('取消');
    }
    else {
        $(this).parent().parent().parent().find('.show').slideUp();
        $(this).text('回复');
    }
  });

  $(document).mouseup(function(e){
    var _con = $('.hide');   // 设置目标区域
    if(!_con.is(e.target) && _con.has(e.target).length === 0){ // Mark 1
      $('.show').slideUp();   // 功能代码
    }
  });

  $('.update_discussion').click(function(){
    if ($(this).hasClass('update_discussion')) {
        var content = $(this).parent().parent().find('.discuss_value').text();         
        var editor = $(this).parent().parent().find('.discussion_editor'); 
        $(this).parent().parent().find('.discussion_content').addClass('invisible');
        editor.val(content).removeClass('invisible');
        editor.focus();
        $(this).removeClass('update_discussion').addClass('discussion_submit_update').text('确定');
        return;
    }

    if ($(this).hasClass('discussion_submit_update')) {
        var content = $(this).parent().parent().find('.discussion_editor').val(), id = $(this).attr('discussionid');
        var dataCallback = (function (obj) { 
            return function(data) {
                if (data.result === 'success') {
                    $(obj).parent().parent().find('.discuss_value').text(content);   
                    $(obj).parent().parent().find('.discussion_editor').addClass('invisible');
                    $(obj).parent().parent().find('.discussion_content').removeClass('invisible');
                } else {
                    messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
                }
            }
        })(this);
        $.post('/discuss/updateContent', {
            discussionId: id,
            content: content
        }, dataCallback); 
        $(this).removeClass('discussion_submit_update').addClass('update_discussion').text('编辑');
    }
  }); 

  $('.update_reply').click(function(){
    if ($(this).hasClass('update_reply')) {
        var content = $(this).parent().parent().find('.discuss_value').text();         
        var editor = $(this).parent().parent().find('.reply_editor'); 
        $(this).parent().parent().find('.discussion_content').addClass('invisible');
        editor.val(content).removeClass('invisible');
        editor.focus();
        $(this).removeClass('update_reply').addClass('reply_submit_update').text('确定');
        return;
    }

    if ($(this).hasClass('reply_submit_update')) {
        var content = $(this).parent().parent().find('.reply_editor').val(), id = $(this).attr('replyid');
        var dataCallback = (function (obj) { 
            return function(data) {
            if (data.result === 'success') {
                $(obj).parent().parent().find('.discuss_value').text(content);   
                $(obj).parent().parent().find('.reply_editor').addClass('invisible');
                $(obj).parent().parent().find('.discussion_content').removeClass('invisible');
            } else {
                messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
            }
            }
        })(this);
        $.post('/message/updateContent', {
            messageId: id,
            content: content
        }, dataCallback); 
        $(this).removeClass('reply_submit_update').addClass('update_reply').text('编辑');
    }
  }); 

  $('#update').click(function() {
    var id, content;
    id = $('#update_discussion').attr('discussionid');
    content = tinyMCE.activeEditor.getContent();
    return $.post('/discuss/updateContent', {
      discussionId: id,
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
    $('.discussion_right').removeClass('invisible');
    $('.discussion_left').removeClass('invisible');
    $('.discussion_reply').removeClass('invisible');
  });
  
  $('#update_discussion').click(function() {         
    var content = $('#head_value').next().text();
    tinyMCE.activeEditor.setContent(content);
    $('.article-editor').removeClass('invisible');
    $('.discussion_right').addClass('invisible');
    $('.discussion_left').addClass('invisible');
    $('.discussion_reply').addClass('invisible');
  }); 
}).call(this);


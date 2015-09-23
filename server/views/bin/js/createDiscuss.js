(function() {
  $('#submit').click(function() {
    var content, title;
    title = $('#title').val();
    content = tinyMCE.activeEditor.getContent();
    var tags = []; 
    $(".discuss_tag").find("input").each(function() {
        tag = $(this).attr("value");
        if ($(this)[0].checked) tags.push(tag);    
    });
    content = tinyMCE.activeEditor.getContent();
    return $.post('/Discuss/create', {
      type: 'question',
      title: title,
      content: content,
      tags: tags,
      answerTo: ''
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
      if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            $(location).attr('href', '/Discuss?page=1&tag=');
          };
          $("#message-confirm").bind("click", messageCallback);
      }
    });
  });

}).call(this);

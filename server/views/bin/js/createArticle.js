(function() {
  $('#submit').click(function() {
    var category, content, title;
    category = $('#category').val();
    title = $('#title').val();
    var tags = [];
    $(".article_tag").find("input").each(function() {
        tag = $(this).attr("value");
        if ($(this)[0].checked) tags.push(tag);    
    });
    content = tinyMCE.activeEditor.getContent();
    return $.post('/Article/create', {
      category: category,
      title: title,
      content: content,
      tags: tags
    }, function(data) {
      messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
      if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            $(location).attr('href', '/Article?page=1&tag=');
          };
          $("#message-confirm").bind("click", messageCallback);
      }
      $("#message-confirm").bind("click", messageCallback);
    });
  });

}).call(this);

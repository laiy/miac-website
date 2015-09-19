(function() {
  $('#submit').click(function() {
    var category, content, title;
    category = $('#category').val();
    title = $('#title').val();
    tags = [];
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
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return $(location).attr('href', '/Article');
      }
    });
  });

}).call(this);

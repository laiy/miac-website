(function() {
  $('#submit').click(function() {
    var category, content, title;
    category = $('#category').val();
    title = $('#title').val();
    content = tinyMCE.activeEditor.getContent();
    return $.post('/Article/create', {
      category: category,
      title: title,
      content: content
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return $(location).attr('href', '/Article');
      }
    });
  });

}).call(this);

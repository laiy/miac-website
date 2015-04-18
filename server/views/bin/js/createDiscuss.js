(function() {
  $('#submit').click(function() {
    var content, title;
    title = $('#title').val();
    content = tinyMCE.activeEditor.getContent();
    return $.post('/Discuss/create', {
      type: 'question',
      title: title,
      content: content,
      answerTo: ''
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return $(location).attr('href', '/Discuss');
      }
    });
  });

}).call(this);

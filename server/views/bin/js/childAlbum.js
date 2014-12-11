(function() {
  $('button').click(function() {
    var albumId, data, items;
    items = window.location.href.split('/');
    albumId = items[items.length - 1];
    data = FormData();
    data.append('picture', $('input').attr('files'));
    data.append('albumId', albumId);
    return $.ajax({
      url: '/album/addPicture',
      data: data,
      cache: false,
      contentType: false,
      processData: false,
      type: 'POST',
      success: function() {
        alert(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          return window.location.reload();
        }
      }
    });
  });

}).call(this);

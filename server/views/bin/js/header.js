(function() {
  $('#logout').click(function() {
    return $.ajax({
      url: '/log/session',
      type: 'delete',
      success: function(data) {
        alert(data.result + '\n' + data.msg);
        if (data.result === 'success') {
          return $(location).attr('href', '/');
        }
      }
    });
  });

}).call(this);

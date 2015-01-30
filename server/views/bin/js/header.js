(function() {
  $('#logout').click(function() {
    return $.ajax({
      url: '/Log/session',
      type: 'delete',
      success: function(data) {
        alert(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          return $(location).attr('href', '/');
        }
      }
    });
  });

}).call(this);

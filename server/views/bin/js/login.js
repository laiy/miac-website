(function() {
  $('button').click(function() {
    var password, username;
    username = $('#username').val();
    password = $('#password').val();
    return $.ajax({
      url: '/Log/session',
      data: {
        username: username,
        password: password
      },
      type: 'post',
      error: function(XMLHttpRequest) {
        return alert(XMLHttpRequest.status + ' ' + XMLHttpRequest.statusText);
      },
      success: function(data) {
        alert(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          return $(location).attr('href', '/');
        }
      }
    });
  });

}).call(this);

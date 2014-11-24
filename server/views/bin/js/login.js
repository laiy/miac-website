(function() {
  $('button').click(function() {
    var password, username;
    username = $('#username').val();
    password = $('#password').val();
    alert('233');
    return $.ajax({
      url: '/log/session',
      data: {
        username: username,
        password: password
      },
      type: 'post',
      error: function(XMLHttpRequest) {
        return alert(XMLHttpRequest.status + ' ' + XMLHttpRequest.statusText);
      },
      success: function(data) {
        return alert(data.result + '\n' + data.msg);
      }
    });
  });

}).call(this);

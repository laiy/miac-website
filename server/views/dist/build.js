(function() {
  $('button').click(function() {
    var password, username;
    username = $('#username').val();
    password = $('#password').val();
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

(function() {
  $('button').click(function() {
    var email, password, username;
    username = $('#username').val();
    password = $('#password').val();
    email = $('#email').val();
    return $.post('/register/regist', {
      username: username,
      password: password,
      email: email
    }, function(data) {
      return alert(data.result + '\n' + data.msg);
    });
  });

}).call(this);

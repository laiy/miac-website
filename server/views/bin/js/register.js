(function() {
  $('button').click(function() {
    var email, password, username;
    username = $('#username').val();
    password = $('#password').val();
    email = $('#email').val();
    return $.post('/Register/regist', {
      username: username,
      password: password,
      email: email
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return $(location).attr('href', '/');
      }
    });
  });

}).call(this);

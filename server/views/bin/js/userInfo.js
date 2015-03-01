(function() {
  $('.password-update').click(function() {
    var password;
    password = $(this).siblings('input').val();
    return $.post('/User/updatePassword', {
      password: password
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return window.location.reload();
      }
    });
  });

  $('.email-update').click(function() {
    var email;
    email = $(this).siblings('input').val();
    return $.post('/User/updateEmail', {
      email: email
    }, function(data) {
      alert(data.result + '\n' + (data.msg ? data.msg : void 0));
      if (data.result === 'success') {
        return window.location.reload();
      }
    });
  });

}).call(this);

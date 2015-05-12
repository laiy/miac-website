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
  var change_pic = 0;
  $("#change_pic_js").click(function() {
    if (change_pic == 0) {
      $(".js_avatar").show();
      change_pic = 1;
    } else {
      $(".js_avatar").hide();
      change_pic = 0;
    }
  });
}).call(this);

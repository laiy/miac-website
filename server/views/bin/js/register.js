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

  var username_tipnum = 0;
  var password_tipnum = 0;
  function username_tranfer() {
    if(username_tipnum == 0) {
      username_tipnum = 1;
      $('#username').after("<div id='username_tip'><p>请填写手机号或邮箱地址</p></div>");
    }
  }
  function password_tranfer() {
    if(password_tipnum == 0) {
      password_tipnum = 1;
      $('#password').after("<div id='password_tip'><p>密码长度至少八位</p></div>");
    }
  }
  function password_tranfer_reverse() {
    if (password_tipnum == 1) {
      $('#password_tip').remove();
      password_tipnum = 0;
    }
  }
  function username_tranfer_reverse() {
    if (username_tipnum == 1) {
      $('#username_tip').remove();
      username_tipnum = 0;
    }
  }
  $('#username').focus(function() {
    username_tranfer();
    password_tranfer_reverse();
  });
  $('#username').click(function() {
    username_tranfer();
  });
  $('#password').focus(function() {
    password_tranfer();
    username_tranfer_reverse();
  });
  $('#password').click(function() {
    password_tranfer();
  });
  $('#email').focus(function() {
    username_tranfer_reverse();
    password_tranfer_reverse();
  })

  $(document).mouseup(function(e){
    if (username_tipnum == 1) {
      var _con = $('#username_tip');   // 设置目标区域
      if(!_con.is(e.target) && _con.has(e.target).length === 0){ // Mark 1
        $('#username_tip').remove();
        username_tipnum = 0;  // 功能代码
      }
    }
    if (password_tipnum == 1) {
      var _con = $('#password_tip');   // 设置目标区域
      if(!_con.is(e.target) && _con.has(e.target).length === 0){ // Mark 1
        $('#password_tip').remove();
        password_tipnum = 0;  // 功能代码
      }
    }
  });



}).call(this);

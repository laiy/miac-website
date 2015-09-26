(function() {
  $('.sign-in-submit').click(function() {
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
        messageFadeIn(XMLHttpRequest.status + ' ' + XMLHttpRequest.statusText);
      },
      success: function(data) {
        messageFadeIn(data.result + '\n' + (data.msg != undefined ? data.msg : ''));
        if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            window.location.reload();
          };
          $("#message-confirm").click(messageCallback);
        }
      }
    });
  });

}).call(this);

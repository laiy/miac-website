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
        messageFadeIn(data.result + '\n' + (data.msg ? data.msg : void 0));
        if (data.result === 'success') {
          $("#message-confirm").unbind("click", messageCallback);
          messageCallback = function() {
            $(location).attr('href', './');
          };
          $("#message-confirm").click(messageCallback);
        }
      }
    });
  });

}).call(this);

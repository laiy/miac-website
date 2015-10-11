(function() {
  window.onload = function() {
    $('#delete_album').click(function() {
        var id = $(this).attr('albumid');
        return $.post('/album/deleteAlbum', {
            albumId: id
        }, function(data) {
          alert(data.result + '\n' + (data.msg ? data.msg : void 0));
          if (data.result === 'success') {
            return $(location).attr('href', '/Album?page=1&tag=');
          }
        });
    });
    $(".firstItem").click(function() {
      var src = $(".firstItem .pic img").attr("src");
      $(".showPic .center .centerPic img").attr("src", src);
      $(".showPic").slideDown();
    });
    $("#close").click(function() {
      $(".showPic").slideUp();
    });
    $(".opcaity").click(function() {
      $("#addPicBG").css("display","block");
      $(".addPic").slideDown();
    });
    $("#addPictureBtn").click(function() {
      $("#addPicBG").css("display","block");
      $(".addPic").slideDown();
    });
    $("#closeBtn").click(function() {
      $("#addPicBG").css("display","none");
    });
  };
}).call(this);

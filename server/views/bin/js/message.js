messageCallback = function() {
};

(function() {
    $("#message-confirm").click(function() {
       messageFadeOut(); 
    });

    messageFadeIn = function(mess) {
        $("#message-content").find("p").text(mess);
        $("#message").removeClass("invisible").addClass("extent-in-animate").removeClass("extent-out-animate");
    }
    messageFadeOut = function() {
        $("#message").removeClass("extent-in-animate").addClass("extent-out-animate").addClass("invisible");
    }

    messageCallback = function() {
    }

    $("#message-confirm").click(messageCallback);

    $("#sign-in-btn").click(function(e) {
        e.preventDefault();
        $("#login-modal").removeClass("invisible").addClass("extent-in-animate").removeClass("extent-out-animate");
        $("#cover").removeClass("invisible");
    }); 

    $("#close-btn").click(function(e) {
        e.preventDefault();
        $("#cover").addClass("invisible");
        $("#login-modal").removeClass("extent-in-animate").addClass("extent-out-animate").addClass("invisible");
    }); 

    $("#message-confirm").click(messageCallback);

}).call(this);

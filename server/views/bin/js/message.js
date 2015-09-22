(function() {
    var messageFadeIn = function() {
        $("#message").removeClass("invisible").addClass("fade-in-animate").removeClass("fade-out-animate");
    }
    var messageFadeOut = function() {
        $("#message").removeClass("fade-in-animate").addClass("fade-out-animate").addClass("invisible");
   
    }

}).call(this);

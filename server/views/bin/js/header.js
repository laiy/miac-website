(function() {
  $(function() {
    /*
    * when button 'Sign out' is clicked, AJAX to back-front to delete session and reload home page
    */

    var Pointer_Animation_Handler, pointer_animation_handler;
    $('#logout').click(function() {
      return $.ajax({
        url: '/Log/session',
        type: 'delete',
        success: function(data) {
          if (data.result === 'success') {
            return $(location).attr('href', '/');
          } else {
            return alert('fail!');
          }
        }
      });
    });
    /*
    * handle the logic of header-pointer's animation
    */

    Pointer_Animation_Handler = (function() {
      /*
      * init datastructure along with event handler
      * @param $navigators: nav elements in DOM
      * @param destinations: record the destinations for pointer to go
      * @param $pointer: pointer element in DOM
      */

      function Pointer_Animation_Handler($navigators, destinations, $pointer) {
        this.$navigators = $navigators != null ? $navigators : $('div#header-nav a');
        this.destinations = destinations != null ? destinations : [];
        this.$pointer = $pointer != null ? $pointer : $('div#header-pointer');
        this.add_event_handler();
      }

      /*
      * add event 'onmouseover' to each navigator
      */


      Pointer_Animation_Handler.prototype.add_event_handler = function() {
        var i, navigator, that, _i, _len, _ref, _results;
        that = this;
        _ref = this.$navigators;
        _results = [];
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          navigator = _ref[i];
          this.destinations[i] = (navigator.offsetLeft - this.$pointer.position().left + (navigator.offsetWidth - 40) / 3) + "px";
          _results.push(navigator.onmouseover = (function(i) {
            return function() {
              return that.$pointer.css('left', that.destinations[i]);
            };
          })(i));
        }
        return _results;
      };

      return Pointer_Animation_Handler;

    })();
    return pointer_animation_handler = new Pointer_Animation_Handler;
  });

}).call(this);

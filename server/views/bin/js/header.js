(function() {
  $(function() {
    /*
    * when button 'Sign out' is clicked, AJAX to back-front to delete session and reload home page
    */

    var Pointer, pointer;
    $('#logout').click(function() {
      return $.ajax({
        url: '/Log/session',
        type: 'delete',
        success: function(data) {
          alert(data.result + '\n' + (data.msg ? data.msg : void 0));
          if (data.result === 'success') {
            return $(location).attr('href', '/');
          }
        }
      });
    });
    /*
    * handle the logic of header-pointer's animation
    */

    Pointer = (function() {
      /*
      * init datastructure along with event handler
      * @param $navigators: nav elements in DOM
      * @param destinations: record the destinations for pointer to go
      * @param $pointer: pointer element in DOM
      */

      function Pointer($navigators, destinations, $pointer) {
        this.$navigators = $navigators != null ? $navigators : $('div#header-nav a');
        this.destinations = destinations != null ? destinations : ['162px', '245px', '340px', '433px', '525px', '613px'];
        this.$pointer = $pointer != null ? $pointer : $('div#header-pointer');
        this.add_event_handler();
      }

      /*
      * add event 'onmouseover' to each navigator
      */


      Pointer.prototype.add_event_handler = function() {
        var i, navigator, that, _i, _len, _ref, _results;
        that = this;
        _ref = this.$navigators;
        _results = [];
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          navigator = _ref[i];
          _results.push(navigator.onmouseover = (function(i) {
            return function() {
              return that.$pointer.css('left', that.destinations[i]);
            };
          })(i));
        }
        return _results;
      };

      return Pointer;

    })();
    return pointer = new Pointer;
  });

}).call(this);

var express = require('express');
var path = require('path');
var favicon = require('static-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var multer  = require('multer');  // handling multipart/form-data
var session = require('express-session');
var config = require('./config/config');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(favicon());
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use(multer({ dest: './public/temp/'}));

app.use(express.static(path.join(__dirname, 'public')));

var db = require('./lib/db');
db.connect(function(db) {

  app.use('/admin', cookieParser(config.cookieSecret));
  app.use('/admin', session());

  // routes
  app.use('/admin', require('./routes/admin'));
  app.use('/api', require('./routes/api'));

  // Test page
  if (app.get('env') === 'development') {
    app.get('/test', function(req, res){
      res.render('test');
    });
  }

  /// catch 404 and forward to error handler
  app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
  });

  /// error handlers

  // development error handler
  // will print stacktrace
  if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
      res.status(err.status || 500);
      console.log(err);
      res.render('error', {
        message: err.message,
        error: err
      });
    });
  }

  // production error handler
  // no stacktraces leaked to user
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: {}
    });
  });

  var server = app.listen(process.env.PORT || 3000, function() {
    console.log('Express server listening on port ' + server.address().port);
  });

});


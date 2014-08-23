var express = require('express');
var router = express.Router();
var album = require('../test/album');

router.get('/', function(req, res, next) {
    res.render('test', {test: "test"});
});

router.get('/album', function(req, res, next) {
    res.render('albumTest', {album: album});
});

module.exports = router;

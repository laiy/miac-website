var express = require('express');
var router = express.Router();
var album = require('../fixtures/album');

router.get('/', function(req, res, next) {
    res.render('test', {test: "test"});
});

router.get('/album', function(req, res, next) {
    console.log(album);
    console.log(album.album._id);
    res.render('albumTest', {album: album});
});

module.exports = router;

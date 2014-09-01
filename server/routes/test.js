var express = require('express');
var router = express.Router();
var album = require('../test/album');
var User = require('../models/user');

router.get('/userTest', function(req ,res, next) {
    console.log(User.validatePassword('122'));
});

router.get('/', function(req, res, next) {
    res.render('index');
});

router.get('/announcement', function(req, res, next) {
    res.render('announcement');
});

router.get('/article', function(req, res, next) {
    res.render('article');
});

router.get('/article/id', function(req, res, next) {
    res.render('childArticle');
});

router.get('/article/create', function(req, res, next) {
    res.render('createArticle');
});

router.get('/share', function(req, res, next) {
    res.render('share');
});

router.get('/share/id', function(req, res, next) {
    res.render('childShare');
});

router.get('/discuss', function(req, res, next) {
    res.render('discuss');
});

router.get('/discuss/id', function(req, res, next) {
    res.render('childDiscuss');
});

router.get('/discuss/create', function(req, res, next) {
    res.render('createDiscuss'); 
});

router.get('/album', function(req, res, next) {
    res.render('album');
});

router.get('/album/id', function(req, res, next) {
    res.render('childAlbum'); 
});

router.get('/album/create', function(req, res, next) {
    res.render('createAlbum');
});

router.get('/works', function(req, res, next) {
    res.render('works');  
});

router.get('/works/create', function(req, res, next) {
    res.render('createWorks');
});

router.get('/about', function(req, res, next) {
    res.render('about');
});

router.get('/logIn', function(req, res, next) {
    res.render('logIn');
});

router.get('/register', function(req, res, next) {
    res.render('register'); 
});

router.get('/albumTest', function(req, res, next) {
    res.render('albumTest', {album: album});
});

router.get('/test', function(req, res, next) {
    res.render('test');
});

module.exports = router;

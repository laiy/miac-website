var express = require('express');
var router = express.Router();

var authorization = require("./middlewares/authorization");
var user = require("../controllers/user");

module.exports = router;

//router.get("/user", authorization.requiresLogin, user.get);
//router.get("/createUser", authorization.checkUserConflict, user.create);

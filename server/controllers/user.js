//exports.get = function (req, res, next) {
    //res.render("showUser", {username: req.session.username});
//};

//exports.create = function (req, res, next) {
    //req.session.username = "shin";
    //res.json({result: "ok"});
//};

exports.validateUsername = function(username) {
    if (!username) {
        return 'Username should not be empty';
    } else if (!/^[a-zA-Z\d]+$/.test(username)) {
        return 'The form of username is invalid';
    }
    return false;
};

exports.validatePassword = function(password) {
    if (!password || password.length < 6) {
        return 'The length of password should not be less than 6';
    }
    return false;
};

exports.generatePassword = function(origin) {
    var salt = crypto.randomBytes(10).toString('hex');
    return {
        identity: encryptPassword(origin, salt),
        salt: salt
    };
};


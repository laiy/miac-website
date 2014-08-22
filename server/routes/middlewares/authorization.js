exports.requiresLogin = function (req, res, next) {
    if (req.session && req.session.username) {
        next();
    } else {
        res.status(401).send("unauthorized");
    }
};

exports.checkUserConflict = function (req, res, next) {
    if (req.session && req.session.username) {
        res.status(409).send("conflict");
    } else {
        next();
    }
};


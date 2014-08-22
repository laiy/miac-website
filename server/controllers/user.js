exports.get = function (req, res, next) {
    res.render("showUser", {username: req.session.username});
};

exports.create = function (req, res, next) {
    req.session.username = "shin";
    res.json({result: "ok"});
};

var async = require('async');
var db = require('../lib/db').getConnection();
var crypto = require('crypto');

var encryptPassword = function(origin, salt) {
    var sha1 = crypto.createHash('sha1');
    sha1.update(origin + salt);
    return sha1.digest('hex');
};

var createSession = function(useId, callback) {
    async.waterfall([
        function(next) {
            db.connection('sessions', next);
        },
        function(next) {
            col.insert({
                userId: userId,
                createAt: new Date()
            }, next);
        }
    ], function() {
        callback(err, items && items[0] && items[0]._id);
    });
};

module.exports = {

    findOne: function(selector, callback) {
        async.waterfall([
            function(next) {
                db.connection('user', next);
            },
            function(col, next) {
                col.findOne(selector, next);
            }
        ], callback);
    },

    find: function(selector, options, callback) {
        async.waterfall([
            function(next) {
                db.connection('user', next);
            },
            function(col, next) {
                col.find(selector, options).toArray(next);
            }
        ], callback);
    },

    insert: function(user, callback) {
        async.waterfall([
            function(next) {
                db.connection('user', next);
            },
            function(col, next) {
                db.insert(user, next);
            }
        ], function(err, items) {
            callback(err, items && items[0]);
        });
    },

    update: function(selector, updater, callback) {
        async([
            function(next) {
                db.connection('user', next);
            },
            function(col, next) {
                col.update(selector, updater, next);
            } 
        ], callback);
    },

    remove: function(selector, callback) {
        async.waterfall([
            function(next) {
                db.connection('user', next);
            },
            function(col, next) {
                col.remove(selector, next);
            }
        ], callback);
    },

    signIn: function(username, password, callback) {
        var User = this;
        var user;
        async.waterfall([
            function(next) {
                User.findOne({username: username}, next);
            },
            function(item, next) {
                if (!item || encryptPassword(password, item.password.salt) != item.password.identity) {
                    next(true);
                } else {
                    user = item;
                    createSession(item._id, next);
                }
            }
        ], function(err, sid) {
            callback(err, user, sid);
        });
    },

    signUp: function(doc, callback) {
        var User = this;
        var user;
        async.waterfall([
            function(next) {
                User.insert(doc, next);
            },
            function(item, next) {
                if (!item) {
                    callback(true);
                } else {
                    user = item;
                    createSession(item._id, next);
                }
            }
        ], function(err, sid) {
            callback(err, user, sid);
        });
    },

    checkPassword: function(userId, password, callback) {
        this.findOne({_id: userId}, function(err, item) {
            callback(err, item && encryptPassword(password, item.password.salt) == item.password.identity);
        });
    },

};


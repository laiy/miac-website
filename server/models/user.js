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
        function(callback) {
            db.connection('sessions', callback);
        },
        function(callback) {
            col.insert({
                userId: userId,
                createAt: new Date()
            }, callback);
        }
    ], function() {
        callback(err, items && items[0] && items[0]._id);
    });
};

module.exports = {

    findOne: function(selector, callback) {
        async.waterfall([
            function(callback) {
                db.connection('user', callback);
            },
            function(col, callback) {
                col.findOne(selector, callback);
            }
        ], callback);
    },

    find: function(selector, options, callback) {
        async.waterfall([
            function(callback) {
                db.connection('user', callback);
            },
            function(col, callback) {
                col.find(selector, options).toArray(callback);
            }
        ], callback);
    },

    insert: function(user, callback) {
        async.waterfall([
            function(callback) {
                db.connection('user', callback);
            },
            function(col, callback) {
                db.insert(user, callback);
            }
        ], function(err, items) {
            callback(err, items && items[0]);
        });
    },

    update: function(selector, updater, callback) {
        async([
            function(callback) {
                db.connection('user', callback);
            },
            function(col, callback) {
                col.update(selector, updater, callback);
            } 
        ], callback);
    },

    remove: function(selector, callback) {
        async.waterfall([
            function(callback) {
                db.connection('user', callback);
            },
            function(col, callback) {
                col.remove(selector, callback);
            }
        ], callback);
    },

    signIn: function(username, password, callback) {
        var User = this;
        var user;
        async.waterfall([
            function(callback) {
                User.findOne({username: username}, callback);
            },
            function(item, callback) {
                if (!item || encryptPassword(password, item.password.salt) != item.password.identity) {
                    callback(true);
                } else {
                    user = item;
                    createSession(item._id, callback);
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
            function(callback) {
                User.insert(doc, callback);
            },
            function(item, callback) {
                if (!item) {
                    callback(true);
                } else {
                    user = item;
                    createSession(item._id, callback);
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

    validateUsername: function(username) {
        if (!username) {
            return 'Username should not be empty';
        } else if (!/^[a-zA-Z\d]+$/.test(username)) {
            return 'The form of username is invalid';
        }
        return false;
    },

    validatePassword: function(password) {
        if (!password || password.length < 6) {
            return 'The length of password should not be less than 6';
        }
        return false;
    }
    

};


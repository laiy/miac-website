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
    }

};


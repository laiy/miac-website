var async = require('async');
var db = require('../lib/db').getConnection();

module.exports = {

    findOne: function(selector, callback) {
        async.waterfall([
            function(next) {
                db.connection('album', next);
            },
            function(col, next) {
                col.findOne(selector, next);
            }
        ], callback);
    },

    find: function(selector, options, callback) {
        async.waterfall([
            function(next) {
                db.connection('album', next);
            },
            function(col, next) {
                col.find(selector, options).toArray(next);
            }
        ], callback);
    },

    insert: function(album, callback) {
        async.waterfall([
            function(next) {
                db.connection('album', next);
            },
            function(col, next) {
                db.insert(album, next);
            }
        ], function(err, items) {
            callback(err, items && items[0]);
        });
    },

    update: function(selector, updater, callback) {
        async([
            function(next) {
                db.connection('album', next);
            },
            function(col, next) {
                col.update(selector, updater, next);
            } 
        ], callback);
    },

    remove: function(selector, callback) {
        async.waterfall([
            function(next) {
                db.connection('album', next);
            },
            function(col, next) {
                col.remove(selector, next);
            }
        ], callback);
    }

};

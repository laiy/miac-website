var connection;
var async = require('async');

exports.connect = function(callback){
  if (connection)
    callback(connection);
  else {
    var MongoClient = require('mongodb').MongoClient;
    var config = require('../config/config').database;
    var uri = 'mongodb://' + config.host + ':' + config.port + '/' + config.name;

    MongoClient.connect(uri, function(err, db) {
      if(err){
        throw new Error('连接数据库失败！');
      }
      else {
        connection = db;
        callback(db);
      }
    });
  }
};

exports.getConnection = function(){
  return connection;
};

//清空数据库
exports.clear = function(callback){
  connection.dropDatabase(function(err, result){
    if (err){
      throw new Error('清空数据库失败！');
    }
    if (callback)
      callback();
  });
};

/*
 *插入即使是生产模式下也需要的数据
 *exports.initialize = function(callback){
 *  插入管理员帐号
 *  async.waterfall([
 *    function(callback){
 *      connection.collection('users', callback);
 *    },
 *
 *    function(col, callback){
 *      var user = {
 *        username: 'admin',
 *        createdAt: new Date(),
 *        role: 'admin',
 *        password: {
 *          identity: '6000a683c6d7442f8209ded2f2e52d7b376e3d58',
 *          salt: '1811b194ae23a1f39bd0'
 *        }
 *      };
 *      col.insert(user, callback);
 *    }
 *  ],
 *
 *  function(err, items){
 *    if (err){
 *      throw new Error('获取users collection失败！');
 *    }
 *    else if (callback){
 *      callback();
 *    }
 *  });
 *};
 */

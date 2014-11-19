#	> File Name: register-test.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:10:09 CST

chai = require 'chai'
chai.should()
app = require '../app.coffee'
request = (require 'supertest')(app)

describe 'regist a new user', ->



#	> File Name: http-request-index-test.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 AM10:46:37 CST

chai = require "chai"
chai.should()
app = require '../app.coffee'
request = (require 'supertest')(app)

describe "index display", ->
    it 'GET / -> index.jade', (done)->
        request
            .get('/')
            .expect(200)
            .end done

#	> File Name: register-test.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:10:09 CST

chai = require 'chai'
chai.should()
app = require '../app.coffee'
request = (require 'supertest')(app)

describe 'regist a new user', ->
    describe 'POST /register -> registration', ->
        before (done)->
            request
                .post('/register')
                .send({username: 'already_existed_user', password: 'blablabla', email: 'blablabla@gmail.com'})
                .end done
        it 'create a new user successfully', (done)->
            request
                .post('/register')
                .send({username: 'franky_ly', password: 'miac-website', email: 'ly.franky@gmail.com'})
                .expect(200)
                .end(err, res)->
                    res.body.result.should.equal 'success'
                    done()
        it 'create a new user fail cuz user has already existed', (done)->
            request
                .post('/register')
                .send({username: 'already_existed_user', password: 'blablabla', email: 'blablabla@gmail.com'})
                .expect(200)
                .end(err, res)->
                    res.body.result.should.equal 'Username has already existed.'
                    done()







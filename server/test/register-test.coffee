#	> File Name: register-test.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:10:09 CST

chai = require 'chai'
chai.should()
app = require '../app.coffee'
request = (require 'supertest')(app)
UserModel = require '../db/models/user.coffee'

describe 'regist a new user', ->
    describe 'POST /register/regist -> registration', ->
        before (done)->
            UserModel.drop ->
                request
                    .post('/register/regist')
                    .send({username: 'already_existed_user', password: 'blablabla', email: 'blablabla@gmail.com'})
                    .end done
        it 'create a new user successfully', (done)->
            request
                .post('/register/regist')
                .send({username: 'franky_ly', password: 'miac-website', email: '834788686@qq.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'franky_ly', password: 'miac-website', email: 'test_test@163.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'franky_ly', password: 'miac-website', email: 'ly.franky@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
                    done()
        it 'create a new user fail cuz username has already existed', (done)->
            request
                .post('/register/regist')
                .send({username: 'already_existed_user', password: 'blablabla', email: 'blablabla@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'Username has already existed.'
                    done()
        it 'create a new user fail cuz some info were not complete', (done)->
            request
                .post('/register/regist')
                .send({username: '', password: 'blablabla', email: 'blablabla@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'Info not complete.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: '', email: 'blablabla@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'Info not complete.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: ''})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'Info not complete.'
                    done()
        it 'create a new user fail cuz the length of password is less than 8', (done)->
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablab', email: 'blablabla@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The length of password must be at least 8.'
                    done()
        it 'create a new user fail cuz the form of email is invalid', (done)->
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'com.com@com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'qwe.cn'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
                    done()


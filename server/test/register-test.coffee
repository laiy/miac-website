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
                .send({username: 'blablabla', password: 'blablabla', email: 'name-<username@domain.com>'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'u<username@domain.com>'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '<username@domain.com>'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'u$ername@domain.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'username@?'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'username\n@domain.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '-username@domain.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '233'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '123123@qqcom'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '213123@qq..com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '213123@@qq.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '213123@qq.com@'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '213213@qq.com.'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '.wqe@qq.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'qwe@.com'})
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
                .send({username: 'blablabla', password: 'blablabla', email: 'ａｂｃ@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'abc@def@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'abc#def@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a  b@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '-_.@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a..b@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '--..@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '-_-@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '....@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a.b@gmail..com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '--__@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '----@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '____@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'ab__c@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'The form of email is invalid.'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a__b@gmail.com'})
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
        it 'Test positive email form', (done)->
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'ABCdef@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'ABC@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '小二郎@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a-1-b-2-c-3@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a1b2c3@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'abc123@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: '123@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'abcdefghijklmnopqrstuvwxzy@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a_b_c@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a-b_c@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a.b_c@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a_b@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a-b@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a-b.c@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a.b.c@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
            request
                .post('/register/regist')
                .send({username: 'blablabla', password: 'blablabla', email: 'a-b-c@gmail.com'})
                .expect(200)
                .end (err, res)->
                    res.body.result.should.equal 'success'
                    done()



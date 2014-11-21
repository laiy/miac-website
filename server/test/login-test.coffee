#	> File Name: login-test.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Friday, November 21, 2014 AM09:29:20 CST

chai = require 'chai'
chai.should()
app = require '../app.coffee'
request = (require 'supertest')(app)
UserModel = require '../db/models/user.coffee'

describe 'login test', ->
    describe 'user login', ->
        before (done)->
            UserModel.drop ->
                request
                    .post('/register/regist')
                    .send({username: 'laiy', password: 'miac-website', email: 'ly.franky@gmail.com'})
                    .end done
        it 'Login fail cuz user doesnt exist', (done)->
            request
                .post('/login/session')
                .send({username: 'ly', password: 'blablabla'})
                .expect(404)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'User is not found.'
                    done()
        it 'Login fail cuz password is not correct', (done)->
            request
                .post('/login/session')
                .send({username: 'laiy', password: 'blablabla'})
                .expect(400)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'Password is not correct.'
                    done()
        it 'Login successfully', (done)->
            request
                .post('/login/session')
                .send({username: 'laiy', password: 'miac-website'})
                .expect(200)
                .expect("set-cookie", /connect\.sid/)
                .end (err, res)->
                    res.body.result.should.equal 'success'
                    done()
        it 'Login fail cuz user has already login', (done)->
            request
                .post('/login/session')
                .send({username: 'laiy', password: 'miac-website'})
                .expect(409)
                .end (err, res)->
                    res.body.result.should.equal 'fail'
                    res.body.msg.should.equal 'User conflict.'
                    done()








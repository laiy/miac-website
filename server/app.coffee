#	> File Name: app.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 AM10:41:51 CST

express = require 'express'
path = require 'path'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
favicon = require 'static-favicon'
busbody = require "connect-busboy"
session = require 'express-session'
logger = require 'morgan'

db = require './db/db.coffee'
config = require './config.coffee'

#routes
indexRoute = require './routes/index.coffee'
registerRoute = require './routes/register.coffee'
loginRoute = require './routes/login.coffee'

app = express()

app.use favicon()
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use busbody {immediate: true}
app.use express.static(path.join(__dirname, 'public'))
app.use cookieParser()
app.use session {
    secret: config.SECRET_KEY
    resave: yes
    saveUninitialized: yes
}

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use '/', indexRoute
app.use '/register', registerRoute
app.use '/login', loginRoute

db.init()

app.listen 2333

module.exports = app



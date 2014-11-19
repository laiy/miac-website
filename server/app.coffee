#	> File Name: app.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 AM10:41:51 CST

express = require 'express'
path = require 'path'

#routes
indexRoute = require './routes/index.coffee'
registerRoute = require './routes/register.coffee'

app = express()

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use '/', indexRoute

app.listen 2333

module.exports = app


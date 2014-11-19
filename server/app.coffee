express = require 'express'
path = require 'path'

#routes
testRoute = require './routes/test.coffee'

app = express()

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'

app.use '/', testRoute

app.listen 2333


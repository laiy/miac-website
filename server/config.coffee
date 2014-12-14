#	> File Name: config.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Thursday, November 20, 2014 AM11:02:23 CST

config = exports

###
* set process environment
###
if not process.env.NODE_ENV
    process.env.DEBUG = "miac-website"
    process.env.NODE_ENV = "DEV"

###
* set database url
###
config.TEST_DB_URI = "mongodb://localhost/mocha-test"
config.PRODUCTION_DB_URI = "mongodb://localhost/miac-website"
config.SECRET_KEY = "-a052-31av5-4s2voo17sjasf-j2-s"


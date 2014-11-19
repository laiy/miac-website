#	> File Name: util.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM05:38:24 CST

crypto = require 'crypto'

util = exports

util.encrypt = (str)->
    sha1 = crypto.createHash 'sha1'
    sha1.update str
    sha1.digest 'hex'

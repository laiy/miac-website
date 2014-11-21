#	> File Name: authorization.coffee
#	> Author: LY
#	> Mail: ly.franky@gmail.com
#	> Created Time: Wednesday, November 19, 2014 PM03:00:57 CST

authorization = exports

authorization.requireLogin = (req, res, next)->
    if not req.session.user
        res.status(401).json {result: 'fail', msg: 'Please log in first.'}
    else
        next()

authorization.checkUserConflict = (req, res, next)->
    if req.session and req.session.user
        res.status(409).json {result: 'fail', msg: 'User conflict.'}
    else
        next()


const {format} = require('timeago.js'),
    helpers = {}

helpers.timeago = timestamp =>format(timestamp)
module.exports= helpers
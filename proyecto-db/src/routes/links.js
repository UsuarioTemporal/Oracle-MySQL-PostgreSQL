const express = require('express'),
    router = express.Router(),
    // pool = require('../database')
    pool = require('../database')
pool.then(console.log).catch(console.log)
module.exports = router
const express = require('express'),
    morgan = require('morgan'),
    app = express()

// settings

app.set('port',process.env.PORT || 8000)

// middlewares : son funciones que se ejecutan cada vez que un cliente envia una petiticon al servidor
app.use(morgan('dev'))

// global variables


// routes

// public

//starting the server
app.listen(app.get('port'),()=>console.log(`escuchando en el puerto ${app.get(`port`)}`))
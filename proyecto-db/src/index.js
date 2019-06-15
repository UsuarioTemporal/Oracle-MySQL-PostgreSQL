const express = require('express'),
    morgan = require('morgan'),
    app = express()

// settings

app.set('port',process.env.PORT || 8000)

// middlewares : son funciones que se ejecutan cada vez que un cliente envia una petiticon al servidor
app.use(morgan('dev'))
app.use(express.urlencoded({extended:false})) // esto sirve para poder aceptar los datos que me envia el usuario desde los formularios
app.use(express.json())
// app.use(express.static(`${__dirname}/public`))

app.set('view engine','pug')

// global variables
//app.use((req,res,next)=>{

  //  next() // para continuar con el resto de codigo
//})

// routes
app.use(require('./routes'))
//app.use(require('./routes/authentication'))
//app.use(require('/links','./routes/links'))

// public
//app.use(express.static())


//starting the server
app.listen(app.get('port'),()=>console.log(`escuchando en el puerto ${app.get(`port`)}`))
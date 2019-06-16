const express = require('express'),
    router = express.Router(),
    // pool = require('../database')
    pool = require('../config/database'),
    {isLoggedIn}=require('../lib/auth')
// pool.then(console.log).catch(console.log)

router.get('/',(req,res)=>{
    res.render('home')
})
.post('/login',async (req,res)=>{
    const {email,pass} = req.body
    const result = await pool
    // console.log(req.body)
    try{
        const SQL = `select * from table(authenticationUser('${email}','${pass}'))`
        const data = await result.execute(SQL)
        res.redirect('/about')
        
    }catch(err){
        res.redirect('/')
    }finally{
       // await result.close()
    }
    
})
.get('/about',isLoggedIn,async (req,res)=>{
    res.render('about')
})

module.exports = router

/**
 * express-session : administra las sesiones de nuestra app . será
 *  necesario para autentuificar a un usuario más tarde, una session
 *  viene a ser para guardar un dato en la memoria dek servidor
 * 
 * 
 * morgan : permite crear logs o mensajes de uqe es lo que las
 *  aplicaciones clientes estan pediendo al sevidor
 * 
 * passport : es un módulo para autentificar, y manejar el proceso de 
 * login de un usuario en nuestra app
 * 
 * passport-local : es un complemento de passport para autentificar a los
 *  usuarios con nuestra propia base de datos
 * 
 * timeago.js : convierte los timestamps o fechas de la bd en un formato 
 * de : 2 minutes ago, 2 hours ago -- nos servira en las vistas
 * 
 * connect-flash :
 * los usuarios para mostrar mensajes de error y exito cuyando el usuario 
 * 1realice una operacion
 * 
 * express-validator : es un  módulo para validar los datos que el
 *  usuario nos envia desde la aplicacion cliente
 */
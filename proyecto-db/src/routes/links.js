const express = require('express'),
    router = express.Router(),
    // pool = require('../database')
    pool = require('../config/database'),
    {isLoggedIn}=require('../lib/auth')
// pool.then(console.log).catch(console.log)

router.get('/',(req,res)=>{
    res.render('home')
})
.get('/signIn',(req,res)=>{
    res.render('signIn')
})
.get('/signUp',(req,res)=>{
    res.render('signUp')
})
.post('/signIn',async (req,res)=>{
    const {email,pass} = req.body
    const result = await pool
    // console.log(req.body)
    try{
        const SQL = `select * from table(authenticationUser('${email}','${pass}'))`
        const data = await result.execute(SQL)
        let id = data.rows[0][0]
        let profile = data.rows[0][3]
        res.redirect(`/user?id=${id}&profile=${profile}`)
    }catch(err){
        res.redirect('/signIn')
    }
})
.post('/signUp',async (req,res)=>{
    const {email,pass,name,patternalSurname,matternalSurname,dni,phoneNumber} = req.body
    console.log(req.body)
    const result = await pool
    try{
        const SQL = `BEGIN 
                    INSERTUSER('${name}'
                        ,'${patternalSurname}'
                        ,'${matternalSurname}'
                        ,'${dni}','${phoneNumber}'
                        ,'${email}','${pass}',2);
                    COMMIT;
                    END;`;
        const data = await result.execute(SQL)
        res.redirect('/signIn')
    }catch(err){
        console.log(err)
        res.redirect('/signUp')
    }
})
.get('/user',async (req,res)=>{
    console.log(req.query)
    res.render('user',{})
})

module.exports = router

/**
 * 
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
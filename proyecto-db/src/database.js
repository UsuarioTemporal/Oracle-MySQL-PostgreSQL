const oracle = require('oracledb'),
    {promisify}=require('util'),
    {database} = require('./keys'),
    print = console.log

// lo que hace es tener una "ESPECIE" de "HILOS" que se iran ejecutando 
// y cada uno irá haciendo una tarea a la vez en sequencia , esto nos ayudara en produccion

const pool = oracle.createPool(database);

pool.getConnection((err,connection)=>{
    if (err) print(`Algo fallo ${err.code} ${err.message}`)
    connection.release()
    return
})
pool.query = promisify(pool.query)
module.exports = pool
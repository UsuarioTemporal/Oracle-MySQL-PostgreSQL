const oracle = require('oracledb'),
    {promisify}=require('util'),
    {database} = require('./keys'),
    print = console.log,
    SQL = `SELECT * FROM user_table`

// lo que hace es tener una "ESPECIE" de "HILOS" que se iran ejecutando 
// y cada uno irá haciendo una tarea a la vez en sequencia , esto nos ayudara en produccion

// const pool = oracle.createPool(database);

oracle.getConnection(database,(err,connection)=>{
    if (err) return print(`Algo fallo ${err.code} ${err.message}`)
    // connection.release()
    connection.execute(SQL,(err,result)=>{
        if (err) return console.log('Ocurrio un error '+err.message)
        console.log(result.rows)
        connection.close(err=>{
            if(err) return console.log(err.message)
        });
        
    })
    print('Conectado')
    return
})
// oracle.query = promisify(oracle.query)
module.exports = oracle
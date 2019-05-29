const oracle = require('oracledb'),
    {promisify}=require('util'),
    {database} = require('./keys'),
    print = console.log,
    SQL = `SELECT * FROM client`

// const pool = oracle.createPool(database)
// pool.then(e=>e.getConnection())
const fnOracle = async ()=>{
    const pool = await oracle.createPool(database)
    pool.getConnection((err,connection)=>{
            if (err) return print(`Algo fallo ${err.code} ${err.message}`)
            // connection.release()
            connection.execute(SQL,(err,result)=>{
                console.log(result.rows)
                connection.close(err=>{
                    if(err) return console.log(err.message)
                });
            })
            return print('Conectado')
        })

}
fnOracle().then(print).catch(print)
// oracle.getConnection(database,(err,connection)=>{
//     if (err) return print(`Algo fallo ${err.code} ${err.message}`)
//     // connection.release()
//     connection.execute(SQL,(err,result)=>{
//         console.log(result.rows)
//         connection.close(err=>{
//             if(err) return console.log(err.message)
//         });
//     })
//     print('Conectado')
//     return
// })
// oracle.query = promisify(oracle.query)
// print(pool)
module.exports = oracle
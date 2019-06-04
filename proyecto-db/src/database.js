const oracle = require('oracledb'),
    {promisify}=require('util'),
    {database} = require('./keys'),
    print = console.log,
    SQL = `SELECT * FROM client`

// const pool = oracle.createPool(database)
// pool.then(e=>e.getConnection())
const fnOracle = async ()=>{
    const pool = await oracle.createPool(database)
    let connection = await pool.getConnection()
    let result = await connection.execute(SQL)
    let data = result.rows
    connection.close().then(()=>console.log('cerrado exitosamente ')).catch(err=>console.log(err.message))
    return data
}

module.exports = fnOracle()

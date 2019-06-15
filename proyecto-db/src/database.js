const oracle = require('oracledb'),
    {promisify}=require('util'),
    {database} = require('./keys'),
    print = console.log,
    SQL = `SELECT * FROM user_table`

// const pool = oracle.createPool(database)
// pool.then(e=>e.getConnection())
const fnOracle = async ()=>{
    const pool = await oracle.createPool(database)
    let connection = await pool.getConnection()
    let result = await connection.execute(SQL)
    
    let data = result.rows
    await connection.close()
    return data
}

module.exports = fnOracle()
fnOracle().then(data=>print(data)).catch(err=>print(`Error de la base de datos es : ${err.message}`))
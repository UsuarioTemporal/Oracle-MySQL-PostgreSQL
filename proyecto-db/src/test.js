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
    return result.rows
}
fnOracle().then(print).catch(print)
module.exports = oracle
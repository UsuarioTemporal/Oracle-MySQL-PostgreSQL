const oracle = require('oracledb'),
    {database} = require('./keys')

// lo que hace es tener una "ESPECIE" de "HILOS" que se iran ejecutando 
// y cada uno irá haciendo una tarea a la vez en sequencia , esto nos ayudara en produccion

oracle.createPool(database);
- A: Atomicity – Atomicidad -> Separar las funciones desarrolladas en la BD como pequeñas tareas y 
  ejecutarlas como un todo. Si alguna tarea falla se hace un rollback(Se deshacen los cambios)
- C: Consistency – Consistencia -> Todo lo que se desarrolló en base al objeto relacional. Los datos 
  tienen congruencia
- I: Isolation – Aislamiento -> Varias tareas ejecutándose al mismo tiempo dentro de la BD
- D: Durability – Durabilidad -> Puedes tener seguridad que la información no se perderá por un 
  fallo catastrófico. PostgreSQL guarda la información en una Bitácora

Por qué PostgreSQL

    Tipos de Datos
    Integridad de Datos
    Concurrencia. Rendimiento
    Fiabilidad, recuperación ante desastres
    Seguridad
    Extensibilidad
    Internacionalización, Búsqueda de texto.

`psql -U postgres`

RESUMEN

    ENTRAR A LA CONSOLA DE POSTGRES
    psql -U postgres -W
    VER LOS COMANDOS \ DE POSTGRES
    \?
    LISTAR TODAS LAS BASES DE DATOS
    \l
    VER LAS TABLAS DE UNA BASE DE DATOS
    \dt
    CAMBIAR A OTRA BD
    \c nombre_BD
    DESCRIBIR UNA TABLA
    \d nombre_tabla
    VER TODOS LOS COMANDOS SQL
    \h
    VER COMO SE EJECTUA UN COMANDO SQL
    \h nombre_de_la_funcion
    CANCELAR TODO LO QUE HAY EN PANTALLA
    Ctrl + C
    VER LA VERSION DE POSTGRES INSTALADA, IMPORTANTE PONER EL ';'
    SELECT version();
    VOLVER A EJECUTAR LA FUNCION REALIADA ANTERIORMENTE
    \g
    INICIALIZAR EL CONTADOR DE TIEMPO PARA QUE LA CONSOLA TE DIGA EN CADA EJECUCION ¿CUANTO DEMORO EN EJECUTAR ESA FUNCION?
    \timing
    LIMPIAR PANTALLA DE LA CONSOLA PSQL
    Ctrl + L


A través de la sentencia (PGADMIN->tootl->query tool, luego el siguiente comando) SHOW CONFIG_FILE se nos muestra donde están los archivos de configuración. En mi caso la ruta es:
/Library/PostgreSQL/12/data/postgresql.conf

Algo a tener en cuenta es que en la ruta por default de instalación no se puede acceder debido a falta de permisos. Para ingresar basta con un:

sudo cd /Library/PostgreSQL/12/data/

Postgresql.conf: Configuración general de postgres, múltiples opciones referentes a direcciones de conexión de entrada, memoria, cantidad de hilos de pocesamiento, replica, etc.

pg_hba.conf: Muestra los roles así como los tipos de acceso a la base de datos.

pg_ident.conf: Permite realizar el mapeo de usuarios. Permite definir roles a usuarios del sistema operativo donde se ejecuta postgres.


![alt](img/0j8zbxmc.jpg)

- https://platzi.com/blog/que-es-ddl-dml-dcl-y-tcl-integridad-referencial/
- https://todopostgresql.com/diferencias-entre-ddl-dml-y-dcl/
- https://todopostgresql.com/comandos-de-transacciones-en-postgresql/
- https://platzi.com/blog/el-apagon-de-platzi-migramos-de-mysql-a-postgresql/

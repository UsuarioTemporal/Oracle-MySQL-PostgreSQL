select username from dba_users;

select * from user_tables;

CREATE USER db_pruebas IDENTIFIED by prueba 
default tablespace;

grant dba to db_pruebas;

alter user db_pruebas account unlock;
alter user db_pruebas account lock;

desc dba_users;

select table from user_table order by tabla_naem;

create user ventas identified by "123"
    default tablespace "USERS"
    temporary tablespace "TEMP";
    GRANT ALL PRIVILEGES TO ventas;

-- conectarse 

    conn ventas/123;
/*
    esquema :  DESCRIBE LA ESTRUCTURA DE LA BASE DE DATOS.
    UN ESQUEMA DEFINE SUS TABLAS , SUS CAMPO EN CADA TZBLA Y LAS RELACIONES ENTRE CADA CAMPO Y CADA TABLA.

    Un esquema representa la configuracion lógica de todo o parte de una base de datos relacional.

    Puede existir de dos formas : como representacion visual y como un conjunto de formulas conocidas como restricciones de integridad que controlan una base de datos.Esta formulas se expresan en un lenguaje  de definicion de datos , tal como SQL.

*/

/*

    Un schema(Esquema) son los conjuntos de objetos que le pertenecen a un user
    Namespace : Espacio de nombre : un grupo de tipo de objetos
*/


-- para conectarse a la base de datos de otro servidor con la misma red local

sqlplus users/pass@192.168.1.1
select * from tab;
exp full=y file=d:\ventas.dmp

exp ventas/123 full=y file=d:\ventas.dmp;
sY>s 
sY>s
-- La secuencia (sequence) se emplea para generar valores enteros secuenciales únicos y asignarlos a cmapos numéricos ;  se utilizan generalmente para las clves primarias de las tablas garantizando que sus valores no se repitam
create sequence nombre_secuencia
    start with valorentero
    increment by valor enteros
    maxvalue valor enteros
    minvalue valorentero
    cycle


/*
    Las secuencias son tablas; por lo tanto se accede a ellas mediante consultas, empleado "select".La diferencia es que utilizamos pseudocolumnas para recuperar el valor actual y el siguiente de la secuencia.
*/

ALTER USER hr ACCOUNT UNLOCK IDENTIFIED BY hr;

-- Operador quote (q)
/*
    Funciona para establecer tu propio marcador de citas
    se puede seleccionar cualquier delimitador
    incrementa el uso  y la lectura


    Simplemente para poder colocar comillas en una expresion
*/

select last_name || q'[ Departament's Manager id : ]' || manager_id as Despartaments from employees ;
'

-- SELECT * FROM employees;

-- desc employees;
-- select last_name || job_id as "empleado" from employees;

select last_name || ' is a ' || job_id as nombres from employees;
select last_name || q'[ Departament's Manager id : ]' || manager_id as Despartaments from employees ;
-- select DISTINCT country from employees;
select * from countries;
'

-- la tabla DUAL es un tabla especial de una sola columna presente de manera predeterminada en todas las instalaciones de base de datos de oracle. Se utiliza para seleccionar una pseudocolumna como sysdate o user  . la tabla tiene una sola columna varhcar2(1)

select 1+1 from dual;
select user from dual;
select sysdate from dual;
select 'hola mundo' from dual;

select initcap('asdasda') from dual;
select length('asdasd') from dual;
select substr('asdasd',0,5) from dual; 


select instr('abc','c') from dual; -- 3

select replace('abca','a','A') from dual; -- a se cambiara por A

select round(45.926,2) as Redondea from dual; -- 45.93
select trunc(59.926,2) as Trunca from dual; -- 59.92
select mod(1600,300) as residuo from dual; -- 100

select last_name from employees hire_date<'01-FEB-88';
select sysdate from dual;
select current_date from dual;

/*
    limpiar pantalla con oracle sql plus clear screen
*/

SELECT NVL(comision,0) as comision from empleados; -- si la comision es nulo ce cambia por cero

SELECT NVL2(nombre,'Tengo nombre','no tengo nombre') as nombres from empleados; -- 



SELECT CASE 
WHEN campo_1 > campo_2 THEN 'mayor' ELSE 'menor' END AS resultado 
FROM tabla


nullif("","") -- recibe dos parametros , si son iguales retorna un null y si no retorna el primer valor 

select decode(job_id,'1',1.2.
                    '2',1.54);
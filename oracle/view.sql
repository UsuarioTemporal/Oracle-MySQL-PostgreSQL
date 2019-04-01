-- vistas 

/*las vistas es una consulta que se presenta como una tabla(virtual) a partir de un conjunto de tablas en una base de datos relacional.La vista solo almacena la definicion , no los datos.


    Se usa para restringir el acceso a datos
    Para crear consultas complejas
    Proveer datos independientes
    Presentar diferentes vistas de los mismos datos
*/
create [or replace] [force | noforce] view view -- force : crea la vista asi las tablas que se este trabajando dentro de la vista no exista
--noforce : solo crea la vista cuando las tabalas que esten relacionadas existan y este es por defecto
as alias_view 

create or replace view empleadoview as 
select employee_id,last_name,salary from employees where departamento_id=80;

desc empleadoview;
select * from empleadoview;


create or replace view dept_sum_vu(name,minsalario,maxsalario,avgsalario) -- esto de aqui es el alias
as select d.department_name ,min(e.salary),max(e.salary),avg(e.salary) 
from employees as e join departments as d
on e.department_id = d.department_id group by d.department_name


-- la clausula WITH CHECK OPTION
/*
puede asegurarse que una operacion DML sobre la vista este en dominio de la misma vista, usando esta clausula
*/
create or replace view empvu20
as select *
    from employees
    where department_id=20
    with check option constraint empvu20_ck;
/*
Cualquier intento de INSERT o UPDATE de fila con un departament_id diferente de 20, flla por que villa el constraint
*/

-- la clausula WITH READ ONLY

/*
    se puede asegurar que ninguna operacion DML ocurra agregando la opcion WITH READ ONLY en la definicion de la vista.
*/

--índices

/*
    - es un objeto de esquema
    - es usado por el oracle server para acelerar la busqueda de los datos usando un  apuntador
    - Para reducir las entradas y salidas (I/O) usando un método para localizar datos rápidamente
    - es dependiente sobre la tabla que fue creado el índice

Cuando se crean los índices

- Automaticamente : clave primaria o una restriccion única
- manualmente : Definidos por el usuario
*/



-- sinonimos

/*
simplificar el acceso a los objetos creando sinonimos
*/
create [public] synonym nombreSinonimo for object; -- public : todos los usuarios tienen acceso a ese sinonimo
create synonym d_sum for dep_sum_vu;
select * from d_sum;
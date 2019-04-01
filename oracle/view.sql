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
-- secuencias 

--indices 

-- sinonimos
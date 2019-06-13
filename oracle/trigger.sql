/**
hoy en dia existen tres tipos de triggers , que son 
de tipo dml
- insert
- update
- delete

de tipo ddl
- create
- drop
...

de tipo database
- logon
- shotdown
*/

create or replace trigger tg_reg_AI
after insert on regions
begin
    insert into log_table values('Insersion en la tabla de regiones',user);
end;
/
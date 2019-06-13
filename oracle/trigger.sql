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

create or replace trigger trg_reg_AI
after insert on regions
begin
    insert into log_table values('Insersion en la tabla de regiones',user);
end;
/

-- impedir operaciones en los trigger
-- para controlar que no se grabe en la fila

-- solo el usuario hr pueda ingresar registros a la tabla
create or replace trigger trg_reg_BI
before insert on regions
begin
    --impedir que sys inserte filas
    if user<>'hr' then
        raise_application_error(-20000,'solo hr puede insertar en la tabla region');
    end if;

end;
/
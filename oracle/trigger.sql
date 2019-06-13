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

--trigger que dispara muchos eventos

create or replace trigger trg_reg_BIUD 
before insert or update or delete on regions
begin
    if user<>'hr' then
        raise_application_error(-20000,'solo hr puede insertar o actualizar o eliminar en la tabla regions');
    end if;
end;
--pero imaginemos que solo queremos disparar el evento en el caso de una columna(solo es posible para los insert) 
create or replace trigger trg_reg_BIUD
before insert or update of region_id delete on regions -- que este pendiente si queremos modificar el id de la tabla region
begin
    if user<>'HR' then
        raise_application_error(-20000,'solo hr puede insertar o eliminar o actualizar en la columna region_id en la tabla regions')
    end if;

end;
/
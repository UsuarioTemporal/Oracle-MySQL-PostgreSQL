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
--pero imaginemos que solo queremos disparar el evento en el caso de una columna(solo es posible para los update) 
create or replace trigger trg_reg_BIUD
before insert or update of region_id delete on regions -- que este pendiente si queremos modificar el id de la tabla region
begin
    if user<>'HR' then
        raise_application_error(-20000,'solo hr puede insertar o eliminar o actualizar en la columna region_id en la tabla regions')
    end if;

end;
/

-- controlar evento

create or replace trigger trg_reg_BIUD
before insert or update of id_region delete on regions
begin
    if inserting then
        insert into log_table values ('se hizo una inserción',user); 
    end if;
/*
    if updating then -- updating('id_region')
        insert into log_table values ('se hizo una actualización',user);
    end if;*/
    if updating('id_region') then
        insert into log_table values ('se hizo una actualización en id_region',user);
    end if;
    if updating('name_regin') then
        insert into log_table values ('se hizo una actualización en name_region',user);
    end if;
    if deleting then
        insert into log_table values('Se hizo una elimación',user);
    end if;
end;
/ 

drop trigger trg_reg_BIUD;


-- trigger de tipo row es que se dispara por cada fila de la operacion
create or replace trigger trg_region
before insert or update or delete 
on regions for each row
begin
    if inserting then
        :new.region_name:=upper(:new.region_name);
        insert into log_table values ('insercion',user);
    end if;
    if updating('region_name') then
        :new.region_name:=upper(:new.region_name);
        insert into log_table values ('update',user);
    end if;
    if updating('region_id') then
        insert into log_table values ('update',user);
    end if;
    if deleting then
        insert into log_table values('delete',user);
    end if;
end;
/
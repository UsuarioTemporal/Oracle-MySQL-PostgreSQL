# bloques anidados
declare
    x number := 10;
begin
    DBMS_OUTPUT.PUT_LINE(x); -- PARA PODER VER ESTO SE NECESITA EL MODO DEPURACION ACTIVO
    -- para poder activarlo desde sql developer -- view -> salida de dbms -> + (para activar el modo depuracion)
    begin
        DBMS_OUTPUT.PUT_LINE(x);
    end;
    begin
        DBMS_OUTPUT.PUT_LINE(x);
    end;
end;

begin
    select username from dba_users;
end;

begin
    null;
end;

# variables
declare
    salario number(2):=100;
    nombre varchar2(100):='Pedro Rodrigues';
    fecha_nacimiento date:='16-jun-1989';
begin
    salario:=salario*10
    if salario>1000 then
        bla bla bla bla :v
    end if;
end;

DECLARE 
    nombre varchar2(100);
BEGIN
    select first_name into nombre from employees where employee_id=100;
    DBMS_OUTPUT.put_line(nombre);
END; 

DECLARE 
    nombre varchar2(100);
    apellido varchar2(100);
BEGIN
    select first_name,last_name into nombre,apellido from employees where employee_id=100;
    DBMS_OUTPUT.put_line(nombre || ' '||apellido);
END; 
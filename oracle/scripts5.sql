/*
    NO_DATA_FOUND
    TOO_MANY_ROWS
    INVALID_CURSOR
    ZERO_DIVIDE
*/
declare
    empleados employees%rowtype;
begin
     select * into empleados from employees;
     -- select * into empleados from employees where employee_id=10000000;
    exception 
        when TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Demasiadas filas devueltas');
        when NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Ninguna fila');
end; 


declare
    mi_exception exception;
    -- asociar mi excepcion con un determinado error de oracle
    pragma EXCEPTION_INIT(mi_exception,-00001);-- hacer cosas en precompilacion
begin
    insert into departments values (1,'asdasd',1.2);
    exception mi_exception THEN
        DBMS_OUTPUT.PUT_LINE('CLAVE PRIMARIA DUPLICADA');
end;

DECLARE 
    ex1 EXCEPTION;
    CURSOR c1 IS SELECT * FROM employees;
BEGIN
    FOR empleados IN c1 LOOP
        IF empleados.salary>1000 THEN
            RAISE ex1;
        end if;
    END LOOP;
    EXCEPTION 
        when ex1 then 
            DBMS_OUTPUT.PUT_LINE('Hay un empleado que gana mas de 1000');
END;
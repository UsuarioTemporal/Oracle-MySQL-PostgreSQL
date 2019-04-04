/*
    NO_DATA_FOUND
    TOO_MANY_ROWS
    INVALID_CURSOR
    ZERO_DIVIDE
    DUP_VAL_ON_INDEX
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
    -- asociar mi excepcion con un determinado error de oracle CPN PRAGMA
    pragma EXCEPTION_INIT(mi_exception,-00001);-- hacer cosas en precompilacion, 
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

DECLARE 
    ex1 EXCEPTION;
    CURSOR c1 IS SELECT * FROM employees;
    empleados c1%type;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO empleado;
        EXIT WHEN C1%NOTFOUND;
        BEGIN
            IF empleados.salary>1000 then
                RAISE ex1;
            END IF;
            EXCEPTION
                WHEN ex1 THEN -- SI NO ES LA EXCEPTION PASA AL BLOQUE PRINCIPAL
                    DBMS_OUTPUT.PUT_LINE('El empleado '|| empleados.first_name || ' gana mas de 1000 '|| empleados.salary);
        END;
    END LOOP;
    CLOSE c1;
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('OTRO ERROR');
END;


BEGIN
    INSERT INTO departments VALUES (10,'ASD',1.1);
EXCEPTION
    WHEN OTHER THEN
        DBMS_OUTPUT.PUT_LINE('CODIGO DE ERROR : '|| SQLCODE);
        DBMS_OUTPUT.PUT_LINE('MENSAJE DEL ERROR: '|| SQLERRM);
END;


declare 
    region regions%rowtype;
    reg_control regions.region_id%type;
begin
    region.region_id:=100;
    region.region_name := 'Africa';
    select region_id into reg_control from regions
    where region_id=region.region_id;
    DBMS_OUTPUT.PUT_LINE('La region ya existe');
exception
    when NO_DATA_FOUND then
        INSERT INTO regions VALUES (region.region_id,region.region_name);
        COMMIT ;
end;
--procedures
--function
--packages
--triggers


/*
    CREA EL OBJETO
        CODIGO FUENTE
        CODIGO PSEUDO-COMPILADO
*/

CREATE OR REPLACE PROCEDURE pro_1
IS
    x NUMBER:=10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('HOLA MUNDO');
END; 
-- maneras de llamar a el procedimiento
CALL pro_1();
EXECUTE pro_1();
set SERVEROUTPUT on
begin
    pro_1;
end;
/

-- plus
/*para ver cuantos objetos tenemos en nuestra base de datos de la conexion particular*/
SELECT OBJECT_TYPE,COUNT(*) FROM USER_OBJECTS
GROUP BY OBJECT_TYPE;


CREATE OR REPLACE PROCEDURE calc_p3
(empl_id IN employees.employee_id%TYPE,porc in number)
as 
    sal number:=0;
    conver number:=0;
begin
    IF porc<0 OR porc >60 THEN
        RAISE_APPLICATION_ERROR(-20000, 'eL PORCENTAJE DEBE SER MAYOR QUE CERO Y MENOR QUE 60');
    END IF;
    SELECT SALARY INTO SAL FROM employees WHERE employee_id=empl_id;
    conver:= sal*porc/100;
    DBMS_OUTPUT.PUT_LINE('Salario normal '||sal);
    DBMS_OUTPUT.PUT_LINE('Salario con '||porc||'% es : '|| conver);
    EXCEPTION 
     when no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('nO EXISTE EL EMPLEADO');
end;
/
EXECUTE calc_p3(105,25);
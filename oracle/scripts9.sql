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
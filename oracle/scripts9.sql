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
CALL pro_1();
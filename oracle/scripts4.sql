# cursores
/*
    son zonas de memoria donde oracle almacena entre otras cosas las filas que recuperamos de los comandos sql
*/

/*
    Un cursor es una instrucción SELECT que define dentro de la sección de declaración de su código PLSQL.Técnicamente los cursores son fragmentos de memoria reservados para procesar los resultados de una coleccion SELECT.
*/
-- cursores implícitos
declare
    x varchar2(100);
begin
    SELECT nombre /* <-- este seria un cursor implicito */ into x from emepelados where codigo=1;
end;

/*
Los cursores implícitos disponen de una serie de atributos
    SQL%FOUND -- devuelve TRUE si el comando SQL ha devuelto al menos una fila
    SQL%NOTFOUND --  devuelve TRUE si el comando SQL no ha devuetlo ninguna fila
    SQL%ROWCOUNT  -- Numero de filas devueltas o procesadas por la operación
*/

DECLARE
    nom ejemplo.nombre%type;
BEGIN
    SELECT nombre INTO nom FROM ejemplo WHERE codigo=1;
    DBMS_OUTPUT.PUT_LINE(nom);
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('devolvio al menos una fila');
    ELSIF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('No devolvio ninguna fila');
    else 
        DBMS_OUTPUT.PUT_LINE('Soy por las puras :v');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
    UPDATE ejemplo SET nombre='asdasd';
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
END;

/*
Cursores explicitos
Nos permiten trabajar con multiples registros al mismo tiempo
*/
declare 
    cursor  nombre_cursor is select * from employees;
    empleados employees%rowtype;
begin
open nombre_cursor;

-- primera fila
fetch nombre_cursor into empleados;
DBMS_OUTPUT.PUT_LINE(empleados.first_name)
--segunda fila
fetch nombre_cursor into empleados;
DBMS_OUTPUT.PUT_LINE(empleados.first_name)
close nombre_cursor;
end;
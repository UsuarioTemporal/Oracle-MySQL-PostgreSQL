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
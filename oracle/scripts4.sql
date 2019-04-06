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


declare
    cursor nombre_cursor is select * from employees;
    empleados employees%ROWTYPE;
begin
    OPEN nombre_cursor;
    LOOP
        FETCH nombre_cursor INTO empleados;
        EXIT WHEN nombre_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(empleados);
    END LOOP;
    CLOSE nombre_cursor;
end;

DECLARE
    CURSOR nombre_cursor IS SELECT * FROM employees;
    -- empleados employees%ROWTYPE;
BEGIN
    FOR empleados in nombre_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(empleados)
        DBMS_OUTPUT.PUT_LINE(empleados.first_name)
    END LOOP;
END;


DECLARE
    CURSOR nombre_cursor IS SELECT * FROM employees WHERE department_id=30;
    empleados nombre_cursor%ROWTYPE;
BEGIN
    OPEN nombre_cursor;
    LOOP
        FECTH nombre_cursor INTO empleados;
        EXIT WHEN nombre_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(empleados);
        DBMS_OUTPUT.PUT_LINE(empleados.first_name)
    END LOOP;
    CLOSE nombre_cursor;
END;

DECLARE
    CURSOR nombre_cursor(cod_dep NUMBER) IS SELECT * FROM employees WHERE department_id=cod_dep;
    empleados nombre_cursor%ROWTYPE;
BEGIN
    OPEN nombre_cursor(30); -- (&cod)
    LOOP
        FECTH nombre_cursor INTO empleados;
        EXIT WHEN nombre_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(empleados);
        DBMS_OUTPUT.PUT_LINE(empleados.first_name)
    END LOOP;
    CLOSE nombre_cursor;
END;

SET SERVEROUTPUT ON;
declare
  vdescripcion VARCHAR2(50);
begin
  SELECT DESCRIPCION INTO vdescripcion from PAISES WHERE CO_PAIS = 'ESP';
  dbms_output.put_line('La lectura del cursor es: ' || vdescripcion);
end;

DECLARE
  r ARTICULOS%ROWTYPE;
BEGIN
  FOR r IN ( SELECT * FROM ARTICULOS ) LOOP
    DBMS_OUTPUT.PUT_LINE(r.cArtDsc);
  END LOOP;
END;

BEGIN
  UPDATE ARTICULOS SET cArtDsc = 'Pantalla LCD' WHERE cCodArt = 'LCD';
  IF SQL%NOTFOUND THEN -- Otra opción : SQL%ROWCOUNT = 0
    INSERT INTO ARTICULOS (cCodArt,cDesArt)
    VALUES (‘LCD’,’Pantalla LCD’);
  END IF;
END;


/*
    Cursores de actualizacion :
    Los cursores de actualizacion son muy importante para realizar validaciones rápidas y toma de desiciones en una misma sentencia
*/
CURSOR nombre_cursor IS
    instruccion_SELECT
FOR UPDATE;

UPDATE tbla SET campo1=... WHERE CURRENT OF nombre_cursor;

/* 
    IMPORTANTE : Cuando trabajamos con cursores de actualización debemos tener en cuenta que la sentencia UPDATE genera bloqueos en la base de datos(transacciones,disparadores)
*/

---------------------------------------------------------------
-- Actualizar el nombre de los paises con tres puntos seguidos 
---------------------------------------------------------------

DECLARE
    CURSOR cur_paises IS 
        SELECT cod_pais , nombre_pais , cod_continente FROM pais 
    FOR UPDATE;

    tb_paises cur_paises%ROWTYPE;
BEGIN
    OPEN cur_paises;
    FETCH cur_paises INTO tb_paises;
        WHILE cur_paises%FOUND LOOP
            UPDATE pais SET nom_
        END LOOP;
    CLOSE cur_paises;
    COMMIT;
END;


DECLARE 
    CURSOR cur_paises IS
        SELECT * FROM countries 
    FOR UPDATE;
    tb_tempo_paises cur_paises%ROWTYPE;
BEGIN
    OPEN cur_paises;
    FETCH cur_paises INTO tb_tempo_paises; -- aquí se habre el cursor por primera vez
    WHILE cur_paises%FOUND LOOP
        UPDATE countries SET country_name=tb_tempo_paises.country_name || '...' 
        WHERE CURRENT OF cur_paises;
        FETCH cur_paises INTO tb_tempo_paises; -- aquí se comienza la segundo y asi toda la iteración
    END LOOP;
    CLOSE cur_paises;
END;

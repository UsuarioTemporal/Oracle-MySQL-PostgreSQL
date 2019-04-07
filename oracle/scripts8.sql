-- Collection 
    /*
        En pocas palabras una coleccion es un set de elementos donde se alamcenas elementos del mismo tipo

        Existen tre de esto :
            INDEX-BY TABLES or ARRAY ASOCIATIVOS
    */

-- varray
    -- TAMAÑO FIJO
CREATE OR REPLACE TYPE nombre_array IS VARRAY(N) OF tipo;

--------------------------------------------------------
declare
    TYPE est_array IS varray(5) OF VARCHAR2(10);
    TYPE calificaciones_array IF VARRAY(5) OF INTEGER;
    estudiantes est_array;
    calificaciones calificaciones_array;
    total INTEGER;
BEGIN
    estudiantes:=est_array('Thom','Carlos','Pepe','Tito','Jacinto :v');
    calificaciones :=calificaciones_array(10,20,15,15,20);
    total:=estudiantes.COUNT;
    FOR i IN 1..total LOOP
        DBMS_OUTPUT.PUT_LINE('STUDENT '|| estudiantes(i)|| ' nota : '|| calificaciones(i));
    END LOOP;
END;
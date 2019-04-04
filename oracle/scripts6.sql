-- colecciones y tipos compuestos
-- son componenetes que pueden albergar múltiples valores a diferencia de los escalares que solo pueden guardar un valor
-- set SERVEROUTput on ESTE COMANDO REDIRIGE LA SALIDA DEL BDMS HACIA LA SALIDA ESTANDAR
/*
    Son de dos tipos :

    - records 
        Es un objeto que tiene una fila , una columna de distintos tipos
        Son muy similares a los registros de una tabla
        %rowtype
    - collections
        guardar valores del mismo tipo pero muchos
        - array asociativos (index by)
        - nested tables
        - varrays
*/

-- record
TYPE empleado IS RECORD (
    nombre VARCHAR2(100),
    salario NUMBER,
    fecha employees.hire_date%TYPE,
    datos_completos employees%ROWTYPE
);
emple1 empleado;

SET SERVEROUTput ON
DECLARE
    TYPE empelado IS RECORD (
        nombre VARCHAR2(100),
        salario NUMBER,
        fecha employees.hire_date%TYPE,
        datos_completos employees%ROWTYPE
    );
    emple1 empleado;
BEGIN
    SELECT * INTO emple1.datos_completos FROM
    employees WHERE employee_id=100;
    emple1.nombre:= emple1.datos_completos.first_name || ' '|| emple1.datos_completos.last_name;
    emple1.salario:=emple1.datos_completos.salary*0.08;
    emple1.fecha:=emple1.datos.hire_date;
    --DBMS_OUTPUT.PUT_LINE(emple1); no se puede imprimir todo este objeto , tiene que ser algunos de sus valores
    DBMS_OUTPUT.PUT_LINE(emple1.datos.first_name);
END;
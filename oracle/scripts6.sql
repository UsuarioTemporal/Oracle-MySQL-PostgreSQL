-- colecciones y tipos compuestos
-- son componenetes que pueden albergar múltiples valores a diferencia de los escalares que solo pueden guardar un valor

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
    datos completos employees%ROWTYPE
);
emple1 empleado;
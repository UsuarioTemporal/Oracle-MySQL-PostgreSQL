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
    TYPE empleado IS RECORD (
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
    emple1.fecha:=emple1.datos_completos.hire_date;
    --DBMS_OUTPUT.PUT_LINE(emple1); no se puede imprimir todo este objeto , tiene que ser algunos de sus valores
    DBMS_OUTPUT.PUT_LINE(emple1.datos_completos.first_name);
END;


create table  regiones as select * from regions where region_id=0;
declare
    reg1 regions%ROWTYPE;
BEGIN
    SELECT * INTO reg1 FROM regions WHERE region_id=1;
    INSERT INTO regiones values (reg1);
END;
/

declare
    reg1 regions%ROWTYPE;
BEGIN
    reg1.region_id:=1;
    reg1.region_name := 'Australia';
    UPDATE regiones set row=reg1 where region_id=1;
end;
/

-- Collections y tipos compuestos
    -- arrays asociativos(index by tables) no tienen tamaño
        -- son colecciones pl/sql con dos columnas
        -- clave primaria de tipo entero o cadena
        -- valores  : un tipo que puede ser escalar , o record

TYPE departamentos IS TABLE OF 
    departaments.departament_name%TYPE
INDEX BY PLS_INTEGER; -- binary_integer | varchar2(x)

TYPE empleados IS TABLE OF
    employees%ROWTYPE -- complejo
INDEX BY PLS_INTEGER;

depts departamentos;
empls empleados;

/*
    Acceso al array
        Para acceder al array usamos ARRAY(n)
        Si es de un tipo complejo, por ejemplo empleados, usamos
        array(n).campo
*/

-- tipo  simple

depts(1):='Informatica';
depts(2):='RRHH';
DBMS_OUTPUT.PUT_LINE(depts(1));
DBMS_OUTPUT.PUT_LINE(depts(2));

-- tipo compuesto

select * into empls(1) from employees where employee_id=100;
DBMS_OUTPUT.PUT_LINE(empls(1).first_name);

/*
    COLECCIONES Y TIPOS COMPUESTOS
        MÉTODOS DE LOS ARRAYS
            EXISTS(N) : DETECTAR SI EXISTE UN ELEMENTO
            COUNT : NÚMERO DE ELEMENTOS
            FIRST : DEVUELVE EL ÍNDICE MAS PEQUEÑO
            LAST : DEVULEVE EL ÍNDICE MAS ALTO
            PRIOR(N) : DEVUELVE EL ÍNDICE ANTERIOR A N
            NEXT(N) : DEVUELVE EL ÍNDICE POSTERIOR A N
            DELETE : BORRA TODO
            DELETE(N) : BORRAR EL ÍNDICE N
            DELETE(M,N) : BORRA DE LOS ÍNIDICES M A N
*/

DBMS_OUTPUT.PUT_LINE(depts.LAST);
DBMS_OUTPUT.PUT_LINE(depts.FIRST);
IF depts.EXISTS(2) THEN
    DBMS_OUTPUT.PUT_LINE(depts(3));
ELSE
    DBMS_OUTPUT.PUT_LINE('VALOR INEXISTENTE');
END IF;


DECLARE
    TYPE departamentos IS TABLE OF
        departments.department_name%TYPE
    INDEX BY PLS_INTEGER;
    depts departamentos;
BEGIN
    depts(1):='Informatica';
    DBMS_OUTPUT.put_line(depts(1));
END;


declare
    TYPE departaments IS TABLE OF
        departments%ROWTYPE
    INDEX BY PLS_INTEGER;
    depts departamentos;
BEGIN
    FOR indice IN 1..10 LOOP
        SELECT * INTO depts(indice) FROM departaments WHERE departament_id
        =index*10;
    END LOOP;

    FOR indice IN depts.FIRST..depts.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(depts(indice));
    END LOOP;
END;
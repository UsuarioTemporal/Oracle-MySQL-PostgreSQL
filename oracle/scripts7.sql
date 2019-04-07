-- 1-Hacer un programa que tenga un cursor que vaya visualizando los salarios de los empleados. Si en el cursor aparece el jefe (Steven King) se debe generar un RAISE_APPLICATION_ERROR indicando que el sueldo del jefe no se puede ver.
DECLARE
    CURSOR cur_jefe IS SELECT (first_name || ' '|| last_name) AS nombre,salary 
    FROM employees ;
    --tab_temp_emple cur_jefe%ROWTYPE;
    ex_steve EXCEPTION;
BEGIN
    FOR tab_temp_emple IN cur_jefe LOOP
        IF TRIM(tab_temp_emple.nombre) LIKE 'Steven King' THEN
            --RAISE_APPLICATION_ERROR(-20000, tab_temp_emple.nombre|| ' privado' );
            CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE( tab_temp_emple.nombre||' : '||  tab_temp_emple.salary );
    END LOOP;
END;
-- 2-Hacemos un bloque con dos cursores. (Esto se puede hacer fácilmente con una sola SELECT pero vamos a hacerlo de esta manera para probar parámetros en cursores)


-- el primero de empleados
-- El segundo de departamentos que tenga como parámetro el MANAGER_ID
-- Por cada fila del primero, abrimos el segundo curso pasando el ID del MANAGER
-- Debemos pintar el Nombre del departamento y el nombre del MANAGER_ID
-- Si el empleado no es MANAGER de ningún departamento debemos poner “No es jefe de nada”

DECLARE
    CURSOR cur_empl IS SELECT * FROM employees;
    CURSOR cur_dep(manager_id_cur departments.manager_id%TYPE) IS 
    SELECT * FROM departments WHERE manager_id=manager_id_cur;
    info departments%ROWTYPE;
BEGIN
    FOR tab_tem_empl IN cur_empl LOOP
        OPEN cur_dep(tab_tem_empl.manager_id);
        FETCH cur_dep INTO info;
        IF cur_dep%NOTFOUND THEN
            DBMS_OUTPUT.PUT_LINE(tab_tem_empl.first_name|| ' no es jefe de nada');
            
        ELSE 
            DBMS_OUTPUT.PUT_LINE(tab_tem_empl.first_name|| ' '||info.department_name);
        END IF;
        CLOSE cur_dep;
    END LOOP;
END;

-- 3-Crear un cursor con parámetros que pasando el número de departamento visualice el número de empleados de ese departamento

-- no es necesario los cursores
SELECT COUNT(*) as 'Numero_empleados' FROM employeeS
WHERE DEPARTMENT_ID=30;

SELECT
    e.first_name,d.department_id,d.department_name
FROM
    employees e,(select * from departments where department_id=30) d
where e.department_id=d.department_id;


-- 4-Crear un bucle FOR donde declaramos una subconsulta que nos devuelva el nombre de los empleados que sean ST_CLERCK. Es decir, no declaramos el cursor sino que lo indicamos directamente en el FOR.
BEGIN
    FOR empl IN(SELECT * FROM employees WHERE job_id='ST_CLERK') LOOP
        DBMS_OUTPUT.PUT_LINE(empl.first_name);
    END LOOP;
END;



-- 5-Creamos un bloque que tenga un cursor para empleados. Debemos crearlo con FOR UPDATE.

-- Por cada fila recuperada, si el salario es mayor de 8000 incrementamos el salario un 2%
-- Si es menor de 800 lo hacemos en un 3%
-- Debemos modificarlo con la cláusula CURRENT OF
-- Comprobar que los salarios se han modificado correctamente.
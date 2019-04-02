-- bloques anidados
declare
    x number := 10;
begin
    DBMS_OUTPUT.PUT_LINE(x); -- PARA PODER VER ESTO SE NECESITA EL MODO DEPURACION ACTIVO
    -- para poder activarlo desde sql developer -- view -> salida de dbms -> + (para activar el modo depuracion)
    begin
        DBMS_OUTPUT.PUT_LINE(x);
    end;
    begin
        DBMS_OUTPUT.PUT_LINE(x);
    end;
end;

begin
    select username from dba_users;
end;

begin
    null;
end;

-- variables
declare
    salario number(2):=100;
    nombre varchar2(100):='Pedro Rodrigues';
    fecha_nacimiento date:='16-jun-1989';
begin
    salario:=salario*10
    if salario>1000 then
        bla bla bla bla :v
    end if;
end;

DECLARE 
    nombre varchar2(100);
BEGIN
    select first_name into nombre from employees where employee_id=100;
    DBMS_OUTPUT.put_line(nombre);
END; 

DECLARE 
    nombre varchar2(100);
    apellido varchar2(100);
BEGIN
    select first_name,last_name into nombre,apellido from employees where employee_id=100;
    DBMS_OUTPUT.put_line(nombre || ' '||apellido);
    DBMS_OUTPUT.put_line(UPPER(nombre || ' '||apellido));
END; 

declare
    x number:=2;
begin
    if x=1 then
        DBMS_OUTPUT.PUT_LINE('Es uno');
    elsif x=2 then
        DBMS_OUTPUT.PUT_LINE('Es dos');
    else 
        DBMS_OUTPUT.PUT_LINE('otro');
    end if;
end;


declare
    x number:=2;
begin
    case x
        when 100 then
            DBMS_OUTPUT.PUT_LINE('100');
        when 2 then
            DBMS_OUTPUT.PUT_LINE('2');
        else
            DBMS_OUTPUT.PUT_LINE('otro');
    end case;
end;


declare
    contador number:=1;
begin
    loop
        DBMS_OUTPUT.put_line(contador);
        contador:=contador+1;
        exit when contador=10;
    end loop;
end;

declare
    contador number:=1;
begin
    while contador <=10 loop
        DBMS_OUTPUT.put_line(contador);
        contador:=contador+1;
    end loop;
end;

begin 
    for contador in 1..10 loop
    -- for contador in reverse 1..10 loop
    end loop;
end;


declare
    contador number :=0;
begin
    <<loop_inicial>>
    loop
        contador:=contador+1;
        DBMS_OUTPUT.put_line(contador || ' inicial');
        exit when contador>10;
        <<loop_anidado>>
        loop 
            contador:=contador+1;
            DBMS_OUTPUT.put_line(contador || ' anidado');
            exit loop_inicial when contador=5;
        end loop loop_anidado;
        
    end loop loop_inicial;
end;

declare 
    contador number:=1;
    pasos number:=1;
begin
    loop
        exit when pasos=5;
        DBMS_OUTPUT.put_line(pasos || ' : ' || contador);
        contador:=contador+1;
        if contador=4 then
            contador:=1;
            pasos:=pasos+1;
            continue;
        end if;
    end loop;
end;

/*
    VARCHAR está reservado Oracle para admitir la distinción entre NULL cadena vacía en el futuro, como ANSI prescribe el estándar.

VARCHAR2 no distingue entre a NULL y cadena vacía, y nunca lo hará.Es decir que si ingresas una cadena vacia o si no ingresas nada al usar varchar2 lo tomara igual

Si confías en una cadena vacía y NULL eres la misma cosa, debes usar VARCHAR2.

*/

/*

    Diferencias entre date y timestamp(marca de tiempo)

    Diferencia
*/

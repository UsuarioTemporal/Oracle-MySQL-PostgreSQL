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
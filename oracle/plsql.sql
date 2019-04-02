# bloques anidados
declare
    x number := 10;
begin
    DBMS_OUTPUT.PUT_LINE(x); -- PARA PODER VER ESTO SE NECESITA EL MODO DEPURACION ACTIVO
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
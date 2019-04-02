# bloques anidados
declare
    x number := 10;
begin
    DBMS_OUTPUT.PUT_LINE(x);
    begin
        DBMS_OUTPUT.PUT_LINE(x);
    end;
    begin
        DBMS_OUTPUT.PUT_LINE(x);
    end;
end;
--fibonacci 1 
set serveroutput on
declare
    prev number:=0;
    pos number:=1;
    numberInput number;
    temp number:=0 ;
    string_numbers varchar2(1000):='';
    total number:=0;
begin
    numberInput := &numberInput;
    for val in 1..numberInput loop
        if val=numberInput then
            string_numbers:=string_numbers|| prev|| '='||total;
            DBMS_OUTPUT.PUT_LINE(string_numbers);
            exit;
        end if;
        string_numbers:=string_numbers|| prev|| '+';
        temp := prev+pos;
        total :=total+pos;
        prev:=pos;
        pos:=temp;
    end loop;
end;
/

-- fibonacci 2
declare
    prev number:=0;
    pos number:=1;
    numberInput number;
    temp number:=0 ;
    string_numbers varchar2(1000):='';
    total number:=0;
begin
    numberInput := &numberInput;
    while numberinput>total loop
        
        string_numbers:=string_numbers||prev||'+';
        temp := prev+pos;
        total :=total+pos;
        prev:=pos;
        pos:=temp;
        if total>=numberinput then 
            string_numbers:=string_numbers||prev||'='||total;
            exit;
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE(string_numbers);
end;
/

-- palindromo
declare 
    word_str varchar2(100);
    reverse_word varchar2(100);
begin
    word_str:=&otro; --'otro'
    for letter in reverse 1..length(word_str) loop
        reverse_word:=reverse_word||SUBSTR(word_str, letter, 1);
    end loop;
    if word_str = reverse_word then
        DBMS_OUTPUT.PUT_LINE('si es');
        return;
    end if;
    DBMS_OUTPUT.PUT_LINE('no es');
end;
/
--capicua

declare
begin
end;
/

--mcm


--mcd


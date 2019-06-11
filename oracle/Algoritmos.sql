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
    numberInput number;
    reverseNumber number:=0;
    temp number;
begin
    numberInput:=&numberInput;
    temp :=numberInput;
    while temp>0 loop
        reverseNumber :=mod(temp,10) + reverseNumber*10;
        temp:=(temp-mod(temp,10))/10;
    end loop;
    if numberInput=reverseNumber then
        DBMS_OUTPUT.PUT_LINE('Es capicua');
        return;
    end if;
    DBMS_OUTPUT.PUT_LINE('no es capicua');
end;
/
-- primo sin rangos
declare
    numberInput number;
    
begin
    numberinput:=&number;
    for val in 2..(numberInput-1) loop
        if mod(numberInput,val)=0 then
            DBMS_OUTPUT.PUT_LINE('No es primo');
            return;
        end if;
     end loop;
     DBMS_OUTPUT.PUT_LINE('Es primo');
end;
/
--primos con rangos

declare
    rangeA number;
    rangeB number;
    flag boolean;
begin
    rangeA:=&firstRange;
    rangeB:=&secondRange;
    
    for val in rangeA..rangeB loop
        flag:=true;
        for val2 in 2..(val-1) loop
            if mod(val,val2)=0 then
                flag:=false;
                exit;
            end if;
        end loop;
        if flag=true and val>1 then
            DBMS_OUTPUT.PUT_LINE(val|| ' es primo');
        end if;
    end loop;
end;

--problema ruso
/*En una olimpiada rusa se propuso el siguiente problema: 
Si escribimos todos los números enteros empezando por el uno,
uno al lado del otro (o sea, 1234567891011121314…), ¿qué dígito ocupa la posición 206788?*/



--palabra pentavocalica


--mcm


--mcd



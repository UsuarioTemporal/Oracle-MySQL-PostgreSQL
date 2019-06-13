create or replace trigger trg_region_BIUD
on regions 
for each row
when (new.region_id>100)
begin
    --toda la logica
end;

/

--estado del trigger

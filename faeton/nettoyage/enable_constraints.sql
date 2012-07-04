declare
-- pour avoir les cles primaires avant les cles etrang.
cursor c_constraint is select * from user_constraints a order by constraint_type;
--where status <> 'ENABLED' and table_name <> 'R_FONCTION'
-- and not exists(select * from user_constraints b where b.constraint_name = a.r_constraint_name and b.table_name = 'R_FONCTION')
requete varchar2(1000);
v_constraint_name varchar2(1000);
begin
for n_constraint_name in c_constraint
LOOP
  begin
  requete := 'alter table ' || n_constraint_name.table_name || ' enable constraint ' || n_constraint_name.constraint_name;
  v_constraint_name := n_constraint_name.constraint_name;
  -- dbms_output.put_line('constraint name:' || requete);
  -- dbms_output.put_line('constraint name:' || n_constraint_name.constraint_name);
  execute immediate requete;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE ('No Data found for SELECT on ');
  WHEN OTHERS THEN
    dbms_output.put_line('constraint name:' || v_constraint_name);
    -- RAISE;
  END;
END LOOP ;
end;
/
quit;

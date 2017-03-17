CREATE OR REPLACE PROCEDURE act_costo IS
tmpVar NUMBER;
ln_costo NUMBER;
CURSOR C1  IS
select it_codigo from in_movim where mv_costo = 0 ;

BEGIN

  for reg1 in  c1 loop
  
  select it_costo into ln_costo from in_item where it_codigo = reg1.it_codigo;
  update in_movim set mv_costo = ln_costo where it_codigo = reg1.it_codigo;
    
  end loop;

   tmpVar := 0;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END act_costo;



/

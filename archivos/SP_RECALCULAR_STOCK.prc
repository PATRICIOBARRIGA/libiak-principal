CREATE OR REPLACE PROCEDURE DINAMIC.SP_RECALCULAR_STOCK IS
tmpVar NUMBER;
v_stockbodega   in_itebod.ib_stock%TYPE;
v_stocksucursal  in_itesucur.it_stock%TYPE;


CURSOR c_inbode IS 
SELECT it_codigo,em_codigo,su_codigo,bo_codigo
FROM   IN_ITEBOD
WHERE em_codigo = '1' 
ORDER BY su_codigo,bo_codigo,it_codigo;


CURSOR c_itsucur IS
SELECT it_codigo,em_codigo,su_codigo
FROM IN_ITESUCUR
WHERE em_codigo = '1'
ORDER BY su_codigo,it_codigo;

/*---------------------------------------------------------------------------------*/

BEGIN
   tmpVar := 0;
   v_stockbodega := 0;
   v_stocksucursal := 0;
   
   for reg1  in c_inbode loop
   
                select nvl(sum(decode(tm_ioe,'I',nvl(mv_cantid,0),'E',nvl(mv_cantid,0) * -1,0)),0)
                into v_stockbodega
                from in_movim
                where em_codigo = reg1.em_codigo
                and su_codigo = reg1.su_codigo
                and bo_codigo = reg1.bo_codigo
                and it_codigo  = reg1.it_codigo;
                            
                IF SQL%NOTFOUND THEN
                    v_stockbodega := 0;
                END IF; 
                                       
                update in_itebod
                set ib_stock = v_stockbodega
                where em_codigo = reg1.em_codigo
                and su_codigo = reg1.su_codigo
                and bo_codigo = reg1.bo_codigo
                and it_codigo = reg1.it_codigo;
     
   end loop; 
   
   
   for reg2 in c_itsucur loop
                select nvl(sum(decode(tm_ioe,'I',mv_cantid,'E',mv_cantid * -1,0)),0)
                into v_stocksucursal
                from in_movim
                where em_codigo = reg2.em_codigo
                and su_codigo = reg2.su_codigo
                and it_codigo  = reg2.it_codigo;
                
                if SQL%NOTFOUND then
                v_stocksucursal := 0;
                end if;
                                  
                update in_itesucur
                set it_stock = v_stocksucursal, 
                     it_stkreal = v_stocksucursal,
                     it_stkdis = v_stocksucursal
                where em_codigo = reg2.em_codigo
                and su_codigo = reg2.su_codigo
                and it_codigo = reg2.it_codigo;
                
   end loop;
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       ROLLBACK;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
      ROLLBACK;
END SP_RECALCULAR_STOCK;
/


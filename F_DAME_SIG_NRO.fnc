CREATE OR REPLACE FUNCTION DINAMIC.F_DAME_SIG_NRO (av_empresa varchar,av_sucursal varchar, tipo varchar) RETURN NUMBER IS
ll_num NUMBER;
lch_si VARCHAR(1);

BEGIN
  -- tmpVar := 0;
   
select pr_sucursal into lch_si from pr_param where em_codigo = av_empresa and pr_nombre = tipo;


If lch_si = 'S' then
    select ps_valor into ll_num from pr_numsuc  where em_codigo = av_empresa and su_codigo = av_sucursal and pr_nombre = tipo ;
    update pr_numsuc  set ps_valor = ps_valor + 1 where em_codigo = av_empresa  and su_codigo = av_sucursal  and pr_nombre = tipo;
else
    select pr_valor   into ll_num from pr_param  where em_codigo = av_empresa  and pr_nombre = tipo;
    update pr_param set pr_valor = pr_valor + 1  where em_codigo = av_empresa  and pr_nombre = tipo;
End if;
    
return ll_num;
   

   
   
   
   
   
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END F_DAME_SIG_NRO;
/


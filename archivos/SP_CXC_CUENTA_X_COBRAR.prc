CREATE OR REPLACE PROCEDURE DINAMIC.SP_CXC_CUENTA_X_COBRAR (av_empresa varchar2, av_sucursal varchar2, av_seccion varchar2, an_venumero NUMBER,av_escodigo varchar2, av_caja VARCHAR2,av_errmsg out varchar2)IS

tmpVar NUMBER;
ld_fecemifac DATE;
ld_fecven  DATE;
ln_venumero NUMBER;
ln_plazo NUMBER;
ln_numpag NUMBER;
ln_vevalpag NUMBER;
ln_veneto NUMBER;
ln_abono NUMBER;
ln_abono_total NUMBER := 0;
lv_cecodigo VARCHAR2(20);
lv_mtcodigo VARCHAR2(20);
lv_mtcodcre VARCHAR2(20);
lv_ifcodigo VARCHAR2(20);
lv_fpcodigo VARCHAR2(20);
lv_leyenda VARCHAR2(100);
ld_fecefec DATE;
lv_chnumero VARCHAR2(20);
lv_chcuenta VARCHAR2(20);
lv_secue VARCHAR2(20);
i NUMBER;
errmsg VARCHAR2(200);

/*
Dependiendo de la forma de pago se genera la o las cuentas por cobrar y
se realiza el abono y cruce de la  o las cuentas
*/
--select fp_plazo,fp_numpag into ln_plazo,ln_numcuotas from fa_formpag where em_codigo = av_empresa and  fp_codigo = reg1.fp_codigo;



BEGIN
   tmpVar := 0;

      --Obtener datos de la factura
       SELECT VE_NUMERO,VE_FECHA,VE_VALPAG,VE_NETO,CE_CODIGO,VE_LEYENDA INTO ln_venumero,ld_fecemifac, ln_vevalpag,ln_veneto,lv_cecodigo,lv_leyenda FROM FA_VENTA WHERE ES_CODIGO = av_escodigo and em_codigo = av_empresa and su_codigo = av_sucursal and bo_codigo = av_seccion and ve_numero = an_venumero;
      --av_cecodigo := lv_cecodigo;
      -- Crea cuenta por cobrar  
        SELECT FA_RECPAG.FP_CODIGO, FA_FORMPAG.FP_PLAZO ,FA_FORMPAG.FP_NUMPAG,  max(RP_FECVEN)
        into lv_fpcodigo, ln_plazo, ln_numpag, ld_fecven  
        FROM FA_RECPAG , FA_FORMPAG 
        WHERE    FA_RECPAG.FP_CODIGO = FA_FORMPAG.FP_CODIGO AND FA_RECPAG.ES_CODIGO = av_escodigo AND FA_RECPAG.EM_CODIGO = av_empresa   AND FA_RECPAG.SU_CODIGO = av_sucursal AND  FA_RECPAG.BO_CODIGO = av_seccion AND FA_RECPAG.VE_NUMERO = an_venumero
        group by FA_RECPAG.FP_CODIGO, FA_FORMPAG.FP_PLAZO ,  FA_FORMPAG.FP_NUMPAG,RP_FECHA;
        
       for i in 1..ln_numpag loop
       lv_mtcodigo := f_dame_sig_nro(av_empresa,av_sucursal,'NUM_ND');
       --Determinar la fecha de vencimiento de la factura
         
           
       INSERT INTO  CC_MOVIM (  TT_CODIGO  ,  TT_IOE   ,  EM_CODIGO ,  SU_CODIGO ,  MT_CODIGO ,  CE_CODIGO  ,  ES_CODIGO  ,  BO_CODIGO  ,  VE_NUMERO  ,  MT_VALOR   ,  MT_FECHA   ,  MT_VALRET  ,  MT_SALDO,MT_FECVEN  )
       VALUES('1','D',av_empresa,av_sucursal,lv_mtcodigo,lv_cecodigo,av_escodigo,av_seccion,an_venumero,ln_vevalpag,ld_fecemifac,ln_veneto*.12,ln_vevalpag, ld_fecven );
       end loop;
   
       
        
  
  --Actualiza el saldo del movimiento de debito 
      update cc_movim  set mt_saldo = mt_saldo - nvl(ln_abono_total,0)   where em_codigo = av_empresa  and su_codigo = av_sucursal  and tt_codigo = '1'  and tt_ioe = 'D' and mt_codigo = lv_mtcodigo; 

      --Actualiza saldo del cupo del cliente
      update fa_clien SET CE_SALCRE = CE_SALCRE - ln_abono_total    WHERE CE_CODIGO = lv_cecodigo AND EM_CODIGO = av_empresa;
   
    -- Actualiza el secuencial de la caja
      update fa_caja   set cj_ticket = cj_ticket + 1 where em_codigo = av_empresa and su_codigo = av_sucursal and cj_caja = av_caja;
  
 av_errmsg := 'Procesado correctamente';  
                 
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
      av_errmsg := ' No encuentro datos para procesar';
     -- NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
     --  dbms_output.put_line ( 'Un error encontrado '||SQLCODE||' '||SUBSTR(SQLERRM,1,200));       
     ROLLBACK; 
    av_errmsg := SQLERRM;
      -- RAISE;
END SP_CXC_CUENTA_X_COBRAR;
/


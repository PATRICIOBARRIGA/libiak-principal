DROP PROCEDURE DINAMIC.SP_CXC_ANULACIONCREDITO;

CREATE OR REPLACE PROCEDURE DINAMIC.SP_CXC_ANULACIONCREDITO  (av_empresa varchar2, av_sucursal varchar2, av_ttcodigo varchar2,av_ttioe varchar2,av_mtcodigo  varchar2 ) IS


TYPE  t_cruce  IS TABLE OF CC_CRUCE%ROWTYPE;
v_debitos    t_cruce;

lc_creditos NUMBER(16,4);
errmsg VARCHAR2(1000);
BEGIN
   
   --Elimina todos los reg  con NRO de  credito = av_mtcodigo
   --Un mov de credito puede cruzar varios mov de debito
   --Ejm:Un pago abona varias facturas
   
   -- Almacenamos en una tabla temporal los registros que van a ser eliminados para luego actualizar el saldo de los debitos que han sido eliminados
   
SELECT  TT_CODDEB  , TT_IOEDEB, MT_CODDEB , TT_CODIGO, TT_IOE  , EM_CODIGO, SU_CODIGO, MT_CODIGO, CR_FECHA, CR_VALDEB,CR_VALCRE,ESTADO,CH_NUMERO 
BULK COLLECT INTO v_debitos
FROM CC_CRUCE
WHERE EM_CODIGO = av_empresa
AND SU_CODIGO = av_sucursal
AND TT_CODIGO = av_ttcodigo
AND TT_IOE = av_ttioe
AND MT_CODIGO = av_mtcodigo;
    
--Inicia el borrado
DELETE FROM CC_CRUCE
WHERE em_codigo = av_empresa
AND su_codigo  = av_sucursal
AND tt_codigo = av_ttcodigo
AND tt_ioe = av_ttioe
AND mt_codigo = av_mtcodigo;
   
   
   --Elimina el detalle del pago:
   --Ejm: El abono fue realizado con cheque
DELETE FROM CC_CHEQUE
WHERE em_codigo = av_empresa
AND su_codigo = av_sucursal
AND tt_codigo = av_ttcodigo
AND tt_ioe = av_ttioe
AND mt_codigo = av_mtcodigo;
   
   
DELETE FROM CC_MOVIM
WHERE em_codigo = av_empresa
AND su_codigo = av_sucursal
AND tt_codigo = av_ttcodigo
AND tt_ioe = av_ttioe
AND mt_codigo = av_mtcodigo;
   
 
 --Actualiza saldos recorriendo la tabla temporal
 
   FOR i IN v_debitos.FIRST .. v_debitos.LAST LOOP
            begin
                    select sum(NVL(cr_valdeb,0))
                    into lc_creditos 
                    from cc_cruce 
                    where  em_codigo = v_debitos(i).em_codigo 
                    and su_codigo = v_debitos(i).su_codigo
                    and tt_coddeb = v_debitos(i).tt_coddeb
                    and tt_ioedeb = v_debitos(i).tt_ioedeb
                    and mt_coddeb = v_debitos(i).mt_coddeb
                    group by em_codigo,su_codigo,tt_coddeb,tt_ioedeb,mt_coddeb;
                    exception
                    when NO_DATA_FOUND then
                    lc_creditos := 0;
           end;

        UPDATE CC_MOVIM
        SET mt_saldo   =   nvl(mt_valor,0)  - nvl(lc_creditos,0)
        where em_codigo = v_debitos(i).em_codigo
        and su_codigo      = v_debitos(i).su_codigo
        and tt_codigo       = v_debitos(i).tt_coddeb
        and tt_ioe            = v_debitos(i).tt_ioedeb
        and mt_codigo     = v_debitos(i).mt_coddeb;
 
     END LOOP;

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       ROLLBACK;
          errmsg := 'Un error encontrado '||SQLCODE||' '||SUBSTR(SQLERRM,1,200);
       RAISE;
END SP_CXC_ANULACIONCREDITO;
/


DROP PUBLIC SYNONYM SP_CXC_ANULACIONCREDITO;

CREATE OR REPLACE PUBLIC SYNONYM SP_CXC_ANULACIONCREDITO FOR DINAMIC.SP_CXC_ANULACIONCREDITO;


GRANT EXECUTE ON DINAMIC.SP_CXC_ANULACIONCREDITO TO GENERAL_USER;

CREATE OR REPLACE PROCEDURE DINAMIC.SP_INV_DESCARGA_TINTES (av_empresa varchar, av_sucursal varchar, av_bodega varchar ,av_tipomov varchar,av_escodigo varchar,av_nrodocref number ) IS
tmpVar NUMBER;

as_item VARCHAR(20);
ln_nromovim NUMBER;
ls_kit  VARCHAR(2); 
ls_ioe VARCHAR2(1);
ls_movdescri VARCHAR2(50);
ln_costo NUMBER;
ad_cantidad NUMBER;
ls_codigo VARCHAR2(20);
lv_formula VARCHAR2(20);

CURSOR c_detve  IS  
SELECT IT_CODIGO, DV_CANDES,DV_MOTOR FORMULA, DV_CHASIS PRESENTACION  FROM FA_DETVE WHERE ES_CODIGO = av_escodigo and EM_CODIGO = av_empresa AND SU_CODIGO =  av_sucursal AND BO_CODIGO = av_bodega AND VE_NUMERO = av_nrodocref;

CURSOR c_tintes IS
SELECT IN_FORTINTE.IT_CODIGO,IN_FORTINTE.FO_VALOR,IN_ITEM.IT_COSTO FROM IN_FORTINTE , IN_ITEM WHERE IN_FORTINTE.IT_CODIGO = IN_ITEM.IT_CODIGO AND IN_FORTINTE.FO_CODIGO = lv_formula;

BEGIN
   tmpVar := 0;

/*Ingresa mov de los items tanto del kit como del atomo
   actualiza stocks en bodega y sucursal
*/
-- busca si el item es kit o no
 

SELECT TM_IOE,TM_DESCRI INTO ls_ioe, ls_movdescri FROM IN_TIMOV WHERE EM_CODIGO = av_empresa AND TM_CODIGO = av_tipomov;

for reg1 in c_detve loop

lv_formula := null;
lv_formula  := reg1.formula;
ad_cantidad := 0;
ad_cantidad := reg1.dv_candes;

                for reg2 in c_tintes loop

                --Realizar calculo en base a la presentacion para descargar tintes
                CASE reg1.presentacion 
                when 'CANECA' then
                ad_cantidad := reg1.dv_candes*reg2.fo_valor*5;
                when'GALON' then
                ad_cantidad := reg1.dv_candes*reg2.fo_valor*1;
                when 'LITRO' then
                ad_cantidad := reg1.dv_candes*reg2.fo_valor*0.25;
                when 'OCTAVO' then 
                ad_cantidad := reg1.dv_candes*reg2.fo_valor*0.125;
                when 'DIECISEIS' then
                ad_cantidad := reg1.dv_candes*reg2.fo_valor*0.0625;
                when 'TREINTADOS' then
                ad_cantidad := reg1.dv_candes*reg2.fo_valor*0.03125;
                end case;
                -- descarga el stock del item

                update in_itesucur
                set it_stock = it_stock + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0),
                    it_stkreal = it_stkreal + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0),
                    it_stkdis = it_stkdis + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0)
                where it_codigo = reg2.it_codigo
                and em_codigo = av_empresa
                and su_codigo  = av_sucursal;

                -- descarga el stock del item
                update in_itebod
                set ib_stock = ib_stock + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0)
                where it_codigo = reg2.it_codigo
                and em_codigo = av_empresa
                and su_codigo = av_sucursal
                and bo_codigo = av_bodega;

                --Determinar el nro de mov.
                ln_nromovim := 0;
                ln_nromovim :=  F_DAME_SIG_NRO(av_empresa,av_sucursal,'NUM_MINV');

                --Ingresar el mov de inv. tanto si es kit o no
                INSERT INTO IN_MOVIM(TM_CODIGO,TM_IOE,IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,MV_NUMERO,MV_CANTID,MV_COSTO,MV_FECHA,MV_OBSERV,VE_NUMERO,ES_CODIGO,MV_USADO)
                VALUES(av_tipomov,ls_ioe,reg2.it_codigo,av_empresa,av_sucursal,av_bodega,ln_nromovim,ad_cantidad,reg2.it_costo,sysdate,ls_movdescri,av_nrodocref,av_escodigo,'N');

                end loop;
                
end loop;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        NULL;
        WHEN OTHERS THEN
        -- Consider logging the error and then re-raise
        rollback;
        RAISE;
       
       
END SP_INV_DESCARGA_TINTES;
/


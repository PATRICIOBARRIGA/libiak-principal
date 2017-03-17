CREATE OR REPLACE PROCEDURE DINAMIC.SP_FACTURA (av_empresa varchar, av_sucursal varchar, av_bodega varchar ,av_tipomov varchar,av_escodigo varchar,av_nrodocref number, ab_flag out varchar ) IS

ld_costo_atomo NUMBER;
ls_atomo VARCHAR2(20);
ld_cantatomo NUMBER;
lch_kit VARCHAR2(2);
as_item VARCHAR(20);
ln_nromovim NUMBER;
ls_kit  VARCHAR(2); 
ls_ioe VARCHAR2(1);
ls_movdescri VARCHAR2(50);
ln_costo NUMBER;
ad_cantidad NUMBER;
ln_stock NUMBER;
ls_codigo VARCHAR2(20);


CURSOR c_detve  IS  
SELECT IT_CODIGO, DV_CANDES  FROM FA_DETVE WHERE ES_CODIGO = av_escodigo and EM_CODIGO = av_empresa AND SU_CODIGO =  av_sucursal AND BO_CODIGO = av_bodega AND VE_NUMERO = av_nrodocref;

BEGIN

/*Ingresa mov de los items tanto del kit como del atomo   actualiza stocks en bodega y sucursal */
-- busca si el item es kit o no
 SELECT TM_IOE,TM_DESCRI INTO ls_ioe, ls_movdescri FROM IN_TIMOV WHERE EM_CODIGO = av_empresa AND TM_CODIGO = av_tipomov;

for reg1 in c_detve loop

ls_codigo := null;
ls_codigo  := reg1.it_codigo;
ad_cantidad := 0;
ad_cantidad := reg1.dv_candes;

-- crea y actualiza cuenta
-- controla stock

-- crea nueva factura
    -- selecciona secuencial de la caja
    -- actualiza secuencial de la caja
    -- inserta cabecera de factura
    --inserta detalle de factura
            --por cada item 
                -- controla stock
                -- inserta movs de kit y atomo
                -- actualiza saldos de inv en sucursal
                -- actualiza saldos de inv en bodega
            
SELECT IT_KIT,IT_COSTO INTO lch_kit ,ln_costo FROM IN_ITEM WHERE IT_CODIGO = reg1.it_codigo;

if lch_kit = 'S' then
    --determinar la cantidad relacionada con el atomo
    SELECT IN_ITEM.IT_KIT,IN_ITEM.IT_COSTO,IN_RELITEM.IT_CODIGO, IN_RELITEM.RI_CANTID
    INTO      lch_kit,ld_costo_atomo, ls_atomo, ld_cantatomo
    FROM    IN_ITEM , IN_RELITEM
    WHERE (IN_RELITEM.EM_CODIGO = IN_ITEM.EM_CODIGO) and
    ( IN_RELITEM.IT_CODIGO = IN_ITEM.IT_CODIGO) and
    (  (IN_RELITEM.TR_CODIGO = '1' ) and
    ( IN_RELITEM.IT_CODIGO1 = ls_codigo ) and 
    ( IN_RELITEM.EM_CODIGO = av_empresa ));

  --Validar que exista el stock suficiente
    select nvl(it_stock,0)    into  ln_stock    from in_itesucur    where em_codigo = av_empresa     and su_codigo = av_sucursal    and it_codigo = ls_atomo;
    
     
    if ln_stock  < ad_cantidad * ld_cantatomo then
    ab_flag := 'false';
    exit;
    end if;

    update in_itesucur
    set it_stock = it_stock + decode(ls_ioe,'E', (ad_cantidad * ld_cantatomo)*-1,'I', (ad_cantidad * ld_cantatomo),0),
        it_stkreal = it_stkreal + decode(ls_ioe,'E', (ad_cantidad * ld_cantatomo)*-1,'I', (ad_cantidad * ld_cantatomo),0),
        it_stkdis = it_stkdis + decode(ls_ioe,'E', (ad_cantidad * ld_cantatomo)*-1,'I', (ad_cantidad * ld_cantatomo),0)     
    where it_codigo = ls_atomo     and em_codigo  = av_empresa     and su_codigo   =  av_sucursal;
    
    
    update in_itebod
    set ib_stock = ib_stock + decode(ls_ioe,'E', (ad_cantidad * ld_cantatomo)*-1,'I', (ad_cantidad * ld_cantatomo),0)
    where it_codigo = ls_atomo     and em_codigo = av_empresa     and su_codigo = av_sucursal     and bo_codigo = av_bodega;    
    
    --Determinar el NRO  de mov
    ln_nromovim :=  F_DAME_SIG_NRO(av_empresa,av_sucursal,'NUM_MINV');
    
    --ingresa el mov del item del atomo
    INSERT INTO IN_MOVIM(TM_CODIGO,TM_IOE,IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,MV_NUMERO,MV_CANTID,MV_COSTO,MV_FECHA,MV_OBSERV,VE_NUMERO,ES_CODIGO,MV_USADO)
    VALUES(av_tipomov,ls_ioe,ls_atomo,av_empresa,av_sucursal,av_bodega,ln_nromovim, (ad_cantidad * ld_cantatomo),ld_costo_atomo,sysdate,ls_movdescri,av_nrodocref,av_escodigo,'N');
  
End if ;  


--Validar stock
-- No es kit
  select nvl(it_stock,0)    into  ln_stock    from in_itesucur    where em_codigo = av_empresa     and su_codigo = av_sucursal   and it_codigo = ls_atomo;
    
     
    if ln_stock  < ad_cantidad  then
    ab_flag := 'false';
    exit;
    end if;



-- descarga el stock del item
update in_itesucur
set it_stock = it_stock + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0),
    it_stkreal = it_stkreal + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0),
    it_stkdis = it_stkdis + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0)
where  em_codigo = av_empresa and su_codigo  = av_sucursal and it_codigo = ls_codigo;

-- descarga el stock del item
update in_itebod
set ib_stock = ib_stock + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0)
where it_codigo = ls_codigo and em_codigo = av_empresa and su_codigo = av_sucursal and bo_codigo = av_bodega;

--Determinar el nro de mov.
ln_nromovim := 0;
ln_nromovim :=  F_DAME_SIG_NRO(av_empresa,av_sucursal,'NUM_MINV');

--Ingresar el mov de inv. tanto si es kit o no
INSERT INTO IN_MOVIM(TM_CODIGO,TM_IOE,IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,MV_NUMERO,MV_CANTID,MV_COSTO,MV_FECHA,MV_OBSERV,VE_NUMERO,ES_CODIGO,MV_USADO)
VALUES(av_tipomov,ls_ioe,ls_codigo,av_empresa,av_sucursal,av_bodega,ln_nromovim,ad_cantidad,ln_costo,sysdate,ls_movdescri,av_nrodocref,av_escodigo,'N');

end loop;

EXCEPTION
        WHEN NO_DATA_FOUND THEN
        NULL;
        WHEN OTHERS THEN
        -- Consider logging the error and then re-raise
        rollback;
        RAISE;
       
       
END SP_FACTURA;
/
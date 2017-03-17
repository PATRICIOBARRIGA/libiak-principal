CREATE OR REPLACE PROCEDURE   SP_INV_MOV_INVENTARIO (av_empresa varchar, av_sucursal varchar, av_bodega varchar ,av_tipomov varchar,av_escodigo varchar,av_nrodocref number, ab_flag out varchar2, an_stkreal out number,av_codant out varchar2) IS

ld_costo_atomo NUMBER;
ls_atomo VARCHAR2(20);
ld_equivatomo NUMBER;
lch_kit VARCHAR2(2);
as_item VARCHAR(20);
ln_nromovim NUMBER;
ls_kit  VARCHAR(2); 
ls_ioe VARCHAR2(1);
ls_movdescri VARCHAR2(50);
ln_costo NUMBER;
ad_cantidad NUMBER;
ls_codigo VARCHAR2(20);
ln_stock NUMBER;
ln_stockkit NUMBER;

err_no_stock EXCEPTION;

CURSOR c_detve  IS  
SELECT IT_CODIGO, DV_CANDES  FROM FA_DETVE WHERE EM_CODIGO = av_empresa AND SU_CODIGO =  av_sucursal AND BO_CODIGO = av_bodega and ES_CODIGO = av_escodigo and  VE_NUMERO = av_nrodocref;

BEGIN
   

/*Ingresa mov de los items tanto del kit como del atomo
   actualiza stocks en bodega y sucursal
*/
-- busca si el item es kit o no
 

SELECT TM_IOE,TM_DESCRI INTO ls_ioe, ls_movdescri FROM IN_TIMOV WHERE EM_CODIGO = av_empresa AND TM_CODIGO = av_tipomov and TM_IOE IN ('I','E');

for reg1 in c_detve loop

ls_codigo := null;
ls_codigo  := reg1.it_codigo;
ad_cantidad := 0;
ln_stock := 0;
ad_cantidad := reg1.dv_candes;

SELECT IT_KIT,IT_COSTO,IT_CODANT INTO lch_kit ,ln_costo,av_codant  FROM IN_ITEM WHERE IT_CODIGO = reg1.it_codigo;

if lch_kit = 'S' then

    SELECT "IN_ITEM"."IT_KIT","IN_ITEM"."IT_COSTO", "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID", floor("IN_ITESUCUR"."IT_STOCK"/"IN_RELITEM"."RI_CANTID")
    INTO      lch_kit,ld_costo_atomo, ls_atomo, ld_equivatomo,ln_stock
    FROM    "IN_ITEM" , "IN_RELITEM", "IN_ITESUCUR"
    WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
    ("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
    ("IN_RELITEM"."IT_CODIGO" = "IN_ITESUCUR"."IT_CODIGO") and
    ("IN_ITESUCUR"."EM_CODIGO" = av_empresa) and
    ("IN_ITESUCUR"."SU_CODIGO" = av_sucursal) and
    (  ("IN_RELITEM"."TR_CODIGO" = '1' ) and
    ( "IN_RELITEM"."IT_CODIGO1" = ls_codigo ) and
    ( "IN_RELITEM"."EM_CODIGO" = av_empresa ));


    --verificar q exista  stock del kit en funcion de su atomo para proceder al descargo
      
     if ln_stock < ad_cantidad then
     raise err_no_stock;
     end if;
    
    --actualizar stock siempre que exista 
    update in_itesucur
    set it_stock = it_stock + decode(ls_ioe,'E', (ad_cantidad * ld_equivatomo)*-1,'I', (ad_cantidad * ld_equivatomo),0),
        it_stkreal = it_stkreal + decode(ls_ioe,'E', (ad_cantidad * ld_equivatomo)*-1,'I', (ad_cantidad * ld_equivatomo),0),
        it_stkdis = it_stkdis + decode(ls_ioe,'E', (ad_cantidad * ld_equivatomo)*-1,'I', (ad_cantidad * ld_equivatomo),0)     
    where em_codigo  = av_empresa
    and su_codigo   =  av_sucursal
    and  it_codigo = ls_atomo;
    
    
    update in_itebod
    set ib_stock = ib_stock + decode(ls_ioe,'E', (ad_cantidad * ld_equivatomo)*-1,'I', (ad_cantidad * ld_equivatomo),0)
    where em_codigo = av_empresa
    and su_codigo = av_sucursal
    and bo_codigo = av_bodega
    and it_codigo = ls_atomo;
    
    
    --Determinar el NRO  de mov
    ln_nromovim :=  F_DAME_SIG_NRO(av_empresa,av_sucursal,'NUM_MINV');
    
    
    ls_movdescri := 'Venta del Kit '||av_codant||' Factura No. '||av_nrodocref;
   
    --ingresa el mov del item del atomo
    INSERT INTO IN_MOVIM(TM_CODIGO,TM_IOE,IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,MV_NUMERO,MV_CANTID,MV_COSTO,MV_FECHA,MV_OBSERV,VE_NUMERO,ES_CODIGO,MV_USADO)
    VALUES(av_tipomov,ls_ioe,ls_atomo,av_empresa,av_sucursal,av_bodega,ln_nromovim, (ad_cantidad * ld_equivatomo),ld_costo_atomo,sysdate,ls_movdescri,av_nrodocref,av_escodigo,'N');
  
end if ;  

--verificar q exista sufieiente stock del item para proceder con el descargo
 select it_stock into ln_stock from in_itesucur where su_codigo = av_sucursal and it_codigo = ls_codigo;
 if ln_stock < ad_cantidad  then
raise err_no_stock;
 end if;

-- descarga el stock del item

update in_itesucur
set it_stock = it_stock + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0),
    it_stkreal = it_stkreal + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0),
    it_stkdis = it_stkdis + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0)
where em_codigo = av_empresa
and su_codigo  = av_sucursal
and it_codigo = ls_codigo;

-- descarga el stock del item
update in_itebod
set ib_stock = ib_stock + decode(ls_ioe,'E', ad_cantidad *-1,'I', ad_cantidad,0)
where em_codigo = av_empresa
and su_codigo = av_sucursal
and bo_codigo = av_bodega
and it_codigo = ls_codigo;

--Determinar el nro de mov.
ln_nromovim := 0;
ln_nromovim :=  F_DAME_SIG_NRO(av_empresa,av_sucursal,'NUM_MINV');

--Ingresar el mov de inv. tanto si es kit o no
 ls_movdescri:=  'Factura de Venta No.'||av_nrodocref;

INSERT INTO IN_MOVIM(TM_CODIGO,TM_IOE,IT_CODIGO,EM_CODIGO,SU_CODIGO,BO_CODIGO,MV_NUMERO,MV_CANTID,MV_COSTO,MV_FECHA,MV_OBSERV,VE_NUMERO,ES_CODIGO,MV_USADO)
VALUES(av_tipomov,ls_ioe,ls_codigo,av_empresa,av_sucursal,av_bodega,ln_nromovim,ad_cantidad,ln_costo,sysdate,ls_movdescri,av_nrodocref,av_escodigo,'N');

end loop; 

EXCEPTION
        WHEN err_no_stock THEN     -- Sin stock suficiente
            an_stkreal := ln_stock;
            ab_flag:= 'false';
            rollback;
        WHEN NO_DATA_FOUND THEN
        NULL;
        WHEN OTHERS THEN
        -- Consider logging the error and then re-raise
        rollback;
        RAISE;
        
END SP_INV_MOV_INVENTARIO;
/


GRANT EXECUTE ON SP_INV_MOV_INVENTARIO TO GENERAL_USER;

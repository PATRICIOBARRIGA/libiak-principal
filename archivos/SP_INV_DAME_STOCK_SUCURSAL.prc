CREATE OR REPLACE PROCEDURE DINAMIC.SP_INV_DAME_STOCK_SUCURSAL (as_empresa  varchar,as_sucursal varchar,as_item varchar, ach_kit char, ad_pedido  number, ad_stockreal out NUMBER, ab_flag out varchar2)IS
tmpVar NUMBER;
--ls_codigo_kit  varchar2(1);
ln_stock NUMBER;  --stock disponible

BEGIN
 
  tmpVar := 0;
  ln_stock:= 0;
/*
///////////////////////////////////////////////////////////////////////
// Descripción : Función booleana para saber si hay o no stock en sucursal
//               además devuelve en ad_cantidad lo que existe .
// Encuentra it_stock de la tabla in_itesucur
// Retorna Falso si la cantidad ingresada es mayor al stock.
// Fecha de Ultima Revisión : 04-10-2004   11:22 Por: Edivas
// si es un kit encuentra el stock del kit,de acuerdo al stock de cada 
// componete y del factor que interviene en el componente.
*/

--Es Kit
if ach_kit = 'S' then

    select TRUNC(min(it_stock / ri_cantid))
    into ln_stock
    from in_itesucur x, in_relitem y
    where x.em_codigo = y.em_codigo
    and x.it_codigo = y.it_codigo
    and x.em_codigo = as_empresa
    and x.su_codigo = as_sucursal
    and y.it_codigo1 = as_item
    and y.tr_codigo = '1';

--No es kit
else
    select it_stock
    into  ln_stock
    from in_itesucur
    where em_codigo = as_empresa
    and su_codigo = as_sucursal
    and it_codigo = as_item;
end if;

if ln_stock > 0 then

    if  ad_pedido > ln_stock then
        ad_stockreal := ln_stock;
        ab_flag := 'false';
       -- return false
    else
        ad_stockreal := ad_pedido;
       ab_flag:= 'true';
        --return true
    end if;
else
    ad_stockreal := 0;
    ab_flag:= 'false';
    --return false
end if;




   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END SP_INV_DAME_STOCK_SUCURSAL;
/


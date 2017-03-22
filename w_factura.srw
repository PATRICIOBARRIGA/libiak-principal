HA$PBExportHeader$w_factura.srw
$PBExportComments$Facturas al por mayor
forward
global type w_factura from w_sheet_master_detail
end type
type cb_ubicacion from commandbutton within w_factura
end type
type cb_1 from commandbutton within w_factura
end type
type cb_2 from commandbutton within w_factura
end type
type cb_3 from commandbutton within w_factura
end type
type cb_formpag from commandbutton within w_factura
end type
type dw_sel_numero from datawindow within w_factura
end type
type p_ubicacion from picture within w_factura
end type
type dw_movim from datawindow within w_factura
end type
type dw_consulta_stk from datawindow within w_factura
end type
type p_producto from picture within w_factura
end type
type dw_1 from datawindow within w_factura
end type
type sle_1 from singlelineedit within w_factura
end type
type cb_4 from commandbutton within w_factura
end type
type pb_1 from picturebutton within w_factura
end type
type dw_pedidos from datawindow within w_factura
end type
type st_1 from statictext within w_factura
end type
type st_plazo from statictext within w_factura
end type
type st_2 from statictext within w_factura
end type
type cb_5 from commandbutton within w_factura
end type
type dw_detalle_pago from uo_dw_detail within w_factura
end type
end forward

shared variables

end variables

global type w_factura from w_sheet_master_detail
integer width = 5317
integer height = 1924
string title = "Factura"
long backcolor = 74477680
cb_ubicacion cb_ubicacion
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_formpag cb_formpag
dw_sel_numero dw_sel_numero
p_ubicacion p_ubicacion
dw_movim dw_movim
dw_consulta_stk dw_consulta_stk
p_producto p_producto
dw_1 dw_1
sle_1 sle_1
cb_4 cb_4
pb_1 pb_1
dw_pedidos dw_pedidos
st_1 st_1
st_plazo st_plazo
st_2 st_2
cb_5 cb_5
dw_detalle_pago dw_detalle_pago
end type
global w_factura w_factura

type variables
 dec{2}  ic_iva,ic_descuento,ic_precio,ic_desc1,ic_desc2,ic_desc3
dec{4}  ic_costo
int     il_descue,ii_excento_iva,ii_numli
string  is_mensaje, is_estado='1',is_codant1,is_numpedido
boolean ib_fabricante,ib_detalle_pago, ib_ubica = false,&
		  prod_visible = false, ib_prof_fac = true,ib_nograba = false
datetime id_hoy

end variables

forward prototypes
public function long wf_valida_cliente (string as_cliente, string as_validar)
public function integer wf_preprint ()
public function integer wf_postprint ()
public function integer wf_crea_actualiza_cuenta (string as_clien, string as_banco, string as_numero, decimal ad_valor)
public function integer wf_actualiza_saldo_nc (string as_numnc, decimal ac_valpag)
public function integer wf_nota_credito (string as_cliente, long ai_factura, decimal ai_total, decimal ai_saldo, string as_tipomov)
public function integer wf_encera_pago ()
public function integer wf_suma_pagos ()
public function integer wf_valida_valor_todas_filas ()
public function integer wf_valida_valor (string as_formpag, string as_inst_finan, decimal ac_valor)
public function integer wf_valida_fecha (datetime ad_fecha, string as_fpcodigo, decimal as_rpvalor)
public function integer wf_proforma_factura (long ai_factura)
public function integer wf_controla_stock_bodega (integer num_filas)
public function integer wf_actualiza_saldo_cupo ()
public function integer wf_cambia_precio_desc ()
public function long wf_nota_debito ()
public subroutine wf_insertarfila ()
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, string as_estado, decimal ac_costo, character ach_kit, string as_atomo, decimal ac_costo_atomo, decimal ac_cantatomo, string as_codant, decimal ac_costprom, decimal ac_costtrans)
public function integer wf_procesa_item (string as_codant, integer ai_fila)
public function integer wf_calcula_valores ()
public function integer wf_calcula_valores_en_bucle (integer ai_fila)
end prototypes

public function long wf_valida_cliente (string as_cliente, string as_validar);//////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n :  Permite verificar si se puede facturar al cliente
// Feha de revisi$$HEX1$$f300$$ENDHEX$$n : 12-Feb-1999  (parcial)
//////////////////////////////////////////////////////////////////////

string ls
long ll
CHOOSE CASE as_validar
  CASE 'ce_facturar'
	 //encuentra si se le puede facturar al cliente
	 SELECT CE_FACTURAR
      INTO :ls
      FROM FA_CLIEN
	 WHERE CE_CODIGO = :as_cliente
      AND EM_CODIGO = :str_appgeninfo.empresa;
	  
	 if ls = 'S' or isnull(ls) then
		  return 1
	 else
		  return -1
	end if
CASE 'ce_estcre'
	 SELECT CE_ESTCRE
      INTO :ls
      FROM FA_CLIEN
	  WHERE CE_CODIGO = :as_cliente
       AND EM_CODIGO = :str_appgeninfo.empresa;
	  
	 if ls = 'A' then
		  return 1
	 else
		  return -1
	end if
CASE 'ce_plazo'
	 SELECT CE_PLAZO
      INTO :ll
      FROM FA_CLIEN
	  WHERE CE_CODIGO = :as_cliente
	    AND EM_CODIGO = :str_appgeninfo.empresa;
	  
	  return ll

END CHOOSE

end function

public function integer wf_preprint ();dataWindowChild ldwc_aux
long ll_filActMaestro,ll_ve_numero, ll_plazo,ll_vehiculo
int li_promo, li_montop,li_max,li_suerte,li_stock
string ls_leyenda, ls_codigo, ls_aux,ls_premio,ls_motor,ls_data
dec{2} ld_valor, lc_valpag
date ld_fecha
boolean lb_fabricante

ll_filActMaestro = dw_master.getRow()
ll_ve_numero = dw_master.getItemNumber(ll_filActMaestro, "ve_numero")
lc_valpag = dw_master.getItemdecimal(ll_filActMaestro, "ve_valpag")
ld_fecha = date(dw_master.getItemDateTime(ll_filActMaestro, "ve_fecha"))
ll_vehiculo = dw_detail.find("it_kit = 'V'",1,dw_detail.rowcount())
ls_leyenda = 'FORMA DE PAGO:'
dw_report.SetTransObject(sqlca)

declare pago_cursor cursor for
select  fp_codigo, rp_valor
from    fa_recpag
where  em_codigo = :str_appgeninfo.empresa
and     su_codigo = :str_appgeninfo.sucursal
and     bo_codigo = :str_appgeninfo.seccion
and     es_codigo = :is_estado
and     ve_numero = :ll_ve_numero
order by rp_numero;

Open pago_cursor;
Do
		fetch pago_cursor into :ls_codigo,:ld_valor;
		if sqlca.sqlcode <> 0 then
			exit;
		end if
			select fp_descorta, fp_plazo
			into :ls_aux, :ll_plazo
			from fa_formpag
			where em_codigo = :str_appgeninfo.empresa
			and fp_codigo = :ls_codigo;
		If ll_plazo = 0 then
			ls_leyenda = ls_leyenda + '~n' + ls_aux +' ---> $' + string(ld_valor,"#,##0.00")
		else
			ls_leyenda = ls_leyenda + '~n' + ls_aux + ' ---> $ ' + string(ld_valor,"#,##0.00") &
			                + ' Pague antes de ' + string(RelativeDate(ld_fecha,ll_plazo),'dd/mm/yyyy')
		End if

Loop while TRUE;

Close pago_cursor;

select pr_valor
into :li_promo
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'PROMO';
if sqlca.sqlcode = 100 then
	messagebox("Error en promo","No se ha encontrado el par$$HEX1$$e100$$ENDHEX$$metro promo...comuniquese con sistemas "+sqlca.sqlerrtext,stopsign!)
end if

//empieza el c$$HEX1$$f300$$ENDHEX$$digo de la ventana de premios por aniversario
if li_promo = 1 then

	select pr_valor
	into :li_montop
	from pr_param
	where em_codigo = :str_appgeninfo.empresa
	and pr_nombre = 'MONTOPROMO';
	if sqlca.sqlcode = 100 then
		messagebox("Error en montopromo","No se ha encontrado el par$$HEX1$$e100$$ENDHEX$$metro montopromo...comuniquese con sistemas "+sqlca.sqlerrtext,stopsign!)
	end if

	if lc_valpag >= li_montop and ib_fabricante = true then

			SELECT PE_MAX
			INTO :li_max
			FROM PR_PREMIOS
			WHERE EM_CODIGO = :str_appgeninfo.empresa
			AND SU_CODIGO = :str_appgeninfo.sucursal
			AND PE_CODIGO = 'GRACIAS';			
			if sqlca.sqlcode = 100 then
				messagebox("Error","Problemas al consultar el maximo en pr_premios...comuniquese con sistemas "+sqlca.sqlerrtext,stopsign!)
			end if

			randomize(0)
			li_suerte  = RAND(li_max) 

			SELECT PE_CODIGO
			INTO :ls_premio
			FROM PR_PREMIOS
			WHERE EM_CODIGO = :str_appgeninfo.empresa
			AND SU_CODIGO = :str_appgeninfo.sucursal
			AND PE_MIN <= :li_suerte AND PE_MAX >= :li_suerte;
			if sqlca.sqlcode = 100 then			
				ls_premio = 'GRACIAS'
			end if

			SELECT STOCK
			INTO :li_stock
			FROM PR_PREMIOS
			WHERE EM_CODIGO = :str_appgeninfo.empresa
			AND SU_CODIGO = :str_appgeninfo.sucursal			
			AND PE_CODIGO = :ls_premio;

			if li_stock < 0 then
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Lo siento...El stock para "+ls_premio+" se ha terminado")	
			else
				update PR_PREMIOS
				set stock = stock - 1
				where EM_CODIGO = :str_appgeninfo.empresa
				and SU_CODIGO = :str_appgeninfo.sucursal
				and PE_CODIGO = :ls_premio;
				
				ls_leyenda = ls_leyenda + '   ' + ls_premio
		
			end if
	end if
end if


Update fa_venta
set    ve_leyenda = :ls_leyenda
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and bo_codigo = :str_appgeninfo.seccion
and es_codigo = :is_estado
and ve_numero = :ll_ve_numero;

commit;
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
                                is_estado, ll_ve_numero)

  
//dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
 //                          is_estado, ll_ve_numero)

if ll_vehiculo > 0 then
	dw_report.modify("DataWindow.detail.Height=190")
else
	dw_report.modify("DataWindow.detail.Height=64")
end if
dw_report.modify("datawindow.print.preview.zoom=75~t" + &
					   "datawindow.print.preview=yes")

				
return 1

end function

public function integer wf_postprint ();cb_formpag.VISIBLE = TRUE
RETURN 1
end function

public function integer wf_crea_actualiza_cuenta (string as_clien, string as_banco, string as_numero, decimal ad_valor);//////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Actualiza en la tabla "fa_ctacli" el campo cs_valche y 
//               cs_numche del cliente, si no existe el cliente y la 
// cuenta en la tabla se crea el cliente
// Retorna : 1 si todo salio bien
// Fecha de Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 18-02-1999
//////////////////////////////////////////////////////////////////////

string ls, ls_clien, ls_rucci,ls_tipo, ls_estado
long li_res,ll_max, li

// encuentra el cliente y el estado de la cuenta dado el banco y
// numero de cuenta

Select ce_codigo, cs_estado
  into :ls, :ls_estado
  from fa_ctacli
 where if_codigo = :as_banco
	and cs_numero = :as_numero;

// Si No existe la cuenta, inserto la cuenta con estado N (Nueva)
if sqlca.sqlcode <> 0 then
	INSERT INTO "FA_CTACLI"( "IF_CODIGO", "CS_NUMERO","CE_CODIGO","CS_VALCHE",   
									"CS_VALPRO", "CS_NUMCHE","CS_NUMPRO","CS_ESTADO" )  
	VALUES (:as_banco,:as_numero,:as_clien,:ad_valor,0,1,0,'N')  ;
else  //si ya existe
	if ls_estado = 'P' then //cuenta inactiva, no se debe facturar
		messageBox('Confirme con Cr$$HEX1$$e900$$ENDHEX$$dito/Cartera','La cuenta corriente tiene problemas.')
		return -1
   end if
	// si el cliente coincide con el due$$HEX1$$f100$$ENDHEX$$o del cheque sumar el valor en
	// cheques y el n$$HEX1$$fa00$$ENDHEX$$mero de cheques
	if ls = as_clien then
		Update fa_ctacli
			set cs_valche = cs_valche + :ad_valor,
				 cs_numche = cs_numche + 1
		 where if_codigo = :as_banco
			and cs_numero = :as_numero;
	else
		// si el cliente no es el mismo que el due$$HEX1$$f100$$ENDHEX$$o de la cuenta registrado
		// le pide que si desea actualizar la cuenta con el dato del cliente
		SELECT "FA_CLIEN"."CE_CODIGO"||' '||NVL("FA_CLIEN"."CE_RAZONS",'')||' / '||DECODE("FA_CLIEN"."CE_TIPO",'N',"FA_CLIEN"."CE_NOMBRE"||' '||"FA_CLIEN"."CE_APELLI","FA_CLIEN"."CE_NOMREP"||' '||"FA_CLIEN"."CE_APEREP") "cliente"
		  INTO :ls_clien  
		  FROM "FA_CLIEN"  
		 WHERE "FA_CLIEN"."EM_CODIGO" = :str_appgeninfo.empresa
		   AND "FA_CLIEN"."CE_CODIGO" = :ls;
		li_res = messageBox('Confirme por favor','Esta cuenta fue ya asignada al cliente ' + ls_clien + '. Desea reemplazar ? ',Question!,YesNoCancel!)
		
		CHOOSE CASE li_res
		CASE 1  // si desea actualizar la cuenta
			Update fa_ctacli
				set cs_valche = cs_valche + :ad_valor,
					 cs_numche = cs_numche + 1,
					 ce_codigo = :as_clien				 
			 where if_codigo = :as_banco
				and cs_numero = :as_numero;
		CASE 2  // si no desea actualizar la cuenta
			Update fa_ctacli
				set cs_valche = cs_valche + :ad_valor,
					 cs_numche = cs_numche + 1		 
			 where if_codigo = :as_banco
				and cs_numero = :as_numero;
		CASE 3  // si desea cancelar y no hacer nada
				return -1
		end choose
   end if						
end if

return 1
end function

public function integer wf_actualiza_saldo_nc (string as_numnc, decimal ac_valpag);decimal{2}  lc_saldo
datetime hoy 

select sysdate
into:hoy
from dual;

//Select ve_valotros
//into :lc_saldo
//from fa_venta
//where es_codigo = '9'
//and em_codigo = :str_appgeninfo.empresa
//and su_codigo = :str_appgeninfo.sucursal
//and ve_numero = :as_numnc;

//Existe una verificacion (ItemChanged!) que impide que pague un valor 
//mayor al saldo. Por lo tanto solo puede ser igual o menor

update fa_venta
set ve_valotros = ve_valotros - :ac_valpag,
	ve_fecha = :hoy
where es_codigo = '9'
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ve_numero = :as_numnc;

if sqlca.sqlcode <> 0 then
	rollback;
	messageBox('Error funci$$HEX1$$f300$$ENDHEX$$n wf_crea_nueva_nc','No se puede actualizar el saldo de la N/C')
	return -1
else
	return 1
end if

end function

public function integer wf_nota_credito (string as_cliente, long ai_factura, decimal ai_total, decimal ai_saldo, string as_tipomov);//////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n: inserta en cc_movim el movimiento de Abono/Cancelaci$$HEX1$$f300$$ENDHEX$$n 
// Factura con Cheque con el  valor del cheque y el saldo deja en cero
// Retorna : El n$$HEX1$$fa00$$ENDHEX$$mero de la Nota de cr$$HEX1$$e900$$ENDHEX$$dito
// Fecha de Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 18-02-1999  18:30
//////////////////////////////////////////////////////////////////////

string ls_numero
dec    ll_numero

// encuentra el Numero secuencial de mivimientos de credito de cxc
select pr_valor
  into :ll_numero
  from pr_param
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'CRE_CXC';
	
if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo obtener el numero de la nota de credito "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

ls_numero = string(ll_numero)
// inserta en cc_movim el valor del cheque y el saldo deja en cero
// tt_codigo = '5' y tt_ioe = 'C' Abono/Cancelaci$$HEX1$$f300$$ENDHEX$$n Factura con Cheque
// es_codigo = 1 de factura al por mayor
insert into cc_movim(tt_codigo,tt_ioe,em_codigo,su_codigo,mt_codigo,
                     rf_codigo,ce_codigo,es_codigo,ve_numero,ig_numero,
							mt_valor,mt_fecha,mt_valret,mt_saldo,bo_codigo)
values(:as_tipomov,'C',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,
       null,:as_cliente,'1',:ai_factura,null,
		 :ai_total,sysdate,0,:ai_saldo,:str_appgeninfo.seccion);

if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo generar la nota de credito: "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

update pr_param
set pr_valor = pr_valor + 1
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'CRE_CXC';

return ll_numero
end function

public function integer wf_encera_pago ();////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Encera la cabecera de la factura
// Fecha de $$HEX1$$fa00$$ENDHEX$$ltima Revisi$$HEX1$$f300$$ENDHEX$$n:  17-Feb-1999
////////////////////////////////////////////////////////////////////

long ll_filactmaster

ll_filactmaster = dw_master.GetRow()

dw_master.SetItem(ll_filactmaster,'ve_efectivo',0.00)
dw_master.SetItem(ll_filactmaster,'ve_valotros',0.00)
dw_master.SetItem(ll_filactmaster,'ve_descue',0.00)
dw_master.SetItem(ll_filactmaster,'ve_valpag',0.00)
dw_master.SetItem(ll_filactmaster,'ve_iva',0.00)
dw_master.SetItem(ll_filactmaster,'ve_subtot',0.00)
return 1
end function

public function integer wf_suma_pagos ();/////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Calcula el valor neto y el descuento
//					El iva a pagar de acuerdo con el descuento que tenga. 
//					Calcula el cambio(vuelto) 
// Fecha de Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 18-Feb-1999  10:45
/////////////////////////////////////////////////////////////////////

string ls_codigo,ls_descue,ls_nulo
int li_filadet
long ll_filact,ll_filcab, li_max, li
decimal{2} lc_valor, lc_valotras=0.00,lc_descuento,&
				lc_iva,lc_cargo,lc_efectivo =0.00

//ll_filcab = dw_master.getrow()
//li_filadet = dw_detail.getrow()
//if li_filadet < 1 then return -1
//ll_filact = dw_detalle_pago.getrow()
//li_max = dw_detalle_pago.RowCount()
//il_descue = 1
//if not isnull(li_max) and li_max > 0 then
//	for li = 1 to li_max
//		ls_codigo = dw_detalle_pago.GetItemString(li,'fp_codigo')
//		// encuentra si tiene descuento o no
////		select fp_descue,fp_numpag,fp_plazo
////		into :ls_descue,:li_numcuota,:li_plazo
////		from fa_formpag
////		where em_codigo = :str_appgeninfo.empresa
////		and fp_codigo = :ls_codigo
////		and fp_utiliza = 'S';
////		if sqlca.sqlcode <> 0 then
////			messagebox('Error','Forma de pago no registrada o no activa.')
////			return 1
////		end if
////		if ls_descue = 'N'  then
////			il_descue = 0
////		end if
//		
//	   // acumula los valores de los pagos
//		if ls_codigo = '0' then
//			lc_efectivo += dw_detalle_pago.getItemdecimal(li,"rp_valor")
//		else
//			lc_valotras += dw_detalle_pago.getItemdecimal(li,"rp_valor")
//		end if			
//	next
//end if
//
//dw_master.SetItem(ll_filcab,"ve_efectivo",lc_efectivo)
//dw_master.SetItem(ll_filcab,"ve_valotros",lc_valotras)
//
//lc_valor = dw_master.Getitemdecimal(ll_filcab,"ve_subtot")	
//lc_cargo = dw_master.Getitemdecimal(ll_filcab,"ve_cargo")
//
//// Calcula el valor del descuento y el Iva
//lc_descuento = round(lc_valor * ic_descuento *ii_excento_iva*il_descue,2)
//dw_master.SetItem(ll_filcab,"ve_descue",lc_descuento)
//// Calcula el Valor Neto
//dw_master.SetItem(ll_filcab,"ve_neto",lc_valor - lc_descuento)	
//lc_iva = dw_detail.Getitemdecimal(li_filadet,"cc_totiva")
//lc_iva = (lc_iva - (lc_iva*ic_descuento)) * ic_iva
//dw_master.SetItem(ll_filcab,"ve_iva",lc_iva)		
//// Calcula el valor a pagar
//lc_valor = lc_valor - lc_descuento + lc_iva + lc_cargo
//dw_master.SetItem(ll_filcab,"ve_valpag", lc_valor )
//// Calcula el valor a pagar en letras
//dw_master.SetItem(ll_filcab,"ve_valletras", f_numero_a_letras(lc_valor)) 
//
//// Calcula el cambio(vuelto) que debe dar
//dw_master.SetItem(ll_filcab,"ve_cambio",lc_valor - (lc_efectivo + lc_valotras))		
//
return 1
end function

public function integer wf_valida_valor_todas_filas ();///////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Controla que el valor a cr$$HEX1$$e900$$ENDHEX$$dito de la compra en la factura
//               no supere el valor del cupo de cr$$HEX1$$e900$$ENDHEX$$dito del cliente.
// Retorna uno si no ha sido superado el valor del cupo de cr$$HEX1$$e900$$ENDHEX$$dito
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 21-12-2006   18:20
///////////////////////////////////////////////////////////////////////

string ls_cliente, ls_codigo, ls_fpvehiculo
char lch_estcre, lch_facturar
dec{2} lc_aux, lc_valor, lc_salcre, lc_saldo
integer li_i,li_j,li_plazo, li_plazocli, fila

ls_cliente = dw_master.GetItemString(dw_master.GetRow(),'ce_codigo')

select ce_plazo,ce_estcre,ce_facturar,ce_salcre
into :li_plazocli,:lch_estcre,:lch_facturar,:lc_salcre
from fa_clien
where ce_codigo = :ls_cliente
AND em_codigo = :str_appgeninfo.empresa;


// Por cada fila del detalle de pagos
for li_i = 1 to dw_detalle_pago.RowCount()
	// encuentra la forma de pago
	ls_codigo = dw_detalle_pago.GetItemString(li_i,'fp_codigo')
   // encuentra los dias de plazo de la forma de pago
	Select fp_plazo,fp_acumula
	into :li_plazo,:ls_fpvehiculo
	from fa_formpag
	where em_codigo = :str_appgeninfo.empresa
	and fp_codigo = :ls_codigo
	and fp_utiliza = 'S';
	
//	if isnull(ls_fpvehiculo) or ls_fpvehiculo <> 'V' Then
//		if li_plazo > li_plazocli then
//			messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')
//			return -1
//		end if
//	end if
	
	If li_plazocli = 1 and li_plazo > 1 then
		messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')
		return -1
	end if
	
//	If li_plazo > li_plazocli then
//		messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')
//		return -1
//     end if
		

	if li_plazo > 0 then // es cr$$HEX1$$e900$$ENDHEX$$dito incremento valor
		lc_valor += dw_detalle_pago.GetItemdecimal(li_i,'rp_valor')
	end if	
	
	//Verifico si existen descuentos en la factura
//	for li_j = 1 to dw_detail.rowcount()
//		lc_aux = dw_detail.getitemnumber(li_j,"dv_desc2")
//		If lc_aux <> 0.00 and li_plazo > 1 Then
//			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha podido grabar esta factura debido a~n~r"+&
//							"que tiene descuentos en pago de contado...verif$$HEX1$$ed00$$ENDHEX$$que")
//			return -1
//		End if
//	next	
	
next

if lch_facturar <> 'S' then
	messageBox('Error','No se puede factura a este cliente. Verifique con Cartera')
	return -1
end if

IF lc_valor > lc_salcre THEN 
	messagebox('Error','La suma de las formas de pago a cr$$HEX1$$e900$$ENDHEX$$dito superan el valor del saldo del cupo de cr$$HEX1$$e900$$ENDHEX$$dito ('+string(lc_salcre) +') del cliente')
	return -1
END IF

if lch_estcre <> 'A' then
	messageBox('Error','El cliente no puede acceder a ning$$HEX1$$fa00$$ENDHEX$$n cr$$HEX1$$e900$$ENDHEX$$dito. Verifique con Cartera')
	return -1
end if

return 1
end function

public function integer wf_valida_valor (string as_formpag, string as_inst_finan, decimal ac_valor);decimal{2} minimo, maximo, minif, maxif, lc_saldo
string tipo, ls_cliente
long ll_plazo

ls_cliente = dw_master.GetItemString(dw_master.GetRow(),'ce_codigo')
select fp_minimo, fp_maximo, fp_plazo
  into :minimo, :maximo, :ll_plazo
  from fa_formpag
 where em_codigo = :str_appgeninfo.empresa
   and fp_codigo = :as_formpag;

select if_minimo, if_maximo, if_tipo
  into :minif, :maxif, :tipo
  from pr_instfin
 where em_codigo = :str_appgeninfo.empresa
   and if_codigo = :as_inst_finan;


if ll_plazo > 0 then
	//Valido el plazo ingresado si la forma de pago es cr$$HEX1$$e900$$ENDHEX$$dito
	if wf_valida_cliente(ls_cliente, 'ce_plazo') < ll_plazo then
		messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')
		return -1
   end if
    //Valido el valor ingresado si la forma de pago es cr$$HEX1$$e900$$ENDHEX$$dito	
	 SELECT CE_SALCRE
      INTO :lc_saldo
      FROM FA_CLIEN
	  WHERE CE_CODIGO = :ls_cliente
	    AND EM_CODIGO = :str_appgeninfo.empresa;
    if ac_valor > lc_saldo then 
		   messagebox('Error','El valor ingresado es mayor que el saldo del cupo de cr$$HEX1$$e900$$ENDHEX$$dito ('+string(lc_saldo,'#,##0.00') +') del cliente')
		   return -1
    end if		
end if
//Validacion de minimo
if minimo > ac_valor then 
		messagebox('Error','El valor ingresado es menor que valor m$$HEX1$$ed00$$ENDHEX$$nimo ('+string(minimo) +') de la forma de pago')
		return -1
end if
if maximo < ac_valor then 
		messagebox('Error','El valor ingresado es mayor que valor m$$HEX1$$e100$$ENDHEX$$ximo ('+string(maximo) +')  de la forma de pago')
		return -1
end if

if not isnull(as_inst_finan) then
//veo si cumple para la institucion financiera
if minif > ac_valor then
		messagebox('Error','El valor ingresado es menor que valor m$$HEX1$$ed00$$ENDHEX$$nimo ('+string(minif) +')  de la Instituci$$HEX1$$f300$$ENDHEX$$n Financiera')
		return -1	
end if
if maxif < ac_valor then
		messagebox('Error','El valor ingresado es mayor que valor m$$HEX1$$e100$$ENDHEX$$ximo ('+string(maxif) +')  de la Instituci$$HEX1$$f300$$ENDHEX$$n Financiera')
		return -1	
end if
end if
return 1
end function

public function integer wf_valida_fecha (datetime ad_fecha, string as_fpcodigo, decimal as_rpvalor);string ls_cliente
decimal lc_saldo
long ll_plazo
datetime hoy

select sysdate
into:hoy
from dual;

ll_plazo = DaysAfter(date(hoy),date(ad_fecha))
ls_cliente = dw_master.GetItemString(dw_master.GetRow(),'ce_codigo')
if ll_plazo < 0 then
	messagebox('Error','La fecha no puede ser una fecha pasada')
	return -1
end if	
//La fecha es importante solo para Cheque ('1') y Letra de Cambio ('3')
if as_fpcodigo = '1' or as_fpcodigo = '3'  then
	if wf_valida_cliente(ls_cliente, 'ce_plazo') < ll_plazo then
		messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')
		return -1
   end if	
end if
if ll_plazo > 0 then
	//Chequeo el valor del cheque contra el saldo del cliente
	 SELECT CE_SALCRE
      INTO :lc_saldo
      FROM FA_CLIEN
	  WHERE CE_CODIGO = :ls_cliente
	    AND EM_CODIGO = :str_appgeninfo.empresa;
    if as_rpvalor > lc_saldo then 
		   messagebox('Error','El valor ingresado es mayor que el saldo del cupo de cr$$HEX1$$e900$$ENDHEX$$dito ('+string(lc_saldo,'#,##0') +') del cliente')
		   return -99
    end if		
end if

return 1
end function

public function integer wf_proforma_factura (long ai_factura);string   ls_codant,ls_nombre,ls_codigo, ls_cliente,ls_motivo, ls_observ
string   ls_vendedor, ls,ls_firma,ls_nomcli,ls_marca,ls_valstk
long     ll_num_filas, ll_secue, ll_filact
decimal  ld_stock, lc_valor, lc
dec{2} lc_subtot,lc_descue,lc_neto,lc_iva,lc_cargo,lc_valpag
dec{4} lc_costo
int  li,li_tiemsec
char lch_kit
s_detalle_factura str_detalle[]

dw_detail.Reset()
dw_detalle_pago.Reset()
dw_master.Reset()
dw_master.InsertRow(0)
dw_master.SetFocus()

ll_filact = dw_master.GetRow()
declare c2 cursor for
 select it_codigo,dv_secue,dv_cantid,dv_precio,
        dv_desc1,dv_desc2,dv_desc3,dv_descue,dv_total,dv_motor
   from fa_detve
  where em_codigo = 1
    and su_codigo = :str_appgeninfo.sucursal
    and es_codigo = 4
    and ve_numero = :ai_factura
	 and dv_cantid > 0
order by dv_secue;

 select count(it_codigo)
   into :ll_num_filas
   from fa_detve
  where em_codigo = 1
    and su_codigo = :str_appgeninfo.sucursal
    and es_codigo = 4
    and ve_numero = :ai_factura
	 and dv_cantid > 0;
	 
if ll_num_filas = 0 or isnull(ll_num_filas) then	 
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Proforma no existe')
	return -1
end if
li = 1

//Inserto la cabecera de la factura
 select ce_codigo,ve_motivo,ve_observ,ve_subtot,ve_descue,ve_neto,ve_iva,ve_cargo,ve_valpag 
   into :ls_cliente,:ls_motivo,:ls_observ,:lc_subtot,:lc_descue,:lc_neto,:lc_iva,:lc_cargo,:lc_valpag
   from fa_venta
  where em_codigo = 1
    and su_codigo = :str_appgeninfo.sucursal
    and es_codigo = 4
    and ve_numero = :ai_factura;

 select ep_codigo, ce_exiva, ce_firma,ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep))  
   into :ls_vendedor, :ls, :ls_firma,:ls_nomcli
   from fa_clien
  where em_codigo = :str_appgeninfo.empresa
    and ce_codigo = :ls_cliente;
if sqlca.sqlcode <> 0 then
   messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Cliente no registrado')
	return -1
end if
sle_1.text = ls_nomcli
if wf_valida_cliente(ls_cliente,'ce_facturar') <> 1 then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','No se puede facturar a este cliente')
	return -1
end if	
if isnull(ls_vendedor) then
	select ep_codigo
	 into :ls_vendedor
	 from no_emple
	where em_codigo = :str_appgeninfo.empresa	 
	  and sa_login = :str_appgeninfo.username;
end if
if ls = 'S' then
	ii_excento_iva = 0
else
	Select pr_valor
	  into :ic_iva
	  from pr_param
    where em_codigo = :str_appgeninfo.empresa
	   and pr_nombre = 'IVA';

	Select pr_valor
	  into :ic_descuento
	  from pr_param
    where em_codigo = :str_appgeninfo.empresa
	   and pr_nombre = 'DSC_SIF';	  
	ii_excento_iva = 1
	ic_descuento = ic_descuento / 100
end if
dw_master.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
dw_master.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
dw_master.SetItem(ll_filact,"es_codigo",is_estado)
dw_master.SetItem(ll_filact,"bo_codigo",str_appgeninfo.seccion)
dw_master.SetItem(ll_filact,"ep_codigo",ls_vendedor)
dw_master.SetItem(ll_filact,"ce_codigo",ls_cliente)
dw_master.SetItem(ll_filact,"ce_firma",ls_firma)
dw_master.SetItem(ll_filact,"empleado",ls_vendedor)
dw_master.SetItem(ll_filact,"ve_motivo",ls_motivo)
dw_master.SetItem(ll_filact,"ve_observ",ls_observ)
dw_master.SetItem(ll_filact,"ve_fecha",id_hoy)

dw_master.SetItem(ll_filact,"ve_subtot",lc_subtot)
dw_master.SetItem(ll_filact,"ve_descue",lc_descue)
dw_master.SetItem(ll_filact,"ve_neto",lc_neto)
dw_master.SetItem(ll_filact,"ve_iva",lc_iva)
dw_master.SetItem(ll_filact,"ve_cargo",lc_cargo)
dw_master.SetItem(ll_filact,"ve_valpag",lc_valpag)

//Ahora vamos con el detalle
open c2;
do
	fetch c2 into :str_detalle[li].item,:str_detalle[li].secue,:str_detalle[li].cantidad,
	              :str_detalle[li].precio,:str_detalle[li].desc1,:str_detalle[li].desc2,&
					  :str_detalle[li].desc3,:str_detalle[li].descue,:str_detalle[li].total,:str_detalle[li].dv_motor;
  	if sqlca.sqlcode <> 0 then exit					  
   li++
loop while TRUE;
close c2;
for li = 1 to ll_num_filas
	dw_detail.InsertRow(0)
	lc = str_detalle[li].cantidad

	select it_codant,it_nombre,it_costo,it_kit,ma_codigo,it_tiemsec,it_valstk
	into :ls_codant,:ls_nombre,:lc_costo,:lch_kit,:ls_marca,:li_tiemsec,:ls_valstk
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codigo = :str_detalle[li].item;


	if ls_valstk = 'S' then
		If f_dame_stock_bodega_new(str_appgeninfo.seccion,str_detalle[li].item,lch_kit,lc) = false then
				messagebox("Error","El stock en sucursal del producto ["+ls_codant+"] = "+string(ld_stock)+"~r~n"+&
					"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>",stopsign!)

			dw_detail.SetItem(li,"it_codigo",str_detalle[li].item)
			dw_detail.SetItem(li,"codant",ls_codant)
			dw_detail.SetItem(li,"nombre",ls_nombre)
			dw_detail.SetItem(li,"it_costo",lc_costo)
			dw_detail.SetItem(li,"it_kit",lch_kit)		
			dw_detail.SetItem(li,"ma_codigo",ls_marca)							
			dw_detail.SetItem(li,"it_tiemsec",li_tiemsec)			
			dw_detail.SetItem(li,"dv_secue",str_detalle[li].secue)
			dw_detail.SetItem(li,"dv_precio",str_detalle[li].precio)
			dw_detail.SetItem(li,"dv_desc1",str_detalle[li].desc1)
			dw_detail.SetItem(li,"dv_desc2",str_detalle[li].desc2)
			dw_detail.SetItem(li,"dv_desc3",str_detalle[li].desc3)
			dw_detail.SetItem(li,"dv_descue",str_detalle[li].descue)
			dw_detail.SetItem(li,"dv_motor",str_detalle[li].dv_motor)				
			dw_detail.SetItem(li,"dv_entrega","N")		
			dw_detail.SetItem(li,"dv_cantid",str_detalle[li].cantidad)
			dw_detail.SetItem(li,"dv_candes",lc)	
			lc_valor= dw_detail.GetItemDecimal(li,"cc_subtot")
			dw_detail.SetItem(li,"dv_total",lc_valor)			
	   else
			dw_detail.SetItem(li,"it_codigo",str_detalle[li].item)
			dw_detail.SetItem(li,"codant",ls_codant)
			dw_detail.SetItem(li,"nombre",ls_nombre)
			dw_detail.SetItem(li,"it_costo",lc_costo)
			dw_detail.SetItem(li,"it_kit",lch_kit)		
			dw_detail.SetItem(li,"ma_codigo",ls_marca)				
			dw_detail.SetItem(li,"it_tiemsec",li_tiemsec)						
			dw_detail.SetItem(li,"dv_secue",str_detalle[li].secue)
			dw_detail.SetItem(li,"dv_precio",str_detalle[li].precio)
			dw_detail.SetItem(li,"dv_desc1",str_detalle[li].desc1)
			dw_detail.SetItem(li,"dv_desc2",str_detalle[li].desc2)
			dw_detail.SetItem(li,"dv_desc3",str_detalle[li].desc3)
			dw_detail.SetItem(li,"dv_descue",str_detalle[li].descue)
			dw_detail.SetItem(li,"dv_motor",str_detalle[li].dv_motor)			
			dw_detail.SetItem(li,"dv_entrega","N")		
			dw_detail.SetItem(li,"dv_cantid",str_detalle[li].cantidad)
			dw_detail.SetItem(li,"dv_candes",str_detalle[li].cantidad)
			lc_valor= dw_detail.GetItemDecimal(li,"cc_subtot")
			dw_detail.SetItem(li,"dv_total",lc_valor)			
	   end if
	else
			dw_detail.SetItem(li,"it_codigo",str_detalle[li].item)
			dw_detail.SetItem(li,"codant",ls_codant)
			dw_detail.SetItem(li,"nombre",ls_nombre)
			dw_detail.SetItem(li,"it_costo",lc_costo)
			dw_detail.SetItem(li,"it_kit",lch_kit)		
			dw_detail.SetItem(li,"ma_codigo",ls_marca)				
			dw_detail.SetItem(li,"it_tiemsec",li_tiemsec)						
			dw_detail.SetItem(li,"dv_secue",str_detalle[li].secue)
			dw_detail.SetItem(li,"dv_precio",str_detalle[li].precio)
			dw_detail.SetItem(li,"dv_desc1",str_detalle[li].desc1)
			dw_detail.SetItem(li,"dv_desc2",str_detalle[li].desc2)
			dw_detail.SetItem(li,"dv_desc3",str_detalle[li].desc3)
			dw_detail.SetItem(li,"dv_descue",str_detalle[li].descue)
			dw_detail.SetItem(li,"dv_motor",str_detalle[li].dv_motor)			
			dw_detail.SetItem(li,"dv_entrega","N")		
			dw_detail.SetItem(li,"dv_cantid",str_detalle[li].cantidad)
			dw_detail.SetItem(li,"dv_candes",str_detalle[li].cantidad)
			lc_valor= dw_detail.GetItemDecimal(li,"cc_subtot")
			dw_detail.SetItem(li,"dv_total",lc_valor)			
	end if
next
wf_encera_pago()
wf_calcula_valores()

//Cambio de estado la proforma a proforma facturada

 Insert Into FA_VENTA (ES_CODIGO, EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO,
                       CJ_CAJA, CE_CODIGO, EP_CODIGO, VE_NUMPRE, VE_FECHA,
							  VE_HORA, VE_SUBTOT, VE_DESCUE, VE_NETO, VE_IVA, VE_CARGO,
							  VE_VALPAG, VE_OBSERV, VE_LEYENDA, VE_EFECTIVO, VE_VALOTROS,
							  VE_CAMBIO, VE_PREANT, VE_VALLETRAS, VE_MOTIVO)
		 select '8', EM_CODIGO, SU_CODIGO, BO_CODIGO, VE_NUMERO,
               CJ_CAJA, CE_CODIGO, EP_CODIGO, VE_NUMPRE, VE_FECHA,
				   VE_HORA, VE_SUBTOT, VE_DESCUE, VE_NETO, VE_IVA, VE_CARGO,
				   VE_VALPAG, VE_OBSERV, null, VE_EFECTIVO, VE_VALOTROS,
					VE_CAMBIO, VE_PREANT, VE_VALLETRAS, VE_MOTIVO
         from FA_VENTA
        where em_codigo = 1
          and su_codigo = :str_appgeninfo.sucursal
          and es_codigo = 4
          and ve_numero = :ai_factura;
	       
Update fa_detve
   set es_codigo = 8
 where em_codigo = 1
   and su_codigo = :str_appgeninfo.sucursal
   and es_codigo = 4
   and ve_numero = :ai_factura;

Update fa_recpag
   set es_codigo = 8
 where em_codigo = 1
   and su_codigo = :str_appgeninfo.sucursal
   and es_codigo = 4
   and ve_numero = :ai_factura;

delete fa_venta 
 where em_codigo = 1
   and su_codigo = :str_appgeninfo.sucursal
   and es_codigo = 4
   and ve_numero = :ai_factura;

return 1
end function

public function integer wf_controla_stock_bodega (integer num_filas);//Descripcion: Funcion que controla el stock maximo disponible de un producto para que sea facturado
//fecha de creaci$$HEX1$$f300$$ENDHEX$$n : 10/05/2001
//Ultima revision:27/09/2001

integer i,j
string ls_item,ls,ls_codant,ls_kit,ls_valstk,ls_codigo_atomo
decimal lc_stock,lc_candes,lc_candes_aux,lc_cantidad
dec{2} lc_stock_disponible


for i = 1 to num_filas
	ls_item = dw_detail.getitemstring(i,"it_codigo")
	lc_cantidad = dw_detail.getitemdecimal(i,"dv_candes")	
	lc_candes = 0
 	If not isnull(ls_item) or ls_item <> '' then 
		select it_codant,it_kit,it_valstk
		into: ls_codant,:ls_kit,:ls_valstk
		from in_item
	   where em_codigo = :str_appgeninfo.empresa
		and it_codigo = :ls_item;
		if sqlca.sqlcode = 100 then
			MessageBox("Error","No se pudo obtener el codant del item ",StopSign!)
			return -1
		end if
	   If ls_valstk = 'S' Then
			If ls_kit = 'S' then
				SELECT "IN_RELITEM"."IT_CODIGO","IN_RELITEM"."RI_CANTID"  
				INTO:ls_codigo_atomo,:lc_stock_disponible
				FROM "IN_RELITEM"  
				 WHERE ( "IN_RELITEM"."TR_CODIGO" = '1' ) AND  
						( "IN_RELITEM"."IT_CODIGO1" = :ls_item ) AND  
						( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa )   ;
			
				SELECT FLOOR("IN_ITEBOD"."IB_STOCK"  / :lc_stock_disponible)
				INTO:lc_stock
				 FROM "IN_ITEBOD"  
				WHERE ( "IN_ITEBOD"."IT_CODIGO" = :ls_codigo_atomo ) AND  
						( "IN_ITEBOD"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
						( "IN_ITEBOD"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND   
						( "IN_ITEBOD"."BO_CODIGO" = :str_appgeninfo.seccion )   						
				FOR UPDATE OF "IN_ITEBOD"."IB_STOCK";	//Es kit
				   
			else // no es kit
				select ib_stock
				into: lc_stock
				from in_itebod
				where em_codigo = :str_appgeninfo.empresa
				and su_codigo = :str_appgeninfo.sucursal
				and bo_codigo = :str_appgeninfo.seccion
				and it_codigo = :ls_item
				for update of ib_stock;
			End If

			if sqlca.sqlcode <> 0 then
				MessageBox("Error","No se pudo obtener el stock del item ",StopSign!)
				return -1
			end if	
			If lc_stock < lc_cantidad then
				is_codant1 = ls_codant
				return -1
			End if
			//Para encontrar y sumar el stock de los items que se repiten en la factura		
			for j = i to num_filas
				ls = dw_detail.getitemstring(j,"it_codigo")
				lc_candes_aux = dw_detail.getitemdecimal(j,"dv_candes")
				If lc_stock >= lc_candes_aux and ls = ls_item then
						lc_candes = lc_candes + lc_candes_aux
						If lc_stock >= lc_candes then 
							continue
						Else
							is_codant1 = ls_codant							
							return -1
						End if
				  End if
			 next
		End if
    End if
next	
return 1
end function

public function integer wf_actualiza_saldo_cupo ();string ls_cliente, ls_codigo
decimal lc_valor = 0
date ld_fecha
long li, ll_max, ll_plazo

ls_cliente = dw_master.GetItemString(dw_master.GetRow(),'ce_codigo')
ll_max = dw_detalle_pago.RowCount()

for li = 1 to ll_max
	ls_codigo = dw_detalle_pago.GetItemString(li,'fp_codigo')
	Select fp_plazo
	into :ll_plazo
	from fa_formpag
	where em_codigo = :str_appgeninfo.empresa
	and fp_codigo = :ls_codigo;
	
	if ll_plazo > 0 then // es cr$$HEX1$$e900$$ENDHEX$$dito incremento valor
	lc_valor += dw_detalle_pago.GetItemNUmber(li,'rp_valor')
	end if
	if ls_codigo = '1' or ls_codigo = '3' then 
		//Cheque o LC, no verifico fecha, pues el proceso de efectivizaci$$HEX1$$f300$$ENDHEX$$n 
		//si es de hoy d$$HEX1$$ed00$$ENDHEX$$a incrementar$$HEX2$$e1002000$$ENDHEX$$el saldo
//	   ld_fecha = date(dw_detalle_pago.GetItemDateTime(li,'rp_fecven'))
//		if ld_fecha > today() then
			lc_valor += dw_detalle_pago.GetItemNumber(li,'rp_valor')
//		end if
   end if
next
    UPDATE FA_CLIEN
	    SET CE_SALCRE = CE_SALCRE - :lc_valor
	  WHERE CE_CODIGO = :ls_cliente
	    AND EM_CODIGO = :str_appgeninfo.empresa;
   if sqlca.sqlcode <> 0 then
		messageBox('Error Interno', 'Funci$$HEX1$$f300$$ENDHEX$$n wf_acualiza_saldo_cupo ' +sqlca.sqlerrtext)
		return -1
	end if
return 1
end function

public function integer wf_cambia_precio_desc ();decimal{2} lc_precio,lc_desc1,lc_desc2,lc_desc3,lc_costo,lc_preciodesc
string ls_codant
int li_row

dw_detail.accepttext()
li_row = dw_detail.getrow()
ls_codant = dw_detail.getitemstring(li_row,'codant')
lc_costo = dw_detail.getitemdecimal(li_row,"it_costo")
lc_precio = dw_detail.getitemdecimal(li_row,"dv_precio")
lc_desc1 = dw_detail.getitemdecimal(li_row,"dv_desc1")
lc_desc2 = dw_detail.getitemdecimal(li_row,"dv_desc2")
lc_desc3 = dw_detail.getitemdecimal(li_row,"dv_desc3")
lc_preciodesc = (((lc_precio * ((100 - lc_desc1)/100))*((100 - lc_desc2)/100))*((100 - lc_desc3)/100))

lc_costo = lc_costo / (1 - ic_descuento) 
if lc_preciodesc < lc_costo then
	If lc_desc1=0 and lc_desc2 = 0 and lc_desc3 = 0 Then		
	 messagebox('Error','El precio no puede ser menor a $'+ string(lc_costo,'#,##0.00')+' d$$HEX1$$f300$$ENDHEX$$lares.')
	 return -1
	else
	  messagebox('Error','El precio no puede ser menor a $'+ string(lc_costo,'#,##0.00')+' d$$HEX1$$f300$$ENDHEX$$lares~n~rTom$$HEX2$$f3002000$$ENDHEX$$en cuenta los descuentos?')
	  return -1
	End if
End if
return 1
end function

public function long wf_nota_debito ();////////////////////////////////////////////////////////////////////
// Retorna : El n$$HEX1$$fa00$$ENDHEX$$mero de la Nota de D$$HEX1$$e900$$ENDHEX$$bito
// Fecha de Ultima Modificaci$$HEX1$$f300$$ENDHEX$$n : 04-01-2006 edivas
////////////////////////////////////////////////////////////////////

long    ll_numero

// Encuentra el Numero secuencial de los debitos de clientes en cxc
select pr_valor
into :ll_numero
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'NUM_ND'
for update of pr_valor;
	
if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo obtener el numero de la nota de debito "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

return ll_numero
end function

public subroutine wf_insertarfila ();int li_filas,li_numli
string ls_dctocli

li_filas = dw_detail.rowcount()
If li_filas < 1 Then return

If li_filas = ii_numli Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Recuerde que s$$HEX1$$f300$$ENDHEX$$lo puede facturar hasta "+string(ii_numli)+" items")
End if

If li_filas > ii_numli  Then 
	dw_detail.deleterow(li_filas)
	return
End if

If isnull(dw_detail.getitemstring(dw_detail.getrow(),"codant"))  Then 
	dw_detail.deleterow(li_filas)
	return
End if


end subroutine

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, string as_estado, decimal ac_costo, character ach_kit, string as_atomo, decimal ac_costo_atomo, decimal ac_cantatomo, string as_codant, decimal ac_costprom, decimal ac_costtrans);//Funcion	inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de sus componentes 
//Modifica	21/12/07    por:PBarriga
//Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=2, tm_ioe='E' es egreso por ventas

long ll_num_movim,ll_fila
string ls_num_movim, ls_factura,ls_es_kit,ls_componente,ls_codant, ls_codigo_kit
boolean lb_exito = TRUE

ls_factura = string(al_factura)

// busca si el item es kit o no 
	
if ach_kit = 'S' then
	// es un kit
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		rollback;		
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'2')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_atomo)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad * ac_cantatomo)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo_atomo)	
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans/ac_cantatomo)	
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom/ac_cantatomo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ","Venta del Kit "+as_codant+" Factura No."+ls_factura)
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",as_estado)		

	// inserta el movimiento del kit (grande)
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		rollback;
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	// ingresa el Kit
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'2')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",'Factura de Venta No. '+ls_factura)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",as_estado)		

else
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		rollback;		
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'2')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
     dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",'Factura de Venta No. '+ls_factura)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",as_estado)		
end if
return(TRUE)

end function

public function integer wf_procesa_item (string as_codant, integer ai_fila);long       ll_filActMaster,ll_nreg,ll_find
decimal{2} lc_prefab,lc_pedido, lc_stock,ld_null,lc_recargo,lc_preciodesc,lc_descprom
dec{4}     lc_costo
string     ls,ls_marca,ls_pepa, ls_nombre, ls_null, ls_codant,&
			  ls_valstk,tipo_descuento,ls_base,ls_param[2],ls_actividad,ls_itcodigo,ls_fp
char       lch_cambia,lch_kit, lch_aux
decimal    ld_desc1, ld_desc2, ld_desc3
int        si_hay,li_ivaitem,li_ajuste
boolean lb_aplica_descto_anio



//Aplica descuento a modelos de a$$HEX1$$f100$$ENDHEX$$os anteriores al actual
	ls = as_codant
	ll_nreg = dw_detail.rowcount()
	ll_find =  dw_detail.find("codant = '"+ls+"'",1, ll_nreg - 1)
	
	if ll_find <> 0 and ll_nreg <> 1 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el c$$HEX1$$f300$$ENDHEX$$digo...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(ll_find))
	end if
	
	
	// con este voy a buscar primero por codigo anterior 
	select ma_codigo,it_tiemsec,it_preparado,it_codigo, it_nombre, it_prefab, it_valstk,nvl(it_costo,0),it_kit,it_base
	into :ls_marca,:li_ivaitem,:lch_cambia,:ls_pepa, :ls_nombre, :lc_prefab, :ls_valstk, :ic_costo, :lch_kit, :ls_base
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls; 

    dw_detail.SetItem(ai_fila,"it_kit",lch_kit)
   
//	if ai_fila > 1  then
//		lch_aux = getitemstring(1,"it_kit")
//		choose case lch_aux
//			case 'N','S'
//				if getitemstring(1,"it_kit") <> lch_kit then 
//					if lch_kit = 'V' then
//						dw_detail.SetItem(ai_fila,'codant',ls_null)
//						beep(1)
//						is_mensaje  = 'No puede facturar vehiculo junto con items'
//						return 1
//					end if
//				end if
//			case 'V'
//				if getitemstring(1,"it_kit") <> lch_kit then 
//					if lch_kit = 'N' or lch_kit = 'S' then
//						dw_detail.SetItem(ai_fila,'codant',ls_null)
//						beep(1)
//						is_mensaje  = 'No puede facturar este item junto con veh$$HEX1$$ed00$$ENDHEX$$culo(s)'
//						return 1
//					end if
//				end if	
//		end choose
//	end if

	
//filtrado para verificar si a este item le falta realizar el ajuste de egreso x preventa
	select it_codigo
	into :ls_itcodigo
	from in_ajuste
	where tm_codigo = '3'
	and tm_ioe = 'I'
	and em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion
	and it_codigo = :ls_pepa
	and da_estado = 'N';
	

	if ls_itcodigo = ls_pepa then
		dw_detail.deleterow(ai_fila)
		ll_find = dw_detail.insertrow(0)
		dw_detail.scrolltorow(ll_find)
		is_mensaje  = 'Falta realizar egreso x preventa de este item'
		return 1
	end if
	

	If lch_cambia = 'S' Then
		dw_detail.settaborder("dv_precio",25)
	Else
		dw_detail.settaborder("dv_precio",0)
	End if
	

	select nvl(it_recargo,0)
	into :lc_recargo
	from in_itesucur
	where em_codigo = : str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and it_codigo = :ls_pepa; 
	if sqlca.sqlcode <> 0 then
		messageBox('Error Interno','No se encuentra producto: '+sqlca.sqlerrtext)
		return -1
	end if		

	lc_prefab = lc_prefab + lc_recargo
	// si debo validar el stock
	//Se debe verificar si por lo menos tengo 1 en stock en mi secci$$HEX1$$f300$$ENDHEX$$n
	if ls_valstk = 'S' then 		
		lc_pedido = 1.0
		//	si_hay = f_dame_stock_sucursal (ls_pepa, lc_pedido, lc_stock)
	   lc_stock = lc_pedido
		// controla si hay stock mayor que 1 en la bodega
		si_hay = f_dame_stock_bodega_real(str_appgeninfo.seccion,ls_pepa,lc_stock)
	   if si_hay = 1 then // si existe por lo menos uno disponible
		
			dw_detail.setitem(ai_fila, 'dv_cantid', 1)
			dw_detail.setitem(ai_fila, 'dv_candes', 1)
			dw_detail.setitem(ai_fila, 'nombre',ls_nombre)
			dw_detail.setitem(ai_fila, 'dv_precio', lc_prefab)
			dw_detail.setitem(ai_fila, 'it_codigo',ls_pepa)
			dw_detail.setitem(ai_fila, 'it_kit',lch_kit)			
			dw_detail.setitem(ai_fila, 'it_tiemsec',li_ivaitem)									
			dw_detail.setitem(ai_fila, 'it_costo',ic_costo)
			dw_detail.setitem(ai_fila, 'ma_codigo',ls_marca)			
			dw_detail.setitem(ai_fila, 'iva',ic_iva*ii_excento_iva)						
			dw_detail.setitem(ai_fila, 'descto',ic_descuento)

			
		else // no hay ni uno disponible
	   		if si_hay = 0 then // aunque no hay 1 disponible si hay en stock 
	   		    is_mensaje = 'No hay disponible este producto. Otra caja ha reservado la existencia ' + &
					      		'Stock en bodega: ' + string (lc_stock, '#,##0.00')
     	    else // no hay tampoco en stock
		        is_mensaje = 'No hay este producto en existencia en la sucursal.'
			end if 
		    //Inserto para la demanda insatisfecha
  		  	dw_detail.ib_inErrorCascade = true
		  	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n',is_mensaje)		 
		  	dw_detail.setitem(ai_fila, 'dv_cantid', 1)
		  	dw_detail.setitem(ai_fila, 'dv_candes', 0)
	     	dw_detail.setitem(ai_fila, 'nombre',ls_nombre)
		  	dw_detail.setitem(ai_fila, 'dv_precio', lc_prefab)
		  	dw_detail.setitem(ai_fila, 'dv_desc1',0)
  	         dw_detail.setitem(ai_fila, 'dv_desc2', 0)
	     	dw_detail.setitem(ai_fila, 'dv_desc3', 0)
   	  	     dw_detail.setitem(ai_fila, 'it_codigo',ls_pepa)
		  	dw_detail.SetItem(ai_fila,"dv_total",0)
   	  	return 0
	 	end if // fin de si hay disponible
	else // de si valida stock
		dw_detail.setitem(ai_fila, 'dv_cantid', 1)
		dw_detail.setitem(ai_fila, 'dv_candes', 1)
 		dw_detail.setitem(ai_fila, 'nombre',ls_nombre)
		dw_detail.setitem(ai_fila, 'dv_precio', lc_prefab)
		dw_detail.setitem(ai_fila, 'it_codigo',ls_pepa)
		dw_detail.setitem(ai_fila, 'it_kit',lch_kit)			
	     dw_detail.setitem(ai_fila, 'it_tiemsec',li_ivaitem)		
		dw_detail.setitem(ai_fila, 'it_costo',ic_costo)		
		dw_detail.setitem(ai_fila, 'ma_codigo',ls_marca)		
		dw_detail.setitem(ai_fila, 'iva',ic_iva*ii_excento_iva)						
		dw_detail.setitem(ai_fila, 'descto',ic_descuento)			
		
	end if // fin de si valida stock

	//Busco los descuentos del item por cliente
	ls_actividad = dw_master.getitemstring(dw_master.getrow(),"ce_actividad") /*pol$$HEX1$$ed00$$ENDHEX$$tica anterior :descuentos por tipo de cliente*/
//	ls_fp  = dw_master.getitemstring(dw_master.getrow(),"fp_codigo")     /*politica nueva :  28-nov-07*/
//	choose case ls_actividad
//	case '1','2'
//		if ai_fila <> 1 and lch_kit = 'V' then
//			dw_detail.deleterow(ai_fila)		
//			is_mensaje  ="S$$HEX1$$f300$$ENDHEX$$lo puede facturar una moto para este tipo de cliente"
//			return	 1
//		end if
//	end choose


	select td_codigo
	into :tipo_descuento
	from in_descitem
	where em_codigo = : str_appgeninfo.empresa
	and it_codigo = :ls_pepa
	and es_codigo = :ls_actividad
	and di_vigente = 'S';

			
	
	select td_desc1,td_desc2,td_desc3
	into :ld_desc1,:ld_desc2,:ld_desc3
	from in_tippre
	where em_codigo = : str_appgeninfo.empresa
	and td_codigo = :tipo_descuento
	and td_vigente = 'S';
	
	if sqlca.sqlcode <> 0 then
		ld_desc1 = 0
		ld_desc2 = 0
		ld_desc3 = 0
	end if

	dw_detail.setitem(ai_fila, 'dv_desc1',ld_desc1)
	dw_detail.setitem(ai_fila, 'dv_desc2', ld_desc2)
	dw_detail.setitem(ai_fila, 'dv_desc3',ld_desc3)
	ic_precio = lc_prefab
	ic_desc1 = ld_desc1
	ic_desc2 = ld_desc2
	ic_desc3 = ld_desc3	
	dw_detail.setitem(ai_fila, 'it_codigo',ls_pepa)
	dw_detail.setitem(ai_fila, 'it_kit',lch_kit)			
	dw_detail.setitem(ai_fila, 'it_tiemsec',li_ivaitem)	
	dw_detail.setitem(ai_fila, 'it_costo',ic_costo)		
	dw_detail.setitem(ai_fila, 'ma_codigo',ls_marca)	
	dw_detail.setitem(ai_fila, 'iva',ic_iva*ii_excento_iva)						
	dw_detail.setitem(ai_fila, 'descto',ic_descuento)
	dw_detail.setitem(ai_fila, 'it_base',ls_base)
	setnull(ls_null)
	dw_detail.setitem(ai_fila, 'dv_motor',ls_null)
	dw_detail.setitem(ai_fila, 'dv_chasis',ls_null)
	
	//Para verificar el costo del item al ingresar el codigo del item
	lc_preciodesc = (((lc_prefab * ((100 - ld_desc1)/100))*((100 - ld_desc2)/100))*((100 - ld_desc3)/100))
     lc_costo = ic_costo / (1 - ic_descuento) 
	if lc_preciodesc < lc_costo then
		If ld_desc1=0 and ld_desc2 = 0 and ld_desc3 = 0 Then		
	 		messagebox('Error','El precio no puede ser menor a $'+ string(lc_costo,'#,##0.00')+' d$$HEX1$$f300$$ENDHEX$$lares.')
		else
	  		messagebox('Error','El precio no puede ser menor a $'+ string(lc_costo,'#,##0.00')+' d$$HEX1$$f300$$ENDHEX$$lares~n~rTom$$HEX2$$f3002000$$ENDHEX$$en cuenta los descuentos?')
		End if
		setnull(ld_null)
		dw_detail.SetItem(ai_fila,"codant",ls_null)	
		dw_detail.SetItem(ai_fila,'nombre',ls_null)	
	  	dw_detail.SetItem(ai_fila,"dv_cantid",ld_null)
	  	dw_detail.SetItem(ai_fila,"dv_candes",ld_null)		  
		dw_detail.SetItem(ai_fila,'dv_precio',0)		
		dw_detail.setitem(ai_fila, 'dv_desc1',35)
		dw_detail.setitem(ai_fila, 'dv_desc2', 0)
		dw_detail.setitem(ai_fila, 'dv_desc3',0)
	  	dw_detail.SetItem(ai_fila,"dv_total",0)		
		dw_detail.setitem(ai_fila, 'dv_motor',ls_null)		  
	  	dw_detail.SetItem(ai_fila,"it_base",ls_null)				  
	  	dw_detail.SetItem(ai_fila,"it_kit",ls_null)		  
		str_prodparam.precio = 0
		setnull(str_prodparam.formula)
		wf_encera_pago()
		wf_calcula_valores()		
		return 2	
	End if
return 1
end function

public function integer wf_calcula_valores ();///////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Calcula el valor neto, el iva y el valor a pagar en
//               numeros y letras   
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 25-Mar-2006
///////////////////////////////////////////////////////////////////

long ll_filact, ll_filactmaster, ll_totfilas, ll_fila
integer li_ivaitem
decimal{2} lc_iva,lc_valor, ll_valorsum, ll_subtot,lc_valpag,lc_sum_tot
string ls_val

ll_filact = dw_detail.GetRow()



ll_filactmaster = dw_master.GetRow()
dw_detail.AcceptText()
If ll_filact = 0 Then
dw_master.setItem(ll_filActMaster,"ve_subtot",0)
dw_master.setItem(ll_filActMaster,"ve_neto",0)
dw_master.setItem(ll_filActMaster,"ve_iva",0)
dw_master.setItem(ll_filActMaster,"ve_descue",0)
else
lc_valor= dw_detail.GetItemDecimal(ll_filact,"cc_subtotal")
// asigna el valor total de la fila
dw_detail.SetItem(ll_filact,"dv_total",lc_valor)

lc_sum_tot = dw_detail.getitemdecimal(ll_filact,"cc_sum_subtot")
dw_master.setItem(ll_filActMaster,"ve_subtot",lc_sum_tot)

// actualiza el valor neto :  subtotal - descuento
ll_subtot= lc_sum_tot - dw_master.GetItemdecimal(ll_filActMaster,"ve_descue")
dw_master.SetItem(ll_filActMaster,"ve_neto",ll_subtot)

lc_iva = dw_detail.getitemdecimal(ll_filact,"cc_totiva") * ic_iva*ii_excento_iva
dw_master.SetItem(ll_filActMaster,"ve_iva",lc_iva)
// encuentra el valor a pagar : neto + iva + cargo
lc_valpag = ll_subtot + lc_iva + dw_master.GetItemdecimal(ll_filActMaster,"ve_cargo")
dw_master.SetItem(ll_filActMaster,"ve_valpag",lc_valpag)

// cambia el valor a pagar a letras 
ls_val = f_numero_a_letras(lc_valpag)
dw_master.SetItem(ll_filActMaster,"ve_valletras",ls_val)
End if
return 1
end function

public function integer wf_calcula_valores_en_bucle (integer ai_fila);///////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Calcula el valor neto, el iva y el valor a pagar en
//               numeros y letras   
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 25-Mar-2006
///////////////////////////////////////////////////////////////////

long ll_filact, ll_filactmaster, ll_totfilas, ll_fila
integer li_ivaitem
decimal{2} lc_iva,lc_valor, ll_valorsum, ll_subtot,lc_valpag,lc_sum_tot
string ls_val

//ll_filact = dw_detail.GetRow()

ll_filact = ai_fila

ll_filactmaster = dw_master.GetRow()
dw_detail.AcceptText()
If ll_filact = 0 Then
dw_master.setItem(ll_filActMaster,"ve_subtot",0)
dw_master.setItem(ll_filActMaster,"ve_neto",0)
dw_master.setItem(ll_filActMaster,"ve_iva",0)
dw_master.setItem(ll_filActMaster,"ve_descue",0)
else
lc_valor= dw_detail.GetItemDecimal(ll_filact,"cc_subtot")
// asigna el valor total de la fila
dw_detail.SetItem(ll_filact,"dv_total",lc_valor)

lc_sum_tot = dw_detail.getitemdecimal(ll_filact,"cc_sum_subtot")
dw_master.setItem(ll_filActMaster,"ve_subtot",lc_sum_tot)

// actualiza el valor neto :  subtotal - descuento
ll_subtot= lc_sum_tot - dw_master.GetItemdecimal(ll_filActMaster,"ve_descue")
dw_master.SetItem(ll_filActMaster,"ve_neto",ll_subtot)

lc_iva = dw_detail.getitemdecimal(ll_filact,"cc_totiva") * ic_iva*ii_excento_iva
dw_master.SetItem(ll_filActMaster,"ve_iva",lc_iva)
// encuentra el valor a pagar : neto + iva + cargo
lc_valpag = ll_subtot + lc_iva + dw_master.GetItemdecimal(ll_filActMaster,"ve_cargo")
dw_master.SetItem(ll_filActMaster,"ve_valpag",lc_valpag)

// cambia el valor a pagar a letras 
ls_val = f_numero_a_letras(lc_valpag)
dw_master.SetItem(ll_filActMaster,"ve_valletras",ls_val)
End if
return 1
end function

on w_factura.create
int iCurrent
call super::create
this.cb_ubicacion=create cb_ubicacion
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_formpag=create cb_formpag
this.dw_sel_numero=create dw_sel_numero
this.p_ubicacion=create p_ubicacion
this.dw_movim=create dw_movim
this.dw_consulta_stk=create dw_consulta_stk
this.p_producto=create p_producto
this.dw_1=create dw_1
this.sle_1=create sle_1
this.cb_4=create cb_4
this.pb_1=create pb_1
this.dw_pedidos=create dw_pedidos
this.st_1=create st_1
this.st_plazo=create st_plazo
this.st_2=create st_2
this.cb_5=create cb_5
this.dw_detalle_pago=create dw_detalle_pago
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ubicacion
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_formpag
this.Control[iCurrent+6]=this.dw_sel_numero
this.Control[iCurrent+7]=this.p_ubicacion
this.Control[iCurrent+8]=this.dw_movim
this.Control[iCurrent+9]=this.dw_consulta_stk
this.Control[iCurrent+10]=this.p_producto
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.sle_1
this.Control[iCurrent+13]=this.cb_4
this.Control[iCurrent+14]=this.pb_1
this.Control[iCurrent+15]=this.dw_pedidos
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.st_plazo
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.cb_5
this.Control[iCurrent+20]=this.dw_detalle_pago
end on

on w_factura.destroy
call super::destroy
destroy(this.cb_ubicacion)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_formpag)
destroy(this.dw_sel_numero)
destroy(this.p_ubicacion)
destroy(this.dw_movim)
destroy(this.dw_consulta_stk)
destroy(this.p_producto)
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.pb_1)
destroy(this.dw_pedidos)
destroy(this.st_1)
destroy(this.st_plazo)
destroy(this.st_2)
destroy(this.cb_5)
destroy(this.dw_detalle_pago)
end on

event open;call super::open;string ls_parametro[], ls_datos[]
datawindowchild dwc
date ld_fecanu
integer li_i

f_recupera_empresa(dw_master,'empleado')
f_recupera_empresa(dw_master,"fp_codigo") 
//f_recupera_empresa(dw_master,"ce_codigo")
f_recupera_empresa(dw_detail,"codant")
f_recupera_empresa(dw_detail,"codant_1")


istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = is_estado

//call super::open
gb_codigo_numerico = true
//dw_master.is_SerialCodeColumn = "ve_numero"
//dw_master.is_SerialCodeType = "FACTURA"
//dw_master.is_serialCodeCompany = str_appgeninfo.empresa
dw_master.ii_nrCols = 5
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "es_codigo"
dw_master.is_connectionCols[4] = "ve_numero"
dw_master.is_connectionCols[5] = "bo_codigo"

dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "es_codigo"
dw_detail.is_connectionCols[4] = "ve_numero"
dw_detail.is_connectionCols[5] = "bo_codigo"
dw_detail.uf_setArgTypes()


//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()

select sysdate
into :id_hoy
from dual;

select es_numli
into : ii_numli
from fa_estado
where es_codigo = :is_estado; //FXM


select cj_fecanu
into   :ld_fecanu
from fa_caja
where cj_caja = :str_appgeninfo.caja;


if relativedate(date(id_hoy),15) >= ld_fecanu then
	for li_i = 15 to 0 step -1
		if relativedate(date(id_hoy),li_i) = ld_fecanu then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","FALTAN "+string(li_i)+" DIAS PARA QUE LAS FACTURAS DE ESTA  C A J A  SE CADUQUEN...")
			exit
		end if
	next
end if


dw_detalle_pago.Settransobject(sqlca)
ib_detalle_pago = true
dw_detalle_pago.Reset()
dw_master.uf_insertCurrentRow()
dw_master.setFocus()
dw_master.TriggerEvent(Clicked!)
m_marco.m_archivo.m_imprimir.visible = false
m_marco.m_ventana.m_todo.triggerevent(clicked!)

//Produccion
//Detalle de pedidos 



dw_pedidos.SetTransObject(sqlca)
end event

event ue_update;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Actualiza los datos
// Fecha de Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 09-05-2005.
////////////////////////////////////////////////////////////////////////

integer  li_pasa,li_filact,li_fpago,li_i,i,li_nreg,j,li_marca,li_plazo
long      ll_candes,ll_factura,rc
string    ls_fp,ls_nc,ls_cliente,ls_codigo,ls_insfin,ls_cuenta,&
			 ls_numche,ls_numnd,ls_numero,ls_codant,ls_atomo,ls_marca, ls_motor, ls_numfact
decimal lc_pedido,lc_aux,lc
decimal{2} ld_total,ld_efectivo,ld_valcheque,ld_cantatomo,lc_ve_subtot
decimal{4} lc_costo,ld_costo_atomo,lc_costprom,lc_costtrans
datetime  ld_fecha,hoy
character lch_kit
boolean   mov_inv



setpointer(hourglass!)

If dw_master.accepttext() < 1 then return
If dw_master.rowcount() < 1 then return
If dw_detail.accepttext() < 1 then return
If dw_detail.rowcount() < 1 then return
If dw_detalle_pago.accepttext() < 1 then return  
If dw_detalle_pago.rowcount() < 1 then 
	messagebox("Atencion","debe ingresar la forma de pago antes de grabar")	
	return  
end if

ib_fabricante = false

select sysdate 
into:hoy
from dual;

if ib_nograba = true then
	messagebox("Atencion","Verifique par$$HEX1$$e100$$ENDHEX$$metros de cr$$HEX1$$e900$$ENDHEX$$dito del cliente...")
	return
end if

//Fila actual de la cabecera
li_filact = dw_master.GetRow()
lc_ve_subtot = dw_master.getitemdecimal(li_filact,"ve_subtot")
ld_total = dw_detail.getitemdecimal(dw_detail.getrow(),"cc_sum_subtot")
if lc_ve_subtot <> ld_total then
	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Problema en factura datos totales no coinciden...verifique')
	return
end if
//Controla que se registre la forma de pago
if dw_master.GetitemNumber(li_filact,'cc_saldo') > 0 then
	messagebox('Error','La factura tiene saldo pendiente de liquidar')
	return
end if
	// Control e datos del cliente para aceptar la facturaci$$HEX1$$f300$$ENDHEX$$n
	// despliega el mensaje y presenta el detalle del pago
if wf_valida_valor_todas_filas() <> 1 then
	dw_detail.Visible = false
	dw_detalle_pago.Visible = true
	dw_detalle_pago.SetRow(dw_detalle_pago.RowCount())
	cb_formpag.text = 'Detalle de Factura'
	dw_detalle_pago.SetFocus()
	ib_detalle_pago = false		
	return
end if	


//1.- Busco  el n$$HEX1$$fa00$$ENDHEX$$mero de Factura en fa_caja
select cj_ticket
into :ll_factura
from fa_caja
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and cj_caja = :str_appgeninfo.caja;
if sqlca.sqlcode <> 0 then
	messageBox('Error Interno', 'Problemas al encontrar el n$$HEX1$$fa00$$ENDHEX$$mero de factura para la caja ' + &
				  str_appgeninfo.caja + 'Por favor reporte a sistemas el siguiente error : ' + sqlca.sqlerrtext )
	return
end if
//Datos auxiliares para la cabecera de la factura de venta
dw_master.SetItem(li_filact,"ve_numero",ll_factura)
dw_master.SetItem(li_filact,"ve_numpre",right(string(ll_factura),7))
dw_master.SetItem(li_filact,"cj_caja",str_appgeninfo.caja)
dw_master.setitem(li_filact,'em_codigo',str_appgeninfo.empresa)
dw_master.setitem(li_filact,'su_codigo',str_appgeninfo.sucursal)
dw_master.setitem(li_filact,'bo_codigo',str_appgeninfo.seccion)
dw_master.setitem(li_filact,'es_codigo',is_estado)	
dw_master.setitem(li_filact,'ve_fecha',hoy)	
dw_master.setitem(li_filact,"ve_hora",hoy)


//2.-funcion que controla el stock m$$HEX1$$e100$$ENDHEX$$ximo a venderse de un producto
li_nreg = dw_detail.RowCount()
li_pasa = wf_controla_stock_bodega(li_nreg)
If li_pasa = -1 Then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha podido grabar esta factura~r~n"+&
							"Debido a que el stock disponible del producto ["+is_codant1+"]~r~n"+&
							"es menor que el pedido...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>")
		return
End if

//seteo el parametro general de la promocion
//select pr_valor
//into :li_marca
//from pr_param
//where em_codigo = :str_appgeninfo.empresa
//and pr_nombre = 'MARCAPROMO';
//if sqlca.sqlcode = 100 then
//	messagebox("Error en marcapromo","Problemas al encontrar el par$$HEX1$$e100$$ENDHEX$$metro fabpromo...comuniquese con sistemas "+sqlca.sqlerrtext,stopsign!)
//end if

// 3.- Actualiza la tabla de inventarios
dw_movim.reset()
for i =1 to li_nreg
		ll_candes = dw_detail.getitemnumber(i,'dv_candes')	
		ls_codigo = dw_detail.getitemstring(i,'it_codigo')			
		ls_codant = dw_detail.getitemstring(i,'codant')	
		lch_kit = dw_detail.getitemstring(i,'it_kit')	
		lc_costo = dw_detail.getitemdecimal(i,'it_costo')
		ls_motor = dw_detail.getitemstring(i,'dv_motor')

		dw_detail.setitem(i,'ve_numero',ll_factura)
		dw_detail.setitem(i,'em_codigo',str_appgeninfo.empresa)
		dw_detail.setitem(i,'su_codigo',str_appgeninfo.sucursal)
		dw_detail.setitem(i,'bo_codigo',str_appgeninfo.seccion)
		dw_detail.setitem(i,'es_codigo',is_estado)	
		dw_detail.Setitem(i,'dv_secue',i)	
		
		if lch_kit = 'V' then	//and cod. cli unomotors	
			ls_numfact = string(ll_factura)
			
			update in_itedet
			set estado = 'V',
				 ve_numero = :ls_numfact
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and di_ref1 = :ls_motor;
		   if sqlca.sqlcode <> 0 then
				messageBox('Error Interno', 'No se puede encontrar el n$$HEX1$$fa00$$ENDHEX$$mero de motor...Por favor avise a sistemas el error : ' + sqlca.sqlerrtext )
				rollback;
				return
			end if			
		end if
		
		ls_marca = dw_detail.getitemstring(i,'ma_codigo')
		if ls_marca = string(li_marca) then
			ib_fabricante = true
		end if

		If ll_candes > 0 Then
		   If lch_kit = 'S' Then
				SELECT "IN_ITEM"."IT_COSTO", "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
				INTO :ld_costo_atomo,:ls_atomo, :ld_cantatomo
				FROM "IN_ITEM"  , "IN_RELITEM"
				WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
				("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
				("IN_RELITEM"."TR_CODIGO" = '1' ) and
				( "IN_RELITEM"."IT_CODIGO1" = :ls_codigo ) and
				( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
		   End if
		   mov_inv = f_descarga_stock_rt_sucursal(ls_codigo,ll_candes,lch_kit,ls_atomo,ld_cantatomo)
			If mov_inv = false then
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+ls_codant+"'")
				return
			End if
			// Descarga ib_stock de la tabla in_itebod
			mov_inv = f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,ll_candes,lch_kit,ls_atomo,ld_cantatomo)
			If mov_inv = false then
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+ls_codant+"'")
				return
			End if			
			
			//Determina el costo promedio
			select NVL(it_costprom,0)
			into   :lc_costprom
			from in_item
			where it_codigo = :ls_codigo;
			
			if sqlca.sqlcode <> 0 then
			lc_costprom = 0	
			end if
			
			//El costo de la transacci$$HEX1$$f300$$ENDHEX$$n en este caso es el costo promedio
			lc_costtrans = lc_costprom
			lc_costprom =  f_costprom(ls_codigo,'E',ll_candes,lc_costprom)
			
			// registra el movimiento de inventarios
		      mov_inv = wf_mov_inventario(ls_codigo,ll_candes,hoy,ll_factura,is_estado,lc_costo,lch_kit,ls_atomo,ld_costo_atomo,ld_cantatomo,ls_codant,lc_costprom,lc_costtrans)
			if mov_inv = false then
				messagebox("Error","Problemas al actualizar el inventario ... wf_mov_inventario")
				dw_movim.reset()
				return
		   end if						
		End if
 next	


//4.- Genera la deuda
ls_cliente = dw_master.GetItemString(li_filact,"ce_codigo")
ld_total = dw_master.GetItemNumber(li_filact,"ve_valpag")
ld_efectivo = dw_master.GetItemNumber(li_filact,"ve_efectivo")
		
// inserta en cc_movim los datos de la factura,cliente y el numero
// de la ND generada
rc = wf_nota_debito()
if  rc = - 1 then return
ls_numnd = string(rc)

li_fpago = dw_detalle_pago.rowcount()
//Datos auxiliares para la forma de pago
For i = 1 to li_fpago
	// determina que forma de pago es
	dw_detalle_pago.setitem(i,'ve_numero',ll_factura)
	dw_detalle_pago.setitem(i,'em_codigo',str_appgeninfo.empresa)
    dw_detalle_pago.setitem(i,'su_codigo',str_appgeninfo.sucursal)
	dw_detalle_pago.setitem(i,'bo_codigo',str_appgeninfo.seccion)
	dw_detalle_pago.setitem(i,'es_codigo',is_estado)	
	dw_detalle_pago.Setitem(i,'rp_numero',i)

	ls_fp = dw_detalle_pago.GetitemString(i,'fp_codigo')
	ld_valcheque = dw_detalle_pago.GetItemDecimal(i,"rp_valor")
	ls_insfin = dw_detalle_pago.GetItemString(i,"if_codigo")
	ls_cuenta = dw_detalle_pago.GetItemString(i,"rp_numcta")
	ls_numche = dw_detalle_pago.GetItemString(i,"rp_numdoc")


	Choose case ls_fp

		Case '0'
				// inserta en cc_movim el movimiento de Abono/Cancelaci$$HEX1$$f300$$ENDHEX$$n 
				// Factura con Efectivo con el  valor cancelado y el saldo deja en cero
				ld_fecha = dw_detalle_pago.GetItemDateTime(i,"rp_fecven")							
				ls_numero = string(wf_nota_credito(ls_cliente,ll_factura,ld_valcheque,0.0,'5'))
				//inserto los datos del cheque en la tabla cc_cheque con el #NC y la fecha del cheque
				insert into cc_cheque (tt_codigo,tt_ioe,em_codigo,su_codigo,mt_codigo,
		   	                    ch_secue,if_codigo,ch_cuenta,ch_numero,ch_fecha,ch_valor,ch_interes,ch_fecinte,
							  ch_pendiente,ch_fecefec,fp_codigo)
				values ('5','C',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,
		      	  	  :i,:ls_insfin,:ls_cuenta,:ls_numche,:ld_fecha,:ld_valcheque,null,null,'S',sysdate,:ls_fp);
				
				insert into cc_cruce (tt_coddeb,tt_ioedeb,mt_coddeb,tt_codigo,tt_ioe,
											em_codigo,su_codigo,mt_codigo,cr_fecha,cr_valdeb,cr_valcre)
				values ('1','D',:ls_numnd,'5','C',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,sysdate,:ld_valcheque,0.0);
				update cc_movim
				set mt_saldo = mt_saldo - :ld_valcheque
				where em_codigo = :str_appgeninfo.empresa
				and su_codigo = :str_appgeninfo.sucursal
				and tt_codigo = '1'
				and tt_ioe = 'D'
				and mt_codigo = :ls_numnd;
			
		Case '1'
                  //Actualiza en la tabla "fa_ctacli" el campo cs_valche y cs_numche 
                  //del cliente, si no existe lo crea
				wf_crea_actualiza_cuenta(ls_cliente,ls_insfin,ls_cuenta,ld_valcheque)
				// inserta en cc_movim el movimiento de Abono/Cancelaci$$HEX1$$f300$$ENDHEX$$n 
				// Factura con Cheque con el  valor del cheque y el saldo deja en cero
				ls_numero = string(wf_nota_credito(ls_cliente,ll_factura,ld_valcheque,0.0,'5'))
				ld_fecha = dw_detalle_pago.GetItemDateTime(i,"rp_fecven")							
				//inserto los datos del cheque en la tabla cc_cheque con el #NC y la fecha del cheque
				insert into cc_cheque (tt_codigo,tt_ioe,em_codigo,su_codigo,mt_codigo,
		   	                    ch_secue,if_codigo,ch_cuenta,ch_numero,ch_fecha,ch_valor,ch_interes,ch_fecinte,
							  ch_pendiente,ch_fecefec,fp_codigo)
				values ('5','C',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,
		      	  	  :i,:ls_insfin,:ls_cuenta,:ls_numche,:ld_fecha,:ld_valcheque,null,null,'S',sysdate,:ls_fp);
				// tt_coddeb,tt_ioedeb,mt_coddeb  '1','D',ls_numnd  Nota de Debito por Factura
				// tt_codigo,tt_ioe   ,mt_codigo  '5','C',ls_numero  Nota de Credito por pago con cheque
				insert into cc_cruce (tt_coddeb,tt_ioedeb,mt_coddeb,tt_codigo,tt_ioe,
		      	                	 em_codigo,su_codigo,mt_codigo,cr_fecha,cr_valdeb,cr_valcre)
				values ('1','D',:ls_numnd,'5','C',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,sysdate,:ld_valcheque,0.0);
				update cc_movim
				set mt_saldo = mt_saldo - :ld_valcheque
				where em_codigo = :str_appgeninfo.empresa
				and su_codigo = :str_appgeninfo.sucursal
				and tt_codigo = '1'
				and tt_ioe = 'D'
				and mt_codigo = :ls_numnd;
		case '2' 	//Verifico y actualizo el saldo de las N/C, si existen
				lc =  dw_detalle_pago.Getitemdecimal(i,'rp_valor')
				ls_nc =  dw_detalle_pago.GetitemString(i,'rp_numdoc')
				if wf_actualiza_saldo_nc(ls_nc,lc) = -1 then return
				
		case else
				setnull(lch_kit)
				if  dw_detail.getitemstring(dw_detail.getrow(),"it_kit") = 'V' then
					lch_kit ='V'
				end if
				
				/*Asigna datos a los mov de debito*/
				// No va en esta seccion del codigo
				for li_i = 1 to dw_1.rowcount()
					dw_1.setitem(li_i,"mt_codigo",ls_numnd)
					dw_1.setitem(li_i,"ce_codigo",ls_cliente)
					dw_1.setitem(li_i,"ve_numero",ll_factura)			
					dw_1.setitem(li_i,"mt_kit",lch_kit)
					rc = long(ls_numnd) + 1
					ls_numnd = string(rc)
				next

				update pr_param
				set pr_valor = :rc
				where em_codigo = :str_appgeninfo.empresa
				and pr_nombre = 'NUM_ND';

	End choose
Next

//Datos auxiliares para el detalle de la factura de venta

if not ib_prof_fac then
	 cb_2.Text = '&Facturar Proforma'
	 ib_prof_fac = true
end if



//5.- Actualizo los datos de la factura
rc =  dw_master.update(true,false) 
if rc = 1 then
	 rc = dw_detail.update(true,false)
	 if rc = 1 then
	    rc = dw_detalle_pago.update(true,false)
		 if rc = 1 then
			dw_movim.settransobject(sqlca)
			rc = dw_movim.update(true,false)
		   If rc = 1 then
				dw_1.settransobject(sqlca)
				rc = dw_1.update(true,false)
				If rc = 1 then
				 dw_master.resetupdate()
				 dw_detail.resetupdate()
				 dw_detalle_pago.resetupdate()
				 dw_movim.resetupdate()
				 dw_1.resetupdate()
                   if wf_actualiza_saldo_cupo() = -1 then
				   rollback;
				   return
			      End if
				 sle_1.text = ''
				 update fa_caja
				 set cj_ticket = cj_ticket + 1
				 where em_codigo = :str_appgeninfo.empresa
				 and su_codigo = :str_appgeninfo.sucursal
				 and cj_caja = :str_appgeninfo.caja;
				 if sqlca.sqlcode <> 0 then
					messageBox('Error Interno', 'No se puede encontrar el siguiente n$$HEX1$$fa00$$ENDHEX$$mero de factura para la caja ' + &
									  str_appgeninfo.caja + 'Por favor reporte a sistemas el siguiente error : ' + sqlca.sqlerrtext )
					rollback;
					return
				 end if
				 
						 // En el caso de que se haya facturado a traves de pedidos de produccion
//						 If not isnull(is_numpedido) and is_numpedido<>"" then 
//							 UPDATE  PD_PEDIDO
//							 SET ESTADO = 'F'
//							 WHERE PE_CODIGO = :is_numpedido;
//							  if sqlca.sqlcode <> 0 then
//								messageBox('Error Interno', 'No se puede actualizar el pedido de produccion '+ sqlca.sqlerrtext )
//								rollback;
//								return
//							 end if
//						 End if			 
						
						 commit;  
						 this.PostEvent('ue_print')
						 //Refrescar la lista de pedidos
						 if dw_pedidos.visible then dw_pedidos.retrieve()
				 else
					  rollback;
					  return
					 end if			 
			  else
			   rollback;
			   return
			  end if			 				 
        else
		   rollback;
		   return
		  end if	
     else
	   rollback;
	   return
     end if
else
rollback;
return
end if

setpointer(arrow!)
end event

event close;call super::close;m_marco.m_archivo.m_imprimir.visible = true
gb_codigo_numerico = false
end event

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()
str_prodparam.corregir = true

end event

event closequery;long ll_xx, li, li_max
string ls, ls_pepa, ls_valstk, ls_kit
decimal lc_pedido
if dw_detail.modifiedcount() > 0 or dw_detail.deletedcount() > 0 then
ll_xx = Messagebox("Confirme " ,"$$HEX1$$bf00$$ENDHEX$$Hay cambios que no se han guardado, desea descartarlos?",Question!,YesNo!)
choose case ll_xx
 case 1 //si
//	if is_estado = '1' then
//		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Los cambios en la factura tienen que ser aceptados, revise sus datos y grabelos')
		message.returnValue = 0
		return
//	  li_max = dw_detail.RowCount()
//	  for li = 1 to li_max
//			ls = dw_detail.getitemstring(li,'codant')
//			lc_pedido = dw_detail.getitemnumber(li,'dv_candes')
//		 select it_codigo, it_valstk, it_kit
//			into :ls_pepa, :ls_valstk, :ls_kit
//			from in_item
//		  where em_codigo = :str_appgeninfo.empresa
//    		 and it_codant = :ls;	
//		if ls_valstk = 'S' then
//		// Cargo el stock disponible del producto que antes descargue
// 			f_carga_stock_sucursal_venta(ls_pepa, lc_pedido)
//		end if
//		next
//	 end if
//	if dw_master.uf_updateCommit(dw_master.getRow(), False) = -1 then
//		message.returnValue = 1
//	end if
//	return	 
	case 2
//		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Los cambios tienen que ser aceptados, revise sus datos y grabelos')
		message.returnValue = 1
		return
//	case 3
//		message.returnValue = 1
//	return
end choose
end if		
end event

event ue_retrieve;return 1

end event

event ue_firstrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_detail.SetFocus()
call super::ue_firstrow
end event

event ue_lastrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_detail.SetFocus()
call super::ue_lastrow
end event

event ue_nextrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_detail.SetFocus()
call super::ue_nextrow
end event

event ue_print;this.wf_prePrint()
dw_report.print()
dw_detalle_pago.Visible = false
dw_detail.Visible = true
ib_detalle_pago = false
cb_formpag.text = 'Detalle de Factura'
//setnull(is_observ)
dw_master.Reset()
dw_detail.Reset()
dw_master.uf_insertCurrentRow()
dw_master.SetFocus()
end event

event ue_priorrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_detail.SetFocus()
call super::ue_priorrow
end event

event ue_outedition;dw_detail.Reset()
dw_detalle_pago.Reset()
dw_master.Reset()
dw_master.InsertRow(0)
dw_master.SetFocus()
//dw_master.uf_insertCurrentRow()
end event

type dw_master from w_sheet_master_detail`dw_master within w_factura
integer x = 0
integer y = 0
integer width = 5202
integer height = 708
integer taborder = 0
string dataobject = "d_cabecera_venta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;//////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Si existen cambios en ciertos campos de la pantalla
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 20-Dec-2002  10:15
//////////////////////////////////////////////////////////////////

long ll_filact,ll_numero
decimal{2} lc_ivavalor,lc_valor,lc_subtot, lc_descue, lc_cargo, lc_valpag
string ls,ls_nomcli, ls_cliente, ls_filtro, ls_vendedor, ls_firma, ls_datos[],ls_tccodigo,ls_column,ls_actividad
char lch_cambven

this.accepttext()
ll_filact = dw_master.getRow()

// con el codigo del cliente
ls_column = getcolumnname()
CHOOSE CASE ls_column
case  'ce_codigo' 
	dw_detail.enabled = true
	ib_nograba = false
	ls_cliente = this.getitemstring(ll_filact,"ce_codigo")
    //encuentra el vendedor, si el cliente es exento de iva y la firma
	select ep_codigo, ce_cambven, ce_exiva, ce_firma,tc_codigo,ce_actividad,ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep)) 
	into :ls_vendedor, :lch_cambven,:ls, :ls_firma,:ls_tccodigo,:ls_actividad,:ls_nomcli
	from fa_clien
	where em_codigo = :str_appgeninfo.empresa
	and    ce_codigo = :ls_cliente;

	if sqlca.sqlcode = 100 then
//	is_mensaje = 'Cliente no registrado'
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Cliente no registrado")
	sle_1.text = ""
	return 1
	end if
	// encuentra si se puede facturar al cliente
	if wf_valida_cliente(ls_cliente,'ce_facturar') <> 1 then
	//is_mensaje = 'No se puede facturar a este cliente'
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede facturar a este cliente")
	sle_1.text = ""
	dw_detail.enabled = false
	ib_nograba = true
	return 1
	end if	
	
	
	if wf_valida_cliente(ls_cliente,'ce_estcre') <> 1 then
	//is_mensaje = 'No se puede facturar a este cliente'
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede facturar a este cliente")
	sle_1.text = ""
	dw_detail.enabled = false
	ib_nograba = true
	return 1
	end if	
	
	int li_plazo
	li_plazo = wf_valida_cliente(ls_cliente,'ce_plazo')
	st_plazo.text = string(li_plazo)
	
			
	// si no tiene vendedor se le asigna a la persona que esta en el sistema
	if isnull(ls_vendedor) then
	select ep_codigo
	into :ls_vendedor
	from no_emple
	where em_codigo = :str_appgeninfo.empresa	 
	and sa_login = :str_appgeninfo.username;
	end if
	
	// si es exento de iva
	if ls = 'S' then
		ii_excento_iva = 0
	else  
		// Encuentra el valor del Iva
		Select pr_valor
		into :ic_iva
		from pr_param
	     where em_codigo = :str_appgeninfo.empresa
		and pr_nombre = 'IVA';

		// encuentra el valor de descuento en efectivo
		Select pr_valor
		into :ic_descuento
		from pr_param
         where em_codigo = :str_appgeninfo.empresa
		and pr_nombre = 'DSC_SIF';	  
		if sqlca.sqlcode <> 0 Then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Valor en tabla pr_param no encontrado")
			return
		End if
		ic_descuento = ic_descuento / 100
		// bandera para el c$$HEX1$$e100$$ENDHEX$$lculo del iva
		ii_excento_iva = 1
	end if
	
	// registra ciertos datos en la cabecera
	sle_1.text = ls_nomcli
	this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
	this.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
	this.SetItem(ll_filact,"es_codigo",is_estado)
	this.SetItem(ll_filact,"bo_codigo",str_appgeninfo.seccion)
	this.SetItem(ll_filact,"ep_codigo",ls_vendedor)
	this.SetItem(ll_filact,"ce_firma",ls_firma)
	this.SetItem(ll_filact,"empleado",ls_vendedor)
     this.SetItem(ll_filact,"tc_codigo",ls_tccodigo)
	this.SetItem(ll_filact,"ce_actividad",ls_actividad)
	this.SetItem(ll_filact,"ce_cambven",lch_cambven)	
	dw_detail.reset()
	dw_detalle_pago.reset()


	// si se registra el n$$HEX1$$fa00$$ENDHEX$$mero preImpreso se inserta una fila en el detalle
	dw_detail.InsertRow(0)	
	dw_detail.setcolumn("codant")
	dw_detail.SetFocus()
////	dw_2.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
	
case 've_descue' 
	
	//lineas de c$$HEX1$$f300$$ENDHEX$$digo que aumento
	if data = '0' then
		ic_descuento = 0
	else
		// encuentra el valor de descuento en efectivo
		Select pr_valor
		into :ic_descuento
		from pr_param
         where em_codigo = :str_appgeninfo.empresa
		and pr_nombre = 'DSC_SIF';	  
		if sqlca.sqlcode <> 0 Then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Valor en tabla pr_param no encontrado")
			return
		End if
		ic_descuento = ic_descuento / 100
	end if
	// fin de las lineas de c$$HEX1$$f300$$ENDHEX$$digo que aumento
	

	// con el descuento
	lc_descue = dec(this.gettext())
	lc_subtot = this.GetItemdecimal(ll_filAct,"ve_subtot")
	lc_cargo = this.GetItemdecimal(ll_filAct,"ve_cargo")

	// actualiza los campos Total, Iva y Saldo
	lc_valor= lc_subtot - lc_descue
	this.SetItem(ll_filAct,"ve_neto",lc_valor)
	lc_ivavalor = round(dw_detail.getitemdecimal(1,"cc_totiva") * ic_iva,2)*ii_excento_iva
	this.SetItem(ll_filAct,"ve_iva",lc_ivavalor)
	lc_valpag = lc_valor + lc_ivavalor + lc_cargo
	this.SetItem(ll_filAct,"ve_valpag", lc_valpag)
   this.SetItem(ll_filAct,"ve_valletras", f_numero_a_letras(lc_valpag)) 
case  've_cargo'
	
	lc_cargo = dec(this.gettext())
	lc_valor= this.GetItemdecimal(ll_filAct,"ve_neto")
	lc_ivavalor= this.GetItemdecimal(ll_filAct,"ve_iva")
	lc_valpag = lc_valor + lc_ivavalor + lc_cargo
	this.SetItem(ll_filAct,"ve_valpag", lc_valpag)
   this.SetItem(ll_filAct,"ve_valletras", f_numero_a_letras(lc_valpag)) 
	
//case  've_numpre' 
//	// si se registra el n$$HEX1$$fa00$$ENDHEX$$mero preImpreso se inserta una fila en el detalle
//	dw_detail.InsertRow(0)	
//	dw_detail.setcolumn("codant")
//	dw_detail.SetFocus()
//	dw_2.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)

case  'empleado'

	ls_vendedor = gettext()
	setItem(ll_filAct,"ep_codigo",ls_vendedor)
	
//case 'fp_codigo'
//	dw_detail.reset()
//	dw_detail.insertrow(0)
	
END CHOOSE

end event

event dw_master::clicked;gb_codigo_numerico = true
str_cliparam.ventana = parent
str_cliparam.datawindow = dw_master
str_cliparam.fila = this.GetRow() 


end event

event dw_master::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"ve_fecha",f_hoy())
dw_detalle_pago.Reset()
end event

event dw_master::updatestart;call super::updatestart;LONG ll_row,li_count
decimal lc_subtotal
gb_codigo_numerico = true

/**/
ll_row = dw_detail.Getrow()
If ll_row = 0 Then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe detalle de la factura")
	Return 1
End if	


select count(1) into :li_count from fa_venta where es_codigo = 1;
if li_count > 100 then
return 1
end if

lc_subtotal = dw_detail.GetItemDecimal(ll_row,"cc_sum_subtot")
dw_master.SetItem(ll_row,"ve_subtot",lc_subtotal)
return 0
end event

event dw_master::itemerror;//messagebox("Error",is_mensaje)
return 1
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_factura
event ue_recuperar pbm_custom41
event ue_darimagen pbm_custom42
event ue_keydown pbm_dwnkey
event ue_darstk pbm_custom43
event ue_tabout pbm_dwntabout
event ue_nextfield pbm_dwnprocessenter
integer x = 14
integer y = 820
integer width = 5193
integer height = 980
integer taborder = 20
string dataobject = "d_detalle_venta"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_detail::ue_darimagen;call super::ue_darimagen;int li_fila, li
string ls_produ, ls

if prod_visible then
	prod_visible = false
	p_producto.Visible = false
else
prod_visible = true 
li_fila = this.getrow()
ls_produ = this.GetItemString(li_fila,'codant')
if not isnull(ls_produ) and ls_produ <> '' then
	Select it_imagen
	  into :ls
	  from in_item
    where em_codigo = :str_appgeninfo.empresa
	   and it_codant = :ls_produ;
	if sqlca.sqlcode <> 0 then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese primero un producto')
	end if
	p_producto.PictureName = ls
	p_producto.Height = 56.5
	p_producto.Width = 91.9
	p_producto.Visible = true
	for li = 1 to 10 //565 es el alto m$$HEX1$$e100$$ENDHEX$$ximo (factor 6)
		p_producto.Visible = false
		p_producto.Height = p_producto.Height+56.5
		p_producto.Width = p_producto.Width + 91.9//(919 es ancho m$$HEX1$$e100$$ENDHEX$$ximo)
		p_producto.Visible = true
	next
end if	
end if
end event

event dw_detail::ue_keydown;int li_fila, li
string ls_produ, ls, ls_k,ls_codant
char lch_cambia

li_fila = this.getrow()
if keydown(KeyF7!)  then
//	this.TriggerEvent('ue_darstk')
	if dw_consulta_stk.visible then
		dw_consulta_stk.visible = false
	else
	ls_produ = dw_detail.GetItemString(li_fila,'codant')
	if not isnull(ls_produ) and ls_produ <> '' then
		Select it_kit
		  into :ls_k
		  from in_item
		 where em_codigo = :str_appgeninfo.empresa
			and it_codant = :ls_produ;
		if sqlca.sqlcode <> 0 then
			messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese primero un producto')
		end if
		If ls_k = 'S' then 
			Select it_codigo
			  into :ls
			  from in_relitem
			 where em_codigo = :str_appgeninfo.empresa
				and it_codigo1 = ( select it_codigo
											from in_item
											where  em_codigo = :str_appgeninfo.empresa
											and it_codant = :ls_produ);
			if sqlca.sqlcode <> 0 then
				messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese primero un producto')
			end if
		else	
			Select it_codigo
			  into :ls
			  from in_item
			 where em_codigo = :str_appgeninfo.empresa
				and it_codant = :ls_produ
				and it_kit = 'N';
			if sqlca.sqlcode <> 0 then
				messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese primero un producto')
			end if
		End if
		dw_consulta_stk.SetTransObject(sqlca)
		dw_consulta_stk.Retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal, ls)
		
	end if	
	dw_consulta_stk.visible = true 
	end if
	
end if

If keydown(keydownarrow!) Then
	If li_fila = rowcount() Then
      ls_codant = 	getitemstring(li_fila,"codant")
	else
      ls_codant = 	getitemstring(li_fila + 1,"codant")		
	End if
	select it_preparado
	into:lch_cambia
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	If lch_cambia = 'S' Then
		this.settaborder("dv_precio",25)
	Else
		this.settaborder("dv_precio",0)
	End if
End if

If keydown(keyUpArrow!) Then
	If li_fila = 1 Then
      ls_codant = 	getitemstring(li_fila,"codant")
	else
      ls_codant = 	getitemstring(li_fila - 1,"codant")		
	End if
	select it_preparado
	into:lch_cambia
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	If lch_cambia = 'S' Then
		this.settaborder("dv_precio",25)
	Else
		this.settaborder("dv_precio",0)
	End if
End if


end event

event dw_detail::ue_tabout;integer li_filas

wf_insertarfila()
li_filas = dw_detail.insertrow(0)
dw_detail.scrolltorow(li_filas)
dw_detail.setrow(li_filas)
str_prodparam.precio = 0
setnull(str_prodparam.formula)
dw_detail.Modify("DataWindow.HorizontalScrollPosition='"+string(0)+"'")
dw_detail.setcolumn('codant')
dw_detail.setfocus()
end event

event dw_detail::ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event

event dw_detail::itemchanged;////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Si cambia uno de los  campos del detalle se ejecuta
// Revisado    : 06-Abril-2006
////////////////////////////////////////////////////////////////////

dwItemStatus lst_estado

long       ll_filActMaster,ll_nreg,ll_find
decimal{2} lc_prefab,lc_pedido, lc_stock,ld_null,lc_recargo,lc_preciodesc,lc_descprom
dec{4}     lc_costo
string     ls,ls_marca,ls_pepa, ls_nombre, ls_null, ls_codant,&
			  ls_valstk,tipo_descuento,ls_base,ls_param[2],ls_actividad,ls_itcodigo,ls_fp,ls_medida,ls_presentacion
char       lch_cambia,lch_kit, lch_aux,ls_columnname
decimal    ld_desc1, ld_desc2, ld_desc3
int        si_hay,li_fila,li_ivaitem,li_ajuste
boolean lb_aplica_descto_anio


this.accepttext()

/*Para aplicar descuentos a motos 2007*/
select pr_valor
into :lc_descprom
from pr_param
where pr_nombre = 'DESCPROM';



li_fila = this.getRow()
str_prodparam.fila = li_fila
ll_filActMaster = dw_master.getRow()

// si cambia el c$$HEX1$$f300$$ENDHEX$$digo del producto

CHOOSE CASE this.getcolumnname()
case 'codant' 
	//Aplica descuento a modelos de a$$HEX1$$f100$$ENDHEX$$os anteriores al actual
	ls = this.getitemstring(li_fila,"codant")
	if mid(ls,1,6) = 'EN200-' then lb_aplica_descto_anio = true 
	ll_nreg = dw_detail.rowcount()
	ll_find =  dw_detail.find("codant = '"+ls+"'",1, ll_nreg - 1)
	if ll_find <> 0 and ll_nreg <> 1 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el c$$HEX1$$f300$$ENDHEX$$digo...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(ll_find))
	end if
	
	
	// con este voy a buscar primero por codigo anterior 
	select ma_codigo,it_tiemsec,it_preparado,it_codigo, it_nombre, it_prefab, it_valstk,nvl(it_costo,0),it_kit,it_base,ub_codigo,decode(ub_codigo,'3','CANECA','6','GALON','7','LITRO','8','OCTAVO','1','UNIDAD','UNIDAD') 
	into :ls_marca,:li_ivaitem,:lch_cambia,:ls_pepa, :ls_nombre, :lc_prefab, :ls_valstk, :ic_costo, :lch_kit, :ls_base,:ls_medida,:ls_presentacion
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls
	and nvl(estado,'N') <> 'S'; 

   if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
		 select ma_codigo,it_tiemsec,it_preparado,it_codigo, it_codant, it_nombre, it_prefab, it_valstk,nvl(it_costo,0),it_kit,it_base,ub_codigo,decode(ub_codigo,'3','CANECA','6','GALON','7','LITRO','8','OCTAVO','1','UNIDAD','UNIDAD') 
		 into :ls_marca,:li_ivaitem,:lch_cambia,:ls_pepa, :ls_codant, :ls_nombre, :lc_prefab, :ls_valstk, :ic_costo, :lch_kit, :ls_base,:ls_medida,:ls_presentacion
		 from in_item
		 where em_codigo = :str_appgeninfo.empresa
		 and it_codbar = :ls
		 and nvl(estado,'N')<>'S';
			
		   If sqlca.sqlcode <> 0 then
  		  		this.ib_inErrorCascade = true
				setnull(ls_null)
   	      		setnull(ld_null)
				this.SetItem(li_fila,'codant',ls_null)
				this.setitem(li_fila,'dv_cantid',ld_null)
				this.setitem(li_fila,'dv_candes',ld_null)
		 		this.setitem(li_fila,'nombre',ls_null)
			  	this.SetItem(li_fila,"it_base",ls_null)				  				 
				this.setitem(li_fila,'dv_precio',ld_null)
				this.SetItem(li_fila,'dv_total',ld_null)
				This.setitem(li_fila, 'dv_motor',ls_null)
				this.setitem(li_fila, 'dv_chasis',ls_null)
				this.setitem(li_fila, 'dv_desc1',ld_null)
				this.setitem(li_fila, 'dv_desc2',ld_null)
				this.setitem(li_fila, 'dv_desc3',ld_null)
			  	this.SetItem(li_fila,"it_kit",ls_null)				
				str_prodparam.precio = 0
				setnull(str_prodparam.formula)
				beep (1)
				is_mensaje = 'No existe c$$HEX1$$f300$$ENDHEX$$digo de producto'
				return 1
		  	else
				this.SetItem(li_fila,"codant",ls_codant)
		  	end if	 
   end if 

  this.SetItem(li_fila,"it_kit",lch_kit)
   if li_fila > 1  then
		lch_aux = getitemstring(1,"it_kit")
		choose case lch_aux
			case 'N','S'
				if getitemstring(1,"it_kit") <> lch_kit then 
					if lch_kit = 'V' then
						this.SetItem(li_fila,'codant',ls_null)
						beep(1)
						is_mensaje  = 'No puede facturar vehiculo junto con items'
						return 1
					end if
				end if
			case 'V'
				if getitemstring(1,"it_kit") <> lch_kit then 
					if lch_kit = 'N' or lch_kit = 'S' then
						this.SetItem(li_fila,'codant',ls_null)
						beep(1)
						is_mensaje  = 'No puede facturar este item junto con veh$$HEX1$$ed00$$ENDHEX$$culo(s)'
						return 1
					end if
				end if	
		end choose
	end if

	
//filtrado para verificar si a este item le falta realizar el ajuste de egreso x preventa
	select it_codigo
	into :ls_itcodigo
	from in_ajuste
	where tm_codigo = '3'
	and tm_ioe = 'I'
	and em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion
	and it_codigo = :ls_pepa
	and da_estado = 'N';
//	ll_find = dw_2.find("it_codigo = '"+ls_pepa+"'",1,dw_2.rowcount())
	if ls_itcodigo = ls_pepa then
		deleterow(li_fila)
		ll_find = insertrow(0)
		scrolltorow(ll_find)
		is_mensaje  = 'Falta realizar egreso x preventa de este item'
		return 1
	end if
	

	If lch_cambia = 'S' Then
		this.settaborder("dv_precio",25)
	Else
		this.settaborder("dv_precio",0)
	End if
	

	select nvl(it_recargo,0)
	into :lc_recargo
	from in_itesucur
	where em_codigo = : str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and it_codigo = :ls_pepa; 
	
	if sqlca.sqlcode <> 0 then
		messageBox('Error Interno','No se encuentra producto: '+sqlca.sqlerrtext)
		return
	end if		

	lc_prefab = lc_prefab + lc_recargo
	// si debo validar el stock
	//Se debe verificar si por lo menos tengo 1 en stock en mi secci$$HEX1$$f300$$ENDHEX$$n
	if ls_valstk = 'S' then 		
		lc_pedido = 1.0
		//	si_hay = f_dame_stock_sucursal (ls_pepa, lc_pedido, lc_stock)
	   lc_stock = lc_pedido
		// controla si hay stock mayor que 1 en la bodega
		si_hay = f_dame_stock_bodega_real(str_appgeninfo.seccion,ls_pepa,lc_stock)
	   if si_hay = 1 then // si existe por lo menos uno disponible
		
			this.setitem(li_fila, 'dv_cantid', 1)
			this.setitem(li_fila, 'dv_candes', 1)
			this.setitem(li_fila, 'nombre',ls_nombre)
			this.setitem(li_fila, 'dv_precio', lc_prefab)
			this.setitem(li_fila, 'it_codigo',ls_pepa)
			this.setitem(li_fila, 'it_kit',lch_kit)			
			this.setitem(li_fila, 'it_tiemsec',li_ivaitem)									
			this.setitem(li_fila, 'it_costo',ic_costo)
			this.setitem(li_fila, 'ma_codigo',ls_marca)			
			this.setitem(li_fila, 'iva',ic_iva*ii_excento_iva)						
			this.setitem(li_fila, 'descto',ic_descuento)

			
		else // no hay ni uno disponible
	   	if si_hay = 0 then // aunque no hay 1 disponible si hay en stock 
	   		is_mensaje = 'No hay disponible este producto. Otra caja ha reservado la existencia ' + &
					      		'Stock en bodega: ' + string (lc_stock, '#,##0.00')
     	   else // no hay tampoco en stock
		        is_mensaje = 'No hay este producto en existencia en la sucursal.'
			end if 
		  //Inserto para la demanda insatisfecha
  		  	this.ib_inErrorCascade = true
		  	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n',is_mensaje)		 
		  	this.setitem(li_fila, 'dv_cantid', 1)
		  	this.setitem(li_fila, 'dv_candes', 0)
	     	this.setitem(li_fila, 'nombre',ls_nombre)
		  	this.setitem(li_fila, 'dv_precio', lc_prefab)
		  	this.setitem(li_fila, 'dv_desc1',0)
  	          this.setitem(li_fila, 'dv_desc2', 0)
	     	this.setitem(li_fila, 'dv_desc3', 0)
   	  	     this.setitem(li_fila, 'it_codigo',ls_pepa)
		  	this.SetItem(li_fila,"dv_total",0)
   	  	return 0
	 	end if // fin de si hay disponible
	else // de si valida stock
		this.setitem(li_fila, 'dv_cantid', 1)
		this.setitem(li_fila, 'dv_candes', 1)
 		this.setitem(li_fila, 'nombre',ls_nombre)
		this.setitem(li_fila, 'dv_precio', lc_prefab)
		this.setitem(li_fila, 'it_codigo',ls_pepa)
		this.setitem(li_fila, 'it_kit',lch_kit)			
	     this.setitem(li_fila, 'it_tiemsec',li_ivaitem)		
		this.setitem(li_fila, 'it_costo',ic_costo)		
		this.setitem(li_fila, 'ma_codigo',ls_marca)		
		this.setitem(li_fila, 'iva',ic_iva*ii_excento_iva)						
		this.setitem(li_fila, 'descto',ic_descuento)			
		
	end if // fin de si valida stock

	//Busco los descuentos del item por cliente
	ls_actividad = dw_master.getitemstring(dw_master.getrow(),"ce_actividad") /*pol$$HEX1$$ed00$$ENDHEX$$tica anterior :descuentos por tipo de cliente*/
	ls_fp  = dw_master.getitemstring(dw_master.getrow(),"fp_codigo")     /*politica nueva :  28-nov-07*/
	choose case ls_actividad
	case '1','2'
		if li_fila <> 1 and lch_kit = 'V' then
			dw_detail.deleterow(li_fila)		
			is_mensaje  ="S$$HEX1$$f300$$ENDHEX$$lo puede facturar una moto para este tipo de cliente"
			return	 1
		end if
	end choose


	select td_codigo
	into :tipo_descuento
	from in_descitem
	where em_codigo = : str_appgeninfo.empresa
	and it_codigo = :ls_pepa
	and es_codigo = :ls_actividad
	and di_vigente = 'S';

			
	
	select td_desc1,td_desc2,td_desc3
	into :ld_desc1,:ld_desc2,:ld_desc3
	from in_tippre
	where em_codigo = : str_appgeninfo.empresa
	and td_codigo = :tipo_descuento
	and td_vigente = 'S';
	
	if sqlca.sqlcode <> 0 then
		ld_desc1 = 0
		ld_desc2 = 0
		ld_desc3 = 0
	end if

	this.setitem(li_fila, 'dv_desc1',ld_desc1)
	this.setitem(li_fila, 'dv_desc2', ld_desc2)
	this.setitem(li_fila, 'dv_desc3',ld_desc3)
	ic_precio = lc_prefab
	ic_desc1 = ld_desc1
	ic_desc2 = ld_desc2
	ic_desc3 = ld_desc3	
	this.setitem(li_fila, 'it_codigo',ls_pepa)
	this.setitem(li_fila, 'it_kit',lch_kit)			
	this.setitem(li_fila, 'it_tiemsec',li_ivaitem)	
	this.setitem(li_fila, 'it_costo',ic_costo)		
	this.setitem(li_fila, 'ma_codigo',ls_marca)	
	this.setitem(li_fila, 'iva',ic_iva*ii_excento_iva)						
	this.setitem(li_fila, 'descto',ic_descuento)
	this.setitem(li_fila, 'it_base',ls_base)
	setnull(ls_null)
	This.setitem(li_fila, 'dv_motor',ls_null)
	this.setitem(li_fila, 'dv_chasis',ls_null)
	//Para verificar el costo del item al ingresar el codigo del item
	lc_preciodesc = (((lc_prefab * ((100 - ld_desc1)/100))*((100 - ld_desc2)/100))*((100 - ld_desc3)/100))
     lc_costo = ic_costo / (1 - ic_descuento) 
	if lc_preciodesc < lc_costo then
		If ld_desc1=0 and ld_desc2 = 0 and ld_desc3 = 0 Then		
	 		messagebox('Error','El precio no puede ser menor a $'+ string(lc_costo,'#,##0.00')+' d$$HEX1$$f300$$ENDHEX$$lares.')
		else
	  		messagebox('Error','El precio no puede ser menor a $'+ string(lc_costo,'#,##0.00')+' d$$HEX1$$f300$$ENDHEX$$lares~n~rTom$$HEX2$$f3002000$$ENDHEX$$en cuenta los descuentos?')
		End if
		setnull(ld_null)
		this.SetItem(li_fila,"codant",ls_null)	
		this.SetItem(li_fila,'nombre',ls_null)	
	  	this.SetItem(li_fila,"dv_cantid",ld_null)
	  	this.SetItem(li_fila,"dv_candes",ld_null)		  
		this.SetItem(li_fila,'dv_precio',0)		
		this.setitem(li_fila, 'dv_desc1',35)
		this.setitem(li_fila, 'dv_desc2', 0)
		this.setitem(li_fila, 'dv_desc3',0)
	  	this.SetItem(li_fila,"dv_total",0)		
		This.setitem(li_fila, 'dv_motor',ls_null)		  
	  	this.SetItem(li_fila,"it_base",ls_null)				  
	  	this.SetItem(li_fila,"it_kit",ls_null)		  
		str_prodparam.precio = 0
		setnull(str_prodparam.formula)
		wf_encera_pago()
		wf_calcula_valores()		
		return 2	
	End if
	if not isnull(ls_base) then
		str_prodparam.codant = ls_pepa
		str_prodparam.cod_base = ls_base
		str_prodparam.medida=ls_medida
		
		open(w_color_preparado_sif)
	end if	
	if lch_kit = 'V' then
		openwithparm(w_venta_vehiculo,ls_pepa)
		if Message.StringParm = 'V' then
			setnull(Message.stringParm)
			ll_find =  dw_detail.find("dv_motor = '"+str_prodparam.motor+"'",1, ll_nreg - 1)
			if ll_find <> 0 and ll_nreg <> 1 then
				deleterow(li_fila)									
				is_mensaje = "Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el veh$$HEX1$$ed00$$ENDHEX$$culo con motor: "+str_prodparam.motor+" ...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(ll_find)
				return 1
			end if
			this.setitem(li_fila,'dv_motor',str_prodparam.motor)
			this.setitem(li_fila,'dv_chasis',str_prodparam.chasis)	

			/*Promocion para EN200-, A$$HEX1$$d100$$ENDHEX$$O=2007, FP = CONTADO DISTRIBUIDOR*/
			if str_prodparam.anio = '2007' and lb_aplica_descto_anio and ls_fp = '136' then
			this.setitem(li_fila, 'dv_desc3',lc_descprom)
			end if
		else
			setnull(Message.stringParm)				
			deleterow(li_fila)
			return
		end if
		setcolumn('dv_cantid')
		setfocus()
	end if
		

case  'dv_cantid'
	lc_pedido = this.GetItemNumber(li_fila,'dv_cantid') 
	if lc_pedido <= 0 then
		this.SetItem(li_fila,'dv_cantid',this.GetItemNumber(li_fila,'dv_cantid'))
		is_mensaje = 'La cantidad debe ser mayor a cero  y solo numeros enteros'
		return 1
	end if
	ls_codant = this.getitemstring(li_fila,'codant')
	select it_codigo, it_nombre, it_prefab, it_valstk,it_kit,it_costo
	into :ls_pepa, :ls_nombre, :lc_prefab, :ls_valstk,:lch_kit,:lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant
	and nvl(estado,'N')<>'S';
	
	if lch_kit = 'V' then
		if lc_pedido > 1 then
			is_mensaje = 'La cantidad debe ser uno (1) para este item'
			return 1
		end if
	end if
	if ls_valstk = 'S' then

		  If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit) = false then
		      messagebox("Error","El stock en sucursal del producto ["+ls_codant+"] = "+string(lc_stock)+"~r~n"+&
							"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>",stopsign!)
			   setitem(li_fila,"dv_candes",lc_stock)
		  end if
		
		  If f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_pepa,lch_kit,lc_pedido) = false then
				messagebox("Error","El stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)+"~r~n"+&
								"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>",stopsign!)
			   setitem(li_fila,"dv_candes",lc_pedido)
		  End if
	End if
	this.setitem(li_fila,"dv_candes",lc_pedido)	
case 'dv_precio'	
	if wf_cambia_precio_desc() = -1 Then 
		this.SetItem(li_fila,'dv_precio',ic_precio)			
		wf_encera_pago()
		wf_calcula_valores()
		//wf_suma_pagos()
		return 1
	end if
case 'dv_desc1'
	if wf_cambia_precio_desc() = -1 Then 
		this.SetItem(li_fila,'dv_desc1',ic_desc1)	
		wf_encera_pago()
		wf_calcula_valores()
		//wf_suma_pagos()
		return 1
	End if
	
case 'dv_desc2'
	if wf_cambia_precio_desc() = -1 Then 
		this.SetItem(li_fila,'dv_desc2',ic_desc2)	
		wf_encera_pago()
		wf_calcula_valores()
		//wf_suma_pagos()
		return 1
	End if

case 'dv_desc3'
	if wf_cambia_precio_desc() = -1 Then 
		this.SetItem(li_fila,'dv_desc3',ic_desc3)	
		wf_encera_pago()
		wf_calcula_valores()
		//wf_suma_pagos()
		return 1
	End if

End choose	

//encera ciertos campos de la cabecera
wf_encera_pago()

// encuentra el valor neto, iva y total a pagar en numeros y 
//letras de la cabecera
wf_calcula_valores()

// calcula ciertos campos de la cabecera de acuerdo a el pago y los
//descuentos
//wf_suma_pagos()

end event

event dw_detail::ue_postdelete;/////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Luego de borrar se llama a las funciones siguientes
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 18-Feb-1999
/////////////////////////////////////////////////////////////////////

// encera la cabecera de la factura
wf_encera_pago()
//Calcula el valor neto, el iva y el valor a pagar en numeros y letras
wf_calcula_valores()
// Calcula descuentos, Iva, Neto y Cambio seg$$HEX1$$fa00$$ENDHEX$$n el descuento que tenga
//wf_suma_pagos()
end event

event dw_detail::getfocus;char lch_modifica
decimal{2} lc_precio,lc_desc1,lc_desc2,lc_desc3,lc_total
long ll_candes

str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow()


lch_modifica = Message.StringParm
if getrow() > 0 Then
 If lch_modifica = 'S' Then //Si es una base
	this.setitem(str_prodparam.fila,"dv_precio",str_prodparam.precio)
	this.setitem(str_prodparam.fila,"dv_motor",str_prodparam.formula)
  	if wf_cambia_precio_desc() = -1 Then 
		this.SetItem(getrow(),'dv_precio',ic_precio)	
	else
		dw_detail.setitem(str_prodparam.fila,"dv_desc1",0.00)	
		ll_candes = dw_detail.getitemnumber(str_prodparam.fila,"dv_candes")		
		lc_precio = dw_detail.getitemdecimal(str_prodparam.fila,"dv_precio")
		lc_desc1 = dw_detail.getitemdecimal(str_prodparam.fila,"dv_desc1")
		lc_desc2 = dw_detail.getitemdecimal(str_prodparam.fila,"dv_desc2")
		lc_desc3 = dw_detail.getitemdecimal(str_prodparam.fila,"dv_desc3")
		lc_total = ll_candes*(((lc_precio * ((100 - lc_desc1)/100))*((100 - lc_desc2)/100))*((100 - lc_desc3)/100))
		dw_detail.setitem(str_prodparam.fila,"dv_total",lc_total)					
	End if

	wf_encera_pago()
	wf_calcula_valores()
	setnull(Message.StringParm)
 End if
End if

end event

event dw_detail::itemfocuschanged;string ls_codant
char lch_cambia

If dwo.name = "dv_desc3" Then 
   ls_codant =	this.getitemstring(row,"codant")

   if isnull(ls_codant) Then return	 
	select it_preparado
	into:lch_cambia
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;	
	If lch_cambia = 'S' Then
		this.settaborder("dv_precio",25)
	Else
		this.settaborder("dv_precio",0)
	End if

End if

end event

event dw_detail::itemerror;integer li_candes

if dwo.name = "codant" Then
	messagebox("Error",is_mensaje,stopsign!)
	return 1
End if

if dwo.name = "dv_cantid" Then
   setnull(li_candes)
	this.setitem(row,"dv_cantid",li_candes)
	this.setitem(row,"dv_candes",li_candes)
	messagebox("Error",is_mensaje,stopsign!)
	return 1
End if
if dwo.name = "dv_precio" then 
	return 1
End if
if dwo.name = "dv_desc1" then 
	return 1
End if
if dwo.name = "dv_desc2" then 
	return 1
End if
if dwo.name = "dv_desc3" then 
	return 1
End if
end event

event dw_detail::rowfocuschanged;string ls_itcodigo,ls_codant,ls_base
char lch_cambia,lch_kit
dec{2} lc_precio

If currentrow < 1 Then return
ls_codant = this.GetItemString(currentrow,"codant")
//ls_itcodigo = this.GetItemString(currentrow,"it_codigo")
//ls_base = this.GetItemString(currentrow,"it_base")
//lc_precio = this.GetItemdecimal(currentrow,"dv_precio")

if isnull(ls_codant) Then return
select it_preparado,it_kit
into:lch_cambia,:lch_kit
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codant = :ls_codant;

If lch_cambia = 'S' Then
	this.settaborder("dv_precio",25)
Else
	this.settaborder("dv_precio",0)
End if

//If not isnull(ls_base) Then	
//	str_prodparam.codant = ls_itcodigo
//	str_prodparam.cod_base = ls_base
//	str_prodparam.precio = lc_precio
//Else
//	setnull(str_prodparam.codant)
//	setnull(str_prodparam.cod_base)
//	str_prodparam.precio = 	0
//End if



end event

event dw_detail::clicked;char lch_cambia
string ls_codant

str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 

accepttext()
If dwo.name = 'dv_desc3' Then
   ls_codant = getitemstring(row,"codant")
	select it_preparado
	into:lch_cambia
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	If lch_cambia = 'S' Then
		this.settaborder("dv_precio",25)
	Else
		this.settaborder("dv_precio",0)
	End if
End if
end event

event dw_detail::doubleclicked;int li_i
Dec{2} lc_valor,lc_precio,lc_desc1,lc_desc2,lc_desc3,lc_total,lc_preciodesc,lc_descue,lc_dscsif
dec{4} lc_costo
long ll_candes,ll_row
String ls_fp
char lch_kit,lch_aplicadscto

this.accepttext()

/*Evitar el descto del 5% Adic si la forma de pago no tiene habilitado Aplicar descuento*/
ll_row = dw_master.getrow()

if ll_row  = 0 then return
ls_fp =  dw_master.Object.fp_codigo[ll_row]

SELECT FP_DESCUE
INTO :lch_aplicadscto
FROM FA_FORMPAG
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND FP_CODIGO = :ls_fp;

if lch_aplicadscto = 'N' or isnull(lch_aplicadscto) or lch_aplicadscto = '' then return



If dwo.name = 'dv_desc2' Then
	lc_descue = getitemdecimal(row,'dv_desc2')
	if isnull(getitemstring(row,'codant')) or 	trim(getitemstring(row,'codant'))= "" then return
	If lc_descue = 0 Then
		lch_kit = getitemstring(row,'it_kit')			
		if lch_kit <> 'V' then 
			Select pr_valdec
			into :lc_dscsif
			from pr_param
			where em_codigo = :str_appgeninfo.empresa
			and pr_nombre = 'DSC_SIF';
			if sqlca.sqlcode <> 0 Then
			  messagebox('Error Interno','Problemas con descuento en efectivo SIF...<Informe a sistemas>')
			  return
			End if	
			for li_i = 1 to this.rowcount()
				setitem(li_i,"dv_desc2",lc_dscsif)
				ll_candes = dw_detail.getitemnumber(li_i,"dv_candes")				
				lc_precio = dw_detail.getitemdecimal(li_i,"dv_precio")
				lc_desc1 = dw_detail.getitemdecimal(li_i,"dv_desc1")
				lc_desc2 = dw_detail.getitemdecimal(li_i,"dv_desc2")
				lc_desc3 = dw_detail.getitemdecimal(li_i,"dv_desc3")
				lc_total = ll_candes*(((lc_precio * ((100 - lc_desc1)/100))*((100 - lc_desc2)/100))*((100 - lc_desc3)/100))
				dw_detail.setitem(li_i,"dv_total",lc_total)				
			next
		else
			Select pr_valdec
			into :lc_dscsif
			from pr_param
			where em_codigo = :str_appgeninfo.empresa
			and pr_nombre = 'DSC_MOTO';
			if sqlca.sqlcode <> 0 Then
			  messagebox('Error Interno','Problemas con descuento en efectivo de motos...<Informe a sistemas>')
			  return
			End if				
			for li_i = 1 to this.rowcount()
				setitem(li_i,"dv_desc2",lc_dscsif)
				ll_candes = dw_detail.getitemnumber(li_i,"dv_candes")				
				lc_precio = dw_detail.getitemdecimal(li_i,"dv_precio")
				lc_desc1 = dw_detail.getitemdecimal(li_i,"dv_desc1")
				lc_desc2 = dw_detail.getitemdecimal(li_i,"dv_desc2")
				lc_desc3 = dw_detail.getitemdecimal(li_i,"dv_desc3")
				lc_total = ll_candes*(((lc_precio * ((100 - lc_desc1)/100))*((100 - lc_desc2)/100))*((100 - lc_desc3)/100))
				dw_detail.setitem(li_i,"dv_total",lc_total)				
			next	
		End if
	else
		for li_i = row to this.rowcount()
			 setitem(li_i,"dv_desc2",0.00)
			ll_candes = dw_detail.getitemnumber(li_i,"dv_candes")				
			lc_precio = dw_detail.getitemdecimal(li_i,"dv_precio")
			lc_desc1 = dw_detail.getitemdecimal(li_i,"dv_desc1")
			lc_desc2 = dw_detail.getitemdecimal(li_i,"dv_desc2")
			lc_desc3 = dw_detail.getitemdecimal(li_i,"dv_desc3")
			lc_total = ll_candes*(((lc_precio * ((100 - lc_desc1)/100))*((100 - lc_desc2)/100))*((100 - lc_desc3)/100))
			dw_detail.setitem(li_i,"dv_total",lc_total)
		next	
	End if	
End if

//If dwo.name = 'dv_desc3' Then
//	lc_valor = This.GetItemDecimal(row,"dv_desc3")
//	for li_i = row to this.rowcount()
//	   setitem(li_i,"dv_desc3",lc_valor)
//		ll_candes = dw_detail.getitemnumber(li_i,"dv_candes")
//		lc_precio = dw_detail.getitemdecimal(li_i,"dv_precio")
//		lc_costo = dw_detail.getitemdecimal(li_i,"it_costo")		
//		lc_desc1 = dw_detail.getitemdecimal(li_i,"dv_desc1")
//		lc_desc2 = dw_detail.getitemdecimal(li_i,"dv_desc2")
//		lc_desc3 = dw_detail.getitemdecimal(li_i,"dv_desc3")
//		lc_preciodesc = (((lc_precio * ((100 - lc_desc1)/100))*((100 - lc_desc2)/100))*((100 - lc_desc3)/100))
//		lc_costo = lc_costo / (1 - ic_descuento) 
//		if lc_preciodesc < lc_costo then
//		 	messagebox('Error','El precio no puede ser menor a $'+ string(lc_costo,'#,##0.00')+' d$$HEX1$$f300$$ENDHEX$$lares.')
//			lc_desc3 = 0.00 
//			SetItem(li_i,'dv_desc3',lc_desc3)
//		End if
//
//		lc_total = ll_candes*(((lc_precio * ((100 - lc_desc1)/100))*((100 - lc_desc2)/100))*((100 - lc_desc3)/100))
//		dw_detail.setitem(li_i,"dv_total",lc_total)
//	next	
//End if
//
wf_encera_pago()
wf_calcula_valores()

end event

event dw_detail::buttonclicked;call super::buttonclicked;String ls_pepa
Long   ll_find,ll_nreg
ll_nreg = this.rowcount()

if dwo.name = 'b_1' then
////	if lch_kit = 'V' then
         ls_pepa = this.GetitemString(row,"it_codigo")
		openwithparm(w_venta_vehiculo,ls_pepa)
		if Message.StringParm = 'V' then
			setnull(Message.stringParm)
			ll_find =  dw_detail.find("dv_motor = '"+str_prodparam.motor+"'",1, ll_nreg - 1)
			if ll_find <> 0 and ll_nreg <> 1 then
				deleterow(row)									
				is_mensaje = "Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el veh$$HEX1$$ed00$$ENDHEX$$culo con motor: "+str_prodparam.motor+" ...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(ll_find)
				return 1
			end if
			this.setitem(row,'dv_motor',str_prodparam.motor)
			this.setitem(row,'dv_chasis',str_prodparam.chasis)	
      else
			this.setitem(row,'dv_motor',str_prodparam.motor)
			this.setitem(row,'dv_chasis',str_prodparam.chasis)	
	  end if
//		setcolumn('dv_cantid')
//		setfocus()
//	end if

end if
end event

type dw_report from w_sheet_master_detail`dw_report within w_factura
integer x = 105
integer y = 4
integer width = 2784
integer height = 732
integer taborder = 0
string dataobject = "dw_factura_remel_a4"
boolean hsplitscroll = true
end type

type cb_ubicacion from commandbutton within w_factura
integer x = 439
integer y = 708
integer width = 526
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ubicaci$$HEX1$$f300$$ENDHEX$$n Geogr$$HEX1$$e100$$ENDHEX$$fica"
end type

event clicked;long ll_filmas
string ls_cliente, ls_yaesta

ll_filmas = dw_master.GetRow()
ls_cliente = dw_master.GetItemString(ll_filmas,'ce_codigo')
if not ib_ubica then
  SELECT CE_UBIGEO
    INTO :ls_yaesta  
    FROM FA_CLIEN
	where EM_CODIGO = :str_appgeninfo.empresa
	  and CE_CODIGO = :ls_cliente;
if sqlca.sqlcode <> 0 or isnull(ls_yaesta) then
	beep(1)
else
	p_ubicacion.Picturename = ls_yaesta
	p_ubicacion.Visible = true
	cb_ubicacion.text = 'Quitar Ubicaci$$HEX1$$f300$$ENDHEX$$n'
	ib_ubica = true
end if
else
	p_ubicacion.Visible = false
	ib_ubica = false
	cb_ubicacion.text ='Ubicaci$$HEX1$$f300$$ENDHEX$$n Geogr$$HEX1$$e100$$ENDHEX$$fica'
end if
end event

type cb_1 from commandbutton within w_factura
integer x = 965
integer y = 708
integer width = 526
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Par$$HEX1$$e100$$ENDHEX$$metros de Cr$$HEX1$$e900$$ENDHEX$$dito"
end type

event clicked;long ll_plazo
string ls_cliente, ls, ls_mensaje, ls_clase
decimal{2} lc_saldo
char lch_factura

ls_cliente = dw_master.GetITemString(dw_master.GetRow(),'ce_codigo')
if isnull(ls_cliente) or ls_cliente = '' then
	ls_mensaje = 'Seleccione un cliente'
else
	SELECT CE_SALCRE, CE_PLAZO, CE_ESTCRE,CE_FACTURAR,CA_DESCRI 
	      INTO :lc_saldo, :ll_plazo, :ls,:lch_factura, :ls_clase
	    FROM FA_CLIEN , FA_CLACLI
	 WHERE FA_CLIEN.EM_CODIGO = FA_CLACLI.EM_CODIGO
	        AND FA_CLIEN.CA_CODIGO = FA_CLACLI.CA_CODIGO
	        AND FA_CLIEN.CE_CODIGO = :ls_cliente
		   AND FA_CLIEN.EM_CODIGO = :str_appgeninfo.empresa;
		

	if sqlca.sqlcode <> 0 then
		ls_mensaje = 'Cliente no registrado'
	else
		CHOOSE CASE ls
			CASE 'A'
				ls = 'Aceptado'
			CASE 'S'
				ls = 'Suspendido'
			CASE 'N'
				ls = 'Negado'
			CASE 'E'
				ls = 'En estudio'
		END CHOOSE

		ls_mensaje = 'Codigo: ' + ls_cliente + "~n" + &
							 'Estado del Cr$$HEX1$$e900$$ENDHEX$$dito: ' + ls + "~n" + &
							 'Saldo del Cupo de Cr$$HEX1$$e900$$ENDHEX$$dito: ' + string(lc_saldo,'#,##0.00') + "~n" + &
							 'Plazo m$$HEX1$$e100$$ENDHEX$$ximo (d$$HEX1$$ed00$$ENDHEX$$as): ' + string(ll_plazo,'#,##0') + "~n" + &
							 'Clase: ' + ls_clase + "~n" + &
							 'Facturar: ' + lch_factura
	end if
end if
messageBox('Par$$HEX1$$e100$$ENDHEX$$metros de Cr$$HEX1$$e900$$ENDHEX$$dito',ls_mensaje)
end event

type cb_2 from commandbutton within w_factura
integer x = 1490
integer y = 708
integer width = 439
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Facturar Proforma"
end type

event clicked;long li
if  ib_prof_fac then
	 cb_2.Text = '&Cancelar Proceso'
	 ib_prof_fac = false
	 if dw_detail.RowCount() > 0 then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe terminar su trabajo pendiente antes de facturar una proforma')
		return
	 end if
	  dw_sel_numero.Reset()
	  dw_sel_numero.InsertRow(0)
	  dw_sel_numero.Visible = true
	  dw_sel_numero.SetFocus()
	  rollback;
else
	 ib_prof_fac = true
	 cb_2.Text = '&Facturar Proforma'	 
//	 rollback using sqlca;
//	 for li = 1 to dw_detail.RowCount() 
//       f_carga_stock_disponible_sucursal(dw_detail.GetItemString(li,'it_codigo'),dw_detail.GetItemNumber(li,'dv_candes'))
//	 next
	 dw_detail.Reset()
	 dw_detalle_pago.Reset()
	 dw_master.Reset()
	 sle_1.text = ''	 
	 dw_master.uf_insertCurrentRow()
	 dw_master.SetFocus()
     dw_sel_numero.reset()
	 dw_sel_numero.Visible = false
	 
end if
end event

type cb_3 from commandbutton within w_factura
integer x = 1929
integer y = 708
integer width = 439
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cliente &Gen$$HEX1$$e900$$ENDHEX$$rico"
end type

event clicked;datawindowchild ldwc_cliente
string ls_codigo

open(w_res_cliente_generico)
//ls_codigo = Message.stringParm
//If ls_codigo = '2' Then
//	commit;
//	dw_master.getChild("ce_codigo", ldwc_cliente)
//	ldwc_cliente.setTransObject(sqlca)
//	ldwc_cliente.retrieve(str_appgeninfo.empresa) 
//End if




end event

type cb_formpag from commandbutton within w_factura
integer x = 9
integer y = 708
integer width = 434
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Detalle de Pago"
end type

event clicked;/////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Crea Dw_child para el detalle de los pagos, hace visible
//               el detalle del pago e invisible el detalle de la factura
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 18-02-1999
/////////////////////////////////////////////////////////////////////

string ls_cliente, ls
long  ll_filActMaster
decimal {2} lc_valor,lc_valpag,lc_salcre
string ls_nulo, ls_codant, ls_observ, ls_motor, ls_chasis
integer i,li_cantid,li_i, li_fila=0
date ld_fecven
datetime hoy
datawindowchild ldwc_fp
long ll_numfilas
char lch_estcre, lch_facturar


dw_detail.AcceptText()
dw_master.AcceptText()
hoy =  f_hoy()
ll_filActMaster = dw_master.GetRow()
ll_numfilas = dw_detail.rowcount()
if ll_numfilas < 1 then return
dw_detalle_pago.Reset()
dw_1.reset()

lc_valpag = dw_master.GetItemDecimal(ll_filActMaster,'ve_valpag')
if ib_detalle_pago then
//	si ve_valpag no es cero o nulo
	if lc_valpag > 0 or not isnull(lc_valpag) then
		ls_observ = dw_master.GetItemString(ll_filActMaster,'ve_observ')
		ls_cliente = dw_master.GetItemString(ll_filActMaster,'ce_codigo')		
		ls_codant = dw_detail.GetItemString(ll_numfilas,'codant')
		if isnull(ls_codant) or ls_codant = '' then
			dw_detail.DeleteRow(ll_numfilas)			
		end if
		
		for i = 1 to ll_numfilas
			li_fila = dw_detail.find("it_kit = 'V'",i,ll_numfilas)
			if li_fila > 0 then
				ls_motor = dw_detail.getitemstring(li_fila,"dv_motor")
				ls_chasis = dw_detail.getitemstring(li_fila,"dv_chasis")	
				if (isnull(ls_motor) or trim(ls_motor)= "") or (isnull(ls_chasis) or trim(ls_chasis) = "") Then
					messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe antes ingresar el motor o chasis")
					return
				end if
			end if
		next
		f_recupera_empresa(dw_detalle_pago,'fp_codigo')
		dw_detalle_pago.getChild("fp_codigo", ldwc_fp)
		ldwc_fp.setTransObject(sqlca)

		if li_fila > 0 then
			ldwc_fp.setfilter("((fp_string like '%F%') and (fp_acumula = 'V')) or (fp_codigo = '24') or (fp_codigo = '136')")
		else
			ldwc_fp.setfilter("(fp_string like '%F%')")  //and isnull(fp_acumula)"
		end if
		ldwc_fp.filter()
		f_recupera_empresa(dw_detalle_pago,'if_codigo')
		
		select ce_salcre,ce_estcre,ce_facturar
		into :lc_salcre,:lch_estcre,:lch_facturar
		from fa_clien
		where ce_codigo = :ls_cliente
		AND em_codigo = :str_appgeninfo.empresa;
		
		 if lch_estcre <> 'A' then
			messageBox('Error','El cliente no puede acceder a ning$$HEX1$$fa00$$ENDHEX$$n cr$$HEX1$$e900$$ENDHEX$$dito. Verifique con Cartera')
			return
		 end if		

		 if lch_facturar <> 'S' then
			messageBox('Error','No se puede facturar a este cliente. Verifique con Cartera')
			return
		 end if		
		
		if lc_valpag > lc_salcre then
			messagebox('Error','El valor ingresado excede el cupo de cr$$HEX1$$e900$$ENDHEX$$dito: '+string(lc_salcre,'#,##0.00') +' del cliente...Verifique con Cartera')
			return
		end if	 

		dw_master.SetItem(ll_filActMaster,'ve_valotros',lc_valpag)				
		// si existe saldo y el detalle de pago es cero filas, inserta una fila
		// en el detalle de pago
		li_fila = dw_detalle_pago.InsertRow(0)
		dw_detalle_pago.SetItem(li_fila,'rp_valor',lc_valpag)		
		dw_detalle_pago.SetItem(li_fila,'rp_fecha',hoy)
		ld_fecven = relativedate(date(hoy),1)
		dw_detalle_pago.SetItem(li_fila,'rp_fecven',ld_fecven)
		li_fila = dw_1.InsertRow(0)
		dw_1.SetItem(li_fila,'mt_valor',lc_valpag)
		dw_1.SetItem(li_fila,'mt_saldo',lc_valpag)				
		dw_1.SetItem(li_fila,'mt_fecven',ld_fecven)
		dw_1.SetItem(li_fila,'mt_fecha',hoy)
		dw_1.SetItem(li_fila,'tt_codigo','1')
		dw_1.SetItem(li_fila,'tt_ioe','D')
		dw_1.SetItem(li_fila,'em_codigo',str_appgeninfo.empresa)
		dw_1.SetItem(li_fila,'su_codigo',str_appgeninfo.sucursal)
		dw_1.SetItem(li_fila,'bo_codigo',str_appgeninfo.seccion)
		dw_1.SetItem(li_fila,'es_codigo','1')
		dw_1.SetItem(li_fila,'rf_codigo',setnull(ls_nulo))
		dw_1.SetItem(li_fila,'mt_valret',0)								

		// hago visible el detalle de pago e invisible el detalle de la factura
		dw_detalle_pago.visible = true
		dw_detail.visible = false	
		// cambio el texto del bot$$HEX1$$f300$$ENDHEX$$n		
		cb_formpag.text = '&Detalle de Factura'
		dw_detalle_pago.SetFocus()
		ib_detalle_pago = false


	else
	  messagebox('Error','Ingrese primero los productos para luego cancelar')
	end if
else
	// si no existe detalle de pagos
	li_fila = dw_detalle_pago.insertrow(0)	
	dw_detalle_pago.SetItem(li_fila,'rp_fecha',hoy)
	ld_fecven = relativedate(date(hoy),1)
	dw_detalle_pago.SetItem(li_fila,'rp_fecven',datetime(ld_fecven))
	dw_master.SetItem(ll_filActMaster,'ve_efectivo',0)		
	dw_master.SetItem(ll_filActMaster,'ve_valotros',0)	
	dw_1.reset()
	dw_detail.visible = true
	dw_detalle_pago.visible = false
	cb_formpag.text = '&Detalle de Pago'
	ib_detalle_pago = true
end if

end event

type dw_sel_numero from datawindow within w_factura
event ue_keydwn pbm_dwnkey
boolean visible = false
integer x = 64
integer y = 40
integer width = 1047
integer height = 244
boolean titlebar = true
string title = "Ingrese el n$$HEX1$$fa00$$ENDHEX$$mero de documento"
string dataobject = "d_sel_retrieve"
boolean livescroll = true
end type

event ue_keydwn;if (KeyDown(KeyEscape!)) then
	this.Visible = false
end if
end event

event itemchanged;If wf_proforma_factura(long(data)) < 0 then
rollback using sqlca;
else
this.visible = false
end if
end event

type p_ubicacion from picture within w_factura
boolean visible = false
integer x = 1317
integer width = 1605
integer height = 684
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_movim from datawindow within w_factura
boolean visible = false
integer x = 18
integer y = 24
integer width = 215
integer height = 92
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_consulta_stk from datawindow within w_factura
event uekedwn pbm_dwnkey
boolean visible = false
integer y = 492
integer width = 2693
integer height = 1096
boolean titlebar = true
string title = "Stock por bodega"
string dataobject = "d_consulta_stk_productosxbodega"
boolean vscrollbar = true
boolean livescroll = true
end type

event uekedwn;if keydown(KeyEscape!) then
	this.visible = false
end if
end event

event clicked;dw_detail.setfocus()
end event

type p_producto from picture within w_factura
boolean visible = false
integer x = 14
integer y = 628
integer width = 1367
integer height = 796
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_factura
boolean visible = false
integer x = 3447
integer y = 12
integer width = 713
integer height = 324
boolean bringtotop = true
string dataobject = "d_cxc_calculo_cuotas_new"
boolean border = false
end type

type sle_1 from singlelineedit within w_factura
integer x = 709
integer y = 124
integer width = 1399
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_factura
boolean visible = false
integer x = 2363
integer y = 708
integer width = 453
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Facturar Pedidos"
end type

event clicked;dw_pedidos.visible = true
dw_pedidos.retrieve()

end event

type pb_1 from picturebutton within w_factura
integer x = 613
integer y = 108
integer width = 91
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean flatstyle = true
string picturename = "Custom090!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;if dw_master.getcolumnName() = 'ce_codigo' then
open(w_res_ubicaclientes)
else
return 1
end if
end event

type dw_pedidos from datawindow within w_factura
boolean visible = false
integer x = 2857
integer y = 20
integer width = 3026
integer height = 1408
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Lista de pedidos"
string dataobject = "d_pd_lista_pedidos"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;String ls_pepa,ls_itcodant,ls_itnombre,ls_codclie
Decimal lc_cantid,lc_pvp
Long ll_new

dw_detail.SetRedraw(false)
DECLARE C1 CURSOR  FOR

SELECT PD_DETPED.IT_CODIGO, DP_CANTID, DP_PVP ,IT_CODANT,IT_NOMBRE
FROM   PD_DETPED,IN_ITEM
WHERE IN_ITEM.IT_CODIGO = PD_DETPED.IT_CODIGO
AND PE_CODIGO = :is_numpedido;

If dwo.name = 't_2' Then
	
	dw_detail.AcceptText()
	is_numpedido = this.Object.pd_pedido_pe_codigo[row]
	ls_codclie = this.Object.pd_pedido_ce_codigo[row]
		
	dw_master.Object.ce_codigo[dw_master.getrow()] = ls_codclie
	dw_master.Setcolumn('ce_codigo')
	dw_master.triggerevent(itemchanged!)
	
	OPEN C1;
	FETCH C1 INTO :ls_pepa, :lc_cantid,:lc_pvp,:ls_itcodant,:ls_itnombre;
	DO WHILE SQLCA.sqlcode = 0
		  ll_new = dw_detail.Insertrow(0)
		  dw_detail.SetRow(ll_new)
		  dw_detail.Object.codant[ll_new]        = ls_itcodant
		  dw_detail.SetColumn('codant')
		  dw_detail.triggerevent(itemchanged!)
		  dw_detail.Object.dv_cantid[ll_new]    = lc_cantid
		  dw_detail.Setcolumn('dv_cantid')
		  dw_detail.triggerevent(itemchanged!)
		  dw_detail.Object.dv_precio[ll_new] = lc_pvp
  	      FETCH C1 INTO :ls_pepa, :lc_cantid,:lc_pvp,:ls_itcodant,:ls_itnombre;
	LOOP
	CLOSE C1;
	
	//elimina filas en blanco
	f_borra_filas_en_blanco(dw_detail,"codant")
	
End if
dw_detail.SetRedraw(true)
end event

type st_1 from statictext within w_factura
integer x = 2085
integer y = 516
integer width = 155
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Plazo:"
boolean focusrectangle = false
end type

type st_plazo from statictext within w_factura
integer x = 2304
integer y = 516
integer width = 133
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_2 from statictext within w_factura
integer x = 2450
integer y = 516
integer width = 329
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "d$$HEX1$$ed00$$ENDHEX$$as"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_factura
boolean visible = false
integer x = 2811
integer y = 712
integer width = 526
integer height = 108
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Informaci$$HEX1$$f300$$ENDHEX$$n de la gu$$HEX1$$ed00$$ENDHEX$$a"
end type

type dw_detalle_pago from uo_dw_detail within w_factura
boolean visible = false
integer y = 824
integer width = 4105
integer height = 980
integer taborder = 0
boolean titlebar = true
string title = "Detalle de Pago"
string dataobject = "d_detalle_pago"
end type

event itemchanged;int li_plazo,li_numcuota,li_plazocli,li_j
long ll_filact,ll_filcab, li_max, li_i
string ls_codigo,ls_cliente, ls,ls_nulo,ls_acumula
dec{2} lc_valor, lc_valotras=0.00, lc_total,lc_descuento=0.00,&
		 lc_iva,lc_efectivo =0.00,lc_salcre,lc_sumtot,lc_null,lc_valpag
dec{4} lc_cuota
datetime ld_fecven,hoy
date ld_fecvto
char lch_estcre


ll_filact = this.getrow()
li_max = this.RowCount()
ll_filcab = dw_master.getrow()
hoy = f_hoy()

lc_iva =  dw_master.Getitemdecimal(ll_filcab,"ve_iva")
if lc_iva > 0.00 then
	lc_iva = ic_iva
end if

if dwo.name = 'if_codigo' then
	ls_codigo = this.gettext()
	select if_minimo
	into :lc_valor
	from pr_instfin
	where em_codigo = :str_appgeninfo.empresa
	and if_codigo = :ls_codigo
	and if_activa = 'S';
	
	if sqlca.sqlcode <> 0 then
		messagebox('Error','Instituci$$HEX1$$f300$$ENDHEX$$n financiera no registrada o no activa')
		return 0
	end if
end if

if dwo.name = 'fp_codigo' then
	
	 ls_codigo = this.gettext()
	 ls_cliente = dw_master.GetItemString(dw_master.GetRow(),'ce_codigo')	 
	 dw_1.reset()
	 
	 select fp_plazo,fp_acumula
	 into :li_plazo,:ls_acumula
	 from fa_formpag  
	 where em_codigo = :str_appgeninfo.empresa
	 and fp_codigo = :ls_codigo
 	 and fp_utiliza = 'S';
	 
//	 for li_j = 1 to dw_detail.rowcount()
//		lc_descuento = dw_detail.getitemnumber(li_j,"dv_desc2")
//		If lc_descuento <> 0.00 and li_plazo > 1 Then
//			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Tiene descuentos en pago de contado...verif$$HEX1$$ed00$$ENDHEX$$que")
//		End if
//	 next

	 select ce_plazo,ce_salcre,ce_estcre
	 into :li_plazocli,:lc_salcre,:lch_estcre
	 from fa_clien
	 where ce_codigo = :ls_cliente
	 AND em_codigo = :str_appgeninfo.empresa;
	 
// 	if isnull(ls_acumula) or ls_acumula <> 'V'Then //No controla el plazo
	 if li_plazo > li_plazocli then
		messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')
	 end if
//	end if

 	 if lch_estcre <> 'A' then
		messageBox('Error','El cliente no puede acceder a ning$$HEX1$$fa00$$ENDHEX$$n cr$$HEX1$$e900$$ENDHEX$$dito. Verifique con Cartera')
	 end if

	 ld_fecven = datetime(relativedate(date(hoy),li_plazo))
	 if dw_master.getitemdecimal(ll_filcab,"cc_saldo") <> 0 then
		 this.SetItem(row,'rp_valor',dw_master.getitemdecimal(ll_filcab,"cc_saldo"))
	 end if
	 this.SetItem(row,'rp_fecven',ld_fecven)
	 this.SetItem(row,'rp_fecha',hoy)	

	for li_i = 1 to li_max
		accepttext()
		ls_codigo = this.GetItemString(li_i,'fp_codigo')
		lc_valor = this.GetItemdecimal(li_i,'rp_valor')
	
		select fp_numpag,fp_plazo
		into :li_numcuota,:li_plazo
		from fa_formpag
		where em_codigo = :str_appgeninfo.empresa
		and fp_codigo = :ls_codigo
		and fp_utiliza = 'S';

		if ls_codigo <> '0' or ls_codigo <> '1' then
			lc_cuota = lc_valor/li_numcuota	
			li_plazo = li_plazo/li_numcuota
			setitem(row,"cc_cuota",lc_cuota)
			setnull(ls_nulo)
			/*Ingresa los mov de debito segun el nro de cuotas*/
			for li_j = 1 to li_numcuota
				ll_filact=dw_1.InsertRow(0)
				dw_1.SetItem(ll_filact,'mt_valor',lc_cuota)
				dw_1.SetItem(ll_filact,'mt_saldo',lc_cuota)				
				ld_fecvto = Relativedate(date(hoy),li_plazo * li_j)
				dw_1.SetItem(ll_filact,'mt_fecven',ld_fecvto)
				dw_1.SetItem(ll_filact,'mt_fecha',hoy)
				dw_1.SetItem(ll_filact,'tt_codigo','1')
				dw_1.SetItem(ll_filact,'tt_ioe','D')
				dw_1.SetItem(ll_filact,'em_codigo',str_appgeninfo.empresa)
				dw_1.SetItem(ll_filact,'su_codigo',str_appgeninfo.sucursal)
				dw_1.SetItem(ll_filact,'bo_codigo',str_appgeninfo.seccion)
				dw_1.SetItem(ll_filact,'es_codigo','1')
				dw_1.SetItem(ll_filact,'rf_codigo',ls_nulo)
				dw_1.SetItem(ll_filact,'mt_valret',0)								
			next
			
		end if
		if ls_codigo = '0' then
			lc_efectivo += this.getItemdecimal(li_i,"rp_valor")
		else
			lc_valotras += this.getItemdecimal(li_i,"rp_valor")
		end if
	next
	dw_master.SetItem(ll_filcab,"ve_valotros",lc_valotras)
	dw_master.SetItem(ll_filcab,"ve_efectivo",lc_efectivo)
	
end if

if dwo.name = 'rp_valor' then
	lc_total =  dec(data)
	ls_cliente = dw_master.GetItemString(ll_filcab,'ce_codigo')
	ls_codigo = this.GetItemString(ll_filact,'fp_codigo')
	dw_1.reset()
	
	 select fp_plazo,fp_acumula
	 into :li_plazo,:ls_acumula
	 from fa_formpag  
	 where em_codigo = :str_appgeninfo.empresa
	 and fp_codigo = :ls_codigo
 	 and fp_utiliza = 'S';

//	for li_j = 1 to dw_detail.rowcount()
//		lc_descuento = dw_detail.getitemnumber(li_j,"dv_desc2")
//		If lc_descuento <> 0.00 and li_plazo > 1 Then
//			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Tiene descuentos en pago de contado...verif$$HEX1$$ed00$$ENDHEX$$que")
//		End if
//	 next

		select ce_plazo,ce_salcre,ce_estcre
		into :li_plazocli,:lc_salcre,:lch_estcre
		from fa_clien
		where ce_codigo = :ls_cliente
		AND em_codigo = :str_appgeninfo.empresa;
	
//	if isnull(ls_acumula) or ls_acumula <> 'V' Then //No controla el plazo	
		if li_plazo > li_plazocli then
			messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')		
		end if
//	end if

 	 if lch_estcre <> 'A' then
		messageBox('Error','El cliente no puede acceder a ning$$HEX1$$fa00$$ENDHEX$$n cr$$HEX1$$e900$$ENDHEX$$dito. Verifique con Cartera')
	 end if

	if lc_total > lc_salcre then
		messagebox('Error','El valor ingresado excede el cupo de cr$$HEX1$$e900$$ENDHEX$$dito: '+string(lc_salcre,'#,##0.00') +' del cliente')
		this.setitem(ll_filact,'rp_valor',lc_salcre)
	else
		this.setitem(ll_filact,'rp_valor',lc_total)
	end if
	
	lc_valpag = dw_master.getitemdecimal(ll_filcab,"ve_valpag")
	for li_i = 1 to li_max
		ls_codigo = this.GetItemString(li_i,'fp_codigo')
		lc_valor = this.GetItemdecimal(li_i,'rp_valor')
		
		if lc_valpag < lc_valor + lc_valotras + lc_efectivo then
			messagebox('Error','No puede haber cambio o vuelto en FXM')
			setitem(li_i,"rp_valor",lc_valpag - (lc_valotras + lc_efectivo))
			lc_valor = this.GetItemdecimal(li_i,'rp_valor')							
		end if
		
		select fp_numpag,fp_plazo
		into :li_numcuota,:li_plazo
		from fa_formpag
		where em_codigo = :str_appgeninfo.empresa
		and fp_codigo = :ls_codigo
		and fp_utiliza = 'S';
		
		if li_numcuota > 0 then
			lc_cuota = lc_valor/li_numcuota	
			li_plazo = li_plazo/li_numcuota
			setitem(li_i,"cc_cuota",lc_cuota)
			setnull(ls_nulo)
			for li_j = 1 to li_numcuota
				ll_filact=dw_1.InsertRow(0)
				dw_1.SetItem(ll_filact,'mt_valor',lc_cuota)
				dw_1.SetItem(ll_filact,'mt_saldo',lc_cuota)				
				ld_fecvto = Relativedate(date(hoy),li_plazo * li_j)
				dw_1.SetItem(ll_filact,'mt_fecven',ld_fecvto)
				dw_1.SetItem(ll_filact,'mt_fecha',hoy)
				dw_1.SetItem(ll_filact,'tt_codigo','1')
				dw_1.SetItem(ll_filact,'tt_ioe','D')
				dw_1.SetItem(ll_filact,'em_codigo',str_appgeninfo.empresa)
				dw_1.SetItem(ll_filact,'su_codigo',str_appgeninfo.sucursal)
				dw_1.SetItem(ll_filact,'bo_codigo',str_appgeninfo.seccion)
				dw_1.SetItem(ll_filact,'es_codigo','1')
				dw_1.SetItem(ll_filact,'rf_codigo',ls_nulo)
				dw_1.SetItem(ll_filact,'mt_valret',0)								
			next
		end if
		if ls_codigo = '0' then
			lc_efectivo += this.getItemdecimal(li_i,"rp_valor")
		else
			lc_valotras += this.getItemdecimal(li_i,"rp_valor")
		end if
	next
	dw_master.SetItem(ll_filcab,"ve_valotros",lc_valotras)
	dw_master.SetItem(ll_filcab,"ve_efectivo",lc_efectivo)
	this.ib_inErrorCascade = true						
	return 1
end if

If dwo.name	= 'rp_numdoc' then
		ls = this.GetText()
		ls_codigo = this.GetItemString(ll_filact,'fp_codigo')
		lc_total =  this.GetItemdecimal(ll_filact,'rp_valor')
		
		if ls_codigo = '2' then // 2 es NOTA DE CREDITO
			Select ve_valotros
			into :lc_valor
			from fa_venta
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and es_codigo = '9'			
			and ve_numero = :ls;
		   if sqlca.sqlcode <> 0 then
				messageBox('Error','No existe la N/C, verifique informaci$$HEX1$$f300$$ENDHEX$$n')
				this.SetItem(ll_filact,'rp_valor',0.00)
				return
			end if
         if lc_total > lc_valor then
			   messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La Nota de Cr$$HEX1$$e900$$ENDHEX$$dito solo tiene un saldo de '+string(lc_valor, "#,##0.00"))
				this.SetItem(ll_filact,'rp_valor',lc_valor)
				//Recalculamos valores cancelados	
				for li_i = 1 to li_max
					ls_codigo = this.GetItemString(li_i,'fp_codigo')

					if ls_codigo = '0' then
						lc_efectivo += this.getItemdecimal(li_i,"rp_valor")
					else
						lc_valotras += this.getItemdecimal(li_i,"rp_valor")
					end if			
				next

				dw_master.SetItem(ll_filcab,"ve_efectivo",lc_efectivo)
				dw_master.SetItem(ll_filcab,"ve_valotros",lc_valotras)
//				lc_valor = dw_master.getitemdecimal(ll_filcab,"ve_valpag")	
//				dw_master.SetItem(ll_filcab,"ve_cambio",lc_valor - (lc_efectivo + lc_valotras))				
				this.SetColumn('rp_fecha')
			end if
   end if				
end if

end event

event losefocus;call super::losefocus;integer li_i, li_numcuota, li_plazo, li_j, li_filact, li_filcab
string ls_codigo, ls_nulo
dec{2} lc_valor, lc_cuota, lc_efectivo, lc_valotras
date ld_fecvto
datetime ldt_hoy


li_filcab = dw_master.GetRow()

CHOOSE CASE this.getcolumnName()
CASE 'rp_numdoc'
if dw_master.GetItemdecimal(li_filcab,'cc_saldo') > 0.00 then
dw_1.reset()
dw_detalle_pago.SetFocus()
li_i = dw_detalle_pago.InsertRow(0)
ScrolltoRow(li_i)
ldt_hoy = f_hoy()

for li_i = 1 to rowcount()

	ls_codigo = this.GetItemString(li_i,'fp_codigo')
	lc_valor = this.GetItemdecimal(li_i,'rp_valor')

	select fp_numpag,fp_plazo
	into :li_numcuota,:li_plazo
	from fa_formpag
	where em_codigo = :str_appgeninfo.empresa
	and fp_codigo = :ls_codigo
	and fp_utiliza = 'S';
	
	if isnull(lc_valor) then
		setitem(li_i,"rp_valor",dw_master.getitemdecimal(li_filcab,"cc_saldo"))
		setitem(li_i,"rp_fecha",ldt_hoy)						
		ld_fecvto = Relativedate(date(ldt_hoy),li_plazo)		
		setitem(li_i,"rp_fecven",ld_fecvto)		
		lc_valor = this.GetItemdecimal(li_i,'rp_valor')
	end if
	

	lc_cuota = lc_valor/li_numcuota	
	li_plazo = li_plazo/li_numcuota
	setitem(li_i,"cc_cuota",lc_cuota)
	setnull(ls_nulo)
	for li_j = 1 to li_numcuota
		li_filact = dw_1.InsertRow(0)
		dw_1.SetItem(li_filact,'mt_valor',lc_cuota)
		dw_1.SetItem(li_filact,'mt_saldo',lc_cuota)				
		ld_fecvto = Relativedate(date(ldt_hoy),li_plazo * li_j)
		dw_1.SetItem(li_filact,'mt_fecven',ld_fecvto)
		dw_1.SetItem(li_filact,'mt_fecha',ldt_hoy)
		dw_1.SetItem(li_filact,'tt_codigo','1')
		dw_1.SetItem(li_filact,'tt_ioe','D')
		dw_1.SetItem(li_filact,'em_codigo',str_appgeninfo.empresa)
		dw_1.SetItem(li_filact,'su_codigo',str_appgeninfo.sucursal)
		dw_1.SetItem(li_filact,'bo_codigo',str_appgeninfo.seccion)
		dw_1.SetItem(li_filact,'es_codigo','1')
		dw_1.SetItem(li_filact,'rf_codigo',ls_nulo)
		dw_1.SetItem(li_filact,'mt_valret',0)								
	next
	if ls_codigo = '0' then
		lc_efectivo += this.getItemdecimal(li_i,"rp_valor")
	else
		lc_valotras += this.getItemdecimal(li_i,"rp_valor")
	end if
next
dw_master.SetItem(li_filcab,"ve_valotros",lc_valotras)
dw_master.SetItem(li_filcab,"ve_efectivo",lc_efectivo)

SetColumn('fp_codigo')

end if
END CHOOSE


end event

event ue_postdelete;string ls_codigo,ls_nulo
integer li_numcuota,li_plazo,li_filact,li_filcab,li_fp,li_cuota
date ld_fecvto
datetime hoy
dec{2} lc_valor,lc_cuota,lc_efectivo = 0.00,lc_valotras = 0.00

//wf_suma_pagos()

li_filact = this.getrow()
li_filcab = dw_master.getrow()
dw_1.reset()
hoy = f_hoy()
for li_fp = 1 to this.RowCount()
	ls_codigo = this.GetItemString(li_fp,'fp_codigo')
	lc_valor = this.GetItemdecimal(li_fp,'rp_valor')	
	if isnull(lc_valor) then return
	
	select fp_numpag,fp_plazo
	into :li_numcuota,:li_plazo
	from fa_formpag
	where em_codigo = :str_appgeninfo.empresa
	and fp_codigo = :ls_codigo
	and fp_utiliza = 'S';
	
	if li_numcuota > 0 then
		lc_cuota = lc_valor/li_numcuota	
		li_plazo = li_plazo/li_numcuota
		setitem(li_fp,"cc_cuota",lc_cuota)
		setnull(ls_nulo)
		for li_cuota = 1 to li_numcuota
			li_filact=dw_1.InsertRow(0)
			dw_1.SetItem(li_filact,'mt_valor',lc_cuota)
			dw_1.SetItem(li_filact,'mt_saldo',lc_cuota)				
			ld_fecvto = Relativedate(date(hoy),li_plazo * li_cuota)
			dw_1.SetItem(li_filact,'mt_fecven',ld_fecvto)
			dw_1.SetItem(li_filact,'mt_fecha',hoy)
			dw_1.SetItem(li_filact,'tt_codigo','1')
			dw_1.SetItem(li_filact,'tt_ioe','D')
			dw_1.SetItem(li_filact,'em_codigo',str_appgeninfo.empresa)
			dw_1.SetItem(li_filact,'su_codigo',str_appgeninfo.sucursal)
			dw_1.SetItem(li_filact,'bo_codigo',str_appgeninfo.seccion)
			dw_1.SetItem(li_filact,'es_codigo','1')
			dw_1.SetItem(li_filact,'rf_codigo',ls_nulo)
			dw_1.SetItem(li_filact,'mt_valret',0)								
		next
	end if
	if ls_codigo = '0' then
		lc_efectivo += this.getItemdecimal(li_fp,"rp_valor")
	else
		lc_valotras += this.getItemdecimal(li_fp,"rp_valor")
	end if			
next
dw_master.SetItem(li_filcab,"ve_efectivo",lc_efectivo)
dw_master.SetItem(li_filcab,"ve_valotros",lc_valotras)
//lc_valor = dw_master.getitemdecimal(li_filcab,"ve_valpag")	
//dw_master.SetItem(li_filcab,"ve_cambio",lc_valor - (lc_efectivo + lc_valotras))				

end event

event ue_postinsert;call super::ue_postinsert;datetime ldt_fecha
date ld_fecven

ldt_fecha = f_hoy()
ld_fecven = relativedate(date(ldt_fecha),1)
setitem(getrow(),"rp_fecha",ldt_fecha)
setitem(getrow(),"rp_fecven",ld_fecven)
end event

event updatestart;call super::updatestart;/*Validar que la forma de pago sea la del compromiso*/
String ls_fpcompromiso,ls_fp,ls_cliente
long ll_row
integer li_plazo,li_plazocli

ll_row = dw_master.getrow()
ls_cliente = dw_master.object.ce_codigo[ll_row]

 select ce_plazo
 into :li_plazocli
 from fa_clien
 where ce_codigo = :ls_cliente
 AND em_codigo = :str_appgeninfo.empresa;

ls_fpcompromiso = dw_master.Object.fp_codigo[ll_row]
ls_fp = this.object.fp_codigo[this.getrow()]


//Politica para REMEL existe varias formas de pago en una misma cancelaci$$HEX1$$f300$$ENDHEX$$n
//if ls_fp <> ls_fpcompromiso then
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No coincide la forma de pago con el compromiso de pago....<Por favor verifique>")
//	Rollback;
//	return 1
//end if
//

select fp_plazo
into :li_plazo
from fa_formpag  
where em_codigo = :str_appgeninfo.empresa
and fp_codigo = :ls_fp
and fp_utiliza = 'S';
	 
 
 if li_plazo > li_plazocli then
	messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')
	Rollback;
	return 1
 end if

end event


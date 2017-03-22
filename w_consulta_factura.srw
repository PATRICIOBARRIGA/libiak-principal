HA$PBExportHeader$w_consulta_factura.srw
forward
global type w_consulta_factura from w_sheet_master_detail
end type
type dw_detalle_pago from uo_dw_detail within w_consulta_factura
end type
type cb_formpag from commandbutton within w_consulta_factura
end type
type cb_ubicacion from commandbutton within w_consulta_factura
end type
type p_producto from picture within w_consulta_factura
end type
type p_ubicacion from picture within w_consulta_factura
end type
type dw_autoriza from datawindow within w_consulta_factura
end type
type dw_ubica from datawindow within w_consulta_factura
end type
end forward

global type w_consulta_factura from w_sheet_master_detail
integer width = 4073
integer height = 1644
string title = "Consulta de Facturas 13.07.2K13"
long backcolor = 79741120
event ue_consultar pbm_custom16
dw_detalle_pago dw_detalle_pago
cb_formpag cb_formpag
cb_ubicacion cb_ubicacion
p_producto p_producto
p_ubicacion p_ubicacion
dw_autoriza dw_autoriza
dw_ubica dw_ubica
end type
global w_consulta_factura w_consulta_factura

type variables
decimal ic_iva, ic_descuento
int il_descue, ii_intentos = 0,primera = 0
long ii_excento_iva
string  is_mensaje, is_estado='1',numero =''
boolean ib_detalle_pago = true
boolean ib_ubica = false,  prod_visible = false
integer ii_pagesize
end variables

forward prototypes
public function integer wf_valida_valor (string as_formpag, string as_inst_finan, decimal ac_valor)
public function integer wf_encera_pago ()
public function integer wf_suma_pagos ()
public function integer wf_nota_credito (string as_cliente, integer ai_factura, long ai_total, integer ai_saldo, string as_tipomov)
public function integer wf_nota_debito (string as_cliente, string ai_factura, long ai_total)
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, date ad_fecha, long al_factura)
public function integer wf_calcula_valores ()
end prototypes

event ue_consultar;call super::ue_consultar;dw_master.postevent(DoubleClicked!)
dw_detail.enabled = true
dw_master.enabled = true
end event

public function integer wf_valida_valor (string as_formpag, string as_inst_finan, decimal ac_valor);decimal minimo, maximo, minif, maxif
string tipo

select fp_minimo, fp_maximo
  into :minimo, :maximo
  from fa_formpag
 where em_codigo = :str_appgeninfo.empresa
   and fp_codigo = :as_formpag;

select if_minimo, if_maximo, if_tipo
  into :minif, :maxif, :tipo
  from pr_instfin
 where em_codigo = :str_appgeninfo.empresa
   and if_codigo = :as_inst_finan;

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

public function integer wf_encera_pago ();long ll_filact, ll_filactmaster
ll_filact = dw_detail.GetRow()
ll_filactmaster = dw_master.GetRow()
dw_master.SetItem(ll_filactmaster,'ve_efectivo',0)
dw_master.SetItem(ll_filactmaster,'ve_valotros',0)
dw_master.SetItem(ll_filactmaster,'ve_descue',0)
return 1
end function

public function integer wf_suma_pagos ();string ls_codigo, ls_descue
long ll_fila, ll_filact, ll_totfilas, ll_filcab, li_max, li
decimal lc_valor, lc_valotras=0, lc_total, lc_descuento, lc_iva, lc_cargo, lc_efectivo =0
ll_filact = dw_detalle_pago.getrow()
li_max = dw_detalle_pago.RowCount()
ll_filcab = dw_master.getrow()
il_descue = 1
if not isnull(li_max) and li_max > 0 then
 for li = 1 to li_max
	ls_codigo = dw_detalle_pago.GetItemString(li,'fp_codigo')
		select fp_descue
		  into :ls_descue
		  from fa_formpag
		 where em_codigo = :str_appgeninfo.empresa
		   and fp_codigo = :ls_codigo
			and fp_utiliza = 'S';
		if sqlca.sqlcode <> 0 then
			messagebox('Error','Forma de pago no registrada o no activa')
			return 1
		end if
			if ls_descue = 'N'  then
				il_descue = 0
			end if
			if ls_codigo = '0' then
				lc_efectivo += dw_detalle_pago.getItemNumber(li,"rp_valor")
			else
				lc_valotras += dw_detalle_pago.getItemNumber(li,"rp_valor")
			end if			
		next
	end if
		dw_master.SetItem(ll_filcab,"ve_efectivo",lc_efectivo)
	   dw_master.SetItem(ll_filcab,"ve_valotros",lc_valotras)
		lc_valor = dw_master.GetitemNumber(ll_filcab,"ve_subtot")	
		lc_cargo =  dw_master.GetitemNumber(ll_filcab,"ve_cargo")
		lc_descuento = round(lc_valor * ic_descuento *ii_excento_iva*il_descue,0)
		lc_iva = round((lc_valor - lc_descuento) * ic_iva*ii_excento_iva,0)
		dw_master.SetItem(ll_filcab,"ve_descue",lc_descuento)
		dw_master.SetItem(ll_filcab,"ve_iva",lc_iva)	
		dw_master.SetItem(ll_filcab,"ve_neto",lc_valor - lc_descuento)	
		lc_valor = lc_valor - lc_descuento + lc_iva + lc_cargo
  		dw_master.SetItem(ll_filcab,"ve_valpag", lc_valor )	
		dw_master.SetItem(ll_filcab,"ve_valletras", f_numero_a_letras(lc_valor)) 
	   dw_master.SetItem(ll_filcab,"ve_cambio",lc_valor - (lc_efectivo + lc_valotras))		
return 1
end function

public function integer wf_nota_credito (string as_cliente, integer ai_factura, long ai_total, integer ai_saldo, string as_tipomov);string ls_numero
dec    ll_numero

select pr_valor
  into :ll_numero
  from pr_param
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_NC';
	
if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo obtener el numero de la nota de credito "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

ls_numero = string(ll_numero)

insert into cc_movim(tt_codigo,tt_ioe,em_codigo,su_codigo,mt_codigo,
                     rf_codigo,ce_codigo,es_codigo,ve_numero,ig_numero,
							mt_valor,mt_fecha,mt_valret,mt_saldo,bo_codigo)
values(:as_tipomov,'C',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,
       null,:as_cliente,'1',:ai_factura,null,:ai_total,sysdate,0,
		 :ai_saldo,:str_appgeninfo.seccion);

if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo generar la nota de credito: "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

update pr_param
   set pr_valor = pr_valor + 1
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_NC';

return ll_numero
end function

public function integer wf_nota_debito (string as_cliente, string ai_factura, long ai_total);string ls_numero
dec    ll_numero

select pr_valor
  into :ll_numero
  from pr_param
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_NC';
	
if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo obtener el numero de la nota de credito "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

ls_numero = string(ll_numero)

insert into cc_movim(tt_codigo,tt_ioe,em_codigo,su_codigo,mt_codigo,
                     rf_codigo,ce_codigo,es_codigo,ve_numero,ig_numero,
							mt_valor,mt_fecha,mt_valret,mt_saldo,bo_codigo)
values('1','D',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,
       null,:as_cliente,'1',:ai_factura,null,:ai_total,sysdate,0,
		 :ai_total,:str_appgeninfo.seccion);

if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo generar la nota de credito: "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

update pr_param
   set pr_valor = pr_valor + 1
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_NC';

return ll_numero
end function

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, date ad_fecha, long al_factura);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
// sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=2, tm_ioe='E' es egreso por ventas
long ll_num_movim,ll_contador = 0
decimal ld_costo,ld_cantidad
string ls_num_movim, ls_factura,ls_es_kit,ls_componente
boolean lb_exito = TRUE
ls_factura = string(al_factura)
// busca los componentes de un kit
declare kit_cursor cursor for
   select it_codigo,ri_cantid
	  from in_relitem
	 where em_codigo = :str_appgeninfo.empresa
	   and it_codigo1 = :as_item
		and tr_codigo = '1';   
// inserto el movimiento del item
//ll_num_movim = f_dame_sig_numero('NUM_MINV')
ls_num_movim = string(ll_num_movim) 
insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                     mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
	     				   mv_observ,mv_usado)
values ('2','E',:as_item,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,
        :ls_num_movim,:ad_cantidad,0,:ad_fecha,:str_appgeninfo.empresa,
	     'Factura de Venta No. '||:ls_factura,'N');
if sqlca.sqlcode <> 0 then lb_exito = FALSE
if lb_exito then
// busca si el item es kit o no 
select it_kit
  into :ls_es_kit
  from in_item
 where em_codigo = :str_appgeninfo.empresa
   and it_codigo = :as_item;
if ls_es_kit = 'S' then	// es un kit
	open kit_cursor;
	do
		// se inserta los componentes del item tipo kit
		fetch kit_cursor into :ls_componente,:ld_cantidad;
		if sqlca.sqlcode <> 0 then exit;
//		ll_num_movim = f_dame_sig_numero('NUM_MINV')
		ls_num_movim = string(ll_num_movim)
		insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                       		mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
		  					  		mv_observ,mv_usado)
  		values ('2','E',:ls_componente,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,
          	  :ls_num_movim,:ad_cantidad*:ld_cantidad,0,:ad_fecha,:str_appgeninfo.empresa,
		    	  'Venta de Kit '||:as_item||' Factura No. '||:ls_factura,'N');
		if sqlca.sqlcode <> 0 then lb_exito = FALSE
	loop while TRUE;
	close kit_cursor;
end if // de si es kit
end if // de si lb_exito
if lb_exito then
	commit;
	return (TRUE)
else
	return(FALSE)
end if
end function

public function integer wf_calcula_valores ();long ll_filact, ll_filactmaster, ll_totfilas, ll_fila
decimal lc_valor, ll_valorsum, ll_subtot, ll_ivavalor, lc_valpag
string ls_val
ll_filact = dw_detail.GetRow()
ll_filactmaster = dw_master.GetRow()
if ll_filact > 0 then
dw_detail.AcceptText()
lc_valor= dw_detail.GetItemDecimal(ll_filact,"cc_subtot")
dw_detail.SetItem(ll_filact,"dv_total",lc_valor)

//inicializo la fila actual
	ll_totFilas = dw_detail.rowCount()

	for ll_fila = 1 to ll_totFilas
  	    ll_valorsum += dw_detail.getItemNumber(ll_fila,"dv_total")
	next
	dw_master.setItem(ll_filActMaster,"ve_subtot",ll_valorsum)

// actualiza los campos Total, Iva y Saldo
 ll_subtot= ll_valorsum - dw_master.GetItemNumber(ll_filActMaster,"ve_descue")
 dw_master.SetItem(ll_filActMaster,"ve_neto",ll_subtot)
 ll_ivavalor= round(ll_subtot*ic_iva,0)*ii_excento_iva
 dw_master.SetItem(ll_filActMaster,"ve_iva",ll_ivavalor)
 lc_valpag = ll_subtot + ll_ivavalor + dw_master.GetItemNumber(ll_filActMaster,"ve_cargo")
 dw_master.SetItem(ll_filActMaster,"ve_valpag",lc_valpag)
 ls_val = f_numero_a_letras(lc_valpag)
 dw_master.SetItem(ll_filActMaster,"ve_valletras",ls_val)
end if
return 1
end function

on w_consulta_factura.create
int iCurrent
call super::create
this.dw_detalle_pago=create dw_detalle_pago
this.cb_formpag=create cb_formpag
this.cb_ubicacion=create cb_ubicacion
this.p_producto=create p_producto
this.p_ubicacion=create p_ubicacion
this.dw_autoriza=create dw_autoriza
this.dw_ubica=create dw_ubica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detalle_pago
this.Control[iCurrent+2]=this.cb_formpag
this.Control[iCurrent+3]=this.cb_ubicacion
this.Control[iCurrent+4]=this.p_producto
this.Control[iCurrent+5]=this.p_ubicacion
this.Control[iCurrent+6]=this.dw_autoriza
this.Control[iCurrent+7]=this.dw_ubica
end on

on w_consulta_factura.destroy
call super::destroy
destroy(this.dw_detalle_pago)
destroy(this.cb_formpag)
destroy(this.cb_ubicacion)
destroy(this.p_producto)
destroy(this.p_ubicacion)
destroy(this.dw_autoriza)
destroy(this.dw_ubica)
end on

event open;call super::open;dw_master.SetTransObject(SQLCA)
dw_detail.SetTransObject(sqlca)
dw_detalle_pago.SetTransObject(sqlca)

end event

event ue_update;string ls_numpre
long ll_numero

dw_master.accepttext()
ls_numpre = dw_master.GetItemString(dw_master.getrow(),"ve_numpre")	
ll_numero = dw_master.GetItemNumber(dw_master.getrow(),"ve_numero")		
UPDATE FA_VENTA
SET VE_NUMPRE = :ls_numpre
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND  ES_CODIGO = 1
AND VE_NUMERO = :ll_numero;
If sqlca.sqlcode <> 0 Then
	rollback;
	messagebox("Error","Problemas al Actualizar el n$$HEX1$$fa00$$ENDHEX$$mero preimpreso")
	return
End if
commit;

end event

event close;//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = false
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = false
gb_codigo_numerico = false
//m_marco.m_edicion.m_consultar1.enabled = FALSE
//m_marco.m_edicion.m_consultar1.visible = FALSE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = FALSE

call super::close
end event

event ue_insert;call super::ue_insert;//str_prodparam.fila = dw_detail.GetRow()
//
end event

event ue_lastrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_master.SetFocus()
call super::ue_lastrow
dw_detail.enabled = true
dw_master.enabled = true
end event

event ue_nextrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_master.SetFocus()
call super::ue_nextrow
dw_detail.enabled = true
dw_master.enabled = true
end event

event ue_print;If f_permisos('sa_reimp') = 'S' Then
	 dw_autoriza.visible = true
	 dw_autoriza.reset()
	 dw_autoriza.insertrow(0)
	 dw_autoriza.SetFocus()
else
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","No tiene permiso para realizar reimpresiones")
	return
End if


	
end event

event ue_priorrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_master.SetFocus()
call super::ue_priorrow
dw_detail.enabled = true
dw_master.enabled = true
end event

event ue_outedition;call super::ue_outedition;dw_detail.Reset()
dw_detalle_pago.Reset()
dw_master.Reset()
dw_master.InsertRow(0)
dw_master.SetFocus()
//dw_master.uf_insertCurrentRow()
end event

event activate;call super::activate;
//m_marco.m_opcion2.m_facturacin.m_anularfactura.enabled = TRUE
//m_marco.m_opcion2.m_facturacin.m_anularfactura.visible = TRUE
//m_marco.m_opcion2.m_facturacin.m_anularfactura.toolbaritemvisible = TRUE
//m_marco.m_edicion.m_consultar1.enabled = TRUE
//m_marco.m_edicion.m_consultar1.visible = TRUE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = TRUE
end event

event ue_printcancel;dw_autoriza.Reset()
dw_autoriza.visible = false
this.ib_inReportMode = false

end event

event ue_retrieve;return 1
end event

event ue_anular;decimal  ld_cantidad
dec{2} ld_valor
datetime ldt_fecha,ldt_fecven,ldt_now
long     ll_totalreg,ll_i,ll_regactual,ll_factura,ll_entregado,ll_resul,ll_total_reg
long     ll_ig_num,i
string   ls_item,ls_sucursal,ls_bodega,ls_ch_pendiente,ls_num_movim,ls_sa_tipo
string   ls_num_nd, ls, ls_cliente,ls_factura,ls_fpcodigo,ls_rpnumdoc,ls_tipo,ls_motor
char     lch_tipo,lch_anula,lch_kit
int         li_res

//Debo verificar que la factura no haya sido contabilizada
//para hacer esto se debe aumentar un campo en la tabla FA_VENTA
//que me indique si la factura fue contabilizada o no
//Debo verificar que los creditos generados por la factura 
//no hayan sido ingresada a bancos, como son varios => cursor
setpointer(hourglass!)

ll_factura = dw_master.getitemnumber(dw_master.getrow(),"ve_numero")
ldt_fecha = dw_master.getitemdatetime(dw_master.getrow(),"ve_fecha")
ld_valor = dw_master.getitemnumber(dw_master.getrow(),"ve_valpag")

SELECT sysdate
INTO      :ldt_now
FROM    dual;

Select sa_tipo
into :ls_tipo
from sg_acceso
where em_codigo = :str_appgeninfo.empresa
and sa_login = :str_appgeninfo.username;

If ls_tipo <> 'A' Then
        if date(ldt_fecha) <> date(ldt_now) then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'No puede anular esta factura por:~r~n1.No es de hoy d$$HEX1$$ed00$$ENDHEX$$a,'+&
		                          '~r~n2.No Tiene Permiso')
		return -1
        end if
End if


this.setmicrohelp("Verificando si existen devoluciones de esta factura")
select count(*)
into :li_res
from fa_venta
where em_codigo = '1'
and su_codigo = :str_appgeninfo.sucursal
and es_codigo = '9'
and ve_numpre = :ll_factura;

 if li_res > 0 then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'Existe una Devoluci$$HEX1$$f300$$ENDHEX$$n de la Factura No.' + string(ll_factura)+ ' y no se puede anular.')
	return -1
end if
this.setmicrohelp("Verificando si existen cr$$HEX1$$e900$$ENDHEX$$ditos de esta factura")

select count(*)
into :ll_ig_num
from cc_cruce
where tt_coddeb = '1'  //Solo facturas
and    mt_coddeb in (
							  select mt_codigo
							  from cc_movim
							  where em_codigo = :str_appgeninfo.empresa
								and su_codigo = :str_appgeninfo.sucursal
								and ve_numero = :ll_factura
								and es_codigo = '1'
								and tt_ioe = 'D'
								and tt_codigo = '1'); //Solo facturas

if ll_ig_num > 0 then
MessageBox("ERROR","La factura tiene pagos ingresados y no se puede Anular.")
return -1
end if

this.setmicrohelp("Anulando la factura")

ll_total_reg = dw_master.RowCount()
ll_regactual = dw_master.GetRow()

ls_cliente = dw_master.GetItemString(ll_regactual,"ce_codigo")
li_res = messageBox('Confirme por favor', 'Est$$HEX2$$e1002000$$ENDHEX$$seguro que desea anular la factura No.' + string(ll_factura) , Question!, YesNo!)
if li_res <> 1 then 
return -1
end if

//devuelvo el cupo de credito al cliente
update fa_clien
set ce_salcre = ce_salcre + :ld_valor
where em_codigo = :str_appgeninfo.empresa
and ce_codigo = :ls_cliente;

declare cc_movim cursor for
select mt_codigo
from cc_movim
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ve_numero = :ll_factura
and es_codigo = '1'
and tt_ioe = 'C';

ls_sucursal = dw_master.GetItemString(ll_regactual,"su_codigo")
ls_bodega = dw_master.GetItemString(ll_regactual,"bo_codigo")
ll_factura = dw_master.GetItemNumber(ll_regactual,"ve_numero")
ll_totalreg = dw_detail.RowCount()
//Si hay pagos en cheque, debo verificar que los cheques generados 
//por la factura no hayan sido efectivizados
open cc_movim;
	do
		fetch cc_movim into :ls_num_movim;
		 if sqlca.sqlcode <> 0 then exit
		 select ch_pendiente
		 into :ls_ch_pendiente
		 from cc_cheque
		 where em_codigo = :str_appgeninfo.empresa
		 and su_codigo = :str_appgeninfo.sucursal
		 and mt_codigo = :ls_num_movim
		 and tt_codigo = '5'
		 and tt_ioe = 'C';
		 if ls_ch_pendiente = 'N' then  //el cheque est$$HEX2$$e1002000$$ENDHEX$$efectivizado
		    MessageBox("ERROR","No se puede anular la factura, debido a que tiene cheques efectivizados")
			close cc_movim;
			return -1
		 end if
	loop while TRUE;
close cc_movim;
ll_resul = f_anula_factura(ls_sucursal,ls_bodega,ll_factura,'1','5')
if ll_resul = 1 then
//	    //borro los movimientos de la tabla cc_movim Cuentas x Cobrar
//	    select mt_codigo
//	    into :ls_num_nd
//		from cc_movim
//		where em_codigo = :str_appgeninfo.empresa
//		and su_codigo = :str_appgeninfo.sucursal
//		and ve_numero = :ll_factura
//		and es_codigo = '1'
//		and tt_codigo = '1'
//		and tt_ioe = 'D';
//		  
//	   delete from cc_cruce
//	   where em_codigo = :str_appgeninfo.empresa
//	   and su_codigo = :str_appgeninfo.sucursal
//	   and mt_coddeb = :ls_num_nd
//	   and tt_coddeb = '1'
//	   and tt_ioedeb = 'D';	
//	   if sqlca.sqlcode <> 0  then
//	  	  MessageBox("ERROR","No puedo borrar los cruces. "+sqlca.sqlerrtext)
//	   end if
//
//	  open cc_movim;
//	  do
//			fetch cc_movim into :ls_num_movim;
//			if sqlca.sqlcode <> 0 then exit
//				delete from cc_cheque
//				where em_codigo = :str_appgeninfo.empresa
//				and su_codigo = :str_appgeninfo.sucursal
//				and mt_codigo = :ls_num_movim
//				and tt_ioe = 'C';
//				if sqlca.sqlcode <> 0 then
//				MessageBox("ERROR","No puedo borrar los cheques. "+sqlca.sqlerrtext)
//				close cc_movim;
//				return
//				end if
//	  loop while TRUE;
//	  close cc_movim;
//
		delete from cc_movim
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
		and ve_numero = :ll_factura
		and es_codigo = '1'
		and tt_codigo = '1'; //Solo facturas
		if sqlca.sqlcode <> 0 then
		MessageBox("ERROR","No puedo borrar los mov. de CxC. "+sqlca.sqlerrtext)		
		return -1
		end if
	  
		for ll_i = 1 to ll_totalreg
			ls_item = dw_detail.GetItemString(ll_i,"it_codigo")
			ld_cantidad = dw_detail.GetItemNumber(ll_i,"dv_candes")
			lch_kit = dw_detail.GetItemString(ll_i,"it_kit")
			ls_motor = dw_detail.GetItemString(ll_i,"dv_motor")			
			if lch_kit = 'V' then		
				update in_itedet
				set estado = 'R'
				where em_codigo = :str_appgeninfo.empresa
				and su_codigo = :str_appgeninfo.sucursal
				and di_ref1 = :ls_motor;
				if sqlca.sqlcode <> 0 then
					messageBox('Error Interno', 'No se puede encontrar el n$$HEX1$$fa00$$ENDHEX$$mero de motor...Por favor avise a sistemas el error : ' + sqlca.sqlerrtext )
					rollback;
					return -1
				end if			
			end if
			//llamada a la funci$$HEX1$$f300$$ENDHEX$$n para devolver todos los stocks a la sucursal
			f_carga_stock_tdr_sucursal(ls_item,ld_cantidad)
			//lamada a la funci$$HEX1$$f300$$ENDHEX$$n para devolver el stock a la bodega
			f_carga_stock_bodega(str_appgeninfo.seccion,ls_item,ld_cantidad)
			ls_factura = string(ll_factura)
			
			delete from in_movim
			where em_codigo = '1'
			and su_codigo = :str_appgeninfo.sucursal
			and tm_codigo = '2'
			and tm_ioe = 'E'
			and ve_numero = :ls_factura
			and es_codigo = '1';
		next
End if
commit;
messageBox('Resultado', 'La factura No. ' + ls_factura + ' fue anulada completamente ' , Information!, Ok!)	
dw_master.reset()
dw_detail.reset()
dw_detalle_pago.reset()
this.setmicrohelp("Listo")
setpointer(arrow!)
return 1

end event

type dw_master from w_sheet_master_detail`dw_master within w_consulta_factura
integer x = 0
integer y = 0
integer width = 4046
integer height = 628
integer taborder = 60
string dataobject = "d_consulta_venta"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_master::clicked;call super::clicked;
//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = false
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = true
str_cliparam.ventana = parent
str_cliparam.datawindow = dw_master
str_cliparam.fila = this.GetRow() 

end event

event dw_master::doubleclicked;call super::doubleclicked;dw_detail.enabled = true
dw_master.enabled = true
dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
dw_detail.enabled = true
dw_master.enabled = true
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_consulta_factura
event ue_recuperar pbm_custom41
event ue_darimagen pbm_custom42
event ue_keydown pbm_dwnkey
integer x = 0
integer y = 728
integer width = 4041
integer height = 816
integer taborder = 20
boolean titlebar = true
string title = "Detalle de Factura"
string dataobject = "d_consulta_detalle_venta"
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

event dw_detail::ue_keydown;if keydown(KeyF11!) then
	this.TriggerEvent('ue_darimagen')
end if
end event

event dw_detail::clicked;call super::clicked;
//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = false
//str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 

end event

type dw_report from w_sheet_master_detail`dw_report within w_consulta_factura
integer x = 146
integer y = 444
integer width = 2821
integer height = 1316
integer taborder = 30
string dataobject = "dw_factura_motegi"
boolean maxbox = true
boolean hsplitscroll = true
end type

type dw_detalle_pago from uo_dw_detail within w_consulta_factura
event ue_guardar pbm_custom09
boolean visible = false
integer y = 728
integer width = 3209
integer height = 812
integer taborder = 10
boolean titlebar = true
string title = "Detalle de Pago"
string dataobject = "d_consulta_detalle_pago"
end type

type cb_formpag from commandbutton within w_consulta_factura
integer x = 5
integer y = 628
integer width = 434
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle de Pago"
end type

event clicked;
if ib_detalle_pago &
Then
	dw_detail.visible = false
	dw_detalle_pago.visible = true
	cb_formpag.text = '&Detalle de Ticket'
	ib_detalle_pago = false
else
	dw_detail.visible = true
	dw_detalle_pago.visible = false
	cb_formpag.text = 'Detalle de Pago'
	dw_detail.SetFocus()
	ib_detalle_pago = true
end if



end event

type cb_ubicacion from commandbutton within w_consulta_factura
integer x = 439
integer y = 628
integer width = 521
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ubicaci$$HEX1$$f300$$ENDHEX$$n Geogr$$HEX1$$e100$$ENDHEX$$fica"
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

type p_producto from picture within w_consulta_factura
boolean visible = false
integer x = 1207
integer y = 576
integer width = 1367
integer height = 796
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type p_ubicacion from picture within w_consulta_factura
boolean visible = false
integer x = 1303
integer y = 236
integer width = 1605
integer height = 684
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_autoriza from datawindow within w_consulta_factura
boolean visible = false
integer x = 942
integer y = 464
integer width = 1157
integer height = 428
integer taborder = 62
boolean bringtotop = true
boolean titlebar = true
string title = "Autorizaci$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_permiso_reimp_fxm"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;string ls_nulo,ls_nuevo,ls_estado
integer li_vehiculo
long ll_ve_numero


dw_autoriza.accepttext()
If dwo.name = 'b_1' then
   
	ll_ve_numero = dw_master.getItemNumber(dw_master.getrow(), "ve_numero")
     ls_estado = dw_master.getItemString(dw_master.getrow(), "es_codigo")
	li_vehiculo = dw_detail.find("it_kit = 'V'",1,dw_detail.rowcount())
	
	ls_nuevo = dw_autoriza.GetItemString(1,'nuevo')
	
	if isnull(ls_nuevo) or ls_nuevo = ''  then return
	//messagebox("Atencion",ls_nuevo+' '+ls_estado+' '+string(ll_ve_numero))
	
	Update fa_venta
	set ve_preant = ve_numpre,
		 ve_numpre = :ls_nuevo
	where es_codigo = :ls_estado
	and em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and ve_numero = :ll_ve_numero;
	//messagebox("",string(sqlca.sqlnrows)+'-'+ string(sqlca.sqlcode))
	
	If sqlca.sqlnrows = 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el preimpreso..."+String(sqlca.sqlcode))
	end if
	
	if sqlca.sqlcode < 0 then
		rollback;
		messageBox('Verifique por favor', 'La factura no se relaciona con los par$$HEX1$$e100$$ENDHEX$$metros actuales' + sqlca.sqlerrtext)
		return	
	else
		commit;
	end if
	
		
//	dw_report.SetTransObject(sqlca)	
 //Impresion normal
// dw_report.Modify("DataWindow.Footer.Height=1500")
//dw_report.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion, ll_ve_numero)
//Prismacolor, Inselair
//dw_report.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal, str_appgeninfo.seccion, ll_ve_numero,ic_iva)
//dw_report.Retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ll_ve_numero,ic_iva*100)
//dw_report.Modify("DataWindow.Footer.Height=2650")	
	
	
	//Impresion a traves de vista
	//dw_report.retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion, ll_ve_numero)
// Para redcolor
//if str_appgeninfo.sucursal  = '1' then
	dw_report.DataObject = 'dw_factura_motegi'
	//dw_report.DataObject = 'dw_factura_cedane_a4'
//	dw_report.DataObject = 'dw_factura_ferro_a4'
//dw_report.DataObject = 'dw_factura_redcolor'
 //dw_report.DataObject = 'd_nventa_new'  //redcolor
//  dw_report.DataObject = 'dw_pintaexpress_a4'  //colorexpress
  dw_report.SetTransObject(sqlca)
//   //recuperacion normal 
//  dw_report.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal, str_appgeninfo.seccion, ll_ve_numero,ic_iva)
	dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, is_estado, ll_ve_numero)
    dw_report.Modify("DataWindow.Footer.Height=1500")	
	 //1550  cedane
	 // 1700 ferrocolor
	//else										  
//	//recuperacion con  vista
//	dw_report.DataObject = 'dw_factura_redcolor_view'
//	dw_report.SetTransObject(sqlca)
//	dw_report.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal, str_appgeninfo.seccion, ll_ve_numero)
//end if		
// fin de redcolor

		if li_vehiculo > 0 then
		dw_report.modify("DataWindow.detail.Height=190")
		else
		dw_report.modify("DataWindow.detail.Height=64")
		end if
		dw_report.modify("datawindow.print.preview.zoom=75~t" + &
						"datawindow.print.preview=yes")
		
		dw_report.Print()
		setnull(ls_nulo)
     	dw_autoriza.SetItem(1, 'nuevo',ls_nulo)
End if

If dwo.name = 'b_2' then
	dw_autoriza.visible = false
End if
end event

type dw_ubica from datawindow within w_consulta_factura
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 800
integer y = 196
integer width = 1445
integer height = 240
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Factura"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event itemchanged;string ls, ls_criterio, ls_tipo, ls_codemp,ls_nombre
long ll_numero,ll_nreg

f_recupera_empresa(dw_detalle_pago,"fp_codigo") 
f_recupera_empresa(dw_detalle_pago,"if_codigo") 

If dwo.name  = "factura" &
Then
ll_numero = long(data)
dw_master.Reset()
dw_detail.Reset()
dw_detalle_pago.Reset()
ll_nreg = dw_master.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ll_numero)

If ll_nreg <= 0 Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No est$$HEX2$$e1002000$$ENDHEX$$registrada la factura N$$HEX2$$ba002000$$ENDHEX$$"+string(ll_numero)+"  $$HEX2$$f3002000$$ENDHEX$$ya ha sido anulada....<Por favor verifique...!!!>")
	Return
End if

ls_codemp = dw_master.getitemstring(dw_master.getrow(),"ep_codigo")

select ep_codigo||' '||ep_nombre||' '||ep_apepat
into :ls_nombre
from no_emple
where em_codigo = :str_appgeninfo.empresa
and ep_codigo = :ls_codemp;


dw_master.modify("st_empleado.text = '"+ls_nombre+"'")
dw_detail.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ll_numero)
dw_detalle_pago.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,is_estado,str_appgeninfo.seccion,ll_numero)
dw_master.enabled = True
dw_detail.enabled = True
dw_detalle_pago.enabled = True
End if 


//CHOOSE CASE this.GetColumnName()
//
//	CASE 'factura'
//		ls_tipo = this.GetItemString(1,'tipo')
//		ls = this.getText()
//		CHOOSE CASE ls_tipo
//			CASE 'B'
//				ls_criterio = "ve_numero = " +  ls
//				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
//				if ll_found > 0 and not isnull(ll_found) then
//				  dw_master.SetFocus()
//				  dw_master.ScrollToRow(ll_found)
//				  dw_master.SetRow(ll_found)
//				  this.Visible = false
//	  			else
//				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Factura no se encuentra, verifique datos')
//				  return
//			  end if
//		   CASE 'F'
//				ls_criterio = "ve_numero" +  ls 
//				dw_master.SetFilter(ls_criterio)
//				dw_master.Filter()
//				dw_master.SetFocus()
//				this.Visible = false	
//				dw_master.ScrollToRow(dw_master.GetRow())
//				dw_master.SetRow(dw_master.GetRow())				
//				
//		END CHOOSE
//END CHOOSE
end event


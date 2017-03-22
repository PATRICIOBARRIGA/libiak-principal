HA$PBExportHeader$w_proforma.srw
$PBExportComments$Facturas al por mayor
forward
global type w_proforma from w_sheet_master_detail
end type
type cb_ubicacion from commandbutton within w_proforma
end type
type cb_1 from commandbutton within w_proforma
end type
type cb_3 from commandbutton within w_proforma
end type
type cb_formpag from commandbutton within w_proforma
end type
type sle_1 from singlelineedit within w_proforma
end type
type p_ubicacion from picture within w_proforma
end type
type dw_consulta_stk from datawindow within w_proforma
end type
type p_producto from picture within w_proforma
end type
type dw_ubica from datawindow within w_proforma
end type
type dw_detalle_pago from uo_dw_detail within w_proforma
end type
end forward

shared variables

end variables

global type w_proforma from w_sheet_master_detail
integer width = 6107
integer height = 1996
string title = "Proforma"
long backcolor = 74477680
event ue_saveas pbm_custom10
event ue_consultar pbm_custom11
cb_ubicacion cb_ubicacion
cb_1 cb_1
cb_3 cb_3
cb_formpag cb_formpag
sle_1 sle_1
p_ubicacion p_ubicacion
dw_consulta_stk dw_consulta_stk
p_producto p_producto
dw_ubica dw_ubica
dw_detalle_pago dw_detalle_pago
end type
global w_proforma w_proforma

type variables
dec{2}  ic_iva,ic_descuento,ic_precio,ic_desc1,ic_desc2,ic_desc3
dec{4}  ic_costo
int     il_descue,ii_excento_iva,ii_numli
string  is_mensaje, is_codant1,is_estado='4'
boolean ib_fabricante,ib_detalle_pago, ib_ubica = false,&
		  prod_visible = false, ib_prof_fac = true,ib_nograba = false
datetime id_hoy
datawindowchild dwc_items
end variables

forward prototypes
public function integer wf_preprint ()
public function integer wf_postprint ()
public function integer wf_calcula_valores ()
public function integer wf_encera_pago ()
public function integer wf_suma_pagos ()
public function integer wf_valida_valor (string as_formpag, string as_inst_finan, decimal ac_valor)
public function integer wf_cambia_precio_desc ()
public subroutine wf_insertarfila ()
end prototypes

event ue_saveas;dw_report.saveas()
end event

event ue_consultar;dw_ubica.reset()
dw_ubica.visible = true
dw_ubica.insertrow(1)
dw_ubica.setfocus()

end event

public function integer wf_preprint ();long      ll_filActMaestro,ll_ve_numero

ll_filActMaestro = dw_master.getRow()
ll_ve_numero    = dw_master.getItemNumber(ll_filActMaestro, "ve_numero")
dw_report.SetTransObject(sqlca)
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,is_estado,ll_ve_numero)
dw_report.modify("datawindow.print.preview.zoom=100~t" + &
					   "datawindow.print.preview=yes")

return 1

end function

public function integer wf_postprint ();cb_formpag.VISIBLE = TRUE
RETURN 1
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

on w_proforma.create
int iCurrent
call super::create
this.cb_ubicacion=create cb_ubicacion
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_formpag=create cb_formpag
this.sle_1=create sle_1
this.p_ubicacion=create p_ubicacion
this.dw_consulta_stk=create dw_consulta_stk
this.p_producto=create p_producto
this.dw_ubica=create dw_ubica
this.dw_detalle_pago=create dw_detalle_pago
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ubicacion
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_formpag
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.p_ubicacion
this.Control[iCurrent+7]=this.dw_consulta_stk
this.Control[iCurrent+8]=this.p_producto
this.Control[iCurrent+9]=this.dw_ubica
this.Control[iCurrent+10]=this.dw_detalle_pago
end on

on w_proforma.destroy
call super::destroy
destroy(this.cb_ubicacion)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_formpag)
destroy(this.sle_1)
destroy(this.p_ubicacion)
destroy(this.dw_consulta_stk)
destroy(this.p_producto)
destroy(this.dw_ubica)
destroy(this.dw_detalle_pago)
end on

event open;call super::open;string ls_parametro[], ls_datos[]
datawindowchild dwc

f_recupera_empresa(dw_master,'empleado')
f_recupera_empresa(dw_master,'fp_codigo')
f_recupera_empresa(dw_detalle_pago,"fp_codigo") 
f_recupera_empresa(dw_detalle_pago,"if_codigo") 

istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = is_estado

gb_codigo_numerico = true
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


dw_detalle_pago.Settransobject(sqlca)
ib_detalle_pago = true
dw_detalle_pago.Reset()
dw_master.uf_insertCurrentRow()
dw_master.setFocus()
dw_master.TriggerEvent(Clicked!)
m_marco.m_archivo.m_imprimir.visible = false
m_marco.m_ventana.m_todo.triggerevent(clicked!)


/**************/
dw_detail.GetChild("codant",dwc_items)
dwc_items.SetTransObject(SQLCA)
dwc_items.Retrieve(str_appgeninfo.empresa)

f_recupera_empresa(dw_detail,"codant_1")

end event

event ue_update;int li, i,li_nreg,li_plazo,li_filactmaster
long ll_num_venta,rc,ll_plazo
string ls,ls_leyenda,ls_aux,ls_leyen,ls_fp
dec{2} lc_valor,lc_sumvalor,lc_valpag
datetime ld_fecha,ld_fecven, hoy
dwitemstatus l_status_master

setpointer(hourglass!)
select sysdate
into:hoy
from dual;

li_filactmaster = dw_master.GetRow()

l_status_master = dw_master.getitemStatus(li_filactmaster,0,primary!)
If l_status_master <> newmodified! Then 
	messagebox('Error','Esta proforma ya esta grabada')	
	return
end if


if dw_master.GetitemNumber(li_filactmaster,'cc_saldo') > 0 then
	messagebox('Error','La proforma tiene saldo pendiente de liquidar')
	return
End if

select ps_valor
into :ll_num_venta
from pr_numsuc
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and pr_nombre = 'PROFORMA'
for update of ps_valor;
If sqlca.sqlcode < 0 Then
	messagebox("Error interno","Problema con el  secuencial de proforma",stopsign!) 
	return
End if

Update pr_numsuc
set ps_valor = ps_valor + 1
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and pr_nombre = 'PROFORMA';
If sqlca.sqlcode < 0 Then
	rollback;
	messagebox("Error interno","Problemas al actualizar secuencial de la proforma",stopsign!) 
	return
End if

//Datos auxiliares para la cabecera de la factura de venta
dw_master.SetItem(li_filactmaster,"ve_numero",ll_num_venta)
dw_master.SetItem(li_filactmaster,"cj_caja",str_appgeninfo.caja)
dw_master.setitem(li_filactmaster,'em_codigo',str_appgeninfo.empresa)
dw_master.setitem(li_filactmaster,'su_codigo',str_appgeninfo.sucursal)
dw_master.setitem(li_filactmaster,'bo_codigo',str_appgeninfo.seccion)
dw_master.setitem(li_filactmaster,'es_codigo',is_estado)	
dw_master.setitem(li_filactmaster,'ve_fecha',hoy)	

dw_master.SetItem(li_filactmaster,'ve_numero',ll_num_venta)
ld_fecha = dw_master.GetItemDatetime(li_filactmaster,'ve_fecha')
lc_valpag = dw_master.GetItemDecimal(li_filactmaster,'ve_valpag')


//Elimina las filas en blanco
li_nreg = dw_detail.RowCount()
for li = 1 to li_nreg
	ls = dw_detail.GetItemString(li,'codant')
	if isnull(ls) or ls = '' then
		dw_detail.DeleteRow(li - i)
		i=i+1	  
	end if
next
li_nreg = dw_detail.RowCount()

for li = 1 to li_nreg
	dw_detail.setitem(li,'ve_numero',ll_num_venta)
	dw_detail.setitem(li,'em_codigo',str_appgeninfo.empresa)
    dw_detail.setitem(li,'su_codigo',str_appgeninfo.sucursal)
	dw_detail.setitem(li,'bo_codigo',str_appgeninfo.seccion)
	dw_detail.setitem(li,'es_codigo',is_estado)		
	dw_detail.SetItem(li,'dv_secue',li)
next

for li = 1 to dw_detalle_pago.RowCount()
	dw_detalle_pago.setitem(li,'ve_numero',ll_num_venta)
	dw_detalle_pago.setitem(li,'em_codigo',str_appgeninfo.empresa)
    dw_detalle_pago.setitem(li,'su_codigo',str_appgeninfo.sucursal)
	dw_detalle_pago.setitem(li,'bo_codigo',str_appgeninfo.seccion)
	dw_detalle_pago.setitem(li,'es_codigo',is_estado)	
	dw_detalle_pago.Setitem(li,'rp_numero',li)
	dw_detalle_pago.Setitem(li,'rp_fecha',ld_fecha)	
	lc_valor = dw_detalle_pago.Getitemdecimal(li,'rp_valor')	
	ls_fp = dw_detalle_pago.Getitemstring(li,'fp_codigo')		
	lc_sumvalor = lc_sumvalor + lc_valor
	ld_fecven = dw_detalle_pago.Getitemdatetime(li,'rp_fecven')

	select fp_descorta,fp_plazo
	into:ls_aux,:li_plazo
	from fa_formpag
	where fp_codigo = :ls_fp;

	If li_plazo > 1 Then
		ls_leyenda = ls_aux + ' $ ' + string(lc_valor,"#,##0.00") &
							 + ' Pague antes de ' + string(date(ld_fecven),'dd/mm/yyyy')
	else
	    ls_leyenda = ls_aux + ' $ ' + string(lc_valor,"#,##0.00")
	End if
	ls_leyen = ls_leyen +' '+ ls_leyenda
Next
dw_master.Setitem(li_filactmaster,'ve_leyenda',ls_leyen)
if lc_sumvalor > lc_valpag then
	messagebox('Error','La Proforma no puede tener cambio...<verifique>')
	return
End if

/* Solo para el caso de la facturaci$$HEX1$$f300$$ENDHEX$$n real
que es el caso en el que se debe ingresar el movimiento  de inv y 
descargar los tintes
*/

/*Recorrer nuevamente el detalle de la factura en busca de formulas de preparados
para descargar los tintes de cada formula*/
//Long k,ll_fil
//String ls_pepa,ls_formula,ls_presentacion,ls_itcodtinte
//Double lc_cantidad_x_preparar,lc_cantidad_a_descargar
//
//
//dw_tinte.AcceptText()
//
//
////Recorre el detalle de la factura
//for j = 1 to li_nreg
//	
//		ls_pepa               = dw_detail.Object.it_codigo[j]
//		ls_formula           = dw_detail.Object.dv_motor[j]
//		ls_presentacion  = dw_detail.Object.presentacion[j]
//	     lc_cantidad_x_preparar = dw_detail.Object.dv_cantid[j]
//		  
//         //si es formula 
//         if isnull(ls_formula) or ls_formula = '' then continue 
//		
//         //recupera  todos los tintes de la formula
//		ll_fil  = f_tintes(ls_pepa,ls_formula,ls_presentacion,lc_cantidad_x_preparar,dw_tinte)
//	
//		 //para cada tinte realizar la descarga
//		 //ingresar el movimiento de inventario en el kardex
// 
//		  for k = 1 to ll_fil
//			   //obtener cod tinte y cantidad a descargar
//			  ls_itcodtinte = dw_tinte.object.it_codigo[k]
//	            lc_cantidad_a_descargar = dw_tinte.object.cc_cantreq[k]
//				  
//			  UPDATE IN_ITEBOD
//			  SET IB_STOCK = IB_STOCK - :lc_cantidad_a_descargar
//			  WHERE IT_CODIGO = :ls_itcodtinte
//			  AND EM_CODIGO = :str_appgeninfo.empresa
//			  AND SU_CODIGO = :str_appgeninfo.sucursal
//			  AND BO_CODIGO = :str_appgeninfo.seccion;
//			  if sqlca.sqlcode <> 0 then
//				MessageBox("ERROR en ue_guardar","No puedo actualizar el stock.");
//				rollback using sqlca;
//				return 
//			 end if
//			  
//	  
//			  UPDATE IN_ITESUCUR
//			  SET IT_STOCK = IT_STOCK - :lc_cantidad_a_descargar,
//			  IT_STKREAL = IT_STKREAL - :lc_cantidad_a_descargar,
//			  IT_STKDIS   = IT_STKDIS - :lc_cantidad_a_descargar
//			  WHERE IT_CODIGO = :ls_itcodtinte
//			  AND EM_CODIGO = :str_appgeninfo.empresa
//			  AND SU_CODIGO = :str_appgeninfo.sucursal;
//			  if sqlca.sqlcode <> 0 then
//				MessageBox("ERROR en f_descarga_stock_real_sucursal","No puedo actualizar el stock.");
//				rollback using sqlca;
//				return 
//			 end if
//			 
////			
//			  
//			  If wf_mov_inventario(ls_itcodtinte,lc_cantidad_a_descargar,hoy,ll_factura,'2',lc_costo,'N','',0,0,ls_codant,0,0) = FALSE Then
//			  dw_movim.reset()
//			  rollback;
//			  MessageBox("ERROR","No se grab$$HEX2$$f3002000$$ENDHEX$$el movimiento de inventario. Por favor avise a sistemas")
//			  return
//		 	  end if
//		  next
//next
   




rc =  dw_master.update(true,false) 
if rc = 1 then
	 rc = dw_detail.update(true,false)
	 if rc = 1 then
	     rc = dw_detalle_pago.update(true,false)
		 if rc = 1 then
			dw_master.resetupdate()
			dw_detail.resetupdate()
			dw_detalle_pago.resetupdate()
			commit;  			
			this.PostEvent('ue_print')
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

end event

event close;call super::close;m_marco.m_archivo.m_imprimir.visible = true
gb_codigo_numerico = false
end event

event ue_insert;int li_filmaster,li_nreg
string ls_nulo
dwitemstatus l_status_master
graphicObject lgo_curObject


li_filmaster  = dw_master.getrow()
l_status_master = dw_master.getitemStatus(li_filmaster,0,primary!)
lgo_curObject = getfocus()
If l_status_master <> newmodified! Then 
	setnull(ls_nulo)
     sle_1.text = ls_nulo
	sle_1.visible = true
	sle_1.enabled = true
	dw_ubica.setitem(1,"factura",ls_nulo)
	dw_master.reset()
	dw_detail.reset()
	dw_detalle_pago.reset()
	dw_master.enabled = false
	dw_detail.enabled = false
	dw_detalle_pago.enabled = false
	dw_master.insertrow(1)
	dw_master.setfocus()
end if
if  lower(lgo_curObject.className()) = "dw_detail"  then
	li_nreg = dw_detail.insertrow(0)
	dw_detail.scrolltorow(li_nreg)
	dw_detail.setcolumn("codant")
	dw_detail.setfocus()	
end if

str_prodparam.fila = dw_detail.GetRow()
str_prodparam.corregir = true

end event

event closequery;long ll_xx, li, li_max
string ls, ls_pepa, ls_valstk, ls_kit
decimal lc_pedido
if dw_detail.modifiedcount() > 0 or dw_detail.deletedcount() > 0 then
ll_xx = Messagebox("Confirme " ,"$$HEX1$$bf00$$ENDHEX$$Hay cambios que no se han guardado, desea descartarlos?",Question!,YesNo!)
choose case ll_xx
case 1 
	message.returnValue = 0
	return
case 2
	message.returnValue = 1
	return
end choose
end if		
end event

event ue_retrieve;return 1

end event

event ue_firstrow;call super::ue_firstrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_detail.SetFocus()

end event

event ue_lastrow;call super::ue_lastrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_detail.SetFocus()

end event

event ue_nextrow;call super::ue_nextrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_detail.SetFocus()

end event

event ue_print;call super::ue_print;dw_detalle_pago.Visible = false
dw_master.enabled = false
dw_detail.enabled = false
dw_detalle_pago.enabled = false
cb_formpag.text = 'Detalle de Pago'

end event

event ue_priorrow;call super::ue_priorrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
dw_detail.SetFocus()

end event

event ue_outedition;dw_detail.Reset()
dw_detalle_pago.Reset()
dw_master.Reset()
dw_master.InsertRow(0)
dw_master.SetFocus()
//dw_master.uf_insertCurrentRow()
end event

event ue_printcancel;call super::ue_printcancel;sle_1.visible = true
sle_1.enabled = false
dw_master.enabled = false
dw_detail.enabled = false
dw_detalle_pago.enabled = false
cb_formpag.text = 'Detalle de Pago'

end event

event ue_delete;call super::ue_delete;string ls_nulo
sle_1.visible = false
sle_1.text = ls_nulo
end event

type dw_master from w_sheet_master_detail`dw_master within w_proforma
integer x = 0
integer y = 4
integer width = 5390
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
char   lch_cambven

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
	select ep_codigo, ce_cambven , ce_exiva, ce_firma,tc_codigo,ce_actividad,ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep))  
	into :ls_vendedor,:lch_cambven, :ls, :ls_firma,:ls_tccodigo,:ls_actividad,:ls_nomcli
	from fa_clien
	where em_codigo = 1
	and    ce_codigo = :ls_cliente;

	if sqlca.sqlcode = 100 then
//	is_mensaje = 'Cliente no registrado'
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Cliente no registrado")
	return 1
	end if
	// encuentra si se puede facturar al cliente
//	if wf_valida_cliente(ls_cliente,'ce_facturar') <> 1 then
//	//is_mensaje = 'No se puede facturar a este cliente'
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede facturar a este cliente")
//	dw_detail.enabled = false
//	ib_nograba = true
//	return 1
//	end if	
	
	
//	if wf_valida_cliente(ls_cliente,'ce_estcre') <> 1 then
//	//is_mensaje = 'No se puede facturar a este cliente'
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede facturar a este cliente")
//	dw_detail.enabled = false
//	ib_nograba = true
//	return 1
//	end if	
			
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
	

case  'empleado'

	ls_vendedor = gettext()
	setItem(ll_filAct,"ep_codigo",ls_vendedor)
	
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
this.setitem(ll_row,"ve_hora",f_hoy())
dw_detalle_pago.Reset()
end event

event dw_master::updatestart;call super::updatestart;LONG ll_row
decimal lc_subtotal
gb_codigo_numerico = true

/**/
ll_row = dw_detail.Getrow()
If ll_row = 0 Then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe detalle de la factura")
	Return 1
End if	
lc_subtotal = dw_detail.GetItemDecimal(ll_row,"cc_sum_subtot")
dw_master.SetItem(ll_row,"ve_subtot",lc_subtotal)
return 0
end event

event dw_master::itemerror;//messagebox("Error",is_mensaje)
return 1
end event

event dw_master::doubleclicked;call super::doubleclicked;dw_ubica.reset()
dw_ubica.visible = true
dw_ubica.insertrow(1)
dw_ubica.setfocus()

end event

type dw_detail from w_sheet_master_detail`dw_detail within w_proforma
event ue_recuperar pbm_custom41
event ue_darimagen pbm_custom42
event ue_keydown pbm_dwnkey
event ue_darstk pbm_custom43
event ue_tabout pbm_dwntabout
event ue_nextfield pbm_dwnprocessenter
integer x = 0
integer y = 816
integer width = 6053
integer height = 980
integer taborder = 0
string dataobject = "d_detalle_venta"
boolean hscrollbar = false
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
this.Modify("DataWindow.HorizontalScrollPosition='"+string(0)+"'")
setcolumn('codant')
setfocus()

end event

event dw_detail::itemchanged;////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Si cambia uno de los  campos del detalle se ejecuta
// Revisado    : 06-Abril-2006
////////////////////////////////////////////////////////////////////

dwItemStatus lst_estado

long       ll_filActMaster,ll_nreg,ll_find
decimal{2} lc_prefab,lc_pedido, lc_stock,ld_null,lc_recargo,lc_preciodesc
dec{4}     lc_costo
string     ls,ls_marca,ls_pepa, ls_nombre, ls_null, ls_codant,&
			  ls_valstk,tipo_descuento,ls_base,ls_param[2],ls_actividad,ls_fp,ls_medida,ls_presentacion
char       lch_cambia,lch_kit,lch_aux
decimal    ld_desc1, ld_desc2, ld_desc3
int        si_hay,li_fila,li_ivaitem,li_ajuste



li_fila = this.getRow()
str_prodparam.fila = li_fila
ll_filActMaster = dw_master.getRow()
//accepttext()
// si cambia el c$$HEX1$$f300$$ENDHEX$$digo del producto
CHOOSE CASE This.GetColumnName()
case 'codant' 
	
	ls = this.gettext()		
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
	and nvl(estado,'N')<>'S'; 

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
				this.SetItem(li_fila,"presentacion",ls_medida)
				this.SetItem(li_fila,"dv_chasis",ls_presentacion)
				
				
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
						is_mensaje  = 'No puede facturar este item junto con veh$$HEX1$$ed00$$ENDHEX$$culo'
						return 1
					end if
				end if
			case 'V'
				if getitemstring(1,"it_kit") <> lch_kit then 
					if lch_kit = 'N' or lch_kit = 'S' then
						this.SetItem(li_fila,'codant',ls_null)
						beep(1)
						is_mensaje  = 'No puede facturar este item          junto con veh$$HEX1$$ed00$$ENDHEX$$culo'
						return 1
					end if
				end if	
		end choose
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
	//Se debe verificar si por lo menos tengo 1 en stock en mi sucursal
	if ls_valstk = 'S' then 		
		lc_pedido = 1.0
		If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit) = false then
			messagebox("Error","No hay stock en sucursal del producto ["+ls+"] = "+string(lc_stock),stopsign!)		
		end if
	end if // fin de si valida stock
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


	//Busco los descuentos del item por cliente
	ls_actividad = dw_master.getitemstring(dw_master.getrow(),"ce_actividad")
	ls_fp  = dw_master.getitemstring(dw_master.getrow(),"fp_codigo")     /*politica nueva :  28-nov-07*/
	
	choose case ls_actividad
	case '1','2'
		if li_fila <> 1 and lch_kit = 'V' then
			dw_detail.deleterow(li_fila)		
			is_mensaje  ="S$$HEX1$$f300$$ENDHEX$$lo puede proformar una moto para este tipo de cliente"
			return	 1
		end if
	end choose
/*  politica anterior al 2017
	select td_codigo
	into :tipo_descuento
	from in_descitem
	where em_codigo = : str_appgeninfo.empresa
	and it_codigo = :ls_pepa
	and es_codigo = :ls_fp
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
*/



/*descuentos en base a calificacion del cliente */
SELECT "IN_TIPPRE"."TD_DESC1", "IN_TIPPRE"."TD_DESC2", "IN_TIPPRE"."TD_DESC3"
INTO    :ld_desc1,:ld_desc2,:ld_desc3  
FROM "IN_DESCITEM", "IN_TIPPRE"  
WHERE ( "IN_TIPPRE"."TD_CODIGO" = "IN_DESCITEM"."TD_CODIGO" ) and  
			( "IN_DESCITEM"."EM_CODIGO" = "IN_TIPPRE"."EM_CODIGO" ) and  
			( "IN_DESCITEM"."EM_CODIGO"  = :str_appgeninfo.empresa) and
			( "IN_DESCITEM"."IT_CODIGO" = :ls_pepa ) AND    
			( "IN_DESCITEM"."ES_CODIGO" = :ls_actividad )  AND
			("IN_DESCITEM"."DI_VIGENTE" = 'S') AND
			("IN_TIPPRE"."TD_VIGENTE" = 'S')  ;
	
	
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
		this.setitem(li_fila, 'dv_desc1',0)
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
//	if not isnull(ls_base) then
//		str_prodparam.codant = ls_pepa
//		str_prodparam.cod_base = ls_base
//		open(w_color_preparado_sif)
//	end if	
//	setcolumn('dv_cantid')
//	setfocus()

//---

Char lch_modifica

if not isnull(ls_base) then
		str_prodparam.codant = ls_pepa
		str_prodparam.cod_base = ls_base
		str_prodparam.medida = ls_medida
		
		open(w_color_preparado)
		lch_modifica = message.StringParm

		If lch_modifica = 'S' Then
		     this.setitem(str_prodparam.fila,"dv_precio",str_prodparam.precio)
	          this.setitem(str_prodparam.fila,"dv_motor",str_prodparam.formula)
			 this.setitem(str_prodparam.fila,"dv_chasis",str_prodparam.medida)	 
			//	  
		    	 if wf_cambia_precio_desc() = -1 Then 
		         this.SetItem(getrow(),'dv_precio',ic_precio)	
			end if
			wf_encera_pago()
			wf_calcula_valores()
			setnull(Message.StringParm)
		end if
	end if	
	

case  'dv_cantid'
	lc_pedido = dec(data) 
	if lc_pedido <= 0 then
		this.SetItem(row,'dv_cantid',this.GetItemNumber(row,'dv_cantid'))
		is_mensaje = 'La cantidad debe ser mayor a cero  y solo numeros enteros'
		return 1
	end if
	ls_codant = this.getitemstring(row,'codant')
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
			messagebox("Error","El stock en sucursal del producto ["+ls_codant+"] es: "+string(lc_stock),stopsign!)		
		end if
	end if
	lc_pedido = dec(data) 
	this.SetItem(li_fila,'dv_candes',lc_pedido)

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
char lch_kit,lch_aplicadscto
string ls_fp
this.accepttext()

//If dwo.name = 'dv_desc1' Then
//	for li_i = row to this.rowcount()
//	   setitem(li_i,"dv_desc1",0.00)
//		ll_candes = dw_detail.getitemnumber(li_i,"dv_candes")		
//		lc_precio = dw_detail.getitemdecimal(li_i,"dv_precio")
//		lc_desc1 = dw_detail.getitemdecimal(li_i,"dv_desc1")
//		lc_desc2 = dw_detail.getitemdecimal(li_i,"dv_desc2")
//		lc_desc3 = dw_detail.getitemdecimal(li_i,"dv_desc3")
//		lc_total = ll_candes*(((lc_precio * ((100 - lc_desc1)/100))*((100 - lc_desc2)/100))*((100 - lc_desc3)/100))
//		dw_detail.setitem(li_i,"dv_total",lc_total)
//	next	
//End if

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

event dw_detail::editchanged;call super::editchanged;String ls_data

if dwo.name = "codant" then
	ls_data = '%'+data+'%'
//	dwc_items.SetTransObject(SQLCA)
//	dwc_items.retrieve(str_appgeninfo.empresa,ls_data)
	dwc_items.SetFilter("cc_item like '"+ls_data+"' ")
	dwc_items.Filter()
	this.GetChild("cc_item",dwc_items)
end if
end event

type dw_report from w_sheet_master_detail`dw_report within w_proforma
integer x = 142
integer y = 36
integer width = 2784
integer height = 768
integer taborder = 0
string dataobject = "d_rep_proforma_empresa"
boolean hsplitscroll = true
end type

type cb_ubicacion from commandbutton within w_proforma
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

type cb_1 from commandbutton within w_proforma
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

type cb_3 from commandbutton within w_proforma
integer x = 1490
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

type cb_formpag from commandbutton within w_proforma
integer x = 5
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
dw_detalle_pago.Reset()

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
		// si existe saldo y el detalle es cero filas, inserta una fila
		// en el detalle
		dw_master.SetItem(ll_filActMaster,'ve_valotros',lc_valpag)
		
		li_fila = dw_detalle_pago.InsertRow(0)
		dw_detalle_pago.SetItem(li_fila,'rp_valor',lc_valpag)		
		dw_detalle_pago.SetItem(li_fila,'rp_fecha',hoy)
		ld_fecven = relativedate(date(hoy),1)
		dw_detalle_pago.SetItem(li_fila,'rp_fecven',ld_fecven)
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
	dw_detail.visible = true
	dw_detalle_pago.visible = false
	cb_formpag.text = '&Detalle de Pago'
	ib_detalle_pago = true
end if

end event

type sle_1 from singlelineedit within w_proforma
integer x = 622
integer y = 132
integer width = 1490
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

type p_ubicacion from picture within w_proforma
boolean visible = false
integer x = 1317
integer width = 1605
integer height = 684
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_consulta_stk from datawindow within w_proforma
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

type p_producto from picture within w_proforma
boolean visible = false
integer x = 14
integer y = 628
integer width = 1367
integer height = 796
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_ubica from datawindow within w_proforma
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 558
integer y = 200
integer width = 1445
integer height = 264
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Proforma"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
end if
end event

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()

end event

event itemchanged;long ll_nreg,ll_numero
string ls_cliente, ls_nomcli

setpointer(hourglass!)
If dwo.name  = "factura" Then
ll_numero = long(data)
dw_master.Reset()
dw_detail.Reset()
dw_detalle_pago.reset()
ll_nreg = dw_master.retrieve(integer(str_appgeninfo.sucursal),integer(is_estado),ll_numero)
If ll_nreg <= 0 Then 
	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','N$$HEX1$$fa00$$ENDHEX$$mero de proforma no existe o ya fue convertida en factura')
	return
End if

ls_cliente = dw_master.getitemstring(dw_master.getrow(),"ce_codigo")
select ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep))  
into :ls_nomcli
from fa_clien
where ce_codigo = :ls_cliente
and em_codigo = 1;

sle_1.visible = true
sle_1.enabled = true
sle_1.text = ls_nomcli

 dw_detail.retrieve(integer(str_appgeninfo.sucursal),integer(is_estado),ll_numero)
 dw_detalle_pago.retrieve(integer(str_appgeninfo.sucursal),integer(is_estado),ll_numero)
 dw_master.enabled = false
 dw_detail.enabled = false
 dw_detalle_pago.enabled = false
End if 
setpointer(arrow!)
end event

type dw_detalle_pago from uo_dw_detail within w_proforma
event ue_tabout pbm_dwntabout
boolean visible = false
integer y = 824
integer width = 4005
integer height = 980
integer taborder = 0
boolean titlebar = true
string title = "Detalle de Pago"
string dataobject = "d_detalle_pago"
end type

event ue_tabout;if  getcolumnName() = 'rp_numdoc' then
	this.insertRow(0)
end if
return 0
end event

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
	 
	 select fp_plazo,fp_acumula
	 into :li_plazo,:ls_acumula
	 from fa_formpag  
	 where em_codigo = :str_appgeninfo.empresa
	 and fp_codigo = :ls_codigo
 	 and fp_utiliza = 'S';
	 
	 for li_j = 1 to dw_detail.rowcount()
		lc_descuento = dw_detail.getitemnumber(li_j,"dv_desc2")
		If lc_descuento <> 0.00 and li_plazo > 1 Then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Tiene descuentos en pago de contado...verif$$HEX1$$ed00$$ENDHEX$$que")
		End if
	 next

	 select ce_plazo,ce_salcre,ce_estcre
	 into :li_plazocli,:lc_salcre,:lch_estcre
	 from fa_clien
	 where ce_codigo = :ls_cliente
	 AND em_codigo = :str_appgeninfo.empresa;
	 
 	if isnull(ls_acumula) or ls_acumula <> 'V'Then //No controla el plazo
	 if li_plazo > li_plazocli then
		messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')
	 end if
	end if

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
		ls_codigo = this.GetItemString(li_i,'fp_codigo')
		lc_valor = this.GetItemdecimal(li_i,'rp_valor')
		if ls_codigo = '0' then
			lc_efectivo += this.getItemdecimal(li_i,"rp_valor")
		else
			lc_valotras += this.getItemdecimal(li_i,"rp_valor")
		end if
	next
	dw_master.SetItem(ll_filcab,"ve_valotros",lc_valotras)
	dw_master.SetItem(ll_filcab,"ve_efectivo",lc_efectivo)
	lc_valor = dw_master.getitemdecimal(ll_filcab,"ve_valpag")	
	dw_master.SetItem(ll_filcab,"ve_cambio",lc_valor - (lc_efectivo + lc_valotras))				
end if

if dwo.name = 'rp_valor' then
		lc_total = dec(this.gettext())
		ls_codigo = this.GetItemString(ll_filact,'fp_codigo')		
		ls_cliente = dw_master.GetItemString(dw_master.GetRow(),'ce_codigo')		

		if wf_valida_valor(ls_codigo, &
		   this.getitemstring(ll_filact,'if_codigo'), lc_total) < 0 then
         this.setitem(ll_filact,'rp_valor',0)
		   this.setcolumn('rp_valor')
		end if
		
		select fp_plazo,fp_numpag
		into :li_plazo,:li_numcuota
		from fa_formpag
		where em_codigo = :str_appgeninfo.empresa
		and fp_codigo = :ls_codigo
		and fp_utiliza = 'S';
	
		select ce_plazo,ce_salcre
		into :li_plazocli,:lc_salcre
		from fa_clien
		where ce_codigo = :ls_cliente
		and em_codigo = :str_appgeninfo.empresa;
			  
		if li_plazo > li_plazocli then
			messagebox('Error','El plazo de la forma de pago es mayor que el permitido para el cliente')		
		end if

		if lc_total > lc_salcre then
			messagebox('Error','El valor ingresado excede el cupo de cr$$HEX1$$e900$$ENDHEX$$dito: '+string(lc_salcre,'#,##0.00') +' del cliente')
			this.setitem(ll_filact,'rp_valor',lc_total)
		end if

		if li_numcuota > 0 then
			lc_valor = lc_total/li_numcuota	
			setitem(ll_filact,"cc_cuota",lc_valor)
		end if
		

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
		lc_valor = dw_master.getitemdecimal(ll_filcab,"ve_valpag")	
		dw_master.SetItem(ll_filcab,"ve_cambio",lc_valor - (lc_efectivo + lc_valotras))				
		this.ib_inErrorCascade = true						
	//	return 1

end if

If dwo.name	= 'rp_fecven' then
		ld_fecven = datetime(this.gettext())
		if ld_fecven < hoy then
  		 messagebox('Error','La fecha de vencimiento no puede ser una fecha pasada')
  		 this.SetItem(ll_filact,'rp_fecven',hoy)
	    end if
end if

end event

event losefocus;call super::losefocus;CHOOSE CASE this.getcolumnName()

CASE 'rp_numdoc'
if dw_master.GetItemdecimal(dw_master.GetRow(),'cc_saldo') > 0.00 then
dw_detalle_pago.SetFocus()
dw_detalle_pago.InsertRow(0)
ScrolltoRow(RowCount())
SetColumn('fp_codigo')
end if
END CHOOSE

end event

event ue_postdelete;string ls_codigo
integer li_fp,li_filcab
dec{2} lc_valor,lc_efectivo = 0.00,lc_valotras = 0.00

li_filcab = dw_master.getrow()

for li_fp = 1 to this.RowCount()
	ls_codigo = this.GetItemString(li_fp,'fp_codigo')
	lc_valor = this.GetItemdecimal(li_fp,'rp_valor')	
	if ls_codigo = '0' then
		lc_efectivo += this.getItemdecimal(li_fp,"rp_valor")
	else
		lc_valotras += this.getItemdecimal(li_fp,"rp_valor")
	end if			
next
dw_master.SetItem(li_filcab,"ve_efectivo",lc_efectivo)
dw_master.SetItem(li_filcab,"ve_valotros",lc_valotras)
lc_valor = dw_master.getitemdecimal(li_filcab,"ve_valpag")	
dw_master.SetItem(li_filcab,"ve_cambio",lc_valor - (lc_efectivo + lc_valotras))				

end event

event ue_postinsert;call super::ue_postinsert;datetime ldt_fecha
date ld_fecven

ldt_fecha = f_hoy()
ld_fecven = relativedate(date(ldt_fecha),1)
setitem(getrow(),"rp_fecha",ldt_fecha)
setitem(getrow(),"rp_fecven",ld_fecven)
end event

event updatestart;call super::updatestart;/*Validar que la forma de pago sea la del compromiso*/
String ls_fpcompromiso,ls_fp
long ll_row

ll_row = dw_master.getrow()
ls_fpcompromiso = dw_master.Object.fp_codigo[ll_row]
ls_fp = this.object.fp_codigo[this.getrow()]

if ls_fp <> ls_fpcompromiso then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No coincide la forma de pago con el compromiso de pago....<Por favor verifique>")
	Rollback;
	return 1
end if
return 0

end event


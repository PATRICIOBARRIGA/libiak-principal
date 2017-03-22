HA$PBExportHeader$w_pd_requisicion_materiales.srw
$PBExportComments$Requisicion de materiales
forward
global type w_pd_requisicion_materiales from w_sheet_master_detail
end type
type dw_movim from datawindow within w_pd_requisicion_materiales
end type
type dw_ord from datawindow within w_pd_requisicion_materiales
end type
type st_1 from statictext within w_pd_requisicion_materiales
end type
type st_2 from statictext within w_pd_requisicion_materiales
end type
type dw_rta from datawindow within w_pd_requisicion_materiales
end type
type st_4 from statictext within w_pd_requisicion_materiales
end type
type dw_ubica from datawindow within w_pd_requisicion_materiales
end type
type st_3 from statictext within w_pd_requisicion_materiales
end type
type cb_1 from commandbutton within w_pd_requisicion_materiales
end type
type dw_formula from datawindow within w_pd_requisicion_materiales
end type
end forward

global type w_pd_requisicion_materiales from w_sheet_master_detail
integer x = 187
integer y = 360
integer width = 4987
integer height = 2404
string title = "Requisici$$HEX1$$f300$$ENDHEX$$n de Materiales"
event ue_consultar pbm_custom16
dw_movim dw_movim
dw_ord dw_ord
st_1 st_1
st_2 st_2
dw_rta dw_rta
st_4 st_4
dw_ubica dw_ubica
st_3 st_3
cb_1 cb_1
dw_formula dw_formula
end type
global w_pd_requisicion_materiales w_pd_requisicion_materiales

type variables
boolean ib_match
decimal ic_iva,ic_cantidad
dec{4} ic_costo
long ii_excento_iva
string  is_mensaje, is_estado='2',is_codant
dataStore ids_mp  //componentes de la receta

end variables

forward prototypes
public function boolean wf_descarga_stock_disp_sucursal (string as_item, long al_cantidad)
public function integer wf_preprint ()
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo)
public function integer wf_carga_formulacion (string as_itcodigo, decimal ac_cantidad_x_formula)
end prototypes

event ue_consultar;dw_master.postevent(DoubleClicked!)


end event

public function boolean wf_descarga_stock_disp_sucursal (string as_item, long al_cantidad);////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Descarga el stock disponible tanto del item como de sus 
//               componentes si es kit. Caso contrario descarga el stock
// disponible en todos los kits al que pertenece el componente
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 14-04-2003
// ////////////////////////////////////////////////////////////////////////

// NOTA.- en in_relitem, tr_codigo = '1'para KIT

decimal ld_cantidad,ld_stkdis_comp,ld_numero_kits,ld_cantidad_minima
boolean lb_exito = TRUE, lb_es_1er_comp = TRUE
string  ls_componente,ls_es_kit,ls_codigo_kit
long    ll_contador

// busca los componentes de un item kit
declare kit_cursor cursor for
select it_codigo,ri_cantid
from in_relitem
where em_codigo = :str_appgeninfo.empresa
and it_codigo1 = :ls_codigo_kit
and tr_codigo = '1';  

// busca los kits al que pertenece un item componente
declare cursor_componente cursor for
select it_codigo1
from in_relitem
where em_codigo = :str_appgeninfo.empresa
and it_codigo = :as_item
and tr_codigo = '1';  

// descarga el stock del item
update in_itesucur
set it_stkdis = it_stkdis - :al_cantidad
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and it_codigo = :as_item;
if sqlca.sqlcode < 0 then
MessageBox("ERROR en f_descarga_stock_disponible_sucursal","No puedo actualizar el stock.");
rollback using sqlca;
return (FALSE)
end if

// busca si el item es kit o no
select it_kit
into :ls_es_kit
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codigo = :as_item;	

if ls_es_kit = 'S' then
// el item es un kit
ls_codigo_kit = as_item 
open kit_cursor;
do
// se procede a descargar stock de cada componente
fetch kit_cursor into :ls_componente,:ld_cantidad;
if sqlca.sqlcode <> 0 then exit; 
update in_itesucur
set it_stkdis = it_stkdis - (:al_cantidad*:ld_cantidad)
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and it_codigo = :ls_componente;
if sqlca.sqlcode < 0 then
lb_exito = FALSE
end if	
loop while TRUE;
close kit_cursor;
else // el item no es un kit, por tanto puede ser componente de kits
select count(*)
into :ll_contador
from in_relitem
where em_codigo = :str_appgeninfo.empresa
and it_codigo = :as_item
and tr_codigo = '1';   

if ll_contador > 0 then  //al menos es parte de un kit
open cursor_componente;
do
lb_es_1er_comp = TRUE
fetch cursor_componente into :ls_codigo_kit;
if sqlca.sqlcode <> 0 then exit
// con cada kit revisar sus componentes
open kit_cursor;
do
fetch kit_cursor into :ls_componente,:ld_cantidad;
if sqlca.sqlcode <> 0 then exit
//encuentra el stock disponible de cada componente
select it_stkdis
into :ld_stkdis_comp
from in_itesucur
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and it_codigo = :ls_componente;

ld_numero_kits = truncate(ld_stkdis_comp/ld_cantidad,0)

if lb_es_1er_comp then
lb_es_1er_comp = FALSE
ld_cantidad_minima = ld_numero_kits
end if
if ld_numero_kits < ld_cantidad_minima then
ld_cantidad_minima = ld_numero_kits
end if
loop while TRUE
close kit_cursor;
// actualiza el stock disponible del kit con el el valor menor, de
// uno de todos los componentes, que resulte de la divisi$$HEX1$$f300$$ENDHEX$$n entre
//el valor disponible para el factor del kit

update in_itesucur
set it_stkdis = :ld_cantidad_minima
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and it_codigo = :ls_codigo_kit;
loop while TRUE
close cursor_componente;
end if
end if // fin del si es kit o no

if not lb_exito then
MessageBox("ERROR en f_descarga_stock_disponible_sucursal","No puedo actualizar stock");
rollback using sqlca;
return (FALSE)
end if
return (TRUE)
end function

public function integer wf_preprint ();long ll_filActMaestro
string ls_nro

dw_report.SetTransObject(sqlca)
ll_filActMaestro = dw_master.getRow()
ls_nro = dw_master.getItemString(ll_filActMaestro, "rm_codigo")
dw_report.retrieve(ls_nro)
				
return 1

end function

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
// sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=1, tm_ioe='I' es ingreso por compras

long ll_num_movim,ll_fila
string ls_num_movim,ls_nulo,ls_observa,ls_obs_kit,ls_factura
boolean lb_exito = TRUE


setnull(ls_nulo)
ls_factura = string(al_factura)
ls_observa = "Recepci$$HEX1$$f300$$ENDHEX$$n de compra No. "+ls_factura
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Kit "+is_codant+" en recepci$$HEX1$$f300$$ENDHEX$$n de compra No. "+ls_factura
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'1')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_atomo)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad * ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo_atomo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_obs_kit)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		

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
	dw_movim.setitem(ll_fila,"tm_codigo",'1')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ic_costo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		

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
	dw_movim.setitem(ll_fila,"tm_codigo",'1')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ic_costo)
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return(TRUE)

end function

public function integer wf_carga_formulacion (string as_itcodigo, decimal ac_cantidad_x_formula);long ll_new,i
String ls_pepa,ls_codant,ls_nombre
Decimal lc_cantid,lc_cantidad_a_producir

lc_cantidad_a_producir = dw_ord.object.or_cantid[dw_ord.getrow()]
dw_formula.retrieve(as_itcodigo,'F')

for i = 1 to dw_formula.rowcount()
         ll_new = dw_detail.insertrow(0)
         dw_detail.Object.it_codigo[ll_new]                = dw_formula.object.it_codigo1[i]
	    dw_detail.Object.in_item_it_codant[ll_new]    = dw_formula.object.it_codant[i]
	    dw_detail.Object.in_item_it_nombre[ll_new]   = dw_formula.object.it_nombre[i]
	    dw_detail.Object.re_cantid[ll_new]                = dw_formula.object.rq_cantid[i]*ac_cantidad_x_formula*lc_cantidad_a_producir
next

return 1
end function

on w_pd_requisicion_materiales.create
int iCurrent
call super::create
this.dw_movim=create dw_movim
this.dw_ord=create dw_ord
this.st_1=create st_1
this.st_2=create st_2
this.dw_rta=create dw_rta
this.st_4=create st_4
this.dw_ubica=create dw_ubica
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_formula=create dw_formula
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_movim
this.Control[iCurrent+2]=this.dw_ord
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_rta
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.dw_ubica
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.dw_formula
end on

on w_pd_requisicion_materiales.destroy
call super::destroy
destroy(this.dw_movim)
destroy(this.dw_ord)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_rta)
destroy(this.st_4)
destroy(this.dw_ubica)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_formula)
end on

event open;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Llena las estructuras para trabajar maestro detalle
//               y para recuperar autom$$HEX1$$e100$$ENDHEX$$ticamente el secuencial de la
// orden de compra
////////////////////////////////////////////////////////////////////////

string ls_parametro[]
dw_rta.SetTransobject(sqlca)
//f_recupera_empresa(dw_master,"pv_codigo") 
//ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[1] = str_appgeninfo.sucursal
ls_parametro[2] = '1' // 1 es ORDEN DE COMPRA
//f_recupera_datos(dw_master,"co_numpad", ls_parametro,2)
istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = is_estado
dw_detail.setrowfocusindicator(hand!)

call super::open
dw_master.is_SerialCodeColumn = "rm_codigo"
dw_master.is_SerialCodeType = "NUM_REQ"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//dw_detail.is_serialCodeDetail = "dc_secue"

// columnas de conecci$$HEX1$$f300$$ENDHEX$$n
dw_master.ii_nrCols = 1
dw_master.is_connectionCols[1] = "rm_codigo"
//dw_master.is_connectionCols[2] = "su_codigo"
//dw_master.is_connectionCols[3] = "ec_codigo"
//dw_master.is_connectionCols[4] = "co_numero"
dw_detail.is_connectionCols[1] = "rm_codigo"
//dw_detail.is_connectionCols[2] = "su_codigo"
//dw_detail.is_connectionCols[3] = "ec_codigo"
//dw_detail.is_connectionCols[4] = "co_numero"
dw_detail.uf_setArgTypes()

//dw_movim.settransobject(sqlca)
//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()

dw_master.uf_insertCurrentRow()
dw_master.setFocus()


//
dw_formula.SetTransObject(sqlca)
dw_ord.SetTransObject(sqlca) //Lista de ordenes pendientes
dw_ord.retrieve()

dw_ord.object.t_1.text = 'Seleccionar orden'



end event

event ue_update;// Descripci$$HEX1$$f300$$ENDHEX$$n : Graba los datos de la orden de compra
dwItemStatus   l_status_master
int                   max,i=0,rc,li_i
datetime          now
long                 ll_numero, ll_secue,ll_totalreg,ll_i,ll_num_nota,lc_cantid
decimal            lc_pedido, lc_sumsaldo, ld_saldo
string               ls_val ='S', ls_valstk, ls, ls_numero, ls_null, ls_kit
string               ls_codigo,ls_atomo
dec{2}             lc_stock
dec{4}             lc_costo_atomo,lc_cantatomo
char                 lch_kit
long                 ll, ll_filact, ll_fila, ll_contador, ll_contador_mov
boolean            lb_mal = FALSE

if dw_master.AcceptText()<>1 then return
if dw_detail.AcceptText()  <>1 then return

select sysdate
into: now
from dual;

ll_filact = dw_master.getrow()
//l_status_master = dw_master.getitemStatus(ll_filact,0,primary!)
//If l_status_master = newmodified! Then
//
///*Tomar secuencial de pedidos de produccion*/
//select pr_valor
//into :ll_num_nota
//from pr_param
//where pr_nombre = 'PR_REQMAT'
//and em_codigo = :str_appgeninfo.empresa
//for update of pr_valor;
//
//dw_master.setitem(ll_filact,"rm_codigo",string(ll_num_nota))
//end if
//
max = dw_detail.rowcount()
// asigna la secuencia del detalle y borra los que tienen el codigo en blanco
for li_i = 1 to max
		ls = dw_detail.GetItemString(li_i - i,'in_item_it_codant')
		if isnull(ls) or ls = '' then
			dw_detail.DeleteRow(li_i - i )
			i=i+1	  
		end if
next

max = dw_detail.rowcount()
if max = 0 then
	messageBox('Error','No se puede grabar no hay datos')
	rollback;
	return
end if	


// 1.- actualiza el nuevo saldo basado en la cantidad recibida
// 2.- Encuentra los saldos de la orden de compra
// para actualizar la orden de compra con el campo completa = null si existen saldos pendientes
// 3.- Actualiza el campo completa si no existen saldos pendientes
// 4.- Si todo salio bien grabar la orden de compra

rc = dw_master.Update(true,false)
if rc = 1 then
	rc = dw_detail.update(true,false)
	if rc = 1 then
		dw_master.resetupdate()
		dw_detail.resetupdate()
		commit;
	else
	rollback;
	return
	end if
else
rollback;
return
end if	



end event

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()
end event

event ue_retrieve;

return 1
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_ord.resize(li_width - 2*dw_ord.x, dw_ord.height)
	
	dw_master.resize(li_width/2 - 100, dw_master.height)
	dw_detail.resize(li_width/2 - 100,  li_height - dw_ord.height - dw_master.height - 280)
	dw_rta.resize(li_width/2 - 200, li_height - dw_ord.height -200)
	dw_master.move(li_width/2,dw_master.y)
	dw_detail.move(li_width/2,dw_detail.y)
	st_1.move(li_width/2,st_1.y)
	st_4.move(li_width/2,st_4.y)
	cb_1.move(li_width /2 -120,cb_1.y)
end if	
this.setRedraw(True)

return 1
end event

type dw_master from w_sheet_master_detail`dw_master within w_pd_requisicion_materiales
integer x = 2377
integer y = 676
integer width = 2505
integer height = 408
string dataobject = "d_pd_reqmat"
boolean hscrollbar = false
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemerror;If dwo.name =  "pv_codigo"  Then
messagebox('Error',is_mensaje)
return 1
End if
end event

event dw_master::losefocus;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Al salir del campo Observaci$$HEX1$$f300$$ENDHEX$$n el foco se coloca en
//               el detalle			
// Revisado    : ING HUGO V OROZCO CH ... 19/01/1998 11:17
////////////////////////////////////////////////////////////////////////

CHOOSE CASE this.GetColumnName()
	CASE 'pe_observ'
		if dw_detail.RowCount() = 0 then
 		  dw_detail.ScrolltoRow(dw_detail.InsertRow(0))
		  dw_detail.setitem(1,"in_item_it_codant",'')
		  dw_detail.SetColumn('in_item_it_codant')
		end if
	END CHOOSE
	
end event

event dw_master::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event dw_master::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"rm_fecha",f_hoy())

end event

event dw_master::updatestart;call super::updatestart;Long ll_row 

ll_row = this.getrow()

this.object.em_codigo[ll_row] = str_appgeninfo.empresa
this.object.su_codigo[ll_row] = str_appgeninfo.sucursal
this.object.bo_codigo[ll_row] = str_appgeninfo.seccion

return 0
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_pd_requisicion_materiales
event pbm_dwnkey pbm_keydown
event ue_keydown pbm_keydown
integer x = 2377
integer y = 1160
integer width = 2505
integer height = 1104
string dataobject = "d_pd_detreq"
borderstyle borderstyle = stylebox!
end type

event dw_detail::ue_keydown;//integer li_fila,li_max
//
//li_fila = this.getrow()
//if (KeyDown(KeyUpArrow!)) then
//	if li_fila > 1 then 
//		this.setcolumn('dc_cantid')
//	else
//		beep(1)
//	end if
//end if
//
//if (KeyDown(KeydownArrow!)) then
//	li_max = this.rowcount()
//	this.setrow(li_max)
//	this.scrolltorow(li_max)
//	this.setcolumn('codant')
//	this.setfocus()
//End if
end event

event dw_detail::itemchanged;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : En el detalle al ingresar el c$$HEX1$$f300$$ENDHEX$$digo del item recupera
//               datos relacionados y los inserta en el detalle, controla
// que la cantidad no se anegativa
////////////////////////////////////////////////////////////////////////

long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
long ll_unidad,ll_clase,ll_cta,ll_cod
decimal ll_valortot,ll_valor,ll_valorsum,ld_area, ll_ivavalor
decimal ll_subtot,ll_reten,ll_suma, ld_canti,ll_suma1,ld_null
char lch_kit
decimal ld_area_pedida ,lc_costo_item, lc_costo,lc_desc1,lc_desc2,lc_desc3
string ls, ls_pepa, ls_nombre, ls_null, ls_codant, ls_codigo,ls_prove

ll_filact = this.getRow()
str_prodparam.fila = ll_filact
ll_filActMaster = dw_master.getRow()
is_mensaje = ''
//ls_prove = dw_master.GetitemString(ll_filActMaster,"pv_codigo")

CHOOSE CASE This.GetColumnName()
case 'in_item_it_codant' 
	ls = this.gettext()
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo, it_nombre,it_kit,it_costo
	into :ls_pepa, :ls_nombre,:lch_kit,:lc_costo_item
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls;
   
	if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
	 	select it_codigo, it_codant, it_nombre,it_kit,nvl(it_costo,0)
		into :ls_pepa, :ls_codant, :ls_nombre,:lch_kit, :lc_costo_item
		from in_item
	  	where em_codigo = :str_appgeninfo.empresa
	       and it_codbar = :ls;
     	
		if sqlca.sqlcode <> 0 then
			setnull(ls_null)
			setnull(ld_null)
			this.SetItem(ll_filact,"in_item_it_codant",ls_null)
			this.setitem(ll_filact, 'dp_cantid',ld_null)
			this.setitem(ll_filact, 'in_item_it_nombre',ls_null)
			this.setitem(ll_filact, 'it_codigo',ls_null)
		       //this.setitem(ll_filact, 'bo_codigo', str_appgeninfo.seccion)
	              // this.setitem(ll_filact, 'dc_costo', ld_null)			
			beep(1)
			is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
			return 1
		else
			this.SetItem(ll_filact,"in_item_it_codant",ls_codant)
		end if	 
 	end if
			
	// inserta datos en el detalle, dw_detail
	
//	select  nvl(ip_plista,0),nvl(ip_desc1,0),nvl(ip_desc2,0),nvl(ip_desc3,0)
//	into  :lc_costo,:lc_desc1,:lc_desc2,:lc_desc3
//	from    in_itepro
//	where em_codigo = :str_appgeninfo.empresa
//     and      it_codigo = :ls_pepa
//	and      pv_codigo = :ls_prove; 
//	
//	if sqlca.sqlcode <> 0 then
//		lc_costo = lc_costo_item
//		lc_desc1 = 0
//		lc_desc2 = 0
//		lc_desc3 = 0
//	end if
//	
	this.setitem(ll_filact, 'in_item_it_nombre',ls_nombre)
	this.setitem(ll_filact, 'it_codigo',ls_pepa)
//	this.setitem(ll_filact, 'bo_codigo', str_appgeninfo.seccion)
//	this.setitem(ll_filact, 'dc_costo', lc_costo)
//	this.setitem(ll_filact, 'dc_desc1', lc_desc1)
//	this.setitem(ll_filact, 'dc_desc2', lc_desc2)
//	this.setitem(ll_filact, 'dc_desc3', lc_desc3)
//	this.setitem(ll_filact, 'it_kit', lch_kit)
//	this.SetColumn('dc_cantid')

case  "dp_cantid" 
	// controla que la cantidad no sea negativa
	this.accepttext()
        ic_cantidad = this.getitemdecimal(this.getrow(),"dp_cantid")	
//	if  ic_cantidad <= 0  then
//	is_mensaje = "La cantidad no puede ser negativa o cero"
//   return 1
//	end if	
End choose
end event

event dw_detail::itemerror;messageBox ("Error", is_mensaje)
return 1
end event

event dw_detail::losefocus;//////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Al salir del campo cantidad se inserta una nueva fila
//                      y el foco se cambia a esa fila
////////////////////////////////////////////////////////////////////////

CHOOSE CASE this.getcolumnName()

CASE "dp_cantid"

	If ic_cantidad > 0 Then
		//window lw_aux
		//lw_aux = parent.getActiveSheet()
		dw_detail.SetFocus()
		//if isValid(lw_aux) then lw_aux.postEvent("ue_insert")
		dw_detail.ScrolltoRow(dw_detail.InsertRow(0))
		this.SetColumn('in_item_it_codant')
		str_prodparam.fila = dw_detail.GetRow()
	End if

END CHOOSE
end event

event dw_detail::clicked;//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 
str_prodparam.campo = "dp_cantid"
cantidad_producto_ubica = TRUE

end event

event dw_detail::ue_postinsert;str_prodparam.fila = dw_detail.GetRow()

end event

event dw_detail::getfocus;call super::getfocus;str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow()
str_prodparam.campo = "dp_cantid"
cantidad_producto_ubica = TRUE




end event

event dw_detail::updatestart;Long max,li_i,ll_row
String ls_numnota

ll_row = dw_master.getrow()

if ll_row = 0 then return 1
ls_numnota = dw_master.object.rm_codigo[ll_row]
max = dw_detail.rowcount()

// asigna la secuencia del detalle y borra los que tienen el codigo en blanco
for li_i = 1 to max
this.Object.rm_codigo[li_i] = ls_numnota
this.Object.re_secue[li_i] = li_i
next

return 0
end event

type dw_report from w_sheet_master_detail`dw_report within w_pd_requisicion_materiales
integer x = 73
integer y = 672
integer width = 2158
integer height = 1532
string dataobject = "d_prn_requisicion"
end type

type dw_movim from datawindow within w_pd_requisicion_materiales
boolean visible = false
integer x = 4329
integer y = 4
integer width = 293
integer height = 92
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ord from datawindow within w_pd_requisicion_materiales
integer x = 69
integer y = 108
integer width = 4818
integer height = 500
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_pd_lista_ordenes"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long ll_row,ll_new
String ls_pepa

ll_row = this.getrow()

this.Setrow(row)
this.ScrollToRow(row)
if dwo.name = 't_1' then
	dw_master.reset()
	ll_new = dw_master.insertrow(0)	
	dw_master.Object.or_codigo[ll_new]   = this.object.pd_ordprd_or_codigo[row]	
	dw_master.Object.st_cantidad.text = String(this.object.or_cantid[row])
end if


end event

event rowfocuschanged;String ls_pepa

ls_pepa = dw_ord.object.it_codigo[currentrow]
dw_rta.retrieve(ls_pepa,'C')
	
end event

type st_1 from statictext within w_pd_requisicion_materiales
integer x = 2377
integer y = 1100
integer width = 526
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
string text = "Detalle de la requisici$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pd_requisicion_materiales
integer x = 69
integer y = 36
integer width = 530
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
string text = "Ordenes de producci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type dw_rta from datawindow within w_pd_requisicion_materiales
integer x = 73
integer y = 672
integer width = 2176
integer height = 1592
integer taborder = 30
boolean bringtotop = true
string title = "Composiciones"
string dataobject = "d_materiaprima_x_item"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;SetRowfocusIndicator(Hand!)
end event

type st_4 from statictext within w_pd_requisicion_materiales
integer x = 2373
integer y = 616
integer width = 320
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
string text = "Requisici$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type dw_ubica from datawindow within w_pd_requisicion_materiales
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 1966
integer y = 784
integer width = 1445
integer height = 276
integer taborder = 40
boolean titlebar = true
string title = "Buscar Nota de Recepci$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event itemchanged;string ls_venpro, ls_prove,ls_filtro,ls_rucci
long ll_found,ll_numero,ll_nreg,ll_filam
datawindowchild ldwc_aux

/* VERSION PARA RECUPERAR UNA POR UNA LA ORDEN DE COMPRA*/
CHOOSE CASE this.GetColumnName()
	CASE 'factura'
		ll_numero = long(this.getText())
		ll_nreg = dw_master.retrieve(string(ll_numero),str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
		If ll_nreg = 0 Then
			messagebox("Atencion","Pedido no se encuentra...")
			return
		End if 		
		ll_filam = dw_master.getrow()				
		
		if ll_nreg = 1 then
		dw_detail.retrieve(string(ll_numero))
		end if	
END CHOOSE

end event

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

type st_3 from statictext within w_pd_requisicion_materiales
integer x = 87
integer y = 616
integer width = 343
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
string text = "Composici$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_pd_requisicion_materiales
integer x = 2254
integer y = 1520
integer width = 114
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;String ls_pepa,ls_itcodigo,ls_itcodant,ls_itnombre
Integer li_reg,i,li_new,ll_row
decimal lc_cantidad_a_producir,lc_cantid
Long     ll_new,ll_count

//ll_row = this.getrow()
//if dwo.name = 'b_1' then
	
	
	if Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea utilizar la formulaci$$HEX1$$f300$$ENDHEX$$n para realizar la requisici$$HEX1$$f300$$ENDHEX$$n de material....?",Question!,YesNo!,1) = 2 then return
	dw_detail.reset()
	lc_cantidad_a_producir = dw_ord.object.or_cantid[dw_ord.getrow()]
	

	li_reg = dw_rta.rowcount()
	
	for i = 1 to li_reg
	   
		 
		 ls_pepa = dw_rta.object.it_codigo1[i] // 
	     lc_cantid = dw_rta.object.rq_cantid[i]
		 //determinar si para el c$$HEX1$$f300$$ENDHEX$$digo existe formulaci$$HEX1$$f300$$ENDHEX$$n
		 

         SELECT COUNT(*)
	    INTO : ll_count
		FROM PD_RECETA
		WHERE IT_CODIGO = :ls_pepa
		AND ESTADO = 'F';

         if ll_count > 0 then
			wf_carga_formulacion(ls_pepa,lc_cantid)
		else	
		 ll_new = dw_detail.insertrow(0)		
		dw_detail.Object.it_codigo[ll_new]                 = dw_rta.object.it_codigo1[i]
	    dw_detail.Object.in_item_it_codant[ll_new]    = dw_rta.object.it_codant[i]
	    dw_detail.Object.in_item_it_nombre[ll_new]   = dw_rta.object.it_nombre[i]
	    dw_detail.Object.re_cantid[ll_new]                = dw_rta.object.rq_cantid[i]*lc_cantidad_a_producir
     	end if
	next

end event

type dw_formula from datawindow within w_pd_requisicion_materiales
boolean visible = false
integer x = 2533
integer y = 1648
integer width = 2194
integer height = 504
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Formulaci$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_materiaprima_x_item"
boolean livescroll = true
end type


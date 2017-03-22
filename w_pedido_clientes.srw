HA$PBExportHeader$w_pedido_clientes.srw
$PBExportComments$Si.Recepciones de pedido de una sucursal
forward
global type w_pedido_clientes from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_pedido_clientes
end type
type dw_movim from datawindow within w_pedido_clientes
end type
type dw_ordprd from datawindow within w_pedido_clientes
end type
type pb_1 from picturebutton within w_pedido_clientes
end type
type dw_1 from datawindow within w_pedido_clientes
end type
type st_1 from statictext within w_pedido_clientes
end type
type st_2 from statictext within w_pedido_clientes
end type
type em_1 from editmask within w_pedido_clientes
end type
type em_2 from editmask within w_pedido_clientes
end type
type st_3 from statictext within w_pedido_clientes
end type
type st_4 from statictext within w_pedido_clientes
end type
type cb_1 from commandbutton within w_pedido_clientes
end type
type cb_2 from commandbutton within w_pedido_clientes
end type
end forward

global type w_pedido_clientes from w_sheet_master_detail
integer x = 187
integer y = 360
integer width = 4526
integer height = 2528
string title = "Nota de Pedido"
event ue_consultar pbm_custom16
dw_ubica dw_ubica
dw_movim dw_movim
dw_ordprd dw_ordprd
pb_1 pb_1
dw_1 dw_1
st_1 st_1
st_2 st_2
em_1 em_1
em_2 em_2
st_3 st_3
st_4 st_4
cb_1 cb_1
cb_2 cb_2
end type
global w_pedido_clientes w_pedido_clientes

type variables
boolean ib_match
decimal ic_iva,ic_cantidad
dec{4} ic_costo
long ii_excento_iva,il_sec
string  is_mensaje, is_estado='2',is_codant
integer ii_numli
end variables

forward prototypes
public function boolean wf_descarga_stock_disp_sucursal (string as_item, long al_cantidad)
public function integer wf_preprint ()
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo)
public subroutine wf_insertarfila ()
end prototypes

event ue_consultar;call super::ue_consultar;dw_master.postevent(DoubleClicked!)
dw_master.object.w_observacion.text = '                                         '
dw_master.object.w_fecha_orden.text = '         '
dw_master.object.w_fecha_entrega.text = '         '


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
string ls_pedido

dw_report.SetTransObject(sqlca)
ll_filActMaestro = dw_master.getRow()
ls_pedido = dw_master.getItemString(ll_filActMaestro, "pe_codigo")
dw_report.retrieve(ls_pedido)
		
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

public subroutine wf_insertarfila ();int li_filas,li_numli
string ls_dctocli

li_filas = dw_detail.rowcount()
If li_filas < 1 Then return


If isnull(dw_detail.getitemstring(dw_detail.getrow(),"in_item_it_codant"))  Then 
	dw_detail.deleterow(li_filas)
	return
End if
end subroutine

on w_pedido_clientes.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.dw_movim=create dw_movim
this.dw_ordprd=create dw_ordprd
this.pb_1=create pb_1
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.em_1=create em_1
this.em_2=create em_2
this.st_3=create st_3
this.st_4=create st_4
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.dw_movim
this.Control[iCurrent+3]=this.dw_ordprd
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.em_1
this.Control[iCurrent+9]=this.em_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_2
end on

on w_pedido_clientes.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.dw_movim)
destroy(this.dw_ordprd)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Llena las estructuras para trabajar maestro detalle
//               y para recuperar autom$$HEX1$$e100$$ENDHEX$$ticamente el secuencial de la
// orden de compra
////////////////////////////////////////////////////////////////////////

string ls_parametro[]

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
istr_argInformation.StringValue[3] = str_appgeninfo.seccion
dw_detail.setrowfocusindicator(hand!)

call super::open
dw_master.is_SerialCodeColumn = "pe_codigo"
//dw_master.is_SerialCodeType = "NUM_ORD"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//dw_detail.is_serialCodeDetail = "dc_secue"

// columnas de conecci$$HEX1$$f300$$ENDHEX$$n
dw_master.ii_nrCols = 1
dw_master.is_connectionCols[1] = "pe_codigo"
//dw_master.is_connectionCols[2] = "su_codigo"
//dw_master.is_connectionCols[3] = "ec_codigo"
//dw_master.is_connectionCols[4] = "co_numero"
dw_detail.is_connectionCols[1] = "pe_codigo"
//dw_detail.is_connectionCols[2] = "su_codigo"
//dw_detail.is_connectionCols[3] = "ec_codigo"
//dw_detail.is_connectionCols[4] = "co_numero"
dw_detail.uf_setArgTypes()

//dw_movim.settransobject(sqlca)
//Si quiero que se llene al arrancar el maestro y el detalle
dw_master.sharedata(dw_1)


f_recupera_empresa(dw_detail,"it_codigo")
f_recupera_empresa(dw_detail,"it_codigo_1")

dw_master.uf_insertCurrentRow()
dw_master.setFocus()
dw_master.Setcolumn("ce_codigo")


str_cliparam.ventana = this
str_cliparam.datawindow = dw_master
str_cliparam.fila = dw_master.GetRow() 


dw_ordprd.SetTransObject(sqlca)


end event

event ue_update;// Descripci$$HEX1$$f300$$ENDHEX$$n : Graba los datos de la orden de compra
dwItemStatus   l_status_master
int      max,i=0,rc,li_i
datetime now
long    ll_numero, ll_secue,ll_totalreg,ll_i,ll_num_nota,lc_cantid
decimal lc_pedido, lc_sumsaldo, ld_saldo
string   ls_val ='S', ls_valstk, ls, ls_numero, ls_null, ls_kit
string ls_codigo,ls_atomo
dec{2} lc_stock
dec{4} lc_costo_atomo,lc_cantatomo
char lch_kit
long    ll, ll_filact, ll_fila, ll_contador, ll_contador_mov
boolean lb_mal = FALSE

if dw_master.AcceptText()<>1 then return
if dw_detail.AcceptText()<>1 then return

select sysdate
into: now
from dual;

ll_filact = dw_master.getrow()
l_status_master = dw_master.getitemStatus(ll_filact,0,primary!)
If l_status_master = newmodified! Then

/*Tomar secuencial de pedidos de produccion*/

ll_num_nota = f_secuencial(str_appgeninfo.empresa,"PR_PEDIDOS")

//select pr_valor
//into :ll_num_nota
//from pr_param
//where pr_nombre = 'PR_PEDIDOS'
//and em_codigo = :str_appgeninfo.empresa
//for update of pr_valor;

dw_master.setitem(ll_filact,"pe_codigo",string(ll_num_nota))
end if

max = dw_detail.rowcount()
// asigna la secuencia del detalle y borra los que tienen el codigo en blanco
for li_i = 1 to max
		ls = dw_detail.GetItemString(li_i - i,'it_codigo')
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




//4.- Si todo salio bien grabar la orden de compra
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

//Inicia nuevo comprobante de pedido
//dw_master.Reset()
//dw_detail.Reset()
//dw_master.uf_insertCurrentRow()
dw_master.SetFocus()

end event

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()
end event

event ue_lastrow;call super::ue_lastrow;dw_master.object.w_observacion.text = '                                         '
dw_master.object.w_fecha_orden.text = '         '
dw_master.object.w_fecha_entrega.text = '         '

end event

event ue_firstrow;call super::ue_firstrow;dw_master.object.w_observacion.text = '                                         '
dw_master.object.w_fecha_orden.text = '         '
dw_master.object.w_fecha_entrega.text = '         '

end event

event ue_nextrow;call super::ue_nextrow;dw_master.object.w_observacion.text = '                                         '
dw_master.object.w_fecha_orden.text = '         '
dw_master.object.w_fecha_entrega.text = '         '

end event

event ue_priorrow;call super::ue_priorrow;dw_master.object.w_observacion.text = '                                         '
dw_master.object.w_fecha_orden.text = '         '
dw_master.object.w_fecha_entrega.text = '         '

end event

event ue_anular;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Llama a la funci$$HEX1$$f300$$ENDHEX$$n Anula_nota_de_recepci$$HEX1$$f300$$ENDHEX$$n que elimina de
//               in_compra y de in_detco, luego actualiza el stock
// disminuyendo y finalmente borra el movimiento de inventario
////////////////////////////////////////////////////////////////////////

dwItemStatus    lst_estado
long          ll_numero,ll_maxrow,ll_total_reg
integer      li_res,li_resultado,li_i
string        ls_codigo,ls_enviada,ls_codant,ls_atomo,ls_numrecep
decimal     lc_stock,ld_cantid,lc_costo,ld_costo_atomo,ld_cantatomo
character   lch_kit

ll_total_reg = dw_master.RowCount()
lst_estado 	 = dw_master.GetItemStatus(dw_master.GetRow(),0,Primary!)
ll_numero 	 = dw_master.GetItemNumber(dw_master.GetRow(),"co_numero")
ls_enviada 	 = dw_master.GetItemString(dw_master.GetRow(),"co_enviada")

if lst_estado <> NotModified! then
	MessageBox("ATENCION","Solo se pueden anular recepciones grabadas")
	return -1
else
	if ls_enviada = 'S' then
		li_res = MessageBox("ATENCION","Est$$HEX2$$e1002000$$ENDHEX$$seguro de que quiere anular la nota de recepci$$HEX1$$f300$$ENDHEX$$n No. "+string(ll_numero)+' que ya fue enviada.',Question!,YesNo!)
	else
		li_res = MessageBox("ATENCION","Est$$HEX2$$e1002000$$ENDHEX$$seguro de que quiere anular la nota de recepci$$HEX1$$f300$$ENDHEX$$n No. "+string(ll_numero),Question!,YesNo!)
	end if
	
	if li_res = 1 then
		Setpointer(Hourglass!)
		ls_numrecep = string(ll_numero)		
		
		select  count(*)
		into :ll_maxrow
		from in_itedet
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
		and co_recep = :ls_numrecep
		and estado = 'V';
		
		if ll_maxrow > 0 then
			messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'No se puede anular esta recepci$$HEX1$$f300$$ENDHEX$$n hay veh$$HEX1$$ed00$$ENDHEX$$culos que han sido vendidos...comuniquese con sistemas' )
			return -1
		end if
		if ll_maxrow = 0 then		
			delete from in_itedet
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and co_recep = :ls_numrecep;
			if sqlca.sqlcode <> 0 then
					messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Problemas al borrar la recepci$$HEX1$$f300$$ENDHEX$$n de veh$$HEX1$$ed00$$ENDHEX$$culos ' +sqlca.sqlerrtext, Exclamation! )	
					rollback;	
					return -1
			end if
		end if					
				
		li_resultado = f_anula_nota_recepcion(ll_numero)
		
		if li_resultado = 1 then
			// descargo el stock que consta en el detalle de la nota de recepci$$HEX1$$f300$$ENDHEX$$n
			ll_maxrow = dw_detail.RowCount()
			for li_i = 1 to ll_maxrow
				ls_codigo = dw_detail.GetItemString(li_i,"it_codigo")
				ld_cantid = dw_detail.GetItemNumber(li_i,"dc_cantid")
				ls_codant = dw_detail.getitemstring(li_i,'codant')	
				lc_stock = dec(ld_cantid)	
				lch_kit = dw_detail.getitemstring(li_i,'it_kit')	
				
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
				
				if f_descarga_stock_rt_sucursal(ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = False Then
					rollback;
					messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+ls_codant)
					return -1
				end if
				if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = false Then
					rollback;
					messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+ls_codant)
					return -1
				End if		 					

			next
			
			// borro el ingreso del inventario
			delete from in_movim
			where tm_codigo = '1'
			and tm_ioe = 'I' 
			and em_codigo = 1
			and su_codigo = :str_appgeninfo.sucursal
			and bo_codigo = :str_appgeninfo.seccion
			and ve_numero = to_char(:ll_numero);
			
			if sqlca.sqlcode <> 0 then
					messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Problemas al anular los movimiento del inventario ' +sqlca.sqlerrtext, Exclamation! )	
					rollback;	
					return	 -1
			else
					commit;
			end if
			
			messageBox('RESULTADO','La recepci$$HEX1$$f300$$ENDHEX$$n de pedido No. ' + string(ll_numero) + ' fue anulada completamente ' , Information!, OkCancel!)	
	   	
			if dw_master.GetRow() = ll_total_reg then dw_master.ScrollToRow(ll_total_reg - 1)
				dw_master.setFocus()
				dw_master.Reset()	   	
				dw_detail.Reset()	
			end if 
	end if //de li_resultado = 1
end if


Setpointer(Arrow!)


end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	dw_detail.resize(dw_master.width,li_height - dw_1.height - dw_master.height - 300)
	dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
end if	
this.setRedraw(True)
end event

event ue_retrieve;call super::ue_retrieve;Date     ld_ini,ld_fin

ld_ini = date (em_1.text )
ld_fin = date (em_2.text )
dw_master.enabled = true
dw_detail.enabled = true

dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ld_ini,ld_fin)
end event

type dw_master from w_sheet_master_detail`dw_master within w_pedido_clientes
integer x = 41
integer y = 612
integer width = 4402
integer height = 396
integer taborder = 0
string dataobject = "d_cab_pedido"
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
this.setitem(ll_row,"pe_fecha",f_hoy())
this.object.em_codigo[ll_row] = str_appgeninfo.empresa
this.object.su_codigo[ll_row] = str_appgeninfo.sucursal
this.object.bo_codigo[ll_row] = str_appgeninfo.seccion

end event

event dw_master::itemchanged;call super::itemchanged;long ll_filact,ll_numero
decimal{2} lc_ivavalor,lc_valor,lc_subtot, lc_descue, lc_cargo, lc_valpag
string ls,ls_nomcli, ls_cliente, ls_filtro, ls_vendedor, ls_firma, ls_datos[],ls_tccodigo,ls_column,ls_actividad
char lch_cambven

this.accepttext()
ll_filact = dw_master.getRow()

// con el codigo del cliente
ls_column = getcolumnname()
CHOOSE CASE ls_column
case  'ce_codigo' 
	
	//ib_nograba = false
	ls_cliente = this.getitemstring(ll_filact,"ce_codigo")
    //encuentra el vendedor, si el cliente es exento de iva y la firma
	select ep_codigo,ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep)) 
	into :ls_vendedor,:ls_nomcli
	from fa_clien
	where em_codigo = :str_appgeninfo.empresa
	and    ce_codigo = :ls_cliente;

	if sqlca.sqlcode = 100 then
//	is_mensaje = 'Cliente no registrado'
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Cliente no registrado")
	this.object.ce_razons[ll_filact] = ""
	return 1
	end if
	this.object.ce_razons[ll_filact]= ls_nomcli

END CHOOSE
end event

event dw_master::clicked;call super::clicked;str_cliparam.ventana = parent
str_cliparam.datawindow = dw_master
str_cliparam.fila = this.GetRow() 

end event

event dw_master::updatestart;return 0
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_pedido_clientes
event pbm_dwnkey pbm_keydown
event ue_keydown pbm_keydown
event ue_nextfield pbm_dwnprocessenter
event ue_tabout pbm_dwntabout
integer x = 46
integer y = 1092
integer width = 4398
integer height = 1288
string dataobject = "d_detpedido"
borderstyle borderstyle = stylebox!
end type

event dw_detail::ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event

event dw_detail::ue_tabout;integer li_filas

//wf_insertarfila()
li_filas = dw_detail.insertrow(0)
dw_detail.scrolltorow(li_filas)
dw_detail.setrow(li_filas)
//dw_detail.Modify("DataWindow.HorizontalScrollPosition='"+string(0)+"'")
dw_detail.setcolumn('it_codigo')
dw_detail.setfocus()
return 1
end event

event dw_detail::itemchanged;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : En el detalle al ingresar el c$$HEX1$$f300$$ENDHEX$$digo del item recupera
//               datos relacionados y los inserta en el detalle, controla
// que la cantidad no se anegativa
////////////////////////////////////////////////////////////////////////

long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
long ll_unidad,ll_clase,ll_cta,ll_cod
decimal ll_valortot,ll_valor,ll_valorsum,ld_area, ll_ivavalor
decimal ll_subtot,ll_reten,ll_suma, ld_canti,ll_suma1,ld_null,lc_prefab
char lch_kit
decimal ld_area_pedida ,lc_costo_item, lc_costo,lc_desc1,lc_desc2,lc_desc3
string ls, ls_pepa, ls_nombre, ls_null, ls_codant, ls_codigo,ls_prove

ll_filact = this.getRow()
str_prodparam.fila = ll_filact
ll_filActMaster = dw_master.getRow()
is_mensaje = ''
//ls_prove = dw_master.GetitemString(ll_filActMaster,"pv_codigo")

CHOOSE CASE This.GetColumnName()
case 'it_codigo' 
	ls = this.gettext()
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo, it_nombre,it_kit,it_costo,it_prefab
	into :ls_pepa, :ls_nombre,:lch_kit,:lc_costo_item,:lc_prefab
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codigo = :ls;
   
	if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
	 	select it_codigo, it_codant, it_nombre,it_kit,nvl(it_costo,0),it_prefab
		into :ls_pepa, :ls_codant, :ls_nombre,:lch_kit, :lc_costo_item,:lc_prefab
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
			this.setitem(ll_filact,'dp_pvp',0)
		       //this.setitem(ll_filact, 'bo_codigo', str_appgeninfo.seccion)
	              // this.setitem(ll_filact, 'dc_costo', ld_null)			
			beep(1)
			is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
			return 1
		else
			this.SetItem(ll_filact,"in_item_it_codant",ls_codant)
			this.SetItem(ll_filact,"dp_pvp",lc_prefab)
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
	this.setitem(ll_filact,'dp_pvp',lc_prefab)
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

event dw_detail::clicked;//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 
str_prodparam.campo = "dp_cantid"
cantidad_producto_ubica = TRUE

Long ll_new

if dwo.name = 't_2' then
	dw_ordprd.visible = true
	dw_ordprd.setfocus()
	ll_new = dw_ordprd.insertrow(0)
	dw_ordprd.Object.ce_codigo[ll_new]   =  dw_master.object.ce_codigo[dw_master.getrow()]
	dw_ordprd.object.it_codigo[ll_new]     =  this.object.it_codigo[this.getrow()]
	dw_ordprd.object.it_codant[ll_new]     =  this.object.in_item_it_codant[this.getrow()]
	dw_ordprd.object.it_nombre[ll_new]    =  this.object.in_item_it_nombre[this.getrow()]
	dw_ordprd.object.or_cantid[ll_new]     =  this.object.dp_cantid[this.getrow()]
	dw_ordprd.object.pe_codigo[ll_new]    =  this.object.pe_codigo[this.getrow()]
	dw_ordprd.object.dp_secue[ll_new]     =  this.object.dp_secue[this.getrow()]
end if


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

ls_numnota = dw_master.object.pe_codigo[ll_row]
max = dw_detail.rowcount()

// asigna la secuencia del detalle y borra los que tienen el codigo en blanco
for li_i = 1 to max
this.Object.pe_codigo[li_i] = ls_numnota
this.Object.dp_secue[li_i] = li_i
next

return 0
end event

type dw_report from w_sheet_master_detail`dw_report within w_pedido_clientes
integer x = 0
integer y = 0
integer width = 2587
integer height = 1296
string dataobject = "d_prn_pedido"
end type

type dw_ubica from datawindow within w_pedido_clientes
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 901
integer y = 612
integer width = 1445
integer height = 276
integer taborder = 40
boolean bringtotop = true
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

type dw_movim from datawindow within w_pedido_clientes
boolean visible = false
integer x = 46
integer y = 740
integer width = 293
integer height = 92
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ordprd from datawindow within w_pedido_clientes
event ue_keycode pbm_dwnkey
boolean visible = false
integer x = 219
integer y = 404
integer width = 3227
integer height = 1484
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Orden de producci$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_ord_produccion_auxiliar"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationnever!
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keycode;if keyDown(KeyEscape!) then
	this.Visible = false
       dw_master.SetFocus()
//	dw_master.SetFilter('')
//	dw_master.Filter()
end if
end event

event updatestart;Long ll_row


ll_row = this.getrow()
if ll_row  = 0 then return
il_sec = f_secuencial(str_appgeninfo.empresa,"PR_ORDPRD")
this.object.or_codigo[ll_row] = string(il_sec)

return 0
end event

event updateend;String ls_pecodigo,ls_sec
 long  ll_secue


ls_pecodigo = dw_detail.Object.pe_codigo[dw_detail.getrow()]
ll_secue     = dw_detail.Object.dp_secue[dw_detail.getrow()]

ls_sec = String(il_sec)

UPDATE PD_DETPED
SET OR_CODIGO  = :ls_sec
WHERE PE_CODIGO = :ls_pecodigo
AND DP_SECUE = :ll_secue;


if sqlca.sqlcode <> 0 then
Rollback;
Messagebox("Atencion","Problemas al actualizar el item ..."+sqlca.sqlerrtext) 
return 1
end if

dw_detail.Object.or_codigo[dw_detail.getrow()] = String(il_sec)

RETURN 0
end event

event buttonclicked;if dwo.name = 'b_2' then
  this.reset()
  this.visible = false
end if
end event

type pb_1 from picturebutton within w_pedido_clientes
integer x = 923
integer y = 752
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean flatstyle = true
boolean originalsize = true
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

type dw_1 from datawindow within w_pedido_clientes
integer x = 32
integer y = 108
integer width = 4411
integer height = 432
boolean bringtotop = true
string title = "none"
string dataobject = "d_cab_pedido2"
boolean livescroll = true
end type

event rowfocuschanged;SetRowfocusIndicator(Hand!)

dw_master.scrolltorow(currentrow)
dw_master.setrow(currentrow)


end event

event clicked;this.Setrow(row)
this.ScrolltoRow(row)
end event

type st_1 from statictext within w_pedido_clientes
integer x = 46
integer y = 24
integer width = 242
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
string text = "Pedidos"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pedido_clientes
integer x = 55
integer y = 1028
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
string text = "Detalle"
boolean focusrectangle = false
end type

type em_1 from editmask within w_pedido_clientes
integer x = 503
integer y = 16
integer width = 430
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
boolean spin = true
end type

type em_2 from editmask within w_pedido_clientes
integer x = 1513
integer y = 16
integer width = 411
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
boolean spin = true
end type

type st_3 from statictext within w_pedido_clientes
integer x = 297
integer y = 24
integer width = 197
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_pedido_clientes
integer x = 1326
integer y = 24
integer width = 178
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_pedido_clientes
integer x = 955
integer y = 16
integer width = 96
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_1.text = em_2.text
end event

type cb_2 from commandbutton within w_pedido_clientes
integer x = 1239
integer y = 16
integer width = 96
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_1.text  =  em_2.text

end event


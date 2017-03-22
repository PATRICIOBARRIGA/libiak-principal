HA$PBExportHeader$w_um_recepcion_pedido.srw
$PBExportComments$Si.Recepciones de pedido de una sucursal
forward
global type w_um_recepcion_pedido from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_um_recepcion_pedido
end type
type dw_movim from datawindow within w_um_recepcion_pedido
end type
type dw_1 from datawindow within w_um_recepcion_pedido
end type
end forward

global type w_um_recepcion_pedido from w_sheet_master_detail
integer x = 187
integer y = 360
integer width = 2610
integer height = 1524
string title = "Nota de Recepci$$HEX1$$f300$$ENDHEX$$n"
event ue_consultar pbm_custom16
dw_ubica dw_ubica
dw_movim dw_movim
dw_1 dw_1
end type
global w_um_recepcion_pedido w_um_recepcion_pedido

type variables
boolean ib_match
decimal ic_iva,ic_cantidad
dec{4} ic_costo
long ii_excento_iva
string  is_mensaje, is_estado='2',is_codant

end variables

forward prototypes
public function boolean wf_descarga_stock_disp_sucursal (string as_item, long al_cantidad)
public function integer wf_preprint ()
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costprom)
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
long ll_co_numero
string ls_prove

dw_report.SetTransObject(sqlca)
ll_filActMaestro = dw_master.getRow()
ll_co_numero = dw_master.getItemNumber(ll_filActMaestro, "co_numero")
ls_prove = dw_master.getItemString(ll_filActMaestro, "pv_codigo")

dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
                   is_estado, ll_co_numero, ls_prove)
				
return 1

end function

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costprom);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
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
     dw_movim.setitem(ll_fila,"mv_costtrans",ic_costo/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom/ac_cantatomo)
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
	dw_movim.setitem(ll_fila,"mv_costtrans",ic_costo)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)
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
	dw_movim.setitem(ll_fila,"mv_costtrans",ic_costo)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return(TRUE)

end function

on w_um_recepcion_pedido.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.dw_movim=create dw_movim
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.dw_movim
this.Control[iCurrent+3]=this.dw_1
end on

on w_um_recepcion_pedido.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.dw_movim)
destroy(this.dw_1)
end on

event open;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Llena las estructuras para trabajar maestro detalle
//               y para recuperar autom$$HEX1$$e100$$ENDHEX$$ticamente el secuencial de la
// orden de compra
////////////////////////////////////////////////////////////////////////

string ls_parametro[]

f_recupera_empresa(dw_master,"pv_codigo") 
//ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[1] = str_appgeninfo.sucursal
ls_parametro[2] = '1' // 1 es ORDEN DE COMPRA
f_recupera_datos(dw_master,"co_numpad", ls_parametro,2)
istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = is_estado
dw_detail.setrowfocusindicator(hand!)

call super::open
dw_master.is_SerialCodeColumn = "co_numero"
dw_master.is_SerialCodeType = "NUM_ORD"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//dw_detail.is_serialCodeDetail = "dc_secue"

// columnas de conecci$$HEX1$$f300$$ENDHEX$$n
dw_master.ii_nrCols = 4
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "ec_codigo"
dw_master.is_connectionCols[4] = "co_numero"
dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "ec_codigo"
dw_detail.is_connectionCols[4] = "co_numero"
dw_detail.uf_setArgTypes()

dw_movim.settransobject(sqlca)
//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()

dw_master.uf_insertCurrentRow()
dw_master.setFocus()
end event

event ue_update;// Descripci$$HEX1$$f300$$ENDHEX$$n : Graba los datos de la orden de compra
dwItemStatus   l_status_master
int      max,i=0,rc,li_i
datetime now,ldt_fecrecp
long    ll_numero, ll_secue,ll_totalreg,ll_i,ll_num_nota,lc_cantid
decimal lc_pedido, lc_sumsaldo, ld_saldo
string   ls_val ='S', ls_valstk, ls, ls_numero, ls_null, ls_kit
string ls_codigo,ls_atomo
dec{2} lc_stock
dec{4} lc_costo_atomo,lc_cantatomo,lc_costprom
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
ldt_fecrecp = dw_master.Object.co_fecha[ll_filact]

If l_status_master <> newmodified! Then return

/*Tomar secuencial de la NR*/
select ps_valor
into :ll_num_nota
from pr_numsuc
where pr_nombre = 'NUM_ORD'
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
for update of ps_valor;
	
dw_master.setitem(ll_filact,"co_numero",ll_num_nota)
max = dw_detail.rowcount()
// asigna la secuencia del detalle y borra los que tienen el codigo en blanco
for li_i = 1 to max
		ls = dw_detail.GetItemString(li_i - i,'codant')
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
ll_numero = dw_master.GetItemNumber(ll_filact, 'co_numpad')
dw_movim.reset()
for i = 1 to max
		dw_detail.SetItem(i ,"dc_secue",i)
		dw_detail.Setitem(i ,"co_numero",ll_num_nota)
		dw_detail.Setitem(i ,"ec_codigo",'2')		
		dw_detail.Setitem(i ,"em_codigo",str_appgeninfo.empresa)	
		dw_detail.Setitem(i ,"su_codigo",str_appgeninfo.sucursal)		
		
		lc_cantid = dw_detail.GetitemNumber(i,'dc_cantid')
		ls_codigo = dw_detail.GetitemString(i,'it_codigo')
		is_codant = dw_detail.getitemstring(i,'codant')		
		lch_kit   = dw_detail.getitemstring(i,'it_kit')	
		ic_costo  = dw_detail.getitemdecimal(i,'dc_costo')			
		
		if not isnull(ll_numero) and ll_numero <> 0 then
		
			select dc_cantid
			into :lc_pedido
			from in_detco
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and ec_codigo = '1' 
			and co_numero = :ll_numero
			and it_codigo = :ls_codigo;
			
			if sqlca.sqlcode < 0 then
				messageBox('Error Interno', 'No se puede recuperar pedido ' + sqlca.sqlerrtext)
				rollback;
				return -1
			end if
			
			update in_detco
			set dc_saldo = dc_saldo - :lc_cantid
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and ec_codigo = '1' 
			and co_numero = :ll_numero
			and it_codigo = :ls_codigo;
			if sqlca.sqlcode < 0 then
				messageBox('Error Interno', 'No se puede actualizar saldo de la orden de compra ' + sqlca.sqlerrtext)
				rollback;
				return -1
			end if
		end if
		
		If lch_kit = 'S' Then
			SELECT "IN_ITEM"."IT_COSTO", "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
			INTO :lc_costo_atomo,:ls_atomo, :lc_cantatomo
			FROM "IN_ITEM"  , "IN_RELITEM"
			WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
			("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
			("IN_RELITEM"."TR_CODIGO" = '1' ) and
			( "IN_RELITEM"."IT_CODIGO1" = :ls_codigo ) and
			( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
		End if			
		
		if f_carga_stock_tdr_sucursal_new(ls_codigo,lc_cantid,lch_kit,ls_atomo,lc_cantatomo) = false Then
			rollback;
			return
		End if			
		if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lc_cantid,lch_kit,ls_atomo,lc_cantatomo) = false Then
			rollback;
			return
		End if			


	    //Inicia el c$$HEX1$$e100$$ENDHEX$$lculo del costo promedio
	    //Con cada recepci$$HEX1$$f300$$ENDHEX$$n se registra el nuevo costo 
      	lc_costprom =  f_costprom(ls_codigo,'I',lc_cantid,ic_costo)

	     if wf_mov_inventario(ls_codigo,lc_cantid,ldt_fecrecp,ll_num_nota,&
							lch_kit,ls_atomo,lc_cantatomo,lc_costo_atomo,lc_costprom) = false then
			rollback;
			dw_movim.reset()
 	      messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario")
	      return 
	   end if	  		

		
next
// 2.- Encuentra los saldos de la orden de compra
// para actualizar la orden de compra con el campo completa = null si existen saldos pendientes
declare saldo cursor for
select dc_saldo
from in_detco
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ec_codigo = '1' 
and co_numero = :ll_numero;	 
open saldo;
	do 
	fetch saldo into :lc_sumsaldo;
	if sqlca.sqlcode <> 0 then	exit;
	if lc_sumsaldo > 0 then
	setnull(ls_val)
	exit
	end if
	loop while TRUE;	
close saldo;
	
//3.- Actualiza el campo completa si no existen saldos pendientes
update in_compra
set co_completa = :ls_val
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ec_codigo = '1' 
and co_numero = :ll_numero;
if sqlca.sqlcode < 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la orden de compra")
rollback;
return -1
end if

//4.- Si todo salio bien grabar la orden de compra
rc = dw_master.Update(true,false)
if rc = 1 then
	  rc = dw_detail.update(true,false)
	  if rc = 1 then
	     rc = dw_movim.update(true,false)
		  if rc = 1 then			
		    dw_master.resetupdate()
		    dw_detail.resetupdate()
			 dw_movim.resetupdate()
		    commit;
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

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()
end event

event ue_retrieve;//dw_master.object.w_observacion.text = '                                         '
//dw_master.object.w_fecha_orden.text = '         '
//dw_master.object.w_fecha_entrega.text = '         '

return 1
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

type dw_master from w_sheet_master_detail`dw_master within w_um_recepcion_pedido
integer x = 0
integer y = 0
integer width = 2578
integer height = 604
string dataobject = "d_recepcion_pedido"
end type

event dw_master::itemchanged;
long ll_filact,ll_numero, ll_fildet, ll_secue
decimal lc_ivavalor,lc_valor,lc_subtot, lc_descup, ld_cantid, lc_costo
DECIMAL lc_desc1, lc_desc2, lc_desc3, lc_total, lc_transporte
string ls, ls_prove, ls_filtro, ls_venpro, ls_codant, ls_nombre, ls_codigo
string ls_formpag,ls_observacion
string ls_fecha_orden, ls_fecha_entrega, ls_codRuc,ls_rucci
char   lch_kit
boolean lb_match
datawindowchild ldwc_aux

ll_filact = dw_master.getRow()

If dwo.name = "co_numpad"  Then//si cambia el n$$HEX1$$fa00$$ENDHEX$$mero de la $$HEX1$$f300$$ENDHEX$$rden de compra
	//If ib_match Then
	ll_numero = long(this.GetText())
	// recupera la cabecera de la orden de compra ingresada
	select pv_codigo, vp_codigo, fp_codigo, co_transpor, co_observ,to_char(co_fecha,'dd/mm/yyyy'), to_char(co_fecent,'dd/mm/yyyy'),co_rucsuc
	into :ls_prove, :ls_venpro, :ls_formpag, :lc_transporte, :ls_observacion, :ls_fecha_orden, :ls_fecha_entrega, :ls_codRuc
	from in_compra
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and ec_codigo = '1' // es orden de compra
	and co_numero = :ll_numero;

	// inserta los datos de la orden de compra en la cabecera de la 
	// recepci$$HEX1$$f300$$ENDHEX$$n, dw_master
	
	select pv_rucci
	into :ls_rucci
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
   and 	pv_codigo = :ls_prove;
	
	this.SetItem(ll_filact,'pv_codigo',ls_prove)
	ls_filtro = "pv_codigo = '"+ ls_prove + "' and vp_codigo ='"+ls_venpro+"'"
	this.getChild("vp_codigo", ldwc_aux)
	ldwc_aux.SetFilter(ls_filtro)
	ldwc_aux.Filter()
	this.SetItem(ll_filact,'vp_codigo',ls_venpro)
	this.SetItem(ll_filact,'fp_codigo',ls_formpag)	
	this.SetItem(ll_filact,'co_transpor',lc_transporte)
	this.SetItem(ll_filact,'co_rucsuc',ls_codruc)	
	this.SetItem(ll_filact,'ec_codpad','1') //1 --> ORDEN DE COMPRA
	this.modify("st_ruc.text = '"+ls_rucci+"'")
	
	if not isnull(ls_observacion) then
		this.object.w_observacion.text = ls_observacion
	else
		this.object.w_observacion.text = '                                 '
	end if	
	
	if not isnull(ls_fecha_orden) then
	   this.object.w_fecha_orden.text = ls_fecha_orden
	else
		this.object.w_fecha_orden.text = '                                 '
   end if
	
	if not isnull(ls_fecha_entrega)then
   	this.object.w_fecha_entrega.text = ls_fecha_entrega
	else
		this.object.w_fecha_entrega.text = '                                 '
	end if
	
   dw_detail.Reset()
 	
	// encuentra el detalle de la compra
	
	DECLARE det_fact CURSOR FOR  
		  SELECT "IN_ITEM"."IT_CODANT","IN_ITEM"."IT_NOMBRE","IN_ITEM"."IT_KIT",
		  			"IN_DETCO"."IT_CODIGO","IN_DETCO"."DC_SALDO","IN_DETCO"."DC_SECUE",
				  "IN_DETCO"."DC_COSTO","IN_DETCO"."DC_DESC1","IN_DETCO"."DC_DESC2",
				  "IN_DETCO"."DC_DESC3","IN_DETCO"."DC_SUBTOT","IN_DETCO"."DC_TOTAL"
		  FROM "IN_DETCO",   
					"IN_ITEM"  
			 WHERE ( "IN_DETCO"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO" ) and 
					( "IN_DETCO"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO" ) and
						 ( "IN_DETCO"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
						 ( "IN_DETCO"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
						 ( "IN_DETCO"."EC_CODIGO" = '1' ) AND  
						 ( "IN_DETCO"."CO_NUMERO" = :ll_numero ) AND
					( "IN_DETCO"."DC_SALDO" > 0 ) 
		 ORDER BY "IN_DETCO"."DC_SECUE";
	
	// inserta el detalle de la compra en el dw_detail de la orden de compra
	OPEN det_fact;
	
	ll_fildet = 0
	
	DO
		FETCH det_fact 
		 INTO :ls_codant,:ls_nombre,:lch_kit,:ls_codigo, :ld_cantid, :ll_secue,
		      :lc_costo, :lc_desc1, :lc_desc2, :lc_desc3, :lc_subtot, :lc_total;
		if sqlca.sqlcode <> 0 then
			exit;
		end if
		
		dw_detail.SetFocus()
		dw_detail.InsertRow(0)
		ll_fildet += 1
		dw_detail.SetItem(ll_fildet,'dc_secue',ll_secue)
		dw_detail.SetItem(ll_fildet,'codant',ls_codant)
		dw_detail.SetItem(ll_fildet,'nombre',ls_nombre)
		dw_detail.SetItem(ll_fildet,'it_kit',lch_kit)		
		dw_detail.SetItem(ll_fildet,'it_codigo',ls_codigo)
		dw_detail.SetItem(ll_fildet,'dc_cantid',ld_cantid)
		dw_detail.setitem(ll_fildet, 'bo_codigo', str_appgeninfo.seccion)
		dw_detail.setitem(ll_fildet, 'dc_costo', lc_costo)
		dw_detail.setitem(ll_fildet, 'dc_desc1', lc_desc1)
		dw_detail.setitem(ll_fildet, 'dc_desc2', lc_desc2)
		dw_detail.setitem(ll_fildet, 'dc_desc3', lc_desc3)
		dw_detail.setitem(ll_fildet, 'dc_subtot', lc_subtot)
		dw_detail.setitem(ll_fildet, 'dc_total', lc_total)
	LOOP WHILE TRUE;	
	
	CLOSE det_fact;
	
	// inserta en la cabecera "ec_codigo" = 2 nota de recepci$$HEX1$$f300$$ENDHEX$$n
	this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
	this.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
	this.SetItem(ll_filact,"ec_codigo",is_estado)
  //End if
End if

If dwo.name =  "pv_codigo"  Then// si cambia el proveedor
//	controla que dado el proveedor,se paga iva o no ?
	ls_prove = this.GetText()
	select pv_caract,pv_rucci
	into :ls,:ls_rucci
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
	  and pv_codigo = :ls_prove;
	
	if sqlca.sqlcode <> 0 then
		is_mensaje = 'Proveedor no registrado'
		return 1
	end if
	
	if ls = 'S' then
		ii_excento_iva = 0
	else
		Select pr_valor
		  into :ic_iva
		  from pr_param
	    where em_codigo = :str_appgeninfo.empresa
		   and pr_nombre = 'IVA';
		ii_excento_iva = 1
	end if
	
	// filtra los vendedores del proveedor
	ls_filtro = "pv_codigo = " +"'"+ ls_prove + "'"
	this.getChild("vp_codigo", ldwc_aux)
	ldwc_aux.SetFilter(ls_filtro)
	ldwc_aux.Filter()
	this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
	this.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
	this.SetItem(ll_filact,"ec_codigo",is_estado)
	this.modify("st_ruc.text = '"+ls_rucci+"'")
End if	

If dwo.name =  "co_observ" Then
	// si realiza cambios en la observaci$$HEX1$$f300$$ENDHEX$$n se cambia el foco al detalle
	//dw_detail.InsertRow(0)
	dw_detail.SetColumn('codant')
	dw_detail.SetFocus()	
	//dw_detail.PostEvent(Clicked!)
End if

end event

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
	CASE 'co_observ'
		if dw_detail.RowCount() = 0 then
 		  dw_detail.ScrolltoRow(dw_detail.InsertRow(0))
		  dw_detail.setitem(1,"codant",'')
		  dw_detail.SetColumn('codant')
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
this.setitem(ll_row,"co_fecha",f_hoy())

end event

type dw_detail from w_sheet_master_detail`dw_detail within w_um_recepcion_pedido
event pbm_dwnkey pbm_keydown
event ue_keydown pbm_keydown
integer x = 0
integer y = 604
integer width = 2578
integer height = 792
string dataobject = "d_um_detalle_recepcion_pedido"
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
ls_prove = dw_master.GetitemString(ll_filActMaster,"pv_codigo")

CHOOSE CASE This.GetColumnName()
case 'codant' 
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
			this.SetItem(ll_filact,"codant",ls_null)
			this.setitem(ll_filact, 'dc_cantid',ld_null)
	          this.setitem(ll_filact, 'nombre',ls_null)
   	          this.setitem(ll_filact, 'it_codigo',ls_null)
	         //this.setitem(ll_filact, 'bo_codigo', str_appgeninfo.seccion)
   	           this.setitem(ll_filact, 'dc_costo', ld_null)			
			beep(1)
			is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
			return 1
		else
			this.SetItem(ll_filact,"codant",ls_codant)
		end if	 
 	end if
			
	// inserta datos en el detalle, dw_detail
	
	select  nvl(ip_plista,0),nvl(ip_desc1,0),nvl(ip_desc2,0),nvl(ip_desc3,0)
	into  :lc_costo,:lc_desc1,:lc_desc2,:lc_desc3
	from    in_itepro
	where em_codigo = :str_appgeninfo.empresa
     and      it_codigo = :ls_pepa
	and      pv_codigo = :ls_prove; 
	
	if sqlca.sqlcode <> 0 then
		lc_costo = lc_costo_item
		lc_desc1 = 0
		lc_desc2 = 0
		lc_desc3 = 0
	end if
	
	this.setitem(ll_filact, 'nombre',ls_nombre)
	this.setitem(ll_filact, 'it_codigo',ls_pepa)
	this.setitem(ll_filact, 'bo_codigo', str_appgeninfo.seccion)
	this.setitem(ll_filact, 'dc_costo', lc_costo)
	this.setitem(ll_filact, 'dc_desc1', lc_desc1)
	this.setitem(ll_filact, 'dc_desc2', lc_desc2)
	this.setitem(ll_filact, 'dc_desc3', lc_desc3)
	this.setitem(ll_filact, 'it_kit', lch_kit)
	this.SetColumn('dc_cantid')

case  "dc_cantid" 
	// controla que la cantidad no sea negativa
	this.accepttext()
   ic_cantidad = this.getitemdecimal(this.getrow(),"dc_cantid")	
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

CASE "dc_cantid"

	If ic_cantidad > 0 Then
		//window lw_aux
		//lw_aux = parent.getActiveSheet()
		dw_detail.SetFocus()
		//if isValid(lw_aux) then lw_aux.postEvent("ue_insert")
		dw_detail.ScrolltoRow(dw_detail.InsertRow(0))
		this.SetColumn('codant')
		str_prodparam.fila = dw_detail.GetRow()
	End if

END CHOOSE
end event

event dw_detail::clicked;String null_str,ls_codant,ls_codigo,ls_nombre
SetNull(null_str)
long ll_reg,ll_i,ll_cantid
dec{4} lc_costo


str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 
str_prodparam.campo = "dc_cantid"
cantidad_producto_ubica = TRUE

if dwo.name = 't_5' then
    dw_1.reset()
    this.reset()	 
    ll_reg = dw_1.importfile(null_str) 	 
    for ll_i = 1 to ll_reg
 
			this.insertrow(0)
						
			ls_codant = dw_1.getitemstring(ll_i,"codant")
			lc_costo  = dw_1.object.costo[ll_i]
			ll_cantid = dw_1.object.cantidad[ll_i]
			
			if ll_cantid <= 0 then 
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","En el archivo que se est$$HEX2$$e1002000$$ENDHEX$$importando existen productos con cantidad  menor o igual a cero (0)....<Por favor verifique!!!>")
				w_marco.Setmicrohelp("La Importaci$$HEX1$$f300$$ENDHEX$$n fall$$HEX1$$f300$$ENDHEX$$")
				return
			end if	
			
			if lc_costo <= 0 then 
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","En el archivo que se est$$HEX2$$e1002000$$ENDHEX$$importando existen productos con costo menor a 0...<Por favor verifique!!!>")
			    w_marco.Setmicrohelp("La Importaci$$HEX1$$f300$$ENDHEX$$n fall$$HEX1$$f300$$ENDHEX$$")
				return
			end if	
									
			select it_codigo,it_nombre
			into :ls_codigo,:ls_nombre
			from in_item
			where em_codigo = :str_appgeninfo.empresa
			and it_codant = :ls_codant;
			if sqlca.sqlcode <> 0 then
				messagebox("Error...verifique","No existe c$$HEX1$$f300$$ENDHEX$$digo de veh$$HEX1$$ed00$$ENDHEX$$culo: "+ls_codant,stopsign!)
				return
			end if
						
			this.setitem(ll_i,"em_codigo",str_appgeninfo.empresa)
			this.setitem(ll_i,"su_codigo",str_appgeninfo.sucursal)
			this.setitem(ll_i,"bo_codigo",str_appgeninfo.seccion)
			
			this.setitem(ll_i,"dc_secue",ll_i)		
						
			this.setitem(ll_i,"it_codigo",ls_codigo)
			this.setitem(ll_i,"codant",ls_codant)
			this.setitem(ll_i,"nombre",ls_nombre)
						
			this.setitem(ll_i,"dc_cantid",ll_cantid)
			this.setitem(ll_i,"dc_costo" ,lc_costo)
    next	
end if
end event

event dw_detail::ue_postinsert;str_prodparam.fila = dw_detail.GetRow()

end event

event dw_detail::getfocus;call super::getfocus;str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow()
str_prodparam.campo = "dc_cantid"
cantidad_producto_ubica = TRUE




end event

type dw_report from w_sheet_master_detail`dw_report within w_um_recepcion_pedido
integer x = 0
integer y = 0
integer width = 2587
integer height = 1296
string dataobject = "d_rep_nota_recepcion"
end type

type dw_ubica from datawindow within w_um_recepcion_pedido
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 544
integer y = 284
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
		ll_nreg = dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'2',ll_numero)
		If ll_nreg = 0 Then
			messagebox("Atencion","La Nota de recepcion fue procesada~r~n"+&
			           "$$HEX2$$f3002000$$ENDHEX$$no existe n$$HEX1$$fa00$$ENDHEX$$mero de nota de recepcion")
			return
		End if 		
		ll_filam = dw_master.getrow()				
		ls_prove = dw_master.getItemstring(ll_filam,'pv_codigo')
		ls_venpro = dw_master.getItemstring(ll_filam,'vp_codigo')		
		ls_filtro = "pv_codigo = '"+ ls_prove + "' and vp_codigo ='"+ls_venpro+"'"
		dw_master.getChild("vp_codigo", ldwc_aux)
		ldwc_aux.SetFilter(ls_filtro)
		ldwc_aux.Filter()
		dw_master.SetItem(ll_filam,'vp_codigo',ls_venpro)		
		select pv_rucci
		into :ls_rucci
		from in_prove
		where em_codigo = :str_appgeninfo.empresa
		and 	pv_codigo = :ls_prove;		
		dw_master.modify("st_ruc.text = '"+ls_rucci+"'")
		dw_master.SetItemStatus(ll_filam,0,Primary!,notmodified!)				

	   if ll_nreg = 1 then
		dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'2',ll_numero)
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

type dw_movim from datawindow within w_um_recepcion_pedido
boolean visible = false
integer x = 18
integer y = 456
integer width = 293
integer height = 72
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_um_recepcion_pedido
boolean visible = false
integer x = 2592
integer y = 600
integer width = 1216
integer height = 800
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_um_importacion_items"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


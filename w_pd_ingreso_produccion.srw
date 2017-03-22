HA$PBExportHeader$w_pd_ingreso_produccion.srw
$PBExportComments$Ingreso de items producidos a inventario
forward
global type w_pd_ingreso_produccion from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_pd_ingreso_produccion
end type
type dw_movim from datawindow within w_pd_ingreso_produccion
end type
type st_2 from statictext within w_pd_ingreso_produccion
end type
type st_3 from statictext within w_pd_ingreso_produccion
end type
type dw_1 from datawindow within w_pd_ingreso_produccion
end type
type cb_1 from commandbutton within w_pd_ingreso_produccion
end type
type dw_rta from datawindow within w_pd_ingreso_produccion
end type
type uo_egprd from uo_ajustes within w_pd_ingreso_produccion
end type
type dw_mp from datawindow within w_pd_ingreso_produccion
end type
type cb_rev from commandbutton within w_pd_ingreso_produccion
end type
type st_4 from statictext within w_pd_ingreso_produccion
end type
type cb_2 from commandbutton within w_pd_ingreso_produccion
end type
type cb_3 from commandbutton within w_pd_ingreso_produccion
end type
type r_1 from rectangle within w_pd_ingreso_produccion
end type
end forward

global type w_pd_ingreso_produccion from w_sheet_master_detail
integer width = 6075
integer height = 2572
string title = "Ingreso de Producto Terminado"
event ue_consultar pbm_custom15
dw_ubica dw_ubica
dw_movim dw_movim
st_2 st_2
st_3 st_3
dw_1 dw_1
cb_1 cb_1
dw_rta dw_rta
uo_egprd uo_egprd
dw_mp dw_mp
cb_rev cb_rev
st_4 st_4
cb_2 cb_2
cb_3 cb_3
r_1 r_1
end type
global w_pd_ingreso_produccion w_pd_ingreso_produccion

type variables
string  is_nombodega,is_empleado,is_mensaje,is_codant1
boolean ib_ponmensaje, ib_not_item_found = FALSE, ib_not_stock_found = FALSE,ib_not_more_stock = FALSE
decimal id_stock
long il_numero
boolean ib_mismas_bodegas = FALSE
dataStore ids_req  //detalle de la requisicion de materiales
string is_numord,is_numreq,is_mov

end variables

forward prototypes
public function integer wf_preprint ()
public function integer wf_controla_stock_bodega (integer num_filas)
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_tipomov, string as_signomov, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo, decimal ac_costprom)
public function integer wf_load_formulacion (string as_pepa, decimal ac_cantidad_producida, string as_tipreceta)
end prototypes

event ue_consultar;call super::ue_consultar;dw_master.postevent(DoubleClicked!)
end event

public function integer wf_preprint ();//dataWindowChild ldwc_aux
//long ll_filActMaestro
//string ls_numero, ls_tipo, ls_ioe
//
//dw_report.SetTransObject(sqlca)
//ll_filActMaestro = dw_master.getRow()
//ls_numero = dw_master.getItemString(ll_filActMaestro, "aj_numero")
//ls_tipo = dw_master.getItemString(ll_filActMaestro, "tm_codigo")
//ls_ioe = dw_master.getItemString(ll_filActMaestro, "tm_ioe")
//
//dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
//                   ls_tipo, ls_ioe, ls_numero)
//				

String ls_rc,ls_tipo,ls_ioe,ls_nro
long ll_row ,ll_reg


open(w_response_impresion_ajustes)
ls_rc = Message.StringParm

if isnull(ls_rc) then return -1

If ls_rc = "I" Then
	ls_tipo = '23'
	ls_ioe = 'I'
	ll_row = dw_master.getrow()
	if ll_row = 0 then 
		dw_report.reset()
		return -1
	end if
	 ls_nro = dw_master.Object.aj_numero[ll_row]
else
	ls_tipo = '22'
	ls_ioe = 'E'
     ll_row =  uo_egprd.dw_master.getrow()
	if ll_row = 0 then 
	dw_report.reset()	
	return -1
     end if
	ls_nro = uo_egprd.dw_master.Object.aj_numero[ll_row]
end if


ll_reg = dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo,ls_ioe,ls_nro)
if ll_reg = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No hay datos con estas condiciones...!!!")
	return -1
end if

return 1

end function

public function integer wf_controla_stock_bodega (integer num_filas);//Descripcion: Funcion que controla el stock maximo disponible de un producto para que sea facturado
//fecha de creaci$$HEX1$$f300$$ENDHEX$$n : 10/05/2001
//Ultima revision:27/09/2001

integer i,j
string ls_item,ls,ls_codant,ls_kit,ls_valstk,ls_codigo_atomo
dec{2} lc_stock,lc_candes,lc_candes_aux,lc_cantidad,lc_stock_disponible

for i =1 to num_filas
ls_item = dw_detail.getitemstring(i,"it_codigo")
lc_cantidad = dw_detail.getitemdecimal(i,"da_cantidad")	
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
				lc_candes_aux = dw_detail.getitemdecimal(j,"da_cantidad")
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

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_tipomov, string as_signomov, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo, decimal ac_costprom);////////////////////////////////////////////////////////////////////////
// Decripci$$HEX1$$f300$$ENDHEX$$n : inserta los movimientos de inventario del item, si es
//               kit tambi$$HEX1$$e900$$ENDHEX$$n de sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
// Retorna verdadero si todo sali$$HEX2$$f3002000$$ENDHEX$$bien.
// Fecha de Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 19-10-2004
///////////////////////////////////////////////////////////////////////

long ll_num_movim,ll_fila
string ls_num_movim,ls_nulo,ls_observa,ls_obs_kit
boolean lb_exito = TRUE


setnull(ls_nulo)
ls_observa = "Ajuste de "+as_signomov+". No. "+string(il_numero)+" de "+is_nombodega + " Ord.Prd: "+is_numord
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Ajuste de "+as_signomov+". del kit "+is_codant1+" No. "+string(il_numero)+" de "+is_nombodega + " Ord.Prd: "+is_numord
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",as_tipomov)
	dw_movim.setitem(ll_fila,"tm_ioe",as_signomov)
	dw_movim.setitem(ll_fila,"it_codigo",as_atomo)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad * ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo_atomo)
     dw_movim.setitem(ll_fila,"mv_costtrans",ac_costprom/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_obs_kit)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",il_numero)		
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
	dw_movim.setitem(ll_fila,"tm_codigo",as_tipomov)
	dw_movim.setitem(ll_fila,"tm_ioe",as_signomov)
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",il_numero)		
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
	dw_movim.setitem(ll_fila,"tm_codigo",as_tipomov)
	dw_movim.setitem(ll_fila,"tm_ioe",as_signomov)
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",il_numero)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return(TRUE)


end function

public function integer wf_load_formulacion (string as_pepa, decimal ac_cantidad_producida, string as_tipreceta);integer j,li_reg
decimal lc_cantid,lc_costo
long ll_new
string ls_clase

li_reg = dw_rta.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,as_pepa,as_tipreceta,ac_cantidad_producida)

for j = 1 to li_reg
  
     	 as_pepa = dw_rta.object.it_codigo1[j] // codigo del componente (materia prima)
	     lc_cantid = dw_rta.object.rq_cantid[j]

         //determinar si para el c$$HEX1$$f300$$ENDHEX$$digo existe formulaci$$HEX1$$f300$$ENDHEX$$n
		SELECT IT_COSTO,CL_CODIGO
		into  :lc_costo,:ls_clase
		FROM IN_ITEM
		WHERE IT_CODIGO = :as_pepa;
		
		if ls_clase = '1.2' then
			wf_load_formulacion(as_pepa,lc_cantid,'F')
		else
			ll_new = uo_egprd.dw_detail.insertrow(0)		
			uo_egprd.dw_detail.Object.it_codigo[ll_new]                = dw_rta.object.it_codigo1[j]
			uo_egprd.dw_detail.Object.codant[ll_new]                    = dw_rta.object.it_codant[j]
			uo_egprd.dw_detail.Object.it_nombre[ll_new]               = dw_rta.object.it_nombre[j]
			uo_egprd.dw_detail.Object.da_cantidad[ll_new]            = dw_rta.object.rq_cantid[j]*ac_cantidad_producida
			uo_egprd.dw_detail.object.da_costo[ll_new]                 = lc_costo 
		end if

next
	
return 1
end function

on w_pd_ingreso_produccion.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.dw_movim=create dw_movim
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_rta=create dw_rta
this.uo_egprd=create uo_egprd
this.dw_mp=create dw_mp
this.cb_rev=create cb_rev
this.st_4=create st_4
this.cb_2=create cb_2
this.cb_3=create cb_3
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.dw_movim
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_rta
this.Control[iCurrent+8]=this.uo_egprd
this.Control[iCurrent+9]=this.dw_mp
this.Control[iCurrent+10]=this.cb_rev
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.r_1
end on

on w_pd_ingreso_produccion.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.dw_movim)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_rta)
destroy(this.uo_egprd)
destroy(this.dw_mp)
destroy(this.cb_rev)
destroy(this.st_4)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.r_1)
end on

event open;datawindowchild ldwc_mov


f_recupera_empresa(dw_master,"tm_codigo")


dw_master.Getchild("tm_codigo",ldwc_mov)
ldwc_mov.setfilter("tm_sigla = 'S'")
ldwc_mov.filter()

select ep_codigo
into :is_empleado
from no_emple
where em_codigo = :str_appgeninfo.empresa
and  sa_login = :str_appgeninfo.username;

istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[3] = str_appgeninfo.seccion

dw_master.SetTransObject(sqlca)
dw_movim.SetTransObject(sqlca)

//if dw_master.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,&
//                      str_appgeninfo.seccion) < 0 then
//	dw_master.InsertRow(1)
//end if

//dw_master.is_SerialCodeColumn = "aj_numero"
//dw_master.is_SerialCodeType = "NUM_AJUS"
//dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//
call super::open

//dw_detail.is_SerialCodeDetail = "da_secuen"

dw_master.ii_nrCols = 6
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "bo_codigo"
dw_master.is_connectionCols[4] = "tm_codigo"
dw_master.is_connectionCols[5] = "tm_ioe"
dw_master.is_connectionCols[6] = "aj_numero"
dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "bo_codigo"
dw_detail.is_connectionCols[4] = "tm_codigo"
dw_detail.is_connectionCols[5] = "tm_ioe"
dw_detail.is_connectionCols[6] = "aj_numero"
dw_detail.uf_setArgTypes()

dw_master.uf_insertcurrentrow()
dw_master.setFocus()
//dw_master.uf_retrieve()

//
dw_1.SetTransObject(sqlca)
dw_1.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)

dw_rta.SetTransObject(sqlca)
dw_mp.SetTransObject(sqlca)
dw_report.SetTransObject(sqlca)
//dw_cmp.SetTransObject(sqlca)


end event

event ue_update;integer rc,li_i,i,li_filact,li_fila
string ls_numajuste,ls_tipo_mov,ls_signo_mov,ls_codigo,ls_numero,ls_atomo
datetime ld_fecha
dec{2} lc_cantidad
dec{4} lc_costo_atomo,lc_cantatomo,lc_costo,lc_costprom
integer li_pasa
character lch_kit,lch_estado
dwitemstatus l_status 

li_filact = dw_master.getrow()

if li_filact = 0 then return
li_fila = dw_detail.RowCount()
dw_movim.reset()
If li_fila <= 0  Then
messagebox("Error","Debe ingresar el detalle para actualizar el ajuste de inventarios")
return
End if

/*No permitir grabar si el registro ya existe*/
l_status = dw_master.getitemstatus(li_filact,0,Primary!)
if l_status = notmodified! or l_status = datamodified!&
then
messagebox("Error","Este registro ya fue grabado")
rollback;
return
end if

// borra las filas en blanco
for li_i = 1 to li_fila
	is_codant1 = dw_detail.GetItemString(li_i - i,'codant')
	if isnull(is_codant1) or is_codant1 = '' then
   	dw_detail.DeleteRow(li_i - i )
		i=i+1	  
	end if
next

li_fila = dw_detail.RowCount()

il_numero = f_dame_sig_numero('NUM_AJUS')

if il_numero <= 0 then
	messagebox("Atenc$$HEX1$$ed00$$ENDHEX$$on","Problemas al obtener el secuencial del ajuste")
	rollback;
	return
end if 

ls_numero = string(il_numero)
dw_master.setitem(li_filact,"aj_numero",ls_numero)

ld_fecha = dw_master.GetItemDateTime(li_filact,"aj_fecha")
ls_tipo_mov = dw_master.GetItemString(li_filact,"tm_codigo")
ls_signo_mov = dw_master.GetItemString(li_filact,"tm_ioe")
if ls_signo_mov = 'I' and ls_tipo_mov = '3' then
	dw_master.setitem(li_filact,"aj_estado",'N')
end if	
//Encuentra el nombre de la bodega
select bo_nombre
into :is_nombodega
from in_bode
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and bo_codigo = :str_appgeninfo.seccion;

dw_detail.accepttext()
//funcion que controla el stock m$$HEX1$$e100$$ENDHEX$$ximo a venderse de un producto
If ls_signo_mov = 'E' Then
	li_pasa = wf_controla_stock_bodega(li_fila)
	If li_pasa = -1 Then
	
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha podido grabar este Ajuste~r~n"+&
								"Debido a que el stock disponible del producto ["+is_codant1+"]~r~n"+&
								"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>")
			rollback;					
			return
	End if
End if

for i =1 to li_fila
	lc_cantidad = dw_detail.getitemnumber(i,'da_cantidad')	
	ls_codigo = dw_detail.getitemstring(i,'it_codigo')	
	is_codant1 = dw_detail.getitemstring(i,'codant')		
	lch_kit = dw_detail.getitemstring(i,'it_kit')	
	lc_costo = dw_detail.getitemdecimal(i,'it_costo')		

	
	dw_detail.setitem(i,"aj_numero",ls_numero)
	dw_detail.setitem(i,"em_codigo",str_appgeninfo.empresa)		 	 
	dw_detail.setitem(i,"su_codigo",str_appgeninfo.sucursal)		 	 	 
	dw_detail.setitem(i,"bo_codigo",str_appgeninfo.seccion)		 	 	 
	dw_detail.setitem(i,"tm_codigo",ls_tipo_mov)		 
	dw_detail.setitem(i,"tm_ioe",ls_signo_mov) 	 
	dw_detail.setitem(i,"da_secuen",string(i))
	
	If lch_kit = 'S' Then
		SELECT NVL("IN_ITEM"."IT_COSTO",0), "IN_RELITEM"."IT_CODIGO", NVL("IN_RELITEM"."RI_CANTID",0)
		INTO :lc_costo_atomo,:ls_atomo, :lc_cantatomo
		FROM "IN_ITEM"  , "IN_RELITEM"
		WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
		("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
		("IN_RELITEM"."TR_CODIGO" = '1' ) and
		( "IN_RELITEM"."IT_CODIGO1" = :ls_codigo ) and
		( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
	End if
	
	// si es egreso
	if ls_signo_mov = 'E' then
		if f_descarga_stock_rt_sucursal(ls_codigo,lc_cantidad,lch_kit,ls_atomo,lc_cantatomo) = False Then
			rollback;
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+is_codant1)
			return
		end if
		if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_cantidad,lch_kit,ls_atomo,lc_cantatomo) = false Then
			rollback;
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+is_codant1)
			return
		End if					
	elseif ls_signo_mov = 'I' then
		// carga el stock te$$HEX1$$f300$$ENDHEX$$rico,real,disponible
		if f_carga_stock_tdr_sucursal_new(ls_codigo,lc_cantidad,lch_kit,ls_atomo,lc_cantatomo) = false Then
			return
		End if			
		// carga el stock en bodega		
		if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lc_cantidad,lch_kit,ls_atomo,lc_cantatomo) = false Then
			return
		End if			
	end if	
	
	//Determinar el costo promedio
	select NVL(it_costprom,0)
	into   :lc_costprom
	from in_item
	where it_codigo = :ls_codigo;
	
	if sqlca.sqlcode <> 0 then
	lc_costprom = 0	
	end if
		
    //El costo de la transacci$$HEX1$$f300$$ENDHEX$$n en este caso es el costo promedio  
	lc_costprom =  f_costprom(ls_codigo,ls_signo_mov,lc_cantidad,lc_costprom)
		
	// inserta los movimientos de Inventarios
	if wf_mov_inventario(ls_codigo,lc_cantidad,ld_fecha,ls_tipo_mov,ls_signo_mov,+&
								lch_kit,ls_atomo,lc_cantatomo,lc_costo_atomo,lc_costo,lc_costprom) = false then
		rollback;								
		Messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario()")
		dw_movim.reset()
		return
   end if
next 



//5.- Actualizo los datos de la factura
//Realiza el egreso de la materia prima  por cada item ingresado
//cb_1.triggerevent(clicked!)
//rc = uo_egprd.il_rc		

		rc =  dw_master.update(true,false) 
		if rc = 1 then
				 rc = dw_detail.update(true,false)
				 if rc = 1 then
							  rc =  dw_movim.update(true,false)
							  if rc = 1 then	
									 //Actualizar la orden de producci$$HEX1$$f300$$ENDHEX$$n con el total del costo
									dw_master.resetupdate()
									dw_detail.resetupdate()
									dw_movim.resetupdate()	
									
									
									UPDATE PD_ORDPRD
									SET  OR_ESTADO = 'I'
									WHERE OR_CODIGO = :is_numord;
									
									
									commit;  
							 else
							 rollback;
							 messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar los movimientos del ajuste" +sqlca.sqlerrtext)					 
							 return
							 end if						
				else
				rollback;
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar el detalle del ajuste" +sqlca.sqlerrtext)				
				return
				end if	
		else
		rollback;
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar la cabecera del ajuste" +sqlca.sqlerrtext)	
		return
		end if

//dw_detail.enabled= FALSE
//dw_master.enabled= FALSE
setpointer(arrow!)
end event

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()
dw_master.enabled = TRUE
dw_detail.enabled = TRUE
dw_master.SetFocus()
//call super::ue_insert
//dw_detail.enabled = TRUE
//dw_detail.uf_insertCurrentRow()
//dw_master.uf_insertCurrentRow()
//dw_detail.SetRowFocusIndicator(Hand!)
//dw_master.setFocus()

//dw_detail.setfocus()
//dw_master.enabled = TRUE
//dw_master.SetFocus()
//call super::ue_insert
//dw_detail.enabled = TRUE
//str_prodparam.fila = dw_detail.GetRow()
end event

event closequery;string ls_item,ls_signo_mov,ls_pepa,ls
int li_res,ll_i,ll_filact,li_i,i
long ll_maxrows,ll_fila
decimal ld_cantidad

if dw_detail.acceptText() = -1 or dw_master.acceptText() = -1 then
	message.returnValue = 1
	return
end if
ll_filact = dw_master.GetRow()
ll_fila = dw_detail.RowCount()
If ll_fila = 0 then return
for li_i = 1 to ll_fila
    ls = dw_detail.GetItemString(li_i - i,'codant')
	 if isnull(ls) or ls = '' then
       dw_detail.DeleteRow(li_i - i )
		 i=i+1	  
	 end if
 next

ls_signo_mov = dw_master.GetItemString(ll_filact,"tm_ioe")

if dw_master.modifiedCount() > 0 or dw_master.deletedCount() > 0 or &
	dw_detail.modifiedCount() > 0 or dw_detail.deletedCount() > 0 then
	li_res = messageBox(this.title, &
						"Hay cambios que no se han guardado~n" + &
						"$$HEX1$$bf00$$ENDHEX$$Desea descartarlos?", Question!, YesNo!)
	choose case li_res
		case 1
			if ls_signo_mov = 'E' then
				ll_maxrows = dw_detail.RowCount()
				for ll_i = 1 to ll_maxrows
					if dw_detail.GetItemStatus(ll_i, 0, Primary!) = NewModified! then 
						ls_item = dw_detail.GetItemString(ll_i,"codant")
						ld_cantidad = dw_detail.GetItemNumber(ll_i,"da_cantidad")
						select it_codigo
						into :ls_pepa
						from in_item
						where em_codigo = :str_appgeninfo.empresa
						and it_codant = :ls_item;	
   		           		f_carga_stock_disponible_sucursal(ls_pepa,ld_cantidad )
					end if
				next	
			end if	
      	message.returnValue = 0
			return
		case 2
			message.returnValue = 1
			return
	end choose
end if

end event

event ue_nextrow;call super::ue_nextrow;//dw_master.enabled = TRUE
//dw_master.SetFocus()
//call super::ue_nextrow
//// dw_master.enabled = FALSE
end event

event ue_retrieve;dw_detail.enabled= FALSE
dw_master.enabled= FALSE
return 1
end event

event resize;//int li_width, li_height
//
//li_width = this.workSpaceWidth()
//li_height = this.workSpaceHeight()
//
//this.setRedraw(False)
//if this.ib_inReportMode then
//	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
//else
//	dw_1.resize(li_width - 2*dw_master.x, dw_1.height)
//	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
//	dw_detail.resize(li_width -2*dw_master.x,li_height - dw_master.y - dw_1.y - 450)
//end if	
//this.setRedraw(True)

return 1
end event

event close;return 1
end event

event ue_print;dwItemStatus   lst_estado
integer li_rc
long ll_curRowMaster
w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then
	openwithparm(w_dw_print_options,dw_report)
	li_rc = message.DoubleParm
	if li_rc = 1 then	
	  if dw_report.print() = 1 then
		if this.wf_postPrint() = 1 then
			//this.setRedraw(False)
			dw_report.enabled = False
			dw_report.visible = False
			dw_master.enabled = True
			dw_master.visible = True
			dw_detail.enabled = True
			dw_detail.visible = True
			this.ib_inReportMode = False
			this.triggerEvent(resize!)		// so the master and detail get the correct size
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_outof_report_mode()
			this.triggerEvent('ue_outedition')
		end if
	end if
   end if
else
	ll_curRowMaster = dw_master.getRow()
	if ll_curRowMaster < 1 then
		beep(1)
		return
	end if
	lst_estado = dw_master.GetItemStatus(dw_master.GetRow(),0,Primary!)
	if lst_estado = NewModified! then 
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Primero debe digitar F5 antes de imprimir")
		return
	end if
	if dw_master.uf_updateCommit(ll_curRowMaster, False) = 1 then
		if this.wf_prePrint() = 1 then
		
			dw_report.modify("datawindow.print.preview.zoom=75~t" + &
								  "datawindow.print.preview=yes")
			dw_master.enabled = False
//			dw_master.visible = False
			dw_detail.enabled = False
//			dw_detail.visible = False
			dw_report.enabled = True
			dw_report.visible = True
			this.ib_inReportMode = True
			this.triggerEvent(resize!)		// so the report gets the correct size
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_into_report_mode()
		end if
	end if
end if
end event

type dw_master from w_sheet_master_detail`dw_master within w_pd_ingreso_produccion
integer x = 37
integer y = 692
integer width = 2651
integer height = 400
integer taborder = 10
string dataobject = "d_pd_ingreso_produccion"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;call super::itemchanged;/////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n: Si cambia uno de los campos de la cabecera
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 17-fab-1999  12:30
////////////////////////////////////////////////////////////////////

string   ls_tm_ioe, ls_tm_codigo, ls_old_tm_codigo
long ll_filact
dwItemStatus l_status

ll_filact = dw_master.getRow()
l_status = this.GetItemStatus(ll_filact, 0, Primary!)

if l_status = New! or l_status = NewModified! then
	// si es nuevo, o se ha modificado insertar datos en la cabecera
	this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
	this.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
	this.SetItem(ll_filact,"bo_codigo",str_appgeninfo.seccion)
	this.SetItem(ll_filact,"ep_codigo",is_empleado)
	this.SetTabOrder('tm_codigo',12)
else
	// no permitir cambiar el tipo de ajuste
	this.SetTabOrder('tm_codigo',0)
end if

// si cambia algunas de las columnas

CHOOSE CASE this.getColumnName()
	CASE 'tm_codigo'  //tipo de ajuste
		ls_old_tm_codigo = this.GetItemString(this.GetRow(),"tm_codigo",Primary!,TRUE)
		ls_tm_codigo = this.GetText()
		select tm_ioe
		into:ls_tm_ioe
		from in_timov
		where em_codigo = :str_appgeninfo.empresa
		and tm_codigo = :ls_tm_codigo;
		if sqlca.sqlcode <> 0 then
			MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Problemas al encontrar el tipo de movimiento.')
			return
		end if
		if ls_old_tm_codigo <> ls_tm_codigo then
			if dw_detail.RowCount() > 0 then
			   this.SetItem(ll_filact,"tm_codigo",ls_old_tm_codigo)
				MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','No se puede cambiar el tipo de movimiento.')
				return 1
			end if
	   end if
	   this.SetItem(ll_filact,"tm_ioe",ls_tm_ioe)
	CASE "aj_observ" //si llega a la observaci$$HEX1$$f300$$ENDHEX$$n inserta una fila en el 
		// detalle y cambia el foco al codigo del item del detalle
		dw_detail.SetFocus()
		dw_detail.InsertRow(0)
		dw_detail.SetColumn('codant')
		dw_detail.PostEvent(Clicked!)
END CHOOSE

end event

event dw_master::itemerror;call super::itemerror;return 1
end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event dw_master::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"aj_fecha",f_hoy())
end event

event dw_master::losefocus;return 1
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_pd_ingreso_produccion
integer x = 37
integer y = 1180
integer width = 2651
integer height = 1192
integer taborder = 0
string dataobject = "d_detalle_ajuste"
boolean hscrollbar = false
borderstyle borderstyle = stylebox!
end type

event dw_detail::itemchanged;string ls_null,ls_sucursal,ls_bodega,ls_codant,ls_nombre,ls_pepa,ls_codmov
character lch_kit,lch_signo_mov,lch_valstk
integer li_filact,li_max,li_find
dec{2} lc_prefab,lc_costo,ld_null,lc_pedido,lc_stock


dw_master.AcceptText()
li_filact = dw_master.GetRow()
ls_sucursal = dw_master.GetItemString(li_filact,"su_codigo")
ls_bodega = dw_master.GetItemString(li_filact,"bo_codigo")
lch_signo_mov = dw_master.GetItemString(li_filact,"tm_ioe") 
ls_codmov = dw_master.GetItemString(li_filact,"tm_codigo") 

str_prodparam.fila = row
li_max = this.RowCount()
//if row < 1 then return


if dwo.name = 'codant' Then
	ls_codant = this.gettext()
	li_find =  dw_detail.find("codant = '"+ls_codant+"'",1, li_max - 1)
	if li_find <> 0 and li_max <> 1 then
		deleterow(row)
		is_mensaje = "Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el codigo: "+ls_codant+" ...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(li_find)
		return 1
	end if
	
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo,it_nombre,it_prefab,it_valstk,it_kit,it_costo
	into :ls_pepa,:ls_nombre,:lc_prefab,:lch_valstk,:lch_kit,:lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
		select it_codigo,it_codant,it_nombre,it_prefab,it_valstk,it_kit,it_costo
		into :ls_pepa,:ls_codant,:ls_nombre,:lc_prefab,:lch_valstk,:lch_kit,:lc_costo
		from in_item
		where em_codigo = :str_appgeninfo.empresa
		and it_codbar = :ls_codant;
		if sqlca.sqlcode <> 0 then
			setnull(ls_null)
			this.SetItem(row,"codant",ls_null)
			beep(1)
			is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
			return 1
			this.SetItem(row,"it_codigo",ls_null)
			this.SetItem(row,'it_nombre',ls_null)
			setnull (ld_null)
			this.SetItem(row,'da_cantidad',ld_null)
			return(1)
		else
			this.SetItem(row,"it_codigo",ls_pepa)
			this.setitem(row,'it_nombre',ls_nombre)
			this.setitem(row,'it_kit',lch_kit)			
			this.setitem(row,'it_costo',lc_costo)
			if ls_codmov = '3' then
			this.setitem(row,'da_estado','S')				
			end if
			this.SetColumn("da_cantidad")
		end if
    else
 	 // si es un Egreso
	  if lch_signo_mov = 'E' then
		if lch_valstk = 'S' then
			lc_pedido = 1.0
			If f_dame_stock_bodega_new(ls_bodega,ls_pepa,lch_kit,lc_pedido) = false then
				rollback;
				deleterow(row)
				is_mensaje = "No hay stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)
				return 1
			End if
			If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit) = false then
					rollback;
					deleterow(row)
					is_mensaje = "No hay stock en sucursal del producto ["+ls_codant+"] = "+string(lc_stock)
					return 1						
			end if
		end if
	  end if
		this.setitem(row, 'da_cantidad', 1)
		this.setitem(row, 'it_nombre',ls_nombre)
		this.setitem(row, 'it_codigo',ls_pepa)
		this.setitem(row,'it_kit',lch_kit)			
		this.setitem(row,'it_costo',lc_costo)
		if ls_codmov = '3' then
			this.setitem(row,'da_estado','S')				
		end if
	end if 
end if


If dwo.name = 'da_cantidad' Then
	lc_pedido = dec(this.gettext()) 
	if lc_pedido <= 0 then
		this.SetItem(row,'da_cantidad',this.GetItemNumber(row,'da_cantidad'))
		is_mensaje = 'La cantidad debe ser mayor a cero'
		return 1
	end if
	
	//La cantidad a ingresar no puede ser mayor a la cantidad producida.
	if lc_pedido > this.object.da_cantidad2[row] then
		is_mensaje = 'La cantidad no puede ser mayor a la cantidad producida'
		return 1
	end if
	
	
	
	ls_codant = this.getitemstring(row,'codant')
	select it_codigo, it_nombre, it_prefab, it_valstk,it_kit,it_costo
	into :ls_pepa, :ls_nombre, :lc_prefab, :lch_valstk,:lch_kit,:lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;	
	if lch_signo_mov = 'E' then 
	  if lch_valstk = 'S' then
//			If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit) = false then
//				rollback;
//		      is_mensaje = "El stock en sucursal del producto ["+ls_codant+"] = "+string(lc_stock)+"~r~n"+&
//							"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>"
//		      SetItem(row,'da_cantidad',lc_stock)
//				return 1		
//			end if
		   If f_dame_stock_bodega_new(ls_bodega,ls_pepa,lch_kit,lc_pedido) = false then
				rollback;
				is_mensaje = "El stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)+"~r~n"+&
								"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>"
				SetItem(row,'da_cantidad',lc_pedido)							
				return 1
		   End if
	   End if
	End if
End if
end event

event dw_detail::itemerror;call super::itemerror;messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n",is_mensaje,stopsign!)
return 1

end event

event dw_detail::losefocus;call super::losefocus;///////////////////////////////////////////////////////////////////////
// Descripcion : Al salir de la cantidad en el detalle se inserta una
//               nueva fila
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 17-Feb-1999
///////////////////////////////////////////////////////////////////////

long     ll_filact
decimal  lc_cantidad

this.AcceptText()
ll_filact = this.GetRow()
CHOOSE CASE this.getcolumnName()
	CASE "da_cantidad"
		  	window lw_aux
		  	lw_aux = parent.GetActiveSheet()
		  	dw_detail.SetFocus()
		  	if isValid(lw_aux) then
			  	this.InsertRow(ll_filact+1)
				this.ScrolltoRow(ll_filact +1)				  				  
			  	this.SetRow(ll_filact+1)
				str_prodparam.fila = ll_filact + 1
		     	this.SetColumn('codant')
		  	end if
END CHOOSE
end event

event dw_detail::ue_postinsert;call super::ue_postinsert;str_prodparam.fila = dw_detail.GetRow()
end event

event dw_detail::clicked;String ls_pepa
Long ll_reg

if row = 0 or isnull(row) then return
if dwo.name = 'b_1' then
ls_pepa = dw_detail.object.it_codigo[row]
ll_reg = dw_rta.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pepa,'C')
if ll_reg = 0 then dw_rta.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pepa,'F')
end if

str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 
str_prodparam.campo = "da_cantidad"
cantidad_producto_ubica = TRUE


	

end event

type dw_report from w_sheet_master_detail`dw_report within w_pd_ingreso_produccion
integer x = 46
integer y = 84
integer width = 3109
integer height = 2332
integer taborder = 0
boolean enabled = true
boolean titlebar = true
string title = "Vista preliminar"
string dataobject = "d_rep_ajuste_produccion"
boolean controlmenu = true
boolean hscrollbar = false
boolean vscrollbar = false
boolean resizable = true
boolean border = false
string icon = "Report5!"
borderstyle borderstyle = StyleBox!
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_ubica from datawindow within w_pd_ingreso_produccion
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 1577
integer y = 320
integer width = 1445
integer height = 264
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Ticket"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event itemchanged;string ls, ls_criterio,ls_tipo,ls_numero
long ll_find,ll_nreg
//
//CHOOSE CASE this.GetColumnName()
//
//	CASE 'factura'
//		ls_tipo = this.GetItemString(1,'tipo')
//		ls = this.getText()
//		CHOOSE CASE ls_tipo
//			CASE 'B'
//				ls_criterio = "aj_numero = " + "'" + ls + "'"
//				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
//				if ll_found > 0 and not isnull(ll_found) then
//				  dw_master.SetFocus()
//				  dw_master.ScrollToRow(ll_found)
//				  dw_master.SetRow(ll_found)
//				  this.Visible = false
//	  			else
//				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Egreso no se encuentra, verifique datos')
//				  return
//			  end if
//		   CASE 'F'
//				ls_criterio = "aj_numero like" + "'" +  ls +"'"
//				dw_master.SetFilter(ls_criterio)
//				dw_master.Filter()
//				dw_master.SetFocus()
//				this.Visible = false	
//				dw_master.ScrollToRow(dw_master.GetRow())
//				dw_master.SetRow(dw_master.GetRow())				
//				
//		END CHOOSE
//END CHOOSE
//
/* VERSION PARA RECUPERAR UNO POR UNO EL AJUSTE*/

CHOOSE CASE this.GetColumnName()
	CASE 'factura'
		ls_numero = this.getText()
		ll_find = dw_1.find("or_codigo = '"+ls_numero+"'",1,dw_1.rowcount())
		if ll_find <= 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones...<Por favor verifique>")
			return
		else
			dw_1.SetRow(ll_find)
			dw_1.ScrollToRow(ll_find)
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

type dw_movim from datawindow within w_pd_ingreso_produccion
boolean visible = false
integer x = 1527
integer y = 996
integer width = 480
integer height = 72
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_pd_ingreso_produccion
integer x = 50
integer y = 616
integer width = 745
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
string text = "Ingreso "
boolean focusrectangle = false
end type

type st_3 from statictext within w_pd_ingreso_produccion
integer x = 46
integer y = 1120
integer width = 411
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
string text = "Detalle del Ingreso"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_pd_ingreso_produccion
integer x = 37
integer width = 5975
integer height = 576
string title = "Requisiciones"
string dataobject = "d_pd_items_producidos"
boolean vscrollbar = true
end type

event clicked;long ll_new,i,ll_reg
Decimal lc_costo
String ls_pepa



SetRow(row)
ScrolltoRow(row)
Setnull(is_mov)

if dwo.name = 't_2' then
	for i = 1 to this.rowcount()
		this.object.opcion[i] = 'S'
	next
end if

if dwo.name = 't_3' then
	for i = 1 to this.rowcount()
		this.object.opcion[i] = 'N'
	next
end if

if dwo.name = 't_4' then
	dw_master.Object.or_codigo[dw_master.getrow()] = is_numord
	dw_detail.reset()
	
	for i = 1 to dw_1.rowcount()
		
		if this.object.opcion[i] = 'S' then
		ll_new = dw_detail.insertrow(0)
		dw_detail.object.it_codigo[ll_new]       = dw_1.object.it_codigo[i]
		dw_detail.object.codant[ll_new]          = dw_1.object.it_codant[i]
		dw_detail.object.it_nombre[ll_new]      = dw_1.object.it_nombre[i]
		dw_detail.object.da_cantidad[ll_new]   = dw_1.object.or_cantprd[i]    //Cantidad producida que va a ser ingresada al inventario.
		dw_detail.object.da_cantidad2[ll_new]   = dw_1.object.or_cantid[i]     //cantidad teorica por  orden de produci$$HEX1$$f300$$ENDHEX$$n. 
		dw_detail.object.or_codigo[ll_new]      = dw_1.object.or_codigo[i]
		dw_detail.object.da_costo[ll_new]       = dw_1.object.it_costo[i]
		dw_detail.object.it_costo[ll_new]         = dw_1.object.it_costo[i]  
		end if
	next
end if

//b_1 guardar cambios

// b_2 Subir el inventario
if dwo.name = 'b_2' then
	     is_mov = 'S'  //Indica que el tipo de movimiento es una reversion, con el objetivo de dar prioridad a la secuencia de grabaci$$HEX1$$f300$$ENDHEX$$n.
	     is_numord = this.object.or_codigo[row]
		uo_egprd.is_numord = is_numord 
		dw_master.reset()
		//datos del ajuste
		ll_new = dw_master.insertrow(0)
		dw_master.object.em_codigo[ll_new] = str_appgeninfo.empresa
		dw_master.object.su_codigo[ll_new]  = str_appgeninfo.sucursal
		dw_master.object.bo_codigo[ll_new]  = str_appgeninfo.seccion
		dw_master.object.aj_fecha[ll_new]    = f_hoy()
		dw_master.Object.or_codigo[ll_new]  = is_numord
	     dw_detail.reset()
	
        
		ll_new = dw_detail.insertrow(0)
		
		dw_detail.object.it_codigo[ll_new]          = dw_1.object.it_codigo[row]
		dw_detail.object.codant[ll_new]             = dw_1.object.it_codant[row]
		dw_detail.object.it_nombre[ll_new]        = dw_1.object.it_nombre[row]
		dw_detail.object.da_cantidad[ll_new]     = dw_1.object.or_cantprd[row]    //Cantidad producida que va a ser ingresada al inventario.
		dw_detail.object.da_cantidad2[ll_new]   = dw_1.object.or_cantid[row]     //cantidad teorica por  orden de produci$$HEX1$$f300$$ENDHEX$$n. 
		dw_detail.object.or_codigo[ll_new]        = dw_1.object.or_codigo[row]
		dw_detail.object.da_costo[ll_new]         = dw_1.object.it_costo[row]
		dw_detail.object.it_costo[ll_new]           = dw_1.object.it_costo[row]  
		dw_detail.object.it_kit[ll_new]               = dw_1.object.it_kit[row]
         cb_1.triggerevent(clicked!)                                                                     //default para generar el ingreso
end if

// Formulaci$$HEX1$$f300$$ENDHEX$$n
if dwo.name = 'b_3' then
	ls_pepa       = this.object.it_codigo[row]
	dw_rta.visible = true
	ll_reg    = dw_rta.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pepa,'C', this.object.or_cantprd[row])
	if ll_reg = 0 then dw_rta.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pepa,'F', this.object.or_cantprd[row])
end if	


//Reversi$$HEX1$$f300$$ENDHEX$$n  del movimiento de ingreso por producci$$HEX1$$f300$$ENDHEX$$n.
if dwo.name = 'b_4' then
	     is_mov = 'R' //Indica que el tipo de movimiento es una reversion, con el objetivo de dar prioridad a la secuencia de grabaci$$HEX1$$f300$$ENDHEX$$n.
	     is_numord = this.object.or_codigo[row]
		 uo_egprd.is_numord = is_numord   
		uo_egprd.dw_master.reset()
		ll_new = uo_egprd.dw_master.insertrow(0)
		uo_egprd.dw_master.object.em_codigo[ll_new] = str_appgeninfo.empresa
		uo_egprd.dw_master.object.su_codigo[ll_new]  = str_appgeninfo.sucursal
		uo_egprd.dw_master.object.bo_codigo[ll_new]  = str_appgeninfo.seccion
		uo_egprd.dw_master.object.aj_fecha[ll_new]    = f_hoy()
		uo_egprd.dw_master.Object.or_codigo[ll_new]  = is_numord
         uo_egprd.dw_detail.reset()
	
		ll_new = uo_egprd.dw_detail.insertrow(0)
		uo_egprd.dw_detail.object.it_codigo[ll_new]          = dw_1.object.it_codigo[row]
		uo_egprd.dw_detail.object.codant[ll_new]             = dw_1.object.it_codant[row]
		uo_egprd.dw_detail.object.it_nombre[ll_new]        = dw_1.object.it_nombre[row]
		uo_egprd.dw_detail.object.da_cantidad[ll_new]     = dw_1.object.or_cantprd[row]    //Cantidad producida que va a ser ingresada al inventario.
		uo_egprd.dw_detail.object.da_cantidad2[ll_new]   = dw_1.object.or_cantid[row]     //cantidad teorica por  orden de produci$$HEX1$$f300$$ENDHEX$$n. 
		uo_egprd.dw_detail.object.or_codigo[ll_new]        = dw_1.object.or_codigo[row]
		uo_egprd.dw_detail.object.da_costo[ll_new]         = dw_1.object.it_costo[row]
		uo_egprd.dw_detail.object.it_costo[ll_new]           = dw_1.object.it_costo[row]  
         uo_egprd.dw_detail.object.it_kit[ll_new]                = dw_1.object.it_kit[row]
         //ejecutar el ingreso de materia prima
         cb_rev.triggerevent(clicked!)
end if
end event

type cb_1 from commandbutton within w_pd_ingreso_produccion
boolean visible = false
integer x = 3410
integer y = 492
integer width = 827
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Se dispara por cada fila del ingreso"
end type

event clicked;string ls_coditem,ls_pepa
integer i,li_reg,j,ll_count,ll_new,k
decimal lc_cantid,lc_cantidad_producida,lc_costo


uo_egprd.dw_master.reset()
uo_egprd.dw_detail.reset()

for i = 1 to dw_detail.rowcount()
	
		ls_coditem = dw_detail.Object.it_codigo[i]  // producto terminado
		lc_cantidad_producida = dw_detail.object.da_cantidad[i] //cantidad producida
	
		//Determinamos si existe formulaci$$HEX1$$f300$$ENDHEX$$n para el item que esta siendo ingresado
		li_reg = dw_rta.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_coditem,'C',lc_cantidad_producida)
		if li_reg = 0 then 
			 li_reg = dw_rta.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_coditem,'F',lc_cantidad_producida)
		end if
    
	 //Si no tiene formulaci$$HEX1$$f300$$ENDHEX$$n continuar al siguiente item
	 		 
		ll_new = uo_egprd.dw_master.insertrow(0)
		uo_egprd.dw_master.object.or_codigo[ll_new]  = dw_detail.object.or_codigo[i]
		uo_egprd.dw_master.object.em_codigo[ll_new]= str_appgeninfo.empresa
		uo_egprd.dw_master.object.su_codigo[ll_new] = str_appgeninfo.sucursal 
		uo_egprd.dw_master.object.bo_codigo[ll_new] = str_appgeninfo.seccion
		uo_egprd.dw_master.object.aj_fecha[ll_new]   = f_hoy()
		
		
		for j = 1 to li_reg
	   	 
			ls_pepa = dw_rta.object.it_codigo1[j] // codigo del componente (materia prima)
			lc_cantid = dw_rta.object.rq_cantid[j]
	
			 //determinar si para el c$$HEX1$$f300$$ENDHEX$$digo existe formulaci$$HEX1$$f300$$ENDHEX$$n
			 
			SELECT IT_COSTO
			into  :lc_costo
			FROM IN_ITEM
			WHERE IT_CODIGO = :ls_pepa;
			
			ll_new = uo_egprd.dw_detail.insertrow(0)		
			uo_egprd.dw_detail.Object.it_codigo[ll_new]                = dw_rta.object.it_codigo1[j]
			uo_egprd.dw_detail.Object.codant[ll_new]                    = dw_rta.object.it_codant[j]
		    uo_egprd.dw_detail.Object.it_kit[ll_new]                       = dw_rta.object.it_kit[j]
			uo_egprd.dw_detail.Object.it_nombre[ll_new]               = dw_rta.object.it_nombre[j]
			uo_egprd.dw_detail.Object.da_cantidad[ll_new]            = dw_rta.object.rq_cantid[j]*lc_cantidad_producida
			uo_egprd.dw_detail.object.da_costo[ll_new]                 = lc_costo  
	    next
	uo_egprd.dw_detail.SetRow(i)
	uo_egprd.dw_detail.ScrolltoRow(i)
next
end event

type dw_rta from datawindow within w_pd_ingreso_produccion
boolean visible = false
integer x = 1285
integer y = 1632
integer width = 3831
integer height = 804
boolean bringtotop = true
boolean titlebar = true
string title = "Proporcion de materiales por producto terminado"
string dataobject = "d_materiaprima_x_item"
boolean controlmenu = true
boolean minbox = true
boolean livescroll = true
end type

event clicked;String ls_pepa
Decimal lc_cantprod

if dwo.name = 'it_base' or dwo.name ='it_codant' or dwo.name = 'it_nombre' then

	ls_pepa = this.object.it_codigo1[row]
	lc_cantprod = this.object.cc_requerida[row]
	if dw_mp.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_pepa,'F',lc_cantprod) > 0 then
	   dw_mp.visible = true
	else
		dw_mp.visible = false
	end if

end if
end event

type uo_egprd from uo_ajustes within w_pd_ingreso_produccion
integer x = 2706
integer y = 664
integer width = 3323
integer height = 1728
integer taborder = 30
end type

on uo_egprd.destroy
call uo_ajustes::destroy
end on

type dw_mp from datawindow within w_pd_ingreso_produccion
boolean visible = false
integer x = 677
integer y = 1236
integer width = 4640
integer height = 1152
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Materia prima por semielaborado"
string dataobject = "d_materiaprima_x_item_semilaborados"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_rev from commandbutton within w_pd_ingreso_produccion
boolean visible = false
integer x = 4297
integer y = 492
integer width = 850
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reversion"
end type

event clicked;string ls_coditem,ls_pepa
integer i,li_reg,j,ll_count,ll_new
decimal lc_cantid,lc_cantidad_producida,lc_costo


dw_master.reset()
dw_detail.reset()

for i = 1 to uo_egprd.dw_detail.rowcount()
	
	ls_coditem = uo_egprd.dw_detail.Object.it_codigo[i]  // producto terminado
	lc_cantidad_producida = uo_egprd.dw_detail.object.da_cantidad[i] //cantidad producida

    //Determinamos si existe formulaci$$HEX1$$f300$$ENDHEX$$n para el item que esta siendo ingresado
    li_reg = dw_rta.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_coditem,'C',lc_cantidad_producida)
	if li_reg = 0 then 
	   li_reg = dw_rta.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_coditem,'F',lc_cantidad_producida)
	end if

    //Si no tiene formulaci$$HEX1$$f300$$ENDHEX$$n continuar al siguiente item
    if li_reg = 0 then continue

	ll_new = dw_master.insertrow(0)
    dw_master.object.or_codigo[ll_new]  = uo_egprd.dw_detail.object.or_codigo[i]
	dw_master.object.em_codigo[ll_new]= str_appgeninfo.empresa
	dw_master.object.su_codigo[ll_new] = str_appgeninfo.sucursal 
	dw_master.object.bo_codigo[ll_new] = str_appgeninfo.seccion
	dw_master.object.aj_fecha[ll_new]   = f_hoy()
	

	for j = 1 to li_reg
	   	 
		 ls_pepa = dw_rta.object.it_codigo1[j] // codigo del componente (materia prima)
	     lc_cantid = dw_rta.object.rq_cantid[j]

		 //determinar si para el c$$HEX1$$f300$$ENDHEX$$digo existe formulaci$$HEX1$$f300$$ENDHEX$$n
		 
		SELECT NVL(IT_COSTO,0)
		into  :lc_costo
		FROM IN_ITEM
		WHERE IT_CODIGO = :ls_pepa;
		
		ll_new = dw_detail.insertrow(0)		
		dw_detail.Object.it_codigo[ll_new]                = dw_rta.object.it_codigo1[j]
	    dw_detail.Object.codant[ll_new]                    = dw_rta.object.it_codant[j]
		dw_detail.Object.it_kit[ll_new]                      = dw_rta.Object.it_kit[j] 
	    dw_detail.Object.it_nombre[ll_new]               = dw_rta.object.it_nombre[j]
	    dw_detail.Object.da_cantidad[ll_new]            = dw_rta.object.rq_cantid[j]*lc_cantidad_producida
		dw_detail.object.da_costo[ll_new]                 = lc_costo  
		dw_detail.object.it_costo[ll_new]                   = lc_costo
	next
	
	dw_detail.SetRow(i)
	dw_detail.ScrolltoRow(i)
//	parent.triggerevent("ue_update")
	
next
end event

type st_4 from statictext within w_pd_ingreso_produccion
integer x = 2747
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
string text = "Egreso"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_pd_ingreso_produccion
integer x = 2107
integer y = 592
integer width = 571
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar Ingreso"
end type

event clicked;parent.triggerevent("ue_update")
end event

type cb_3 from commandbutton within w_pd_ingreso_produccion
integer x = 5394
integer y = 600
integer width = 613
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar Egreso"
end type

event clicked;Integer li_rc




uo_egprd.triggerevent("ue_update")
end event

type r_1 from rectangle within w_pd_ingreso_produccion
integer linethickness = 4
long fillcolor = 16777215
integer x = 439
integer y = 336
integer width = 329
integer height = 176
end type

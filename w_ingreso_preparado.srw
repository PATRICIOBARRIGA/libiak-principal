HA$PBExportHeader$w_ingreso_preparado.srw
$PBExportComments$Si.
forward
global type w_ingreso_preparado from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_ingreso_preparado
end type
type dw_movim from datawindow within w_ingreso_preparado
end type
end forward

global type w_ingreso_preparado from w_sheet_master_detail
integer width = 3122
integer height = 1752
string title = "Preparados"
long backcolor = 67108864
event ue_consultar pbm_custom15
dw_ubica dw_ubica
dw_movim dw_movim
end type
global w_ingreso_preparado w_ingreso_preparado

type variables
string  is_mensaje,is_codant1,is_codprep
decimal id_stock
dec{4}  ic_costo,ic_costop

end variables

forward prototypes
public function integer wf_preprint ()
public function integer wf_controla_stock_bodega (integer num_filas)
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_numprep, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo)
public function boolean wf_mov_inv_ingreso (string as_item_prep, decimal ac_cantidad, datetime ad_fecha, string as_numprep, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo)
end prototypes

event ue_consultar;call super::ue_consultar;dw_master.postevent(DoubleClicked!)
end event

public function integer wf_preprint ();dataWindowChild ldwc_aux
long ll_filActMaestro
string ls_numero
ll_filActMaestro = dw_master.getRow()
ls_numero = dw_master.getItemString(ll_filActMaestro, "pr_numero")
dw_report.SetTransObject(sqlca)
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
                   ls_numero)
dw_report.modify("datawindow.print.preview.zoom=75~t" + &
					   "datawindow.print.preview=yes")
			
return 1

end function

public function integer wf_controla_stock_bodega (integer num_filas);//Descripcion: Funcion que controla el stock maximo disponible de un producto para que sea facturado
//fecha de creaci$$HEX1$$f300$$ENDHEX$$n : 10/05/2001
//Ultima revision:27/09/2001

integer i,j
string ls_item,ls,ls_codant,ls_kit,ls_valstk,ls_codigo_atomo
decimal lc_stock,lc_candes,lc_candes_aux,lc_stock_disponible
long ll_cantidad

for i =1 to num_filas
ls_item = dw_detail.getitemstring(i,"it_codigo")
ll_cantidad = dw_detail.getitemdecimal(i,"pr_cantidad")	
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
			If lc_stock < ll_cantidad then
				is_codant1 = ls_codant
				return -1
			End if
			//Para encontrar y sumar el stock de los items que se repiten en la factura		
			for j = i to num_filas
				ls = dw_detail.getitemstring(j,"it_codigo")
				lc_candes_aux = dw_detail.getitemdecimal(j,"pr_cantidad")
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

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_numprep, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
// sus componentes 
//Ultima revis$$HEX1$$f300$$ENDHEX$$n : 20/10/2004 por : edivas
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo = 10, tm_ioe ='E' es egreso por ventas

long ll_num_movim,ll_fila
string ls_num_movim,ls_nulo,ls_observa,ls_obs_kit


setnull(ls_nulo)
ls_observa = "Descargo preparaci$$HEX1$$f300$$ENDHEX$$n de colores. Ticket No. "+as_numprep
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Descargo kit "+is_codant1+" prep. de colores. Ticket No."+as_numprep
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'10')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
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
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numprep))		
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
	dw_movim.setitem(ll_fila,"tm_codigo",'10')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
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
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numprep))
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
	dw_movim.setitem(ll_fila,"tm_codigo",'10')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
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
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numprep))		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if

return(TRUE)



end function

public function boolean wf_mov_inv_ingreso (string as_item_prep, decimal ac_cantidad, datetime ad_fecha, string as_numprep, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo);string ls_observa,ls_obs_kit,ls_nulo,as_item,ls_num_movim
long ll_num_movim
int ll_fila


//ingreso por preparacion de colores
ls_observa = "Ingreso preparaci$$HEX1$$f300$$ENDHEX$$n de colores. Ticket No. "+as_numprep
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Ingreso kit "+is_codprep+" prep. de colores. Ticket No."+as_numprep
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'11')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_atomo)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ac_cantidad * ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo_atomo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_obs_kit)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numprep))		
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
	dw_movim.setitem(ll_fila,"tm_codigo",'11')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_item_prep)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ac_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ic_costop)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numprep))
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
	dw_movim.setitem(ll_fila,"tm_codigo",'11')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_item_prep)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ac_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ic_costop)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numprep))		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return true
end function

on w_ingreso_preparado.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.dw_movim=create dw_movim
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.dw_movim
end on

on w_ingreso_preparado.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.dw_movim)
end on

event open;istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = str_appgeninfo.seccion
dw_master.SetTransObject(sqlca)
dw_movim.settransobject(sqlca)
call super::open
dw_master.is_SerialCodeColumn = "pr_numero"
dw_master.is_SerialCodeType = "NUM_PREP"  //tipo STRING
dw_master.is_serialCodeCompany = str_appgeninfo.empresa

dw_master.ii_nrCols = 4
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "bo_codigo"
dw_master.is_connectionCols[4] = "pr_numero"
dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "bo_codigo"
dw_detail.is_connectionCols[4] = "pr_numero"
dw_detail.uf_setArgTypes()
dw_master.uf_insertCurrentRow()
dw_master.SetFocus()

end event

event ue_update;//Ultima Revisi$$HEX1$$f300$$ENDHEX$$n: 21/06/2007
//por Edivas


integer      li_i,li_filact,li_fila,rtncode,li_pasa,li_j
long         ll_maxrows
decimal      ld_cantidad,lc_cantatomop,lc_cantatomo
dec{4}       lc_costo_atomo,lc_costo_atomop
string       ls_codigo,ls_p,ls_preparado,ls_atomo,ls_atomop
datetime     ld_fecha
character    lch_kit,lch_kit_p
dwitemstatus l_status 

setpointer(hourglass!)
li_filact = dw_master.GetRow()
if li_filact = 0 then return
li_fila = dw_detail.RowCount()
//Borra la linea en blanco
for li_i = 1 to li_fila
	 ls_codigo = dw_detail.GetItemString(li_i - li_j,'codant')
	 ls_p = dw_detail.GetItemString(li_i - li_j,'codant_prep')
	 if (isnull(ls_codigo) or trim(ls_codigo) = '') and (isnull(ls_p) or trim(ls_p) = '')  then
		 dw_detail.DeleteRow(li_i - li_j)
		 li_j++
	else
		 if (not isnull(ls_codigo) or trim(ls_codigo) <> '') and (not isnull(ls_p) or trim(ls_p) <> '')  then
		 else
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe completar el ingreso del producto para su conversi$$HEX1$$f300$$ENDHEX$$n...<verifique>")
			return
		 end if		
	end if
next

li_fila = dw_detail.RowCount()
If li_fila <= 0  Then
messagebox("Error","Debe ingresar el detalle para actualizar el ajuste de preparados")
return
End if


//No permitir grabar si el registro ya existe 
l_status = dw_master.getitemstatus(li_filact,0,Primary!)
if l_status = notmodified! or l_status = datamodified!&
then
messagebox("Error","Este registro ya fue grabado")
return
end if

li_pasa = wf_controla_stock_bodega(li_fila)
If li_pasa = -1 Then
	   rollback;
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar el preparado~r~n"+&
							"Debido a que el stock disponible del producto ["+is_codant1+"]~r~n"+&
							"es menor que el pedido...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>")
		return
End if

		
//Para sacar el secuencial del preparado
ll_maxrows = f_dame_sig_numero('NUM_PREP')
ls_preparado = string(ll_maxrows)
dw_master.SetItem(li_filact,'em_codigo',str_appgeninfo.empresa)
dw_master.SetItem(li_filact,'su_codigo',str_appgeninfo.sucursal)
dw_master.SetItem(li_filact,'bo_codigo',str_appgeninfo.seccion)
dw_master.SetItem(li_filact,'pr_numero',ls_preparado)
ld_fecha = dw_master.GetItemDatetime(li_filact,"pr_fecha")

//Llena datos del detalle para in_preparado , actualiza el stock para control del inventario y 
//carga los tipos del movimiento de cada item en in_movim para el control del Kardex
dw_movim.reset()
li_fila = dw_detail.RowCount()
For li_i = 1 to li_fila
	dw_detail.SetItem(li_i,'em_codigo',str_appgeninfo.empresa)
	dw_detail.SetItem(li_i,'su_codigo',str_appgeninfo.sucursal)
	dw_detail.SetItem(li_i,'bo_codigo',str_appgeninfo.seccion)
	dw_detail.SetItem(li_i,'pr_numero',ls_preparado)
	dw_detail.SetItem(li_i,'pr_secuencia',li_i)	 
   //Ubica el producto en su correspondiente movimiento de inventario(Kardex)	
	ls_codigo = dw_detail.GetItemString(li_i,'it_codigo')
	ls_p = dw_detail.GetItemString(li_i,'it_codprep')
	ld_cantidad = dw_detail.GetItemNumber (li_i,"pr_cantidad")
	lch_kit = dw_detail.getitemstring(li_i,'it_kit')	
	is_codant1 = dw_detail.getitemstring(li_i,'codant')		
	ic_costo = dw_detail.getitemdecimal(li_i,'it_costo')		
	lch_kit_p = dw_detail.getitemstring(li_i,'it_kit_p')	
	is_codprep = dw_detail.getitemstring(li_i,'codant_prep')		
	ic_costop = dw_detail.getitemdecimal(li_i,'it_costo_p')			
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

	if f_descarga_stock_rt_sucursal(ls_codigo,ld_cantidad,lch_kit,ls_atomo,lc_cantatomo) = False Then
		rollback;
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+is_codant1)
		return
	end if
	if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,ld_cantidad,lch_kit,ls_atomo,lc_cantatomo) = false Then
		rollback;
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+is_codant1)
		return
	End if			

	if wf_mov_inventario(ls_codigo,ld_cantidad,ld_fecha,ls_preparado,+&
	                     lch_kit,ls_atomo,lc_cantatomo,lc_costo_atomo)= false then
		rollback;
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar el inventario")
		return
	end if	
	

	If lch_kit_p = 'S' Then
		SELECT "IN_ITEM"."IT_COSTO", "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
		INTO :lc_costo_atomop,:ls_atomop, :lc_cantatomop
		FROM "IN_ITEM"  , "IN_RELITEM"
		WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
		("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
		("IN_RELITEM"."TR_CODIGO" = '1' ) and
		( "IN_RELITEM"."IT_CODIGO1" = :ls_p ) and
		( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
	End if
	//cargo el stock del preparado
	if f_carga_stock_tdr_sucursal_new(ls_p,ld_cantidad,lch_kit_p,ls_atomop,lc_cantatomop) = false Then
		return
	End if			
	if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_p,ld_cantidad,lch_kit_p,ls_atomop,lc_cantatomop) = false Then
		return
	End if				

	if wf_mov_inv_ingreso(ls_p,ld_cantidad,ld_fecha,ls_preparado,+&
	                     lch_kit_p,ls_atomop,lc_cantatomop,lc_costo_atomop)= false then
		rollback;								
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar el inventario")
		return
	end if	

Next

//Actualiza el dw maestro y el detalle
rtncode = dw_master.Update(TRUE, FALSE)
IF rtncode = 1 THEN
	rtncode = dw_detail.Update(TRUE, FALSE)
	IF rtncode = 1 THEN
	  rtncode = dw_movim.Update(TRUE, FALSE)
		IF rtncode = 1 THEN
			dw_master.ResetUpdate() // Both updates are OK
			dw_detail.ResetUpdate()// Clear update flags
			dw_movim.ResetUpdate()
			commit;
		ELSE
			ROLLBACK;
			RETURN
		END IF		
	ELSE
		ROLLBACK;
		RETURN
	END IF
ELSE
	ROLLBACK;
	RETURN
END IF
dw_master.setfocus()
dw_detail.enabled = FALSE
setpointer(arrow!)

end event

event ue_delete;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if
ludw_basic = lgo_curObject
if ludw_basic.GetItemStatus(ludw_basic.GetRow(), 0, Primary!) = NewModified! or &
   ludw_basic.GetItemStatus(ludw_basic.GetRow(), 0, Primary!) = New! then
    ludw_basic.uf_deleteCurrentRow()
else 
	beep(1)
end if

end event

event closequery;return 0
end event

event ue_retrieve;dw_detail.enabled = FALSE
dw_master.enabled = FALSE			
return 1
end event

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()
dw_detail.enabled = true
dw_master.enabled = true
end event

event ue_firstrow;return 1
end event

event ue_nextrow;return 1
end event

event ue_lastrow;return 1
end event

event ue_priorrow;return 1
end event

type dw_master from w_sheet_master_detail`dw_master within w_ingreso_preparado
integer x = 5
integer y = 0
integer width = 3067
integer height = 264
integer taborder = 0
string dataobject = "d_cabecera_ingreso_preparados"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_master::itemchanged;call super::itemchanged;If dwo.name = "pr_observa" Then
	dw_detail.SetFocus()
	dw_detail.InsertRow(0)
	dw_detail.SetColumn('codant')
End if
end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event dw_master::updatestart;dwItemStatus    l_status
string ls_res

//Actualizamos el campo de estado del registro actual
ls_res = this.Describe("estado.ColType")
if ls_res <> "!" then
  l_status = this.GetItemStatus(this.GetRow(),0,Primary!)
  if l_status = New! or l_status = NewModified! then
	  this.SetItem(this.GetRow(),"estado",'N')
  elseif l_status = DataModified! then
	  this.SetItem(this.GetRow(),"estado",'A')
  end if
end if
end event

event dw_master::ue_postinsert;call super::ue_postinsert;Long ll_row

ll_row = this.getrow()
if ll_row = 0 then return
this.setitem(ll_row,"pr_fecha",f_hoy())
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_ingreso_preparado
event ue_keydown pbm_dwnkey
event ue_tabout pbm_dwntabout
integer x = 5
integer y = 264
integer width = 3067
integer height = 1380
integer taborder = 0
string dataobject = "d_detalle_ingreso_preparados"
end type

event dw_detail::ue_keydown;call super::ue_keydown;if (KeyDown(KeyF2!)) then
	choose case this.GetColumnName()
       CASE 'codant_prep'
			open(w_preparado_ubica)
	end choose
		
end if
end event

event dw_detail::ue_tabout;long ll

this.SetFocus()
ll = dw_detail.InsertRow(0)
this.ScrollTORow(ll)
this.SetRow(ll)
this.SetColumn('codant')

end event

event dw_detail::itemchanged;string ls_col,ls_codant,ls_unidad,ls_pepa, ls_nombre, ls_valstk,ls_null,ls_unidpre
dec{2} lc_pedido,ld_null
dec{4} lc_costo,lc_costop
character lch_kit,lch_kit_p
int li_max,li_find
long ll_pos

li_max = this.RowCount()
if row < 1 then return
setnull (ld_null)
setnull (ls_null)
ls_col = this.getcolumnName()
choose case ls_col
	case 'codant'
	ls_codant = this.gettext()
	//con este voy a buscar
	//primero por codigo anterior
	select it_codigo, it_nombre,ub_codigo,it_kit,nvl(it_costo,0)
	into :ls_pepa, :ls_nombre,:ls_unidad,:lch_kit,:lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	If sqlca.sqlcode <> 0 then
	 //luego por codigo de barras
			select it_codigo, it_codant, it_nombre, ub_codigo,it_kit,nvl(it_costo,0)
			into :ls_pepa, :ls_codant, :ls_nombre, :ls_unidad,:lch_kit,:lc_costo
			from in_item
			where em_codigo = :str_appgeninfo.empresa
			and it_codbar = :ls_codant;
			If sqlca.sqlcode <> 0 then
				this.SetItem(row,"codant",ls_null)
				this.SetItem(row,"it_codigo",ls_null)
				this.SetItem(row,'nombre',ls_null)
				this.SetItem(row,'pr_cantidad',ld_null)
				beep(1)
				is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo del producto"
				return 1
		   else
				this.SetItem(row,"it_codigo",ls_pepa)
				this.setitem(row,'nombre',ls_nombre)
				this.setitem(row,'it_kit',lch_kit)			
				this.setitem(row,'it_costo',lc_costo)
				this.SetColumn("pr_cantidad")		
			end if	 
 else  
	   lc_pedido = 1 // Al menos debe tener  1 en stock la bodega para poder descargar
		If f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_pepa,lch_kit,lc_pedido) = false then
			rollback;
			deleterow(row)
			is_mensaje = "No hay stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)
			return 1
		End if	  

		this.setitem(row,'pr_cantidad',1)
		this.selecttext(1,1)
		this.setitem(row,'nombre',ls_nombre)
		this.setitem(row,'it_codigo',ls_pepa)
		this.setitem(row,'ub_codigo',ls_unidad)	 
		this.setitem(row,'it_kit',lch_kit)			
		this.setitem(row,'it_costo',lc_costo)
	 
  End if 
	case 'codant_prep'
		
	ls_codant = this.gettext()
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo, it_nombre, ub_codigo,it_kit,nvl(it_costo,0)
	into :ls_pepa, :ls_nombre, :ls_unidpre,:lch_kit_p,:lc_costop
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	if sqlca.sqlcode <> 0 then
		this.SetItem(row,"codant_prep",ls_null)
		beep(1)
		is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo del producto"
		return 1
	End if
	if str_appgeninfo.rol = 'ADM_PRE' Then
		ll_pos = pos(ls_nombre,'@')	
		If ll_pos = 0 Then
			this.SetItem(row,"codant_prep",ls_null)
			beep(1)
			is_mensaje = "C$$HEX1$$f300$$ENDHEX$$digo a convertir no es preparado...<verif$$HEX1$$ed00$$ENDHEX$$que>"
			return 1
		End if
	End if
	
	ls_unidad = this.getitemstring(row,"ub_codigo")
	If ls_unidad <> ls_unidpre Then
		this.setfocus()
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n medida","Codigo a convertir no es igual la unidad de medida")
	End if
	this.setitem(row, 'nombre_prep',ls_nombre)
	this.setitem(row, 'it_codprep',ls_pepa)
	this.setitem(row,'it_kit_p',lch_kit_p)			
	this.setitem(row,'it_costo_p',lc_costop)
	
	case 'pr_cantidad'
	ls_codant = this.getitemstring(row,'codant')
	lc_pedido = dec(this.gettext())

	if lc_pedido <= 0 then
		this.SetItem(row,'pr_cantidad',this.GetItemNumber(row,'pr_cantidad'))
		is_mensaje = 'La cantidad debe ser mayor a cero o n$$HEX1$$fa00$$ENDHEX$$meros'
		return 1
	end if

	select it_codigo, it_nombre, it_valstk, it_kit,nvl(it_costo,0)
	into :ls_pepa, :ls_nombre, :ls_valstk, :lch_kit, :lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;	
	if ls_valstk = 'S' then
		If f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_pepa,lch_kit,lc_pedido) = false then
			rollback;
			is_mensaje = "El stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)+"~r~n"+&
							"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>"
			SetItem(row,'pr_cantidad',lc_pedido)							
			return 1
		End if		
	End if								
end choose
end event

event dw_detail::ue_postinsert;str_prodparam.fila = this.GetRow()

end event

event dw_detail::itemerror;messagebox("Error33",is_mensaje,stopsign!)
return 1

		

end event

event dw_detail::updatestart;dwItemStatus    l_status
string ls_res


//Actualizamos el campo de estado del registro actual
ls_res = this.Describe("estado.ColType")
if ls_res <> "!" then
  l_status = this.GetItemStatus(this.GetRow(),0,Primary!)
  if l_status = New! or l_status = NewModified! then
	  this.SetItem(this.GetRow(),"estado",'N')
  elseif l_status = DataModified! then
	  this.SetItem(this.GetRow(),"estado",'A')
  end if
end if
end event

type dw_report from w_sheet_master_detail`dw_report within w_ingreso_preparado
integer x = 0
integer y = 0
integer taborder = 0
string dataobject = "d_rep_ingreso_preparado"
end type

type dw_ubica from datawindow within w_ingreso_preparado
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 777
integer y = 456
integer width = 1445
integer height = 276
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

event itemchanged;string ls_numero, ls_criterio, ls_tipo
long ll_found,ll_nreg
//
//CHOOSE CASE this.GetColumnName()
//
//	CASE 'factura'
//		ls_tipo = this.GetItemString(1,'tipo')
//		ls = this.getText()
//		CHOOSE CASE ls_tipo
//			CASE 'B'
//				ls_criterio = "pr_numero = " + "'" + ls + "'"
//				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
//				if ll_found > 0 and not isnull(ll_found) then
//				  dw_master.SetFocus()
//				  dw_master.ScrollToRow(ll_found)
//				  dw_master.SetRow(ll_found)
//				  this.Visible = false
//	  			else
//				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ticket no se encuentra, verifique datos')
//				  return
//			  end if
//		   CASE 'F'
//				ls_criterio = "pr_numero like" + "'" +  ls +"'"
//				dw_master.SetFilter(ls_criterio)
//				dw_master.Filter()
//				dw_master.SetFocus()
//				this.Visible = false	
//				dw_master.ScrollToRow(dw_master.GetRow())
//				dw_master.SetRow(dw_master.GetRow())				
//				
//		END CHOOSE
//END CHOOSE


CHOOSE CASE this.GetColumnName()
	CASE 'factura'
		ls_numero = this.getText()
		ll_nreg = dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_numero)
		if ll_nreg <= 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones <Por favor verifique>")
			return
		end if
	   if ll_nreg = 1 then
		dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_numero)
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

type dw_movim from datawindow within w_ingreso_preparado
boolean visible = false
integer x = 41
integer y = 48
integer width = 165
integer height = 96
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


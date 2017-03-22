HA$PBExportHeader$w_receptar_transferencia.srw
$PBExportComments$Si.Recepcion de transferencia
forward
global type w_receptar_transferencia from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_receptar_transferencia
end type
type cb_1 from commandbutton within w_receptar_transferencia
end type
type dw_movim from datawindow within w_receptar_transferencia
end type
type dw_1 from datawindow within w_receptar_transferencia
end type
type st_1 from statictext within w_receptar_transferencia
end type
end forward

global type w_receptar_transferencia from w_sheet_master_detail
integer width = 3168
integer height = 1732
string title = "Recepci$$HEX1$$f300$$ENDHEX$$n de Transferencias"
event ue_transferir pbm_custom15
event ue_consultar pbm_custom16
dw_ubica dw_ubica
cb_1 cb_1
dw_movim dw_movim
dw_1 dw_1
st_1 st_1
end type
global w_receptar_transferencia w_receptar_transferencia

type variables
string  is_empleado,is_mensaje
boolean ib_ponmensaje, ib_not_item_found = FALSE, ib_not_stock_found = FALSE,ib_not_more_stock = FALSE
decimal id_stock
boolean ib_mismas_bodegas = FALSE, ib_generar = false
end variables

forward prototypes
public function integer wf_calcula_numero_planos ()
public function boolean wf_descarga_stock (string as_item, decimal ad_cantidad, string as_sucursal, string as_bodega)
public function integer wf_preprint ()
public function integer wf_recupera_transferencia ()
public function integer wf_calcula_numero ()
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_numero, string as_nombodega, character ach_kit, string as_codant, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo, decimal ac_costprom)
end prototypes

event ue_transferir;//long ll_found
//if  not ib_generar then
//	ib_generar = true
//	dw_transferencia.Reset()
//	dw_transferencia.InsertRow(0)
//	dw_transferencia.x = 183
//	dw_transferencia.y = 97
//	dw_transferencia.visible = true
//
//else
//	 SetPointer(HourGlass!)
//	 if wf_recupera_transferencia() = 1 then
//		 ib_generar = false
//		 messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La transferencia se recuper$$HEX2$$f3002000$$ENDHEX$$satisfactoriamente')
//		 dw_transferencia.Reset()
//		 dw_transferencia.visible = false
//	end if
//   SetPointer(Arrow!)
//end if
end event

event ue_consultar;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true

//dw_master.postevent(DoubleClicked!)
end event

public function integer wf_calcula_numero_planos ();//long    ll_filact, ll_numero, ll_ticket, li, ll_max
//string  ls_numero,ls_su_codenv,ls_bo_codenv,ls_su_codigo,ls_bo_codigo
//
//   ll_filact = dw_plano_cab.GetRow()
//
//   //calculo el n$$HEX1$$fa00$$ENDHEX$$mero de documento
//
//	ls_su_codenv = dw_plano_cab.GetItemString(ll_filact,"su_codenv") //str_appgeninfo.sucursal 
//	ls_bo_codenv = dw_plano_cab.GetItemString(ll_filact,"bo_codenv") //str_appgeninfo.seccion 
//	ls_su_codigo = dw_plano_cab.GetItemString(ll_filact,"su_codigo")
//	ls_bo_codigo = dw_plano_cab.GetItemString(ll_filact,"bo_codigo")
//
//	Select bo_recep
//	  into :ll_numero
//	  from in_bode
//    where em_codigo = :str_appgeninfo.empresa
//	   and su_codigo = :ls_su_codenv
//		and bo_codigo = :ls_bo_codenv;
//   if sqlca.sqlcode <> 0 then
//		messageBox('Error','No se encuentra el siguiente n$$HEX1$$fa00$$ENDHEX$$mero de la transferencia. Funci$$HEX1$$f300$$ENDHEX$$n wf_calcula_n$$HEX1$$fa00$$ENDHEX$$mero')
//		return -1
//	end if
//    Update in_bode
//	    set bo_recep = bo_recep + 1
//    where em_codigo = :str_appgeninfo.empresa
//	   and su_codigo = :ls_su_codenv
//		and bo_codigo = :ls_bo_codenv;
//
//   Select nt_numrecep
//	  into :ll_ticket
//	  from pr_numtrans
//	 where em_codigo = :str_appgeninfo.empresa
//	   and su_codenv = :ls_su_codenv
//		and bo_codenv = :ls_bo_codenv
//		and su_codigo = :ls_su_codigo
//		and bo_codigo = :ls_bo_codigo;
//   if sqlca.sqlcode <> 0 then
//		messageBox('Error','No se encuentra el siguiente n$$HEX1$$fa00$$ENDHEX$$mero del ticket. Funci$$HEX1$$f300$$ENDHEX$$n wf_calcula_n$$HEX1$$fa00$$ENDHEX$$mero')
//		rollback;
//		return -1
//	end if
//	Update pr_numtrans
//	   set nt_numrecep = nt_numrecep + 1
//	 where em_codigo = :str_appgeninfo.empresa
//	   and su_codenv = :ls_su_codenv
//		and bo_codenv = :ls_bo_codenv
//		and su_codigo = :ls_su_codigo
//		and bo_codigo = :ls_bo_codigo;	
//	//commit;
//	dw_plano_cab.SetItem(ll_filact, 'tf_numero', string(ll_numero))
//	dw_plano_cab.SetItem(ll_filact, 'tf_ticket', string(ll_ticket))
//
//	ll_max = dw_plano_det.RowCount()
//	for li = 1 to ll_max
//		dw_plano_det.SetItem(li, 'tf_ticket', string(ll_ticket))
//	next
return 1
end function

public function boolean wf_descarga_stock (string as_item, decimal ad_cantidad, string as_sucursal, string as_bodega);string  ls_componente,ls_es_kit
decimal ld_cantidad

declare kit_cursor cursor for
   select it_codigo,ri_cantid
	  from in_relitem
	 where em_codigo = :str_appgeninfo.empresa
	   and it_codigo1 = :as_item
		and tr_codigo = '1';   // TR_CODIGO = '1' --> ES KIT

select it_kit
  into :ls_es_kit
  from in_item

 where em_codigo = :str_appgeninfo.empresa
   and it_codigo = :as_item;
	
if ls_es_kit = 'S' then
	open kit_cursor;
	do
		fetch kit_cursor into :ls_componente,:ld_cantidad;
		if sqlca.sqlcode <> 0 then
			exit;
		end if
		update in_itesucur
		   set it_stock = it_stock - (:ld_cantidad * :ad_cantidad),
	    		 it_stkdis = it_stkdis - (:ld_cantidad * :ad_cantidad),
		 		 it_stkreal = it_stkreal - (:ld_cantidad * :ad_cantidad)
		 where em_codigo = :str_appgeninfo.empresa
		   and su_codigo = :as_sucursal
			and it_codigo = :ls_componente;
		if sqlca.sqlcode <> 0 then
			messageBox("ERROR","No se pudo descargar el stock de sucursal");
			close kit_cursor;
			return(FALSE)
		end if
		update in_itebod
		   set ib_stock = ib_stock - (:ld_cantidad * :ad_cantidad)
		 where em_codigo = :str_appgeninfo.empresa
		   and su_codigo = :as_sucursal
			and bo_codigo = :as_bodega
			and it_codigo = :ls_componente;
		if sqlca.sqlcode <> 0 then
			messageBox("ERROR","No se pudo descargar el stock de bodega");
			close kit_cursor;
			return(FALSE)
		end if
	loop while TRUE;
end if;

update in_itesucur
   set it_stock = it_stock - :ad_cantidad,
	    it_stkdis = it_stkdis - :ad_cantidad,
		 it_stkreal = it_stkreal - :ad_cantidad
 where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :as_sucursal
	and it_codigo = :as_item;
	
	if sqlca.sqlcode <> 0 then
		messageBox("ERROR","No se pudo descargar el stock ");
		return(FALSE)
	else
		return(TRUE)
	end if
	
update in_itebod
   set ib_stock = ib_stock - :ad_cantidad
 where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :as_sucursal
	and bo_codigo = :as_bodega
	and it_codigo = :as_item;	
	
if sqlca.sqlcode <> 0 then
	messageBox("ERROR","No se pudo descargar el stock ");
	return(FALSE)
else
	return(TRUE)
end if
end function

public function integer wf_preprint ();dataWindowChild ldwc_aux
long   ll_filActMaestro,ll_res
string ls_em_codigo,ls_su_codenv,ls_bo_codenv,ls_su_codigo,ls_bo_codigo,ls_ticket

ll_filActMaestro = dw_master.getRow()

ls_em_codigo = dw_master.getItemString(ll_filActMaestro, "em_codigo")
ls_su_codenv = dw_master.getItemString(ll_filActMaestro, "su_codenv")
ls_bo_codenv = dw_master.getItemString(ll_filActMaestro, "bo_codenv")
ls_su_codigo = dw_master.getItemString(ll_filActMaestro, "su_codigo")
ls_bo_codigo = dw_master.getItemstring(ll_filActMaestro, "bo_codigo")
ls_ticket    = dw_master.getItemString(ll_filActMaestro, "tf_ticket")

//ll_res = dw_report.getChild("d_rep_cab_transferencia", ldwc_aux)
dw_report.setTransObject(sqlca)
ll_res = dw_report.retrieve(ls_em_codigo,ls_su_codenv,ls_bo_codenv,ls_su_codigo,ls_bo_codigo,ls_ticket)

//ll_res = dw_report.getChild("d_rep_det_transferencia", ldwc_aux)
//ldwc_aux.setTransObject(sqlca)
//ll_res = ldwc_aux.retrieve(ls_em_codigo,ls_su_codenv,ls_bo_codenv,ls_su_codigo,ls_bo_codigo,ls_ticket)
 
return 1
end function

public function integer wf_recupera_transferencia ();//string ls_sucursal_origen, ls_num, ls_bodega_origen, ls_ticket
//string ls_sucursal_destino, ls_bodega_destino, ls_criterio, ls_nombodega
//string ls_filename_c, ls_filename_d, ls_c, ls_d, ls_item
//long ll_num_row_c, ll_num_row_d, ll_maxrows, ll_i, ll_filact, ll_found
//decimal ld_cantidad
//datetime ld_fecha
//
//if dw_transferencia.AcceptText() < 1 then return -1
//ls_sucursal_origen = dw_transferencia.GetItemString(dw_transferencia.GetRow(),'sucursal_origen')
//ls_num =  dw_transferencia.GetItemString(dw_transferencia.GetRow(),'ticket')
//ls_bodega_origen =  dw_transferencia.GetItemString(dw_transferencia.GetRow(),'bodega_origen')
//if isnull(ls_sucursal_origen) or ls_sucursal_origen = '' or isnull(ls_num) or ls_num = '' &
//   or isnull(ls_bodega_origen) or ls_bodega_origen = '' then
//	messageBox('Revise Informaci$$HEX1$$f300$$ENDHEX$$n','Ingrese todos los datos antes de procesar')
//	return -1
//end if
//dw_plano_cab.Reset()
//dw_plano_det.Reset()
//ls_c = 'CT' + ls_sucursal_origen + ls_bodega_origen  + ls_num + '.txt'
//ls_d = 'DT' + ls_sucursal_origen + ls_bodega_origen  + ls_num + '.txt'
//
//select pr_descri
//  into :ls_filename_c
//  from pr_param
// where em_codigo = :str_appgeninfo.empresa
//   and pr_nombre = 'TRANSFER';
//if sqlca.sqlcode <> 0 then
//	MessageBox("ERROR DE TRANSFERENCIA","No puedo tomar la direccion del archivo destino "+sqlca.sqlerrtext)
//end if
//
//ls_filename_c = ls_filename_c + ls_c
//ll_num_row_c = dw_plano_cab.ImportFile(ls_filename_c)
//	if ll_num_row_c <> 1 then
//		messageBox('Error','El archivo de cabecera no se encuentra o es de formato incorrecto' + string(ll_num_row_c) +ls_filename_c)
//		dw_plano_cab.Reset()
//		return -1
//	end if
//
//select pr_descri
//  into :ls_filename_d
//  from pr_param
// where em_codigo = :str_appgeninfo.empresa
//   and pr_nombre = 'DETTRANS';
//if sqlca.sqlcode <> 0 then
//	MessageBox("ERROR DE TRANSFERENCIA","No puedo tomar la direccion del archivo destino "+sqlca.sqlerrtext)
//end if
//ls_filename_d = ls_filename_d + ls_d
//ll_num_row_d = dw_plano_det.ImportFile(ls_filename_d)
//if ll_num_row_d <= 0 then
//	messageBox('Error','El archivo de detalle no se encuentra o es de formato incorrecto'+ string(ll_num_row_d) +ls_filename_d)
//	dw_plano_det.Reset()
//	return -1
//end if	
////Los archivos aparentemente se importaron bien !
//
//dw_plano_cab.SetTransObject(sqlca)
//dw_plano_det.SetTransObject(sqlca)
//
////Calculo el siguiente n$$HEX1$$fa00$$ENDHEX$$mero de recepcion que me toca
//dw_plano_cab.SetItem(dw_plano_cab.GetRow(), 'tf_numenvio', ls_num)
//if wf_calcula_numero_planos() <> 1 then return -1
//
//if dw_plano_cab.Update(true,false) <> 1 then
//	messageBox('Error. Comuniquese con sistemas','El archivo de cabecera no es correcto o est$$HEX2$$e1002000$$ENDHEX$$da$$HEX1$$f100$$ENDHEX$$ado')
//	rollback;	
//   return -1
//end if
//if dw_plano_det.Update(true,false) <> 1 then
//	messageBox('Error. Comuniquese con sistemas','El archivo de detalle no es correcto o est$$HEX2$$e1002000$$ENDHEX$$da$$HEX1$$f100$$ENDHEX$$ado')
//	rollback;	
//   return -1
//end if
//
////Se recuper$$HEX2$$f3002000$$ENDHEX$$la transferencia adecuadamente, genero los mov. inventario
//	ll_filact = dw_plano_cab.GetRow()
//   ls_ticket = dw_plano_cab.GetItemString(ll_filact,"tf_ticket")	
//	ls_sucursal_origen = dw_plano_cab.GetItemString(ll_filact,"su_codenv")
//	ls_bodega_origen = dw_plano_cab.GetItemString(ll_filact,"bo_codenv")
//	ls_sucursal_destino = dw_plano_cab.GetItemString(ll_filact,"su_codigo")
//	ls_bodega_destino = dw_plano_cab.GetItemString(ll_filact,"bo_codigo")
//	ld_fecha = dw_plano_cab.GetItemDateTime(ll_filact,"tf_fecha")
//	select substr(bo_nombre,1,30)
//	  into :ls_nombodega
//	  from in_bode
//	 where em_codigo = :str_appgeninfo.empresa
//	   and su_codigo = :ls_sucursal_origen
//		and bo_codigo = :ls_bodega_origen;
//	ll_maxrows = dw_plano_det.RowCount()
//	for ll_i = 1 to ll_maxrows
//		ls_item = dw_plano_det.GetItemString(ll_i,"it_codigo")
//		ld_cantidad = dw_plano_det.GetItemNumber(ll_i,"df_cantid")
//		f_carga_stock_tdr_sucursal(ls_item,ld_cantidad)
//		f_carga_stock_bodega(str_appgeninfo.seccion,ls_item,ld_cantidad)
//		wf_mov_inventario(ls_item,ld_cantidad,ld_fecha,ls_ticket,&
//                        ls_sucursal_destino,ls_bodega_destino,ls_nombodega)
//	next
//commit using sqlca;
//dw_master.uf_retrieve()
//ls_criterio = 'tf_ticket = ' +"'"+ ls_ticket +"'"+ ' and su_codigo=  ' +"'"+ ls_sucursal_destino +"'"+ &
//				  ' and bo_codigo = ' +"'"+ ls_bodega_destino +"'"+ ' and su_codenv = ' +"'"+ ls_sucursal_origen +"'"+ &
//				  ' and bo_codenv = ' +"'"+ ls_bodega_origen+"'"
//ll_found = dw_master.Find(ls_criterio, 1, dw_master.RowCount())
//dw_master.ScrollToRow(ll_found)
//
return 1
end function

public function integer wf_calcula_numero ();long    ll_filact, ll_numero, ll_ticket
string  ls_numero,ls_su_codenv,ls_bo_codenv,ls_su_codigo,ls_bo_codigo

   ll_filact = dw_master.GetRow()

   //calculo el n$$HEX1$$fa00$$ENDHEX$$mero de documento

	ls_su_codenv = dw_master.GetItemString(ll_filact,"su_codenv")
	ls_bo_codenv =  dw_master.GetItemString(ll_filact,"bo_codenv")
	ls_su_codigo = str_appgeninfo.sucursal 
	ls_bo_codigo = str_appgeninfo.seccion

	Select bo_recep
	into :ll_numero
	from in_bode
     where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion
	for update of bo_recep;
     if sqlca.sqlcode <> 0 then
	messageBox('Error','No se encuentra el siguiente n$$HEX1$$fa00$$ENDHEX$$mero de la transferencia. Funci$$HEX1$$f300$$ENDHEX$$n wf_calcula_n$$HEX1$$fa00$$ENDHEX$$mero')
	return -1
	end if
     Update in_bode
	set bo_recep = bo_recep + 1
     where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion;
	 if sqlca.sqlcode <> 0 then
		messageBox('Error',' Problemas al actualizar el secuencial de la transferencia. Funci$$HEX1$$f300$$ENDHEX$$n wf_calcula_n$$HEX1$$fa00$$ENDHEX$$mero')
		rollback;
		return -1
	end if


    Select nt_numrecep
	into :ll_ticket
	from pr_numtrans
	where em_codigo = :str_appgeninfo.empresa
	and su_codenv = :ls_su_codenv
	and bo_codenv = :ls_bo_codenv
	and su_codigo = :ls_su_codigo
	and bo_codigo = :ls_bo_codigo
	for update of nt_numrecep;
	//messagebox("",ls_su_codenv +' '+ls_bo_codenv+' ' +ls_su_codigo+' '+ls_bo_codigo )
     if sqlca.sqlcode <> 0 then
		messageBox('Error',' No se encuentra el siguiente n$$HEX1$$fa00$$ENDHEX$$mero del ticket. Funci$$HEX1$$f300$$ENDHEX$$n wf_calcula_n$$HEX1$$fa00$$ENDHEX$$mero')
		rollback;
		return -1
	end if
	Update pr_numtrans
	set nt_numrecep = nt_numrecep + 1
	where em_codigo = :str_appgeninfo.empresa
	and su_codenv = :ls_su_codenv
	 and bo_codenv = :ls_bo_codenv
	 and su_codigo = :ls_su_codigo
	 and bo_codigo = :ls_bo_codigo;
	  if sqlca.sqlcode <> 0 then
		messageBox('Error',' Problemas al actualizar  el siguiente n$$HEX1$$fa00$$ENDHEX$$mero del ticket. Funci$$HEX1$$f300$$ENDHEX$$n wf_calcula_n$$HEX1$$fa00$$ENDHEX$$mero')
		rollback;
		return -1
	end if
	 
	 
     dw_master.SetItem(ll_filact, 'tf_numero', string(ll_numero))
     dw_master.SetItem(ll_filact, 'tf_ticket', string(ll_ticket))

return 1
end function

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_numero, string as_nombodega, character ach_kit, string as_codant, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo, decimal ac_costprom);//Funcion	inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de sus componentes 
//Modifica	07/10/2004    por:PBarriga
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=8, tm_ioe='I' es ingreso por recepci$$HEX1$$f300$$ENDHEX$$n de transferencia
decimal lc_costo
long ll_num_movim,ll_fila
string ls_num_movim,ls_nulo,ls_observa,ls_obs_kit
boolean lb_exito = TRUE


setnull(ls_nulo)

/*Para insertar el ultimo costo que tiene el item*/


ls_observa = "Transf. desde "+as_nombodega+" No. "+as_numero
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Transf. kit "+as_codant+" desde "+as_nombodega+" No. "+as_numero
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
	dw_movim.setitem(ll_fila,"tm_codigo",'8')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
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
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numero))
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
	dw_movim.setitem(ll_fila,"tm_codigo",'8')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
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
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numero))
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
	dw_movim.setitem(ll_fila,"tm_codigo",'8')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
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
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numero))
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return(TRUE)


end function

on w_receptar_transferencia.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.cb_1=create cb_1
this.dw_movim=create dw_movim
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_movim
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.st_1
end on

on w_receptar_transferencia.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.cb_1)
destroy(this.dw_movim)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;f_recupera_empresa(dw_master,"su_codenv")
f_recupera_empresa(dw_master,"bo_codenv")

select ep_codigo
into :is_empleado
from no_emple
where em_codigo = :str_appgeninfo.empresa
and sa_login = :str_appgeninfo.username
and ep_nonom = 'S'
and ep_fecsal is null;


istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = str_appgeninfo.seccion


call super::open

dw_master.ii_nrCols = 6
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codenv"
dw_master.is_connectionCols[3] = "bo_codenv"
dw_master.is_connectionCols[4] = "su_codigo"
dw_master.is_connectionCols[5] = "bo_codigo"
dw_master.is_connectionCols[6] = "tf_ticket"

dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codenv"
dw_detail.is_connectionCols[3] = "bo_codenv"
dw_detail.is_connectionCols[4] = "su_codigo"
dw_detail.is_connectionCols[5] = "bo_codigo"
dw_detail.is_connectionCols[6] = "tf_ticket"
dw_detail.uf_setArgTypes()

dw_master.uf_insertCurrentRow()
dw_master.setFocus()
dw_movim.settransobject(sqlca)
dw_report.SettransObject(sqlca)
dw_1.SettransObject(sqlca)


dw_ubica.InsertRow(0)
//dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
//this.triggerevent("ue_nextrow")
//this.triggerevent("ue_firstrow")

end event

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()


end event

event ue_update;integer rc,li_i,i,li_pasa,li_filact
long ll_fila,ll_cantidad
string ls_ticket,ls,ls_sucursal_origen,ls_bodega_origen,&
		ls_nombodega,ls_codigo,ls_codant,ls_atomo
datetime ld_fecha		
dec{2} lc_stock
dec{4} lc_cantatomo,lc_costo_atomo,lc_costo,lc_costprom
char lch_sino, lch_kit
boolean lb_actualizar

dwitemstatus l_status 


dw_master.AcceptText()
dw_detail.AcceptText()

li_filact = dw_master.GetRow()
lch_sino = dw_master.GetItemString(li_filact,"tf_aceptada")
If lch_sino = 'S' Then
	messagebox("Error","Esta recepci$$HEX1$$f300$$ENDHEX$$n de transferencia ya fue procesada...<verifique>")
	return
End if
If cb_1.visible = true Then
	messagebox("Error","La recepci$$HEX1$$f300$$ENDHEX$$n de transferencia debe ser grabada con el bot$$HEX1$$f300$$ENDHEX$$n Ejecutar")
	return
End if

if li_filact = 0 then return
ll_fila = dw_detail.RowCount()

If ll_fila <= 0  Then
messagebox("Error","No existen items en el detalle de la recepci$$HEX1$$f300$$ENDHEX$$n...<verifique>")
return
End if

/*No permitir grabar si el registro ya existe*/
l_status = dw_master.getitemstatus(li_filact,0,Primary!)
if l_status = notmodified! or l_status = datamodified!&
then
messagebox("Error","Este registro ya fue grabado")
return
end if

ls_codant = dw_detail.getitemstring(ll_fila,"codant")
if isnull(ls_codant) or ls_codant = "" Then
	dw_detail.deleterow(ll_fila)
end if	

ll_fila = dw_detail.RowCount()

if wf_calcula_numero() <> 1 then	return 

dw_master.SetItem(li_filact,"em_codigo",str_appgeninfo.empresa)
dw_master.SetItem(li_filact,"su_codigo",str_appgeninfo.sucursal)
dw_master.SetItem(li_filact,"bo_codigo",str_appgeninfo.seccion)

//Llena datos de la cabecera
ls_ticket = dw_master.GetItemString(li_filact,"tf_ticket")
ld_fecha = dw_master.GetItemDatetime(li_filact,"tf_fecha")
ls_sucursal_origen = dw_master.GetItemString(li_filact,"su_codenv")
ls_bodega_origen = dw_master.GetItemString(li_filact,"bo_codenv")

select substr(bo_nombre,1,30)
into :ls_nombodega
from in_bode
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :ls_sucursal_origen
and bo_codigo = :ls_bodega_origen;

//Llena datos del detalle
dw_movim.reset()

for li_i = 1 to ll_fila
	dw_detail.SetItem(li_i,"em_codigo",str_appgeninfo.empresa)
	dw_detail.SetItem(li_i,"su_codenv",ls_sucursal_origen) 
	dw_detail.SetItem(li_i,"bo_codenv",ls_bodega_origen) 	  
	dw_detail.SetItem(li_i,"su_codigo",str_appgeninfo.sucursal) 	  
	dw_detail.SetItem(li_i,"bo_codigo",str_appgeninfo.seccion) 
	dw_detail.SetItem(li_i,"tf_ticket",ls_ticket) 
	dw_detail.SetItem(li_i,"df_secuen",string(li_i))
	ll_cantidad = dw_detail.getitemnumber(li_i,'df_cantid')	
	ls_codigo = dw_detail.getitemstring(li_i,'it_codigo')
	ls_codant = dw_detail.getitemstring(li_i,'codant')		
	lc_stock = dec(ll_cantidad)	
	lch_kit = dw_detail.getitemstring(li_i,'it_kit')	
	lc_costo = dw_detail.getitemdecimal(li_i,'df_costo')				
	
	If lch_kit = 'S' Then
		SELECT NVL("IN_ITEM"."IT_COSTO",0), "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
		INTO :lc_costo_atomo,:ls_atomo, :lc_cantatomo
		FROM "IN_ITEM"  , "IN_RELITEM"
		WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
		("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
		("IN_RELITEM"."TR_CODIGO" = '1' ) and
		( "IN_RELITEM"."IT_CODIGO1" = :ls_codigo ) and
		( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
	End if	
	If str_appgeninfo.sucursal = ls_sucursal_origen Then	
		if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,lc_cantatomo) = false Then
			return
		End if			
			
	Else
		if f_carga_stock_tdr_sucursal_new(ls_codigo,lc_stock,lch_kit,ls_atomo,lc_cantatomo) = false Then
			return
		End if			
		if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,lc_cantatomo) = false Then
			return
		End if			
	End if
	/*Determina el costo promedio*/
	select NVL(it_costprom,0)
	into   :lc_costprom
	from in_item
	where it_codigo = :ls_codigo;
	
	if sqlca.sqlcode <> 0 then
	lc_costprom = 0	
	end if
							
    //El costo de la transacci$$HEX1$$f300$$ENDHEX$$n en este caso es el costo promedio  
	lc_costprom =  f_costprom(ls_codigo,'I',lc_stock,lc_costprom)
	if wf_mov_inventario(ls_codigo,lc_stock,ld_fecha,ls_ticket,ls_nombodega,lch_kit,ls_codant,ls_atomo,&
							lc_cantatomo,lc_costo_atomo,lc_costo,lc_costprom) = false then
	rollback;	
	dw_movim.reset()	
	messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario")
	return 
	end if	  
next

//5.- Actualizo los datos de la factura
dw_master.SetItem(li_filact,"tf_aceptada",'S')			
rc =  dw_master.update(true,false) 
if rc = 1 then
	 rc = dw_detail.update(true,false)
	 if rc = 1 then
	    rc = dw_movim.update(true,false)
	  	 if rc = 1 then		
			 dw_master.resetupdate()
			 dw_detail.resetupdate()
			 dw_movim.resetupdate()			
			 commit;  
			 cb_1.visible = false
       else
		 Messagebox("Atenc$$HEX2$$ed00f300$$ENDHEX$$n","Problemas al Actualizar los movimientos de inventario"+sqlca.sqlerrtext)	
		 rollback;
		 return
 	  	 end if
	 else
	 Messagebox("Atenc$$HEX2$$ed00f300$$ENDHEX$$n","Problemas al Actualizar el detalle de la transferencia"+sqlca.sqlerrtext)		
	 rollback;
	 return
	 end if
else
Messagebox("Atenc$$HEX2$$ed00f300$$ENDHEX$$n","Problemas al Actualizar la transferencia"+sqlca.sqlerrtext)		
rollback;
return
end if

dw_detail.enabled= FALSE
dw_master.enabled= FALSE


If messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea imprimir la recepci$$HEX1$$f300$$ENDHEX$$n...?",Question!,YesNo!,2) = 1 then
dw_report.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_ticket)
dw_report.print()
end if

setpointer(arrow!)
end event

event ue_retrieve;return 1

end event

event ue_delete;return
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_ubica.resize(li_width -2*dw_ubica.x,dw_ubica.height)
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	dw_detail.resize(dw_master.width,this.height - 900 )
end if	
this.setRedraw(True)

end event

type dw_master from w_sheet_master_detail`dw_master within w_receptar_transferencia
integer x = 41
integer y = 280
integer width = 3063
integer height = 380
string dataobject = "d_cab_recep_transferencia"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;call super::itemchanged;DataWindowChild  ldwc_aux
string   ls_su_codenv, ls_su_codigo, ls_bo_codenv, ls_bo_codigo, ls_columna, ls_null, ls
long     ll_filact

SetNull(ls_null)
ls = is_empleado
ll_filact = dw_master.getRow()
ls_columna = dw_master.GetColumnName()
if isnull(is_empleado) then
	messageBox('Error','Usted no tiene autorizaci$$HEX1$$f300$$ENDHEX$$n para hacer transferencias. Comuniquese con el departamento de Sistemas.')
	return
end if

choose case ls_columna
	case "su_codenv"
		this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
		this.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
		this.SetItem(ll_filact,"bo_codigo",str_appgeninfo.seccion)
		this.SetItem(ll_filact,"ep_codigo",is_empleado)
   	    ls_su_codigo = this.Gettext()
		ls = "su_codigo = " + "'" + ls_su_codigo + "'" + ' and bo_codigo <> ' + "'" + str_appgeninfo.seccion + "'" 
		dw_master.getChild("bo_codenv", ldwc_aux)
		ldwc_aux.SetFilter(ls)
		ldwc_aux.Filter()		

	case "bo_codenv"
		dw_detail.SetFocus()
		dw_detail.InsertRow(0)
		dw_detail.SetColumn('codant')
		dw_detail.PostEvent(Clicked!)

end choose
end event

event dw_master::itemerror;call super::itemerror;if ib_mismas_bodegas then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede hacer transferencia entre la misma bodega",StopSign!)
	ib_mismas_bodegas = FALSE
end if
return 1
end event

event dw_master::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0 then return
this.setitem(ll_row,"tf_fecha",f_hoy())
this.setitem(ll_row,"tf_hora",f_hoy())
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_receptar_transferencia
integer x = 37
integer y = 676
integer width = 3067
integer height = 928
string dataobject = "d_recep_transferencia"
boolean hscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_detail::itemchanged;call super::itemchanged;string     ls_col, ls, ls_nombre, ls_fraccion, ls_iva
string     ls_formato, ls_criterio, ls_null, ls_peso
int        li_fila, li_max
long       ll_filact
string     ls_pepa, ls_codant,ls_valstk, ls_kit, ls_sucursal, ls_bodega
decimal{2} lc_precio, lc_valor, lc_stock, lc_pedido, lc_prefab,lc_costo
decimal{4} lc_cantidad,ld_null
boolean    si_hay
s_stock_bodegas bodegas

ll_filact = dw_master.GetRow()
ls_sucursal = dw_master.GetItemString(ll_filact,"su_codenv")
ls_bodega = dw_master.GetItemString(ll_filact,"bo_codenv")

li_fila = this.GetRow()
li_max = this.RowCount()

if li_fila < 1 then return
ls_col = this.getcolumnName()

choose case ls_col
case 'codant'
	ls = this.gettext()

	// con este voy a buscar
	//primero por codigo anterior
	 select it_codigo, it_nombre, it_prefab, it_valstk, it_kit,nvl(it_costo,0)
		into :ls_pepa, :ls_nombre, :lc_prefab, :ls_valstk, :ls_kit,:lc_costo
		from in_item
	  where em_codigo = :str_appgeninfo.empresa
	    and it_codant = :ls;
   if sqlca.sqlcode <> 0 then
	   //luego por codigo de barras
	   select it_codigo, it_codant, it_nombre, it_prefab, it_valstk, it_kit,nvl(it_costo,0)
		  into :ls_pepa, :ls_codant, :ls_nombre, :lc_prefab, :ls_valstk, :ls_kit,:lc_costo
		  from in_item
	    where em_codigo = :str_appgeninfo.empresa
	      and it_codbar = :ls;
      if sqlca.sqlcode <> 0 then
		   setnull(ls_null)
		   setnull(ld_null)
		   this.SetItem(li_fila,"codant",ls_null)
			this.SetItem(li_fila,"it_codigo",ls_null)
			this.setitem(li_fila,'it_nombre',ls_null)
			this.setitem(li_fila,'df_cantid',ld_null)
		   beep(1)
		   ib_not_item_found = TRUE
		   is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
		   return(1)
	   else
		   this.SetItem(li_fila,"it_codigo",ls_pepa)
			this.setitem(li_fila,'it_nombre',ls_nombre)
			this.setitem(li_fila,'it_kit',ls_kit)
			this.setitem(li_fila,'df_costo',lc_costo)
			this.SetColumn("df_cantid")
	   end if
	else
		this.SetItem(li_fila,"it_codigo",ls_pepa)
		this.setitem(li_fila,'it_nombre',ls_nombre)
		this.setitem(li_fila,'it_kit',ls_kit)
		this.setitem(li_fila,"df_costo",lc_costo)
		this.SetColumn("df_cantid")
   end if 

case 'df_cantid'
	lc_valor = dec(this.gettext()) 
	if lc_valor <= 0 then
		this.SetItem(li_fila,'df_cantid',this.GetItemNumber(li_fila,'df_cantid'))
		is_mensaje = 'La cantidad debe ser mayor a cero'
		return 1
	end if
end choose
end event

event dw_detail::itemerror;call super::itemerror;string ls_mensaje

//messageBox("Error", is_mensaje)

IF ib_not_item_found THEN 
	messagebox("Reintente Operaci$$HEX1$$f300$$ENDHEX$$n","No existe c$$HEX1$$f300$$ENDHEX$$digo de producto",StopSign!)
	ib_not_item_found = FALSE
END IF
if ib_not_stock_found then
	messagebox("Reintente Operaci$$HEX1$$f300$$ENDHEX$$n","No existe stock solicitado de producto",StopSign!)
	ib_not_stock_found = FALSE
end if
if ib_not_more_stock then
	ls_mensaje = 'Cantidad no disponible de este producto.' + &
					 ' Stock en bodega: ' + string (id_stock)
	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n', ls_mensaje,StopSign!)
	ib_not_more_stock = FALSE
end if
return 1
end event

event dw_detail::clicked;call super::clicked;//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.campo = "df_cantid"
str_prodparam.fila = dw_detail.GetRow() 
cantidad_producto_ubica = TRUE
end event

event dw_detail::losefocus;call super::losefocus;long ll_filact

CHOOSE CASE this.getcolumnName()
	CASE "df_cantid"
		if not ib_not_more_stock then 
		  	ll_filact = this.GetRow()
		  	window lw_aux
		  	lw_aux = parent.GetActiveSheet()
		  	dw_detail.SetFocus()
		  	if isValid(lw_aux) then 
			  	this.InsertRow(ll_filact+1)
			  	this.SetRow(ll_filact+1)
				this.ScrolltoRow(ll_filact +1)
				str_prodparam.fila = ll_filact + 1
		     	this.SetColumn('codant')
		  	end if
	   end if
END CHOOSE
end event

event dw_detail::ue_postinsert;call super::ue_postinsert;str_prodparam.fila = dw_detail.GetRow()
end event

type dw_report from w_sheet_master_detail`dw_report within w_receptar_transferencia
integer x = 37
integer y = 272
string dataobject = "d_rep_recep_transferencia"
end type

type dw_ubica from datawindow within w_receptar_transferencia
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
integer x = 37
integer y = 84
integer width = 3063
integer height = 180
integer taborder = 40
string title = "Buscar Ticket"
string dataobject = "d_sel_factura_transfer"
boolean livescroll = true
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

event buttonclicked;string ls_sucorg, ls_numero, ls_ticket, ls_bodorg
long ll_nreg

this.accepttext()
dw_master.reset()
dw_detail.reset()
ls_numero = this.Getitemstring(1,"factura") //numero
ls_ticket = this.Getitemstring(1,"ticket")		
If isnull(ls_numero) or isnull(ls_ticket) Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Factura o Ticket")
	return
End if
ll_nreg = dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_ticket,ls_numero)
if ll_nreg < 1 Then 
	cb_1.visible = false
	return 
End if
ls_sucorg = dw_master.Getitemstring(1,"su_codenv")		
ls_bodorg = dw_master.Getitemstring(1,"bo_codenv")		
dw_detail.retrieve(str_appgeninfo.empresa,ls_sucorg,ls_bodorg,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_ticket)
cb_1.visible = true
end event

type cb_1 from commandbutton within w_receptar_transferencia
boolean visible = false
integer x = 2139
integer y = 448
integer width = 288
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ejecutar"
end type

event clicked;integer li_filact,li_fila,li_sino,i,li_i,li_nreg
long ll_cantidad,rc,ll_cantid,max
datetime ld_fecha
string ls_ticket,ls_numero,ls_sucursal_origen,ls_bodega_origen,&
		ls_nombodega,ls_codigo,ls_atomo,ls_codant,ls_ajnumero,ls_motor,ls
char lch_sino,lch_kit
dec{2} lc_stock,lc_cantatomo,lc_costo_atomo,lc_costo
dec{4} lc_costprom

SetPointer(Hourglass!)

ld_fecha = f_hoy()
li_filact = dw_master.GetRow()
li_fila = dw_detail.RowCount()
If li_fila <= 0  Then
Messagebox("Error","Atenci$$HEX1$$f300$$ENDHEX$$n no existen datos en el detalle de la recepci$$HEX1$$f300$$ENDHEX$$n....<verifique>")	
return
End if


/*Eliminar las filas en blanco*/
max = dw_detail.rowcount()
for li_i = 1 to max
		ls = dw_detail.GetItemString(li_i - i,'codant')
		if isnull(ls) or ls = '' then
			dw_detail.DeleteRow(li_i - i )
			i=i+1	  
		end if
next
dw_movim.reset()

ls_ticket = dw_master.GetItemString(li_filact,"tf_ticket")
ls_numero = dw_master.GetItemString(li_filact,"tf_numero")
lch_sino  = dw_master.GetItemString(li_filact,"tf_aceptada")
ls_sucursal_origen = dw_master.GetItemString(li_filact,"su_codenv")
ls_bodega_origen = dw_master.GetItemString(li_filact,"bo_codenv")

If isnull(lch_sino) or lch_sino = "" then lch_sino = 'N'
If lch_sino <> 'S' Then
	li_sino = messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro que quiere procesar el envio de esta transferencia como recibida~n~r"+&
					"Esto modificar$$HEX2$$e1002000$$ENDHEX$$su inventario",information!,Yesno!,2)
	If li_sino = 1 Then
		w_marco.Setmicrohelp("Receptando transferencia....Por favor espere!")
		select substr(bo_nombre,1,30)
		into :ls_nombodega
		from in_bode
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :ls_sucursal_origen
		and bo_codigo = :ls_bodega_origen;
		
		dw_1.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
		for i = 1 to li_fila
			ll_cantidad = dw_detail.getitemnumber(i,'df_cantid')	
			ls_codigo = dw_detail.getitemstring(i,'it_codigo')	
			lc_stock = dec(ll_cantidad)
			lch_kit = dw_detail.getitemstring(i,'it_kit')	
			ls_codant = dw_detail.getitemstring(i,'codant')				
			lc_costo = dw_detail.getitemdecimal(i,'df_costo')	

			dw_1.setfilter(" in_ajuste_it_codigo ='"+ls_codigo+"'")
			dw_1.filter()
			
			li_nreg = dw_1.rowcount()
			if li_nreg > 0 then
				for li_i = 1 to li_nreg 
					ll_cantid = dw_1.getitemnumber(li_i,"in_ajuste_da_cantidad")
					if ll_cantidad >= ll_cantid then
						dw_1.setitem(li_i,"in_ajuste_da_estado",'N')
						ll_cantidad = ll_cantidad - ll_cantid
					end if
				next
				dw_1.setfilter("")
				dw_1.filter()
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
			
			If str_appgeninfo.sucursal = ls_sucursal_origen Then	
				if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,lc_cantatomo) = false Then
					return
				End if			
			Else
				if f_carga_stock_tdr_sucursal_new(ls_codigo,lc_stock,lch_kit,ls_atomo,lc_cantatomo) = False Then
					return
				end if		 
				if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,lc_cantatomo) = false Then
					return
				End if			
			End if		
			
			 //Determinar el costo promedio 
			select NVL(it_costprom,0)
			into   :lc_costprom
			from in_item
			where it_codigo = :ls_codigo;
			
			if sqlca.sqlcode <> 0 then
			lc_costprom = 0	
			end if
				
			 //El costo de la transacci$$HEX1$$f300$$ENDHEX$$n en este caso es el costo promedio  
			lc_costprom =  f_costprom(ls_codigo,'I',lc_stock,lc_costprom)
				
			 if wf_mov_inventario(ls_codigo,lc_stock,ld_fecha,ls_ticket,&
			                      ls_nombodega,lch_kit,ls_codant,ls_atomo,lc_cantatomo,lc_costo_atomo,lc_costo,lc_costprom) = false then
			 messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario...no encuentra c$$HEX1$$f300$$ENDHEX$$digo")
			 dw_movim.reset()
			 return 
			 end if
			 
			if lch_kit = 'V' then	
			  ls_motor = dw_detail.GetItemString(i,'df_motor')
			  if not isnull(ls_motor) or trim(ls_motor) <> '' then
					update in_itedet
					set su_codigo = :str_appgeninfo.sucursal,
						 estado = 'R'
					where em_codigo = :str_appgeninfo.empresa
					and su_codigo = :ls_sucursal_origen
					and di_ref1 = :ls_motor;
					if sqlca.sqlcode <> 0 then
						rollback;				
						messageBox('Error','Problemas al actualizar la transferencia del veh$$HEX1$$ed00$$ENDHEX$$culo')
						return -1
					end if
			  end if		  
			end if
			 
		Next	
		
		dw_master.SetItem(li_filact,"tf_aceptada",'S')
		dw_master.SetItem(li_filact,"tf_hora",ld_fecha)	 	

		rc = dw_master.update(true,false)
		if rc = 1 then
   	   rc = dw_movim.update(true,false)		
 		   if rc = 1 then
				rc = dw_1.update(true,false)			
				if rc = 1 then
					dw_master.resetupdate()
					dw_movim.resetupdate()
					dw_1.resetupdate()					
					commit;
					cb_1.visible = false
				else
				rollback;					
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el ajuste "+sqlca.sqlerrtext)
				return
				end if
			else
			rollback;				
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el inventario "+sqlca.sqlerrtext)
			return
		   end if
	  else
	   rollback;			
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la recepci$$HEX1$$f300$$ENDHEX$$n "+sqlca.sqlerrtext)
		return
	  end if		
		w_marco.Setmicrohelp("Listo..........Transferencia receptada! ")
		dw_report.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_ticket)
		dw_report.print()
		setpointer(arrow!)
   End if
else
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta recepci$$HEX1$$f300$$ENDHEX$$n de transferencia ya fue procesada")
return	
End if

end event

type dw_movim from datawindow within w_receptar_transferencia
boolean visible = false
integer x = 59
integer y = 292
integer width = 110
integer height = 92
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_receptar_transferencia
boolean visible = false
integer x = 2587
integer y = 316
integer width = 233
integer height = 76
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_ajuste_ingreso"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_receptar_transferencia
integer x = 55
integer y = 24
integer width = 1189
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
string text = "Seleccione la transferencia para realizar la recepci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type


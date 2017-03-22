HA$PBExportHeader$w_marco.srw
forward
global type w_marco from w_frame_basic
end type
end forward

global type w_marco from w_frame_basic
integer width = 3378
integer height = 1892
string title = "Libiak ERP."
string menuname = "m_marco"
long backcolor = 79741120
string icon = "imagenes\Sif.ico"
event ue_refrescar pbm_custom20
end type
global w_marco w_marco

type variables
DataStore dw_prod, dw_clien
boolean ib_primera = true
end variables

event ue_refrescar;//this.SetMicroHelp('Espere un momento, por favor. Actualizando Consultas...')
//SetPointer(HourGlass!)
//if ib_primera then
//		dw_prod = Create DataStore
//		dw_clien = Create DataStore
//		ib_primera = false
//end if
//dw_prod.DataObject = 'dw_productos'
//dw_clien.DataObject = 'dw_clientes'
//dw_prod.Settransobject(sqlca)
//dw_prod.Retrieve(str_appgeninfo.empresa)
//dw_clien.Settransobject(sqlca)
//dw_clien.Retrieve(str_appgeninfo.empresa)
//this.SetMicroHelp('Listo')
//SetPointer(Arrow!)
end event

on w_marco.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_marco" then this.MenuID = create m_marco
end on

on w_marco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event timer;//this.setMicroHelp("Listo                                                                                   "+f_obtienefecha()+"   "+string(now(),"hh:mm:ss"))
//this.setmicrohelp("Listo     "+string(now(),"hh:mm:ss"))
//this.setmicrohelp("Listo     "+"Quito"+string(today(),"dd/mm/yyyy")+string(now(),"hh:mm:ss"))

//String ls_rol
//Long ll_count
//
//
//SELECT RS_NOMBRE
//into :ls_rol
//FROM SG_ACCESO
//WHERE EM_CODIGO = :str_appgeninfo.empresa
//AND SA_LOGIN = :str_appgeninfo.username;
//
//If ls_rol = 'CONTADOR' OR ls_rol = 'CONTADORBAS' Then
//	select count(1)
//	into :ll_count
//	from co_cabcom
//	where cp_anulado = 'P';
//	
//	if ll_count > 0 then
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Existen comprobantes contables pendientes ...<Por favor tome acci$$HEX1$$f300$$ENDHEX$$n...!!!>")
//	end if
//End if
//return 1

//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El per$$HEX1$$ed00$$ENDHEX$$odo de prueba ha caducado...la aplicaci$$HEX1$$f300$$ENDHEX$$n se cerrar$$HEX1$$e100$$ENDHEX$$...!!!>")
//Halt
end event

event close;//menu    lm_framemenu
//integer li_position, li_itemcount,li_actualizar_menu,li_items_del_item,li_i,li_j
//integer li_indice,li_items_item_item,li_items_item_n4,li_indice4
//string  ls_opcion,ls_nombre,ls_i,ls_j,ls_k,ls_m
//long    ll_posicion
//
////Vemos si es necesario actualizar las opciones del men$$HEX2$$fa002000$$ENDHEX$$en la base
////select pr_valor
////into :li_actualizar_menu
////from pr_param
////where pr_nombre = 'ACT_MENU'
////and em_codigo = :str_appgeninfo.empresa;
//
//
////if li_actualizar_menu = 1 then
//	This.SetMicrohelp('Actualizando Menu, espere por favor...')
////    delete from sg_rolmenu;
////		delete from sg_menu;
//		delete from sg_menures;	
//		lm_frameMenu = this.menuid
//     	li_itemcount = upperBound(lm_frameMenu.item)
//     for li_position = 1 to li_itemcount
//		ls_opcion = lm_framemenu.item[li_position].ClassName()
//		ls_nombre = lm_frameMenu.item[li_position].text
////		lm_frameMenu.item[li_position].tag = lm_frameMenu.item[li_position].text
//		ls_i = string(li_position,"00")
//		insert into sg_menures(mn_codigo,mn_opcion,mn_nombre,mn_padre)
//		values (:ls_i,:ls_opcion,:ls_nombre,null);
//		li_items_del_item = upperBound(lm_frameMenu.item[li_position].item)
//		for li_i = 1 to li_items_del_item
//	      ls_opcion = lm_framemenu.item[li_position].item[li_i].ClassName()
//			ll_posicion = pos(lm_frameMenu.item[li_position].item[li_i].text,"&")
//			ls_nombre = lm_frameMenu.item[li_position].item[li_i].text
////			lm_frameMenu.item[li_position].item[li_i].tag = lm_frameMenu.item[li_position].item[li_i].text
//			ls_j = string(li_i,"00")
//			insert into sg_menures(mn_codigo,mn_opcion,mn_nombre,mn_padre)
//		    values (:ls_i||:ls_j,:ls_opcion,:ls_nombre,:ls_i);
//			li_items_item_item = upperBound(lm_frameMenu.item[li_position].item[li_i].item)
//			for li_indice = 1 to li_items_item_item
//				ls_opcion = lm_framemenu.item[li_position].item[li_i].item[li_indice].ClassName()
//				ll_posicion = pos(lm_frameMenu.item[li_position].item[li_i].item[li_indice].text,"&")
//				ls_nombre = lm_frameMenu.item[li_position].item[li_i].item[li_indice].text
////				lm_frameMenu.item[li_position].item[li_i].item[li_indice].tag = lm_frameMenu.item[li_position].item[li_i].item[li_indice].text
//				ls_k = string(li_indice,"00")
//				insert into sg_menures(mn_codigo,mn_opcion,mn_nombre,mn_padre)
//		   	     values (:ls_i||:ls_j||:ls_k,:ls_opcion,:ls_nombre,:ls_i||:ls_j);
//				li_items_item_n4 = upperBound(lm_frameMenu.item[li_position].item[li_i].item[li_indice].item)
//				for li_indice4 = 1 to li_items_item_n4
//					ls_opcion = lm_framemenu.item[li_position].item[li_i].item[li_indice].item[li_indice4].ClassName()
//					ll_posicion = pos(lm_frameMenu.item[li_position].item[li_i].item[li_indice].item[li_indice4].text,"&")
//					ls_nombre = lm_frameMenu.item[li_position].item[li_i].item[li_indice].item[li_indice4].text
////					lm_frameMenu.item[li_position].item[li_i].item[li_indice].item[li_indice4].tag = lm_frameMenu.item[li_position].item[li_i].item[li_indice].item[li_indice4].text
//					ls_m = string(li_indice4,"00")
//					insert into sg_menures(mn_codigo,mn_opcion,mn_nombre,mn_padre)
//						  values (:ls_i||:ls_j||:ls_k||:ls_m,:ls_opcion,:ls_nombre,:ls_i||:ls_j||:ls_k);
//				next
//		next
//   next
//next
////   insert into sg_rolmenu ( SELECT "SG_MENU"."MN_CODIGO","SG_ROL"."RS_NOMBRE",'N',null
////									FROM "SG_MENU","SG_ROL");
//									
////	update pr_param
////	set pr_valor = 0
////	where pr_nombre = 'ACT_MENU'
////	and em_codigo = :str_appgeninfo.empresa;
//
//
////	update sg_rolmenu
////	set rm_habilitado = 'S'
////	where rs_nombre = 'ADMINISTRADOR';
//	
//	commit;
////end if
//									
//ib_primera = true
//Destroy dw_prod
//Destroy dw_clien
end event

event open;call super::open;w_marco.title = gs_titulo_marco + "         " +gs_empresa+"/"+ gs_su_nombre + "/" + gs_bo_nombre+"/"+&
					str_appgeninfo.caja+" "+str_appgeninfo.departamento+"   "+gs_empleado
gnv_help.iw_mdiWindow = This

//Timer(5)
end event

event closequery;call super::closequery;int li_xx
li_xx = Messagebox("Confirme "+str_appgeninfo.username,"$$HEX1$$bf00$$ENDHEX$$Desea salir del sistema?",Question!,YesNo!,2)
If li_xx = 1 Then 
	rollback;
	disconnect;
	halt
else
	return 1	
end if

end event


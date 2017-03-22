HA$PBExportHeader$w_usuario.srw
forward
global type w_usuario from w_sheet_1_dw_maint
end type
type st_1 from statictext within w_usuario
end type
type st_2 from statictext within w_usuario
end type
end forward

global type w_usuario from w_sheet_1_dw_maint
integer width = 2729
integer height = 1444
string title = "Usuarios del Sistema"
st_1 st_1
st_2 st_2
end type
global w_usuario w_usuario

on w_usuario.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
end on

on w_usuario.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
end on

event open;DataWindowChild  ldwc_aux

dw_datos.getChild("em_codigo", ldwc_aux)
ldwc_aux.setTransObject(sqlca)
ldwc_aux.retrieve()

dw_datos.getChild("su_codigo", ldwc_aux)
ldwc_aux.setTransObject(sqlca)
ldwc_aux.retrieve(str_appgeninfo.empresa)

dw_datos.getChild("sa_seccion", ldwc_aux)
ldwc_aux.setTransObject(sqlca)
ldwc_aux.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

call super::open

dw_datos.setFocus()
dw_datos.uf_retrieve()
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_usuario
integer y = 140
integer width = 2697
integer height = 1204
string dataobject = "d_usuario"
boolean border = true
end type

event dw_datos::updatestart;call super::updatestart;//Si se graba bien el usuario entonces crearlo en la base
////String ls_parametros,ls_clave,ls_usuario
//Int li_rc
//
//
//
//dwItemStatus l_status
//
//
//if this.getrow() = 0 then return
//
//ls_usuario = this.object.sa_login[this.getrow()]
//ls_clave    = this.object.sa_passwd[this.getrow()]
//
//if isnumber(ls_clave) then ls_clave = '"'+ls_clave+'"'
//
////Determinar si existe el usuario en la base de datos
//
//l_status = this.GetItemStatus( this.GetRow(), 0, Primary!)
//
//
//	
//	SELECT COUNT(1)
//	INTO :li_rc
//	FROM DBA_USERS
//	WHERE USERNAME = UPPER(:ls_usuario);
//		
//     if li_rc = 1 and l_status = newmodified! then
//		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existe un usuario con est$$HEX1$$e100$$ENDHEX$$s caracter$$HEX1$$ed00$$ENDHEX$$sticas...Por favor verifique...!!!!",Exclamation!)
//		return 1
//	elseif li_rc = 0 then
//  		ls_parametros = "CREATE USER "+ls_usuario+" IDENTIFIED BY "+ls_clave
//		execute immediate :ls_parametros;
//		if sqlca.sqlcode < 0 Then
//					if sqlca.sqldbcode = 1031 then
//					Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al crear el usuario en la base de datos ; privilegios insuficientes..." +sqlca.sqlerrtext)
//					rollback;
//					return 1
//					end if
//			
//			 Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al crear el usuario en la base de datos." +sqlca.sqlerrtext)
//			  rollback;
//			 return 1 
//		end if 
//	end if	
//	
///*Siempre ejecutar */
//ls_parametros = "GRANT GENERAL_USER"+ls_usuario 
//execute immediate :ls_parametros;
//if sqlca.sqlcode < 0 Then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al asignar el ROL..." +sqlca.sqlerrtext)
//rollback;
//return 1
//end if 
//
//ls_parametros = "ALTER USER "+ls_usuario+ " DEFAULT  ROLE   GENERAL_USER "  
//execute immediate :ls_parametros;
//if sqlca.sqlcode < 0 Then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar privilegios..." +sqlca.sqlerrtext)
//rollback;  
//return 1
//end if 
//
//
//ls_parametros = "ALTER USER "+ls_usuario+ " IDENTIFIED BY "+ ls_clave
//execute immediate :ls_parametros;
//if sqlca.sqlcode < 0 Then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al asignar el password..." +sqlca.sqlerrtext)
//rollback;  
//return 1
//end if 


return 0
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_usuario
end type

type st_1 from statictext within w_usuario
integer x = 1623
integer y = 28
integer width = 1042
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
string text = "Actualizar un registro  a la vez ...recomendado"
boolean focusrectangle = false
end type

type st_2 from statictext within w_usuario
integer x = 1413
integer y = 28
integer width = 187
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
string text = "NOTA:"
boolean focusrectangle = false
end type


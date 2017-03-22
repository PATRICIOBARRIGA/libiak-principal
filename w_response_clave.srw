HA$PBExportHeader$w_response_clave.srw
forward
global type w_response_clave from window
end type
type cb_1 from commandbutton within w_response_clave
end type
type sle_4 from singlelineedit within w_response_clave
end type
type st_4 from statictext within w_response_clave
end type
type sle_2 from singlelineedit within w_response_clave
end type
type st_3 from statictext within w_response_clave
end type
type sle_3 from singlelineedit within w_response_clave
end type
type st_2 from statictext within w_response_clave
end type
type st_1 from statictext within w_response_clave
end type
type pb_2 from picturebutton within w_response_clave
end type
type pb_1 from picturebutton within w_response_clave
end type
type sle_1 from singlelineedit within w_response_clave
end type
end forward

global type w_response_clave from window
integer width = 978
integer height = 896
boolean titlebar = true
string title = "Clave para editar"
windowtype windowtype = response!
long backcolor = 67108864
event ue_nextfield pbm_dwnprocessenter
cb_1 cb_1
sle_4 sle_4
st_4 st_4
sle_2 sle_2
st_3 st_3
sle_3 sle_3
st_2 st_2
st_1 st_1
pb_2 pb_2
pb_1 pb_1
sle_1 sle_1
end type
global w_response_clave w_response_clave

type variables
window iw_aux
int ii_intentos = 0
end variables

event ue_nextfield;send(handle(this),256,9,long(0,0))
end event

on w_response_clave.create
this.cb_1=create cb_1
this.sle_4=create sle_4
this.st_4=create st_4
this.sle_2=create sle_2
this.st_3=create st_3
this.sle_3=create sle_3
this.st_2=create st_2
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.sle_1=create sle_1
this.Control[]={this.cb_1,&
this.sle_4,&
this.st_4,&
this.sle_2,&
this.st_3,&
this.sle_3,&
this.st_2,&
this.st_1,&
this.pb_2,&
this.pb_1,&
this.sle_1}
end on

on w_response_clave.destroy
destroy(this.cb_1)
destroy(this.sle_4)
destroy(this.st_4)
destroy(this.sle_2)
destroy(this.st_3)
destroy(this.sle_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.sle_1)
end on

event open;This.Move(800,800)
iw_aux = Message.PowerObjectParm

end event

type cb_1 from commandbutton within w_response_clave
integer x = 530
integer y = 504
integer width = 375
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cambiar Clave"
end type

event clicked;sle_3.visible = true
sle_4.visible = true
st_3.visible = true
st_4.visible = true
end event

type sle_4 from singlelineedit within w_response_clave
boolean visible = false
integer x = 480
integer y = 324
integer width = 384
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_response_clave
boolean visible = false
integer x = 50
integer y = 324
integer width = 402
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Confirmar clave:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_response_clave
integer x = 480
integer y = 148
integer width = 384
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_response_clave
boolean visible = false
integer x = 55
integer y = 240
integer width = 334
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Clave Nueva:"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_response_clave
boolean visible = false
integer x = 480
integer y = 236
integer width = 384
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_response_clave
integer x = 55
integer y = 156
integer width = 215
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Clave:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_response_clave
integer x = 55
integer y = 64
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Usuario:"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_response_clave
integer x = 288
integer y = 476
integer width = 174
integer height = 152
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Cancel.Gif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type pb_1 from picturebutton within w_response_clave
integer x = 50
integer y = 476
integer width = 174
integer height = 152
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;String  ls_usuario,ls_clave,ls_parametros,ls_clave_new,&
		  ls_clave_old,ls_mid,ls_clave_confir,ls_flag,ls_objeto
long ll_pos


ls_usuario      = sle_1.text
ls_clave        = sle_2.text
ls_clave_new    = sle_3.text
ls_clave_confir = sle_4.text

ls_objeto = iw_aux.classname()
if sle_3.visible <> true or sle_4.visible <> true then
	
	SELECT 'S'
	INTO    :ls_flag
     FROM "SG_MENU",   
         	 "SG_ROL",   
 	          "SG_ROLMENU",  
              "SG_ACCESO"   
     WHERE ( "SG_ROL"."RS_NOMBRE" = "SG_ROLMENU"."RS_NOMBRE" )  and
			   ( "SG_ACCESO"."RS_NOMBRE" = "SG_ROLMENU"."RS_NOMBRE" )  and
			   ( "SG_ROLMENU"."MN_CODIGO" = "SG_MENU"."MN_CODIGO" ) and  
			   ( ( "SG_ACCESO"."SA_LOGIN" = :ls_usuario ) AND  
				 ( "SG_ACCESO"."SA_PASSWD" = :ls_clave ) AND  
				 ( "SG_ACCESO"."SA_PASSEDIT" = 'S' ) AND
				 ( "SG_MENU"."MN_OPCION" = :ls_objeto ) ) ;
	if sqlca.sqlcode < 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n",""+sqlca.sqlerrtext)
		rollback;
		return
	end if

	if ii_intentos < 3 then
		if ls_flag = 'S' then
			CloseWithReturn(Parent,ls_flag)
		else
			Messagebox("Error","Clave de usuario no v$$HEX1$$e100$$ENDHEX$$lida...intente de nuevo",stopsign!)
			sle_2.setfocus()	
			ii_intentos++
			Return
		end if
	else
		MESSAGEBOX('Acceso negado a Editar','Ha excedido el n$$HEX1$$fa00$$ENDHEX$$mero m$$HEX1$$e100$$ENDHEX$$ximo de intentos. Adi$$HEX1$$f300$$ENDHEX$$s.',Exclamation!)
		close(parent)
	end if
else
	select sa_passwd
	into :ls_clave_old
	from sg_acceso
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo   = :str_appgeninfo.sucursal
	and sa_login 	 = :ls_usuario;

	If ls_clave <> ls_clave_old Then
		Messagebox("Error","Clave actual de usuario no coincide...intente de nuevo",stopsign!)
		 sle_2.setfocus()	
		Return
	End if
	ll_pos = pos(ls_clave_new,'')
	ls_mid = mid(ls_clave_new,ll_pos,1)
	If ls_mid = '' Then
		Messagebox("Error","Ingrese su nueva clave por favor",stopsign!)
		return
	End if
	if ls_clave_new <> ls_clave_confir then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Confirmaci$$HEX1$$f300$$ENDHEX$$n de clave no coincide...verifique" +sqlca.sqlerrtext)
		Return
	end if
	
	update sg_acceso
	set sa_passwd = :ls_clave_new
	where em_codigo = :str_appgeninfo.empresa
	and sa_login = :ls_usuario;
	If sqlca.sqlcode < 0 Then
		rollback;
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al cambiar la clave del Usuario." +sqlca.sqlerrtext)
		Return
	End if 
	commit;
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Cambio de clave efectuado con $$HEX1$$e900$$ENDHEX$$xito")
	close(parent)	
end if






end event

type sle_1 from singlelineedit within w_response_clave
integer x = 480
integer y = 60
integer width = 384
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 20
borderstyle borderstyle = stylelowered!
end type


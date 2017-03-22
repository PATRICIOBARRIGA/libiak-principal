HA$PBExportHeader$w_response_clave_old.srw
forward
global type w_response_clave_old from window
end type
type st_2 from statictext within w_response_clave_old
end type
type st_1 from statictext within w_response_clave_old
end type
type pb_2 from picturebutton within w_response_clave_old
end type
type pb_1 from picturebutton within w_response_clave_old
end type
type sle_2 from singlelineedit within w_response_clave_old
end type
type sle_1 from singlelineedit within w_response_clave_old
end type
end forward

global type w_response_clave_old from window
integer width = 1166
integer height = 628
boolean titlebar = true
string title = "Modificar Asiento"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_2 st_2
st_1 st_1
pb_2 pb_2
pb_1 pb_1
sle_2 sle_2
sle_1 sle_1
end type
global w_response_clave_old w_response_clave_old

type variables
window iw_aux
end variables

on w_response_clave_old.create
this.st_2=create st_2
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.Control[]={this.st_2,&
this.st_1,&
this.pb_2,&
this.pb_1,&
this.sle_2,&
this.sle_1}
end on

on w_response_clave_old.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.sle_2)
destroy(this.sle_1)
end on

event open;This.Move(800,800)
iw_aux = Message.PowerObjectParm
end event

type st_2 from statictext within w_response_clave_old
integer x = 151
integer y = 212
integer width = 224
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clave:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_response_clave_old
integer x = 155
integer y = 92
integer width = 187
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Usuario"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_response_clave_old
integer x = 928
integer y = 352
integer width = 174
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Cancel.Gif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type pb_1 from picturebutton within w_response_clave_old
integer x = 50
integer y = 348
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;String  ls_usuario,ls_clave,ls_param
long     ll_num
char lch_cambio

ls_usuario = sle_1.text
ls_clave     =  sle_2.text

//Validar la contrase$$HEX1$$f100$$ENDHEX$$a

//Select  sa_proceso 
//into:      lch_cambio
//from     sg_acceso
//where  em_codigo = :str_appgeninfo.empresa
//and sa_login = :ls_usuario 
//and sa_passwd = :ls_clave
//and sa_activo = 'S';
//
//If sqlca.sqlcode < 0 Then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al validar el Usuario." +sqlca.sqlerrtext)
//Return
//End if 	
//
//If lch_cambio <> 'S' Then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No es un usuario autorizado.")
//Return
//End if




/************/
string ls_flag,ls_objeto
ls_objeto = iw_aux.classname()


select  'S'
into    :ls_flag
from   sg_objedit x, sg_menu y ,no_emple z , sg_acceso t 
where x.mn_codigo = y.mn_codigo
and x.ep_codigo    = z.ep_codigo
and z.sa_login       =  t.sa_login
and z.sa_login       = :sle_1.text
and t.sa_passedit  = :sle_2.text
and y.mn_opcion   = :ls_objeto;

if sqlca.sqlcode < 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n",""+sqlca.sqlerrtext)
	rollback;
	return
end if

CloseWithReturn(Parent,ls_flag)
//CloseWithReturn(Parent,lch_cambio)

end event

type sle_2 from singlelineedit within w_response_clave_old
integer x = 421
integer y = 204
integer width = 507
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_response_clave_old
integer x = 421
integer y = 84
integer width = 512
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type


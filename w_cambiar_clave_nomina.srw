HA$PBExportHeader$w_cambiar_clave_nomina.srw
forward
global type w_cambiar_clave_nomina from window
end type
type sle_4 from singlelineedit within w_cambiar_clave_nomina
end type
type st_4 from statictext within w_cambiar_clave_nomina
end type
type sle_2 from singlelineedit within w_cambiar_clave_nomina
end type
type st_3 from statictext within w_cambiar_clave_nomina
end type
type sle_3 from singlelineedit within w_cambiar_clave_nomina
end type
type st_2 from statictext within w_cambiar_clave_nomina
end type
type st_1 from statictext within w_cambiar_clave_nomina
end type
type pb_2 from picturebutton within w_cambiar_clave_nomina
end type
type pb_1 from picturebutton within w_cambiar_clave_nomina
end type
type sle_1 from singlelineedit within w_cambiar_clave_nomina
end type
end forward

global type w_cambiar_clave_nomina from window
integer width = 960
integer height = 760
boolean titlebar = true
string title = "Cambiar clave de asistencia"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
event ue_nextfield pbm_dwnprocessenter
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
global w_cambiar_clave_nomina w_cambiar_clave_nomina

event ue_nextfield;send(handle(this),256,9,long(0,0))
end event

on w_cambiar_clave_nomina.create
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
this.Control[]={this.sle_4,&
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

on w_cambiar_clave_nomina.destroy
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

end event

type sle_4 from singlelineedit within w_cambiar_clave_nomina
integer x = 462
integer y = 312
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
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_cambiar_clave_nomina
integer x = 50
integer y = 312
integer width = 370
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Confirmar clave:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_cambiar_clave_nomina
integer x = 462
integer y = 152
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
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_cambiar_clave_nomina
integer x = 55
integer y = 236
integer width = 302
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clave Nueva:"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_cambiar_clave_nomina
integer x = 462
integer y = 232
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
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_cambiar_clave_nomina
integer x = 55
integer y = 160
integer width = 302
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clave Actual:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_cambiar_clave_nomina
integer x = 55
integer y = 76
integer width = 398
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "C$$HEX1$$f300$$ENDHEX$$digo empleado:"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_cambiar_clave_nomina
integer x = 576
integer y = 448
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

type pb_1 from picturebutton within w_cambiar_clave_nomina
integer x = 133
integer y = 448
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

event clicked;String  ls_usuario,ls_clave,ls_parametros,ls_clave_new,ls_clave_old,ls_mid,ls_clave_confir
long ll_pos


ls_usuario      = sle_1.text
ls_clave        = sle_2.text
ls_clave_new    = sle_3.text
ls_clave_confir = sle_4.text

select  ep_clavnom
into:ls_clave_old
from no_emple
where em_codigo = :str_appgeninfo.empresa
and ep_codigo = :ls_usuario;

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

//declare c1 cursor for
//	select  ep_clavnom
//	from no_emple
//	where em_codigo = :str_appgeninfo.empresa
//	and su_codigo = :str_appgeninfo.sucursal
//	and ep_nonom = 'S'
//	and ep_fecsal is null;
//open c1;
// fetch c1 into:ls_clave_old;
//	DO WHILE sqlca.sqlcode = 0
//		IF ls_clave_new = ls_clave_old Then
//			close c1;
//			Messagebox("Error","Clave nueva ya exise, ingrese otra por favor",stopsign!)
//			return
//		End if
//		fetch c1 into:ls_clave_old;
//	LOOP
//close c1;

if ls_clave_new <> ls_clave_confir then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Confirmaci$$HEX1$$f300$$ENDHEX$$n de clave no coincide...verifique" +sqlca.sqlerrtext)
	Return
end if

update no_emple
set ep_clavnom = :ls_clave_new
where em_codigo = :str_appgeninfo.empresa
and ep_codigo = :ls_usuario;
If sqlca.sqlcode < 0 Then
	rollback;
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al cambiar la clave del Usuario." +sqlca.sqlerrtext)
	Return
End if 
commit;
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Cambio de clave efectuado con $$HEX1$$e900$$ENDHEX$$xito")
close(parent)
end event

type sle_1 from singlelineedit within w_cambiar_clave_nomina
integer x = 462
integer y = 72
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
integer limit = 5
borderstyle borderstyle = stylelowered!
end type


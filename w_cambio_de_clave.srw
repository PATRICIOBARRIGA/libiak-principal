HA$PBExportHeader$w_cambio_de_clave.srw
forward
global type w_cambio_de_clave from window
end type
type sle_2 from singlelineedit within w_cambio_de_clave
end type
type st_3 from statictext within w_cambio_de_clave
end type
type sle_3 from singlelineedit within w_cambio_de_clave
end type
type st_2 from statictext within w_cambio_de_clave
end type
type st_1 from statictext within w_cambio_de_clave
end type
type pb_2 from picturebutton within w_cambio_de_clave
end type
type pb_1 from picturebutton within w_cambio_de_clave
end type
type sle_1 from singlelineedit within w_cambio_de_clave
end type
end forward

global type w_cambio_de_clave from window
integer width = 974
integer height = 760
boolean titlebar = true
string title = "Cambio de clave SIF"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
sle_2 sle_2
st_3 st_3
sle_3 sle_3
st_2 st_2
st_1 st_1
pb_2 pb_2
pb_1 pb_1
sle_1 sle_1
end type
global w_cambio_de_clave w_cambio_de_clave

on w_cambio_de_clave.create
this.sle_2=create sle_2
this.st_3=create st_3
this.sle_3=create sle_3
this.st_2=create st_2
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.sle_1=create sle_1
this.Control[]={this.sle_2,&
this.st_3,&
this.sle_3,&
this.st_2,&
this.st_1,&
this.pb_2,&
this.pb_1,&
this.sle_1}
end on

on w_cambio_de_clave.destroy
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

type sle_2 from singlelineedit within w_cambio_de_clave
integer x = 361
integer y = 160
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

type st_3 from statictext within w_cambio_de_clave
integer x = 50
integer y = 284
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

type sle_3 from singlelineedit within w_cambio_de_clave
integer x = 361
integer y = 272
integer width = 507
integer height = 84
integer taborder = 30
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

type st_2 from statictext within w_cambio_de_clave
integer x = 50
integer y = 168
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

type st_1 from statictext within w_cambio_de_clave
integer x = 50
integer y = 56
integer width = 210
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Usuario:"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_cambio_de_clave
integer x = 686
integer y = 444
integer width = 174
integer height = 152
integer taborder = 50
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

type pb_1 from picturebutton within w_cambio_de_clave
integer x = 160
integer y = 444
integer width = 174
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;String  ls_usuario,ls_clave,ls_parametros,ls_clave_new,ls_clave_old

ls_usuario    = sle_1.text
ls_clave      = sle_2.text
ls_clave_new  = sle_3.text


//select  sa_passwd 
//into:ls_clave_old
//from sg_acceso
//where em_codigo = :str_appgeninfo.empresa
//and su_codigo = :str_appgeninfo.sucursal
//and sa_login = :ls_usuario;
//If ls_clave <> ls_clave_old Then
//	Messagebox("Error","Clave de usuario actual no coincide...intente de nuevo",stopsign!)
//    sle_2.setfocus()	
//	Return
//End if

//Verifico si ya existe nueva clave ingresada en la base
//declare c1 cursor for
//	select  sa_passwd 
//	from sg_acceso
//	where em_codigo = :str_appgeninfo.empresa
//	and su_codigo = :str_appgeninfo.sucursal;
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


if str_appgeninfo.username = ls_usuario and str_appgeninfo.password = ls_clave then
	//Validar la contrase$$HEX1$$f100$$ENDHEX$$a
	ls_parametros = "ALTER USER "+ls_usuario+" IDENTIFIED BY "+ls_clave_new
	execute immediate :ls_parametros;
	If sqlca.sqlcode < 0 Then
		rollback;
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al cambiar la clave del Usuario en la base" +sqlca.sqlerrtext)
		Return
	End if 
	
	//update sg_acceso
	//set sa_passwd = :ls_clave_new
	//where em_codigo = :str_appgeninfo.empresa
	//and su_codigo = :str_appgeninfo.sucursal
	//and sa_login = :ls_usuario;
	//If sqlca.sqlcode < 0 Then
	//	rollback;
	//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al cambiar la clave del Usuario." +sqlca.sqlerrtext)
	//	Return
	//End if 
	commit;
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Cambio de clave efectuado con $$HEX1$$e900$$ENDHEX$$xito")
	sle_1.setfocus()
else
		Messagebox("Error de Clave","Clave de Usuario incorrecta" +sqlca.sqlerrtext)
		Return
end if
end event

type sle_1 from singlelineedit within w_cambio_de_clave
integer x = 361
integer y = 48
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


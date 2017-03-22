HA$PBExportHeader$w_cambiar_instancia.srw
forward
global type w_cambiar_instancia from window
end type
type sle_2 from singlelineedit within w_cambiar_instancia
end type
type st_3 from statictext within w_cambiar_instancia
end type
type sle_3 from singlelineedit within w_cambiar_instancia
end type
type st_2 from statictext within w_cambiar_instancia
end type
type st_1 from statictext within w_cambiar_instancia
end type
type pb_2 from picturebutton within w_cambiar_instancia
end type
type pb_1 from picturebutton within w_cambiar_instancia
end type
type sle_1 from singlelineedit within w_cambiar_instancia
end type
end forward

global type w_cambiar_instancia from window
integer width = 974
integer height = 760
boolean titlebar = true
string title = "Cambiar Instancia"
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
global w_cambiar_instancia w_cambiar_instancia

on w_cambiar_instancia.create
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

on w_cambiar_instancia.destroy
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

type sle_2 from singlelineedit within w_cambiar_instancia
integer x = 375
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
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_cambiar_instancia
integer x = 50
integer y = 284
integer width = 187
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

type sle_3 from singlelineedit within w_cambiar_instancia
integer x = 375
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

type st_2 from statictext within w_cambiar_instancia
integer x = 50
integer y = 168
integer width = 238
integer height = 56
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

type st_1 from statictext within w_cambiar_instancia
integer x = 50
integer y = 56
integer width = 320
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Conectar con:"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_cambiar_instancia
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

type pb_1 from picturebutton within w_cambiar_instancia
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

event clicked;s_instancia str_instancia

str_instancia.instancia = sle_1.text
str_instancia.usuario = sle_2.text
str_instancia.clave  = sle_3.text

If str_instancia.instancia ='' or str_instancia.usuario = '' or str_instancia.clave = '' Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar todos los datos para conectarse con la nueva base")
	return	
End if

disconnect using sqlca;
//str_instancia.instancia = '@'+str_instancia.instancia

w_marco.SetMicroHelp("Conect$$HEX1$$e100$$ENDHEX$$ndonos a la base de datos...")
str_appgeninfo.db_connected = f_db_connect(sqlca, &
								str_instancia.usuario, str_instancia.clave, &
								str_appgeninfo.dbms, str_instancia.instancia, &
								str_appgeninfo.databasename)
if str_appgeninfo.db_connected then 
	w_marco.SetMicroHelp("Listo...")
	close(parent)
	str_appgeninfo.servername = str_instancia.instancia
	str_appgeninfo.username = str_instancia.usuario
	str_appgeninfo.password = str_instancia.clave
	open(w_sel_sucursal_bodega)
Else
	f_db_connect(sqlca,str_appgeninfo.username, str_appgeninfo.password, &
                         str_appgeninfo.dbms, str_appgeninfo.servername,str_appgeninfo.databasename)
	return
End if



end event

type sle_1 from singlelineedit within w_cambiar_instancia
integer x = 375
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


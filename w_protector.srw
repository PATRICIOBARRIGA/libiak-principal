HA$PBExportHeader$w_protector.srw
$PBExportComments$Protector de pantalla
forward
global type w_protector from window
end type
type st_3 from statictext within w_protector
end type
type st_1 from statictext within w_protector
end type
type st_clave from statictext within w_protector
end type
type sle_clave from singlelineedit within w_protector
end type
type st_saludo from statictext within w_protector
end type
type cb_1 from commandbutton within w_protector
end type
type p_2 from picture within w_protector
end type
end forward

global type w_protector from window
integer width = 3141
integer height = 2424
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 0
st_3 st_3
st_1 st_1
st_clave st_clave
sle_clave sle_clave
st_saludo st_saludo
cb_1 cb_1
p_2 p_2
end type
global w_protector w_protector

type variables
int ii_intentos
boolean ib_ok
end variables

on closequery;if 	ib_ok = false then message.returnvalue = 1
end on

event open;//st_saludo.text = aplicacion.saludo
end event

on w_protector.create
this.st_3=create st_3
this.st_1=create st_1
this.st_clave=create st_clave
this.sle_clave=create sle_clave
this.st_saludo=create st_saludo
this.cb_1=create cb_1
this.p_2=create p_2
this.Control[]={this.st_3,&
this.st_1,&
this.st_clave,&
this.sle_clave,&
this.st_saludo,&
this.cb_1,&
this.p_2}
end on

on w_protector.destroy
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_clave)
destroy(this.sle_clave)
destroy(this.st_saludo)
destroy(this.cb_1)
destroy(this.p_2)
end on

type st_3 from statictext within w_protector
integer x = 795
integer y = 152
integer width = 338
integer height = 88
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "C$$HEX1$$ed00$$ENDHEX$$a. Ltda."
boolean focusrectangle = false
end type

type st_1 from statictext within w_protector
integer x = 73
integer y = 80
integer width = 727
integer height = 156
integer textsize = -28
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "DynaSoft"
boolean focusrectangle = false
end type

type st_clave from statictext within w_protector
boolean visible = false
integer x = 78
integer y = 420
integer width = 581
integer height = 72
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
boolean enabled = false
string text = "Digite su clave :"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_clave from singlelineedit within w_protector
boolean visible = false
integer x = 699
integer y = 420
integer width = 453
integer height = 88
integer taborder = 10
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean password = true
integer limit = 8
borderstyle borderstyle = stylelowered!
end type

event modified;if trim(this.text) = str_appgeninfo.password then
	ib_ok = true
	close(parent)
else
	if ii_intentos >= 3 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El n$$HEX1$$fa00$$ENDHEX$$mero m$$HEX1$$e100$$ENDHEX$$ximo de intentos ha sido excedido. Adi$$HEX1$$f300$$ENDHEX$$s",StopSign!)
		halt
	end if
	beep(1)
	Messagebox("Revise","Clave mal digitada!",StopSign!)
	ii_intentos++
	this.setfocus()
end if
end event

type st_saludo from statictext within w_protector
integer x = 78
integer y = 236
integer width = 1989
integer height = 136
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16776960
long backcolor = 0
boolean enabled = false
string text = "Dynamic Sistema Integrado Financiero (DynaSif 9.0)"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_protector
integer x = 1207
integer y = 416
integer width = 411
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quitar &Protector"
boolean cancel = true
boolean default = true
end type

on clicked;this.visible = false
st_clave.visible = true
sle_clave.visible = true
sle_clave.setfocus()
end on

type p_2 from picture within w_protector
integer width = 4009
integer height = 1940
boolean originalsize = true
string picturename = "Imagenes\ScreenS.Gif"
boolean focusrectangle = false
end type


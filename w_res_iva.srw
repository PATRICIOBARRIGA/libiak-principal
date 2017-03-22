HA$PBExportHeader$w_res_iva.srw
forward
global type w_res_iva from window
end type
type cb_2 from commandbutton within w_res_iva
end type
type cb_1 from commandbutton within w_res_iva
end type
type st_2 from statictext within w_res_iva
end type
type em_1 from editmask within w_res_iva
end type
end forward

global type w_res_iva from window
integer width = 882
integer height = 456
boolean titlebar = true
string title = "IVA"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_2 cb_2
cb_1 cb_1
st_2 st_2
em_1 em_1
end type
global w_res_iva w_res_iva

on w_res_iva.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.em_1=create em_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_2,&
this.em_1}
end on

on w_res_iva.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.em_1)
end on

event open;this.move(1000,1000)
end event

type cb_2 from commandbutton within w_res_iva
integer x = 603
integer y = 264
integer width = 215
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_res_iva
integer x = 69
integer y = 260
integer width = 210
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "O.K."
end type

event clicked;decimal  lc_iva
lc_iva = dec(em_1.text)
if lc_iva <=0 Then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El IVA no puede ser menor o igual a cero.")
return
end if 
closewithreturn(parent,lc_iva)
end event

type st_2 from statictext within w_res_iva
integer x = 160
integer y = 60
integer width = 512
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingrese el valor de IVA"
boolean focusrectangle = false
end type

type em_1 from editmask within w_res_iva
integer x = 320
integer y = 128
integer width = 256
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
end type


HA$PBExportHeader$w_gen_parametros.srw
forward
global type w_gen_parametros from window
end type
type cb_2 from commandbutton within w_gen_parametros
end type
type cb_1 from commandbutton within w_gen_parametros
end type
type st_1 from statictext within w_gen_parametros
end type
type rb_2 from radiobutton within w_gen_parametros
end type
type rb_1 from radiobutton within w_gen_parametros
end type
end forward

global type w_gen_parametros from window
integer width = 1262
integer height = 644
boolean titlebar = true
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n de par$$HEX1$$e100$$ENDHEX$$metros"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
st_1 st_1
rb_2 rb_2
rb_1 rb_1
end type
global w_gen_parametros w_gen_parametros

on w_gen_parametros.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_1,&
this.rb_2,&
this.rb_1}
end on

on w_gen_parametros.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_1)
end on

type cb_2 from commandbutton within w_gen_parametros
integer x = 699
integer y = 376
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

type cb_1 from commandbutton within w_gen_parametros
integer x = 114
integer y = 376
integer width = 343
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
boolean default = true
end type

event clicked;string ls_op

if rb_1.checked then ls_op = 'S'
if rb_2.checked then ls_op = 'T'
choose case ls_op
	case 'S'
		//f_sucursal()
	case 'T'
		f_secuencial_transfer()
end choose
return 1
end event

type st_1 from statictext within w_gen_parametros
integer x = 69
integer y = 56
integer width = 494
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Seleccione la opci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_gen_parametros
integer x = 261
integer y = 240
integer width = 837
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Secuenciales de transferencias"
end type

type rb_1 from radiobutton within w_gen_parametros
integer x = 261
integer y = 152
integer width = 763
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Par$$HEX1$$e100$$ENDHEX$$metros por sucursal"
end type


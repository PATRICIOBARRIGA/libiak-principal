HA$PBExportHeader$w_preview.srw
forward
global type w_preview from window
end type
type cb_help from commandbutton within w_preview
end type
type cb_aceptar from commandbutton within w_preview
end type
type cb_cancelar from commandbutton within w_preview
end type
type rb_zd from radiobutton within w_preview
end type
type rb_zprint from radiobutton within w_preview
end type
type cbx_regla from checkbox within w_preview
end type
type cbx_preview from checkbox within w_preview
end type
type em_personal from editmask within w_preview
end type
type rb_p from radiobutton within w_preview
end type
type rb_30 from radiobutton within w_preview
end type
type rb_65 from radiobutton within w_preview
end type
type rb_100 from radiobutton within w_preview
end type
type rb_200 from radiobutton within w_preview
end type
type st_1 from statictext within w_preview
end type
type gb_2 from groupbox within w_preview
end type
type gb_1 from groupbox within w_preview
end type
end forward

global type w_preview from window
integer x = 649
integer y = 452
integer width = 1632
integer height = 1024
boolean titlebar = true
string title = "Preparaci$$HEX1$$f300$$ENDHEX$$n de P$$HEX1$$e100$$ENDHEX$$gina"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_help cb_help
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
rb_zd rb_zd
rb_zprint rb_zprint
cbx_regla cbx_regla
cbx_preview cbx_preview
em_personal em_personal
rb_p rb_p
rb_30 rb_30
rb_65 rb_65
rb_100 rb_100
rb_200 rb_200
st_1 st_1
gb_2 gb_2
gb_1 gb_1
end type
global w_preview w_preview

type variables
datawindow dw
int zoom, topico
end variables

on open;dw = message.PowerObjectParm

topico = 123

zoom = integer (dw.describe ("datawindow.zoom"))
cbx_preview.checked = (dw.describe ("datawindow.print.preview") = "yes")
cbx_regla.checked = (dw.describe ("datawindow.print.preview.rulers") = "yes")
if cbx_preview.checked then
	zoom = integer (dw.describe ("datawindow.print.preview.zoom"))
   rb_zprint.checked = true
else
	rb_zd.checked = true
end if

choose case zoom
	case 200
			rb_200.checked = true
	case 100
			rb_100.checked = true
	case 65
			rb_65.checked = true
	case 30
			rb_30.checked = true
	case else
			rb_p.checked = true
         em_personal.text = string (zoom)
end choose
end on

on w_preview.create
this.cb_help=create cb_help
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.rb_zd=create rb_zd
this.rb_zprint=create rb_zprint
this.cbx_regla=create cbx_regla
this.cbx_preview=create cbx_preview
this.em_personal=create em_personal
this.rb_p=create rb_p
this.rb_30=create rb_30
this.rb_65=create rb_65
this.rb_100=create rb_100
this.rb_200=create rb_200
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_help,&
this.cb_aceptar,&
this.cb_cancelar,&
this.rb_zd,&
this.rb_zprint,&
this.cbx_regla,&
this.cbx_preview,&
this.em_personal,&
this.rb_p,&
this.rb_30,&
this.rb_65,&
this.rb_100,&
this.rb_200,&
this.st_1,&
this.gb_2,&
this.gb_1}
end on

on w_preview.destroy
destroy(this.cb_help)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.rb_zd)
destroy(this.rb_zprint)
destroy(this.cbx_regla)
destroy(this.cbx_preview)
destroy(this.em_personal)
destroy(this.rb_p)
destroy(this.rb_30)
destroy(this.rb_65)
destroy(this.rb_100)
destroy(this.rb_200)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_help from commandbutton within w_preview
integer x = 1042
integer y = 700
integer width = 439
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Help"
end type

type cb_aceptar from commandbutton within w_preview
integer x = 110
integer y = 700
integer width = 439
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
end type

event clicked;dw.SetRedraw (False)
if rb_zprint.checked then
	dw.modify ("datawindow.print.preview.zoom = " + string (zoom))
else
	dw.modify ("datawindow.zoom = " + string (zoom))
end if

if cbx_preview.checked then
	dw.modify ("datawindow.print.preview = Yes")	
else
	dw.modify ("datawindow.print.preview = No")	
end if

if cbx_regla.checked then
	dw.modify ("datawindow.print.preview.rulers = Yes")	
else
	dw.modify ("datawindow.print.preview.rulers = No")	
end if

dw.SetRedraw (true)

close (parent)
end event

type cb_cancelar from commandbutton within w_preview
integer x = 576
integer y = 700
integer width = 439
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

on clicked;close (parent)
end on

type rb_zd from radiobutton within w_preview
integer x = 910
integer y = 220
integer width = 581
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zoom a los datos"
end type

type rb_zprint from radiobutton within w_preview
integer x = 914
integer y = 120
integer width = 571
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zoom al Preview "
boolean checked = true
end type

type cbx_regla from checkbox within w_preview
integer x = 933
integer y = 516
integer width = 370
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Regla"
end type

type cbx_preview from checkbox within w_preview
integer x = 933
integer y = 408
integer width = 384
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Preview"
end type

on clicked;if checked then
	cbx_regla.enabled = true
else
	cbx_regla.enabled = false
end if
end on

type em_personal from editmask within w_preview
integer x = 576
integer y = 484
integer width = 206
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
string mask = "###"
end type

on getfocus;rb_p.checked = true
end on

on modified;zoom = integer (this.text)
end on

type rb_p from radiobutton within w_preview
integer x = 151
integer y = 492
integer width = 421
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Personalizar"
end type

on clicked;zoom = 0
em_personal.text = ""
em_personal.SetFocus()

end on

type rb_30 from radiobutton within w_preview
integer x = 151
integer y = 400
integer width = 352
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "30 %"
end type

on clicked;zoom = 30
end on

type rb_65 from radiobutton within w_preview
integer x = 151
integer y = 308
integer width = 352
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "65 %"
end type

on clicked;zoom = 65
end on

type rb_100 from radiobutton within w_preview
integer x = 151
integer y = 216
integer width = 352
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "100%"
boolean checked = true
end type

on clicked;zoom = 100
end on

type rb_200 from radiobutton within w_preview
integer x = 151
integer y = 124
integer width = 352
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "200 %"
end type

on clicked;zoom = 200
end on

type st_1 from statictext within w_preview
integer x = 69
integer y = 672
integer width = 1454
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_preview
integer x = 855
integer y = 32
integer width = 672
integer height = 320
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tipo de Zoom"
end type

type gb_1 from groupbox within w_preview
integer x = 59
integer y = 32
integer width = 754
integer height = 604
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Zoom"
end type


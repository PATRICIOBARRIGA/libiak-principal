HA$PBExportHeader$w_response_impresion_ajustes.srw
forward
global type w_response_impresion_ajustes from w_response_basic
end type
type rb_1 from radiobutton within w_response_impresion_ajustes
end type
type rb_2 from radiobutton within w_response_impresion_ajustes
end type
type st_1 from statictext within w_response_impresion_ajustes
end type
end forward

global type w_response_impresion_ajustes from w_response_basic
integer width = 1042
integer height = 608
string title = "Opciones de Impresi$$HEX1$$f300$$ENDHEX$$n de Ajustes"
rb_1 rb_1
rb_2 rb_2
st_1 st_1
end type
global w_response_impresion_ajustes w_response_impresion_ajustes

on w_response_impresion_ajustes.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.st_1
end on

on w_response_impresion_ajustes.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_1)
end on

event open;return 1
end event

type pb_cancel from w_response_basic`pb_cancel within w_response_impresion_ajustes
integer x = 750
integer y = 320
end type

type pb_ok from w_response_basic`pb_ok within w_response_impresion_ajustes
integer x = 110
integer y = 316
end type

event pb_ok::clicked;call super::clicked;
//Imprime ingreso
if rb_1.checked then
	Message.StringParm = 'I'
elseif rb_2.checked then
	Message.StringParm = 'E'
end if

CloseWithReturn(Parent, Message.StringParm)
end event

type dw_response from w_response_basic`dw_response within w_response_impresion_ajustes
integer x = 1248
integer y = 56
integer width = 320
integer height = 308
end type

type rb_1 from radiobutton within w_response_impresion_ajustes
integer x = 325
integer y = 112
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingreso"
end type

type rb_2 from radiobutton within w_response_impresion_ajustes
integer x = 320
integer y = 212
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Egreso"
end type

type st_1 from statictext within w_response_impresion_ajustes
integer x = 37
integer y = 16
integer width = 901
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Seleccione la  opci$$HEX1$$f300$$ENDHEX$$n que desea imprimir"
boolean focusrectangle = false
end type


HA$PBExportHeader$w_secuencial_transferencias.srw
forward
global type w_secuencial_transferencias from w_response_basic
end type
type st_1 from statictext within w_secuencial_transferencias
end type
end forward

global type w_secuencial_transferencias from w_response_basic
integer width = 1714
integer height = 716
string title = "Secuenciales de transferencia"
st_1 st_1
end type
global w_secuencial_transferencias w_secuencial_transferencias

on w_secuencial_transferencias.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_secuencial_transferencias.destroy
call super::destroy
destroy(this.st_1)
end on

event open;//
return 1
end event

type pb_cancel from w_response_basic`pb_cancel within w_secuencial_transferencias
integer x = 1317
integer y = 340
integer width = 183
integer height = 164
boolean originalsize = false
end type

event pb_cancel::clicked;call super::clicked;close(parent)
return 1
end event

type pb_ok from w_response_basic`pb_ok within w_secuencial_transferencias
integer x = 210
integer y = 332
integer width = 183
integer height = 160
end type

event pb_ok::clicked;call super::clicked;Setpointer(Hourglass!)

f_secuencial_transfer()
Setpointer(arrow!)
w_marco.setmicrohelp("Proceso Terminado......")
end event

type dw_response from w_response_basic`dw_response within w_secuencial_transferencias
boolean visible = false
integer x = 37
integer y = 376
integer height = 144
end type

type st_1 from statictext within w_secuencial_transferencias
integer x = 210
integer y = 60
integer width = 1321
integer height = 252
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Este proceso generar$$HEX2$$e1002000$$ENDHEX$$una secuencia de transferencia entre bodegas de cada sucursal. Para ejecutar la operaci$$HEX1$$f300$$ENDHEX$$n presione el boton Aceptar."
boolean focusrectangle = false
end type


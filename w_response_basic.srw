HA$PBExportHeader$w_response_basic.srw
forward
global type w_response_basic from window
end type
type pb_cancel from picturebutton within w_response_basic
end type
type pb_ok from picturebutton within w_response_basic
end type
type dw_response from datawindow within w_response_basic
end type
end forward

global type w_response_basic from window
integer x = 759
integer y = 612
integer width = 1646
integer height = 720
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
pb_cancel pb_cancel
pb_ok pb_ok
dw_response dw_response
end type
global w_response_basic w_response_basic

on w_response_basic.create
this.pb_cancel=create pb_cancel
this.pb_ok=create pb_ok
this.dw_response=create dw_response
this.Control[]={this.pb_cancel,&
this.pb_ok,&
this.dw_response}
end on

on w_response_basic.destroy
destroy(this.pb_cancel)
destroy(this.pb_ok)
destroy(this.dw_response)
end on

event open;long ll_newRow
long ll_aux

ll_newRow = dw_response.insertRow(1)
if ll_newRow < 1 then
	messageBox("Error Fatal", "No se puede insertar una fila en la ventana de datos", StopSign!)
	setNull(ll_aux)
	closeWithReturn(this, ll_aux)
end if

end event

type pb_cancel from picturebutton within w_response_basic
integer x = 1006
integer y = 452
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
boolean originalsize = true
string picturename = "Imagenes\Cancel.Gif"
end type

event clicked;long ll_aux

setNull(ll_aux)
closeWithReturn(parent, ll_aux)
end event

type pb_ok from picturebutton within w_response_basic
integer x = 197
integer y = 452
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
end type

type dw_response from datawindow within w_response_basic
integer x = 14
integer y = 72
integer width = 1568
integer height = 328
integer taborder = 10
boolean border = false
end type


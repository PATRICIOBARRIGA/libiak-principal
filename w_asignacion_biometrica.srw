HA$PBExportHeader$w_asignacion_biometrica.srw
forward
global type w_asignacion_biometrica from window
end type
type cb_1 from commandbutton within w_asignacion_biometrica
end type
end forward

global type w_asignacion_biometrica from window
integer width = 1669
integer height = 572
boolean titlebar = true
string title = "Asignaci$$HEX1$$f300$$ENDHEX$$n biom$$HEX1$$e900$$ENDHEX$$trica"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_asignacion_biometrica w_asignacion_biometrica

on w_asignacion_biometrica.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_asignacion_biometrica.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_asignacion_biometrica
integer x = 183
integer y = 112
integer width = 1312
integer height = 188
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Click aqu$$HEX2$$ed002000$$ENDHEX$$para realizar el mantenimiento de huellas"
end type

event clicked;run("c:\huella\borrar\mantenimiento.exe")
close(parent)
end event


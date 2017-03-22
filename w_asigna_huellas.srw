HA$PBExportHeader$w_asigna_huellas.srw
forward
global type w_asigna_huellas from window
end type
type cb_1 from commandbutton within w_asigna_huellas
end type
end forward

global type w_asigna_huellas from window
integer width = 1669
integer height = 572
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_asigna_huellas w_asigna_huellas

on w_asigna_huellas.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_asigna_huellas.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_asigna_huellas
integer x = 110
integer y = 112
integer width = 1408
integer height = 188
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Click aqu$$HEX2$$ed002000$$ENDHEX$$para realizar el mantenimiento de huellas"
boolean flatstyle = true
end type

event clicked;run("c:\huella\borrar\mantenimiento.exe")
close(parent)
end event


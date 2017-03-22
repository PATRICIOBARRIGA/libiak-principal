HA$PBExportHeader$w_vh_opciones_menu.srw
forward
global type w_vh_opciones_menu from window
end type
type st_1 from statictext within w_vh_opciones_menu
end type
type lb_1 from listbox within w_vh_opciones_menu
end type
end forward

global type w_vh_opciones_menu from window
integer width = 1024
integer height = 1128
boolean titlebar = true
string title = "Veh$$HEX1$$ed00$$ENDHEX$$culos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
lb_1 lb_1
end type
global w_vh_opciones_menu w_vh_opciones_menu

on w_vh_opciones_menu.create
this.st_1=create st_1
this.lb_1=create lb_1
this.Control[]={this.st_1,&
this.lb_1}
end on

on w_vh_opciones_menu.destroy
destroy(this.st_1)
destroy(this.lb_1)
end on

type st_1 from statictext within w_vh_opciones_menu
integer x = 59
integer y = 20
integer width = 475
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Seleccione la opci$$HEX1$$f300$$ENDHEX$$n."
boolean focusrectangle = false
end type

type lb_1 from listbox within w_vh_opciones_menu
integer x = 41
integer y = 84
integer width = 905
integer height = 900
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Ingreso","Clases y subclases","Modelos","Partes y piezas"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;w_frame_basic lw_frame
//lw_frame = parentWindow

choose case index
case 1	
return opensheet(w_vh_ingreso,w_marco,0,original!)
case 2
return opensheet(w_vh_clase_y_subclases,w_marco,0,original!)      
case 3
return opensheet(w_vh_modelos,w_marco,0,original!)
case 4
return opensheet(w_vh_partes_y_piezas,w_marco,0,original!)
end choose
	
end event


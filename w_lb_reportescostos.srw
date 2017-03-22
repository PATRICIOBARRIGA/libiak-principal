HA$PBExportHeader$w_lb_reportescostos.srw
$PBExportComments$Contenedor de reportes de costos
forward
global type w_lb_reportescostos from window
end type
type lb_1 from listbox within w_lb_reportescostos
end type
end forward

global type w_lb_reportescostos from window
integer width = 1143
integer height = 1360
boolean titlebar = true
string title = "Costos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
lb_1 lb_1
end type
global w_lb_reportescostos w_lb_reportescostos

on w_lb_reportescostos.create
this.lb_1=create lb_1
this.Control[]={this.lb_1}
end on

on w_lb_reportescostos.destroy
destroy(this.lb_1)
end on

type lb_1 from listbox within w_lb_reportescostos
integer x = 46
integer y = 64
integer width = 987
integer height = 1112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Detalle de costos por sucursal","Resumen  de costos por empresa","Detalle de ventas por sucursal","Rentabilidad de items"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;w_frame_basic lw_frame
//lw_frame = parentWindow

choose case index
case 1	
return opensheet(w_rep_costos_x_sucursal,w_marco,0,original!)
case 2
return opensheet(w_rep_costos_resumen,w_marco,0,original!)      
case 3
return opensheet(w_rep_ventas_x_sucursal,w_marco,0,original!)
case 4
return opensheet(w_rep_rentabilidad,w_marco,0,original!)
end choose
	
end event


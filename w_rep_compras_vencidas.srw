HA$PBExportHeader$w_rep_compras_vencidas.srw
forward
global type w_rep_compras_vencidas from window
end type
type dw_datos from datawindow within w_rep_compras_vencidas
end type
type cb_1 from commandbutton within w_rep_compras_vencidas
end type
type cbx_powerfilter from u_powerfilter_checkbox within w_rep_compras_vencidas
end type
end forward

global type w_rep_compras_vencidas from window
integer width = 3378
integer height = 1784
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_datos dw_datos
cb_1 cb_1
cbx_powerfilter cbx_powerfilter
end type
global w_rep_compras_vencidas w_rep_compras_vencidas

on w_rep_compras_vencidas.create
this.dw_datos=create dw_datos
this.cb_1=create cb_1
this.cbx_powerfilter=create cbx_powerfilter
this.Control[]={this.dw_datos,&
this.cb_1,&
this.cbx_powerfilter}
end on

on w_rep_compras_vencidas.destroy
destroy(this.dw_datos)
destroy(this.cb_1)
destroy(this.cbx_powerfilter)
end on

type dw_datos from datawindow within w_rep_compras_vencidas
integer x = 82
integer y = 276
integer width = 3227
integer height = 1384
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_rep_compras_vencidas
integer x = 814
integer y = 96
integer width = 1120
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;cbx_PowerFilter.of_setdw(dw_datos)
end event

type cbx_powerfilter from u_powerfilter_checkbox within w_rep_compras_vencidas
integer x = 105
integer y = 112
integer width = 393
end type


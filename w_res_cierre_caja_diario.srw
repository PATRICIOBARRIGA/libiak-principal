HA$PBExportHeader$w_res_cierre_caja_diario.srw
forward
global type w_res_cierre_caja_diario from window
end type
type cb_1 from commandbutton within w_res_cierre_caja_diario
end type
type dw_1 from datawindow within w_res_cierre_caja_diario
end type
end forward

global type w_res_cierre_caja_diario from window
integer width = 969
integer height = 980
boolean titlebar = true
string title = "Consulta de Cajeros por Caja"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
cb_1 cb_1
dw_1 dw_1
end type
global w_res_cierre_caja_diario w_res_cierre_caja_diario

on w_res_cierre_caja_diario.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_res_cierre_caja_diario.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_fecha
date ld_fecha

this.move(1000,300)
dw_1.settransobject(sqlca)
ls_fecha = message.stringparm
ld_fecha = date(ls_fecha)
dw_1.retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),ld_fecha)
end event

type cb_1 from commandbutton within w_res_cierre_caja_diario
integer x = 265
integer y = 752
integer width = 352
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_res_cierre_caja_diario
integer x = 27
integer y = 28
integer width = 896
integer height = 680
string dataobject = "d_dddw_cajero1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


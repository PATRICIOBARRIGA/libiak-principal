HA$PBExportHeader$w_recurrentes.srw
$PBExportComments$Si.
forward
global type w_recurrentes from window
end type
type cb_2 from commandbutton within w_recurrentes
end type
type cb_1 from commandbutton within w_recurrentes
end type
type dw_1 from datawindow within w_recurrentes
end type
end forward

global type w_recurrentes from window
integer x = 1001
integer y = 1000
integer width = 2194
integer height = 1276
boolean titlebar = true
string title = "Comprobantes Recurrentes"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_recurrentes w_recurrentes

event open;datawindowchild ldwc_ctas
dw_1.SetTransObject(sqlca)
dw_1.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
end event

on w_recurrentes.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_recurrentes.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_recurrentes
integer x = 1865
integer y = 156
integer width = 293
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;Close(Parent)
end event

type cb_1 from commandbutton within w_recurrentes
integer x = 1865
integer y = 48
integer width = 293
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;/*Tomar los datos de la fila seleccionada
e insertar en el detalle*/
long ll_row
string ls_tipo


ll_row = dw_1.getrow()
If ll_row = 0 then return
ls_tipo = dw_1.GetitemString(ll_row,"ct_codigo")
closewithreturn(parent,ls_tipo)






end event

type dw_1 from datawindow within w_recurrentes
integer x = 18
integer y = 20
integer width = 1819
integer height = 1228
integer taborder = 10
string title = "none"
string dataobject = "d_recurrentes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


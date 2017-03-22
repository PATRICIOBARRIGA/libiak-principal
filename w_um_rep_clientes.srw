HA$PBExportHeader$w_um_rep_clientes.srw
$PBExportComments$Listados de clientes agrupados por Vendedor, tipo, clase.
forward
global type w_um_rep_clientes from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_um_rep_clientes
end type
type cbx_1 from checkbox within w_um_rep_clientes
end type
end forward

global type w_um_rep_clientes from w_sheet_1_dw_rep
integer x = 5
integer y = 240
integer width = 2944
integer height = 1444
string title = "Reporte de Clientes"
long backcolor = 81324524
st_1 st_1
cbx_1 cbx_1
end type
global w_um_rep_clientes w_um_rep_clientes

type variables

end variables

on w_um_rep_clientes.create
int iCurrent
call super::create
this.st_1=create st_1
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cbx_1
end on

on w_um_rep_clientes.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cbx_1)
end on

event open;this.ib_notautoretrieve = true
call super::open
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_um_rep_clientes
integer x = 5
integer y = 112
integer width = 2912
integer height = 1224
integer taborder = 20
string dataobject = "d_um_rep_clientes"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::retrieveend;call super::retrieveend;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_um_rep_clientes
integer y = 660
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_um_rep_clientes
integer x = 1051
integer y = 720
end type

type st_1 from statictext within w_um_rep_clientes
integer x = 32
integer y = 32
integer width = 434
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Listado de clientes:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_um_rep_clientes
integer x = 567
integer y = 24
integer width = 690
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ocultar cupo disponible"
end type

event clicked;if cbx_1.checked then 
dw_datos.object.t_disponible.visible = false
dw_datos.object.cupo_disponible.visible = false
dw_datos.object.asesor.x=768
dw_datos.object.asesor.width=960
else
dw_datos.object.t_disponible.visible = true
dw_datos.object.cupo_disponible.visible = true	
dw_datos.object.asesor.x=1202
dw_datos.object.asesor.width=526
end if
end event


HA$PBExportHeader$w_rep_ventas_x_item.srw
forward
global type w_rep_ventas_x_item from w_sheet_1_dw_rep
end type
type sle_1 from singlelineedit within w_rep_ventas_x_item
end type
type sle_2 from singlelineedit within w_rep_ventas_x_item
end type
type st_1 from statictext within w_rep_ventas_x_item
end type
type st_2 from statictext within w_rep_ventas_x_item
end type
type st_3 from statictext within w_rep_ventas_x_item
end type
end forward

global type w_rep_ventas_x_item from w_sheet_1_dw_rep
integer width = 3406
integer height = 2112
string title = "Items por factura"
boolean ib_notautoretrieve = true
sle_1 sle_1
sle_2 sle_2
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_rep_ventas_x_item w_rep_ventas_x_item

event ue_retrieve;String ls_estado[]
ls_estado[1] = '1'

dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_estado,Long(sle_1.text),long(sle_2.text))
end event

on w_rep_ventas_x_item.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.sle_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
end on

on w_rep_ventas_x_item.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ventas_x_item
integer y = 244
integer width = 3301
integer height = 1728
string dataobject = "d_rep_ventas_producto"
end type

event dw_datos::retrieveend;call super::retrieveend;this.modify("st_empresa.text  = '"+gs_empresa+"' st_sucursal.text  = '"+gs_su_nombre+"' st_grupo.text = '"+'Reporte de Items por factura'+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ventas_x_item
integer x = 1888
integer y = 1304
string dataobject = "d_rep_ventas_producto"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_ventas_x_item
integer x = 1906
integer y = 820
integer width = 814
integer height = 464
end type

type sle_1 from singlelineedit within w_rep_ventas_x_item
integer x = 439
integer y = 112
integer width = 402
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type sle_2 from singlelineedit within w_rep_ventas_x_item
integer x = 1198
integer y = 112
integer width = 402
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type st_1 from statictext within w_rep_ventas_x_item
integer x = 91
integer y = 120
integer width = 325
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
string text = "Factura Inicial:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_ventas_x_item
integer x = 882
integer y = 120
integer width = 315
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
string text = "Factura final:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rep_ventas_x_item
integer x = 91
integer y = 44
integer width = 649
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
string text = "Ingrese el rango de facturas."
boolean focusrectangle = false
end type


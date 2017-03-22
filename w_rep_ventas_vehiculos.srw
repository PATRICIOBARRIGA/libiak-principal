HA$PBExportHeader$w_rep_ventas_vehiculos.srw
forward
global type w_rep_ventas_vehiculos from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_ventas_vehiculos
end type
type em_2 from editmask within w_rep_ventas_vehiculos
end type
type st_1 from statictext within w_rep_ventas_vehiculos
end type
type st_2 from statictext within w_rep_ventas_vehiculos
end type
type st_3 from statictext within w_rep_ventas_vehiculos
end type
type st_4 from statictext within w_rep_ventas_vehiculos
end type
type ddlb_1 from dropdownlistbox within w_rep_ventas_vehiculos
end type
type st_5 from statictext within w_rep_ventas_vehiculos
end type
end forward

global type w_rep_ventas_vehiculos from w_sheet_1_dw_rep
integer width = 3822
integer height = 2480
string title = "Venta de Veh$$HEX1$$ed00$$ENDHEX$$culos"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
ddlb_1 ddlb_1
st_5 st_5
end type
global w_rep_ventas_vehiculos w_rep_ventas_vehiculos

type variables
integer ii_index
end variables

on w_rep_ventas_vehiculos.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.ddlb_1=create ddlb_1
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.st_5
end on

on w_rep_ventas_vehiculos.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.ddlb_1)
destroy(this.st_5)
end on

event ue_retrieve;date ld_ini,ld_fin

setpointer(hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if isnull(ld_ini) or isnull(ld_fin) then
		messageBox("Error","Ingrese la fecha")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if


if ld_ini > ld_fin then
		messageBox("Error","Rango de Fechas Incorrecto")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if

if ii_index = 3 then
	ii_index = 9
end if

if ii_index = 4 then
	ii_index = 10
end if

dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'"+&
					"st_rango.text = 'Desde: "+string(ld_ini,'dd/mm/yyyy')+"  Hasta: "+string(ld_fin,'dd/mm/yyyy')+"'")	
dw_datos.Retrieve(str_appgeninfo.sucursal,ii_index,ld_ini,ld_fin)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ventas_vehiculos
integer x = 23
integer y = 220
integer width = 3726
integer height = 2152
integer taborder = 40
string dataobject = "d_rep_ventas_vehiculos"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ventas_vehiculos
integer x = 46
integer y = 316
integer taborder = 0
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_ventas_vehiculos
integer x = 183
integer y = 412
integer width = 485
integer height = 192
integer taborder = 0
end type

type em_1 from editmask within w_rep_ventas_vehiculos
integer x = 242
integer y = 68
integer width = 306
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_ventas_vehiculos
integer x = 777
integer y = 68
integer width = 306
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_ventas_vehiculos
integer x = 59
integer y = 72
integer width = 169
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_ventas_vehiculos
integer x = 613
integer y = 72
integer width = 151
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rep_ventas_vehiculos
integer x = 242
integer y = 156
integer width = 293
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/aaaa]"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rep_ventas_vehiculos
integer x = 782
integer y = 156
integer width = 293
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/aaaa]"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_rep_ventas_vehiculos
integer x = 1431
integer y = 68
integer width = 763
integer height = 376
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean sorted = false
string item[] = {"Facturas FXM","Facturas POS","Devoluci$$HEX1$$f300$$ENDHEX$$n FXM","Devoluci$$HEX1$$f300$$ENDHEX$$n POS"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_index = index
end event

type st_5 from statictext within w_rep_ventas_vehiculos
integer x = 1285
integer y = 72
integer width = 137
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo:"
alignment alignment = center!
boolean focusrectangle = false
end type


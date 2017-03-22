HA$PBExportHeader$w_rep_control_de_entregas.srw
$PBExportComments$Si.
forward
global type w_rep_control_de_entregas from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_control_de_entregas
end type
type em_2 from editmask within w_rep_control_de_entregas
end type
type st_1 from statictext within w_rep_control_de_entregas
end type
type st_2 from statictext within w_rep_control_de_entregas
end type
end forward

global type w_rep_control_de_entregas from w_sheet_1_dw_rep
integer width = 3086
integer height = 1852
string title = "Gu$$HEX1$$ed00$$ENDHEX$$as de Transporte"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_rep_control_de_entregas w_rep_control_de_entregas

on w_rep_control_de_entregas.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_rep_control_de_entregas.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;Date ld_ini,ld_fin

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
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
dw_datos.retrieve(str_appgeninfo.sucursal,ld_ini,ld_fin)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_control_de_entregas
integer x = 18
integer y = 160
integer width = 3003
integer height = 1584
integer taborder = 30
string dataobject = "d_rep_control_de_entregas"
boolean border = true
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_control_de_entregas
integer x = 2560
integer y = 12
integer width = 155
integer height = 56
integer taborder = 0
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_control_de_entregas
integer x = 2162
integer y = 12
integer width = 155
integer height = 56
integer taborder = 0
end type

type em_1 from editmask within w_rep_control_de_entregas
integer x = 283
integer y = 28
integer width = 352
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_control_de_entregas
integer x = 855
integer y = 28
integer width = 352
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_control_de_entregas
integer x = 82
integer y = 36
integer width = 178
integer height = 52
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

type st_2 from statictext within w_rep_control_de_entregas
integer x = 667
integer y = 40
integer width = 165
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
string text = "Hasta:"
boolean focusrectangle = false
end type


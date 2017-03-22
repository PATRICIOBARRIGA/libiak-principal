HA$PBExportHeader$w_rep_antiguedad_cartera.srw
$PBExportComments$Si.
forward
global type w_rep_antiguedad_cartera from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_antiguedad_cartera
end type
type em_1 from editmask within w_rep_antiguedad_cartera
end type
end forward

global type w_rep_antiguedad_cartera from w_sheet_1_dw_rep
integer width = 2825
integer height = 1656
string title = "Reporte de Antiguedad de Cartera"
long backcolor = 67108864
st_1 st_1
em_1 em_1
end type
global w_rep_antiguedad_cartera w_rep_antiguedad_cartera

on w_rep_antiguedad_cartera.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_1
end on

on w_rep_antiguedad_cartera.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_1)
end on

event open;ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;Date ld_fecha


ld_fecha = date(em_1.text)

dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.retrieve(str_appgeninfo.empresa,ld_fecha)

return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_antiguedad_cartera
integer x = 32
integer y = 196
integer width = 2725
integer height = 1328
integer taborder = 20
string dataobject = "d_rep_cartera_antigua"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_antiguedad_cartera
integer x = 1563
integer y = 1000
integer width = 672
integer height = 436
integer taborder = 30
end type

type st_1 from statictext within w_rep_antiguedad_cartera
integer x = 73
integer y = 68
integer width = 357
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
string text = "Fecha de corte:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_rep_antiguedad_cartera
integer x = 494
integer y = 64
integer width = 315
integer height = 80
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
end type


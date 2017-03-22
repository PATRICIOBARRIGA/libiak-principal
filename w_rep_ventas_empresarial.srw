HA$PBExportHeader$w_rep_ventas_empresarial.srw
forward
global type w_rep_ventas_empresarial from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_ventas_empresarial
end type
type em_2 from editmask within w_rep_ventas_empresarial
end type
type st_1 from statictext within w_rep_ventas_empresarial
end type
type st_2 from statictext within w_rep_ventas_empresarial
end type
end forward

global type w_rep_ventas_empresarial from w_sheet_1_dw_rep
integer width = 2962
integer height = 1540
string title = "Ventas Netas Empresarial"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_rep_ventas_empresarial w_rep_ventas_empresarial

on w_rep_ventas_empresarial.create
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

on w_rep_ventas_empresarial.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.retrieve(ld_ini,ld_fin)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ventas_empresarial
integer y = 140
integer width = 2862
integer height = 1280
integer taborder = 30
string dataobject = "d_rep_cross_ventas_netas_x_empresa"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ventas_empresarial
integer x = 1536
integer y = 536
integer taborder = 0
string dataobject = "d_rep_cross_ventas_netas_x_empresa"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_ventas_empresarial
integer x = 558
integer y = 548
integer width = 494
integer height = 224
integer taborder = 0
end type

type em_1 from editmask within w_rep_ventas_empresarial
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

type em_2 from editmask within w_rep_ventas_empresarial
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

type st_1 from statictext within w_rep_ventas_empresarial
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

type st_2 from statictext within w_rep_ventas_empresarial
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


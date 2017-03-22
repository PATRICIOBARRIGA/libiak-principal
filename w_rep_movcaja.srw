HA$PBExportHeader$w_rep_movcaja.srw
forward
global type w_rep_movcaja from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_movcaja
end type
type em_2 from editmask within w_rep_movcaja
end type
type st_1 from statictext within w_rep_movcaja
end type
type st_2 from statictext within w_rep_movcaja
end type
end forward

global type w_rep_movcaja from w_sheet_1_dw_rep
integer width = 2903
integer height = 1488
string title = "Movimientos de caja"
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_rep_movcaja w_rep_movcaja

on w_rep_movcaja.create
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

on w_rep_movcaja.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;Date ld_ini,ld_fin

ld_ini  = date(em_1.text)
ld_fin  = date(em_2.text)

dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_ini,ld_fin)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_movcaja
integer x = 23
integer y = 144
integer width = 2839
integer height = 1232
string dataobject = "d_rep_movcaja"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_movcaja
integer y = 132
string dataobject = "d_rep_movcaja"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_movcaja
end type

type em_1 from editmask within w_rep_movcaja
integer x = 338
integer y = 24
integer width = 357
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_movcaja
integer x = 960
integer y = 24
integer width = 347
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_movcaja
integer x = 105
integer y = 32
integer width = 210
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_movcaja
integer x = 727
integer y = 36
integer width = 229
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
alignment alignment = center!
boolean focusrectangle = false
end type


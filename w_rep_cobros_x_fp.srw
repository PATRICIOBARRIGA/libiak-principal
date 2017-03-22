HA$PBExportHeader$w_rep_cobros_x_fp.srw
$PBExportComments$Si.
forward
global type w_rep_cobros_x_fp from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_cobros_x_fp
end type
type em_2 from editmask within w_rep_cobros_x_fp
end type
type st_1 from statictext within w_rep_cobros_x_fp
end type
type st_2 from statictext within w_rep_cobros_x_fp
end type
end forward

global type w_rep_cobros_x_fp from w_sheet_1_dw_rep
integer width = 2469
integer height = 1352
string title = "Cobro de Recaps por forma de pago"
long backcolor = 81324524
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_rep_cobros_x_fp w_rep_cobros_x_fp

on w_rep_cobros_x_fp.create
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

on w_rep_cobros_x_fp.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)


dw_datos.retrieve(str_appgeninfo.empresa,ld_ini,ld_fin)
end event

event open;call super::open;f_recupera_empresa(dw_datos,"cb_cabcobt_cn_codigo_1")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cobros_x_fp
integer x = 18
integer y = 172
integer width = 2400
integer height = 1040
integer taborder = 30
string dataobject = "d_rep_cobros_x_fp"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cobros_x_fp
integer x = 41
integer y = 564
integer taborder = 40
string dataobject = "d_rep_cobros_x_fp"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_cobros_x_fp
end type

type em_1 from editmask within w_rep_cobros_x_fp
integer x = 325
integer y = 40
integer width = 306
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_cobros_x_fp
integer x = 891
integer y = 44
integer width = 302
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_cobros_x_fp
integer x = 128
integer y = 48
integer width = 183
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
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_cobros_x_fp
integer x = 718
integer y = 52
integer width = 169
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


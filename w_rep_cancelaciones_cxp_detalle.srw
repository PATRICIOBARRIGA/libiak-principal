HA$PBExportHeader$w_rep_cancelaciones_cxp_detalle.srw
$PBExportComments$Si.
forward
global type w_rep_cancelaciones_cxp_detalle from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_cancelaciones_cxp_detalle
end type
type em_2 from editmask within w_rep_cancelaciones_cxp_detalle
end type
type st_1 from statictext within w_rep_cancelaciones_cxp_detalle
end type
type st_2 from statictext within w_rep_cancelaciones_cxp_detalle
end type
end forward

global type w_rep_cancelaciones_cxp_detalle from w_sheet_1_dw_rep
integer width = 2889
integer height = 1816
string title = "Detalle de cancelaciones"
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_rep_cancelaciones_cxp_detalle w_rep_cancelaciones_cxp_detalle

event open;ib_notautoretrieve = true
em_1.text = string(today())
em_2.text = string(today())
call super::open
end event

event ue_retrieve;Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_ini,ld_fin)
end event

on w_rep_cancelaciones_cxp_detalle.create
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

on w_rep_cancelaciones_cxp_detalle.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cancelaciones_cxp_detalle
integer y = 172
integer width = 2784
integer height = 1508
string dataobject = "d_fp_cancelaciones_cxp"
end type

event dw_datos::retrieveend;call super::retrieveend;this.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cancelaciones_cxp_detalle
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_cancelaciones_cxp_detalle
end type

type em_1 from editmask within w_rep_cancelaciones_cxp_detalle
integer x = 334
integer y = 56
integer width = 343
integer height = 72
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
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_cancelaciones_cxp_detalle
integer x = 960
integer y = 56
integer width = 343
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
end type

type st_1 from statictext within w_rep_cancelaciones_cxp_detalle
integer x = 64
integer y = 64
integer width = 265
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
string text = "Desde :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_cancelaciones_cxp_detalle
integer x = 722
integer y = 64
integer width = 238
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
string text = "Hasta :"
alignment alignment = center!
boolean focusrectangle = false
end type


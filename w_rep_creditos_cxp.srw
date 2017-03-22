HA$PBExportHeader$w_rep_creditos_cxp.srw
$PBExportComments$Si. Reporte de mov. de creditos en cxp, Facturas de servicios, Facturas de compra, etc.Vale
forward
global type w_rep_creditos_cxp from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_creditos_cxp
end type
type em_2 from editmask within w_rep_creditos_cxp
end type
type st_1 from statictext within w_rep_creditos_cxp
end type
type st_2 from statictext within w_rep_creditos_cxp
end type
type dw_1 from datawindow within w_rep_creditos_cxp
end type
type st_3 from statictext within w_rep_creditos_cxp
end type
end forward

global type w_rep_creditos_cxp from w_sheet_1_dw_rep
integer width = 2176
integer height = 1224
string title = "Movimientos de Cr$$HEX1$$e900$$ENDHEX$$dito"
long backcolor = 81324524
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
dw_1 dw_1
st_3 st_3
end type
global w_rep_creditos_cxp w_rep_creditos_cxp

on w_rep_creditos_cxp.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_3
end on

on w_rep_creditos_cxp.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.st_3)
end on

event ue_retrieve;date ld_ini,ld_fin
string ls_tvcodigo

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
ls_tvcodigo = dw_1.getitemstring(1,"tv_codigo")


dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tvcodigo,ld_ini,ld_fin)

end event

event open;call super::open;dw_1.insertrow(0)
f_recupera_empresa(dw_1,"tv_codigo")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_creditos_cxp
integer x = 9
integer y = 196
integer width = 2130
integer height = 892
integer taborder = 40
string dataobject = "d_rep_factura_servicios"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+upper(gs_empresa)+"'st_sucursal.text = '"+upper(gs_su_nombre)+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_creditos_cxp
integer x = 37
integer y = 776
integer width = 503
integer height = 212
integer taborder = 50
end type

type em_1 from editmask within w_rep_creditos_cxp
integer x = 1285
integer y = 72
integer width = 297
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
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_creditos_cxp
integer x = 1783
integer y = 72
integer width = 297
integer height = 88
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_creditos_cxp
integer x = 1106
integer y = 88
integer width = 178
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

type st_2 from statictext within w_rep_creditos_cxp
integer x = 1623
integer y = 88
integer width = 155
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

type dw_1 from datawindow within w_rep_creditos_cxp
integer x = 32
integer y = 72
integer width = 1024
integer height = 88
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_tipo_mov_cre_cxp"
boolean border = false
boolean livescroll = true
end type

type st_3 from statictext within w_rep_creditos_cxp
integer x = 41
integer y = 16
integer width = 146
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
string text = "Tipo"
boolean focusrectangle = false
end type


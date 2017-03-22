HA$PBExportHeader$w_rep_compras_detalladas.srw
$PBExportComments$Si.
forward
global type w_rep_compras_detalladas from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_compras_detalladas
end type
type em_2 from editmask within w_rep_compras_detalladas
end type
type st_2 from statictext within w_rep_compras_detalladas
end type
type st_3 from statictext within w_rep_compras_detalladas
end type
type dw_1 from datawindow within w_rep_compras_detalladas
end type
end forward

global type w_rep_compras_detalladas from w_sheet_1_dw_rep
integer width = 2341
integer height = 1324
string title = "Compras detalladas por proveedor"
long backcolor = 81324524
em_1 em_1
em_2 em_2
st_2 st_2
st_3 st_3
dw_1 dw_1
end type
global w_rep_compras_detalladas w_rep_compras_detalladas

event open;datawindowchild  ldwc_prov
ib_notautoretrieve = true

dw_1.insertrow(0)
dw_1.getchild("proveedor",ldwc_prov)
ldwc_prov.settransobject(sqlca)
ldwc_prov.retrieve(str_appgeninfo.empresa)
call super:: open
end event

event ue_retrieve;Date ld_ini,ld_fin
String ls_codant,ls_pvcodigo

ls_pvcodigo = dw_1.getitemstring(1,"proveedor")
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.retrieve('3',str_appgeninfo.empresa,ld_ini,ld_fin,ls_pvcodigo)
end event

on w_rep_compras_detalladas.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_1
end on

on w_rep_compras_detalladas.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
end on

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 2*dw_datos.y +200)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_compras_detalladas
integer x = 27
integer y = 280
integer width = 2249
integer height = 996
integer taborder = 40
string dataobject = "d_rep_compras_detalladas_x_prov"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_compras_detalladas
integer x = 142
integer y = 828
integer width = 599
integer height = 280
integer taborder = 50
end type

type em_1 from editmask within w_rep_compras_detalladas
integer x = 370
integer y = 176
integer width = 343
integer height = 76
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

type em_2 from editmask within w_rep_compras_detalladas
integer x = 933
integer y = 172
integer width = 343
integer height = 80
integer taborder = 30
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

type st_2 from statictext within w_rep_compras_detalladas
integer x = 69
integer y = 188
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

type st_3 from statictext within w_rep_compras_detalladas
integer x = 754
integer y = 184
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

type dw_1 from datawindow within w_rep_compras_detalladas
integer x = 27
integer y = 36
integer width = 1541
integer height = 116
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_proveedor"
boolean border = false
boolean livescroll = true
end type


HA$PBExportHeader$w_rep_resultados_integrales_niff.srw
$PBExportComments$Balances NIFF, de resultados integrales
forward
global type w_rep_resultados_integrales_niff from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_resultados_integrales_niff
end type
type em_2 from editmask within w_rep_resultados_integrales_niff
end type
type st_1 from statictext within w_rep_resultados_integrales_niff
end type
type st_2 from statictext within w_rep_resultados_integrales_niff
end type
type rb_1 from radiobutton within w_rep_resultados_integrales_niff
end type
type rb_2 from radiobutton within w_rep_resultados_integrales_niff
end type
end forward

global type w_rep_resultados_integrales_niff from w_sheet_1_dw_rep
integer width = 3589
integer height = 1560
string title = "Balance de Situaci$$HEX1$$f300$$ENDHEX$$n Financiera Consolidado"
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_resultados_integrales_niff w_rep_resultados_integrales_niff

on w_rep_resultados_integrales_niff.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
end on

on w_rep_resultados_integrales_niff.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if rb_1.checked then
	dw_datos.DataObject = 'd_balance_resultados_integrales_niffs'
elseif rb_2.checked then
	dw_datos.DataObject = 'd_balance_resultados_integrales_comparativo_niffs'
end if
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ld_ini,ld_fin)
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
dw_datos.modify("st_empresa.text= '"+gs_empresa+"'")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_resultados_integrales_niff
integer x = 0
integer y = 216
integer width = 3543
integer height = 1236
string dataobject = "d_balance_consolidado_pyg_niffs"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_resultados_integrales_niff
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_resultados_integrales_niff
end type

type em_1 from editmask within w_rep_resultados_integrales_niff
integer x = 293
integer y = 36
integer width = 347
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

type em_2 from editmask within w_rep_resultados_integrales_niff
integer x = 974
integer y = 36
integer width = 347
integer height = 72
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

type st_1 from statictext within w_rep_resultados_integrales_niff
integer x = 55
integer y = 44
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_resultados_integrales_niff
integer x = 745
integer y = 40
integer width = 224
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

type rb_1 from radiobutton within w_rep_resultados_integrales_niff
integer x = 1518
integer y = 32
integer width = 338
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Estandar"
boolean checked = true
end type

type rb_2 from radiobutton within w_rep_resultados_integrales_niff
integer x = 1518
integer y = 116
integer width = 503
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Comparativo"
end type


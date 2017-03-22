HA$PBExportHeader$w_rep_comisiones_x_asesor_cedane.srw
$PBExportComments$Si.En produccion comisiones por asesor parametrizada
forward
global type w_rep_comisiones_x_asesor_cedane from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_rep_comisiones_x_asesor_cedane
end type
type rb_2 from radiobutton within w_rep_comisiones_x_asesor_cedane
end type
type st_1 from statictext within w_rep_comisiones_x_asesor_cedane
end type
type cbx_1 from checkbox within w_rep_comisiones_x_asesor_cedane
end type
type st_2 from statictext within w_rep_comisiones_x_asesor_cedane
end type
type cbx_3 from checkbox within w_rep_comisiones_x_asesor_cedane
end type
type cbx_4 from checkbox within w_rep_comisiones_x_asesor_cedane
end type
type cbx_5 from checkbox within w_rep_comisiones_x_asesor_cedane
end type
type em_1 from editmask within w_rep_comisiones_x_asesor_cedane
end type
type em_2 from editmask within w_rep_comisiones_x_asesor_cedane
end type
type st_3 from statictext within w_rep_comisiones_x_asesor_cedane
end type
type st_4 from statictext within w_rep_comisiones_x_asesor_cedane
end type
type cbx_2 from checkbox within w_rep_comisiones_x_asesor_cedane
end type
end forward

global type w_rep_comisiones_x_asesor_cedane from w_sheet_1_dw_rep
integer width = 4366
integer height = 1696
string title = "Comisiones por Asesor"
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
rb_1 rb_1
rb_2 rb_2
st_1 st_1
cbx_1 cbx_1
st_2 st_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
em_1 em_1
em_2 em_2
st_3 st_3
st_4 st_4
cbx_2 cbx_2
end type
global w_rep_comisiones_x_asesor_cedane w_rep_comisiones_x_asesor_cedane

on w_rep_comisiones_x_asesor_cedane.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_1=create st_1
this.cbx_1=create cbx_1
this.st_2=create st_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.em_1=create em_1
this.em_2=create em_2
this.st_3=create st_3
this.st_4=create st_4
this.cbx_2=create cbx_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cbx_3
this.Control[iCurrent+7]=this.cbx_4
this.Control[iCurrent+8]=this.cbx_5
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.em_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.cbx_2
end on

on w_rep_comisiones_x_asesor_cedane.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_1)
destroy(this.cbx_1)
destroy(this.st_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cbx_2)
end on

event ue_retrieve;Date ld_desde,ld_hasta

ld_desde = date(em_1.text)
ld_hasta = date(em_2.text)
if cbx_2.checked then
	dw_datos.DataObject = 'd_rep_cobros_x_asesor_cedane_comisiones'
	dw_datos.SetTransObject(sqlca)
     dw_datos.Retrieve()
else
	dw_datos.DataObject = 'd_rep_cobros_x_asesor_cedane'
	dw_datos.SetTransObject(sqlca)
	dw_datos.retrieve(ld_desde,ld_hasta)
end if
dw_datos.modify("datawindow.print.preview.zoom=75~t" +"datawindow.print.preview=yes")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_comisiones_x_asesor_cedane
integer x = 0
integer y = 136
integer width = 4315
integer height = 1448
integer taborder = 30
string dataobject = "d_rep_cobros_x_asesor_cedane"
end type

event dw_datos::retrievestart;call super::retrievestart;this.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_comisiones_x_asesor_cedane
integer y = 724
integer taborder = 40
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_comisiones_x_asesor_cedane
integer taborder = 50
end type

type rb_1 from radiobutton within w_rep_comisiones_x_asesor_cedane
boolean visible = false
integer x = 2208
integer y = 40
integer width = 352
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
string text = "Contado"
end type

type rb_2 from radiobutton within w_rep_comisiones_x_asesor_cedane
boolean visible = false
integer x = 2213
integer y = 112
integer width = 352
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
string text = "Cr$$HEX1$$e900$$ENDHEX$$dito"
end type

type st_1 from statictext within w_rep_comisiones_x_asesor_cedane
integer x = 46
integer y = 36
integer width = 571
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Recuperaci$$HEX1$$f300$$ENDHEX$$n de cartera:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_rep_comisiones_x_asesor_cedane
boolean visible = false
integer x = 334
integer y = 36
integer width = 434
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
string text = "Veh$$HEX1$$ed00$$ENDHEX$$culos"
end type

type st_2 from statictext within w_rep_comisiones_x_asesor_cedane
boolean visible = false
integer x = 1819
integer y = 44
integer width = 352
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Forma de pago:"
boolean focusrectangle = false
end type

type cbx_3 from checkbox within w_rep_comisiones_x_asesor_cedane
boolean visible = false
integer x = 1019
integer y = 112
integer width = 562
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
string text = "Calcular Comisiones"
boolean checked = true
end type

type cbx_4 from checkbox within w_rep_comisiones_x_asesor_cedane
boolean visible = false
integer x = 1056
integer y = 116
integer width = 626
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
string text = "Recuperaci$$HEX1$$f300$$ENDHEX$$n cartera"
end type

type cbx_5 from checkbox within w_rep_comisiones_x_asesor_cedane
boolean visible = false
integer x = 329
integer y = 200
integer width = 777
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
string text = "Notas de D$$HEX1$$e900$$ENDHEX$$bito por Anticipo:"
end type

type em_1 from editmask within w_rep_comisiones_x_asesor_cedane
integer x = 1349
integer y = 28
integer width = 480
integer height = 76
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
boolean spin = true
end type

type em_2 from editmask within w_rep_comisiones_x_asesor_cedane
integer x = 2162
integer y = 28
integer width = 480
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
boolean spin = true
end type

type st_3 from statictext within w_rep_comisiones_x_asesor_cedane
integer x = 731
integer y = 36
integer width = 594
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
string text = "Cobros ingresados desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rep_comisiones_x_asesor_cedane
integer x = 1888
integer y = 36
integer width = 256
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
string text = "hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_2 from checkbox within w_rep_comisiones_x_asesor_cedane
integer x = 3077
integer y = 32
integer width = 585
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
string text = "Ver comisiones"
end type


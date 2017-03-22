HA$PBExportHeader$w_rep_resumen_debitos.srw
$PBExportComments$Si.
forward
global type w_rep_resumen_debitos from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_resumen_debitos
end type
type em_2 from editmask within w_rep_resumen_debitos
end type
type st_1 from statictext within w_rep_resumen_debitos
end type
type st_2 from statictext within w_rep_resumen_debitos
end type
type rb_1 from radiobutton within w_rep_resumen_debitos
end type
type rb_2 from radiobutton within w_rep_resumen_debitos
end type
end forward

global type w_rep_resumen_debitos from w_sheet_1_dw_rep
integer width = 2734
integer height = 1736
string title = "Resumen de d$$HEX1$$e900$$ENDHEX$$bitos"
long backcolor = 67108864
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_resumen_debitos w_rep_resumen_debitos

event open;ib_notautoretrieve = true
call super::open
end event

on w_rep_resumen_debitos.create
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

on w_rep_resumen_debitos.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;Date ld_ini,ld_fin

ld_ini  = date(em_1.text)
ld_fin = date(em_2.text)


dw_datos.retrieve(ld_ini,ld_fin)

if rb_1.checked then
dw_datos.DataObject = 'd_rep_cartera'	
dw_datos.SetTransobject(SQLCA)
dw_datos.Retrieve(str_appgeninfo.empresa,ld_ini,ld_fin)
end if 

if rb_2.checked then
dw_datos.DataObject = 'd_rep_resumen_debitos_cartera'
dw_datos.SetTransObject(SQLCA)
dw_datos.Retrieve(ld_ini,ld_fin)
end if


dw_datos.modify("st_empresa.text = '"+gs_empresa+ "'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
								"datawindow.print.preview=yes")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_resumen_debitos
integer x = 0
integer y = 176
integer width = 2688
integer height = 1412
string dataobject = "d_rep_resumen_debitos_cartera"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_resumen_debitos
integer x = 1536
integer y = 644
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_resumen_debitos
end type

type em_1 from editmask within w_rep_resumen_debitos
integer x = 270
integer y = 48
integer width = 343
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
end type

type em_2 from editmask within w_rep_resumen_debitos
integer x = 933
integer y = 48
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_resumen_debitos
integer x = 41
integer y = 56
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_resumen_debitos
integer x = 718
integer y = 56
integer width = 206
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

type rb_1 from radiobutton within w_rep_resumen_debitos
integer x = 1554
integer y = 24
integer width = 466
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
string text = "Resumen cartera"
end type

type rb_2 from radiobutton within w_rep_resumen_debitos
integer x = 1554
integer y = 84
integer width = 498
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
string text = "D$$HEX1$$e900$$ENDHEX$$bito por sucursal"
end type


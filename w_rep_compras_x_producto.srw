HA$PBExportHeader$w_rep_compras_x_producto.srw
$PBExportComments$Si.
forward
global type w_rep_compras_x_producto from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_compras_x_producto
end type
type em_2 from editmask within w_rep_compras_x_producto
end type
type st_2 from statictext within w_rep_compras_x_producto
end type
type st_3 from statictext within w_rep_compras_x_producto
end type
type sle_1 from singlelineedit within w_rep_compras_x_producto
end type
type st_1 from statictext within w_rep_compras_x_producto
end type
type rb_1 from radiobutton within w_rep_compras_x_producto
end type
type rb_2 from radiobutton within w_rep_compras_x_producto
end type
end forward

global type w_rep_compras_x_producto from w_sheet_1_dw_rep
integer width = 2336
integer height = 1428
string title = "Compras por producto"
long backcolor = 81324524
em_1 em_1
em_2 em_2
st_2 st_2
st_3 st_3
sle_1 sle_1
st_1 st_1
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_compras_x_producto w_rep_compras_x_producto

event open;ib_notautoretrieve = true
call super:: open
end event

event ue_retrieve;Date ld_ini,ld_fin
String ls_codant,ls_pvcodigo

ls_codant = sle_1.text
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")

if rb_1.checked then dw_datos.dataobject = 'd_rep_compras_x_producto'
if rb_2.checked then dw_datos.dataobject = 'd_rep_compras_x_producto2'

dw_datos.settransobject(sqlca)
dw_datos.retrieve('3',str_appgeninfo.empresa,ld_ini,ld_fin,ls_codant)


end event

on w_rep_compras_x_producto.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_3=create st_3
this.sle_1=create sle_1
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
end on

on w_rep_compras_x_producto.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 2*dw_datos.y + 200)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_compras_x_producto
integer x = 27
integer y = 240
integer width = 2249
integer height = 1036
integer taborder = 40
string dataobject = "d_rep_compras_x_producto"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_compras_x_producto
integer x = 1486
integer y = 956
integer width = 599
integer height = 280
integer taborder = 50
end type

type em_1 from editmask within w_rep_compras_x_producto
integer x = 1253
integer y = 44
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_compras_x_producto
integer x = 1815
integer y = 40
integer width = 343
integer height = 80
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

type st_2 from statictext within w_rep_compras_x_producto
integer x = 1038
integer y = 52
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

type st_3 from statictext within w_rep_compras_x_producto
integer x = 1637
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

type sle_1 from singlelineedit within w_rep_compras_x_producto
integer x = 498
integer y = 144
integer width = 1664
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
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rep_compras_x_producto
integer x = 78
integer y = 144
integer width = 398
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
string text = "C$$HEX1$$f300$$ENDHEX$$digo / Nombre :"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_compras_x_producto
integer x = 55
integer y = 44
integer width = 343
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
string text = "C$$HEX1$$f300$$ENDHEX$$digo"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_rep_compras_x_producto
integer x = 494
integer y = 44
integer width = 366
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
string text = "Nombre"
borderstyle borderstyle = stylelowered!
end type


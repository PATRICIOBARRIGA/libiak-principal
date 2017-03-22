HA$PBExportHeader$w_rep_resumen_mensual_compras_x_item.srw
$PBExportComments$Si.Resumen mensual de compras de un producto por proveedor
forward
global type w_rep_resumen_mensual_compras_x_item from w_sheet_1_dw_rep
end type
type sle_1 from singlelineedit within w_rep_resumen_mensual_compras_x_item
end type
type st_1 from statictext within w_rep_resumen_mensual_compras_x_item
end type
type em_1 from editmask within w_rep_resumen_mensual_compras_x_item
end type
type em_2 from editmask within w_rep_resumen_mensual_compras_x_item
end type
type st_2 from statictext within w_rep_resumen_mensual_compras_x_item
end type
type st_3 from statictext within w_rep_resumen_mensual_compras_x_item
end type
type rb_1 from radiobutton within w_rep_resumen_mensual_compras_x_item
end type
type rb_2 from radiobutton within w_rep_resumen_mensual_compras_x_item
end type
type rb_3 from radiobutton within w_rep_resumen_mensual_compras_x_item
end type
end forward

global type w_rep_resumen_mensual_compras_x_item from w_sheet_1_dw_rep
integer width = 2889
integer height = 1952
string title = "Resumen de compras mensual"
long backcolor = 81324524
sle_1 sle_1
st_1 st_1
em_1 em_1
em_2 em_2
st_2 st_2
st_3 st_3
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
end type
global w_rep_resumen_mensual_compras_x_item w_rep_resumen_mensual_compras_x_item

on w_rep_resumen_mensual_compras_x_item.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_3=create st_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.rb_3
end on

on w_rep_resumen_mensual_compras_x_item.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
end on

event open;ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;String ls_codant,ls_mes
date ld_ini,ld_fin
integer i
decimal lc_venta

ls_codant = sle_1.text
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)


/* por Item*/
if rb_1.checked then
dw_datos.dataobject = 'd_rep_resumen_compras_graph'
dw_datos.settransobject(sqlca)
dw_datos.retrieve('3',str_appgeninfo.empresa,ld_ini,ld_fin,ls_codant)
end if

/* De todos los items*/
if rb_2.checked then
dw_datos.dataobject = 'd_rep_resumen_compras_graph2'
dw_datos.settransobject(sqlca)
dw_datos.retrieve('3',str_appgeninfo.empresa,ld_ini,ld_fin)
end if

if rb_3.checked then
dw_datos.dataobject = 'd_rep_resumen_compras_graph3'
dw_datos.settransobject(sqlca)
dw_datos.retrieve('3',str_appgeninfo.empresa,ld_ini,ld_fin)
end if
end event

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 2*dw_datos.y + 200)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_resumen_mensual_compras_x_item
integer x = 14
integer y = 244
integer width = 2821
integer height = 1560
integer taborder = 50
string dataobject = "d_rep_resumen_compras_graph"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_resumen_mensual_compras_x_item
integer x = 142
integer y = 1128
integer width = 1083
integer height = 564
integer taborder = 40
string dataobject = "d_rep_resumen_compras_x_item"
end type

type sle_1 from singlelineedit within w_rep_resumen_mensual_compras_x_item
integer x = 361
integer y = 124
integer width = 782
integer height = 84
integer taborder = 10
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

type st_1 from statictext within w_rep_resumen_mensual_compras_x_item
integer x = 123
integer y = 136
integer width = 233
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
string text = "Producto:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_rep_resumen_mensual_compras_x_item
integer x = 1458
integer y = 124
integer width = 343
integer height = 84
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

type em_2 from editmask within w_rep_resumen_mensual_compras_x_item
integer x = 2034
integer y = 124
integer width = 343
integer height = 84
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

type st_2 from statictext within w_rep_resumen_mensual_compras_x_item
integer x = 1271
integer y = 136
integer width = 187
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

type st_3 from statictext within w_rep_resumen_mensual_compras_x_item
integer x = 1833
integer y = 136
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
string text = "Hasta :"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_resumen_mensual_compras_x_item
integer x = 123
integer y = 36
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
string text = "Por Item"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_rep_resumen_mensual_compras_x_item
integer x = 626
integer y = 36
integer width = 480
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
string text = "Todos los items"
borderstyle borderstyle = stylelowered!
end type

type rb_3 from radiobutton within w_rep_resumen_mensual_compras_x_item
integer x = 1211
integer y = 32
integer width = 347
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Acumulado"
borderstyle borderstyle = stylelowered!
end type


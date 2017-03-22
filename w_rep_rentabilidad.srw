HA$PBExportHeader$w_rep_rentabilidad.srw
$PBExportComments$Si.Rentabilidad total sin importar ventas
forward
global type w_rep_rentabilidad from w_sheet_1_dw_rep
end type
type cbx_1 from checkbox within w_rep_rentabilidad
end type
type rb_1 from radiobutton within w_rep_rentabilidad
end type
type rb_2 from radiobutton within w_rep_rentabilidad
end type
type cbx_2 from checkbox within w_rep_rentabilidad
end type
type rb_3 from radiobutton within w_rep_rentabilidad
end type
type st_2 from statictext within w_rep_rentabilidad
end type
type em_1 from editmask within w_rep_rentabilidad
end type
type st_3 from statictext within w_rep_rentabilidad
end type
type em_2 from editmask within w_rep_rentabilidad
end type
type st_1 from statictext within w_rep_rentabilidad
end type
type rr_1 from roundrectangle within w_rep_rentabilidad
end type
type rr_2 from roundrectangle within w_rep_rentabilidad
end type
type dw_v_vs_c from datawindow within w_rep_rentabilidad
end type
type dw_linea from datawindow within w_rep_rentabilidad
end type
type dw_item from datawindow within w_rep_rentabilidad
end type
end forward

global type w_rep_rentabilidad from w_sheet_1_dw_rep
integer width = 3963
integer height = 2800
string title = "Rentabilidad por cliente"
long backcolor = 67108864
boolean ib_notautoretrieve = true
cbx_1 cbx_1
rb_1 rb_1
rb_2 rb_2
cbx_2 cbx_2
rb_3 rb_3
st_2 st_2
em_1 em_1
st_3 st_3
em_2 em_2
st_1 st_1
rr_1 rr_1
rr_2 rr_2
dw_v_vs_c dw_v_vs_c
dw_linea dw_linea
dw_item dw_item
end type
global w_rep_rentabilidad w_rep_rentabilidad

on w_rep_rentabilidad.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_2=create cbx_2
this.rb_3=create rb_3
this.st_2=create st_2
this.em_1=create em_1
this.st_3=create st_3
this.em_2=create em_2
this.st_1=create st_1
this.rr_1=create rr_1
this.rr_2=create rr_2
this.dw_v_vs_c=create dw_v_vs_c
this.dw_linea=create dw_linea
this.dw_item=create dw_item
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.cbx_2
this.Control[iCurrent+5]=this.rb_3
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_1
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.rr_1
this.Control[iCurrent+12]=this.rr_2
this.Control[iCurrent+13]=this.dw_v_vs_c
this.Control[iCurrent+14]=this.dw_linea
this.Control[iCurrent+15]=this.dw_item
end on

on w_rep_rentabilidad.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_2)
destroy(this.rb_3)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.rr_1)
destroy(this.rr_2)
destroy(this.dw_v_vs_c)
destroy(this.dw_linea)
destroy(this.dw_item)
end on

event open;call super::open;gnv_help.of_register(This)
Setpointer(Hourglass!)
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=no")

dw_linea.SetTransObject(sqlca)

em_2.visible = false
st_3.visible = false
em_1.visible = false
st_2.visible = false 
dw_v_vs_c.visible = false

dw_v_vs_c.SetTransObject(sqlca)
f_recupera_empresa(dw_v_vs_c,"in_item_cl_codigo")
//f_recupera_empresa(dw_v_vs_c,"in_item_cl_codigo_1")






end event

event close;call super::close;gnv_help.of_unregister(This)
end event

event ue_retrieve;date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

Setpointer(hourglass!)
//call super::ue_retrieve


w_marco.Setmicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n....espere por favor")

if rb_1.checked then
dw_datos.DataObject = 'd_rentabilidad_items'
end if
if rb_2.checked then
dw_datos.DataObject = 'd_rentabilidad_items_x_linea_y_cliente'	
end if
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve()

if rb_3.checked then
dw_datos.visible = false
dw_v_vs_c.visible = true
dw_v_vs_c.retrieve(ld_ini,ld_fin)
end if

w_marco.Setmicrohelp("Listo....")
Setpointer(Arrow!)



end event

event resize;call super::resize;dw_linea.resize(this.workSpaceWidth() - 2*dw_linea.x, this.workSpaceHeight() - 2*dw_linea.y)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_rentabilidad
integer x = 37
integer y = 224
integer width = 3877
integer height = 2464
string dataobject = "d_rentabilidad_items"
end type

event dw_datos::doubleclicked;call super::doubleclicked;String ls_pepa

ls_pepa = dw_datos.object.in_item_it_codigo[row]
dw_item.retrieve(ls_pepa)
dw_item.Show()
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_rentabilidad
integer x = 146
integer y = 1828
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_rentabilidad
integer x = 229
integer y = 1964
end type

type cbx_1 from checkbox within w_rep_rentabilidad
integer x = 1454
integer y = 40
integer width = 384
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
string text = "Ver gr$$HEX1$$e100$$ENDHEX$$fico"
boolean checked = true
end type

event clicked;if rb_1.checked then
	if this.checked then
	dw_datos.Object.gr_1.visible = true
     else
	dw_datos.Object.gr_1.visible = false
     end if	
elseif	rb_2.checked then
	if this.checked then
	dw_datos.Object.gr_1.visible = true
	dw_datos.Object.gr_2.visible = true
	else
	dw_datos.Object.gr_1.visible = false
	dw_datos.Object.gr_2.visible = false
     end if
end if

end event

type rb_1 from radiobutton within w_rep_rentabilidad
integer x = 759
integer y = 32
integer width = 603
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
string text = "Rentabilidad por item"
end type

type rb_2 from radiobutton within w_rep_rentabilidad
integer x = 759
integer y = 104
integer width = 571
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
string text = "Rentabilidad por l$$HEX1$$ed00$$ENDHEX$$nea"
end type

type cbx_2 from checkbox within w_rep_rentabilidad
integer x = 1454
integer y = 108
integer width = 393
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
string text = "Ver detalle"
end type

event clicked;if rb_2.checked then
	if this.checked then
 	   dw_datos.Object.DataWindow.Detail.Height = 64
	else
	   dw_datos.Object.DataWindow.Detail.Height = 0	
	end if
end if
end event

type rb_3 from radiobutton within w_rep_rentabilidad
integer x = 1993
integer y = 28
integer width = 686
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
string text = "Relacion Costo vs Ventas"
end type

event clicked;if rb_3.enabled = true then
	em_2.visible = true
	st_3.visible = true
	em_1.visible = true
	st_2.visible = true
//	dw_v_vs_c.visible = true
else
	em_2.visible = false
	st_3.visible = false
	em_1.visible = false
	st_2.visible = false
//	dw_v_vs_c.visible = false
end if



end event

type st_2 from statictext within w_rep_rentabilidad
integer x = 2007
integer y = 120
integer width = 219
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
string text = "Fecha Ini:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_rep_rentabilidad
integer x = 2226
integer y = 112
integer width = 311
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

type st_3 from statictext within w_rep_rentabilidad
integer x = 2610
integer y = 120
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
string text = "Fecha Fin:"
boolean focusrectangle = false
end type

type em_2 from editmask within w_rep_rentabilidad
integer x = 2843
integer y = 112
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

type st_1 from statictext within w_rep_rentabilidad
integer x = 50
integer y = 28
integer width = 635
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
string text = "Seleccione el tipo de reporte"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_rep_rentabilidad
long linecolor = 134217738
integer linethickness = 4
long fillcolor = 67108864
integer x = 699
integer y = 16
integer width = 1157
integer height = 184
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_rep_rentabilidad
long linecolor = 134217738
integer linethickness = 4
long fillcolor = 67108864
integer x = 1947
integer y = 16
integer width = 1243
integer height = 188
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_v_vs_c from datawindow within w_rep_rentabilidad
boolean visible = false
integer x = 41
integer y = 224
integer width = 3872
integer height = 2448
integer taborder = 20
string title = "none"
string dataobject = "d_rentabilidad_venta_vs_costo2"
boolean border = false
boolean livescroll = true
end type

type dw_linea from datawindow within w_rep_rentabilidad
integer x = 37
integer y = 224
integer width = 3872
integer height = 2216
integer taborder = 10
string title = "none"
string dataobject = "d_rentabilidad_items_x_linea_y_cliente"
boolean border = false
boolean livescroll = true
end type

type dw_item from datawindow within w_rep_rentabilidad
boolean visible = false
integer x = 251
integer y = 580
integer width = 3333
integer height = 1972
integer taborder = 40
boolean titlebar = true
string title = "Comportamiento del Item"
string dataobject = "d_comportamiento_ventas_x_item_empresa"
boolean controlmenu = true
boolean border = false
boolean livescroll = true
end type


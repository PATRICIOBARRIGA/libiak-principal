HA$PBExportHeader$w_rep_vencimiento_compras.srw
$PBExportComments$Si.
forward
global type w_rep_vencimiento_compras from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_vencimiento_compras
end type
type em_2 from editmask within w_rep_vencimiento_compras
end type
type st_1 from statictext within w_rep_vencimiento_compras
end type
type st_2 from statictext within w_rep_vencimiento_compras
end type
type cb_2 from commandbutton within w_rep_vencimiento_compras
end type
type cbx_powerfilter from u_powerfilter_checkbox within w_rep_vencimiento_compras
end type
end forward

global type w_rep_vencimiento_compras from w_sheet_1_dw_rep
integer width = 4713
integer height = 2092
string title = "Vencimiento Compras"
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
cb_2 cb_2
cbx_powerfilter cbx_powerfilter
end type
global w_rep_vencimiento_compras w_rep_vencimiento_compras

event ue_retrieve;Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)



SetPointer(Hourglass!)
w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n....por favor espere...")
//if rb_1.checked then
//dw_datos.DataObject = 'd_rep_vencimiento_compras'
//else
//dw_datos.DataObject = 'd_rep_vencimiento_compras_servicios'
//end if
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ld_ini,ld_fin)
SetPointer(Arrow!)
w_marco.SetMicrohelp("Listo...")
end event

on w_rep_vencimiento_compras.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_2=create cb_2
this.cbx_powerfilter=create cbx_powerfilter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cbx_powerfilter
end on

on w_rep_vencimiento_compras.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cbx_powerfilter)
end on

event open;call super::open;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=no")

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_vencimiento_compras
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 37
integer y = 284
integer width = 4576
integer height = 1644
string dataobject = "d_rep_vencimiento_compras_servicios"
boolean border = true
end type

event dw_datos::ue_leftbuttonup;cbx_PowerFilter.event post ue_buttonclicked(dwo.type,dwo.name)
end event

event dw_datos::resize;call super::resize;cbx_PowerFilter.event ue_positionbuttons()
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_vencimiento_compras
integer x = 942
integer y = 1084
integer taborder = 40
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_vencimiento_compras
integer x = 87
integer y = 1084
integer taborder = 60
end type

type em_1 from editmask within w_rep_vencimiento_compras
integer x = 594
integer y = 56
integer width = 379
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
end type

type em_2 from editmask within w_rep_vencimiento_compras
integer x = 1221
integer y = 56
integer width = 379
integer height = 80
integer taborder = 50
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

type st_1 from statictext within w_rep_vencimiento_compras
integer x = 59
integer y = 64
integer width = 457
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
string text = "Ingresadas desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_vencimiento_compras
integer x = 1001
integer y = 64
integer width = 215
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

type cb_2 from commandbutton within w_rep_vencimiento_compras
integer x = 1682
integer y = 52
integer width = 1047
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Click aqui para establecer fitro avanzado"
boolean flatstyle = true
end type

event clicked;cbx_powerfilter.visible = true
cbx_PowerFilter.of_setdw(dw_datos)
end event

type cbx_powerfilter from u_powerfilter_checkbox within w_rep_vencimiento_compras
boolean visible = false
integer x = 50
integer y = 168
integer width = 855
boolean bringtotop = true
integer textsize = -8
string text = "&Filtrar"
string defaulttiptext = "Mostrar todo"
boolean bubblestyle = true
end type


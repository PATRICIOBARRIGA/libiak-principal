HA$PBExportHeader$w_rep_ventas_netas_empresa.srw
forward
global type w_rep_ventas_netas_empresa from w_sheet_1_dw
end type
type dw_asiento from datawindow within w_rep_ventas_netas_empresa
end type
type em_1 from editmask within w_rep_ventas_netas_empresa
end type
type em_2 from editmask within w_rep_ventas_netas_empresa
end type
type st_1 from statictext within w_rep_ventas_netas_empresa
end type
type st_2 from statictext within w_rep_ventas_netas_empresa
end type
type st_3 from statictext within w_rep_ventas_netas_empresa
end type
type st_4 from statictext within w_rep_ventas_netas_empresa
end type
type rb_1 from radiobutton within w_rep_ventas_netas_empresa
end type
type rb_2 from radiobutton within w_rep_ventas_netas_empresa
end type
end forward

global type w_rep_ventas_netas_empresa from w_sheet_1_dw
integer width = 3739
integer height = 2520
string title = "Res$$HEX1$$fa00$$ENDHEX$$men de ventas netas"
long backcolor = 67108864
event type integer ue_contabilizar ( )
dw_asiento dw_asiento
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_ventas_netas_empresa w_rep_ventas_netas_empresa

event activate;w_frame_basic lw_frame
m_frame_basic lm_frame

lw_frame = this.parentWindow()
lm_frame = lw_frame.menuid
lm_frame.mf_into_report_mode()
end event

event open;dw_datos.settransobject(sqlca)
dw_report.settransobject(sqlca)

this.ib_notautoretrieve = True
dw_datos.modify("datawindow.print.preview.zoom=100~t" + &
										"datawindow.print.preview=yes")
										
call super::open										

end event

event ue_print;int li_rc

openwithparm(w_dw_print_options,dw_datos)
li_rc = message.DoubleParm
if li_rc = 1 then
	if rb_1.checked = true then
		dw_datos.print()
	else
		dw_report.print()
	end if
end if

end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

event ue_printcancel;beep(1)
end event

event ue_saveas;dw_datos.saveas()
end event

on w_rep_ventas_netas_empresa.create
int iCurrent
call super::create
this.dw_asiento=create dw_asiento
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_asiento
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.rb_2
end on

on w_rep_ventas_netas_empresa.destroy
call super::destroy
destroy(this.dw_asiento)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event close;call super::close;//ROLLBACK;
end event

event ue_mail;OpenSheetWithParm(w_mail_send,dw_datos,w_marco,15,Original!)
return 1
end event

event ue_retrieve;date ld_ini,ld_fin


setpointer(hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if isnull(ld_ini) or isnull(ld_fin) then
		messageBox("Error","Ingrese la fecha")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if


if ld_ini > ld_fin then
		messageBox("Error","Rango de Fechas Incorrecto")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if

if rb_1.checked = true then
dw_report.visible = false	
dw_datos.visible = true
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_rango.text = 'Desde: "+string(ld_ini,'dd/mm/yyyy')+"  Hasta: "+string(ld_fin,'dd/mm/yyyy')+"'")	
dw_datos.Retrieve(ld_ini,ld_fin)
else
dw_report.visible = true	
dw_datos.visible = false
dw_report.modify("st_empresa.text = '"+gs_empresa+"' st_rango.text = 'Desde: "+string(ld_ini,'dd/mm/yyyy')+"  Hasta: "+string(ld_fin,'dd/mm/yyyy')+"'")	
dw_report.Retrieve(ld_ini,ld_fin)
end if


end event

event resize;dataWindow ldw_aux

if rb_1.checked = true then
	ldw_aux = dw_datos
else
	ldw_aux = dw_report
end if

ldw_aux.resize(this.workSpaceWidth() - ldw_aux.x, this.workSpaceHeight() - ldw_aux.y)

end event

type dw_datos from w_sheet_1_dw`dw_datos within w_rep_ventas_netas_empresa
integer x = 18
integer y = 236
integer width = 3547
integer height = 2160
integer taborder = 30
string dataobject = "d_rep_ventas_autocons_empresa"
boolean hscrollbar = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_datos::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from w_sheet_1_dw`dw_report within w_rep_ventas_netas_empresa
integer x = 18
integer y = 236
integer width = 3547
integer height = 2160
integer taborder = 0
boolean enabled = true
string dataobject = "d_rep_ventas_autocons_sucursal"
boolean hscrollbar = false
borderstyle borderstyle = stylelowered!
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_asiento from datawindow within w_rep_ventas_netas_empresa
boolean visible = false
integer x = 2647
integer y = 16
integer width = 210
integer height = 180
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_1 from editmask within w_rep_ventas_netas_empresa
integer x = 827
integer y = 60
integer width = 306
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
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_ventas_netas_empresa
integer x = 1362
integer y = 60
integer width = 306
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
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_ventas_netas_empresa
integer x = 645
integer y = 64
integer width = 169
integer height = 64
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

type st_2 from statictext within w_rep_ventas_netas_empresa
integer x = 1198
integer y = 64
integer width = 151
integer height = 64
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

type st_3 from statictext within w_rep_ventas_netas_empresa
integer x = 827
integer y = 148
integer width = 293
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/aaaa]"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rep_ventas_netas_empresa
integer x = 1367
integer y = 148
integer width = 293
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/aaaa]"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_ventas_netas_empresa
integer x = 119
integer y = 32
integer width = 311
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
string text = "Empresa"
boolean checked = true
end type

type rb_2 from radiobutton within w_rep_ventas_netas_empresa
integer x = 119
integer y = 140
integer width = 311
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
string text = "Sucursal"
end type


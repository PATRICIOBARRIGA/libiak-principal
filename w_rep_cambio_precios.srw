HA$PBExportHeader$w_rep_cambio_precios.srw
$PBExportComments$Si.
forward
global type w_rep_cambio_precios from w_sheet_1_dw
end type
type dw_1 from datawindow within w_rep_cambio_precios
end type
end forward

global type w_rep_cambio_precios from w_sheet_1_dw
integer width = 2702
integer height = 1436
string title = "Consulta Cambio de Precios"
long backcolor = 1090519039
dw_1 dw_1
end type
global w_rep_cambio_precios w_rep_cambio_precios

event activate;//w_frame_basic lw_frame
//m_frame_basic lm_frame
//
//lw_frame = this.parentWindow()
//lm_frame = lw_frame.menuid
//lm_frame.mf_into_report_mode()

end event

event open;dw_1.insertrow(0)
dw_1.setfocus()
this.ib_notautoretrieve = true
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
call super::open										
dw_datos.settransobject(SQLCA)
dw_datos.retrieve(str_appgeninfo.empresa,0)

end event

event ue_print;int li_rc

openwithparm(w_dw_print_options,dw_datos)
li_rc = message.DoubleParm
//gi_print = 0
if li_rc = 1 then
   dw_datos.print()	
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

on w_rep_cambio_precios.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_cambio_precios.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_retrieve;integer li_num_dias
long ll_row

dw_1.Accepttext()
ll_row = dw_1.getrow()
li_num_dias = dw_1.GetItemNumber(ll_row,"num_dias")
dw_datos.retrieve(str_appgeninfo.empresa,li_num_dias)

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

type dw_datos from w_sheet_1_dw`dw_datos within w_rep_cambio_precios
integer y = 152
integer width = 2661
integer height = 1176
string dataobject = "d_rep_cambio_precios"
boolean hscrollbar = false
boolean livescroll = false
end type

event dw_datos::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from w_sheet_1_dw`dw_report within w_rep_cambio_precios
integer y = 144
integer width = 859
integer height = 252
boolean enabled = true
borderstyle borderstyle = styleraised!
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_1 from datawindow within w_rep_cambio_precios
event losefocus pbm_dwnkillfocus
integer width = 2665
integer height = 144
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ext_cambio_precios"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;integer li_num_dias
this.Accepttext()
li_num_dias = this.GetItemNumber(row,"num_dias")
dw_datos.retrieve(str_appgeninfo.empresa,li_num_dias)
end event


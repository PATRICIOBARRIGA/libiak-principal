HA$PBExportHeader$w_sheet_1_dw_rep.srw
forward
global type w_sheet_1_dw_rep from w_sheet_1_dw
end type
type dw_asiento from datawindow within w_sheet_1_dw_rep
end type
end forward

global type w_sheet_1_dw_rep from w_sheet_1_dw
integer width = 1509
integer height = 1020
event type integer ue_contabilizar ( )
dw_asiento dw_asiento
end type
global w_sheet_1_dw_rep w_sheet_1_dw_rep

event activate;w_frame_basic lw_frame
m_frame_basic lm_frame

lw_frame = this.parentWindow()
lm_frame = lw_frame.menuid
lm_frame.mf_into_report_mode()
end event

event open;call super::open;this.ib_inReportMode = True
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
//ROLLBACK;
//EXECUTE IMMEDIATE "SET TRANSACTION READ ONLY";

end event

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 2*dw_datos.y)
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

on w_sheet_1_dw_rep.create
int iCurrent
call super::create
this.dw_asiento=create dw_asiento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_asiento
end on

on w_sheet_1_dw_rep.destroy
call super::destroy
destroy(this.dw_asiento)
end on

event close;call super::close;//ROLLBACK;
end event

event ue_mail;OpenSheetWithParm(w_mail_send,dw_datos,w_marco,15,Original!)
return 1
end event

type dw_datos from w_sheet_1_dw`dw_datos within w_sheet_1_dw_rep
integer x = 41
integer y = 0
integer width = 1426
integer height = 760
end type

event dw_datos::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from w_sheet_1_dw`dw_report within w_sheet_1_dw_rep
integer y = 24
integer width = 859
integer height = 568
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

type dw_asiento from datawindow within w_sheet_1_dw_rep
boolean visible = false
integer x = 553
integer y = 260
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


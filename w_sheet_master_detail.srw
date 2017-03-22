HA$PBExportHeader$w_sheet_master_detail.srw
$PBExportComments$Sheet with one master dw and one detail dw
forward
global type w_sheet_master_detail from w_sheet
end type
type dw_master from uo_dw_master within w_sheet_master_detail
end type
type dw_detail from uo_dw_detail within w_sheet_master_detail
end type
type dw_report from datawindow within w_sheet_master_detail
end type
end forward

global type w_sheet_master_detail from w_sheet
integer width = 1545
integer height = 1124
event ue_retrieve pbm_custom01
event ue_firstrow pbm_custom02
event ue_priorrow pbm_custom03
event ue_nextrow pbm_custom04
event ue_lastrow pbm_custom05
event ue_sort pbm_custom06
event ue_update pbm_custom07
event ue_delete pbm_custom08
event ue_insert pbm_custom09
event ue_print pbm_custom10
event ue_zoomin pbm_custom11
event ue_zoomout pbm_custom12
event ue_printcancel pbm_custom13
event ue_outedition pbm_custom14
event ue_filter pbm_custom06
event type long ue_mail ( )
event ue_edit pbm_custom20
event ue_preliminar pbm_custom20
event type integer ue_anular ( )
dw_master dw_master
dw_detail dw_detail
dw_report dw_report
end type
global w_sheet_master_detail w_sheet_master_detail

type variables
s_argInformation istr_argInformation
boolean ib_inReportMode
boolean ib_updated = FALSE
boolean ib_edit
integer ii_controledit
end variables

forward prototypes
public function integer wf_copyargs ()
public function integer wf_preprint ()
public function integer wf_postprint ()
end prototypes

event ue_retrieve;graphicObject lgo_curObject
long ll_curRow

lgo_curObject = getFocus()

if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

choose case lower(lgo_curObject.className())
	case "dw_master"
		dw_master.uf_retrieve()
	case "dw_detail"
		ll_curRow = dw_master.getRow()
		if ll_curRow > 0 then
			dw_detail.uf_retrieve(ll_curRow)
		else
			dw_detail.reset()
		end if
end choose

dw_master.enabled = FALSE
dw_detail.enabled = FALSE
end event

event ue_firstrow;call super::ue_firstrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

dw_master.enabled = TRUE
dw_master.SetFocus()
lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_firstRow()

end event

event ue_priorrow;call super::ue_priorrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

dw_master.enabled = TRUE
dw_master.SetFocus()

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_priorRow()

end event

event ue_nextrow;call super::ue_nextrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

dw_master.enabled = TRUE
dw_master.SetFocus()
lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_nextRow()

end event

event ue_lastrow;call super::ue_lastrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

dw_master.enabled = TRUE
dw_master.SetFocus()
lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_lastRow()

end event

event ue_sort;call super::ue_sort;graphicObject lgo_curObject
uo_dw_basic ludw_basic


lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_sort()

end event

event ue_update;call super::ue_update;long ll_curRow, ll_numdet

ll_curRow = dw_master.getRow()

if ll_curRow > 0 then
	dw_master.uf_updateCommit(ll_curRow, False)
	ib_updated = TRUE
else
	beep(1)
end if

dw_master.SetFocus()


end event

on ue_delete;call w_sheet::ue_delete;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_deleteCurrentRow()

end on

event ue_insert;call super::ue_insert;graphicObject lgo_curObject
long ll_curRow, li_res
uo_dw_basic ludw_basic


lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	dw_master.enabled = TRUE
	dw_master.SetFocus()
	lgo_curObject = getFocus()
//	beep(1)
//	return
end if

// you can only insert in the detail of a valid master row
if lower(lgo_curObject.className()) = "dw_detail" and &
													this.dw_master.getRow() < 0 then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_insertCurrentRow()

end event

event ue_print;dwItemStatus   lst_estado
integer li_rc
long ll_curRowMaster
w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then
	openwithparm(w_dw_print_options,dw_report)
	li_rc = message.DoubleParm
	if li_rc = 1 then	
	  if dw_report.print() = 1 then
		if this.wf_postPrint() = 1 then
			this.setRedraw(False)
			dw_report.enabled = False
			dw_report.visible = False
			dw_master.enabled = True
			dw_master.visible = True
			dw_detail.enabled = True
			dw_detail.visible = True
			this.ib_inReportMode = False
			this.triggerEvent(resize!)		// so the master and detail get the correct size
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_outof_report_mode()
			//this.triggerEvent('ue_outedition')
		end if
	end if
   end if
else
	ll_curRowMaster = dw_master.getRow()
	if ll_curRowMaster < 1 then
		beep(1)
		return
	end if
	lst_estado = dw_master.GetItemStatus(dw_master.GetRow(),0,Primary!)
	if lst_estado = NewModified! then 
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Primero debe digitar F5 antes de imprimir")
		return
	end if
	if dw_master.uf_updateCommit(ll_curRowMaster, False) = 1 then
		if this.wf_prePrint() = 1 then
			this.setRedraw(False)
			dw_report.modify("datawindow.print.preview.zoom=75~t" + &
								  "datawindow.print.preview=yes")
			dw_master.enabled = False
			dw_master.visible = False
			dw_detail.enabled = False
			dw_detail.visible = False
			dw_report.enabled = True
			dw_report.visible = True
			this.ib_inReportMode = True
			this.triggerEvent(resize!)		// so the report gets the correct size
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_into_report_mode()
		end if
	end if
end if
end event

on ue_zoomin;call w_sheet::ue_zoomin;int li_curZoom

li_curZoom = integer(dw_report.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end on

on ue_zoomout;call w_sheet::ue_zoomout;int li_curZoom

li_curZoom = integer(dw_report.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if

end on

on ue_printcancel;call w_sheet::ue_printcancel;w_frame_basic lw_frame
m_frame_basic lm_frame

if this.wf_postPrint() = 1 then
	this.setRedraw(False)
	dw_report.enabled = False
	dw_report.visible = False
	dw_master.enabled = True
	dw_master.visible = True
	dw_detail.enabled = True
	dw_detail.visible = True
	this.ib_inReportMode = False
	this.triggerEvent(resize!)		// so the master and detail get the correct size
	lw_frame = this.parentWindow()
	lm_frame = lw_frame.menuid
	lm_frame.mf_outof_report_mode()
	this.setRedraw(True)
end if

end on

event ue_filter;graphicObject lgo_curObject
uo_dw_basic ludw_basic


lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_filter()
end event

event type long ue_mail();openWithParm(w_mail_send,dw_report)
return 1
end event

event ue_edit;


string ls_windowname
window lw_waux

lw_waux = This.GetActiveSheet()
ls_windowname = Classname(lw_waux)

SELECT decode("SG_MENU"."MN_ACTIVO",'S',1,0)  
INTO   :ii_controledit  
FROM "SG_MENU"  
WHERE "SG_MENU"."MN_OPCION" = :ls_windowname;

return ii_controledit
end event

event ue_preliminar;dwItemStatus   lst_estado
string ls_range
int li_res
long ll_curRowMaster

w_frame_basic lw_frame
m_frame_basic lm_frame

li_res=openwithparm(w_preview,dw_report)
if this.ib_inReportMode then
	if li_res <0 then
		this.setRedraw(False)
		dw_report.enabled = False
		dw_report.visible = False
		dw_master.enabled = True
		dw_master.visible = True
		dw_detail.enabled = True
		dw_detail.visible = True
		this.ib_inReportMode = False
		this.triggerEvent(resize!)		// so the master and detail get the correct size
		lw_frame = this.parentWindow()
		lm_frame = lw_frame.menuid
		lm_frame.mf_outof_report_mode()
	end if
else
	ll_curRowMaster = dw_master.getRow()
	if ll_curRowMaster < 1 then
		beep(1)
		return
	end if
	lst_estado = dw_master.GetItemStatus(dw_master.GetRow(),0,Primary!)
	if lst_estado = NewModified! then 
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Primero debe digitar F5 antes de imprimir")
		return
	end if
	if dw_master.uf_updateCommit(ll_curRowMaster, False) = 1 then
		if this.wf_prePrint() = 1 then
			this.setRedraw(False)
			dw_report.modify("datawindow.print.preview.zoom=75~t" + &
								  "datawindow.print.preview=yes")
			dw_master.enabled = False
			dw_master.visible = False
			dw_detail.enabled = False
			dw_detail.visible = False
			dw_report.enabled = True
			dw_report.visible = True
			this.ib_inReportMode = True
			this.triggerEvent(resize!)		// so the report gets the correct size
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_into_report_mode()
		end if
	end if
end if
end event

event type integer ue_anular();//Ingrese aqui el c$$HEX1$$f300$$ENDHEX$$digo para anular
return 1
end event

public function integer wf_copyargs ();int li_arg

// check if the dw needs args
if pos(dw_master.describe("DataWindow.Table.Select"), ":") > 0 then
	dw_master.istr_argInformation.nrArgs = this.istr_argInformation.nrArgs
	if dw_master.istr_argInformation.nrArgs > 5 then
		for li_arg = 1 to dw_master.istr_argInformation.nrArgs
			dw_master.istr_argInformation.argType[li_arg] = "string"
			dw_master.istr_argInformation.stringValue[li_arg] = this.istr_argInformation.stringValue[li_arg]
	   next
	else
	  for li_arg = 1 to dw_master.istr_argInformation.nrArgs
		  dw_master.istr_argInformation.argType[li_arg] = lower(this.istr_argInformation.argType[li_arg])
		  choose case dw_master.istr_argInformation.argType[li_arg]
			  case "string"
				  dw_master.istr_argInformation.stringValue[li_arg] = this.istr_argInformation.stringValue[li_arg]
			  case "number"
				  dw_master.istr_argInformation.numberValue[li_arg] = this.istr_argInformation.numberValue[li_arg]
			  case "date"
				  dw_master.istr_argInformation.dateValue[li_arg] = this.istr_argInformation.dateValue[li_arg]
			  case "dateTime"
				  dw_master.istr_argInformation.dateTimeValue[li_arg] = this.istr_argInformation.dateTimeValue[li_arg]
			  case "time"
				  dw_master.istr_argInformation.timeValue[li_arg] = this.istr_argInformation.timeValue[li_arg]
			  case else
				  messageBox("Error de programaci$$HEX1$$f300$$ENDHEX$$n", "El argumento " + &
					  	  string(li_arg) + " tiene el tipo '" + &
						  dw_master.istr_argInformation.argType[li_arg] + &
						  "' que es desconocido o no soportado", StopSign!)
				  return -1
		  end choose
	  next
   end if
end if

return 1

end function

public function integer wf_preprint ();return 1
end function

public function integer wf_postprint ();return 1
end function

event open;call super::open;//this.istr_argInformation = message.PowerObjectParm
//Ahora lleno esta estructura en la ultima hoja de la herencia
if not isValid(this.istr_argInformation) then
//	setNull(this.istr_argInformation)
end if

dw_master.idw_detail = this.dw_detail
dw_detail.idw_master = this.dw_master

dw_master.setTransObject(sqlca)
dw_detail.setTransObject(sqlca)

if this.wf_copyArgs() = -1 then
	this.postEvent(close!)
	return
end if

end event

event closequery;call super::closequery;int li_res

if dw_detail.acceptText() = -1 or dw_master.acceptText() = -1 then
	message.returnValue = 1
	return
end if

if dw_master.modifiedCount() > 0 or dw_master.deletedCount() > 0 or &
	dw_detail.modifiedCount() > 0 or dw_detail.deletedCount() > 0 then
	li_res = messageBox(this.title, &
						"Hay cambios que no se han guardado~n" + &
						"$$HEX1$$bf00$$ENDHEX$$Desea descartarlos?", Question!, YesNo!)
	choose case li_res
//		case 1
//			if dw_master.uf_updateCommit(dw_master.getRow(), False) = -1 then
//				message.returnValue = 1
//			end if
//			return
		case 1
			message.returnValue = 0
			return
		case 2
			message.returnValue = 1
			return
	end choose
end if

end event

on resize;call w_sheet::resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	dw_detail.resize(dw_master.width,li_height - dw_detail.y - dw_master.y)
end if	
this.setRedraw(True)

end on

on w_sheet_master_detail.create
int iCurrent
call super::create
this.dw_master=create dw_master
this.dw_detail=create dw_detail
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_master
this.Control[iCurrent+2]=this.dw_detail
this.Control[iCurrent+3]=this.dw_report
end on

on w_sheet_master_detail.destroy
call super::destroy
destroy(this.dw_master)
destroy(this.dw_detail)
destroy(this.dw_report)
end on

on activate;call w_sheet::activate;w_frame_basic lw_frame
m_frame_basic lm_frame

lw_frame = this.parentWindow()
lm_frame = lw_frame.menuid

if this.ib_inReportMode then
	lm_frame.mf_into_report_mode()
else
	lm_frame.mf_outof_report_mode()
end if

end on

on close;w_frame_basic lw_frame
m_frame_basic lm_frame

dw_master.shareDataOff()
dw_detail.shareDataOff()

if this.ib_inReportMode then
	lw_frame = this.parentWindow()
	lm_frame = lw_frame.menuid
	lm_frame.mf_outof_report_mode()
end if

call super::close

end on

type dw_master from uo_dw_master within w_sheet_master_detail
integer x = 32
integer y = 32
integer width = 1426
integer height = 388
integer taborder = 30
borderstyle borderstyle = styleraised!
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_filact
dwItemStatus l_status

ll_filact = dw_master.GetRow()
l_status = this.GetItemStatus(ll_filact, 0, Primary!)
if l_status = New! or l_status = NewModified! then
   dw_master.enabled = TRUE
	dw_detail.enabled = TRUE
else
//	dw_master.enabled = FALSE
//	dw_detail.enabled = FALSE
end if
end event

type dw_detail from uo_dw_detail within w_sheet_master_detail
integer x = 32
integer y = 460
integer width = 1426
integer taborder = 10
borderstyle borderstyle = styleraised!
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from datawindow within w_sheet_master_detail
boolean visible = false
integer x = 32
integer y = 32
integer width = 1449
integer height = 968
integer taborder = 20
boolean enabled = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


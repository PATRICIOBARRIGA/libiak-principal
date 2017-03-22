HA$PBExportHeader$w_sheet_master_mult_detail.srw
$PBExportComments$Window with one master and multiple details
forward
global type w_sheet_master_mult_detail from w_sheet
end type
type rb_detail3 from radiobutton within w_sheet_master_mult_detail
end type
type rb_detail2 from radiobutton within w_sheet_master_mult_detail
end type
type rb_detail1 from radiobutton within w_sheet_master_mult_detail
end type
type dw_detail1 from uo_dw_detail within w_sheet_master_mult_detail
end type
type dw_master from uo_dw_master_mult within w_sheet_master_mult_detail
end type
type dw_detail2 from uo_dw_detail within w_sheet_master_mult_detail
end type
type dw_detail3 from uo_dw_detail within w_sheet_master_mult_detail
end type
type dw_report from uo_dw_basic within w_sheet_master_mult_detail
end type
end forward

global type w_sheet_master_mult_detail from w_sheet
integer width = 1527
integer height = 1148
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
event ue_edit pbm_custom20
rb_detail3 rb_detail3
rb_detail2 rb_detail2
rb_detail1 rb_detail1
dw_detail1 dw_detail1
dw_master dw_master
dw_detail2 dw_detail2
dw_detail3 dw_detail3
dw_report dw_report
end type
global w_sheet_master_mult_detail w_sheet_master_mult_detail

type variables
s_argInformation istr_argInformation
boolean ib_inReportMode
boolean ib_edit
integer ii_controledit
end variables

forward prototypes
public function integer wf_copyargs ()
public function integer wf_preprint ()
public function integer wf_postprint ()
end prototypes

on ue_retrieve;graphicObject lgo_curObject
long ll_curRow
uo_dw_detail ldw_detail

lgo_curObject = getFocus()

if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

choose case lower(lgo_curObject.className())
	case "dw_master"
		dw_master.uf_retrieve()
	case "dw_detail1", "dw_detail2", "dw_detail3"
		ldw_detail = lgo_curObject
		ll_curRow = dw_master.getRow()
		if ll_curRow > 0 then
			ldw_detail.uf_retrieve(ll_curRow)
		else
			ldw_detail.reset()
		end if
end choose

end on

on ue_firstrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_firstRow()

end on

on ue_priorrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_priorRow()

end on

on ue_nextrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_nextRow()

end on

on ue_lastrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_lastRow()

end on

on ue_sort;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_sort()

end on

on ue_update;call w_sheet::ue_update;long ll_curRow

ll_curRow = dw_master.getRow()

if ll_curRow > 0 then
	dw_master.uf_updateCommit(ll_curRow, False)
else
	beep(1)
end if

end on

on ue_delete;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_deleteCurrentRow()

end on

on ue_insert;graphicObject lgo_curObject
long ll_curRow
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

// you can only insert in the detail of a valid master row
if lower(lgo_curObject.className()) <> "dw_master" and &
													this.dw_master.getRow() < 0 then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_insertCurrentRow()

end on

on ue_print;long ll_curRowMaster
uo_dw_detail ldw_detail

if this.ib_inReportMode then
	if dw_report.print() = 1 then
		if this.wf_postPrint() = 1 then
			this.setRedraw(False)
			dw_report.enabled = False
			dw_report.visible = False
			dw_master.enabled = True
			dw_master.visible = True
			if rb_detail1.checked then
				ldw_detail = dw_detail1
			elseif rb_detail2.checked then
				ldw_detail = dw_detail2
			else
				ldw_detail = dw_detail3
			end if
			ldw_detail.enabled = True
			ldw_detail.visible = True
			rb_detail1.enabled = True
			rb_detail1.visible = True
			rb_detail2.enabled = True
			rb_detail2.visible = True
			rb_detail3.enabled = True
			rb_detail3.visible = True
			this.ib_inReportMode = False
			this.triggerEvent(resize!)		// so the master and detail get the correct size
		end if
	end if		
else
	ll_curRowMaster = dw_master.getRow()
	if ll_curRowMaster < 1 then
		beep(1)
		return
	end if
	if dw_master.uf_updateCommit(ll_curRowMaster, False) = 1 then
		if this.wf_prePrint() = 1 then
			this.setRedraw(False)
			dw_master.enabled = False
			dw_master.visible = False
			if rb_detail1.checked then
				ldw_detail = dw_detail1
			elseif rb_detail2.checked then
				ldw_detail = dw_detail2
			else
				ldw_detail = dw_detail3
			end if
			ldw_detail.enabled = False
			ldw_detail.visible = False
			rb_detail1.enabled = False
			rb_detail1.visible = False
			rb_detail2.enabled = False
			rb_detail2.visible = False
			rb_detail3.enabled = False
			rb_detail3.visible = False
			dw_report.enabled = True
			dw_report.visible = True
			this.ib_inReportMode = True
			this.triggerEvent(resize!)		// so the report gets the correct size
		end if
	end if
end if

end on

event ue_edit;String ls_windowname
window lw_waux

lw_waux = This.GetActiveSheet()
ls_windowname = Classname(lw_waux)

SELECT decode("SG_MENU"."MN_ACTIVO",'S',1,0)  
INTO   :ii_controledit  
FROM "SG_MENU"  
WHERE "SG_MENU"."MN_OPCION" = :ls_windowname;

return ii_controledit
end event

public function integer wf_copyargs ();int li_arg

// check if the dw needs args
if pos(dw_master.describe("DataWindow.Table.Select"), ":") > 0 then
	dw_master.istr_argInformation.nrArgs = this.istr_argInformation.nrArgs
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

return 1

end function

public function integer wf_preprint ();return 1

end function

public function integer wf_postprint ();return 1

end function

event open;call super::open;//this.istr_argInformation = message.PowerObjectParm
if not isValid(this.istr_argInformation) then
	//setNull(this.istr_argInformation)
end if

dw_master.idw_detail[1] = this.dw_detail1
dw_master.idw_detail[2] = this.dw_detail2
dw_master.idw_detail[3] = this.dw_detail3
dw_detail1.idw_master = this.dw_master
dw_detail2.idw_master = this.dw_master
dw_detail3.idw_master = this.dw_master

dw_master.setTransObject(sqlca)
dw_detail1.setTransObject(sqlca)
dw_detail2.setTransObject(sqlca)
dw_detail3.setTransObject(sqlca)

end event

on resize;call w_sheet::resize;int li_width, li_height
uo_dw_detail ldw_detail

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	if rb_detail1.checked then
		ldw_detail = dw_detail1
	elseif rb_detail2.checked then
		ldw_detail = dw_detail2
	else
		ldw_detail = dw_detail3
	end if
	ldw_detail.resize(dw_master.width,li_height - ldw_detail.y - dw_master.y)
end if
this.setRedraw(True)

end on

on closequery;int li_res

if dw_detail1.acceptText() = -1 or &
	dw_detail2.acceptText() = -1 or &
	dw_detail3.acceptText() = -1 or &
	dw_master.acceptText() = -1 then
	message.returnValue = 1
	return
end if

if dw_master.modifiedCount() > 0 or dw_master.deletedCount() > 0 or &
	dw_detail1.modifiedCount() > 0 or dw_detail1.deletedCount() > 0 or &
	dw_detail2.modifiedCount() > 0 or dw_detail2.deletedCount() > 0 or &
	dw_detail3.modifiedCount() > 0 or dw_detail3.deletedCount() > 0 then
	li_res = messageBox(this.title, &
						"Hay cambios que no se han guardado~n" + &
						"$$HEX1$$bf00$$ENDHEX$$Desea guardarlos?", Question!, YesNoCancel!)
	choose case li_res
		case 1
			if dw_master.uf_updateCommit(dw_master.getRow(), False) = -1 then
				message.returnValue = 1
			end if
		case 2
		case 3
			message.returnValue = 1
	end choose
end if

end on

on w_sheet_master_mult_detail.create
int iCurrent
call super::create
this.rb_detail3=create rb_detail3
this.rb_detail2=create rb_detail2
this.rb_detail1=create rb_detail1
this.dw_detail1=create dw_detail1
this.dw_master=create dw_master
this.dw_detail2=create dw_detail2
this.dw_detail3=create dw_detail3
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_detail3
this.Control[iCurrent+2]=this.rb_detail2
this.Control[iCurrent+3]=this.rb_detail1
this.Control[iCurrent+4]=this.dw_detail1
this.Control[iCurrent+5]=this.dw_master
this.Control[iCurrent+6]=this.dw_detail2
this.Control[iCurrent+7]=this.dw_detail3
this.Control[iCurrent+8]=this.dw_report
end on

on w_sheet_master_mult_detail.destroy
call super::destroy
destroy(this.rb_detail3)
destroy(this.rb_detail2)
destroy(this.rb_detail1)
destroy(this.dw_detail1)
destroy(this.dw_master)
destroy(this.dw_detail2)
destroy(this.dw_detail3)
destroy(this.dw_report)
end on

type rb_detail3 from radiobutton within w_sheet_master_mult_detail
integer x = 937
integer y = 484
integer width = 283
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detail 3"
end type

on clicked;if dw_detail1.visible = True then
	beep(1)
else
	parent.setRedraw(False)
	dw_detail1.visible = False
	dw_detail1.enabled = False
	dw_detail2.visible = False
	dw_detail2.enabled = False
	dw_detail3.visible = True
	dw_detail3.enabled = True
	parent.postEvent(resize!)
	parent.setRedraw(True)
end if

end on

type rb_detail2 from radiobutton within w_sheet_master_mult_detail
integer x = 489
integer y = 484
integer width = 283
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detail 2"
end type

on clicked;if dw_detail2.visible = True then
	beep(1)
else
	parent.setRedraw(False)
	dw_detail1.visible = False
	dw_detail1.enabled = False
	dw_detail2.visible = True
	dw_detail2.enabled = True
	dw_detail3.visible = False
	dw_detail3.enabled = False
	parent.postEvent(resize!)
	parent.setRedraw(True)
end if

end on

type rb_detail1 from radiobutton within w_sheet_master_mult_detail
integer x = 41
integer y = 484
integer width = 283
integer height = 72
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Detail 1"
boolean checked = true
end type

on clicked;if dw_detail1.visible = True then
	beep(1)
else
	parent.setRedraw(False)
	dw_detail1.visible = True
	dw_detail1.enabled = True
	dw_detail2.visible = False
	dw_detail2.enabled = False
	dw_detail3.visible = False
	dw_detail3.enabled = False
	parent.postEvent(resize!)
	parent.setRedraw(True)
end if

end on

type dw_detail1 from uo_dw_detail within w_sheet_master_mult_detail
integer x = 41
integer y = 564
integer height = 444
integer taborder = 50
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_master from uo_dw_master_mult within w_sheet_master_mult_detail
integer x = 37
integer y = 28
integer width = 1367
integer height = 444
integer taborder = 10
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_detail2 from uo_dw_detail within w_sheet_master_mult_detail
integer x = 41
integer y = 564
integer width = 1083
integer height = 444
integer taborder = 60
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_detail3 from uo_dw_detail within w_sheet_master_mult_detail
integer x = 41
integer y = 564
integer width = 1394
integer height = 444
integer taborder = 70
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from uo_dw_basic within w_sheet_master_mult_detail
boolean visible = false
integer x = 32
integer y = 28
integer width = 1499
integer height = 996
integer taborder = 80
boolean enabled = false
end type


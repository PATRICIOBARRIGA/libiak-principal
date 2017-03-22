HA$PBExportHeader$w_sheet_master_tabpage_detail.srw
forward
global type w_sheet_master_tabpage_detail from w_sheet
end type
type dw_master from uo_dw_master_mult within w_sheet_master_tabpage_detail
end type
type dw_report from datawindow within w_sheet_master_tabpage_detail
end type
type tab_detail from tab within w_sheet_master_tabpage_detail
end type
type tabpage_detail1 from userobject within tab_detail
end type
type dw_detail1 from uo_dw_detail within tabpage_detail1
end type
type tabpage_detail1 from userobject within tab_detail
dw_detail1 dw_detail1
end type
type tabpage_detail2 from userobject within tab_detail
end type
type dw_detail2 from uo_dw_detail within tabpage_detail2
end type
type tabpage_detail2 from userobject within tab_detail
dw_detail2 dw_detail2
end type
type tabpage_detail3 from userobject within tab_detail
end type
type dw_detail3 from uo_dw_detail within tabpage_detail3
end type
type tabpage_detail3 from userobject within tab_detail
dw_detail3 dw_detail3
end type
type tabpage_detail4 from userobject within tab_detail
end type
type dw_detail4 from uo_dw_detail within tabpage_detail4
end type
type tabpage_detail4 from userobject within tab_detail
dw_detail4 dw_detail4
end type
type tab_detail from tab within w_sheet_master_tabpage_detail
tabpage_detail1 tabpage_detail1
tabpage_detail2 tabpage_detail2
tabpage_detail3 tabpage_detail3
tabpage_detail4 tabpage_detail4
end type
end forward

global type w_sheet_master_tabpage_detail from w_sheet
integer width = 2427
integer height = 1412
long backcolor = 79741120
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
event ue_filter pbm_custom06
event ue_edit pbm_custom20
event type integer ue_anular ( )
dw_master dw_master
dw_report dw_report
tab_detail tab_detail
end type
global w_sheet_master_tabpage_detail w_sheet_master_tabpage_detail

type variables
s_argInformation istr_argInformation
boolean ib_inReportMode
boolean ib_edit
integer ii_controledit
end variables

forward prototypes
public function integer wf_copyargs ()
public function integer wf_postprint ()
public function integer wf_preprint ()
end prototypes

event ue_retrieve;call super::ue_retrieve;graphicObject lgo_curObject
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
	case "dw_detail1", "dw_detail2", "dw_detail3", "dw_detail4"
		ldw_detail = lgo_curObject
		ll_curRow = dw_master.getRow()
		if ll_curRow > 0 then
			ldw_detail.uf_retrieve(ll_curRow)
		else
			ldw_detail.reset()
		end if
end choose

end event

event ue_firstrow;call super::ue_firstrow;graphicObject lgo_curObject
uo_dw_basic ludw_basic

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

event ue_update;call super::ue_update;long ll_curRow

ll_curRow = dw_master.getRow()

if ll_curRow > 0 then
	dw_master.uf_updateCommit(ll_curRow, False)
else
	beep(1)
end if

end event

event ue_delete;call super::ue_delete;graphicObject lgo_curObject
uo_dw_basic ludw_basic

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_deleteCurrentRow()

end event

event ue_insert;call super::ue_insert;graphicObject lgo_curObject
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
end event

event ue_print;call super::ue_print;long ll_curRowMaster
uo_dw_detail ldw_detail

if this.ib_inReportMode then
	if dw_report.print() = 1 then
		if this.wf_postPrint() = 1 then
			this.setRedraw(False)
			dw_report.enabled = False
			dw_report.visible = False
			dw_master.enabled = True
			dw_master.visible = True
			if tab_detail.SelectedTab = 1 then
				ldw_detail = tab_detail.tabpage_detail1.dw_detail1
			elseif tab_detail.SelectedTab = 2 then
				ldw_detail = tab_detail.tabpage_detail2.dw_detail2
			else
				ldw_detail = tab_detail.tabpage_detail3.dw_detail3
			end if
			ldw_detail.enabled = True
			ldw_detail.visible = True
			tab_detail.enabled = True
			tab_detail.visible = True
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
			if tab_detail.SelectedTab = 1 then
				ldw_detail = tab_detail.tabpage_detail1.dw_detail1
			elseif tab_detail.SelectedTab = 2 then
				ldw_detail = tab_detail.tabpage_detail2.dw_detail2
			else
				ldw_detail = tab_detail.tabpage_detail3.dw_detail3
			end if
			ldw_detail.enabled = False
			ldw_detail.visible = False
			tab_detail.enabled = False
			tab_detail.visible = False
			dw_report.enabled = True
			dw_report.visible = True
			this.ib_inReportMode = True
			this.triggerEvent(resize!)		// so the report gets the correct size
		end if
	end if
end if

end event

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

event type integer ue_anular();//ingrese aqui el c$$HEX1$$f300$$ENDHEX$$digo para la anulaci$$HEX1$$f300$$ENDHEX$$n
return 1
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

public function integer wf_postprint ();return 1
end function

public function integer wf_preprint ();return 1
end function

event closequery;int li_res

if tab_detail.tabpage_detail1.dw_detail1.acceptText() = -1 or &
	tab_detail.tabpage_detail2.dw_detail2.acceptText() = -1 or &
	tab_detail.tabpage_detail3.dw_detail3.acceptText() = -1 or &
	tab_detail.tabpage_detail4.dw_detail4.acceptText() = -1 or &	
	dw_master.acceptText() = -1 then
	message.returnValue = 1
	return
end if

if dw_master.modifiedCount() > 0 or dw_master.deletedCount() > 0 or &
	tab_detail.tabpage_detail1.dw_detail1.modifiedCount() > 0 or tab_detail.tabpage_detail1.dw_detail1.deletedCount() > 0 or &
	tab_detail.tabpage_detail2.dw_detail2.modifiedCount() > 0 or tab_detail.tabpage_detail2.dw_detail2.deletedCount() > 0 or &
	tab_detail.tabpage_detail3.dw_detail3.modifiedCount() > 0 or tab_detail.tabpage_detail3.dw_detail3.deletedCount() > 0 or &
	tab_detail.tabpage_detail4.dw_detail4.modifiedCount() > 0 or tab_detail.tabpage_detail4.dw_detail4.deletedCount() > 0 then
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

end event

event open;call super::open;//this.istr_argInformation = message.PowerObjectParm
if not isValid(this.istr_argInformation) then
//	setNull(this.istr_argInformation)
end if

dw_master.idw_detail[1] = this.tab_detail.tabpage_detail1.dw_detail1
dw_master.idw_detail[2] = this.tab_detail.tabpage_detail2.dw_detail2
dw_master.idw_detail[3] = this.tab_detail.tabpage_detail3.dw_detail3
dw_master.idw_detail[4] = this.tab_detail.tabpage_detail4.dw_detail4
tab_detail.tabpage_detail1.dw_detail1.idw_master = this.dw_master
tab_detail.tabpage_detail2.dw_detail2.idw_master = this.dw_master
tab_detail.tabpage_detail3.dw_detail3.idw_master = this.dw_master
tab_detail.tabpage_detail4.dw_detail4.idw_master = this.dw_master

dw_master.setTransObject(sqlca)
tab_detail.tabpage_detail1.dw_detail1.setTransObject(sqlca)
tab_detail.tabpage_detail2.dw_detail2.setTransObject(sqlca)
tab_detail.tabpage_detail3.dw_detail3.setTransObject(sqlca)
tab_detail.tabpage_detail4.dw_detail4.setTransObject(sqlca)
end event

event resize;call super::resize;int li_width, li_height
uo_dw_detail ldw_detail

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	if tab_detail.SelectedTab = 1 then
		ldw_detail = tab_detail.tabpage_detail1.dw_detail1
	else
	 if tab_detail.SelectedTab = 2 then
		ldw_detail = tab_detail.tabpage_detail2.dw_detail2
	 else
		if tab_detail.SelectedTab = 3 then
		   ldw_detail = tab_detail.tabpage_detail3.dw_detail3
	   else
		   ldw_detail = tab_detail.tabpage_detail4.dw_detail4
	   end if
	 end if
	end if
	ldw_detail.resize(dw_master.width - 2* ldw_detail.x ,li_height - ldw_detail.y - dw_master.y)
end if
this.setRedraw(True)

end event

on w_sheet_master_tabpage_detail.create
int iCurrent
call super::create
this.dw_master=create dw_master
this.dw_report=create dw_report
this.tab_detail=create tab_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_master
this.Control[iCurrent+2]=this.dw_report
this.Control[iCurrent+3]=this.tab_detail
end on

on w_sheet_master_tabpage_detail.destroy
call super::destroy
destroy(this.dw_master)
destroy(this.dw_report)
destroy(this.tab_detail)
end on

event activate;call super::activate;w_frame_basic lw_frame
m_frame_basic lm_frame

lw_frame = this.parentWindow()
lm_frame = lw_frame.menuid

if this.ib_inReportMode then
	lm_frame.mf_into_report_mode()
else
	lm_frame.mf_outof_report_mode()
end if

end event

type dw_master from uo_dw_master_mult within w_sheet_master_tabpage_detail
integer width = 2427
integer height = 444
integer taborder = 30
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from datawindow within w_sheet_master_tabpage_detail
boolean visible = false
integer y = 8
integer width = 1454
integer height = 1076
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tab_detail from tab within w_sheet_master_tabpage_detail
event create ( )
event destroy ( )
integer x = 9
integer y = 448
integer width = 2427
integer height = 864
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 81324524
boolean raggedright = true
integer selectedtab = 1
tabpage_detail1 tabpage_detail1
tabpage_detail2 tabpage_detail2
tabpage_detail3 tabpage_detail3
tabpage_detail4 tabpage_detail4
end type

on tab_detail.create
this.tabpage_detail1=create tabpage_detail1
this.tabpage_detail2=create tabpage_detail2
this.tabpage_detail3=create tabpage_detail3
this.tabpage_detail4=create tabpage_detail4
this.Control[]={this.tabpage_detail1,&
this.tabpage_detail2,&
this.tabpage_detail3,&
this.tabpage_detail4}
end on

on tab_detail.destroy
destroy(this.tabpage_detail1)
destroy(this.tabpage_detail2)
destroy(this.tabpage_detail3)
destroy(this.tabpage_detail4)
end on

type tabpage_detail1 from userobject within tab_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2391
integer height = 744
long backcolor = 79741120
string text = "Detail 1"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
string powertiptext = "fsdfsdsdf"
dw_detail1 dw_detail1
end type

on tabpage_detail1.create
this.dw_detail1=create dw_detail1
this.Control[]={this.dw_detail1}
end on

on tabpage_detail1.destroy
destroy(this.dw_detail1)
end on

type dw_detail1 from uo_dw_detail within tabpage_detail1
integer x = 5
integer y = 4
integer width = 1966
integer height = 516
integer taborder = 2
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type tabpage_detail2 from userobject within tab_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2391
integer height = 744
long backcolor = 79741120
string text = "Detail 2"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_detail2 dw_detail2
end type

on tabpage_detail2.create
this.dw_detail2=create dw_detail2
this.Control[]={this.dw_detail2}
end on

on tabpage_detail2.destroy
destroy(this.dw_detail2)
end on

type dw_detail2 from uo_dw_detail within tabpage_detail2
integer x = 32
integer y = 36
integer width = 2030
integer height = 664
integer taborder = 2
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type tabpage_detail3 from userobject within tab_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2391
integer height = 744
long backcolor = 81324524
string text = "Detail 3"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
dw_detail3 dw_detail3
end type

on tabpage_detail3.create
this.dw_detail3=create dw_detail3
this.Control[]={this.dw_detail3}
end on

on tabpage_detail3.destroy
destroy(this.dw_detail3)
end on

type dw_detail3 from uo_dw_detail within tabpage_detail3
integer x = 32
integer y = 40
integer width = 2030
integer height = 664
integer taborder = 2
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type tabpage_detail4 from userobject within tab_detail
integer x = 18
integer y = 104
integer width = 2391
integer height = 744
long backcolor = 81324524
string text = "Detail 4"
long tabtextcolor = 33554432
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
dw_detail4 dw_detail4
end type

on tabpage_detail4.create
this.dw_detail4=create dw_detail4
this.Control[]={this.dw_detail4}
end on

on tabpage_detail4.destroy
destroy(this.dw_detail4)
end on

type dw_detail4 from uo_dw_detail within tabpage_detail4
integer x = 18
integer y = 16
integer width = 2313
integer height = 672
integer taborder = 2
end type

event rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event


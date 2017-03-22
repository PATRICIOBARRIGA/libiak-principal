HA$PBExportHeader$w_sheet_1_dw.srw
forward
global type w_sheet_1_dw from w_sheet
end type
type dw_datos from uo_dw_basic within w_sheet_1_dw
end type
type dw_report from datawindow within w_sheet_1_dw
end type
end forward

global type w_sheet_1_dw from w_sheet
integer width = 1554
integer height = 1032
event ue_retrieve pbm_custom01
event ue_firstrow pbm_custom02
event ue_priorrow pbm_custom03
event ue_nextrow pbm_custom04
event ue_lastrow pbm_custom05
event ue_sort pbm_custom06
event ue_print pbm_custom10
event ue_zoomin pbm_custom11
event ue_zoomout pbm_custom12
event ue_printcancel pbm_custom13
event ue_saveas pbm_custom14
event ue_filter pbm_custom07
event type long ue_mail ( )
event ue_edit pbm_custom20
event ue_preliminar pbm_custom17
event type integer ue_anular ( )
dw_datos dw_datos
dw_report dw_report
end type
global w_sheet_1_dw w_sheet_1_dw

type variables
s_argInformation istr_argInformation
boolean ib_notAutoRetrieve
boolean ib_inReportMode
boolean ib_edit
integer ii_controledit

end variables

forward prototypes
public function integer wf_copyargs_basic ()
public function integer wf_copyargs ()
public function integer wf_preprint ()
public function integer wf_postprint ()
public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name)
end prototypes

event ue_retrieve;call super::ue_retrieve;dw_datos.uf_retrieve()
end event

event ue_firstrow;call super::ue_firstrow;dw_datos.uf_firstRow()
end event

event ue_priorrow;call super::ue_priorrow;dw_datos.uf_priorRow()
end event

event ue_nextrow;call super::ue_nextrow;dw_datos.uf_nextRow()
end event

event ue_lastrow;call super::ue_lastrow;dw_datos.uf_lastRow()
end event

event ue_sort;call super::ue_sort;dw_datos.uf_sort()
end event

event ue_print;call super::ue_print;string ls_range
int li_res
w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then

	openwithparm(w_dw_print_options,dw_report)
   li_res = message.doubleparm
 //  li_res = gi_print
   if li_res <> 1 then
		li_res = 1
	else
	//	gi_print = 0
		li_res = dw_report.print()
		if li_res = 1 then li_res = this.wf_postPrint()
	end if
		
	if li_res = 1 then
		this.setRedraw(False)
		dw_report.enabled = False
		dw_report.visible = False
		dw_datos.enabled = True
		dw_datos.visible = True
		this.ib_inReportMode = False
		this.triggerEvent(resize!)		// so the master and detail get the correct size
		lw_frame = this.parentWindow()
		lm_frame = lw_frame.menuid
		lm_frame.mf_outof_report_mode()
	end if

else
	if dw_datos.uf_updateCommit() = 1 then
		if this.wf_prePrint() = 1 then
			this.setRedraw(False)
			dw_report.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
			dw_datos.enabled = False
			dw_datos.visible = False
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

this.setRedraw(True)

end event

event ue_zoomin;call super::ue_zoomin;int li_curZoom

li_curZoom = integer(dw_report.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;call super::ue_zoomout;int li_curZoom

li_curZoom = integer(dw_report.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

event ue_printcancel;call super::ue_printcancel;w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then

	if this.wf_postPrint() = 1 then
		this.setRedraw(False)
		dw_report.enabled = False
		dw_report.visible = False
		dw_datos.enabled = True
		dw_datos.visible = True
		this.ib_inReportMode = False
		this.triggerEvent(resize!)		// so dw_datos get the correct size
		lw_frame = this.parentWindow()
		lm_frame = lw_frame.menuid
		lm_frame.mf_outof_report_mode()
	end if

else
	beep(1)
end if

this.setRedraw(True)

end event

event ue_saveas;call super::ue_saveas;int li_res

if this.ib_inReportMode then
		li_res = dw_report.saveas()
      // messagebox('UE_SAVEAS','Ya me ejecute mal ....');
end if

this.setRedraw(True)

end event

event ue_filter;dw_datos.uf_filter()
end event

event type long ue_mail();OpenSheetWithParm(w_mail_send,dw_report,w_marco,15,Original!)
return 1
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

event ue_preliminar;string ls_range
int li_res
Datawindow ldw_report
w_frame_basic lw_frame
m_frame_basic lm_frame

if dw_report.visible=true then
	ldw_report=dw_report
else
	ldw_report=dw_datos
end if

li_res=openwithparm(w_preview,ldw_report)

if this.ib_inReportMode then
	if li_res <0 then
		this.setRedraw(False)
		dw_report.enabled = False
		dw_report.visible = False
		dw_datos.enabled = True
		dw_datos.visible = True
		this.ib_inReportMode = False
		this.triggerEvent(resize!)		// so the master and detail get the correct size
		lw_frame = this.parentWindow()
		lm_frame = lw_frame.menuid
		lm_frame.mf_outof_report_mode()
	end if

else
	if dw_datos.uf_updateCommit() = 1 then
		if this.wf_prePrint() = 1 then
			this.setRedraw(False)
			dw_report.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
			dw_datos.enabled = False
			dw_datos.visible = False
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
this.setRedraw(True)
end event

event type integer ue_anular();// Ingrese aqui el c$$HEX1$$f300$$ENDHEX$$digo que involucra realizar una anulaci$$HEX1$$f300$$ENDHEX$$n.
RETURN 1
end event

public function integer wf_copyargs_basic ();//int li_arg

dw_datos.istr_argInformation = this.istr_argInformation

//dw_datos.istr_argInformation.nrArgs = this.istr_argInformation.nrArgs
//for li_arg = 1 to dw_datos.istr_argInformation.nrArgs
//	dw_datos.istr_argInformation.argType[li_arg] = lower(this.istr_argInformation.argType[li_arg])
//	choose case dw_datos.istr_argInformation.argType[li_arg]
//		case "string"
//			dw_datos.istr_argInformation.stringValue[li_arg] = this.istr_argInformation.stringValue[li_arg]
//		case "number"
//			dw_datos.istr_argInformation.numberValue[li_arg] = this.istr_argInformation.numberValue[li_arg]
//		case "date"
//			dw_datos.istr_argInformation.dateValue[li_arg] = this.istr_argInformation.dateValue[li_arg]
//		case "dateTime"
//			dw_datos.istr_argInformation.dateTimeValue[li_arg] = this.istr_argInformation.dateTimeValue[li_arg]
//		case "time"
//			dw_datos.istr_argInformation.timeValue[li_arg] = this.istr_argInformation.timeValue[li_arg]
//		case else
//			messageBox("Error de programaci$$HEX1$$f300$$ENDHEX$$n", "El argumento " + &
//					string(li_arg) + " tiene el tipo '" + &
//					dw_datos.istr_argInformation.argType[li_arg] + &
//					"' que es desconocido o no soportado", StopSign!)
//			return -1
//	end choose
//next

return 1

end function

public function integer wf_copyargs ();// check if the dw needs args
if pos(dw_datos.describe("DataWindow.Table.Select"), ":") > 0 then
	return this.wf_copyargs_basic()
end if

return 1
end function

public function integer wf_preprint ();if dw_report.dataObject = "" then
	dw_report.dataObject = dw_datos.dataObject
	return dw_datos.shareData(dw_report)
else
	return 1
end if

end function

public function integer wf_postprint ();return 1
end function

public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name);string 	ls_ret	
mailreturncode mRet

/*****************************************************************
	Log off from the mail system
 *****************************************************************/
mRet = ams_mSes.mailLogoff ( )
ls_ret = f_mail_error_to_string ( mRet, 'Logoff:', FALSE )
//st_status_bar.text = ' Logoff: ' + ls_ret

If mRet <> mailReturnSuccess! Then
	MessageBox ("Mail Logoff", 'Return Code <> mailReturnSuccess!' )
	return
End If

/*****************************************************************
	Finally, destroy the mail session object created earlier.
	Also, delete the temporary attachment file.
 *****************************************************************/
destroy ams_mses


FileDelete ( as_attach_name )
end subroutine

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

event close;w_frame_basic lw_frame
m_frame_basic lm_frame

dw_datos.shareDataOff()

if this.ib_inReportMode then
	lw_frame = this.parentWindow()
	lm_frame = lw_frame.menuid
	lm_frame.mf_outof_report_mode()
end if

call super::close


end event

on w_sheet_1_dw.create
int iCurrent
call super::create
this.dw_datos=create dw_datos
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_datos
this.Control[iCurrent+2]=this.dw_report
end on

on w_sheet_1_dw.destroy
call super::destroy
destroy(this.dw_datos)
destroy(this.dw_report)
end on

event closequery;call super::closequery;int li_res

if dw_datos.acceptText() = -1 then
	message.returnValue = 1
	return
end if

if dw_datos.modifiedCount() > 0 or dw_datos.deletedCount() > 0 then
	li_res = messageBox(this.title, &
						"Hay cambios que no se han guardado~n" + &
						"$$HEX1$$bf00$$ENDHEX$$Desea guardarlos?", Question!, YesNoCancel!)
	choose case li_res
		case 1
			if dw_datos.uf_updateCommit() = -1 then
				message.returnValue = 1
			end if
			return
		case 2
			return
		case 3
			message.returnValue = 1
			return
	end choose
end if

end event

event open;call super::open;//this.istr_argInformation = message.PowerObjectParm
//Ahora lleno esta estructura en la ultima hoja de la herencia
if not isValid(this.istr_argInformation) then
	//setNull(this.istr_argInformation)
end if

if not isNull(this.istr_argInformation) then
	if dw_datos.dataObject = "" then
		dw_datos.dataObject = this.istr_argInformation.dataObject
		dw_datos.width = this.istr_argInformation.width
		dw_datos.height = this.istr_argInformation.height
	end if
	if dw_report.dataObject = "" then
		dw_report.dataObject = this.istr_argInformation.dataObject_rep
		dw_report.width = this.istr_argInformation.width
		dw_report.height = this.istr_argInformation.height
	end if
	if this.istr_argInformation.title <> "" then
		this.title = this.istr_argInformation.title
	end if
end if

if dw_datos.setTransObject(sqlca) = -1 then
	messageBox("Error interno", &
		"No se puede asociar la conexi$$HEX1$$f300$$ENDHEX$$n a base de datos con la ventana de datos", &
		StopSign!)
	this.postEvent(Close!)
	return
end if

// see if the dw needs args and if so copy them (with necessary conversions)
// from the window arg struct to the dw arg struct

if this.wf_copyArgs() = -1 then
	this.postEvent(close!)
	return
end if
	
if ib_notAutoRetrieve = False then dw_datos.uf_retrieve()

end event

event resize;call super::resize;dataWindow ldw_aux

if this.ib_inReportMode then
	ldw_aux = dw_report
else
	ldw_aux = dw_datos
end if

ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight() - 2*ldw_aux.y)

end event

type dw_datos from uo_dw_basic within w_sheet_1_dw
integer y = 4
integer width = 1495
integer height = 828
integer taborder = 10
end type

type dw_report from datawindow within w_sheet_1_dw
boolean visible = false
integer y = 32
integer width = 1467
integer height = 360
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

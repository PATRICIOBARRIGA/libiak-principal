HA$PBExportHeader$w_rep_crucerecaps.srw
$PBExportComments$Si.
forward
global type w_rep_crucerecaps from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_rep_crucerecaps
end type
type em_2 from editmask within w_rep_crucerecaps
end type
type st_1 from statictext within w_rep_crucerecaps
end type
type st_2 from statictext within w_rep_crucerecaps
end type
type st_3 from statictext within w_rep_crucerecaps
end type
end forward

global type w_rep_crucerecaps from w_sheet_1_dw_maint
integer width = 3259
integer height = 1720
string title = "Cobro de Recaps"
long backcolor = 81324524
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_rep_crucerecaps w_rep_crucerecaps

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint (); dw_report.modify("st_empresa.text = '"+gs_empresa+"'")
 return 1
end function

on w_rep_crucerecaps.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
end on

on w_rep_crucerecaps.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;em_1.setfocus()


dw_datos.sharedata(dw_report)

end event

event ue_retrieve;Datawindowchild dwc
date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_datos.GetChild('cb_cruce_bt_codigo',dwc)
dwc.SetTransObject(sqlca)
dwc.retrieve('1','1')
dw_datos.retrieve(ld_ini,ld_fin)
end event

event close;call super::close;dw_datos.sharedataoff()
end event

event ue_print;ib_inreportmode = true

call super::ue_print

end event

event activate;call super::activate;m_marco.m_archivo.m_salvarcomo.visible = True
m_marco.m_archivo.m_salvarcomo.enabled = True

end event

event ue_saveas;call super::ue_saveas;integer li_res
li_res = dw_datos.saveas()
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_rep_crucerecaps
integer y = 124
integer width = 3209
integer height = 1460
integer taborder = 30
string dataobject = "d_rep_crucerecaps2"
boolean hsplitscroll = true
end type

event dw_datos::clicked;call super::clicked;datawindowchild dwc

string ls_cobro

CHOOSE CASE this.GetColumnName()
	CASE 'cb_cruce_bt_codigo'
		if isnull(row) or row <= 0 then return
		ls_cobro = this.GetItemString(row,'cb_cruce_bt_codigo')
		dw_datos.GetChild('cb_cruce_bt_codigo',dwc)
		dwc.SetTransObject(sqlca)
		dwc.Retrieve(str_appgeninfo.empresa,ls_cobro)
END CHOOSE
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_rep_crucerecaps
integer x = 14
integer y = 128
integer width = 3177
integer height = 1448
integer taborder = 40
string dataobject = "d_rep_crucerecaps"
boolean hscrollbar = false
end type

type em_1 from editmask within w_rep_crucerecaps
integer x = 1102
integer y = 32
integer width = 343
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

type em_2 from editmask within w_rep_crucerecaps
integer x = 1714
integer y = 32
integer width = 343
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

type st_1 from statictext within w_rep_crucerecaps
integer x = 914
integer y = 40
integer width = 178
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

type st_2 from statictext within w_rep_crucerecaps
integer x = 1568
integer y = 40
integer width = 146
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
string text = "Hasta:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rep_crucerecaps
integer x = 32
integer y = 36
integer width = 786
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
string text = "Ingrese rango de fechas del cobro:"
alignment alignment = center!
boolean focusrectangle = false
end type


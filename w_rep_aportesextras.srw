HA$PBExportHeader$w_rep_aportesextras.srw
$PBExportComments$Si.Contiene el anexo para envio de aportes extras al iess
forward
global type w_rep_aportesextras from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_aportesextras
end type
type st_1 from statictext within w_rep_aportesextras
end type
end forward

global type w_rep_aportesextras from w_sheet_1_dw_rep
integer width = 2624
integer height = 1692
string title = "Aportes extras IESS"
long backcolor = 67108864
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
em_1 em_1
st_1 st_1
end type
global w_rep_aportesextras w_rep_aportesextras

on w_rep_aportesextras.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
end on

on w_rep_aportesextras.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
end on

event ue_retrieve;SetPointer(Hourglass!)
dw_datos.retrieve(em_1.text)
dw_report.retrieve(em_1.text)
Setpointer(Arrow!)
end event

event ue_saveas;dw_report.saveas()
end event

event open;call super::open;dw_report.SetTransObject(sqlca)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_aportesextras
integer x = 32
integer y = 152
integer width = 2533
integer height = 1396
integer taborder = 20
string dataobject = "d_rep_anexos_iess2"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_aportesextras
integer x = 73
integer y = 1004
integer width = 1061
integer height = 384
integer taborder = 0
string dataobject = "d_rep_anexos_iess"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_aportesextras
integer x = 1230
integer y = 988
integer taborder = 0
end type

type em_1 from editmask within w_rep_aportesextras
integer x = 274
integer y = 36
integer width = 288
integer height = 76
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
string mask = "mm-yyyy"
end type

type st_1 from statictext within w_rep_aportesextras
integer x = 69
integer y = 48
integer width = 197
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
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo:"
boolean focusrectangle = false
end type


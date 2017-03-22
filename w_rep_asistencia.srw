HA$PBExportHeader$w_rep_asistencia.srw
$PBExportComments$Si.
forward
global type w_rep_asistencia from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_asistencia
end type
type em_2 from editmask within w_rep_asistencia
end type
type st_1 from statictext within w_rep_asistencia
end type
type st_2 from statictext within w_rep_asistencia
end type
end forward

global type w_rep_asistencia from w_sheet_1_dw_rep
integer width = 3104
integer height = 1780
string title = "Asistencia"
long backcolor = 81324524
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_rep_asistencia w_rep_asistencia

on w_rep_asistencia.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_rep_asistencia.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_datos.retrieve(str_appgeninfo.empresa,ld_ini,ld_fin)
end event

event open;call super::open;em_1.text = string(today())
em_2.text = string(today())
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_asistencia
integer x = 5
integer y = 156
integer width = 3049
integer height = 1512
integer taborder = 30
string dataobject = "d_rep_asistencia"
end type

event dw_datos::retrievestart;call super::retrievestart;this.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_asistencia
integer taborder = 40
end type

type em_1 from editmask within w_rep_asistencia
integer x = 224
integer y = 32
integer width = 361
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_asistencia
integer x = 818
integer y = 32
integer width = 361
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
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

type st_1 from statictext within w_rep_asistencia
integer x = 37
integer y = 44
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

type st_2 from statictext within w_rep_asistencia
integer x = 622
integer y = 44
integer width = 174
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


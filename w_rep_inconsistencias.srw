HA$PBExportHeader$w_rep_inconsistencias.srw
forward
global type w_rep_inconsistencias from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_inconsistencias
end type
type em_2 from editmask within w_rep_inconsistencias
end type
type st_1 from statictext within w_rep_inconsistencias
end type
type st_2 from statictext within w_rep_inconsistencias
end type
end forward

global type w_rep_inconsistencias from w_sheet_1_dw_rep
integer width = 2505
integer height = 1380
string title = "Demanda insatisfecha e inconsistencias"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_rep_inconsistencias w_rep_inconsistencias

on w_rep_inconsistencias.create
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

on w_rep_inconsistencias.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)


dw_datos.retrieve(ld_ini,ld_fin)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_inconsistencias
integer x = 9
integer y = 172
integer width = 2441
integer height = 1080
string dataobject = "d_rep_inconsistencias_e_insatisfechas"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_inconsistencias
end type

type em_1 from editmask within w_rep_inconsistencias
integer x = 265
integer y = 44
integer width = 343
integer height = 76
integer taborder = 30
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

type em_2 from editmask within w_rep_inconsistencias
integer x = 937
integer y = 44
integer width = 343
integer height = 76
integer taborder = 40
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

type st_1 from statictext within w_rep_inconsistencias
integer x = 46
integer y = 52
integer width = 210
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
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_inconsistencias
integer x = 722
integer y = 52
integer width = 210
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
alignment alignment = center!
boolean focusrectangle = false
end type


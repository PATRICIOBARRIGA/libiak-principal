HA$PBExportHeader$w_rep_egresos.srw
$PBExportComments$Si.
forward
global type w_rep_egresos from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_egresos
end type
type em_2 from editmask within w_rep_egresos
end type
type st_1 from statictext within w_rep_egresos
end type
type st_2 from statictext within w_rep_egresos
end type
type cb_1 from commandbutton within w_rep_egresos
end type
end forward

global type w_rep_egresos from w_sheet_1_dw_rep
integer width = 2409
integer height = 1420
string title = "Egresos por fecha"
long backcolor = 79741120
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
cb_1 cb_1
end type
global w_rep_egresos w_rep_egresos

type variables
datetime idt_fini,idt_ffin
end variables

on w_rep_egresos.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_1
end on

on w_rep_egresos.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
end on

event open;ib_notautoretrieve = true
dw_report.SetTransObject(sqlca)
f_recupera_empresa(dw_datos,"cb_egreso_if_codigo")
call super::open
end event

event ue_retrieve;Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

idt_fini = datetime(ld_ini)
idt_ffin = datetime(ld_fin)

dw_datos.retrieve(idt_fini,idt_ffin)
end event

event ue_saveas;dw_datos.saveas()

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_egresos
integer x = 14
integer y = 160
integer width = 2345
integer height = 1160
integer taborder = 0
string dataobject = "d_rep_egresos"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_egresos
integer x = 59
integer y = 364
integer width = 864
integer taborder = 30
string dataobject = "d_banco"
end type

type em_1 from editmask within w_rep_egresos
integer x = 229
integer y = 36
integer width = 343
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "dd/mm/yyyy"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_egresos
integer x = 768
integer y = 36
integer width = 343
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "dd/mm/yyyy"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_rep_egresos
integer x = 41
integer y = 48
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
string text = "Desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_egresos
integer x = 613
integer y = 48
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

type cb_1 from commandbutton within w_rep_egresos
integer x = 1769
integer y = 40
integer width = 558
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Archivo para el banco"
end type

event clicked;dw_report.retrieve(idt_fini,idt_ffin)
dw_report.saveas()
end event


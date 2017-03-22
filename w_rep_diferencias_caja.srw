HA$PBExportHeader$w_rep_diferencias_caja.srw
forward
global type w_rep_diferencias_caja from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_diferencias_caja
end type
type st_2 from statictext within w_rep_diferencias_caja
end type
type em_1 from editmask within w_rep_diferencias_caja
end type
type em_2 from editmask within w_rep_diferencias_caja
end type
end forward

global type w_rep_diferencias_caja from w_sheet_1_dw_rep
integer width = 2862
integer height = 1676
string title = "Diferencias en Caja"
long backcolor = 67108864
st_1 st_1
st_2 st_2
em_1 em_1
em_2 em_2
end type
global w_rep_diferencias_caja w_rep_diferencias_caja

on w_rep_diferencias_caja.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.em_1=create em_1
this.em_2=create em_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
end on

on w_rep_diferencias_caja.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.em_2)
end on

event open;ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;Date ld_fecini,ld_fecfin

ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)

dw_datos.retrieve(str_appgeninfo.empresa, datetime(ld_fecini),datetime(ld_fecfin))

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_diferencias_caja
integer x = 5
integer y = 196
integer width = 2807
integer height = 1376
string dataobject = "d_rep_faltantes_sobrantes_caja"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_diferencias_caja
integer x = 146
integer y = 1052
integer height = 444
end type

type st_1 from statictext within w_rep_diferencias_caja
integer x = 50
integer y = 68
integer width = 183
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

type st_2 from statictext within w_rep_diferencias_caja
integer x = 731
integer y = 68
integer width = 169
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

type em_1 from editmask within w_rep_diferencias_caja
integer x = 238
integer y = 56
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_diferencias_caja
integer x = 887
integer y = 56
integer width = 398
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type


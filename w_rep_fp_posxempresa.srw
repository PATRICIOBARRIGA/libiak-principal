HA$PBExportHeader$w_rep_fp_posxempresa.srw
$PBExportComments$Pantalla para ubicar los cheques de un cliente dado
forward
global type w_rep_fp_posxempresa from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_fp_posxempresa
end type
type st_1 from statictext within w_rep_fp_posxempresa
end type
type st_2 from statictext within w_rep_fp_posxempresa
end type
type st_3 from statictext within w_rep_fp_posxempresa
end type
type st_4 from statictext within w_rep_fp_posxempresa
end type
type em_2 from editmask within w_rep_fp_posxempresa
end type
end forward

global type w_rep_fp_posxempresa from w_sheet_1_dw_rep
integer width = 2715
integer height = 2612
string title = "Formas de Pago en la Empresa"
long backcolor = 67108864
em_1 em_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
em_2 em_2
end type
global w_rep_fp_posxempresa w_rep_fp_posxempresa

on w_rep_fp_posxempresa.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.em_2=create em_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.em_2
end on

on w_rep_fp_posxempresa.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.em_2)
end on

event open;ib_notautoretrieve = true
call super::open





end event

event ue_retrieve;date ld_fecini,ld_fecfin
integer li_nreg

setpointer(hourglass!)
dw_datos.accepttext()
ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)
dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
li_nreg = dw_datos.retrieve(ld_fecini,ld_fecfin)
if li_nreg = 0 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones")
	return
end if
setpointer(arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_fp_posxempresa
integer x = 18
integer y = 204
integer width = 2638
integer height = 2276
integer taborder = 30
string dataobject = "d_rep_ventas_fp_x_empresa"
boolean hscrollbar = false
boolean border = true
boolean livescroll = false
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_fp_posxempresa
integer x = 37
integer y = 260
integer width = 224
integer height = 212
integer taborder = 0
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_fp_posxempresa
end type

type em_1 from editmask within w_rep_fp_posxempresa
integer x = 229
integer y = 48
integer width = 343
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_fp_posxempresa
integer x = 32
integer y = 60
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

type st_2 from statictext within w_rep_fp_posxempresa
integer x = 658
integer y = 60
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
string text = "Hasta:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rep_fp_posxempresa
integer x = 215
integer y = 128
integer width = 357
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/aaaa]"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rep_fp_posxempresa
integer x = 823
integer y = 128
integer width = 357
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/aaaa]"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_2 from editmask within w_rep_fp_posxempresa
integer x = 841
integer y = 48
integer width = 343
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type


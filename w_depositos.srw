HA$PBExportHeader$w_depositos.srw
$PBExportComments$Si.
forward
global type w_depositos from w_sheet_1_dw_rep
end type
type sle_1 from singlelineedit within w_depositos
end type
type st_1 from statictext within w_depositos
end type
end forward

global type w_depositos from w_sheet_1_dw_rep
integer width = 2281
integer height = 1472
string title = "Consulta dep$$HEX1$$f300$$ENDHEX$$sitos"
long backcolor = 81324524
sle_1 sle_1
st_1 st_1
end type
global w_depositos w_depositos

on w_depositos.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
end on

on w_depositos.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
end on

event open;ib_notautoretrieve = true
call super:: open
end event

event ue_retrieve;string        ls_deposito
ls_deposito = sle_1.text

dw_datos.retrieve(str_appgeninfo.empresa,ls_deposito)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_depositos
integer x = 18
integer y = 164
integer width = 2213
integer height = 1168
string dataobject = "d_depositos"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_depositos
integer x = 142
integer y = 660
end type

type sle_1 from singlelineedit within w_depositos
integer x = 663
integer y = 36
integer width = 343
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
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_depositos
integer x = 50
integer y = 44
integer width = 599
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
string text = "Ingrese el Nro de dep$$HEX1$$f300$$ENDHEX$$sito:"
boolean focusrectangle = false
end type


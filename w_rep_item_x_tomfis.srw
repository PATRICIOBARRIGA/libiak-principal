HA$PBExportHeader$w_rep_item_x_tomfis.srw
$PBExportComments$Si.
forward
global type w_rep_item_x_tomfis from w_sheet_1_dw_rep
end type
type sle_1 from singlelineedit within w_rep_item_x_tomfis
end type
type st_1 from statictext within w_rep_item_x_tomfis
end type
end forward

global type w_rep_item_x_tomfis from w_sheet_1_dw_rep
integer width = 2875
integer height = 1800
long backcolor = 67108864
sle_1 sle_1
st_1 st_1
end type
global w_rep_item_x_tomfis w_rep_item_x_tomfis

event open;ib_notautoretrieve = true
call super::open

end event

event ue_retrieve;String ls_item
ls_item  = sle_1.text

dw_datos.retrieve(ls_item)
end event

on w_rep_item_x_tomfis.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
end on

on w_rep_item_x_tomfis.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
end on

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_item_x_tomfis
integer x = 18
integer y = 176
integer width = 2821
integer height = 1524
integer taborder = 20
string dataobject = "d_rep_item_x_tomfis"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_item_x_tomfis
integer x = 9
integer y = 172
integer width = 2834
integer height = 1504
integer taborder = 30
string dataobject = "d_rep_item_x_tomfis"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_1 from singlelineedit within w_rep_item_x_tomfis
integer x = 686
integer y = 52
integer width = 558
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
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rep_item_x_tomfis
integer x = 64
integer y = 56
integer width = 576
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
string text = "Ingrese el c$$HEX1$$f300$$ENDHEX$$digo del Item:"
boolean focusrectangle = false
end type


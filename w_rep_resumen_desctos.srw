HA$PBExportHeader$w_rep_resumen_desctos.srw
$PBExportComments$Si.
forward
global type w_rep_resumen_desctos from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_resumen_desctos
end type
type sle_1 from singlelineedit within w_rep_resumen_desctos
end type
type st_2 from statictext within w_rep_resumen_desctos
end type
end forward

global type w_rep_resumen_desctos from w_sheet_1_dw_rep
integer width = 3470
integer height = 1716
string title = "Resumen de descuentos"
long backcolor = 67108864
boolean ib_notautoretrieve = true
st_1 st_1
sle_1 sle_1
st_2 st_2
end type
global w_rep_resumen_desctos w_rep_resumen_desctos

on w_rep_resumen_desctos.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.st_2
end on

on w_rep_resumen_desctos.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.st_2)
end on

event ue_retrieve;String ls_item

ls_item = sle_1.text
dw_datos.retrieve(ls_item)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_resumen_desctos
integer x = 5
integer y = 196
integer width = 3401
integer height = 1404
string dataobject = "d_rep_desctos_x_linea"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_resumen_desctos
integer x = 91
integer y = 772
string dataobject = "d_rep_desctos_x_linea"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_resumen_desctos
integer x = 475
integer y = 736
end type

type st_1 from statictext within w_rep_resumen_desctos
integer x = 37
integer y = 24
integer width = 1056
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
string text = "Descuentos por tipo de cliente."
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rep_resumen_desctos
integer x = 681
integer y = 108
integer width = 2039
integer height = 64
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "%"
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_rep_resumen_desctos
integer x = 37
integer y = 112
integer width = 635
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingrese descripci$$HEX1$$f300$$ENDHEX$$n del Item:"
boolean focusrectangle = false
end type


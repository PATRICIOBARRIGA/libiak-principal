HA$PBExportHeader$w_roles_x_objeto.srw
forward
global type w_roles_x_objeto from w_sheet_1_dw_rep
end type
type sle_1 from singlelineedit within w_roles_x_objeto
end type
type st_1 from statictext within w_roles_x_objeto
end type
type st_2 from statictext within w_roles_x_objeto
end type
end forward

global type w_roles_x_objeto from w_sheet_1_dw_rep
integer width = 2779
integer height = 1608
string title = "Roles por opci$$HEX1$$f300$$ENDHEX$$n de men$$HEX1$$fa00$$ENDHEX$$"
long backcolor = 67108864
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
sle_1 sle_1
st_1 st_1
st_2 st_2
end type
global w_roles_x_objeto w_roles_x_objeto

on w_roles_x_objeto.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
end on

on w_roles_x_objeto.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_retrieve;String ls_opcion
ls_opcion = sle_1.text
dw_datos.retrieve(ls_opcion)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_roles_x_objeto
integer x = 18
integer y = 208
integer width = 2702
integer height = 1276
string dataobject = "d_roles_x_objeto"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_roles_x_objeto
integer x = 274
integer y = 876
string dataobject = "d_roles_x_objeto"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_roles_x_objeto
integer x = 215
integer y = 836
end type

type sle_1 from singlelineedit within w_roles_x_objeto
integer x = 480
integer y = 92
integer width = 1312
integer height = 88
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

type st_1 from statictext within w_roles_x_objeto
integer x = 64
integer y = 24
integer width = 1737
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
string text = "Escriba el nombre de la opci$$HEX1$$f300$$ENDHEX$$n de men$$HEX2$$fa002000$$ENDHEX$$para saber a que roles est$$HEX2$$e1002000$$ENDHEX$$asignado."
boolean focusrectangle = false
end type

type st_2 from statictext within w_roles_x_objeto
integer x = 59
integer y = 104
integer width = 402
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opci$$HEX1$$f300$$ENDHEX$$n de men$$HEX1$$fa00$$ENDHEX$$:"
boolean focusrectangle = false
end type


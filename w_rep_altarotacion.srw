HA$PBExportHeader$w_rep_altarotacion.srw
$PBExportComments$Vale
forward
global type w_rep_altarotacion from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_altarotacion
end type
type em_2 from editmask within w_rep_altarotacion
end type
type st_1 from statictext within w_rep_altarotacion
end type
type st_2 from statictext within w_rep_altarotacion
end type
type cb_1 from commandbutton within w_rep_altarotacion
end type
type cb_2 from commandbutton within w_rep_altarotacion
end type
end forward

global type w_rep_altarotacion from w_sheet_1_dw_rep
integer width = 2290
integer height = 1180
string title = "Productos con Alta Rotaci$$HEX1$$f300$$ENDHEX$$n"
long backcolor = 79741120
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
cb_1 cb_1
cb_2 cb_2
end type
global w_rep_altarotacion w_rep_altarotacion

on w_rep_altarotacion.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
end on

on w_rep_altarotacion.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_retrieve;Date ld_fini,ld_ffin

ld_fini = date(em_1.text)
ld_ffin = date(em_2.text)

dw_datos.retrieve(ld_fini,ld_ffin)
end event

event resize;this.setRedraw(False)
dw_datos.resize(this.workSpaceWidth() - dw_datos.x, this.workSpaceHeight() - dw_datos.y)
this.setRedraw(True)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_altarotacion
integer x = 14
integer y = 132
integer width = 2217
integer height = 920
integer taborder = 30
string dataobject = "d_rep_altarotacion"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_altarotacion
integer x = 32
integer y = 256
integer taborder = 40
end type

type em_1 from editmask within w_rep_altarotacion
integer x = 384
integer y = 24
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
long backcolor = 16777215
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type em_2 from editmask within w_rep_altarotacion
integer x = 992
integer y = 20
integer width = 343
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_rep_altarotacion
integer x = 187
integer y = 32
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
string text = "Desde :"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_altarotacion
integer x = 823
integer y = 32
integer width = 155
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

type cb_1 from commandbutton within w_rep_altarotacion
integer x = 1440
integer y = 24
integer width = 343
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
end type

event clicked;parent.triggerevent("ue_retrieve")
end event

type cb_2 from commandbutton within w_rep_altarotacion
integer x = 1847
integer y = 24
integer width = 343
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtrar"
end type

event clicked;String ls_nulo

Setnull(ls_nulo)
dw_datos.Setfilter(ls_nulo)
dw_datos.Filter()
end event


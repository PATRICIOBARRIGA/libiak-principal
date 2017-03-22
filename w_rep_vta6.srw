HA$PBExportHeader$w_rep_vta6.srw
$PBExportComments$Ventas por plazo
forward
global type w_rep_vta6 from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_vta6
end type
type em_2 from editmask within w_rep_vta6
end type
type st_2 from statictext within w_rep_vta6
end type
type st_1 from statictext within w_rep_vta6
end type
type rb_1 from radiobutton within w_rep_vta6
end type
type rb_2 from radiobutton within w_rep_vta6
end type
type rb_3 from radiobutton within w_rep_vta6
end type
type rb_4 from radiobutton within w_rep_vta6
end type
type st_3 from statictext within w_rep_vta6
end type
type rr_1 from roundrectangle within w_rep_vta6
end type
end forward

global type w_rep_vta6 from w_sheet_1_dw_rep
integer width = 3191
integer height = 1816
string title = "Ventas"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_2 st_2
st_1 st_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
st_3 st_3
rr_1 rr_1
end type
global w_rep_vta6 w_rep_vta6

type variables
boolean ib_cancel
end variables

on w_rep_vta6.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.st_3=create st_3
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.rr_1
end on

on w_rep_vta6.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.st_3)
destroy(this.rr_1)
end on

event ue_retrieve;Integer index
Date  ld_ini,ld_fin

SetPointer(Hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n.....por favor espere....!!!")


index  = message.DoubleParm

if rb_1.checked then dw_datos.dataobject = 'd_rep_ventas_x_plazos'  
if rb_2.checked then dw_datos.dataobject = 'd_fin_ventas_x_mes_empresa' /*Resumen*/
if rb_3.checked then dw_datos.dataobject = 'd_ventas_x_mes_empresa'       /*Detalle*/
if rb_4.checked then dw_datos.dataobject = 'd_ventas_x_mes_empresa_unid' 


dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ld_ini,ld_fin)
w_marco.SetMicrohelp("Listo....!!!")

SetPointer(Arrow!)
end event

event activate;call super::activate;em_1.Setfocus()
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_vta6
integer x = 37
integer y = 308
integer width = 3086
integer height = 1376
string dataobject = "d_rep_ventas_x_plazos"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_vta6
integer x = 1705
integer y = 812
integer taborder = 60
string dataobject = "d_rep_ventydev_resum_x_asesor"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_vta6
integer x = 681
integer y = 952
integer taborder = 90
end type

type em_1 from editmask within w_rep_vta6
integer x = 274
integer y = 52
integer width = 343
integer height = 72
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
boolean autoskip = true
end type

type em_2 from editmask within w_rep_vta6
integer x = 923
integer y = 52
integer width = 343
integer height = 72
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

type st_2 from statictext within w_rep_vta6
integer x = 55
integer y = 60
integer width = 215
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

type st_1 from statictext within w_rep_vta6
integer x = 663
integer y = 60
integer width = 251
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

type rb_1 from radiobutton within w_rep_vta6
integer x = 1353
integer y = 52
integer width = 718
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ventas por plazo de cr$$HEX1$$e900$$ENDHEX$$dito"
end type

type rb_2 from radiobutton within w_rep_vta6
integer x = 2272
integer y = 92
integer width = 320
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen"
end type

type rb_3 from radiobutton within w_rep_vta6
integer x = 2272
integer y = 180
integer width = 343
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
string text = "Detalle"
end type

type rb_4 from radiobutton within w_rep_vta6
integer x = 2766
integer y = 176
integer width = 325
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unidades"
end type

type st_3 from statictext within w_rep_vta6
integer x = 2203
integer y = 28
integer width = 585
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
string text = "Por segmento de mercado"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_rep_vta6
long linecolor = 10789024
integer linethickness = 4
long fillcolor = 67108864
integer x = 2139
integer y = 56
integer width = 978
integer height = 224
integer cornerheight = 40
integer cornerwidth = 46
end type


HA$PBExportHeader$w_rep_cartera_vencida_cxc.srw
forward
global type w_rep_cartera_vencida_cxc from w_sheet_1_dw_rep
end type
type sle_1 from singlelineedit within w_rep_cartera_vencida_cxc
end type
type st_1 from statictext within w_rep_cartera_vencida_cxc
end type
type rb_1 from radiobutton within w_rep_cartera_vencida_cxc
end type
type rb_2 from radiobutton within w_rep_cartera_vencida_cxc
end type
type rb_3 from radiobutton within w_rep_cartera_vencida_cxc
end type
type st_2 from statictext within w_rep_cartera_vencida_cxc
end type
type dw_1 from datawindow within w_rep_cartera_vencida_cxc
end type
type rb_4 from radiobutton within w_rep_cartera_vencida_cxc
end type
type st_3 from statictext within w_rep_cartera_vencida_cxc
end type
end forward

global type w_rep_cartera_vencida_cxc from w_sheet_1_dw_rep
integer width = 4046
integer height = 2028
long backcolor = 67108864
boolean ib_notautoretrieve = true
sle_1 sle_1
st_1 st_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
st_2 st_2
dw_1 dw_1
rb_4 rb_4
st_3 st_3
end type
global w_rep_cartera_vencida_cxc w_rep_cartera_vencida_cxc

on w_rep_cartera_vencida_cxc.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.st_2=create st_2
this.dw_1=create dw_1
this.rb_4=create rb_4
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_3
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.st_3
end on

on w_rep_cartera_vencida_cxc.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.rb_4)
destroy(this.st_3)
end on

event ue_retrieve;date ld_hoy

select trunc(sysdate)
into :ld_hoy
from dual;

if rb_1.checked then
dw_datos.Dataobject = 'd_rep_cartera_vencida_x_cliente'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(integer(sle_1.text),str_appgeninfo.empresa,ld_hoy,dw_1.object.ce_codigo[1]	)
end if

if rb_2.checked then
dw_datos.Dataobject = 'd_rep_cartera_vencida'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(integer(sle_1.text),str_appgeninfo.empresa,ld_hoy)
end if 

if rb_3.checked then
dw_datos.Dataobject = 'd_rep_cartera_vencida_x_resumen'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(integer(sle_1.text),str_appgeninfo.empresa,ld_hoy)
end if 

if rb_4.checked then
dw_datos.Dataobject = 'd_rep_cartera_x_plazos'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(str_appgeninfo.empresa,ld_hoy,Integer(sle_1.text))
end if 

end event

event open;call super::open;f_recupera_empresa(dw_1,"ce_codigo")
dw_1.insertrow(0)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cartera_vencida_cxc
integer x = 23
integer y = 296
integer width = 3959
integer height = 1580
integer taborder = 20
string dataobject = "d_rep_cartera_vencida_debitos"
end type

event dw_datos::retrievestart;call super::retrievestart;This.Modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cartera_vencida_cxc
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_cartera_vencida_cxc
integer taborder = 40
end type

type sle_1 from singlelineedit within w_rep_cartera_vencida_cxc
integer x = 1207
integer y = 48
integer width = 197
integer height = 68
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

type st_1 from statictext within w_rep_cartera_vencida_cxc
integer x = 41
integer y = 48
integer width = 1166
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
string text = "Ingrese el n$$HEX1$$fa00$$ENDHEX$$mero de d$$HEX1$$ed00$$ENDHEX$$as para c$$HEX1$$e100$$ENDHEX$$lculo de la cartera:"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_cartera_vencida_cxc
integer x = 2254
integer y = 128
integer width = 343
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
string text = "Por cliente"
end type

type rb_2 from radiobutton within w_rep_cartera_vencida_cxc
integer x = 1184
integer y = 140
integer width = 334
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
string text = "D$$HEX1$$e900$$ENDHEX$$bitos"
end type

type rb_3 from radiobutton within w_rep_cartera_vencida_cxc
integer x = 526
integer y = 140
integer width = 293
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

type st_2 from statictext within w_rep_cartera_vencida_cxc
integer x = 37
integer y = 144
integer width = 407
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
string text = "Todos los clientes"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_rep_cartera_vencida_cxc
integer x = 2249
integer y = 196
integer width = 1408
integer height = 88
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_clientes"
boolean border = false
boolean livescroll = true
end type

type rb_4 from radiobutton within w_rep_cartera_vencida_cxc
integer x = 1184
integer y = 208
integer width = 768
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
string text = "D$$HEX1$$e900$$ENDHEX$$bitos y cheques diferidos"
end type

type st_3 from statictext within w_rep_cartera_vencida_cxc
integer x = 987
integer y = 148
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
string text = "Detalle"
boolean focusrectangle = false
end type


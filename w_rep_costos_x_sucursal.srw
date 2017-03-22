HA$PBExportHeader$w_rep_costos_x_sucursal.srw
forward
global type w_rep_costos_x_sucursal from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_costos_x_sucursal
end type
type em_2 from editmask within w_rep_costos_x_sucursal
end type
type st_1 from statictext within w_rep_costos_x_sucursal
end type
type st_2 from statictext within w_rep_costos_x_sucursal
end type
type dw_1 from datawindow within w_rep_costos_x_sucursal
end type
type rb_1 from radiobutton within w_rep_costos_x_sucursal
end type
type cbx_1 from checkbox within w_rep_costos_x_sucursal
end type
type cbx_2 from checkbox within w_rep_costos_x_sucursal
end type
type cbx_3 from checkbox within w_rep_costos_x_sucursal
end type
type cbx_4 from checkbox within w_rep_costos_x_sucursal
end type
type cbx_5 from checkbox within w_rep_costos_x_sucursal
end type
type rb_2 from radiobutton within w_rep_costos_x_sucursal
end type
end forward

global type w_rep_costos_x_sucursal from w_sheet_1_dw_rep
integer width = 4850
integer height = 2524
string title = "Detalle de costos por sucursal"
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
dw_1 dw_1
rb_1 rb_1
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
rb_2 rb_2
end type
global w_rep_costos_x_sucursal w_rep_costos_x_sucursal

type variables

end variables

event ue_retrieve;/**/
String ls_sucursal,ls_tipomov
Date ld_ini,ld_fin
Int li_mov,li_sucursal,&
     li_estado[2]



Setpointer(Hourglass!)

if rb_1.checked then /*Ventas*/
	li_mov = 2
	ls_tipomov = 'E'
	if cbx_2.checked then li_estado[1] = 1
	if cbx_3.checked then li_estado[2] = 2
end if


if rb_2.checked then /*Devoluciones*/
	li_mov = 5
	ls_tipomov = 'I'
	if cbx_4.checked then li_estado[1] = 9
	if cbx_5.checked then li_estado[2] = 10
end if

ls_sucursal = dw_1.object.sucursal[1] 


ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if cbx_1.checked  then /*Empresarial*/
dw_datos.dataObject = 'd_rep_costos_x_empresa'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(li_mov,ls_tipomov,ld_ini,ld_fin,li_estado)
else
dw_datos.dataObject = 'd_rep_costos_x_sucursal'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(li_mov,ls_tipomov,Integer(ls_sucursal),ld_ini,ld_fin,li_estado)
end if
dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
Setpointer(Arrow!)
end event

on w_rep_costos_x_sucursal.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.rb_1=create rb_1
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.cbx_2
this.Control[iCurrent+9]=this.cbx_3
this.Control[iCurrent+10]=this.cbx_4
this.Control[iCurrent+11]=this.cbx_5
this.Control[iCurrent+12]=this.rb_2
end on

on w_rep_costos_x_sucursal.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.rb_2)
end on

event open;ib_notautoretrieve = true

dw_1.insertrow(0)
f_recupera_empresa(dw_1,"sucursal")
f_recupera_empresa(dw_datos,"in_movim_su_codigo")

call super::open

end event

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_costos_x_sucursal
integer x = 32
integer y = 368
integer width = 4768
integer height = 2032
integer taborder = 130
string title = "Costos por sucursal"
string dataobject = "d_rep_costos_x_sucursal"
boolean vscrollbar = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_costos_x_sucursal
integer x = 133
integer y = 1320
integer taborder = 110
string dataobject = "d_rep_costos_x_sucursal"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_costos_x_sucursal
integer x = 1179
integer y = 1332
integer taborder = 20
end type

type em_1 from editmask within w_rep_costos_x_sucursal
integer x = 393
integer y = 44
integer width = 343
integer height = 76
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

type em_2 from editmask within w_rep_costos_x_sucursal
integer x = 955
integer y = 40
integer width = 343
integer height = 80
integer taborder = 40
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

type st_1 from statictext within w_rep_costos_x_sucursal
integer x = 155
integer y = 52
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

type st_2 from statictext within w_rep_costos_x_sucursal
integer x = 791
integer y = 52
integer width = 151
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

type dw_1 from datawindow within w_rep_costos_x_sucursal
integer x = 55
integer y = 128
integer width = 1531
integer height = 212
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_sucursal"
boolean border = false
boolean livescroll = true
end type

type rb_1 from radiobutton within w_rep_costos_x_sucursal
integer x = 1847
integer y = 44
integer width = 343
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Ventas"
boolean checked = true
end type

event clicked;cbx_4.checked=false
cbx_5.checked=false
end event

type cbx_1 from checkbox within w_rep_costos_x_sucursal
integer x = 1449
integer y = 48
integer width = 320
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Empresa"
end type

type cbx_2 from checkbox within w_rep_costos_x_sucursal
integer x = 1938
integer y = 128
integer width = 777
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por mayor FxM                      (1)"
end type

type cbx_3 from checkbox within w_rep_costos_x_sucursal
integer x = 1938
integer y = 196
integer width = 805
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Punto de venta P.O.S.           (2)"
end type

type cbx_4 from checkbox within w_rep_costos_x_sucursal
integer x = 2953
integer y = 136
integer width = 768
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Devoluci$$HEX1$$f300$$ENDHEX$$n FxM                     (9)"
end type

type cbx_5 from checkbox within w_rep_costos_x_sucursal
integer x = 2953
integer y = 204
integer width = 814
integer height = 72
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Devoluci$$HEX1$$f300$$ENDHEX$$n P.O.S.                (10)"
end type

type rb_2 from radiobutton within w_rep_costos_x_sucursal
integer x = 2862
integer y = 44
integer width = 453
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Devoluciones"
end type

event clicked;cbx_2.checked=false
cbx_3.checked=false
end event


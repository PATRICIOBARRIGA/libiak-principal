HA$PBExportHeader$w_anexos_compras.srw
$PBExportComments$Si.
forward
global type w_anexos_compras from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_anexos_compras
end type
type rb_2 from radiobutton within w_anexos_compras
end type
type rb_3 from radiobutton within w_anexos_compras
end type
type st_1 from statictext within w_anexos_compras
end type
type st_2 from statictext within w_anexos_compras
end type
type dw_1 from datawindow within w_anexos_compras
end type
type rb_4 from radiobutton within w_anexos_compras
end type
end forward

global type w_anexos_compras from w_sheet_1_dw_rep
integer width = 2912
integer height = 1944
string title = "Anexos Compras"
long backcolor = 67108864
boolean ib_notautoretrieve = true
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
st_1 st_1
st_2 st_2
dw_1 dw_1
rb_4 rb_4
end type
global w_anexos_compras w_anexos_compras

event ue_retrieve;
if rb_1.Checked then
dw_datos.Dataobject = 'd_anexo_transaccional_compras_retfte'
end if

if rb_2.Checked then
dw_datos.Dataobject = 'd_anexo_transaccional_compras_sinretfte2'
end if

if rb_3.Checked then
dw_datos.Dataobject = 'd_anexo_transaccional_nc'
end if

if rb_4.Checked then
dw_datos.Dataobject = 'd_anexo_transaccional_nc_agrupado'
end if

dw_datos.SetTransObject(sqlca)
dw_datos.retrieve()

//dw_1.SetTransObject(sqlca)
//dw_1.retrieve()
end event

on w_anexos_compras.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.rb_4=create rb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.rb_4
end on

on w_anexos_compras.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.rb_4)
end on

event open;call super::open;//dw_1.setTransObject(sqlca)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_anexos_compras
integer x = 73
integer y = 376
integer width = 2752
integer height = 1336
string dataobject = "d_anexo_transaccional_compras_retfte"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_anexos_compras
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_anexos_compras
end type

type rb_1 from radiobutton within w_anexos_compras
integer x = 123
integer y = 40
integer width = 430
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
string text = "Con retenciones"
boolean checked = true
end type

type rb_2 from radiobutton within w_anexos_compras
integer x = 123
integer y = 120
integer width = 443
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
string text = "Sin retenciones"
end type

type rb_3 from radiobutton within w_anexos_compras
integer x = 123
integer y = 196
integer width = 453
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
string text = "Notas de cr$$HEX1$$e900$$ENDHEX$$dito"
end type

type st_1 from statictext within w_anexos_compras
integer x = 681
integer y = 28
integer width = 2103
integer height = 184
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione el tipo de anexo que requiere; una vez seleccionado recupere la informaci$$HEX1$$f300$$ENDHEX$$n utilizando el icono RECUPERAR FILAS desde el menu principal o con la combinaci$$HEX1$$f300$$ENDHEX$$n de teclas CTRL + R. Ingrese los par$$HEX1$$e100$$ENDHEX$$metros de recuperaci$$HEX1$$f300$$ENDHEX$$n y pulse OK."
boolean focusrectangle = false
end type

type st_2 from statictext within w_anexos_compras
integer x = 686
integer y = 220
integer width = 992
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Para Mercader$$HEX1$$ed00$$ENDHEX$$a = 3, Bienes y Servicios =0"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_anexos_compras
boolean visible = false
integer x = 3099
integer y = 80
integer width = 206
integer height = 172
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_anexo_transaccional_compras_retftepru2"
boolean border = false
boolean livescroll = true
end type

type rb_4 from radiobutton within w_anexos_compras
integer x = 128
integer y = 284
integer width = 453
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
string text = "NC Agrupado"
end type


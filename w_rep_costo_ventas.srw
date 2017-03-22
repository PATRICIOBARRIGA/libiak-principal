HA$PBExportHeader$w_rep_costo_ventas.srw
$PBExportComments$Costo de Ventas
forward
global type w_rep_costo_ventas from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_costo_ventas
end type
type cb_1 from commandbutton within w_rep_costo_ventas
end type
type st_2 from statictext within w_rep_costo_ventas
end type
type em_1 from editmask within w_rep_costo_ventas
end type
end forward

global type w_rep_costo_ventas from w_sheet_1_dw_rep
integer width = 2807
integer height = 1472
string title = "Reporte de Costo de Ventas"
long backcolor = 77897888
st_1 st_1
cb_1 cb_1
st_2 st_2
em_1 em_1
end type
global w_rep_costo_ventas w_rep_costo_ventas

type variables
string   is_pepa 
end variables

on w_rep_costo_ventas.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.st_2=create st_2
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_1
end on

on w_rep_costo_ventas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.em_1)
end on

event open;this.ib_notautoretrieve = true
//dw_1.InsertRow(0)
call super::open
end event

event resize;call super::resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
//dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
//dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_costo_ventas
integer x = 0
integer y = 208
integer width = 2770
integer height = 1092
integer taborder = 20
string dataobject = "d_costos_x_factura"
boolean border = true
end type

event dw_datos::retrieveend;call super::retrieveend;dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
return 1
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_costo_ventas
integer x = 1399
integer y = 356
integer height = 216
integer taborder = 40
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_costo_ventas
end type

type st_1 from statictext within w_rep_costo_ventas
integer x = 37
integer y = 44
integer width = 224
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
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_rep_costo_ventas
integer x = 677
integer y = 40
integer width = 389
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
boolean default = true
end type

event clicked;String ls_fecha
ls_fecha = em_1.text 
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_fecha)
end event

type st_2 from statictext within w_rep_costo_ventas
integer x = 283
integer y = 116
integer width = 238
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
string text = "[mm-yyyy]"
boolean focusrectangle = false
end type

type em_1 from editmask within w_rep_costo_ventas
integer x = 256
integer y = 32
integer width = 279
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "00-0000"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "##-####"
boolean autoskip = true
end type


HA$PBExportHeader$w_rep_ventas_x_sucursal.srw
forward
global type w_rep_ventas_x_sucursal from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_ventas_x_sucursal
end type
type em_2 from editmask within w_rep_ventas_x_sucursal
end type
type ddlb_1 from dropdownlistbox within w_rep_ventas_x_sucursal
end type
type st_1 from statictext within w_rep_ventas_x_sucursal
end type
type st_2 from statictext within w_rep_ventas_x_sucursal
end type
type dw_1 from datawindow within w_rep_ventas_x_sucursal
end type
type rb_1 from radiobutton within w_rep_ventas_x_sucursal
end type
type rb_2 from radiobutton within w_rep_ventas_x_sucursal
end type
end forward

global type w_rep_ventas_x_sucursal from w_sheet_1_dw_rep
integer width = 2898
integer height = 2040
string title = "Detalle de ventas por sucursal"
long backcolor = 67108864
em_1 em_1
em_2 em_2
ddlb_1 ddlb_1
st_1 st_1
st_2 st_2
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_ventas_x_sucursal w_rep_ventas_x_sucursal

type variables
int ii_index
end variables

event ue_retrieve;/**/
String ls_sucursal
Date ld_ini,ld_fin
Int li_sucursal




ls_sucursal = dw_1.object.sucursal[1] 

if rb_2.checked and ii_index = 1 then ii_index = 9
if rb_2.checked and ii_index = 2 then ii_index = 10

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

Setpointer(Hourglass!)
dw_datos.retrieve(ii_index,ld_ini,ld_fin,Integer(ls_sucursal))
Setpointer(Arrow!)
end event

on w_rep_ventas_x_sucursal.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.ddlb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
end on

on w_rep_ventas_x_sucursal.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event open;ib_notautoretrieve = true

dw_1.insertrow(0)
f_recupera_empresa(dw_1,"sucursal")
f_recupera_empresa(dw_datos,"fa_detve_su_codigo")

call super::open

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ventas_x_sucursal
integer y = 328
integer width = 2816
integer height = 1580
integer taborder = 80
string dataobject = "d_relacion_costo_precio_x_suc"
boolean hsplitscroll = true
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ventas_x_sucursal
integer x = 50
integer y = 928
integer taborder = 60
string dataobject = "d_relacion_costo_precio_x_suc"
end type

type em_1 from editmask within w_rep_ventas_x_sucursal
integer x = 1920
integer y = 148
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
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_ventas_x_sucursal
integer x = 2464
integer y = 152
integer width = 343
integer height = 76
integer taborder = 70
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

type ddlb_1 from dropdownlistbox within w_rep_ventas_x_sucursal
integer x = 1102
integer y = 140
integer width = 599
integer height = 220
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Facturaci$$HEX1$$f300$$ENDHEX$$n por Mayor","P.O.S."}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_index = index
end event

type st_1 from statictext within w_rep_ventas_x_sucursal
integer x = 1733
integer y = 148
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

type st_2 from statictext within w_rep_ventas_x_sucursal
integer x = 2318
integer y = 152
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

type dw_1 from datawindow within w_rep_ventas_x_sucursal
integer x = 82
integer y = 128
integer width = 1001
integer height = 100
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_sucursal"
boolean border = false
boolean livescroll = true
end type

type rb_1 from radiobutton within w_rep_ventas_x_sucursal
integer x = 87
integer y = 24
integer width = 343
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ventas"
end type

type rb_2 from radiobutton within w_rep_ventas_x_sucursal
integer x = 462
integer y = 28
integer width = 411
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
long backcolor = 67108864
string text = "Devoluciones"
end type


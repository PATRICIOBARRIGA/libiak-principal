HA$PBExportHeader$w_lb_ventas.srw
forward
global type w_lb_ventas from w_sheet
end type
type st_1 from statictext within w_lb_ventas
end type
type lb_1 from listbox within w_lb_ventas
end type
end forward

global type w_lb_ventas from w_sheet
integer width = 1541
integer height = 1464
string title = "Estad$$HEX1$$ed00$$ENDHEX$$stica mensual"
long backcolor = 67108864
st_1 st_1
lb_1 lb_1
end type
global w_lb_ventas w_lb_ventas

on w_lb_ventas.create
int iCurrent
call super::create
this.st_1=create st_1
this.lb_1=create lb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.lb_1
end on

on w_lb_ventas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.lb_1)
end on

type st_1 from statictext within w_lb_ventas
integer x = 41
integer y = 20
integer width = 206
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Ventas"
boolean focusrectangle = false
end type

type lb_1 from listbox within w_lb_ventas
integer x = 37
integer y = 84
integer width = 1413
integer height = 1232
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Lista de Precios","Ventas Netas por Asesor","Ventas Netas por Asesor sin Veh$$HEX1$$ed00$$ENDHEX$$culos","Ventas Netas del Asesor x Cliente","Ventas Netas del Asesor x Sucursal","Ventas Netas del Asesor x L$$HEX1$$ed00$$ENDHEX$$nea","Ventas Netas del Asesor x Fabricante","Fabricantes por sucursal","Items por cliente","L$$HEX1$$ed00$$ENDHEX$$neas por asesor","L$$HEX1$$ed00$$ENDHEX$$neas por sucursal","Ventas netas Asesor x Cliente - Factura y FPago.","Ventas netas Asesor x Cliente - Factura - FPago y Fabricante","Ventas empresa","Ventas por plazos "}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case index
case 1
opensheetwithparm(w_rep_lista_de_precios,index,w_marco,1,Original!)
case 2,3,4,5,6,7,8
opensheetwithparm(w_rep_vta1,index,w_marco,1,Original!)
case 9
opensheetwithparm(w_rep_vta2,index,w_marco,1,Original!)
case 10,11
opensheetwithparm(w_rep_vta3,index,w_marco,1,Original!)
case 12,13
opensheetwithparm(w_rep_vta4,index,w_marco,1,Original!)
case 14
opensheetwithparm(w_rep_vta5,index,w_marco,1,Original!)
case 15
opensheetwithparm(w_rep_vta6,index,w_marco,1,Original!)

end choose 
end event


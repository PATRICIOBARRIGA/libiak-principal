HA$PBExportHeader$w_venta_vehiculo.srw
forward
global type w_venta_vehiculo from window
end type
type st_2 from statictext within w_venta_vehiculo
end type
type cb_2 from commandbutton within w_venta_vehiculo
end type
type st_1 from statictext within w_venta_vehiculo
end type
type sle_1 from singlelineedit within w_venta_vehiculo
end type
type dw_1 from datawindow within w_venta_vehiculo
end type
end forward

global type w_venta_vehiculo from window
integer width = 3918
integer height = 1772
boolean titlebar = true
string title = "Venta de Veh$$HEX1$$ed00$$ENDHEX$$culos"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "imagenes\Sif.ico"
boolean center = true
st_2 st_2
cb_2 cb_2
st_1 st_1
sle_1 sle_1
dw_1 dw_1
end type
global w_venta_vehiculo w_venta_vehiculo

type variables
long il_nfila
end variables

on w_venta_vehiculo.create
this.st_2=create st_2
this.cb_2=create cb_2
this.st_1=create st_1
this.sle_1=create sle_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.cb_2,&
this.st_1,&
this.sle_1,&
this.dw_1}
end on

on w_venta_vehiculo.destroy
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.dw_1)
end on

event open;string ls_pepa



f_recupera_empresa(dw_1,"it_codigo")
ls_pepa = message.stringparm
dw_1.settransobject(sqlca)
dw_1.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pepa)

end event

type st_2 from statictext within w_venta_vehiculo
integer x = 64
integer y = 124
integer width = 2816
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "NOTA: Solo se puede seleccionar un veh$$HEX1$$ed00$$ENDHEX$$culo  por factura...Por favor tenga en cuenta est$$HEX2$$e1002000$$ENDHEX$$advertencia."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_venta_vehiculo
integer x = 3488
integer y = 52
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cerrar"
end type

event clicked;setnull(str_prodparam.motor)
setnull(str_prodparam.chasis)
closewithreturn(parent,'')

end event

type st_1 from statictext within w_venta_vehiculo
integer x = 78
integer y = 36
integer width = 539
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Buscar por CHASIS :"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_venta_vehiculo
integer x = 631
integer y = 28
integer width = 937
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_chasis

ls_chasis = sle_1.text
if isnull(ls_chasis) or trim(ls_chasis) = "" then return
il_nfila = dw_1.find("di_ref2 like '%"+ls_chasis+"'",1,dw_1.rowcount())
if il_nfila > 0 then
	dw_1.scrolltorow(il_nfila)
	dw_1.setrow(il_nfila)
	dw_1.selectrow(il_nfila,true)
end if
end event

type dw_1 from datawindow within w_venta_vehiculo
integer x = 59
integer y = 204
integer width = 3785
integer height = 1436
string title = "none"
string dataobject = "d_ventas_vehiculos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;Long ll_reg,i,ll_find
String ls_op

If dwo.name = 'b_1' then

Setnull(ls_op)	
ll_reg = this.rowcount()

i = 0
for i = 1 to ll_reg	
	ls_op = this.object.seleccion[i]
	if   ls_op = 'S' then 
		ll_find = i
		exit
	end if
next	

if ll_find = 0 then return
str_prodparam.motor = dw_1.getitemstring(ll_find,"di_ref1")
str_prodparam.chasis = dw_1.getitemstring(ll_find,"di_ref2")
//+' RAMV: '+dw_1.getitemstring(i,"di_docref")+' A$$HEX1$$d100$$ENDHEX$$O Fab:'+dw_1.getitemstring(i,"di_ref4")+ ' PAIS:'+dw_1.getitemstring(i,"pa_codigo")
str_prodparam.anio    = dw_1.getitemstring(ll_find,"di_ref4")
closewithreturn(parent,'V')
end if
end event


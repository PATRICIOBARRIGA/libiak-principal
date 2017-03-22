HA$PBExportHeader$w_reimprimir_devol_compra.srw
$PBExportComments$Si
forward
global type w_reimprimir_devol_compra from w_sheet_1_dw_rep
end type
type dw_param from datawindow within w_reimprimir_devol_compra
end type
end forward

global type w_reimprimir_devol_compra from w_sheet_1_dw_rep
integer width = 3003
integer height = 1740
string title = "Reimpresi$$HEX1$$f300$$ENDHEX$$n de Notas de D$$HEX1$$e900$$ENDHEX$$bito"
boolean resizable = false
dw_param dw_param
end type
global w_reimprimir_devol_compra w_reimprimir_devol_compra

type variables

end variables

event open;dw_param.InsertRow(0)
dw_param.setfocus()
dw_datos.settransobject(SQLCA)

this.ib_notautoretrieve = true
call super::open										


end event

on w_reimprimir_devol_compra.create
int iCurrent
call super::create
this.dw_param=create dw_param
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_param
end on

on w_reimprimir_devol_compra.destroy
call super::destroy
destroy(this.dw_param)
end on

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_param.resize(li_width - 2*dw_param.x, dw_param.height)
dw_datos.resize(dw_param.width,li_height - dw_datos.y - dw_param.y)
this.setRedraw(True)
end event

event ue_print;If dw_datos.rowcount() = 0 Then 
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Error no existen datos para imprimir...verifique n$$HEX1$$fa00$$ENDHEX$$mero de nota de d$$HEX1$$e900$$ENDHEX$$bito")	
return
end if
dw_datos.print()	

end event

event ue_retrieve;long ll_venumero


dw_param.accepttext()
ll_venumero = dw_param.getitemNumber(1,"ve_numero")
If  ll_venumero > 0 and not isnull(ll_venumero) Then	
	if dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ll_venumero) <= 0 then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Nota de D$$HEX1$$e900$$ENDHEX$$bito no registrada en esta sucursal')
		return
	end if
	dw_datos.modify("datawindow.print.preview.zoom=75 datawindow.print.preview=yes")
	dw_datos.modify("st_reimpresion.visible='1'")
else
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Nota de D$$HEX1$$e900$$ENDHEX$$bito')
	dw_param.setfocus()
	dw_datos.modify("st_reimpresion.visible='0'")
	return
End if


end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_reimprimir_devol_compra
integer x = 0
integer y = 160
integer width = 2999
integer height = 1500
string dataobject = "d_redcolor_nd_preimpresa_devcomp"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_reimprimir_devol_compra
integer y = 164
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_reimprimir_devol_compra
end type

type dw_param from datawindow within w_reimprimir_devol_compra
integer width = 2999
integer height = 160
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_devolucion_compra"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;parent.triggerevent("ue_retrieve")
end event


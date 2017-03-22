HA$PBExportHeader$w_um_rep_reimprimir_nc.srw
$PBExportComments$Si.
forward
global type w_um_rep_reimprimir_nc from w_sheet_1_dw_rep
end type
type dw_param from datawindow within w_um_rep_reimprimir_nc
end type
end forward

global type w_um_rep_reimprimir_nc from w_sheet_1_dw_rep
integer width = 3497
integer height = 2024
string title = "Reimpresi$$HEX1$$f300$$ENDHEX$$n de Notas de Cr$$HEX1$$e900$$ENDHEX$$dito"
boolean resizable = false
long backcolor = 67108864
dw_param dw_param
end type
global w_um_rep_reimprimir_nc w_um_rep_reimprimir_nc

type variables
string is_estado
long il_venumero
String is_preimpreso
end variables

event open;dw_param.InsertRow(0)
dw_param.setfocus()
dw_datos.settransobject(SQLCA)

this.ib_notautoretrieve = true
call super::open										


end event

on w_um_rep_reimprimir_nc.create
int iCurrent
call super::create
this.dw_param=create dw_param
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_param
end on

on w_um_rep_reimprimir_nc.destroy
call super::destroy
destroy(this.dw_param)
end on

event ue_retrieve;char lch_tipo

dw_param.accepttext()
lch_tipo = dw_param.getitemstring(1,"numero")
//il_venumero = dw_param.getitemNumber(1,"ve_numero")
is_preimpreso = dw_param.getitemString(1,"ve_numero")
//If (not isnull(is_numdevol) and is_numdevol<>'' ) and (not isnull(is_venumero) and is_venumero <>'' ) Then
If   not isnull(is_preimpreso) Then	
	If lch_tipo = 'F' Then
		is_estado = '9'
	Else
		is_estado = '10'
	End if
	if dw_datos.Retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,is_preimpreso) <= 0 then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Nota de Cr$$HEX1$$e900$$ENDHEX$$dito no registrada en esta sucursal')
		return
	end if
	dw_datos.modify("datawindow.print.preview.zoom=85 datawindow.print.preview=yes")
	dw_datos.modify("st_reimpresion.visible='1'")
else
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Nota de Cr$$HEX1$$e900$$ENDHEX$$dito')
	dw_param.setfocus()
	dw_datos.modify("st_reimpresion.visible='0'")
	return
End if
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_param.resize(li_width - 2*dw_param.x, dw_param.height)
dw_datos.resize(dw_param.width,li_height - dw_datos.y - dw_param.y)
this.setRedraw(True)
end event

event ue_print;//string ls_opcion
long ll_nreg,ll_reg
integer li_i


If dw_datos.rowcount() = 0 Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Nada para Imprimir")
	dw_param.setfocus()
	return
End if

//open(w_res_imp_nc)
//ls_opcion = message.stringparm

//If ls_opcion = '1' Then
//	dw_datos.modify("st_reimpresion.visible='1'")
//	dw_datos.print()	
//	dw_datos.modify("st_reimpresion.visible='0'")
//End if

//If ls_opcion = '2' Then
	//dw_report.modify("st_reimpresion.visible='1'")
	//dw_report.settransobject(sqlca)
dw_datos.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"' st_seccion.text ='"+gs_bo_nombre+"'" )		
ll_nreg = dw_datos.Retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,il_venumero)
If ll_nreg = 0 Then 
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Error de la Nota de Cr$$HEX1$$e900$$ENDHEX$$dito pues no existen datos para imprimir")	
return
end if
dw_datos.print()	
//End if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_um_rep_reimprimir_nc
integer x = 0
integer y = 244
integer width = 3483
integer height = 1688
string dataobject = "d_um_nc_preimp_devol_facytick_veh"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_um_rep_reimprimir_nc
integer y = 164
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_um_rep_reimprimir_nc
end type

type dw_param from datawindow within w_um_rep_reimprimir_nc
integer width = 3483
integer height = 244
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_devolucion"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;char lch_tipo

dw_param.accepttext()
lch_tipo = dw_param.getitemstring(1,"numero")
il_venumero = dw_param.getitemNumber(1,"ve_numero")
//If (not isnull(is_numdevol) and is_numdevol<>'' ) and (not isnull(is_venumero) and is_venumero <>'' ) Then
If   not isnull(is_preimpreso) Then	
	If lch_tipo = 'F' Then
		is_estado = '9'
	Else
		is_estado = '10'
	End if
	if dw_datos.Retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,is_preimpreso) <= 0 then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Nota de Cr$$HEX1$$e900$$ENDHEX$$dito no registrada en esta sucursal')
		return
	end if
	dw_datos.modify("datawindow.print.preview.zoom=75 datawindow.print.preview=yes")
	dw_datos.modify("st_reimpresion.visible='1'")
else
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Nota de Cr$$HEX1$$e900$$ENDHEX$$dito')
	dw_param.setfocus()
	dw_datos.modify("st_reimpresion.visible='0'")
	return
End if





end event


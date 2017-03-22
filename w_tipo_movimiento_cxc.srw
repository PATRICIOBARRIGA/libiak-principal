HA$PBExportHeader$w_tipo_movimiento_cxc.srw
$PBExportComments$Si.Para el ingreso de los tipos de movimientos de cxc
forward
global type w_tipo_movimiento_cxc from w_sheet_1_dw_maint
end type
end forward

global type w_tipo_movimiento_cxc from w_sheet_1_dw_maint
integer width = 3086
integer height = 1388
string title = "Tipo de Movimiento (Cuentas por Cobrar)"
long backcolor = 1090519039
end type
global w_tipo_movimiento_cxc w_tipo_movimiento_cxc

type variables
datawindowchild dwc_cuentas

end variables

event open;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n :  llena la estructura istr_argInformation, luyego le indica 
//                la columna que se va asignar el c$$HEX1$$f300$$ENDHEX$$digo secuencial
//
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : PATRICIO BARRIGA 03/04/2008  16:16
/*********************************************************************/

istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "tt_codigo"
dw_datos.is_SerialCodeType = "TI_MOV_CXC"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

dw_datos.GetChild("pl_codigo",dwc_cuentas)
dwc_cuentas.SetTransObject(SQLCA)
dwc_cuentas.Retrieve(str_appgeninfo.empresa)

call super::open
end event

on w_tipo_movimiento_cxc.create
call super::create
end on

on w_tipo_movimiento_cxc.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_tipo_movimiento_cxc
integer y = 0
integer width = 3049
integer height = 1284
string dataobject = "d_tipo_movimiento_cxc"
end type

event dw_datos::itemchanged;call super::itemchanged;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n :  Cuando se cambia el foco, se setea en el dw el
//                c$$HEX1$$f300$$ENDHEX$$digo de la Empresa. 
//
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : ING HUGO V OROZCO CH 20/01/1998  15:22 
/*********************************************************************/

long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

event dw_datos::editchanged;call super::editchanged;
String ls_data
If dwo.name = "pl_codigo" Then
	ls_data = data+'%'
	dwc_cuentas.SetFilter("pl_codigo like '"+ls_data+"' ")
	dwc_cuentas.Filter()
	This.GetChild("pl_codigo",dwc_cuentas)
End if 

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_tipo_movimiento_cxc
integer x = 55
integer y = 300
end type


HA$PBExportHeader$w_actividad_cliente.srw
$PBExportComments$Clase de cliente
forward
global type w_actividad_cliente from w_sheet_1_dw_maint
end type
end forward

global type w_actividad_cliente from w_sheet_1_dw_maint
integer width = 1207
integer height = 1540
string title = "Clase de Cliente"
long backcolor = 1090519039
end type
global w_actividad_cliente w_actividad_cliente

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

dw_datos.is_SerialCodeColumn = "ca_codigo"
dw_datos.is_SerialCodeType = "COD_CLCLI"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
call super::open
end event

on w_actividad_cliente.create
call super::create
end on

on w_actividad_cliente.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_actividad_cliente
integer x = 5
integer y = 0
integer width = 1166
integer height = 1432
string dataobject = "d_clase_cliente"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo", str_appgeninfo.empresa)

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_actividad_cliente
integer x = 46
integer y = 268
integer width = 169
integer height = 200
end type


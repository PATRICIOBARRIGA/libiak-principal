HA$PBExportHeader$w_tipo_movimiento_cxp.srw
$PBExportComments$Si.
forward
global type w_tipo_movimiento_cxp from w_sheet_1_dw_maint
end type
end forward

global type w_tipo_movimiento_cxp from w_sheet_1_dw_maint
integer width = 1691
integer height = 1388
string title = "Tipo de Movimiento (Cuentas por Pagar)"
long backcolor = 1090519039
end type
global w_tipo_movimiento_cxp w_tipo_movimiento_cxp

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "tv_codigo"
dw_datos.is_SerialCodeType = "TI_MOV_CXP"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
call super::open
end event

on w_tipo_movimiento_cxp.create
call super::create
end on

on w_tipo_movimiento_cxp.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_tipo_movimiento_cxp
integer y = 0
integer width = 1655
integer height = 1284
string dataobject = "d_tipo_movimiento_cxp"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_tipo_movimiento_cxp
integer y = 704
end type


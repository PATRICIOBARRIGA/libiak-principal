HA$PBExportHeader$w_unidades_base.srw
$PBExportComments$Si.Definicion de las unidades base de los productos
forward
global type w_unidades_base from w_sheet_1_dw_maint
end type
end forward

global type w_unidades_base from w_sheet_1_dw_maint
integer width = 1541
integer height = 1368
string title = "Unidades base de productos"
long backcolor = 1090519039
end type
global w_unidades_base w_unidades_base

on w_unidades_base.create
call super::create
end on

on w_unidades_base.destroy
call super::destroy
end on

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "ub_codigo"
dw_datos.is_SerialCodeType = "COD_UB"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

call super::open

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_unidades_base
integer width = 1504
integer height = 1256
string dataobject = "d_unidad_base_items"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_unidades_base
end type


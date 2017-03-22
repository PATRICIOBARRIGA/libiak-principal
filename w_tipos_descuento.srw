HA$PBExportHeader$w_tipos_descuento.srw
$PBExportComments$Si.Definicion de tipos de descuento al precio base
forward
global type w_tipos_descuento from w_sheet_1_dw_maint
end type
end forward

global type w_tipos_descuento from w_sheet_1_dw_maint
integer width = 3259
integer height = 1540
string title = "Tipos de descuento "
long backcolor = 1090519039
end type
global w_tipos_descuento w_tipos_descuento

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "td_codigo"
dw_datos.is_SerialCodeType = "COD_TPDES"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
call super::open
end event

on w_tipos_descuento.create
call super::create
end on

on w_tipos_descuento.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_tipos_descuento
integer y = 0
integer width = 3200
integer height = 1408
string dataobject = "d_tipo_descuento_items"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_tipos_descuento
end type


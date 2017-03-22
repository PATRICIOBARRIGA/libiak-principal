HA$PBExportHeader$w_tipo_mov_inventario.srw
$PBExportComments$Si.
forward
global type w_tipo_mov_inventario from w_sheet_1_dw_maint
end type
end forward

global type w_tipo_mov_inventario from w_sheet_1_dw_maint
integer width = 2272
integer height = 932
string title = "Tipos de movimientos de inventario"
long backcolor = 1090519039
end type
global w_tipo_mov_inventario w_tipo_mov_inventario

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
call super::open
dw_datos.is_SerialCodeColumn = "tm_codigo"
dw_datos.is_SerialCodeType = "COD_TMIN"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
end event

on w_tipo_mov_inventario.create
call super::create
end on

on w_tipo_mov_inventario.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_tipo_mov_inventario
integer y = 0
integer width = 2245
string dataobject = "d_tipo_mov_inventario"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact

ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_tipo_mov_inventario
end type


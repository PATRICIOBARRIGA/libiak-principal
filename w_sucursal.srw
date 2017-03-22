HA$PBExportHeader$w_sucursal.srw
forward
global type w_sucursal from w_sheet_1_dw_maint
end type
end forward

global type w_sucursal from w_sheet_1_dw_maint
integer width = 2432
integer height = 732
string title = "Sucursales"
long backcolor = 1090519039
end type
global w_sucursal w_sucursal

on w_sucursal.create
call super::create
end on

on w_sucursal.destroy
call super::destroy
end on

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
call super::open
dw_datos.is_SerialCodeColumn = "su_codigo"
dw_datos.is_SerialCodeType = "COD_SUCU"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_sucursal
integer y = 0
integer width = 2400
integer height = 632
string dataobject = "d_sucursal"
boolean border = true
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact

ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_sucursal
end type


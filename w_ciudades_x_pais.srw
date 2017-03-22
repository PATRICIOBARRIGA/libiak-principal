HA$PBExportHeader$w_ciudades_x_pais.srw
forward
global type w_ciudades_x_pais from w_sheet_1_dw_maint
end type
end forward

global type w_ciudades_x_pais from w_sheet_1_dw_maint
integer width = 2848
integer height = 1612
end type
global w_ciudades_x_pais w_ciudades_x_pais

on w_ciudades_x_pais.create
call super::create
end on

on w_ciudades_x_pais.destroy
call super::destroy
end on

event open;call super::open;dw_datos.is_SerialCodeColumn = "cu_codigo"
dw_datos.is_SerialCodeType = "COD_CIUDAD"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ciudades_x_pais
integer width = 2149
integer height = 1488
string dataobject = "d_ciudad"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_ciudades_x_pais
end type


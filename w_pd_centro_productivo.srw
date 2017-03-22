HA$PBExportHeader$w_pd_centro_productivo.srw
forward
global type w_pd_centro_productivo from w_sheet_1_dw_maint
end type
end forward

global type w_pd_centro_productivo from w_sheet_1_dw_maint
integer width = 3886
integer height = 2120
string title = "Centro productivo"
end type
global w_pd_centro_productivo w_pd_centro_productivo

on w_pd_centro_productivo.create
call super::create
end on

on w_pd_centro_productivo.destroy
call super::destroy
end on

event open;dw_datos.is_SerialCodeColumn = "cr_codigo"
dw_datos.is_SerialCodeType = "COD_CTRPRD"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa


f_recupera_empresa(dw_datos,'pl_codigo')
f_recupera_empresa(dw_datos,'pl_codigo_1')
call super::open
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_pd_centro_productivo
integer x = 64
integer y = 52
integer width = 3758
integer height = 1940
string dataobject = "d_pd_centro_productivo"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_pd_centro_productivo
integer x = 27
integer y = 372
string dataobject = "d_pd_centro_productivo"
end type


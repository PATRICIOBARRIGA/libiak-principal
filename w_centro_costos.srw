HA$PBExportHeader$w_centro_costos.srw
$PBExportComments$Si. Vale
forward
global type w_centro_costos from w_sheet_1_dw_maint
end type
end forward

global type w_centro_costos from w_sheet_1_dw_maint
integer width = 923
integer height = 1156
string title = "Centro de Costos"
end type
global w_centro_costos w_centro_costos

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
call super::open
dw_datos.is_SerialCodeColumn = "cs_codigo"
dw_datos.is_SerialCodeType = "COD_CENC"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
end event

on w_centro_costos.create
call super::create
end on

on w_centro_costos.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_centro_costos
integer width = 882
integer height = 1044
string dataobject = "d_centro_costos"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact

ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_centro_costos
end type


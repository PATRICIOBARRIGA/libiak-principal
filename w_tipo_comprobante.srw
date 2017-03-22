HA$PBExportHeader$w_tipo_comprobante.srw
$PBExportComments$Si.
forward
global type w_tipo_comprobante from w_sheet_1_dw_maint
end type
end forward

global type w_tipo_comprobante from w_sheet_1_dw_maint
integer width = 1897
integer height = 1104
string title = "Tipo de comprobantes"
end type
global w_tipo_comprobante w_tipo_comprobante

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
call super::open
dw_datos.is_SerialCodeColumn = "ti_codigo"
dw_datos.is_SerialCodeType = "COD_TICO"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
end event

on w_tipo_comprobante.create
call super::create
end on

on w_tipo_comprobante.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_tipo_comprobante
integer y = 0
integer width = 1861
integer height = 1000
string dataobject = "d_tipo_comprobante"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact

ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_tipo_comprobante
end type


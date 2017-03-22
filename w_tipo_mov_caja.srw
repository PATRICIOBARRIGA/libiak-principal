HA$PBExportHeader$w_tipo_mov_caja.srw
forward
global type w_tipo_mov_caja from w_sheet_1_dw_maint
end type
end forward

global type w_tipo_mov_caja from w_sheet_1_dw_maint
integer width = 1833
integer height = 932
end type
global w_tipo_mov_caja w_tipo_mov_caja

on w_tipo_mov_caja.create
call super::create
end on

on w_tipo_mov_caja.destroy
call super::destroy
end on

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
call super::open
dw_datos.is_SerialCodeColumn = "tj_codigo"
dw_datos.is_SerialCodeType = "COD_MOCJ"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_tipo_mov_caja
integer y = 0
integer width = 1801
string dataobject = "d_tipo_mov_caja"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact

ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_tipo_mov_caja
integer y = 252
integer width = 837
integer height = 248
end type


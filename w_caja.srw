HA$PBExportHeader$w_caja.srw
$PBExportComments$Ingreso y mantenimiento de cajas
forward
global type w_caja from w_sheet_1_dw_maint
end type
end forward

global type w_caja from w_sheet_1_dw_maint
integer width = 2299
integer height = 896
string title = "Mantenimiento de Caja"
long backcolor = 67108864
end type
global w_caja w_caja

on w_caja.create
call super::create
end on

on w_caja.destroy
call super::destroy
end on

event open;istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = str_appgeninfo.seccion

dw_datos.is_SerialCodeColumn = "cj_caja"
dw_datos.is_SerialCodeType = "COD_CAJA"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
call super::open

end event

event ue_update;long ll_row

dw_datos.accepttext()
ll_row  = dw_datos.GetRow()
dw_datos.SetItem(ll_row,"em_codigo",str_appgeninfo.empresa);
dw_datos.SetItem(ll_row,"su_codigo",str_appgeninfo.sucursal);
dw_datos.SetItem(ll_row,"bo_codigo",str_appgeninfo.seccion);
call super::ue_update
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_caja
integer y = 8
integer width = 2263
integer height = 768
string dataobject = "d_caja"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::itemchanged;call super::itemchanged;
if row <= 0 then return
if dwo.name = 'cj_estado' then
this.SetItem(row,'cj_feccam',f_hoy())
end if
end event

event dw_datos::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0 then return
this.setitem(ll_row,"cj_feccam",f_hoy())

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_caja
end type


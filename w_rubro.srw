HA$PBExportHeader$w_rubro.srw
$PBExportComments$Si.Ingreso de Rubro
forward
global type w_rubro from w_sheet_1_dw_maint
end type
end forward

global type w_rubro from w_sheet_1_dw_maint
integer width = 2683
integer height = 2904
string title = "Rubros a liquidar"
end type
global w_rubro w_rubro

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
f_recupera_empresa(dw_datos,'pl_codigo')
call super::open
dw_datos.is_SerialCodeColumn = "ru_codigo"
dw_datos.is_SerialCodeType = "COD_RUBRO"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

end event

on w_rubro.create
call super::create
end on

on w_rubro.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_rubro
integer y = 0
integer width = 2647
integer height = 2788
string dataobject = "d_rubro"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::itemchanged;call super::itemchanged;datetime ld_null
SetNull(ld_null)
this.SetItem(row,'em_codigo', str_appgeninfo.empresa)
Choose case this.GetcolumnName()
	case 'ru_fecmax'
		if	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","El cambio de fecha permitir$$HEX2$$e1002000$$ENDHEX$$el pago de este rubro, aseg$$HEX1$$fa00$$ENDHEX$$rese de que esto es lo que desea.",Information!,YesNo!)=2 then
			data=string(this.GetItemDate(row,'rufecmax'),'dd/mm/yyyy')
		else 
			this.SetItem(row,'ru_fecpag',ld_null)
		end if
end choose
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_rubro
end type


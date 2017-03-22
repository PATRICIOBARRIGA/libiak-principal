HA$PBExportHeader$w_gruposcontables.srw
forward
global type w_gruposcontables from w_sheet_1_dw_maint
end type
end forward

global type w_gruposcontables from w_sheet_1_dw_maint
integer width = 4718
integer height = 1808
string title = "Grupos contables"
end type
global w_gruposcontables w_gruposcontables

type variables
datawindowchild dwc_cuentas

end variables

on w_gruposcontables.create
call super::create
end on

on w_gruposcontables.destroy
call super::destroy
end on

event open;/*Argumentos para recuperar la informaci$$HEX1$$f300$$ENDHEX$$n a penas se abre la ventana*/

istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"

istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal

//f_recupera_empresa(dw_datos,"md_codigo")
f_recupera_empresa(dw_datos,"pl_codigo")
f_recupera_empresa(dw_datos,"pl_codigo1")
f_recupera_empresa(dw_datos,"pl_codigo2")


call super::open
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_gruposcontables
integer x = 9
integer y = 0
integer width = 4667
integer height = 1680
string dataobject = "d_gruposcontables"
end type

event dw_datos::editchanged;call super::editchanged;String ls_data

If dwo.name = "pl_codigo" Then
	ls_data = data+'%'
	dwc_cuentas.SetFilter("pl_codigo like '"+ls_data+"' ")
	dwc_cuentas.Filter()
	This.GetChild("pl_codigo",dwc_cuentas)
End if 

If dwo.name = "pl_codigo1" Then
	ls_data = data+'%'
	dwc_cuentas.SetFilter("pl_codigo1 like '"+ls_data+"' ")
	dwc_cuentas.Filter()
	This.GetChild("pl_codigo1",dwc_cuentas)
End if 

If dwo.name = "pl_codigo2" Then
	ls_data = data+'%'
	dwc_cuentas.SetFilter("pl_codigo2 like '"+ls_data+"' ")
	dwc_cuentas.Filter()
	This.GetChild("pl_codigo2",dwc_cuentas)
End if 



Return 1
end event

event dw_datos::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = This.getrow()
This.object.em_codigo[ll_row] = str_appgeninfo.empresa
This.object.su_codigo[ll_row] = str_appgeninfo.sucursal
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_gruposcontables
integer x = 37
integer y = 620
integer width = 4539
integer height = 688
string dataobject = "d_gruposcontables"
boolean hscrollbar = false
end type


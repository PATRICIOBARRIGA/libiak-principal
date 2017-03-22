HA$PBExportHeader$w_forma_pago.srw
$PBExportComments$Formas de pago del sistema
forward
global type w_forma_pago from w_sheet_1_dw_maint
end type
end forward

global type w_forma_pago from w_sheet_1_dw_maint
integer width = 2377
integer height = 780
string title = "Forma de Pago"
long backcolor = 1090519039
end type
global w_forma_pago w_forma_pago

type variables
datawindowchild idwc_cuentas
end variables

on w_forma_pago.create
call super::create
end on

on w_forma_pago.destroy
call super::destroy
end on

event open;istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal

dw_datos.is_SerialCodeColumn = "fp_codigo"
dw_datos.is_SerialCodeType = "COD_FRMPAG"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa


f_recupera_empresa(dw_datos,'pl_codigo')

call super::open
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_forma_pago
integer y = 0
integer width = 2345
integer height = 684
string dataobject = "d_forma_pago"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo", str_appgeninfo.empresa)

end event

event dw_datos::updatestart;call super::updatestart;String  ls_fpstring
Long ll_row

ll_row  = this.getrow()
ls_fpstring = this.getitemstring(ll_row,'v')
ls_fpstring = ls_fpstring + this.getitemstring(ll_row,'t')
ls_fpstring = ls_fpstring + this.getitemstring(ll_row,'f')
ls_fpstring = ls_fpstring + this.getitemstring(ll_row,'p')
ls_fpstring = ls_fpstring + this.getitemstring(ll_row,'c')

this.setitem(ll_row,"fp_string",ls_fpstring)
end event

event dw_datos::retrieverow;call super::retrieverow;string ls_fpstring,ls_val


ls_fpstring = this.getitemstring(row,"fp_string")

ls_val = mid(ls_fpstring,1,1)
this.setitem(row,"v",ls_val)

ls_val = mid(ls_fpstring,2,1)
this.setitem(row,"t",ls_val)

ls_val = mid(ls_fpstring,3,1)
this.setitem(row,"f",ls_val)

ls_val = mid(ls_fpstring,4,1)
this.setitem(row,"p",ls_val)

ls_val = mid(ls_fpstring,5,1)
this.setitem(row,"c",ls_val)

end event

event dw_datos::editchanged;call super::editchanged;String ls_data
If dwo.name = "pl_codigo" &
Then
ls_data = data+'%'
idwc_cuentas.SetFilter("pl_codigo like '"+ls_data+"' ")
idwc_cuentas.Filter()
This.GetChild("pl_codigo",idwc_cuentas)
End if 
Return 1
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_forma_pago
integer x = 101
integer y = 144
integer width = 814
integer height = 252
end type


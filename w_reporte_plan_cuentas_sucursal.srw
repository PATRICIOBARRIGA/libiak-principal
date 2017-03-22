HA$PBExportHeader$w_reporte_plan_cuentas_sucursal.srw
$PBExportComments$Si.
forward
global type w_reporte_plan_cuentas_sucursal from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_reporte_plan_cuentas_sucursal
end type
end forward

global type w_reporte_plan_cuentas_sucursal from w_sheet_1_dw_rep
integer width = 2885
integer height = 1340
string title = "Plan cuentas sucursal"
long backcolor = 81324524
dw_1 dw_1
end type
global w_reporte_plan_cuentas_sucursal w_reporte_plan_cuentas_sucursal

on w_reporte_plan_cuentas_sucursal.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_reporte_plan_cuentas_sucursal.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;
DataWindowChild   ldwc_aux



dw_1.InsertRow(0)
dw_1.SetText('Matriz') //por default
dw_1.GetChild("su_codigo",ldwc_aux)
ldwc_aux.setTransObject(sqlca)
ldwc_aux.Retrieve("1")
istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = '1' //empresa por default
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[2] = '1' //sucursal por default
call super::open
dw_datos.uf_retrieve()
end event

event ue_retrieve;string  ls_sucursal
long ll_filact

SetPointer(HourGlass!)
ll_filact = dw_1.GetRow()
ls_sucursal = dw_1.GetText()

dw_datos.retrieve(str_appgeninfo.empresa,ls_sucursal)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_reporte_plan_cuentas_sucursal
integer x = 0
integer y = 164
integer width = 2848
integer height = 1036
string dataobject = "d_rep_plan_cuentas_sucursal"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_reporte_plan_cuentas_sucursal
integer x = 1678
integer y = 560
end type

type dw_1 from datawindow within w_reporte_plan_cuentas_sucursal
integer y = 16
integer width = 2848
integer height = 140
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_external_sucursal"
boolean border = false
boolean livescroll = true
end type


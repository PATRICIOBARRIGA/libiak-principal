HA$PBExportHeader$w_estructura_plan_ctas.srw
$PBExportComments$Si.
forward
global type w_estructura_plan_ctas from w_sheet_1_dw_maint
end type
end forward

global type w_estructura_plan_ctas from w_sheet_1_dw_maint
int Width=1358
int Height=929
end type
global w_estructura_plan_ctas w_estructura_plan_ctas

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
call super::open

end event

on w_estructura_plan_ctas.create
call w_sheet_1_dw_maint::create
end on

on w_estructura_plan_ctas.destroy
call w_sheet_1_dw_maint::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_estructura_plan_ctas
int Y=1
int Width=1331
string DataObject="d_estructura_plan_ctas"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact

ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event


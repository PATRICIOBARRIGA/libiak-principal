HA$PBExportHeader$w_plan_niff.srw
forward
global type w_plan_niff from w_sheet_1_dw_maint
end type
end forward

global type w_plan_niff from w_sheet_1_dw_maint
integer width = 3086
integer height = 1624
end type
global w_plan_niff w_plan_niff

on w_plan_niff.create
call super::create
end on

on w_plan_niff.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_plan_niff
integer y = 16
integer width = 3017
integer height = 1476
string dataobject = "d_plan_niff"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_plan_niff
end type


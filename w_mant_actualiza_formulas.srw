HA$PBExportHeader$w_mant_actualiza_formulas.srw
forward
global type w_mant_actualiza_formulas from w_sheet_1_dw_maint
end type
end forward

global type w_mant_actualiza_formulas from w_sheet_1_dw_maint
integer width = 3410
integer height = 1856
end type
global w_mant_actualiza_formulas w_mant_actualiza_formulas

on w_mant_actualiza_formulas.create
call super::create
end on

on w_mant_actualiza_formulas.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_mant_actualiza_formulas
integer width = 3355
integer height = 1724
string dataobject = "d_actualiza_formulas"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_mant_actualiza_formulas
integer x = 14
integer y = 468
string dataobject = "d_actualiza_formulas"
end type


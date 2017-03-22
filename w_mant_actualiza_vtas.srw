HA$PBExportHeader$w_mant_actualiza_vtas.srw
forward
global type w_mant_actualiza_vtas from w_sheet_1_dw_maint
end type
end forward

global type w_mant_actualiza_vtas from w_sheet_1_dw_maint
integer width = 5175
integer height = 1900
end type
global w_mant_actualiza_vtas w_mant_actualiza_vtas

on w_mant_actualiza_vtas.create
call super::create
end on

on w_mant_actualiza_vtas.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_mant_actualiza_vtas
integer width = 5120
integer height = 1800
string dataobject = "d_actualiza_presentacion_vtas"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_mant_actualiza_vtas
end type


HA$PBExportHeader$w_vh_modelos.srw
forward
global type w_vh_modelos from w_sheet_1_dw_maint
end type
end forward

global type w_vh_modelos from w_sheet_1_dw_maint
integer width = 2720
integer height = 1488
string title = "Modelos"
end type
global w_vh_modelos w_vh_modelos

on w_vh_modelos.create
call super::create
end on

on w_vh_modelos.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_vh_modelos
integer x = 18
integer y = 8
integer width = 2647
integer height = 1344
string dataobject = "d_modelos_vh"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_vh_modelos
end type


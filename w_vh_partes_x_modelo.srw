HA$PBExportHeader$w_vh_partes_x_modelo.srw
forward
global type w_vh_partes_x_modelo from w_sheet_1_dw_maint
end type
end forward

global type w_vh_partes_x_modelo from w_sheet_1_dw_maint
integer width = 4503
integer height = 1304
end type
global w_vh_partes_x_modelo w_vh_partes_x_modelo

on w_vh_partes_x_modelo.create
call super::create
end on

on w_vh_partes_x_modelo.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_vh_partes_x_modelo
integer x = 32
integer y = 28
integer width = 4416
integer height = 1132
string dataobject = "d_vh_partes"
boolean border = true
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_vh_partes_x_modelo
end type


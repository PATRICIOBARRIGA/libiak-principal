HA$PBExportHeader$w_vh_clase_y_subclases.srw
forward
global type w_vh_clase_y_subclases from w_sheet_1_dw_maint
end type
end forward

global type w_vh_clase_y_subclases from w_sheet_1_dw_maint
integer width = 2670
integer height = 1704
string title = "Clase"
end type
global w_vh_clase_y_subclases w_vh_clase_y_subclases

on w_vh_clase_y_subclases.create
call super::create
end on

on w_vh_clase_y_subclases.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_vh_clase_y_subclases
integer y = 24
integer width = 2610
integer height = 1556
string dataobject = "d_clase_vh"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_vh_clase_y_subclases
end type


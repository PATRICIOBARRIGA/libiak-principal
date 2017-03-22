HA$PBExportHeader$w_modulos_sistema.srw
forward
global type w_modulos_sistema from w_sheet_1_dw_maint
end type
end forward

global type w_modulos_sistema from w_sheet_1_dw_maint
integer width = 2053
integer height = 1460
string title = "M$$HEX1$$f300$$ENDHEX$$dulos del sistema"
long backcolor = 67108864
end type
global w_modulos_sistema w_modulos_sistema

on w_modulos_sistema.create
call super::create
end on

on w_modulos_sistema.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_modulos_sistema
integer y = 12
integer width = 1998
integer height = 1312
string dataobject = "d_modulos_sistema"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_modulos_sistema
integer x = 2025
integer y = 264
string dataobject = "d_modulos_sistema"
end type


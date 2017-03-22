HA$PBExportHeader$w_menu.srw
forward
global type w_menu from w_sheet_1_dw_maint
end type
end forward

global type w_menu from w_sheet_1_dw_maint
integer width = 3141
integer height = 1956
string title = "Mantenimiento del Men$$HEX1$$fa00$$ENDHEX$$"
long backcolor = 67108864
end type
global w_menu w_menu

on w_menu.create
call super::create
end on

on w_menu.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_menu
integer width = 3090
integer height = 1792
string dataobject = "d_menu"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_menu
integer width = 133
integer height = 152
end type


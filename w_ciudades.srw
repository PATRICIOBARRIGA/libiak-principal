HA$PBExportHeader$w_ciudades.srw
forward
global type w_ciudades from w_sheet_1_dw_maint
end type
end forward

global type w_ciudades from w_sheet_1_dw_maint
integer width = 3744
integer height = 1420
string title = "Pa$$HEX1$$ed00$$ENDHEX$$ses"
end type
global w_ciudades w_ciudades

on w_ciudades.create
call super::create
end on

on w_ciudades.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ciudades
integer x = 14
integer y = 12
integer width = 3616
integer height = 1300
string dataobject = "d_paises"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_ciudades
integer x = 14
integer y = 288
string dataobject = "d_paises"
end type


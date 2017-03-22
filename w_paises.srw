HA$PBExportHeader$w_paises.srw
forward
global type w_paises from w_sheet_1_dw_maint
end type
end forward

global type w_paises from w_sheet_1_dw_maint
integer width = 3081
integer height = 1184
string title = "Pa$$HEX1$$ed00$$ENDHEX$$ses"
end type
global w_paises w_paises

on w_paises.create
call super::create
end on

on w_paises.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_paises
integer x = 14
integer y = 12
integer width = 3017
integer height = 1040
string dataobject = "d_paises"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_paises
integer x = 32
integer y = 160
string dataobject = "d_paises"
end type


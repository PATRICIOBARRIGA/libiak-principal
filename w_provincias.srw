HA$PBExportHeader$w_provincias.srw
forward
global type w_provincias from w_sheet_1_dw_maint
end type
end forward

global type w_provincias from w_sheet_1_dw_maint
integer width = 2363
integer height = 1156
string title = "Provincias"
long backcolor = 67108864
end type
global w_provincias w_provincias

type variables

end variables

on w_provincias.create
call super::create
end on

on w_provincias.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_provincias
integer x = 14
integer y = 12
integer width = 2299
integer height = 1032
string dataobject = "d_provincias"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_provincias
integer x = 14
integer y = 288
integer width = 2107
string dataobject = "d_provincias"
end type


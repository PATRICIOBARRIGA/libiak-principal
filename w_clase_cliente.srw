HA$PBExportHeader$w_clase_cliente.srw
$PBExportComments$Tipo de cliente
forward
global type w_clase_cliente from w_sheet_1_dw_maint
end type
end forward

global type w_clase_cliente from w_sheet_1_dw_maint
integer width = 1289
integer height = 1312
string title = "Tipo de cliente"
long backcolor = 1090519039
end type
global w_clase_cliente w_clase_cliente

on w_clase_cliente.create
call super::create
end on

on w_clase_cliente.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_clase_cliente
integer width = 1257
integer height = 1212
string dataobject = "d_tipo_cliente"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_clase_cliente
integer y = 416
integer width = 402
integer height = 172
end type


HA$PBExportHeader$w_rep_transferencias_reservadas.srw
$PBExportComments$Si.
forward
global type w_rep_transferencias_reservadas from w_sheet_1_dw_rep
end type
end forward

global type w_rep_transferencias_reservadas from w_sheet_1_dw_rep
integer width = 3223
integer height = 1976
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
end type
global w_rep_transferencias_reservadas w_rep_transferencias_reservadas

on w_rep_transferencias_reservadas.create
call super::create
end on

on w_rep_transferencias_reservadas.destroy
call super::destroy
end on

event ue_retrieve;dw_datos.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,str_appgeninfo.seccion)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_transferencias_reservadas
integer x = 5
integer y = 4
integer width = 3163
integer height = 1852
string dataobject = "d_rep_transferencias_reservadas"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_transferencias_reservadas
integer x = 82
integer y = 616
string dataobject = "d_rep_transferencias_reservadas"
end type


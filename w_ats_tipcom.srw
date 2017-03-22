HA$PBExportHeader$w_ats_tipcom.srw
$PBExportComments$Tipos de  comprobantes para el SRI
forward
global type w_ats_tipcom from w_sheet_1_dw_maint
end type
end forward

global type w_ats_tipcom from w_sheet_1_dw_maint
integer width = 3415
integer height = 1264
string title = "Comprobantes SRI"
end type
global w_ats_tipcom w_ats_tipcom

on w_ats_tipcom.create
call super::create
end on

on w_ats_tipcom.destroy
call super::destroy
end on

event ue_print;call super::ue_print;ib_inreportmode = true
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ats_tipcom
integer width = 3374
integer height = 1144
string dataobject = "d_ats_tipcom"
boolean border = true
end type

event dw_datos::rowfocuschanged;call super::rowfocuschanged;SetRowfocusIndicator(Hand!)
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_ats_tipcom
end type


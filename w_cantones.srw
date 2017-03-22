HA$PBExportHeader$w_cantones.srw
forward
global type w_cantones from w_sheet_1_dw_maint
end type
end forward

global type w_cantones from w_sheet_1_dw_maint
integer width = 2450
integer height = 1160
string title = "Cantones"
end type
global w_cantones w_cantones

type variables
datawindowchild  idwc_prov
end variables

on w_cantones.create
call super::create
end on

on w_cantones.destroy
call super::destroy
end on

event open;call super::open;idwc_prov.settransobject(sqlca)
idwc_prov.getchild("po_codigo",idwc_prov)
idwc_prov.retrieve()
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_cantones
integer x = 14
integer y = 12
integer width = 2382
integer height = 1032
string dataobject = "d_cantones"
end type

event dw_datos::itemfocuschanged;call super::itemfocuschanged;string ls_codpais

if row = 0 then return
if  dwo.name = 'po_codigo' then
ls_codpais = this.object.pa_codigo[row]	
idwc_prov.setfilter("pa_codigo = '"+ls_codpais+"'")	
idwc_prov.filter()
this.getchild("po_codigo",idwc_prov)
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_cantones
integer x = 78
integer y = 436
integer width = 2199
string dataobject = "d_cantones"
end type


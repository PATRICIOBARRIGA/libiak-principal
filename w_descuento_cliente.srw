HA$PBExportHeader$w_descuento_cliente.srw
$PBExportComments$Clase de cliente
forward
global type w_descuento_cliente from w_sheet_1_dw_maint
end type
end forward

global type w_descuento_cliente from w_sheet_1_dw_maint
integer width = 1134
integer height = 1080
string title = "Descuentos x tipo de cliente"
long backcolor = 67108864
end type
global w_descuento_cliente w_descuento_cliente

on w_descuento_cliente.create
call super::create
end on

on w_descuento_cliente.destroy
call super::destroy
end on

event ue_update;string ls_dctocli
integer li_nfila
dwitemstatus l_status

setpointer(hourglass!)
li_nfila = dw_datos.getrow()
l_status = dw_datos.getitemstatus(dw_datos.getrow(),0,Primary!)
If l_status = newmodified! then
	dw_datos.update()
	
	ls_dctocli = dw_datos.getitemstring(dw_datos.getrow(),"dc_codigo")
	
	INSERT INTO "IN_DESCITEM" ( "TD_CODIGO","EM_CODIGO","IT_CODIGO","ES_CODIGO","DI_VIGENTE")  
	SELECT  "TD_CODIGO","EM_CODIGO","IT_CODIGO",:ls_dctocli,"DI_VIGENTE"
	FROM "IN_DESCITEM"
	WHERE "ES_CODIGO" = '2';
	if sqlca.sqlcode <> 0 then
		rollback;
		messageBox('Error','No se puede grabar el nuevo tipo de descuento')
		return
	end if
	commit;	
else
	dw_datos.update()
end if
setmicrohelp("Proceso...Listo")
setpointer(arrow!)


end event

event ue_insert;call super::ue_insert;string ls_secue

select to_char(max(to_number(dc_codigo) + 1))
into :ls_secue
from fa_dctocli;


dw_datos.setitem(dw_datos.getrow(),"dc_codigo",ls_secue)
dw_datos.setfocus()
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_descuento_cliente
integer x = 5
integer y = 0
integer width = 1070
integer height = 948
string dataobject = "d_descuento_cliente"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_descuento_cliente
integer x = 46
integer y = 268
integer width = 169
integer height = 200
integer taborder = 0
end type


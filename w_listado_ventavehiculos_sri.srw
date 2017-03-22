HA$PBExportHeader$w_listado_ventavehiculos_sri.srw
$PBExportComments$Si.
forward
global type w_listado_ventavehiculos_sri from w_sheet_1_dw_maint
end type
end forward

global type w_listado_ventavehiculos_sri from w_sheet_1_dw_maint
integer width = 3177
integer height = 1644
string title = "Venta de veh$$HEX1$$ed00$$ENDHEX$$culos"
long backcolor = 67108864
end type
global w_listado_ventavehiculos_sri w_listado_ventavehiculos_sri

on w_listado_ventavehiculos_sri.create
call super::create
end on

on w_listado_ventavehiculos_sri.destroy
call super::destroy
end on

event ue_saveas;dw_report.retrieve(str_appgeninfo.sucursal)
dw_report.saveas()


end event

event activate;call super::activate;m_marco.m_archivo.m_salvarcomo.enabled = true
end event

event deactivate;call super::deactivate;m_marco.m_archivo.m_salvarcomo.enabled = false
end event

event open;dw_report.SetTransObject(sqlca)
ib_notautoretrieve = true
call super :: open
end event

event ue_retrieve;dw_datos.retrieve(str_appgeninfo.sucursal)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_listado_ventavehiculos_sri
integer y = 120
integer width = 3118
integer height = 1316
string dataobject = "d_sri_seleccionafactura"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_listado_ventavehiculos_sri
integer x = 946
integer y = 740
string dataobject = "d_sri_xml2"
end type


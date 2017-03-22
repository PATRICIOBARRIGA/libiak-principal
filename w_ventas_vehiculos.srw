HA$PBExportHeader$w_ventas_vehiculos.srw
$PBExportComments$Si.
forward
global type w_ventas_vehiculos from w_sheet_1_dw_maint
end type
end forward

global type w_ventas_vehiculos from w_sheet_1_dw_maint
integer width = 3593
integer height = 1868
string title = "Registro de facturas para el SRI"
long backcolor = 67108864
end type
global w_ventas_vehiculos w_ventas_vehiculos

type variables
datawindowchild   idwc_prov
end variables

on w_ventas_vehiculos.create
call super::create
end on

on w_ventas_vehiculos.destroy
call super::destroy
end on

event open;String ls_parametro[]

dw_datos.insertrow(0)
ls_parametro[1] = '593' //ecuador por default
f_recupera_datos(dw_datos,"ri_codprovincia",ls_parametro,1) 
ls_parametro[] ={'593','17'}//Pichincha por defaut
f_recupera_datos(dw_datos,"ri_codmatriculacion",ls_parametro,2) 
ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;dw_datos.retrieve(str_appgeninfo.sucursal)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ventas_vehiculos
integer width = 3557
integer height = 1752
string dataobject = "d_ventas_sri"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_datos::itemfocuschanged;String ls_parametro[],ls_codpais ,ls_codprov
ls_parametro[] ={'593','17'}//Pichincha por defaut


ls_codprov = this.getitemstring(row,"ri_codprovincia")
ls_parametro[] = {'593',mid(ls_codprov,2)}
f_recupera_datos(dw_datos,"ri_codmatriculacion",ls_parametro,2) 

end event

event dw_datos::itemchanged;call super::itemchanged;String ls_parametro[],ls_nulo ,ls_codprov
ls_parametro[] ={'593','17'}//Pichincha por defaut

if dwo.name = 'ri_codprovincia' then
setnull(ls_nulo)	
ls_parametro[] = {'593',mid(data,2)}
dw_datos.setitem(dw_datos.getrow(),"ri_codmatriculacion",ls_nulo)
f_recupera_datos(dw_datos,"ri_codmatriculacion",ls_parametro,2) 

end if
end event

event dw_datos::updatestart;call super::updatestart;this.SetItem(this.GetRow(),"su_codigo",str_appgeninfo.sucursal)
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_ventas_vehiculos
integer x = 1952
integer y = 1020
string dataobject = "d_ventas_sri"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type


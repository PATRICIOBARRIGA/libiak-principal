HA$PBExportHeader$w_items_x_proveedor.srw
$PBExportComments$Si.Para mantenimiento de precios de lista y descuentos por proveedor
forward
global type w_items_x_proveedor from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_items_x_proveedor
end type
end forward

global type w_items_x_proveedor from w_sheet_1_dw_maint
integer width = 4096
integer height = 2008
string title = "Items por Proveedor"
long backcolor = 67108864
dw_1 dw_1
end type
global w_items_x_proveedor w_items_x_proveedor

type variables
String is_pvcodigo
DateTime id_hoy
end variables

on w_items_x_proveedor.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_items_x_proveedor.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;ib_notautoretrieve = true
dw_1.insertrow(0)
f_recupera_empresa(dw_1,"proveedor")


SELECT sysdate
INTO :id_hoy
FROM DUAL;

call super::open

end event

event ue_insert;call super::ue_insert;Long ll_row
ll_row = dw_datos.getrow()

If ll_row <> 0 then
	dw_datos.Setitem(ll_row,"em_codigo",str_appgeninfo.empresa)
End if
end event

event ue_retrieve;String ls_pvcodigo

dw_1.AcceptText()
ls_pvcodigo = dw_1.getitemstring(1,"proveedor")
dw_datos.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_items_x_proveedor
integer y = 152
integer width = 4050
integer height = 1748
string dataobject = "d_items_x_proveedor"
boolean hsplitscroll = true
end type

event dw_datos::itemchanged;call super::itemchanged;
String ls,ls_nombre,ls_pepa,ls_pvcodigo


If dwo.name = "codigo" then
select it_codigo,it_nombre
into :ls_pepa,:ls_nombre
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codant = :data;
if sqlca.sqlcode <> 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","C$$HEX1$$f300$$ENDHEX$$digo de producto no existe..."+sqlca.sqlerrtext)
	return 
end if
this.setitem(row,"nombre_producto",ls_nombre)
this.setitem(row,"it_codigo",ls_pepa)
end if

this.setitem(row,"pv_codigo",is_pvcodigo)
this.setitem(row,"f_modificacion",id_hoy)
end event

event dw_datos::doubleclicked;Long i
Decimal lc_valor,lc_costunit

This.AcceptText()


If dwo.name = 'ip_plista'&
Then
	lc_valor = This.GetItemNumber(row,"ip_plista")
	for i = row to this.rowcount()
	this.setitem(i,"ip_plista",lc_valor)
	next	
End if


If dwo.name = 'ip_desc1'&
Then
	lc_valor = This.GetItemNumber(row,"ip_desc1")
	for i = row to this.rowcount()
	this.setitem(i,"ip_desc1",lc_valor)
	next	
End if

If dwo.name = 'ip_desc2'&
Then
	lc_valor = This.GetItemNumber(row,"ip_desc2")
	for i = row to this.rowcount()
	this.setitem(i,"ip_desc2",lc_valor)
	next	
End if

If dwo.name = 'ip_desc3'&
Then
	lc_valor = This.GetItemNumber(row,"ip_desc3")
	for i = row to this.rowcount()
	this.setitem(i,"ip_desc3",lc_valor)
	next	
End if

return 1

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_items_x_proveedor
integer y = 4
integer width = 4050
integer height = 1896
end type

type dw_1 from datawindow within w_items_x_proveedor
integer x = 27
integer y = 32
integer width = 1527
integer height = 96
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_proveedor"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_pvcodigo = data
parent.triggerevent("ue_retrieve")
end event


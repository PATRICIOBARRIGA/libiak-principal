HA$PBExportHeader$w_rep_stk_items_x_suc.srw
$PBExportComments$Reporte de Stk de productos por sucursales
forward
global type w_rep_stk_items_x_suc from window
end type
type st_1 from statictext within w_rep_stk_items_x_suc
end type
type sle_1 from singlelineedit within w_rep_stk_items_x_suc
end type
type dw_datos from datawindow within w_rep_stk_items_x_suc
end type
end forward

global type w_rep_stk_items_x_suc from window
integer width = 1815
integer height = 2136
boolean titlebar = true
string title = "Stock de productos"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
st_1 st_1
sle_1 sle_1
dw_datos dw_datos
end type
global w_rep_stk_items_x_suc w_rep_stk_items_x_suc

event open;dw_datos.settransobject(sqlca)
end event

on w_rep_stk_items_x_suc.create
this.st_1=create st_1
this.sle_1=create sle_1
this.dw_datos=create dw_datos
this.Control[]={this.st_1,&
this.sle_1,&
this.dw_datos}
end on

on w_rep_stk_items_x_suc.destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.dw_datos)
end on

type st_1 from statictext within w_rep_stk_items_x_suc
integer x = 69
integer y = 28
integer width = 247
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Producto:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rep_stk_items_x_suc
integer x = 325
integer y = 20
integer width = 512
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_atomo,ls_codant,ls_kit,ls_codigo
decimal lc_equivalencia

ls_codant = this.text

/*Verificar si es Kit o no*/
select it_kit,it_codigo
into :ls_kit,:ls_codigo
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codant = :ls_codant;

If sqlca.sqlcode = 100 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe c$$HEX1$$f300$$ENDHEX$$digo del producto")
	return
End if



If ls_kit = 'S' Then
	select y.it_codigo, y.ri_cantid
	into :ls_atomo, :lc_equivalencia
	from  in_item x,in_relitem y
	where x.em_codigo = y.em_codigo
	and x.it_codigo = y.it_codigo1
	and y.em_codigo = :str_appgeninfo.empresa
	and x.it_codant = :ls_codant;
else
	ls_atomo = ls_codigo
	lc_equivalencia = 1
end if	
	
if not isnull(ls_codant) and ls_codant <> '' then
	dw_datos.Retrieve(lc_equivalencia,str_appgeninfo.empresa,ls_atomo,ls_codant)		
end if	














end event

type dw_datos from datawindow within w_rep_stk_items_x_suc
integer x = 27
integer y = 120
integer width = 1733
integer height = 1892
integer taborder = 10
string title = "none"
string dataobject = "dw_consulta_stk_sucursales"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


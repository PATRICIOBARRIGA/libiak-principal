HA$PBExportHeader$w_rep_proveedores.srw
$PBExportComments$Listado de proveedores
forward
global type w_rep_proveedores from w_sheet_1_dw_rep
end type
type cb_1 from commandbutton within w_rep_proveedores
end type
end forward

global type w_rep_proveedores from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2802
integer height = 1464
string title = "Reporte de Proveedores"
long backcolor = 12632256
cb_1 cb_1
end type
global w_rep_proveedores w_rep_proveedores

type variables

end variables

on w_rep_proveedores.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_rep_proveedores.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;this.ib_notautoretrieve = true
call super::open
dw_datos.retrieve(str_appgeninfo.empresa)

end event

event ue_retrieve;beep(1)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_proveedores
integer x = 0
integer y = 144
integer width = 2770
integer height = 1216
integer taborder = 20
string dataobject = "d_rep_proveedores"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_proveedores
integer x = 23
integer y = 252
integer taborder = 30
end type

type cb_1 from commandbutton within w_rep_proveedores
integer x = 2359
integer y = 28
integer width = 361
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtrar"
end type

event clicked;string ls_tipo, ls_activo, ls_filtro
string ls_nulo

setnull(ls_nulo)

//If dwo.name = "b_1" Then
//	dw_1.AcceptText()
//	dw_datos.setredraw(false)
//	ls_tipo =dw_1.GetItemString(1,'pv_tipo')
//	ls_activo =dw_1.GetItemString(1,'pv_activo')
//
//	ls_filtro="(em_codigo = '"+ str_appgeninfo.empresa+"' )" 
////	ls_filtro = "(pv_tipo like '%' )"
//	if not isnull(ls_tipo) and ls_tipo<>'' then
//		ls_filtro="(pv_tipo = '"+ ls_tipo+"' ) and  "+ls_filtro
//	end if
//	if not isnull(ls_activo) and ls_activo<>'' then
//		ls_filtro="(pv_activo = '"+ ls_activo+"' ) and "+ls_filtro
//	end if
//	dw_datos.SetFilter(ls_filtro)
//	dw_datos.filter()
////	dw_datos.groupcalc()
//	dw_datos.setredraw(true)
//	setpointer(Arrow!)
//End if

dw_datos.setfilter(ls_nulo)
dw_datos.filter()

end event


HA$PBExportHeader$w_ubicacion_productos.srw
$PBExportComments$Si.
forward
global type w_ubicacion_productos from w_sheet_1_dw
end type
type dw_ubica from datawindow within w_ubicacion_productos
end type
end forward

global type w_ubicacion_productos from w_sheet_1_dw
integer width = 3826
integer height = 1408
string title = "Ubicaci$$HEX1$$f300$$ENDHEX$$n de Productos"
long backcolor = 81324524
event ue_update pbm_custom07
event ue_delete pbm_custom08
event ue_insert pbm_custom09
event ue_enterqry pbm_custom20
event ue_execqry pbm_custom21
event ue_consultar pbm_custom16
dw_ubica dw_ubica
end type
global w_ubicacion_productos w_ubicacion_productos

type variables
string is_titulo
end variables

event ue_update;call super::ue_update;dw_datos.uf_updateCommit()
end event

event ue_delete;call super::ue_delete;dw_datos.uf_deleteCurrentRow()
end event

event ue_insert;call super::ue_insert;dw_datos.uf_InsertCurrentRow()
end event

event ue_enterqry;call super::ue_enterqry;string  ls_select

is_titulo = this.title
dw_datos.Modify("DataWindow.QueryMode=yes")
this.title = this.title + " (Consulta)"
//dw_datos.Modify("DataWindow.Color='8421376'")
//ls_select = dw_datos.GetSQLSelect()
//MessageBox("SELECT",ls_select)
end event

event ue_execqry;call super::ue_execqry;//string  ls_oldsql,ls_where,ls_caracter,ls_aux,ls_newsql
//long    ll_where
//integer li_ands,li_igual
//boolean lb_likes


//ls_oldsql = upper(dw_datos.GetSQLSelect())
//MessageBox("SELECT DE EJECUCION",ls_oldsql)
//ll_where = pos(ls_oldsql,"WHERE") + 5
//ls_where = right(ls_oldsql,len(ls_oldsql)-ll_where)
//
//li_ands = pos(ls_where,"AND")
//ls_newsql = left(ls_oldsql,ll_where)
//if li_ands > 0 then
//	ls_caracter = ""
//  do while ls_caracter <> ";"
//	  ls_aux = left(ls_where,li_ands+3)
//	  lb_likes = match(ls_aux,"%")
//	  if lb_likes then
//		  li_igual = pos(ls_aux,"=")
//		  ls_aux = replace(ls_aux,li_igual,1,"LIKE")
//	  end if
//	  li_ands = pos(ls_aux,"AND")
//	  if li_ands > 0 then
//	    ls_newsql = ls_newsql + left(ls_aux,li_ands+3)
//		 ls_where = right(ls_where,len(ls_where)-len(ls_aux))
//       li_ands = pos(ls_where,"AND")
//		 if li_ands = 0 then
//			li_ands = len(ls_where)
//		 end if
//	  else
//		 ls_newsql = ls_newsql + ls_aux
//		 ls_caracter = ";"
//	  end if
//  loop
//end if

//dw_datos.SetSQLSelect(ls_newsql)
//dw_datos.retrieve('1')
this.postevent("ue_retrieve")

//dw_datos.Modify("DataWindow.Color='12632256'")
dw_datos.Modify("DataWindow.QueryMode=no")
this.title = is_titulo
//dw_datos.SetSqlSelect(ls_oldsql)
end event

event ue_consultar;dw_datos.postevent(DoubleClicked!)
end event

on w_ubicacion_productos.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
end on

on w_ubicacion_productos.destroy
call super::destroy
destroy(this.dw_ubica)
end on

event open;dw_datos.settransobject(sqlca)
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
ib_notautoretrieve = true
call super::open
end event

event activate;return 1
end event

type dw_datos from w_sheet_1_dw`dw_datos within w_ubicacion_productos
integer x = 23
integer y = 0
integer width = 3758
integer height = 1268
string dataobject = "d_ubicacion_productos"
end type

event dw_datos::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

event dw_datos::doubleclicked;call super::doubleclicked;dw_ubica.object.factura_t.text = 'C$$HEX1$$f300$$ENDHEX$$digo:'
dw_ubica.reset()
dw_ubica.insertrow(1)
dw_ubica.setcolumn(1)
dw_ubica.setfocus()
dw_ubica.Visible = true



end event

type dw_report from w_sheet_1_dw`dw_report within w_ubicacion_productos
integer y = 120
integer width = 302
integer height = 112
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_ubica from datawindow within w_ubicacion_productos
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 622
integer y = 108
integer width = 1445
integer height = 272
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Producto"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
    dw_datos.SetFocus()
	dw_datos.SetFilter('')
	dw_datos.Filter()
end if
end event

event itemchanged;string ls_codigo,ls_tipo
long ll_found

/*Ubicar codigo del producto*/
CHOOSE CASE this.GetColumnName()

	CASE 'factura'
		ls_tipo = this.GetItemString(1,'tipo')
		ls_codigo = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ll_found = dw_datos.Find("codigo = '"+ls_codigo+"'",1,dw_datos.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_datos.SetFocus()
				  dw_datos.ScrollToRow(ll_found)
				  dw_datos.SetRow(ll_found)
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','C$$HEX1$$f300$$ENDHEX$$digo de producto no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				dw_datos.SetFilter("codigo like '"+ls_codigo+"'")
				dw_datos.Filter()
				dw_datos.SetFocus()
				this.Visible = false	
				dw_datos.ScrollToRow(dw_datos.GetRow())
				dw_datos.SetRow(dw_datos.GetRow())				
				
		END CHOOSE
END CHOOSE
end event


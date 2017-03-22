HA$PBExportHeader$w_sheet_1_dw_maint.srw
forward
global type w_sheet_1_dw_maint from w_sheet_1_dw
end type
end forward

global type w_sheet_1_dw_maint from w_sheet_1_dw
event ue_update pbm_custom07
event ue_delete pbm_custom08
event ue_insert pbm_custom09
event ue_enterqry pbm_custom20
event ue_execqry pbm_custom21
end type
global w_sheet_1_dw_maint w_sheet_1_dw_maint

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

on w_sheet_1_dw_maint.create
call super::create
end on

on w_sheet_1_dw_maint.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw`dw_datos within w_sheet_1_dw_maint
end type

event dw_datos::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from w_sheet_1_dw`dw_report within w_sheet_1_dw_maint
integer width = 1435
integer height = 396
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event


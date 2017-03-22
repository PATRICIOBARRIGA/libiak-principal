HA$PBExportHeader$w_rep_ventas_prod_x_fabri.srw
$PBExportComments$OJO Revisar PB
forward
global type w_rep_ventas_prod_x_fabri from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_ventas_prod_x_fabri
end type
end forward

global type w_rep_ventas_prod_x_fabri from w_sheet_1_dw_rep
integer width = 2912
integer height = 1552
string title = "Reporte de Ventas"
long backcolor = 67108864
dw_sel_rep dw_sel_rep
end type
global w_rep_ventas_prod_x_fabri w_rep_ventas_prod_x_fabri

on w_rep_ventas_prod_x_fabri.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_ventas_prod_x_fabri.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;this.ib_notautoretrieve = true
dw_datos.SetTransObject(sqlca)
dw_sel_rep.InsertRow(0)
dw_sel_rep.setfocus()
call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event ue_retrieve;long ll_row
string ls_titulo,ls_tipo
int li_estado[2]
date fec_ini, fec_fin,ld_hoy

SetPointer(HourGlass!)
select trunc(sysdate)
into:ld_hoy
from dual;

dw_sel_rep.AcceptText()
ls_tipo = dw_sel_rep.GetItemString(1,'estado')
fec_ini = dw_sel_rep.GetItemDate(1,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(1,'fec_fin')

choose case ls_tipo
case 'TI'
li_estado[1] = 2
ls_titulo = 'Ventas de Productos por Fabricante  (Tickets)'
case 'FA'
li_estado[1] = 1
ls_titulo = 'Ventas de Productos por Fabricante  (Facturas)'
case 'TF'
li_estado[] = {1,2}
ls_titulo = 'Ventas de Productos por Fabricante  (Tickets y Facturas)'
case 'NT'
li_estado[1] = 10	
ls_titulo = 'Devoluciones de Productos por Fabricante  (Tickets)'
case 'NF'
li_estado[1] = 9		
ls_titulo = 'Devoluciones de Productos por Fabricante  (Facturas)'
case 'NC'	
li_estado[] = {9,10}
ls_titulo = 'Devoluciones de Productos por Fabricante  (Tickets y Facturas)'
end choose

dw_datos.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"' st_grupo.text ='"+ls_titulo+"'" )	
dw_datos.Retrieve(integer(str_appgeninfo.sucursal),li_estado,fec_ini,fec_fin)
SetPointer(Arrow!)



end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ventas_prod_x_fabri
integer x = 0
integer y = 216
integer width = 2875
integer height = 1208
string dataobject = "d_rep_ventas_prod_x_fabri"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ventas_prod_x_fabri
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_ventas_prod_x_fabri
end type

type dw_sel_rep from datawindow within w_rep_ventas_prod_x_fabri
integer width = 2875
integer height = 216
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rep_ventas_prod_x_fabri"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;//long ll_filact
//string ls_estado,ls_order,ls_estado1,ep_codigo,ls_nombre
//date fec_ini, fec_fin
//datawindowChild ldw_aux
//
//ll_filact = row
//SetPointer(HourGlass!)
//dw_datos.SetRedraw(false)
//this.AcceptText()
//ls_estado = this.GetItemString(ll_filact,'estado')
//fec_ini = this.GetItemDate(ll_filact,'fec_ini')
//fec_fin = this.GetItemDate(ll_filact,'fec_fin')
//ls_order=GetItemString(row,'order')+ ' A'
//
//choose case ls_estado
//	case '1'
//		ls_estado1='5'
//	case '2'
//		ls_estado1='6'
//	case else
//		ls_estado1=ls_estado
//end choose
//CHOOSE CASE this.GetColumnName()
//	case 'fec_ini','fec_fin'
//	if ls_estado<>'D' then // devoluciones
//			dw_datos.ScrollToRow(1)
//			dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_estado,ls_estado1, fec_ini, fec_fin)
//	else
//			dw_datos.ScrollToRow(1)
//			dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini, fec_fin)
//	end if
//	CASE 'estado'
//		ls_estado = data
//		if ls_estado<>'D' then // devoluciones
//			dw_datos.ScrollToRow(1)
//			dw_datos.DataObject='d_rep_venta_fecha'				
//			dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
//								"datawindow.print.preview=yes")
//			dw_datos.SetTransObject(sqlca)
//			dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_estado,ls_estado1, fec_ini, fec_fin)
//		else
//			dw_datos.ScrollToRow(1)
//			dw_datos.DataObject='d_rep_venta_devoluciones'				
//			dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
//								"datawindow.print.preview=yes")
//			dw_datos.SetTransObject(sqlca)
//			dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini, fec_fin,ls_nombre)
//		end if
//	
//END CHOOSE
//
//if ls_estado='D' then //devoluciones
//	ep_codigo=GetItemString(row,'ep_codigo')
//	if not isnull(ep_codigo) then
//		dw_datos.SetFilter("ep_codigo='"+ep_codigo+"'")
//		dw_datos.Filter()
//		GetChild('ep_codigo',ldw_aux)
//		ls_nombre=ldw_aux.GetItemString(ldw_aux.GetRow(),'c_nombre')
//		if isnull(ls_nombre) then
//			ls_nombre=''
//		else
//			ls_nombre=' / '+ls_nombre			
//		end if
//		dw_datos.object.st_titulo.text="Reporte de Devoluciones"+ls_nombre
//	else
//		dw_datos.SetFilter("ep_codigo like '%'")
//		dw_datos.Filter()
//	end if
//end if
//dw_datos.SetSort(ls_order)
//dw_datos.Sort()
//dw_datos.GroupCalc()
//SetPointer(Arrow!)
//dw_datos.SetRedraw(true)
end event


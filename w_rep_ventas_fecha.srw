HA$PBExportHeader$w_rep_ventas_fecha.srw
$PBExportComments$OJO Revisar PB
forward
global type w_rep_ventas_fecha from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_ventas_fecha
end type
end forward

global type w_rep_ventas_fecha from w_sheet_1_dw_rep
integer width = 2912
integer height = 1552
string title = "Reporte de Ventas"
long backcolor = 67108864
dw_sel_rep dw_sel_rep
end type
global w_rep_ventas_fecha w_rep_ventas_fecha

on w_rep_ventas_fecha.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_ventas_fecha.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;long fila
string as_datos[2]

this.ib_notautoretrieve = true
datawindowchild ldwc_aux
dw_sel_rep.getChild("estado",ldwc_aux)
ldwc_aux.setTransObject(sqlca)
ldwc_aux.Retrieve()

fila=ldwc_aux.InsertRow(0)
ldwc_aux.SetItem(fila ,'es_descri','Facturas POS y Anulaciones')
ldwc_aux.SetItem(fila,'es_codigo','P') // no cambiar de letra

fila=ldwc_aux.InsertRow(0)
ldwc_aux.SetItem(fila ,'es_descri','Facturas x Mayor y Anulaciones')
ldwc_aux.SetItem(fila,'es_codigo','F') // no cambiar de letra

fila=ldwc_aux.InsertRow(0)
ldwc_aux.SetItem(fila,'es_descri','Notas de Cr$$HEX1$$e900$$ENDHEX$$dito')
ldwc_aux.SetItem(fila,'es_codigo','D') // no cambiar de letra
ldwc_aux.ScrollToRow(1)
dw_sel_rep.InsertRow(0)
as_datos[1] = str_appgeninfo.empresa
as_datos[2] = str_appgeninfo.sucursal
f_recupera_datos(dw_sel_rep,'ep_codigo',as_datos,2)
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
string ls_estado,ep_codigo,ls_nombre,ls_descri
date fec_ini, fec_fin

SetPointer(HourGlass!)
dw_datos.SetRedraw(false)

dw_sel_rep.AcceptText()
ll_row = dw_sel_rep.getrow()
ls_estado = dw_sel_rep.GetItemString(ll_row,'estado')
fec_ini = dw_sel_rep.GetItemDate(ll_row,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(ll_row,'fec_fin')

select es_descri
into :ls_descri
from fa_estado
where es_codigo = :ls_estado;

ls_descri = 'Reporte de '+ls_descri
choose case ls_estado
	case 'D' 
	dw_datos.ScrollToRow(1)
	dw_datos.DataObject='d_rep_venta_devoluciones'				
	dw_datos.SetTransObject(sqlca)
	dw_datos.Retrieve(integer(str_appgeninfo.sucursal),fec_ini, fec_fin)
	ls_descri = 'Reporte de Devoluciones'
	case 'F'
	dw_datos.ScrollToRow(1)
	dw_datos.DataObject='d_rep_venta_fxm_anuladas'
	dw_datos.SetTransObject(sqlca)
	dw_datos.Retrieve(integer(str_appgeninfo.sucursal),fec_ini, fec_fin)
	ls_descri = 'Reporte de Facturas al por Mayor y Anuladas'
	case 'P'
	dw_datos.ScrollToRow(1)
	dw_datos.DataObject='d_rep_venta_fpos_anuladas'
	dw_datos.SetTransObject(sqlca)
	dw_datos.Retrieve(integer(str_appgeninfo.sucursal),fec_ini, fec_fin)
	ls_descri = 'Reporte de Facturas Punto de Venta (POS) y Anuladas'
	case else
	dw_datos.ScrollToRow(1)
	dw_datos.DataObject='d_rep_venta_fecha'	
	dw_datos.SetTransObject(sqlca)
	dw_datos.Retrieve(integer(str_appgeninfo.sucursal),integer(ls_estado),fec_ini, fec_fin)
end choose
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text='"+gs_su_nombre+"' st_estado.text='"+ls_descri+"'"+& 
						"datawindow.print.preview.zoom=100  datawindow.print.preview=yes")
SetPointer(Arrow!)
dw_datos.SetRedraw(true)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ventas_fecha
integer x = 0
integer y = 216
integer width = 2875
integer height = 1208
string dataobject = "d_rep_venta_fecha"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ventas_fecha
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_ventas_fecha
end type

type dw_sel_rep from datawindow within w_rep_ventas_fecha
integer width = 2875
integer height = 216
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rep_ventas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


HA$PBExportHeader$w_rep_demanda_insatisfecha.srw
$PBExportComments$Reporte de la Demanda Insatisfecha por sucursal.
forward
global type w_rep_demanda_insatisfecha from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_demanda_insatisfecha
end type
end forward

global type w_rep_demanda_insatisfecha from w_sheet_1_dw_rep
integer width = 2912
integer height = 1552
string title = "Reporte de Ventas"
long backcolor = 81324524
dw_sel_rep dw_sel_rep
end type
global w_rep_demanda_insatisfecha w_rep_demanda_insatisfecha

on w_rep_demanda_insatisfecha.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_demanda_insatisfecha.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;this.ib_notautoretrieve = true
dw_sel_rep.InsertRow(0)
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

event ue_retrieve;long ll_filact
date fec_ini, fec_fin

dw_sel_rep.accepttext()
ll_filact = dw_sel_rep.GetRow()
SetPointer(HourGlass!)
fec_ini = dw_sel_rep.GetItemDate(ll_filact,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(ll_filact,'fec_fin')

if fec_ini>fec_fin then
	messageBox("Error","Rango de Fechas Incorrecto",StopSign!)
else
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text='"+gs_su_nombre+"'")
	dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'1', fec_ini, fec_fin)
end if
SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_demanda_insatisfecha
integer x = 0
integer y = 136
integer width = 2875
integer height = 1304
integer taborder = 0
string dataobject = "d_rep_demanda_insatisfecha"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_demanda_insatisfecha
integer y = 228
integer taborder = 0
end type

type dw_sel_rep from datawindow within w_rep_demanda_insatisfecha
integer width = 2875
integer height = 140
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_fechas_productos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;//long ll_filact
//string ls_estado='1' // para facturas al por mayor
//date fec_ini, fec_fin
//
//ll_filact = this.GetRow()
//SetPointer(HourGlass!)
//CHOOSE CASE this.GetColumnName()
//	CASE 'fec_ini'
//		fec_ini = date(data)
//		fec_fin = this.GetItemDate(ll_filact,'fec_fin')
//
//	CASE 'fec_fin'
//		fec_fin = date(data)
//		fec_ini = this.GetItemDate(ll_filact,'fec_ini')
//
//END CHOOSE
//if fec_ini>fec_fin then
//	messageBox("Error","Rango de Fechas Incorrecto",StopSign!)
//else
//	dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_estado, fec_ini, fec_fin)
//end if
//SetPointer(Arrow!)
end event


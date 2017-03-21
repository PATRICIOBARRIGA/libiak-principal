HA$PBExportHeader$w_rep_facturas_vencidas.srw
$PBExportComments$Si.Facturas vencidas del sistema
forward
global type w_rep_facturas_vencidas from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_facturas_vencidas
end type
end forward

global type w_rep_facturas_vencidas from w_sheet_1_dw_rep
integer width = 3246
integer height = 2028
string title = "Facturas Vencidas"
long backcolor = 79741120
dw_sel_rep dw_sel_rep
end type
global w_rep_facturas_vencidas w_rep_facturas_vencidas

type variables

end variables

on w_rep_facturas_vencidas.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_facturas_vencidas.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;datawindowchild dwc_empleado

dw_sel_rep.InsertRow(0)
dw_sel_rep.setfocus()
dw_datos.SetTransObject(sqlca)
f_recupera_empresa(dw_datos,"ep_codigo")

this.ib_notautoretrieve = true
call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
dw_report.resize(dw_sel_rep.width,li_height - dw_report.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event close;call super::close;//dw_report.sharedataoff()
end event

event ue_print;string ls_tipo
int li_rc

//ls_tipo = dw_sel_rep.getitemstring(1,"tipo")
//if ls_tipo = 'D' or ls_tipo = 'S' then
	openwithparm(w_dw_print_options,dw_datos)
	li_rc = message.DoubleParm
	if li_rc = 1 then dw_datos.print()	
//end if


//if ls_tipo = 'R' then
//	openwithparm(w_dw_print_options,dw_report)
//	li_rc = message.DoubleParm
//	if li_rc = 1 then dw_report.print()	
//end if


end event

event ue_retrieve;date fec_ini, fec_fin
character lch_tipo
integer li_fila

SetPointer(HourGlass!)
dw_sel_rep.accepttext()
li_fila = dw_sel_rep.getrow()
fec_ini = dw_sel_rep.GetItemDate(li_fila,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(li_fila,'fec_fin')
lch_tipo = dw_sel_rep.GetItemstring(li_fila,'tipo')
If fec_ini > fec_fin and not isnull(fec_ini) Then
	messageBox("Error","Rango de Fechas Incorrecto")
	dw_datos.SetRedraw(True)
	SetPointer(Arrow!)
	return
End if

						  

dw_datos.reset()							  
If lch_tipo = 'D' Then
//	dw_datos.DataObject = 'facturas_vencidas_unnomotors'
	dw_datos.DataObject = 'facturas_vencidas_redcolor'
	dw_datos.SetTransObject(sqlca)
	f_recupera_empresa(dw_datos,"ep_codigo")
	dw_datos.Modify("datawindow.detail.height = '70'  datawindow.print.preview='yes' datawindow.print.preview.zoom='100'")
	dw_datos.Retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),fec_ini,fec_fin)
elseif lch_tipo = 'R' then
	dw_datos.Modify("datawindow.detail.height = '0'  datawindow.print.preview='yes' datawindow.print.preview.zoom='100'")
	dw_datos.Retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),fec_ini,fec_fin)
else
	//dw_datos.DataObject = 'facturas_vencidas_pintamax'
     dw_datos.DataObject = 'facturas_vencidas_redcolor'
	dw_datos.SetTransObject(sqlca)
	f_recupera_empresa(dw_datos,"ep_codigo")
	dw_datos.Modify("datawindow.print.preview='yes' datawindow.print.preview.zoom='100'")
	dw_datos.Retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),fec_ini,fec_fin)
End if




end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_facturas_vencidas
integer x = 0
integer y = 168
integer width = 3200
integer height = 1748
string dataobject = "facturas_vencidas"
boolean border = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event dw_datos::retrieveend;call super::retrieveend;Date fec_ini , fec_fin
String ls_titulo,ls_tipo

fec_ini = dw_sel_rep.GetItemDate(1,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(1,'fec_fin')

ls_tipo = dw_sel_rep.object.tipo[1]

choose case ls_tipo
	case 'D'
		ls_titulo = 'Reporte Detallado de facturas vencidas'
	case 'R'
		ls_titulo = 'Reporte Resumido de facturas vencidas'
	case 'S'
		ls_titulo = 'Reporte Simplificado de facturas vencidas'
end choose

dw_datos.Modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text ='"+gs_su_nombre+"' st_seccion.text ='"+gs_bo_nombre+"'"+&  
	"st_titulo.text='"+ls_titulo+ " Desde: "+string(fec_ini,'dd/mm/yyyy')+" Hasta: "+string(fec_fin,'dd/mm/yyyy')+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_facturas_vencidas
integer x = 9
integer y = 168
integer width = 219
integer height = 140
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_facturas_vencidas
integer x = 274
integer y = 176
integer width = 265
integer height = 128
end type

type dw_sel_rep from datawindow within w_rep_facturas_vencidas
integer width = 3200
integer height = 168
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_emp_clien_fechas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;//char lch_tipo
//int li_rc
//
//If dwo.name = "tipo" Then
//	lch_tipo = this.getitemstring(row,"tipo")
//	if lch_tipo = 'R' then
//		dw_report.visible = false
//		dw_datos.visible = true
//	end if
//	if lch_tipo = 'D' then
//		dw_report.visible = true
//		dw_datos.visible = false
//	end if
//End if
end event


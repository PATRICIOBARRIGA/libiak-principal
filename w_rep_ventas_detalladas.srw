HA$PBExportHeader$w_rep_ventas_detalladas.srw
$PBExportComments$Ventas agrupadas por cliente o vendedor.
forward
global type w_rep_ventas_detalladas from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_ventas_detalladas
end type
end forward

global type w_rep_ventas_detalladas from w_sheet_1_dw_rep
integer x = 9
integer y = 248
integer width = 3017
integer height = 1484
string title = "Detalle de Ventas"
long backcolor = 1090519039
dw_1 dw_1
end type
global w_rep_ventas_detalladas w_rep_ventas_detalladas

type variables
string   is_pepa 
end variables

forward prototypes
public function integer wf_filtro_reporte (ref datawindow dw, ref string ls_filtro, string ls_reporte)
end prototypes

public function integer wf_filtro_reporte (ref datawindow dw, ref string ls_filtro, string ls_reporte);dw.Object.f.visible=False
dw.Object.nv.visible=False
dw.Object.nvf.visible=False
if ls_reporte='1'then
		dw_datos.Object.f.visible=True
		ls_filtro=" (estado='"+ls_reporte+"')"
else
		if ls_reporte='2' then
			dw_datos.Object.nv.visible=True
			ls_filtro=" (estado='"+ls_reporte+"')"
		else
			dw_datos.Object.nvf.visible=True
			ls_filtro=" (estado like '%')"
		end if
end if			
return 1
end function

on w_rep_ventas_detalladas.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_ventas_detalladas.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;string datos[1]

dw_1.InsertRow(0)
datos[1] = str_appgeninfo.empresa
//f_recupera_empresa(dw_1,'fb_codigo')
//f_recupera_empresa(dw_1,'vendedor')
//f_recupera_datos(dw_1,'cliente',datos,1)
//f_recupera_empresa(dw_1,'fp_codigo')
//f_recupera_empresa(dw_1,'if_codigo')
this.ib_notautoretrieve = true

call super::open

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;string ls_factotick,ls_tipo_reporte,ls_reporte,&
		 ls_cod_producto,ls_cod_clase,ls_producto,&
		 ls_fb_codigo,ls_null,ls_bo_codigo,ls_cli_vend
date fec_ini,fec_fin
integer li_estado[2]
boolean lb_pasa = false

setnull(ls_null)
dw_1.AcceptText()

fec_ini=dw_1.GetItemDate(1,'fec_ini')
fec_fin=dw_1.GetItemDate(1,'fec_fin')

dw_datos.SetRedraw(False)
SetPointer(HourGlass!)
ls_tipo_reporte=dw_1.GetItemString(1,'reporte')	
ls_factotick = dw_1.GetItemString(1,'tipo_reporte')	
If isnull(ls_tipo_reporte) or isnull(ls_factotick) then
	messageBox("Error","Faltan par$$HEX1$$e100$$ENDHEX$$metros...<Verifique>")
	return
End if
if fec_ini>fec_fin or isnull(fec_ini) then
		messageBox("Error","Rango de Fechas Incorrecto")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if
If ls_factotick = '3' Then
	li_estado[1] = 1
	li_estado[2] = 2
Else
	li_estado[1] = integer(ls_factotick)
End If

Choose Case ls_tipo_reporte
case 'Producto'	 
	If ls_factotick = '1' Then
		ls_tipo_reporte='Facturas por Producto'
	End if
	If ls_factotick = '2' Then
		ls_tipo_reporte='Facturas (POS) por Producto'
	End if
	If ls_factotick = '3' Then
		ls_tipo_reporte='Ventas por Producto'
	End if
	dw_datos.DataObject='d_rep_ventas_producto'
	dw_datos.SetTransObject(sqlca)
	dw_datos.retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),li_estado,fec_ini,fec_fin)
	  
case 'Cliente','Vendedor'
	If ls_tipo_reporte = 'Cliente' Then
		ls_cli_vend = 'Cliente'
		If ls_factotick = '1' Then
			ls_tipo_reporte='Facturas por Cliente'
		End if
		If ls_factotick = '2' Then
			ls_tipo_reporte='Facturas (POS) por Cliente'
		End if
		If ls_factotick = '3' Then
			ls_tipo_reporte='Ventas por cliente'
		End if
	End if
	If ls_tipo_reporte = 'Vendedor' Then
		ls_cli_vend = 'Vendedor'
		If ls_factotick = '1' Then
			ls_tipo_reporte='Facturas por Vendedor'
		End if
		If ls_factotick = '2' Then
			ls_tipo_reporte='Facturas (POS) por Vendedor'
		End if
		If ls_factotick = '3' Then
			ls_tipo_reporte='Ventas Por Vendedor'
		End if
	End if
	dw_datos.DataObject='d_rep_ventas_agrupado'
	dw_datos.SetTransObject(sqlca)						
	dw_datos.retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),li_estado,fec_ini,fec_fin,ls_cli_vend)
case 'fp_codigo'
		If ls_factotick = '1' Then
			ls_tipo_reporte='Facturas por Forma de Pago'
		End if
		If ls_factotick = '2' Then
			ls_tipo_reporte='Facturas (POS) por Forma de Pago'
		End if
		If ls_factotick = '3' Then
			ls_tipo_reporte='Detalle de Ventas por Formas de Pago'
		End if

	dw_datos.DataObject='d_rep_ventas_fp_agrupado'				
	dw_datos.SetTransObject(sqlca)
	f_recupera_empresa(dw_datos,'fp_codigo')	
	If dw_datos.retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),li_estado,fec_ini,fec_fin) < 1 Then
	   messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estos parametros")
	   return
     End if
case 'PV','PC'
	If ls_tipo_reporte = 'PV' Then
		ls_cli_vend = 'Vendedor'		
		If ls_factotick = '1' Then
			ls_tipo_reporte='Detalle de Facturas por Vendedor'
		End if
		If ls_factotick = '2' Then
			ls_tipo_reporte='Detalle de Facturas (POS) Por Vendedor'
		End if
		If ls_factotick = '3' Then
			ls_tipo_reporte='Detalle de Ventas Por Vendedor'
		End if
	End if
	If ls_tipo_reporte = 'PC' Then
		ls_cli_vend = 'Cliente'		
		If ls_factotick = '1' Then
			ls_tipo_reporte='Detalle de Facturas por Cliente'
		End if
		If ls_factotick = '2' Then
			ls_tipo_reporte='Detalle de Facturas (POS) Por Cliente'
		End if
		If ls_factotick = '3' Then
			ls_tipo_reporte='Detalle de Ventas Por Cliente'
		End if
	End if
	
	dw_datos.DataObject='d_rep_ventas_producto_agrupado'				
	dw_datos.SetTransObject(sqlca)
	dw_datos.retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),li_estado,fec_ini,fec_fin,ls_cli_vend)
end choose
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'"+&
					"st_grupo.text = '"+ls_tipo_reporte+"'")
dw_datos.modify("datawindow.print.preview='yes'")

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ventas_detalladas
integer x = 0
integer y = 176
integer width = 2990
integer height = 1196
string dataobject = "d_rep_ventas_agrupado"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ventas_detalladas
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_ventas_detalladas
end type

type dw_1 from datawindow within w_rep_ventas_detalladas
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 2990
integer height = 172
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rep_ventas_agrupadas_new"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event editchanged;String ls_data
datawindowchild dwc_aux
If dwo.name = "cliente" &
Then
ls_data = data+'%'
dwc_aux.SetFilter("cliente like '"+ls_data+"' ")
dwc_aux.Filter()
dw_1.GetChild("cliente",dwc_aux)
End if 
return 1
end event


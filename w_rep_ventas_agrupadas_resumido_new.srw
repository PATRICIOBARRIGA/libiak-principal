HA$PBExportHeader$w_rep_ventas_agrupadas_resumido_new.srw
forward
global type w_rep_ventas_agrupadas_resumido_new from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_ventas_agrupadas_resumido_new
end type
end forward

global type w_rep_ventas_agrupadas_resumido_new from w_sheet_1_dw_rep
integer width = 3273
integer height = 1824
string title = "Resumen de Ventas Agrupadas"
dw_1 dw_1
end type
global w_rep_ventas_agrupadas_resumido_new w_rep_ventas_agrupadas_resumido_new

on w_rep_ventas_agrupadas_resumido_new.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_ventas_agrupadas_resumido_new.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;datawindowchild ldw_aux

dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'fabricante')
f_recupera_empresa(dw_1,'bo_codigo')
dw_1.GetChild('bo_codigo',ldw_aux)
ldw_aux.SetFilter("su_codigo ='"+str_appgeninfo.sucursal+"'")
ldw_aux.Filter()
ldw_aux.insertrow(0)

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

event w_rep_ventas_agrupadas_resumido_new::ue_print;int li_res
openwithparm(w_dw_print_options,dw_datos)
li_res = message.doubleparm
if li_res <> 1 then
	li_res = 1
else
	li_res = dw_datos.print()
	if li_res = 1 then li_res = this.wf_postPrint()
end if

end event

event ue_retrieve;string ls_estado[2],ls_factotick,ls_tipo_reporte,ls_reporte,&
		 ls_cod_producto,ls_cod_clase,ls_producto,&
		 ls_fb_codigo,ls_null,ls_bo_codigo
date fec_ini,fec_fin
boolean lb_pasa = false
dec{2} lc_iva

setnull(ls_null)
dw_1.AcceptText()

fec_ini = dw_1.GetItemDate(1,'fec_ini')
fec_fin = relativedate(dw_1.GetItemDate(1,'fec_fin'),1)

dw_datos.SetRedraw(False)
SetPointer(HourGlass!)
ls_tipo_reporte=dw_1.GetItemString(1,'tipo_reporte')	
ls_factotick = dw_1.GetItemString(1,'reporte')	
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
	ls_estado[1] ="1"
	ls_estado[2] ="2"
Else
	ls_estado[1] =ls_factotick
End If

Choose Case ls_tipo_reporte
case 'Producto' 
	dw_datos.DataObject='d_rep_ventas_producto_resumido'
	dw_datos.SetTransObject(sqlca)
	 lc_iva = f_iva()
	dw_datos.retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin,lc_iva)
		
case 'Fecha'
	dw_datos.DataObject='d_rep_resumen_ventas_diario'					
	dw_datos.SetTransObject(sqlca)
	dw_datos.reset()
     dw_datos.retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)		
case 'PV','PC'
	if ls_tipo_reporte='PV' then// agrupado productos por vendedor
		ls_tipo_reporte='Vendedor'
	else // agrupado productos por cliente
		ls_tipo_reporte='Cliente'			
	end if
	dw_datos.DataObject='d_rep_ventas_prod_agrupado_resumido'
	dw_datos.SetTransObject(sqlca)						
	dw_datos.retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo_reporte,fec_ini,fec_fin)
case 'fp_codigo'
	dw_datos.DataObject='d_rep_ventas_fp_resumen'				
	dw_datos.SetTransObject(sqlca)
	If dw_datos.retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin) < 2 Then
	   messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estos parametros")
	   return
     End if
//case else //agrupado por Vendedor o Cliente y formas de pago
//	dw_datos.DataObject='d_rep_ventas_agrupado_resumido'				
//	dw_datos.SetTransObject(sqlca)
//	dw_datos.retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo_reporte,fec_ini,fec_fin)
end choose
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
choose case ls_factotick 
	case "1"
		dw_datos.modify("st_f.visible='1' st_nv.visible='0' st_nvyf.visible='0'") 
	case "2"
		dw_datos.modify("st_nv.visible='1' st_f.visible='0'  st_nvyf.visible='0'") 
	case "3"
		dw_datos.modify("st_nvyf.visible='1' st_nv.visible='0' st_f.visible='0'") 
end choose
dw_datos.modify("datawindow.print.preview='yes'")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ventas_agrupadas_resumido_new
integer x = 0
integer y = 200
integer width = 3232
integer height = 1536
string dataobject = "d_rep_resumen_ventas_diario"
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ventas_agrupadas_resumido_new
integer x = 14
integer y = 360
integer width = 270
integer height = 300
end type

type dw_1 from datawindow within w_rep_ventas_agrupadas_resumido_new
integer width = 3232
integer height = 196
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_rep_ventas_agrupadas_resumido"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


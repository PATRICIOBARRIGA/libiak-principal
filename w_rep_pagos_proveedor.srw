HA$PBExportHeader$w_rep_pagos_proveedor.srw
$PBExportComments$Si.Reporte de pagos en un rango de fechas.
forward
global type w_rep_pagos_proveedor from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_pagos_proveedor
end type
end forward

global type w_rep_pagos_proveedor from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2935
integer height = 1436
string title = "Pagos a Proveedores"
long backcolor = 1090519039
dw_1 dw_1
end type
global w_rep_pagos_proveedor w_rep_pagos_proveedor

type variables
string   is_pepa 
end variables

on w_rep_pagos_proveedor.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_pagos_proveedor.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'pv_codigo')
this.ib_notautoretrieve = true
call super::open
this.ib_inReportMode = True

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
dw_report.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_print;int li_rc
if dw_datos.visible=True then
	openwithparm(w_dw_print_options,dw_datos)
	li_rc = message.DoubleParm
//gi_print = 0
	if li_rc = 1 then
   	dw_datos.print()	
	end if
elseif dw_report.visible=True then
	openwithparm(w_dw_print_options,dw_report)
	li_rc = message.DoubleParm
//gi_print = 0
	if li_rc = 1 then
   	dw_report.print()	
	end if
end if
end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_pagos_proveedor
integer x = 0
integer y = 272
integer width = 2903
integer height = 1132
integer taborder = 20
string dataobject = "d_rep_movimiento_credito_cxp"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_pagos_proveedor
integer x = 5
integer y = 276
integer width = 1563
integer height = 700
integer taborder = 30
end type

type dw_1 from datawindow within w_rep_pagos_proveedor
integer width = 2898
integer height = 276
integer taborder = 10
string dataobject = "d_sel_rep_pagos_proveedor"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;string pv_codigo, ls_filtro, ls_tipo_reporte
date fec_ini,fec_fin
AcceptText()
pv_codigo=GetItemString(row,'pv_codigo')
ls_tipo_reporte=GetItemString(row,'tipo')
fec_ini=GetItemDate(row,'fecha_ini')
fec_fin=GetItemDate(row,'fecha_fin')
dw_Datos.SetRedraw(false)
SetPointer(HourGlass!)
if isnull(pv_codigo) then
	ls_filtro="(pv_codigo like '%')"
else
	ls_filtro="(pv_codigo='"+pv_codigo+"')"
end if
if ls_tipo_reporte='C' then
	ls_filtro=ls_filtro+"  and not isnull( pm_fecpa )"
elseif ls_tipo_reporte='P' then
	ls_filtro=ls_filtro+" and isnull(pm_fecpa) "
end if

Choose case GetColumnName()
	case 'fecha_ini','fecha_fin'
		if fec_ini>fec_fin or isnull(fec_ini) then
			dw_Datos.SetRedraw(True)
			SetPointer(Arrow!)
			return			
		end if
		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
end choose
dw_datos.ScrollToRow(1)
dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()
dw_Datos.SetRedraw(True)
SetPointer(Arrow!)
end event


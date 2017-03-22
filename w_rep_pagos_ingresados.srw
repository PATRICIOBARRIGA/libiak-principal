HA$PBExportHeader$w_rep_pagos_ingresados.srw
$PBExportComments$Si.Cheques Postfechados
forward
global type w_rep_pagos_ingresados from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_pagos_ingresados
end type
end forward

global type w_rep_pagos_ingresados from w_sheet_1_dw_rep
integer width = 2912
integer height = 1844
string title = "Cancelaciones"
long backcolor = 67108864
dw_sel_rep dw_sel_rep
end type
global w_rep_pagos_ingresados w_rep_pagos_ingresados

on w_rep_pagos_ingresados.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_pagos_ingresados.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;DatawindowChild       dwc


dw_datos.settransobject(sqlca)
dw_sel_rep.InsertRow(0)
dw_sel_rep.GetChild("tipo",dwc)
dwc.SetTransObject(SQLCA)
dwc.Retrieve(str_appgeninfo.empresa)
dwc.SetFilter("fp_string like '%T%' ")
dwc.Filter()
this.ib_notautoretrieve = true
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

event ue_retrieve;String ls_estado,ls_fp,ls_tipofp
Date   fecha,ld_fecfin


dw_sel_rep.AcceptText()

fecha  = dw_sel_rep.GetItemDate(1,"fecha")
ld_fecfin  = dw_sel_rep.GetItemDate(1,"fec_fin")
ls_fp  = dw_sel_rep.GetItemString(1,"tipo")

select fp_descri
into:ls_tipofp
from fa_formpag
where em_codigo = :str_appgeninfo.empresa
and fp_codigo = :ls_fp;

dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
dw_datos.Object.st_texto.Text='Reporte de pagos ingresados con '+ls_tipofp
					
dw_datos.Retrieve(str_appgeninfo.sucursal,fecha,ld_fecfin,ls_fp)


end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_pagos_ingresados
integer x = 0
integer y = 240
integer width = 2875
integer height = 1508
string dataobject = "d_rep_pagos_ingresados_por_dia"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_pagos_ingresados
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_pagos_ingresados
end type

type dw_sel_rep from datawindow within w_rep_pagos_ingresados
integer width = 2875
integer height = 240
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_fecha"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;//long ll_filact
//date fecha
//string ls 
//
//ll_filact = this.GetRow()
//SetPointer(HourGlass!)
//CHOOSE CASE this.GetColumnName()
//	CASE 'fecha'
//   		     fecha = date(this.GetText())
//			ls = this.GetItemString(ll_filact,'tipo')
//			if ls = 'C' then
//  			   dw_datos.DataObject = 'd_rep_cheques_vencidos_sif'
//			else
//			   dw_datos.DataObject = 'd_rep_efectivo_sif'				
//			end if
// 			dw_datos.SetTransObject(sqlca)
//			dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fecha)
//			dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
//								"datawindow.print.preview=yes")				
//   CASE 'tipo'
//   		ls= this.GetText()
//			fecha = this.GetItemdate(ll_filact,'fecha')
//			if ls = 'C' then
//  			   dw_datos.DataObject = 'd_rep_cheques_vencidos_sif'
//			else
//			   dw_datos.DataObject = 'd_rep_efectivo_sif'				
//			end if
// 			dw_datos.SetTransObject(sqlca)
//			dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fecha)
//			dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
//								"datawindow.print.preview=yes")		
//END CHOOSE
//
//SetPointer(Arrow!)
end event


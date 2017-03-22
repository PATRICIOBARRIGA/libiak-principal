HA$PBExportHeader$w_rep_pagos_diferidos.srw
$PBExportComments$Si.Cheques Postfechados
forward
global type w_rep_pagos_diferidos from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_pagos_diferidos
end type
type rb_empre from radiobutton within w_rep_pagos_diferidos
end type
type rb_sucur from radiobutton within w_rep_pagos_diferidos
end type
type rb_plazos from radiobutton within w_rep_pagos_diferidos
end type
end forward

global type w_rep_pagos_diferidos from w_sheet_1_dw_rep
integer width = 2912
integer height = 1624
string title = "Pagos diferidos"
dw_sel_rep dw_sel_rep
rb_empre rb_empre
rb_sucur rb_sucur
rb_plazos rb_plazos
end type
global w_rep_pagos_diferidos w_rep_pagos_diferidos

on w_rep_pagos_diferidos.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
this.rb_empre=create rb_empre
this.rb_sucur=create rb_sucur
this.rb_plazos=create rb_plazos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
this.Control[iCurrent+2]=this.rb_empre
this.Control[iCurrent+3]=this.rb_sucur
this.Control[iCurrent+4]=this.rb_plazos
end on

on w_rep_pagos_diferidos.destroy
call super::destroy
destroy(this.dw_sel_rep)
destroy(this.rb_empre)
destroy(this.rb_sucur)
destroy(this.rb_plazos)
end on

event open;DatawindowChild       dwc


dw_sel_rep.InsertRow(0)
dw_sel_rep.GetChild("tipo",dwc)
dwc.SetTransObject(SQLCA)
dwc.Retrieve(str_appgeninfo.empresa)
dwc.SetFilter("fp_string like '%T%' ")
dwc.Filter()
dw_report.settransobject(sqlca)
this.ib_notautoretrieve = true
call super::open




end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
dw_report.resize(dw_sel_rep.width,li_height - dw_report.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event ue_retrieve;String ls_estado,ls_fp,ls_tipofp
date  ld_fini,ld_ffin


dw_sel_rep.AcceptText()

ls_fp  = dw_sel_rep.GetItemString(1,"tipo")
ld_fini  = dw_sel_rep.GetItemDate(1,"fecha")
ld_ffin  = dw_sel_rep.GetItemDate(1,"fecha_fin")

select fp_descri
into:ls_tipofp
from fa_formpag
where em_codigo = :str_appgeninfo.empresa
and fp_codigo = :ls_fp;

if rb_empre.checked then
	dw_datos.dataobject = 'd_rep_pagos_diferidos_emp'
    dw_datos.SetTransobject(sqlca)
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"'"+&
					"st_titulo.text='Reporte de pagos diferidos con "+ls_tipofp+"'")
	dw_datos.Retrieve(ls_fp,ld_fini,ld_ffin)
end if


if rb_sucur.checked then  
	dw_datos.dataobject = 'd_rep_pagos_diferidos'
	dw_datos.settransobject(sqlca)
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'"+&
					"st_titulo.text='Reporte de pagos diferidos con "+ls_tipofp+"'")
	dw_datos.Retrieve(str_appgeninfo.sucursal,ls_fp,ld_fini,ld_ffin)
end if


//if rb_plazos. checked then
//dw_datos.dataobject = 'd_rep_pagos_diferidos_x_plazos'
//dw_datos.SetTransObject(sqlca)
//dw_datos.retrieve(30,str_appgeninfo.empresa,ld_fini,ld_ffin,ls_fp)	
//end if

dw_datos.modify("datawindow.print.preview = yes")	


end event

event ue_filter;call super::ue_filter;//string ls_null
//integer li_res
//
//setnull(ls_null)
//if rb_sucur.checked Then
//	li_res = dw_report.SetFilter(ls_null)
//	if li_res = 1 then
//		dw_report.Filter()
//		return dw_report.groupcalc()
//
//	else
//		return li_res
//	end if
//else
//	li_res = dw_datos.SetFilter(ls_null)
//	if li_res = 1 then
//		dw_datos.Filter()
//		return dw_datos.groupcalc()
//	else
//		return li_res
//	end if
//end if

//return 1
end event

event ue_print;int li_rc


openwithparm(w_dw_print_options,dw_datos)
li_rc = message.DoubleParm	
if li_rc = 1 then
dw_datos.print()
end if




end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_pagos_diferidos
integer x = 0
integer y = 296
integer width = 2875
integer height = 1220
string title = "Pagos diferidos"
string dataobject = "d_rep_pagos_diferidos_emp"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_pagos_diferidos
integer y = 224
integer width = 2875
integer height = 1300
string dataobject = "d_rep_pagos_diferidos"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_pagos_diferidos
end type

type dw_sel_rep from datawindow within w_rep_pagos_diferidos
integer width = 2875
integer height = 296
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_fecha_final_tipo"
boolean border = false
boolean livescroll = true
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

type rb_empre from radiobutton within w_rep_pagos_diferidos
integer x = 2437
integer y = 44
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Empresa"
end type

type rb_sucur from radiobutton within w_rep_pagos_diferidos
integer x = 2437
integer y = 124
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sucursal"
boolean checked = true
end type

type rb_plazos from radiobutton within w_rep_pagos_diferidos
integer x = 2437
integer y = 200
integer width = 361
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por plazos"
end type


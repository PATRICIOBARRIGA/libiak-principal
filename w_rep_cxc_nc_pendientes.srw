HA$PBExportHeader$w_rep_cxc_nc_pendientes.srw
$PBExportComments$Si.Cheques Postfechados
forward
global type w_rep_cxc_nc_pendientes from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_cxc_nc_pendientes
end type
type rb_empre from radiobutton within w_rep_cxc_nc_pendientes
end type
type rb_sucur from radiobutton within w_rep_cxc_nc_pendientes
end type
end forward

global type w_rep_cxc_nc_pendientes from w_sheet_1_dw_rep
integer width = 2917
integer height = 1624
string title = "Pagos diferidos"
long backcolor = 67108864
dw_sel_rep dw_sel_rep
rb_empre rb_empre
rb_sucur rb_sucur
end type
global w_rep_cxc_nc_pendientes w_rep_cxc_nc_pendientes

on w_rep_cxc_nc_pendientes.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
this.rb_empre=create rb_empre
this.rb_sucur=create rb_sucur
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
this.Control[iCurrent+2]=this.rb_empre
this.Control[iCurrent+3]=this.rb_sucur
end on

on w_rep_cxc_nc_pendientes.destroy
call super::destroy
destroy(this.dw_sel_rep)
destroy(this.rb_empre)
destroy(this.rb_sucur)
end on

event open;dw_sel_rep.InsertRow(0)
dw_sel_rep.setfocus()
dw_datos.SetTransObject(sqlca)
dw_report.SetTransObject(sqlca)
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

event ue_retrieve;date  ld_fini,ld_ffin


dw_sel_rep.AcceptText()
ld_fini  = dw_sel_rep.GetItemDate(1,"fec_ini")
ld_ffin  = dw_sel_rep.GetItemDate(1,"fec_fin")


if rb_sucur.checked then  
	dw_report.visible  = false
	dw_datos.visible = true
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
	dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fini,ld_ffin)

else
	dw_report.visible  = true
	dw_datos.visible = false
	dw_report.modify("st_empresa.text = '"+gs_empresa+"'")
	dw_report.Retrieve(str_appgeninfo.empresa,ld_fini,ld_ffin)
	dw_report.modify("datawindow.print.preview = yes")

end if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cxc_nc_pendientes
integer x = 0
integer y = 224
integer width = 2875
integer height = 1128
string dataobject = "d_rep_cxc_devol_venta_fxm"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cxc_nc_pendientes
integer y = 224
integer width = 2875
integer height = 1300
string dataobject = "d_rep_cxc_devol_venta_fxm_emp"
end type

type dw_sel_rep from datawindow within w_rep_cxc_nc_pendientes
integer width = 2875
integer height = 224
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rango_fecha"
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

type rb_empre from radiobutton within w_rep_cxc_nc_pendientes
integer x = 2135
integer y = 28
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

type rb_sucur from radiobutton within w_rep_cxc_nc_pendientes
integer x = 2135
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


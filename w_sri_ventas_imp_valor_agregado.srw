HA$PBExportHeader$w_sri_ventas_imp_valor_agregado.srw
$PBExportComments$Si.
forward
global type w_sri_ventas_imp_valor_agregado from w_sheet_1_dw
end type
type st_1 from statictext within w_sri_ventas_imp_valor_agregado
end type
type em_1 from editmask within w_sri_ventas_imp_valor_agregado
end type
type rb_1 from radiobutton within w_sri_ventas_imp_valor_agregado
end type
type rb_2 from radiobutton within w_sri_ventas_imp_valor_agregado
end type
type dw_1 from datawindow within w_sri_ventas_imp_valor_agregado
end type
type cb_1 from commandbutton within w_sri_ventas_imp_valor_agregado
end type
type rb_3 from radiobutton within w_sri_ventas_imp_valor_agregado
end type
type dw_2 from datawindow within w_sri_ventas_imp_valor_agregado
end type
type dw_3 from datawindow within w_sri_ventas_imp_valor_agregado
end type
type st_2 from statictext within w_sri_ventas_imp_valor_agregado
end type
end forward

global type w_sri_ventas_imp_valor_agregado from w_sheet_1_dw
integer width = 3131
integer height = 2144
string title = "SRI VENTAS (IVA)"
long backcolor = 67108864
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
st_1 st_1
em_1 em_1
rb_1 rb_1
rb_2 rb_2
dw_1 dw_1
cb_1 cb_1
rb_3 rb_3
dw_2 dw_2
dw_3 dw_3
st_2 st_2
end type
global w_sri_ventas_imp_valor_agregado w_sri_ventas_imp_valor_agregado

event activate;w_frame_basic lw_frame
m_frame_basic lm_frame

lw_frame = this.parentWindow()
lm_frame = lw_frame.menuid
lm_frame.mf_into_report_mode()
end event

event open;dw_datos.SetTransObject(sqlca)
//dw_report.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)

call super::open
end event

event resize;
if rb_1.checked then
	dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 2*dw_datos.y)
end if

if rb_2.checked then
	dw_1.resize(this.workSpaceWidth() - 2*dw_1.x, this.workSpaceHeight() - 2*dw_1.y)
end if

if rb_3.checked then
	dw_2.resize(this.workSpaceWidth() - 2*dw_2.x, this.workSpaceHeight() - 2*dw_2.y)
end if

end event

event ue_print;//int li_rc
//
//openwithparm(w_dw_print_options,dw_datos)
//li_rc = message.DoubleParm
//gi_print = 0
//if li_rc = 1 then
//   dw_datos.print()	
//end if
//
end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

event ue_printcancel;beep(1)
end event

on w_sri_ventas_imp_valor_agregado.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_1=create em_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.rb_3=create rb_3
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.st_2
end on

on w_sri_ventas_imp_valor_agregado.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.rb_3)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_2)
end on

event ue_mail;OpenSheetWithParm(w_mail_send,dw_datos,w_marco,15,Original!)
return 1
end event

event closequery;return
end event

event ue_retrieve;date ld_fecfin
string ls_fecha,ls_fecreg
integer li_reten

setpointer(hourglass!)
ls_fecha = em_1.text
ld_fecfin = date('01/'+ls_fecha)

select pr_valor
into :li_reten
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'RET_PTO';
if sqlca.sqlcode =100 then
	messagebox("Error","No se encuentra el dato",stopsign!)
	return
end if

if rb_1.checked then
 dw_datos.retrieve(ls_fecha,ld_fecfin,li_reten)
 dw_datos.Modify("DataWindow.Print.Preview=Yes")
 dw_datos.visible = true
 dw_1.visible = false
 dw_2.visible = false
end if

if rb_2.checked then
 dw_1.retrieve(ls_fecha,ld_fecfin,li_reten)
 dw_1.Modify("DataWindow.Print.Preview=Yes") 
 dw_datos.visible = false
 dw_1.visible = true
 dw_2.visible = false
end if

if rb_3.checked then
 dw_2.retrieve(str_appgeninfo.empresa,ls_fecha,ld_fecfin,li_reten) 
 dw_2.Modify("DataWindow.Print.Preview=Yes") 
 dw_datos.visible = false
 dw_1.visible = false
 dw_2.visible = true
end if
setpointer(arrow!)
end event

event ue_saveas;string ls_periodo

ls_periodo = em_1.text
ls_periodo = mid(ls_periodo,1,2)+mid(ls_periodo,4,7)
setpointer(hourglass!)
if rb_1.checked = true then
	dw_datos.SaveAs("Archivos\sriventas"+ls_periodo+".TXT",Text!,FALSE)
end if

if rb_2.checked = true then
	dw_1.SaveAs("ARCHIVOS\srinc_ven"+ls_periodo+".TXT",Text!,FALSE)
end if

if rb_3.checked = true then
	dw_2.SaveAs("ARCHIVOS\srinc_cartera"+ls_periodo+".TXT",Text!,FALSE)
end if
MessageBox("Confirmaci$$HEX1$$f300$$ENDHEX$$n","EL archivo se exporto con $$HEX1$$e900$$ENDHEX$$xito...AHORA DEBE IMPORTARLO") 		
setpointer(arrow!)
end event

type dw_datos from w_sheet_1_dw`dw_datos within w_sri_ventas_imp_valor_agregado
integer x = 14
integer y = 232
integer width = 3063
integer height = 1764
integer taborder = 0
string dataobject = "d_anexo_transaccional_ventas"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_datos::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from w_sheet_1_dw`dw_report within w_sri_ventas_imp_valor_agregado
integer x = 41
integer y = 204
integer width = 421
integer height = 196
integer taborder = 0
boolean enabled = true
borderstyle borderstyle = styleraised!
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type st_1 from statictext within w_sri_ventas_imp_valor_agregado
integer x = 23
integer y = 108
integer width = 187
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_sri_ventas_imp_valor_agregado
integer x = 201
integer y = 88
integer width = 288
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/yyyy"
boolean autoskip = true
end type

type rb_1 from radiobutton within w_sri_ventas_imp_valor_agregado
integer x = 521
integer y = 96
integer width = 265
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Ventas"
end type

type rb_2 from radiobutton within w_sri_ventas_imp_valor_agregado
integer x = 818
integer y = 96
integer width = 398
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Devoluciones"
end type

type dw_1 from datawindow within w_sri_ventas_imp_valor_agregado
boolean visible = false
integer x = 14
integer y = 232
integer width = 3063
integer height = 1764
string dataobject = "d_anexo_sri_devol_ventas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_sri_ventas_imp_valor_agregado
integer x = 2569
integer y = 88
integer width = 416
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Importar"
end type

event clicked;long ll_nreg
string ls_periodo

//Se graban los archivos resultantes a la tabla sri_ventas

setpointer(hourglass!)
w_marco.setmicrohelp("Procesando...")
ls_periodo = em_1.text
ls_periodo = mid(ls_periodo,1,2)+mid(ls_periodo,4,7)
if isnull(ls_periodo) or ls_periodo = "" then 
	MessageBox("Error","Ingrese la fecha del per$$HEX1$$ed00$$ENDHEX$$odo")
	return
end if

if rb_1.checked then
	ll_nreg = dw_3.importfile("Archivos\sriventas"+ls_periodo+".TXT")
	if ll_nreg > 0 then
		if dw_3.update() = 1 then
			commit;
			MessageBox("Confirmaci$$HEX1$$f300$$ENDHEX$$n","EL archivo sri_ventas"+ls_periodo+" se import$$HEX2$$f3002000$$ENDHEX$$con $$HEX1$$e900$$ENDHEX$$xito") 		
		else
			Rollback;
			dw_3.reset()
			messagebox("Error","Problemas al actualizar tabla sri_ventas "+sqlca.sqlerrtext)
			return
		end if
	else
		MessageBox("Error","Problemas al importar el archivo sri_ventas o no existe...avise a sistemas",stopsign!)
		return
	end if
end if

if rb_2.checked then
	ll_nreg = dw_3.importfile("Archivos\srinc_ven"+ls_periodo+".TXT")
	if ll_nreg > 0 then
		if dw_3.update() = 1 then
			commit;
			MessageBox("Confirmaci$$HEX1$$f300$$ENDHEX$$n","EL archivo srinc_ven"+ls_periodo+" se import$$HEX2$$f3002000$$ENDHEX$$con $$HEX1$$e900$$ENDHEX$$xito") 		
		else
			Rollback;
			dw_3.reset()
			messagebox("Error","Problemas al actualizar tabla sri_ventas "+sqlca.sqlerrtext)
			return
		end if
	else
		MessageBox("Error","Problemas al importar el archivo srinc_ven o no existe...avise a sistemas",stopsign!)
		return
	end if
end if

if rb_3.checked then
	ll_nreg = dw_3.importfile("Archivos\srinc_cartera"+ls_periodo+".TXT")
	if ll_nreg > 0 then
		if dw_3.update() = 1 then
			commit;
			MessageBox("Confirmaci$$HEX1$$f300$$ENDHEX$$n","EL archivo srinc_cartera"+ls_periodo+" se import$$HEX2$$f3002000$$ENDHEX$$con $$HEX1$$e900$$ENDHEX$$xito") 		
		else
			Rollback;
			dw_3.reset()
			messagebox("Error","Problemas al actualizar tabla sri_ventas "+sqlca.sqlerrtext)
			return
		end if
	else
		MessageBox("Error","Problemas al importar el archivo srinc_cartera o no existe...avise a sistemas",stopsign!)
		return
	end if

end if
setpointer(arrow!)
w_marco.setmicrohelp("Listo...Proceso Terminado")

end event

type rb_3 from radiobutton within w_sri_ventas_imp_valor_agregado
integer x = 1248
integer y = 96
integer width = 343
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&NC Cartera"
end type

type dw_2 from datawindow within w_sri_ventas_imp_valor_agregado
boolean visible = false
integer x = 14
integer y = 232
integer width = 3063
integer height = 1764
string title = "none"
string dataobject = "d_anexo_sri_nc_ventas_cxc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_sri_ventas_imp_valor_agregado
boolean visible = false
integer x = 14
integer y = 232
integer width = 3063
integer height = 1764
string title = "none"
string dataobject = "d_iva_sri_ventas_a_tabla"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_sri_ventas_imp_valor_agregado
integer x = 1915
integer y = 12
integer width = 1070
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "NOTA : Antes de importar grabe el archivo recuperado"
boolean focusrectangle = false
end type


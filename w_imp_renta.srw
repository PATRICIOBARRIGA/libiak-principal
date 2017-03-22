HA$PBExportHeader$w_imp_renta.srw
$PBExportComments$Si.
forward
global type w_imp_renta from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_imp_renta
end type
type em_1 from editmask within w_imp_renta
end type
type em_2 from editmask within w_imp_renta
end type
type st_2 from statictext within w_imp_renta
end type
type cb_1 from commandbutton within w_imp_renta
end type
type dw_sri from datawindow within w_imp_renta
end type
type cb_2 from commandbutton within w_imp_renta
end type
end forward

global type w_imp_renta from w_sheet_1_dw_rep
integer width = 3543
integer height = 1908
string title = "SRI"
long backcolor = 67108864
boolean ib_inreportmode = true
st_1 st_1
em_1 em_1
em_2 em_2
st_2 st_2
cb_1 cb_1
dw_sri dw_sri
cb_2 cb_2
end type
global w_imp_renta w_imp_renta

on w_imp_renta.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_sri=create dw_sri
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_sri
this.Control[iCurrent+7]=this.cb_2
end on

on w_imp_renta.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_sri)
destroy(this.cb_2)
end on

event open;ib_notautoretrieve = true
ib_inReportMode = false

dw_datos.sharedata(dw_report)
dw_sri.SetTransObject(sqlca)
call super::open
dw_datos.modify("datawindow.print.preview.zoom=100~t" + "datawindow.print.preview=yes")

end event

event ue_retrieve;Date ld_ini,ld_fin

setpointer(hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
if ld_ini > ld_fin or isnull(ld_ini) then
		messageBox("Error","Rango de Fechas Incorrecto")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if
dw_sri.visible = false	
dw_datos.visible = true
dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.retrieve(ld_ini,ld_fin)
setpointer(arrow!)
end event

event close;call super::close;dw_datos.sharedataoff()
end event

event ue_print;int li_rc
datawindow  ldw_aux


if dw_datos.visible then
	ldw_aux = dw_datos
elseif dw_report.visible then
	ldw_aux = dw_report
else
	return
end if
ldw_aux.modify("datawindow.print.preview.zoom=100~t" + &
										"datawindow.print.preview=yes")
openwithparm(w_dw_print_options,ldw_aux)
li_rc = message.DoubleParm
if li_rc = 1 then
ldw_aux.print()	
end if

end event

event resize;
dw_datos.resize(this.workSpaceWidth() - 100, this.workSpaceHeight() - 200)
dw_report.resize(this.workSpaceWidth() - 100, this.workSpaceHeight() - 200)
dw_sri.resize(this.workSpaceWidth() - 100, this.workSpaceHeight() - 200)
end event

event ue_saveas;datawindow  ldw_aux


if dw_sri.visible then
	ldw_aux = dw_sri
elseif dw_datos.visible then
	ldw_aux = dw_datos
else
	return
end if
ldw_aux.saveas()
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_imp_renta
integer y = 180
integer width = 3419
integer height = 1608
integer taborder = 40
string dataobject = "d_imp_renta_empleado"
boolean border = true
boolean hsplitscroll = true
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_imp_renta
integer x = 41
integer y = 180
integer width = 3383
integer height = 1608
integer taborder = 50
string dataobject = "d_prn_formulario107"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_imp_renta
integer x = 1349
integer y = 36
integer width = 293
integer height = 100
end type

type st_1 from statictext within w_imp_renta
integer x = 91
integer y = 56
integer width = 183
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_imp_renta
integer x = 293
integer y = 44
integer width = 306
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_imp_renta
integer x = 891
integer y = 44
integer width = 306
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_2 from statictext within w_imp_renta
integer x = 695
integer y = 56
integer width = 178
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_imp_renta
integer x = 2789
integer y = 36
integer width = 645
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ver informaci$$HEX1$$f300$$ENDHEX$$n individual"
end type

event clicked;String ls_epcodigo
Long ll_row,ll_reg,ll_find


dw_datos.AcceptText()
dw_sri.visible = false
If dw_datos.visible then
   dw_datos.visible = false
   dw_report.visible = true
   cb_1.text= 'Ver resumen'	
   ll_row = dw_datos.getrow()
   ll_reg = dw_report.rowcount()
   ls_epcodigo =   dw_datos.Object.no_emple_ep_codigo[ll_row]
   ll_find =   dw_report.Find("no_emple_ep_codigo = '"+ls_epcodigo+"'",1,ll_reg)
   dw_report.scrolltorow(ll_find)
   dw_report.setrow(ll_find)
   dw_report.modify("datawindow.print.preview.zoom=100~t" + "datawindow.print.preview=yes")
else
  dw_datos.visible = true
  dw_report.visible = false
  cb_1.text= 'Ver informaci$$HEX1$$f300$$ENDHEX$$n individual'	
end if	
end event

type dw_sri from datawindow within w_imp_renta
boolean visible = false
integer x = 41
integer y = 180
integer width = 2656
integer height = 1112
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_sri_rdep_x_ingresos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_imp_renta
integer x = 2130
integer y = 36
integer width = 640
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Generar archivo para SRI"
end type

event clicked;long ll_nreg, ll_i
integer li_j,li_len
string ls_cadena,ls_archivo

setpointer(hourglass!)
dw_sri.reset()
ll_nreg = dw_datos.rowcount()
if ll_nreg > 0 then
	dw_datos.visible = false	
	dw_report.visible = false
	dw_sri.visible = true
	for ll_i = 1 to ll_nreg
		ls_archivo = dw_datos.getitemstring(ll_i,"em_ruc")
		ls_archivo = ls_archivo + dw_datos.getitemstring(ll_i,"no_emple_ep_ci")+'2'
		li_len = len(dw_datos.getitemstring(ll_i,"no_emple_ep_calle1"))
		if li_len < 20 then
			ls_cadena = ""
			for li_j = li_len to 19
				ls_cadena = ls_cadena + ' '
			next
			ls_archivo = ls_archivo + ls_cadena + dw_datos.getitemstring(ll_i,"no_emple_ep_calle1")
		else
			ls_archivo = ls_archivo +mid(dw_datos.getitemstring(ll_i,"no_emple_ep_calle1"),1,20)
		end if
		li_len = len(dw_datos.getitemstring(ll_i,"no_emple_ep_calle2"))
		if li_len < 10 then
			ls_cadena = ""
			for li_j = li_len to 9
				ls_cadena = ls_cadena+ ' '
			next
			ls_archivo = ls_archivo + ls_cadena + dw_datos.getitemstring(ll_i,"no_emple_ep_calle2")
		else
			ls_archivo = ls_archivo +mid(dw_datos.getitemstring(ll_i,"no_emple_ep_calle2"),1,10)
		end if
		li_len = len(dw_datos.getitemstring(ll_i,"ciudad"))
		if li_len < 20 then
			ls_cadena = ""
			for li_j = li_len to 19
				ls_cadena = ls_cadena + ' '
			next
			ls_archivo = ls_archivo + ls_cadena + dw_datos.getitemstring(ll_i,"ciudad")
		else
			ls_archivo = ls_archivo +mid(dw_datos.getitemstring(ll_i,"ciudad"),1,20)
		end if		
		ls_archivo = ls_archivo + dw_datos.getitemstring(ll_i,"prov")
		if dw_datos.getitemstring(ll_i,"prov") = '17' then
			ls_archivo = ls_archivo + '022530912'
		else
			ls_archivo = ls_archivo + dw_datos.getitemstring(ll_i,"telef") + '0000000'			
		end if
		if dw_datos.getitemdecimal(ll_i,"iess") > 0.00 then
			ls_archivo = ls_archivo + '1'
		else
			ls_archivo = ls_archivo + '2'	
		end if
		li_len = len(string(dw_datos.getitemdecimal(ll_i,"cc_toting"),'###0.00'))
		if li_len < 11 then
			ls_cadena = ""
			for li_j = li_len to 10
				ls_cadena = ls_cadena + '0'
			next
			ls_archivo = ls_archivo + ls_cadena + string(dw_datos.getitemdecimal(ll_i,"cc_toting"),'###0.00')
		else
			ls_archivo = ls_archivo +mid(string(dw_datos.getitemdecimal(ll_i,"cc_toting"),'###0.00'),1,11)
		end if
		
		li_len = len(string(dw_datos.getitemdecimal(ll_i,"iess"),'###0.00'))
		if li_len < 9 then
			ls_cadena = ""
			for li_j = li_len to 8
				ls_cadena = ls_cadena + '0'
			next
			ls_archivo = ls_archivo + ls_cadena + string(dw_datos.getitemdecimal(ll_i,"iess"),'###0.00')
		else
			ls_archivo = ls_archivo +mid(string(dw_datos.getitemdecimal(ll_i,"iess"),'###0.00'),1,9)
		end if
		li_len = len(string(dw_datos.getitemdecimal(ll_i,"cc_subtot"),'###0.00'))
		if li_len < 11 then
			ls_cadena = ""
			for li_j = li_len to 10
				ls_cadena = ls_cadena + '0'
			next
			ls_archivo = ls_archivo + ls_cadena + string(dw_datos.getitemdecimal(ll_i,"cc_subtot"),'###0.00')
		else
			ls_archivo = ls_archivo +mid(string(dw_datos.getitemdecimal(ll_i,"cc_subtot"),'###0.00'),1,11)
		end if		
		li_len = len(string(dw_datos.getitemdecimal(ll_i,"cc_totreten"),'###0.00'))
		if li_len < 9 then
			ls_cadena = ""
			for li_j = li_len to 8
				ls_cadena = ls_cadena + '0'
			next
			ls_archivo = ls_archivo + ls_cadena + string(dw_datos.getitemdecimal(ll_i,"cc_totreten"),'###0.00')
		else
			ls_archivo = ls_archivo +mid(string(dw_datos.getitemdecimal(ll_i,"cc_totreten"),'###0.00'),1,9)
		end if
		if dw_datos.getitemdecimal(ll_i,"cc_totreten") > 0 then
			ls_archivo = ls_archivo + dw_datos.getitemstring(1,"cc_a$$HEX1$$f100$$ENDHEX$$o") + '01'
		else
			ls_archivo = ls_archivo + dw_datos.getitemstring(1,"cc_a$$HEX1$$f100$$ENDHEX$$o") + '00'			
		end if
		dw_sri.insertrow(ll_i)
		dw_sri.setitem(ll_i,"imprenta",ls_archivo)
	next
else
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe recuperar antes los datos del impuesto a la renta")
	return
end if
dw_sri.modify("datawindow.print.preview.zoom=100~t" + "datawindow.print.preview=yes")
cb_1.text= 'Ver resumen'	
setpointer(arrow!)
w_marco.setmicrohelp("Proceso Terminado")
end event


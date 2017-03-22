HA$PBExportHeader$w_rep_balances.srw
$PBExportComments$Si. Balances del per$$HEX1$$ed00$$ENDHEX$$odo
forward
global type w_rep_balances from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_rep_balances
end type
type rb_2 from radiobutton within w_rep_balances
end type
type em_1 from editmask within w_rep_balances
end type
type em_2 from editmask within w_rep_balances
end type
type st_1 from statictext within w_rep_balances
end type
type st_2 from statictext within w_rep_balances
end type
type cbx_1 from checkbox within w_rep_balances
end type
type cbx_2 from checkbox within w_rep_balances
end type
type cbx_emp from checkbox within w_rep_balances
end type
type cbx_suc from checkbox within w_rep_balances
end type
end forward

global type w_rep_balances from w_sheet_1_dw_rep
integer width = 2679
integer height = 1960
string title = "Balances Financieros"
long backcolor = 79741120
rb_1 rb_1
rb_2 rb_2
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
cbx_1 cbx_1
cbx_2 cbx_2
cbx_emp cbx_emp
cbx_suc cbx_suc
end type
global w_rep_balances w_rep_balances

on w_rep_balances.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_emp=create cbx_emp
this.cbx_suc=create cbx_suc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.cbx_2
this.Control[iCurrent+9]=this.cbx_emp
this.Control[iCurrent+10]=this.cbx_suc
end on

on w_rep_balances.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_emp)
destroy(this.cbx_suc)
end on

event open;this.ib_notautoretrieve = true
call super::open
end event

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() ) //- 2*ldw_aux.y


end event

event ue_retrieve;date ld_fecini,ld_fecfin

ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)

If cbx_emp.checked then
	If rb_1.checked and cbx_1.checked Then
		dw_datos.dataobject = "d_rep_balance_general"
	End if
	If rb_1.checked and cbx_2.checked Then
		dw_datos.dataobject = "d_rep_balance_general_resumido"
	End if
	
	If rb_2.checked and cbx_1.checked Then
		dw_datos.dataobject = "d_rep_balance_pyg"
	End if
	
	If rb_2.checked and cbx_2.checked Then
		dw_datos.dataobject = "d_rep_balance_pyg_resumido"
	End if

	dw_datos.settransobject(sqlca)
   f_recupera_empresa(dw_datos,"cc_centro")
   dw_datos.reset()
   dw_datos.retrieve(str_appgeninfo.empresa,ld_fecini,ld_fecfin)

End if

If cbx_suc.checked then
	If rb_1.checked and cbx_1.checked Then
		dw_datos.dataobject = "d_rep_balance_general_x_suc"
	End if
	If rb_1.checked and cbx_2.checked Then
		dw_datos.dataobject = "d_rep_balance_general_resumido_x_suc"
	End if
	
	If rb_2.checked and cbx_1.checked Then
		dw_datos.dataobject = "d_rep_balance_pyg_x_suc"
	End if
	
	If rb_2.checked and cbx_2.checked Then
		dw_datos.dataobject = "d_rep_balance_pyg_resumido_x_suc"
	End if
	dw_datos.settransobject(sqlca)
   f_recupera_empresa(dw_datos,"cc_centro")
	dw_datos.reset()
   dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fecini,ld_fecfin)
End if
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' datawindow.print.preview='yes'")




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

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_balances
integer x = 14
integer y = 276
integer width = 2606
integer height = 1548
integer taborder = 70
string dataobject = "d_rep_balance_general"
boolean livescroll = false
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_balances
integer x = 69
integer y = 1112
integer taborder = 90
end type

type rb_1 from radiobutton within w_rep_balances
integer x = 91
integer y = 108
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "General"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_rep_balances
integer x = 91
integer y = 184
integer width = 590
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
string text = "P$$HEX1$$e900$$ENDHEX$$rdidas y Ganancias"
borderstyle borderstyle = stylelowered!
end type

type em_1 from editmask within w_rep_balances
integer x = 1038
integer y = 168
integer width = 329
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_balances
integer x = 1605
integer y = 172
integer width = 329
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_balances
integer x = 837
integer y = 184
integer width = 192
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

type st_2 from statictext within w_rep_balances
integer x = 1435
integer y = 184
integer width = 165
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
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_rep_balances
integer x = 2208
integer y = 96
integer width = 302
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detallado"
borderstyle borderstyle = stylelowered!
end type

event clicked;cbx_2.checked = false
end event

type cbx_2 from checkbox within w_rep_balances
integer x = 2208
integer y = 180
integer width = 311
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
string text = "Resumido"
borderstyle borderstyle = stylelowered!
end type

event clicked;cbx_1.checked = false
end event

type cbx_emp from checkbox within w_rep_balances
integer x = 101
integer y = 28
integer width = 498
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
string text = "Por empresa"
borderstyle borderstyle = stylelowered!
end type

event clicked;cbx_suc.checked = false
end event

type cbx_suc from checkbox within w_rep_balances
integer x = 832
integer y = 28
integer width = 576
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
string text = "Por sucursal"
borderstyle borderstyle = stylelowered!
end type

event clicked;cbx_emp.checked = false
end event


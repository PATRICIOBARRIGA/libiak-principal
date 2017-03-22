HA$PBExportHeader$w_rep_balances_financieros.srw
$PBExportComments$Si. (****)Balances del per$$HEX1$$ed00$$ENDHEX$$odo
forward
global type w_rep_balances_financieros from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_rep_balances_financieros
end type
type rb_2 from radiobutton within w_rep_balances_financieros
end type
type em_1 from editmask within w_rep_balances_financieros
end type
type em_2 from editmask within w_rep_balances_financieros
end type
type st_1 from statictext within w_rep_balances_financieros
end type
type st_2 from statictext within w_rep_balances_financieros
end type
type st_3 from statictext within w_rep_balances_financieros
end type
type ddlb_1 from dropdownlistbox within w_rep_balances_financieros
end type
end forward

global type w_rep_balances_financieros from w_sheet_1_dw_rep
integer width = 2976
integer height = 1980
string title = "Balances Financieros"
long backcolor = 79741120
rb_1 rb_1
rb_2 rb_2
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
ddlb_1 ddlb_1
end type
global w_rep_balances_financieros w_rep_balances_financieros

on w_rep_balances_financieros.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.ddlb_1
end on

on w_rep_balances_financieros.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.ddlb_1)
end on

event open;String ls_parametro[]

this.ib_notautoretrieve = true
ls_parametro[1] = str_appgeninfo.empresa
f_recupera_datos(dw_datos,"co_detcom_centro", ls_parametro,1)
f_recupera_datos(dw_datos,"co_detcom_centro_1", ls_parametro,1)
call super::open
end event

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() ) //- 2*ldw_aux.y


end event

event ue_retrieve;date ld_fecini,ld_fecfin

ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)

SetPointer(hourglass!)

dw_datos.reset()
dw_datos.retrieve(str_appgeninfo.empresa,ld_fecini,ld_fecfin)
dw_datos.Setredraw(false)
If rb_1.checked then
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_titulo.text = 'BALANCE GENERAL'  st_1.text = 'ACTIVOS:' st_2.text =  'PASIVOS: ' st_3.text = 'PATRIMONIO:'")
dw_datos.setfilter("compute_2 in ('1','2','3')")
dw_datos.filter()
End if

If rb_2.checked then
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_titulo.text = 'BALANCE  DE  PERDIDAS Y GANANCIAS'  st_1.text = 'VENTAS:' st_2.text =  'COSTO VENTAS: ' st_3.text = 'GASTOS:'")
dw_datos.setfilter("compute_2 in ('4','5','6','7','8','9')")
dw_datos.filter()
End if
dw_datos.Setredraw(true)

SetPointer(Arrow!)










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

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_balances_financieros
integer x = 14
integer y = 244
integer width = 2857
integer height = 1580
integer taborder = 40
string dataobject = "d_rep_balances_financieros"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_balances_financieros
integer x = 69
integer y = 1112
integer taborder = 50
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_balances_financieros
integer x = 2011
integer y = 1212
end type

type rb_1 from radiobutton within w_rep_balances_financieros
integer x = 91
integer y = 40
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
end type

event clicked;dw_datos.Setredraw(false)
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_titulo.text = 'BALANCE GENERAL'  st_1.text = 'ACTIVOS:' st_2.text =  'PASIVOS: ' st_3.text = 'PATRIMONIO:'")
dw_datos.Setfilter("")
dw_datos.filter()
dw_datos.setfilter("compute_2 in ('1','2','3')")
dw_datos.filter()
dw_datos.Setredraw(true)







end event

type rb_2 from radiobutton within w_rep_balances_financieros
integer x = 91
integer y = 124
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
end type

event clicked;dw_datos.Setredraw(false)
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_titulo.text = 'BALANCE  DE  PERDIDAS Y GANANCIAS'  st_1.text = 'VENTAS:' st_2.text =  'COSTO VENTAS: ' st_3.text = 'GASTOS:'")
dw_datos.Setfilter("")
dw_datos.filter()
dw_datos.setfilter("compute_2 in ('4','5','6')")
dw_datos.filter()
dw_datos.Setredraw(true)

end event

type em_1 from editmask within w_rep_balances_financieros
integer x = 1691
integer y = 100
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

type em_2 from editmask within w_rep_balances_financieros
integer x = 2258
integer y = 100
integer width = 329
integer height = 80
integer taborder = 30
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

type st_1 from statictext within w_rep_balances_financieros
integer x = 1490
integer y = 112
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

type st_2 from statictext within w_rep_balances_financieros
integer x = 2089
integer y = 112
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

type st_3 from statictext within w_rep_balances_financieros
integer x = 736
integer y = 48
integer width = 206
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
string text = "Nivel:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_rep_balances_financieros
integer x = 955
integer y = 40
integer width = 411
integer height = 352
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean sorted = false
string item[] = {"1","2","3"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_datos.SetRedraw(false)
choose case index
	case 1
		dw_datos.Object.DataWindow.Detail.Height='0'
   	     dw_datos.Modify("DataWindow.Header.3.Height=0")
    	     dw_datos.Modify("DataWindow.Trailer.3.Height=0")
		dw_datos.Modify("DataWindow.Trailer.2.Height=0")
	case 2
		dw_datos.Object.DataWindow.Detail.Height='0'
          dw_datos.Modify("DataWindow.Header.2.Height=68")
   	     dw_datos.Modify("DataWindow.Header.3.Height=68")
    	     dw_datos.Modify("DataWindow.Trailer.3.Height=0")
		dw_datos.Modify("DataWindow.Trailer.2.Height=0")
	case 3
		dw_datos.Object.DataWindow.Detail.Height='68'
          dw_datos.Modify("DataWindow.Header.2.Height=68")
   	     dw_datos.Modify("DataWindow.Header.3.Height=68")
    	     dw_datos.Modify("DataWindow.Trailer.3.Height=68")
		dw_datos.Modify("DataWindow.Trailer.2.Height=68")
		dw_datos.Modify("DataWindow.Trailer.1.Height=68")
end choose
dw_datos.SetRedraw(true)

end event


HA$PBExportHeader$w_rep_vta1.srw
forward
global type w_rep_vta1 from w_sheet_1_dw_rep
end type
type cbx_1 from checkbox within w_rep_vta1
end type
type cbx_2 from checkbox within w_rep_vta1
end type
type cbx_3 from checkbox within w_rep_vta1
end type
type cbx_4 from checkbox within w_rep_vta1
end type
type em_1 from editmask within w_rep_vta1
end type
type em_2 from editmask within w_rep_vta1
end type
type st_2 from statictext within w_rep_vta1
end type
type st_1 from statictext within w_rep_vta1
end type
type rb_1 from radiobutton within w_rep_vta1
end type
type rb_2 from radiobutton within w_rep_vta1
end type
end forward

global type w_rep_vta1 from w_sheet_1_dw_rep
integer width = 3675
integer height = 1816
string title = "Ventas"
long backcolor = 67108864
boolean ib_notautoretrieve = true
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
em_1 em_1
em_2 em_2
st_2 st_2
st_1 st_1
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_vta1 w_rep_vta1

type variables
boolean ib_cancel
end variables

on w_rep_vta1.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
this.Control[iCurrent+3]=this.cbx_3
this.Control[iCurrent+4]=this.cbx_4
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.em_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.rb_1
this.Control[iCurrent+10]=this.rb_2
end on

on w_rep_vta1.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;Integer li_estados[4],index
Date  ld_ini,ld_fin

SetPointer(Hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if cbx_1.checked then li_estados[1] = 1	
if cbx_2.checked then li_estados[2] = 2	
if cbx_3.checked then li_estados[3] = 9	
if cbx_4.checked then li_estados[4] = 10	
w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n.....por favor espere....!!!")


index  = message.DoubleParm
choose case index
	case 2
		if rb_1.checked then dw_datos.dataobject = 'd_rep_ventydev_resum_x_asesor'    /*Valores*/
		if rb_2.checked then return
	case 3
		if rb_1.checked then dw_datos.dataobject = 'd_rep_vtasydev_res_x_asesor_sin_motos'    /*Valores*/				
		if rb_2.checked then return		
	case 4
		if rb_1.checked then dw_datos.dataobject = 'd_rep_ventydev_resum_asesorycli'    /*Valores*/				
		if rb_2.checked then return
	case 5
		if rb_1.checked then dw_datos.dataobject = 'd_rep_vtasydev_asesorxsucursal'    /*Valores*/				
		if rb_2.checked then return		
	case 6
		if rb_1.checked then dw_datos.dataobject = 'd_rep_vtasydev_asesorxlinea'    /*Valores*/				
		if rb_2.checked then return				
	case 7 
		if rb_1.checked then dw_datos.dataobject = 'd_rep_m_ventas_y_devol_fab_x_asesor3' /*Valores*/
		if rb_2.checked then dw_datos.dataobject = 'd_rep_m_ventas_y_devol_fab_x_asesor4' /*Unidades*/
	case  8 
		if rb_1.checked then dw_datos.dataobject = 'd_rep_m_vtasydev_fab_x_sucursal'    /*Valores*/
		if rb_2.checked then dw_datos.dataobject = 'd_rep_m_vtasydev_fab_x_sucursal2'  /*Unidades*/
end choose

dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(li_estados[],ld_ini,ld_fin)
w_marco.SetMicrohelp("Listo....!!!")

SetPointer(Arrow!)
end event

event activate;call super::activate;em_1.Setfocus()
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_vta1
integer x = 37
integer y = 212
integer width = 3579
integer height = 1472
string dataobject = "d_rep_ventydev_resum_x_asesor"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_vta1
integer x = 1705
integer y = 812
integer taborder = 60
string dataobject = "d_rep_ventydev_resum_x_asesor"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_vta1
integer x = 681
integer y = 952
integer taborder = 90
end type

type cbx_1 from checkbox within w_rep_vta1
integer x = 1998
integer y = 24
integer width = 768
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
string text = "Facturaci$$HEX1$$f300$$ENDHEX$$n por mayor          (1)"
end type

type cbx_2 from checkbox within w_rep_vta1
integer x = 1998
integer y = 92
integer width = 763
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Punto de venta P.O.S.           (2)"
end type

type cbx_3 from checkbox within w_rep_vta1
integer x = 2825
integer y = 24
integer width = 768
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Devoluci$$HEX1$$f300$$ENDHEX$$n FxM                     (9)"
end type

type cbx_4 from checkbox within w_rep_vta1
integer x = 2825
integer y = 92
integer width = 814
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Devoluci$$HEX1$$f300$$ENDHEX$$n P.O.S.                (10)"
end type

type em_1 from editmask within w_rep_vta1
integer x = 274
integer y = 52
integer width = 343
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_vta1
integer x = 923
integer y = 52
integer width = 343
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_2 from statictext within w_rep_vta1
integer x = 55
integer y = 60
integer width = 215
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
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_rep_vta1
integer x = 663
integer y = 60
integer width = 251
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

type rb_1 from radiobutton within w_rep_vta1
integer x = 1385
integer y = 24
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
string text = "Valor"
end type

type rb_2 from radiobutton within w_rep_vta1
integer x = 1385
integer y = 96
integer width = 338
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
string text = "Unidades"
end type


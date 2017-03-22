HA$PBExportHeader$w_rep_vta4.srw
forward
global type w_rep_vta4 from w_sheet_1_dw_rep
end type
type cbx_1 from checkbox within w_rep_vta4
end type
type cbx_2 from checkbox within w_rep_vta4
end type
type cbx_3 from checkbox within w_rep_vta4
end type
type cbx_4 from checkbox within w_rep_vta4
end type
type em_1 from editmask within w_rep_vta4
end type
type em_2 from editmask within w_rep_vta4
end type
type st_2 from statictext within w_rep_vta4
end type
type st_1 from statictext within w_rep_vta4
end type
type dw_1 from datawindow within w_rep_vta4
end type
type st_fab from statictext within w_rep_vta4
end type
end forward

global type w_rep_vta4 from w_sheet_1_dw_rep
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
dw_1 dw_1
st_fab st_fab
end type
global w_rep_vta4 w_rep_vta4

type variables

end variables

on w_rep_vta4.create
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
this.dw_1=create dw_1
this.st_fab=create st_fab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
this.Control[iCurrent+3]=this.cbx_3
this.Control[iCurrent+4]=this.cbx_4
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.em_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.st_fab
end on

on w_rep_vta4.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.st_fab)
end on

event ue_retrieve;Integer li_estados[4]
Date  ld_ini,ld_fin
string ls_codfab


SetPointer(Hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
ls_codfab = dw_1.getitemstring(dw_1.getrow(),"fb_codigo")

if cbx_1.checked then li_estados[1] = 1	
if cbx_2.checked then li_estados[2] = 2	
if cbx_3.checked then li_estados[3] = 9	
if cbx_4.checked then li_estados[4] = 10	
w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n.....por favor espere....!!!")

choose case message.DoubleParm
	case 12
		dw_datos.dataobject = 'dw_rep_facturas_vendxclienxfacxfp'    /*Valores*/
		dw_datos.SetTransObject(sqlca)
		dw_datos.retrieve(ld_ini,ld_fin,li_estados[])		
	case 13
		dw_datos.dataobject = 'dw_rep_facturas_vendxclienxfabxfacxfp'    /*Valores*/
		dw_datos.SetTransObject(sqlca)
		if isnull(ls_codfab) or trim(ls_codfab) = ""  then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el fabricante")
			return
		end if			
		dw_datos.retrieve(ld_ini,ld_fin,li_estados[],ls_codfab)

end choose
w_marco.SetMicrohelp("Listo....!!!")

SetPointer(Arrow!)
end event

event activate;call super::activate;em_1.Setfocus()
end event

event open;call super::open;integer index
dw_1.settransobject(sqlca)
f_recupera_empresa(dw_1,"fb_codigo")
dw_1.insertrow(0)
index  = message.DoubleParm
if index = 12 then
	dw_1.visible = false
	st_fab.visible= false
else
	dw_1.visible = true
	st_fab.visible = true	
end if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_vta4
integer x = 37
integer y = 212
integer width = 3579
integer height = 1472
string dataobject = "dw_rep_facturas_vendxclienxfacxfp"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_vta4
integer x = 1705
integer y = 812
integer taborder = 70
string dataobject = "dw_rep_facturas_vendxclienxfacxfp"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_vta4
integer x = 681
integer y = 952
integer taborder = 100
end type

type cbx_1 from checkbox within w_rep_vta4
integer x = 2208
integer y = 24
integer width = 727
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
string text = "Facturaci$$HEX1$$f300$$ENDHEX$$n por mayor     (1)"
end type

type cbx_2 from checkbox within w_rep_vta4
integer x = 2208
integer y = 92
integer width = 727
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Punto de venta P.O.S.      (2)"
end type

type cbx_3 from checkbox within w_rep_vta4
integer x = 2949
integer y = 24
integer width = 672
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
string text = "Devoluci$$HEX1$$f300$$ENDHEX$$n FxM         (9)"
end type

type cbx_4 from checkbox within w_rep_vta4
integer x = 2949
integer y = 92
integer width = 672
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Devoluci$$HEX1$$f300$$ENDHEX$$n P.O.S.     (10)"
end type

type em_1 from editmask within w_rep_vta4
integer x = 251
integer y = 52
integer width = 311
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

type em_2 from editmask within w_rep_vta4
integer x = 782
integer y = 52
integer width = 311
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

type st_2 from statictext within w_rep_vta4
integer x = 59
integer y = 60
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_rep_vta4
integer x = 594
integer y = 60
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
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_rep_vta4
boolean visible = false
integer x = 1408
integer y = 52
integer width = 713
integer height = 88
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_fabricantes"
boolean border = false
boolean livescroll = true
end type

type st_fab from statictext within w_rep_vta4
boolean visible = false
integer x = 1147
integer y = 60
integer width = 256
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
string text = "Fabricante:"
boolean focusrectangle = false
end type


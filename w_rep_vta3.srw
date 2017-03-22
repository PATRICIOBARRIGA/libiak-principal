HA$PBExportHeader$w_rep_vta3.srw
forward
global type w_rep_vta3 from w_sheet_1_dw_rep
end type
type cbx_1 from checkbox within w_rep_vta3
end type
type cbx_2 from checkbox within w_rep_vta3
end type
type cbx_3 from checkbox within w_rep_vta3
end type
type cbx_4 from checkbox within w_rep_vta3
end type
type em_1 from editmask within w_rep_vta3
end type
type em_2 from editmask within w_rep_vta3
end type
type st_2 from statictext within w_rep_vta3
end type
type st_1 from statictext within w_rep_vta3
end type
type rb_1 from radiobutton within w_rep_vta3
end type
type rb_2 from radiobutton within w_rep_vta3
end type
type st_3 from statictext within w_rep_vta3
end type
type sle_1 from singlelineedit within w_rep_vta3
end type
end forward

global type w_rep_vta3 from w_sheet_1_dw_rep
integer width = 3675
integer height = 1816
string title = "Ventas por fabricante"
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
st_3 st_3
sle_1 sle_1
end type
global w_rep_vta3 w_rep_vta3

type variables
boolean ib_cancel
end variables

on w_rep_vta3.create
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
this.st_3=create st_3
this.sle_1=create sle_1
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
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.sle_1
end on

on w_rep_vta3.destroy
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
destroy(this.st_3)
destroy(this.sle_1)
end on

event ue_retrieve;Integer li_estados[4],index
Date  ld_ini,ld_fin
String ls_item

SetPointer(Hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
ls_item = sle_1.text

if cbx_1.checked then li_estados[1] = 1	
if cbx_2.checked then li_estados[2] = 2	
if cbx_3.checked then li_estados[3] = 9	
if cbx_4.checked then li_estados[4] = 10	
w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n.....por favor espere....!!!!")

index  = message.DoubleParm
choose case index
case 10 
			if rb_1.checked then dw_datos.dataobject = 'd_rep_lineas_x_asesor'    /*Valores*/
			if rb_2.checked then dw_datos.dataobject = 'd_rep_lineas_x_asesor2'  /*Unidades*/
case 11
			if rb_1.checked then dw_datos.dataobject = 'd_rep_lineas_x_sucursal' /*Valores*/
			if rb_2.checked then dw_datos.dataobject = 'd_rep_lineas_x_sucursal2' /*Unidades*/
end choose

dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(li_estados[],ld_ini,ld_fin,ls_item)
w_marco.SetMicrohelp("Listo....!!!!")

SetPointer(Arrow!)
end event

event activate;call super::activate;em_1.Setfocus()
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_vta3
integer x = 37
integer y = 308
integer width = 3579
integer height = 1376
string dataobject = "d_rep_lineas_x_asesor"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_vta3
integer x = 1705
integer y = 812
integer taborder = 60
string dataobject = "d_rep_lineas_x_asesor"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_vta3
integer x = 681
integer y = 952
integer taborder = 90
end type

type cbx_1 from checkbox within w_rep_vta3
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

type cbx_2 from checkbox within w_rep_vta3
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

type cbx_3 from checkbox within w_rep_vta3
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

type cbx_4 from checkbox within w_rep_vta3
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

type em_1 from editmask within w_rep_vta3
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

type em_2 from editmask within w_rep_vta3
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

type st_2 from statictext within w_rep_vta3
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

type st_1 from statictext within w_rep_vta3
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

type rb_1 from radiobutton within w_rep_vta3
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

type rb_2 from radiobutton within w_rep_vta3
integer x = 1385
integer y = 96
integer width = 571
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

type st_3 from statictext within w_rep_vta3
integer x = 55
integer y = 204
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
string text = "Item:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rep_vta3
integer x = 279
integer y = 192
integer width = 1774
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type


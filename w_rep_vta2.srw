HA$PBExportHeader$w_rep_vta2.srw
$PBExportComments$Ventas netas por cliente
forward
global type w_rep_vta2 from w_sheet_1_dw_rep
end type
type cbx_1 from checkbox within w_rep_vta2
end type
type cbx_2 from checkbox within w_rep_vta2
end type
type cbx_3 from checkbox within w_rep_vta2
end type
type cbx_4 from checkbox within w_rep_vta2
end type
type em_1 from editmask within w_rep_vta2
end type
type em_2 from editmask within w_rep_vta2
end type
type st_2 from statictext within w_rep_vta2
end type
type st_1 from statictext within w_rep_vta2
end type
type st_3 from statictext within w_rep_vta2
end type
type sle_1 from singlelineedit within w_rep_vta2
end type
type st_cliente from statictext within w_rep_vta2
end type
type rb_1 from radiobutton within w_rep_vta2
end type
type rb_2 from radiobutton within w_rep_vta2
end type
type cbx_5 from checkbox within w_rep_vta2
end type
end forward

global type w_rep_vta2 from w_sheet_1_dw_rep
integer width = 3579
integer height = 1816
string title = "Detalle de ventas por cliente"
boolean ib_notautoretrieve = true
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
em_1 em_1
em_2 em_2
st_2 st_2
st_1 st_1
st_3 st_3
sle_1 sle_1
st_cliente st_cliente
rb_1 rb_1
rb_2 rb_2
cbx_5 cbx_5
end type
global w_rep_vta2 w_rep_vta2

type variables
boolean ib_cancel
end variables

on w_rep_vta2.create
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
this.st_3=create st_3
this.sle_1=create sle_1
this.st_cliente=create st_cliente
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_5=create cbx_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
this.Control[iCurrent+3]=this.cbx_3
this.Control[iCurrent+4]=this.cbx_4
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.em_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.sle_1
this.Control[iCurrent+11]=this.st_cliente
this.Control[iCurrent+12]=this.rb_1
this.Control[iCurrent+13]=this.rb_2
this.Control[iCurrent+14]=this.cbx_5
end on

on w_rep_vta2.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.st_cliente)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_5)
end on

event ue_retrieve;Integer li_estados[4]
Date  ld_ini,ld_fin
long  ll_codclie

SetPointer(Hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
ll_codclie = long(sle_1.text)

if cbx_1.checked then li_estados[1] = 1	
if cbx_2.checked then li_estados[2] = 2	
if cbx_3.checked then li_estados[3] = 9	
if cbx_4.checked then li_estados[4] = 10	
w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n.....por favor espere....!!!!")


If cbx_5.checked then      /* Todos los clientes */
	If rb_1.checked then		dw_datos.dataobject = 'd_rep_m_ventas_x_asesor_allclientes'
	If rb_2.checked then 		dw_datos.dataobject = 'd_rep_m_ventas_x_asesor_allclientes2'
else
	If rb_1.checked then		dw_datos.dataobject = 'd_rep_m_ventas_items_x_cliente'
	If rb_2.checked then 		dw_datos.dataobject = 'd_rep_m_ventas_items_x_cliente2'
end if
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(li_estados[],ld_ini,ld_fin,ll_codclie)
w_marco.SetMicrohelp("Listo....!!!!")

SetPointer(Arrow!)
end event

event activate;call super::activate;em_1.Setfocus()
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_vta2
integer x = 37
integer y = 284
integer width = 3451
integer height = 1400
string dataobject = "d_rep_m_ventas_items_x_cliente"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_vta2
integer x = 1705
integer y = 812
integer taborder = 60
string dataobject = "d_rep_m_ventas_items_x_cliente"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_vta2
integer x = 681
integer y = 952
integer taborder = 90
end type

type cbx_1 from checkbox within w_rep_vta2
integer x = 1861
integer y = 24
integer width = 800
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

type cbx_2 from checkbox within w_rep_vta2
integer x = 1861
integer y = 92
integer width = 795
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

type cbx_3 from checkbox within w_rep_vta2
integer x = 2688
integer y = 24
integer width = 786
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

type cbx_4 from checkbox within w_rep_vta2
integer x = 2688
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

type em_1 from editmask within w_rep_vta2
integer x = 366
integer y = 48
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

type em_2 from editmask within w_rep_vta2
integer x = 978
integer y = 48
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

type st_2 from statictext within w_rep_vta2
integer x = 55
integer y = 56
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

type st_1 from statictext within w_rep_vta2
integer x = 718
integer y = 56
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

type st_3 from statictext within w_rep_vta2
integer x = 695
integer y = 184
integer width = 265
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cod cliente:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rep_vta2
integer x = 974
integer y = 180
integer width = 343
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;String ls_cliente

SELECT CE_RAZONS
INTO :ls_cliente
FROM FA_CLIEN
WHERE CE_CODIGO = :this.text;

st_cliente.text = ls_cliente
end event

type st_cliente from statictext within w_rep_vta2
integer x = 1349
integer y = 192
integer width = 2117
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
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_vta2
integer x = 1463
integer y = 24
integer width = 347
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

type rb_2 from radiobutton within w_rep_vta2
integer x = 1463
integer y = 96
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
string text = "Unidades"
end type

type cbx_5 from checkbox within w_rep_vta2
integer x = 73
integer y = 176
integer width = 594
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
string text = "Todos los clientes"
end type


HA$PBExportHeader$w_rep_costos.srw
$PBExportComments$Costo de Ventas
forward
global type w_rep_costos from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_rep_costos
end type
type rb_2 from radiobutton within w_rep_costos
end type
type st_1 from statictext within w_rep_costos
end type
type st_2 from statictext within w_rep_costos
end type
type st_3 from statictext within w_rep_costos
end type
type sle_1 from singlelineedit within w_rep_costos
end type
type rb_3 from radiobutton within w_rep_costos
end type
type rb_4 from radiobutton within w_rep_costos
end type
type st_4 from statictext within w_rep_costos
end type
type st_5 from statictext within w_rep_costos
end type
type st_6 from statictext within w_rep_costos
end type
type em_1 from editmask within w_rep_costos
end type
type em_2 from editmask within w_rep_costos
end type
end forward

global type w_rep_costos from w_sheet_1_dw_rep
integer width = 3698
integer height = 1700
string title = "Costos de Ventas"
long backcolor = 79741120
boolean ib_notautoretrieve = true
rb_1 rb_1
rb_2 rb_2
st_1 st_1
st_2 st_2
st_3 st_3
sle_1 sle_1
rb_3 rb_3
rb_4 rb_4
st_4 st_4
st_5 st_5
st_6 st_6
em_1 em_1
em_2 em_2
end type
global w_rep_costos w_rep_costos

type variables
boolean ib_ingresa
end variables

on w_rep_costos.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.sle_1=create sle_1
this.rb_3=create rb_3
this.rb_4=create rb_4
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.em_1=create em_1
this.em_2=create em_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.sle_1
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.em_1
this.Control[iCurrent+13]=this.em_2
end on

on w_rep_costos.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.em_1)
destroy(this.em_2)
end on

event ue_retrieve;Date ld_fini,ld_ffin
long ll_venumero

ld_fini = date(em_1.text)
ld_ffin = date(em_2.text)
ll_venumero = long(sle_1.text)
dw_datos.setredraw(false)
If ld_fini <> date('01/01/1900') and ld_ffin <> date('01/01/1900') Then
 if rb_1.checked Then
 dw_datos.DataObject = 'd_rep_kardex_costo'	
 end if	
 if rb_2.checked Then
 dw_datos.DataObject = 'd_rep_kardex_costo_posfact'		
 end if	
  if rb_3.checked Then
 dw_datos.DataObject = 'd_rep_kardex_costo_totales'		
 end if	
  if rb_4.checked Then
 dw_datos.DataObject = 'd_rep_kardex_costo_posfact_tot'		
 end if	
 dw_datos.SetTransObject(sqlca)
 dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fini,ld_ffin)
else
	If ib_ingresa = true then
        dw_datos.DataObject = 'd_rep_costo_ticket_factura'			
        dw_datos.SetTransObject(sqlca)
        dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ll_venumero)
	   ib_ingresa = false
	End if
End if
dw_datos.modify("datawindow.print.preview.zoom=100~t" + &
										"datawindow.print.preview=yes")
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")										
dw_datos.setredraw(true)


end event

event resize;this.setRedraw(False)
dw_datos.resize(this.workSpaceWidth() - dw_datos.x, this.workSpaceHeight() - dw_datos.y)
this.setRedraw(True)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_costos
integer x = 27
integer y = 460
integer width = 3598
integer height = 1108
integer taborder = 50
string dataobject = "d_rep_kardex_costo"
boolean border = true
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_costos
integer x = 55
integer y = 604
integer taborder = 0
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_costos
end type

type rb_1 from radiobutton within w_rep_costos
string tag = "Detallado"
integer x = 1344
integer y = 208
integer width = 640
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
string text = "Acumulado(POS y FxM)"
boolean checked = true
boolean lefttext = true
end type

type rb_2 from radiobutton within w_rep_costos
integer x = 1344
integer y = 296
integer width = 635
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
string text = "POS- FxM"
boolean lefttext = true
end type

type st_1 from statictext within w_rep_costos
integer x = 78
integer y = 60
integer width = 174
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

type st_2 from statictext within w_rep_costos
integer x = 686
integer y = 60
integer width = 160
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

type st_3 from statictext within w_rep_costos
integer x = 64
integer y = 172
integer width = 411
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
string text = "Factura / Ticket #:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rep_costos
integer x = 498
integer y = 164
integer width = 494
integer height = 80
integer taborder = 40
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

event getfocus;string ls_nulo

ib_ingresa = true
setnull(ls_nulo)
em_1.text = ls_nulo
em_2.text = ls_nulo
end event

type rb_3 from radiobutton within w_rep_costos
integer x = 2226
integer y = 208
integer width = 658
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
string text = "Acumulado(POS y FxM)"
boolean lefttext = true
end type

type rb_4 from radiobutton within w_rep_costos
integer x = 2226
integer y = 296
integer width = 658
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
string text = "POS-FxM."
boolean lefttext = true
end type

type st_4 from statictext within w_rep_costos
integer x = 1253
integer y = 60
integer width = 517
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
string text = "Ventas y devoluciones"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_rep_costos
integer x = 1262
integer y = 148
integer width = 343
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
string text = "Por Item"
boolean focusrectangle = false
end type

type st_6 from statictext within w_rep_costos
integer x = 2089
integer y = 148
integer width = 343
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
string text = "Por fabricante"
boolean focusrectangle = false
end type

type em_1 from editmask within w_rep_costos
integer x = 279
integer y = 48
integer width = 297
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
end type

type em_2 from editmask within w_rep_costos
integer x = 869
integer y = 48
integer width = 306
integer height = 88
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
end type


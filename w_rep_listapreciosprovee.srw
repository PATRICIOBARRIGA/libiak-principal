HA$PBExportHeader$w_rep_listapreciosprovee.srw
$PBExportComments$Lista de precios por proveedor
forward
global type w_rep_listapreciosprovee from w_sheet_1_dw_rep
end type
type cbx_1 from checkbox within w_rep_listapreciosprovee
end type
type rb_1 from radiobutton within w_rep_listapreciosprovee
end type
type rb_2 from radiobutton within w_rep_listapreciosprovee
end type
end forward

global type w_rep_listapreciosprovee from w_sheet_1_dw_rep
integer width = 4626
integer height = 2596
string title = "Lista de precios por proveedor"
cbx_1 cbx_1
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_listapreciosprovee w_rep_listapreciosprovee

on w_rep_listapreciosprovee.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
end on

on w_rep_listapreciosprovee.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event open;ib_inreportmode = false

end event

event closequery;return 0
end event

event ue_retrieve;if rb_1.checked then
	dw_datos.dataobject = "d_rep_listapreciosxprovee2"
elseif rb_2.checked then
	dw_datos.dataobject = "d_rep_listapreciosxprovee"
end if
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve()
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_listapreciosprovee
integer x = 91
integer y = 148
integer width = 4471
integer height = 2264
string dataobject = "d_rep_listapreciosxprovee2"
boolean hsplitscroll = true
end type

event dw_datos::buttonclicked;call super::buttonclicked;INT I
String ls_itcodigo
Decimal lc_costo

For i = 1 to dw_datos.rowcount()
	if dw_datos.Object.opcion[i]= 'S' then
		ls_itcodigo = dw_datos.object.it_codigo[i]
		lc_costo = dw_datos.object.cc_neto[i]
		
		UPDATE IN_ITEM
		SET IT_COSTO = :lc_costo
		WHERE IT_CODIGO = :ls_itcodigo;
	end if		
next
commit;
Messagebox("Listo...","Se ha actualizado el costo de los items seleccionados....")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_listapreciosprovee
integer x = 229
integer y = 532
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_listapreciosprovee
integer x = 265
integer y = 672
end type

type cbx_1 from checkbox within w_rep_listapreciosprovee
integer x = 4338
integer y = 244
integer width = 73
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
string text = "none"
end type

event clicked;Integer i
String ls_opcion = 'N'

if this.checked then ls_opcion = 'S'
for i = 1 to dw_datos.rowcount()
	dw_datos.Object.opcion[i] = ls_opcion
next

end event

type rb_1 from radiobutton within w_rep_listapreciosprovee
integer x = 123
integer y = 36
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
string text = "Tabular"
boolean checked = true
end type

type rb_2 from radiobutton within w_rep_listapreciosprovee
integer x = 818
integer y = 32
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
string text = "Tabla cruzada"
end type


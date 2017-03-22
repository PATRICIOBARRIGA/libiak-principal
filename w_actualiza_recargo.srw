HA$PBExportHeader$w_actualiza_recargo.srw
$PBExportComments$Si.
forward
global type w_actualiza_recargo from w_sheet_1_dw_maint
end type
type st_2 from statictext within w_actualiza_recargo
end type
type em_1 from editmask within w_actualiza_recargo
end type
type st_1 from statictext within w_actualiza_recargo
end type
type st_3 from statictext within w_actualiza_recargo
end type
type sle_1 from singlelineedit within w_actualiza_recargo
end type
type sle_2 from singlelineedit within w_actualiza_recargo
end type
type st_4 from statictext within w_actualiza_recargo
end type
type st_5 from statictext within w_actualiza_recargo
end type
type st_6 from statictext within w_actualiza_recargo
end type
type dw_1 from datawindow within w_actualiza_recargo
end type
type st_7 from statictext within w_actualiza_recargo
end type
type pb_1 from picturebutton within w_actualiza_recargo
end type
end forward

global type w_actualiza_recargo from w_sheet_1_dw_maint
integer width = 5458
integer height = 2144
st_2 st_2
em_1 em_1
st_1 st_1
st_3 st_3
sle_1 sle_1
sle_2 sle_2
st_4 st_4
st_5 st_5
st_6 st_6
dw_1 dw_1
st_7 st_7
pb_1 pb_1
end type
global w_actualiza_recargo w_actualiza_recargo

type variables
long il_start
end variables
on w_actualiza_recargo.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_1=create em_1
this.st_1=create st_1
this.st_3=create st_3
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.dw_1=create dw_1
this.st_7=create st_7
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.sle_2
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.st_7
this.Control[iCurrent+12]=this.pb_1
end on

on w_actualiza_recargo.destroy
call super::destroy
destroy(this.st_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_1)
destroy(this.st_7)
destroy(this.pb_1)
end on

event open;ib_notautoretrieve = true
call super::open
dw_1.insertrow(0)
f_recupera_empresa(dw_1,"sucursal")
end event

event ue_retrieve;String ls_suc

dw_1.accepttext()
ls_suc = dw_1.object.sucursal[1]
if dw_datos.retrieve(ls_suc) = 0 then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones...!!!",Exclamation!)
end if
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_actualiza_recargo
integer x = 46
integer y = 216
integer width = 5326
integer height = 1556
string dataobject = "d_recargo_de_items"
boolean border = true
end type

event dw_datos::doubleclicked;call super::doubleclicked;

Dec{2}  lc_valor
Long i

If dwo.name = 'in_itesucur_it_recargo' &
Then
	lc_valor = this.getitemnumber(row,"in_itesucur_it_recargo")
	for i = row to this.rowcount()
	this.setitem(i,"in_itesucur_it_recargo",lc_valor)
	next	
End if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_actualiza_recargo
end type

type st_2 from statictext within w_actualiza_recargo
integer x = 2309
integer y = 52
integer width = 1321
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
string text = "INGRESE EL PORCENTAJE PARA CALCULAR EL RECARGO"
boolean focusrectangle = false
end type

type em_1 from editmask within w_actualiza_recargo
integer x = 3643
integer y = 32
integer width = 375
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
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###.00"
boolean autoskip = true
end type

event modified;/*C$$HEX1$$e100$$ENDHEX$$lculo del recargo*/
Dec{2} lc_porctje
Long i,ll_nreg

lc_porctje = dec(this.text)
ll_nreg = dw_datos.rowcount()
for i = 1 to ll_nreg
dw_datos.Object.in_itesucur_it_recargo[i] = dw_datos.Object.in_item_it_prefab[i]*(lc_porctje	/100)
next
end event

type st_1 from statictext within w_actualiza_recargo
integer x = 2944
integer y = 136
integer width = 677
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
string text = "RECARGO =  PREFAB * PCTJE"
boolean focusrectangle = false
end type

type st_3 from statictext within w_actualiza_recargo
integer x = 4023
integer y = 48
integer width = 82
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
string text = "[%]"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_actualiza_recargo
integer x = 425
integer y = 1896
integer width = 489
integer height = 84
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

event modified;String ls_data
Long ll_find

ls_data = '%'+this.text+'%'
ll_find = dw_datos.find("it_codant like '"+ls_data+"'",1,dw_datos.Rowcount())

If ll_find <> 0 then 
	dw_datos.ScrollToRow(ll_find)
	dw_datos.SetRow(ll_find)
end if
end event

type sle_2 from singlelineedit within w_actualiza_recargo
integer x = 933
integer y = 1896
integer width = 3355
integer height = 84
integer taborder = 70
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

event modified;String ls_data
Long ll_find

ls_data = '%'+this.text+'%'
ll_find = dw_datos.find("it_nombre like '"+ls_data+"'",il_start,dw_datos.Rowcount())

If ll_find <> 0 then 
	dw_datos.ScrollToRow(ll_find)
	dw_datos.SetRow(ll_find)
end if
end event

type st_4 from statictext within w_actualiza_recargo
integer x = 69
integer y = 1912
integer width = 352
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
string text = "Ubica producto:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_actualiza_recargo
integer x = 942
integer y = 1836
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
string text = "Producto"
boolean focusrectangle = false
end type

type st_6 from statictext within w_actualiza_recargo
integer x = 434
integer y = 1832
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
string text = "C$$HEX1$$f300$$ENDHEX$$digo"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_actualiza_recargo
integer x = 352
integer y = 40
integer width = 1833
integer height = 100
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_sucursal"
boolean border = false
boolean livescroll = true
end type

type st_7 from statictext within w_actualiza_recargo
integer x = 55
integer y = 60
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
string text = "Seleccione la"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_actualiza_recargo
integer x = 4306
integer y = 1892
integer width = 110
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "FindNext!"
alignment htextalign = left!
string powertiptext = "Siguiente"
end type

event clicked;il_start  = dw_datos.getrow() + 1
sle_2.triggerevent(modified!)
end event


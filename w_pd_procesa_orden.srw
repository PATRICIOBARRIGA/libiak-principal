HA$PBExportHeader$w_pd_procesa_orden.srw
forward
global type w_pd_procesa_orden from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_pd_procesa_orden
end type
type st_1 from statictext within w_pd_procesa_orden
end type
type st_2 from statictext within w_pd_procesa_orden
end type
type sle_1 from singlelineedit within w_pd_procesa_orden
end type
type cb_1 from commandbutton within w_pd_procesa_orden
end type
type st_3 from statictext within w_pd_procesa_orden
end type
type cb_2 from commandbutton within w_pd_procesa_orden
end type
type sle_2 from singlelineedit within w_pd_procesa_orden
end type
type st_4 from statictext within w_pd_procesa_orden
end type
type em_2 from editmask within w_pd_procesa_orden
end type
type st_5 from statictext within w_pd_procesa_orden
end type
end forward

global type w_pd_procesa_orden from w_sheet_1_dw_maint
integer width = 5074
integer height = 2640
string title = "Procesamiento de $$HEX1$$f300$$ENDHEX$$rdenes"
boolean ib_notautoretrieve = true
em_1 em_1
st_1 st_1
st_2 st_2
sle_1 sle_1
cb_1 cb_1
st_3 st_3
cb_2 cb_2
sle_2 sle_2
st_4 st_4
em_2 em_2
st_5 st_5
end type
global w_pd_procesa_orden w_pd_procesa_orden

on w_pd_procesa_orden.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.st_2=create st_2
this.sle_1=create sle_1
this.cb_1=create cb_1
this.st_3=create st_3
this.cb_2=create cb_2
this.sle_2=create sle_2
this.st_4=create st_4
this.em_2=create em_2
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.sle_2
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.em_2
this.Control[iCurrent+11]=this.st_5
end on

on w_pd_procesa_orden.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.sle_2)
destroy(this.st_4)
destroy(this.em_2)
destroy(this.st_5)
end on

event open;call super::open;em_1.text = string(today())
em_2.text = string(today())
end event

event ue_retrieve;Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_datos.retrieve(ld_ini,ld_fin)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_pd_procesa_orden
integer x = 69
integer y = 236
integer width = 4923
integer height = 2260
string dataobject = "d_pd_lista_ordenes_b"
boolean border = true
end type

event dw_datos::clicked;call super::clicked;Setpointer(Hourglass!)
parent.triggerevent("ue_update")
Setpointer(Arrow!)
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_pd_procesa_orden
integer x = 1719
integer y = 1828
end type

type em_1 from editmask within w_pd_procesa_orden
integer x = 270
integer y = 100
integer width = 306
integer height = 72
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

event modified;cb_1.triggerevent(clicked!)
end event

event getfocus;cb_2.triggerevent(clicked!)
end event

type st_1 from statictext within w_pd_procesa_orden
integer x = 55
integer y = 108
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pd_procesa_orden
integer x = 1335
integer y = 108
integer width = 274
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
string text = "Producto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_pd_procesa_orden
integer x = 1614
integer y = 100
integer width = 599
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
borderstyle borderstyle = stylelowered!
end type

event modified;cb_1.triggerevent(clicked!)
end event

event getfocus;cb_2.triggerevent(clicked!)
end event

type cb_1 from commandbutton within w_pd_procesa_orden
boolean visible = false
integer x = 2935
integer y = 104
integer width = 343
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;Long    ll_find
Date    ld_fecha
String  ls_codant ,ls_fecha,ls_cadena,ls_numord



Setnull(ls_fecha)
Setnull(ls_numord)
setnull(ls_codant)

ls_fecha = em_1.text
ls_numord = sle_2.text
ls_codant  = sle_1.text

if not isnull(ls_fecha) and ls_fecha <> '00/00/0000' then
		ls_cadena = "string(pd_ordprd_or_fecha,'dd/mm/yyyy') = ' "+ls_fecha+" ' "
	elseif not isnull(ls_numord) and (ls_numord) <> "" then
         ls_cadena = "pd_ordprd_or_codigo = '"+ls_numord+"'"
	elseif not isnull(ls_codant) and (ls_codant) <> "" then
		ls_cadena = "in_item_it_codant = '"+ls_codant+"'"
end if

ll_find = dw_datos.Find(ls_cadena,1,dw_datos.rowcount())
dw_datos.Scrolltorow(ll_find)
dw_datos.Setrow(ll_find)



end event

type st_3 from statictext within w_pd_procesa_orden
integer x = 2272
integer y = 108
integer width = 233
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
string text = "Orden N$$HEX1$$ba00$$ENDHEX$$:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_pd_procesa_orden
boolean visible = false
integer x = 3355
integer y = 100
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;String ls_nulo

Setnull(ls_nulo)

em_1.text = ls_nulo
sle_2.text = ls_nulo
sle_1.text = ls_nulo
end event

type sle_2 from singlelineedit within w_pd_procesa_orden
integer x = 2514
integer y = 100
integer width = 370
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
borderstyle borderstyle = stylelowered!
end type

event modified;cb_1.triggerevent(clicked!)
end event

event getfocus;cb_2.triggerevent(clicked!)
end event

type st_4 from statictext within w_pd_procesa_orden
integer x = 73
integer y = 24
integer width = 283
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
string text = "Buscar por:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_2 from editmask within w_pd_procesa_orden
integer x = 805
integer y = 104
integer width = 352
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

type st_5 from statictext within w_pd_procesa_orden
integer x = 603
integer y = 108
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
string text = "hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type


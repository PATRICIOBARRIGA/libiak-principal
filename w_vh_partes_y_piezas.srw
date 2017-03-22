HA$PBExportHeader$w_vh_partes_y_piezas.srw
forward
global type w_vh_partes_y_piezas from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_vh_partes_y_piezas
end type
type shl_1 from statichyperlink within w_vh_partes_y_piezas
end type
type dw_2 from datawindow within w_vh_partes_y_piezas
end type
type cb_1 from commandbutton within w_vh_partes_y_piezas
end type
type cb_2 from commandbutton within w_vh_partes_y_piezas
end type
type st_1 from statictext within w_vh_partes_y_piezas
end type
type st_2 from statictext within w_vh_partes_y_piezas
end type
end forward

global type w_vh_partes_y_piezas from w_sheet_1_dw_maint
integer width = 6304
integer height = 1916
string title = "Partes y piezas"
dw_1 dw_1
shl_1 shl_1
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_2 st_2
end type
global w_vh_partes_y_piezas w_vh_partes_y_piezas

on w_vh_partes_y_piezas.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.shl_1=create shl_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.shl_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
end on

on w_vh_partes_y_piezas.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.shl_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;/**/
dw_1.SetTransObject(sqlca)
dw_1.retrieve()
/**/
f_recupera_empresa(dw_datos,"mo_codigo")
f_recupera_empresa(dw_datos,"it_codigo")
f_recupera_empresa(dw_datos,"it_codigo_1")

dw_2.Insertrow(0)
f_recupera_empresa(dw_2,"mo_codigo")
call super::open
end event

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_vh_partes_y_piezas
integer x = 37
integer y = 848
integer width = 6171
integer height = 932
string dataobject = "d_vh_partes"
boolean border = true
end type

event dw_datos::buttonclicked;call super::buttonclicked;if dwo.name = 'b_3' then
This.Object.DataWindow.QueryMode = "No"
This.AcceptText()
This.retrieve()
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_vh_partes_y_piezas
end type

type dw_1 from datawindow within w_vh_partes_y_piezas
integer x = 41
integer y = 76
integer width = 6162
integer height = 604
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_item_horiz"
boolean hsplitscroll = true
boolean livescroll = true
end type

type shl_1 from statichyperlink within w_vh_partes_y_piezas
integer x = 3630
integer y = 732
integer width = 526
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Ingresar seleccionados"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_vh_partes_y_piezas
integer x = 850
integer y = 728
integer width = 1509
integer height = 112
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_vh_modelos"
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within w_vh_partes_y_piezas
integer x = 2395
integer y = 728
integer width = 635
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aplicar"
end type

event clicked;String ls_criterio, ls_mod,ls_anio

ls_mod = dw_2.object.mo_codigo[1]
ls_anio = dw_2.object.pt_anio[1]

ls_criterio = "mo_codigo <> '@'"

if not isnull(ls_mod) and not isnull(ls_anio) then
ls_criterio = "mo_codigo = '"+ls_mod+"' and pt_anio = '"+ls_anio+"'"
elseif not isnull(ls_mod) then
	ls_criterio="mo_codigo ='"+ls_mod+"'" 
elseif not isnull(ls_anio) then
	ls_criterio = "pt_anio = '"+ls_anio+"'"
end if
	
dw_datos.Setfilter(ls_criterio)
dw_datos.Filter() 
end event

type cb_2 from commandbutton within w_vh_partes_y_piezas
integer x = 3136
integer y = 728
integer width = 453
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Subir selecci$$HEX1$$f300$$ENDHEX$$n"
end type

event clicked;long i,ll_new

for i = 1 to dw_1.Rowcount()
	if dw_1.object.opc[i] = 'S' then
	ll_new = dw_datos.insertrow(0)
	dw_datos.Object.it_codigo[ll_new] = dw_1.object.it_codigo[i]
	end if
next
end event

type st_1 from statictext within w_vh_partes_y_piezas
integer x = 46
integer y = 16
integer width = 352
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Partes y piezas"
boolean focusrectangle = false
end type

type st_2 from statictext within w_vh_partes_y_piezas
integer x = 37
integer y = 752
integer width = 635
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Partes y piezas por modelo"
boolean focusrectangle = false
end type


HA$PBExportHeader$w_preparado_ubica.srw
$PBExportComments$Busqueda de preparados
forward
global type w_preparado_ubica from window
end type
type pb_ok from picturebutton within w_preparado_ubica
end type
type dw_busca from datawindow within w_preparado_ubica
end type
type st_1 from statictext within w_preparado_ubica
end type
type pb_1 from picturebutton within w_preparado_ubica
end type
type dw_1 from datawindow within w_preparado_ubica
end type
end forward

global type w_preparado_ubica from window
integer x = 46
integer y = 512
integer width = 2738
integer height = 1320
boolean titlebar = true
string title = "Ubicaci$$HEX1$$f300$$ENDHEX$$n de Productos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
pb_ok pb_ok
dw_busca dw_busca
st_1 st_1
pb_1 pb_1
dw_1 dw_1
end type
global w_preparado_ubica w_preparado_ubica

type variables
boolean ib_directo
end variables

event open;//setpointer(hourglass!)
//dw_busca.insertrow(1)
//w_marco.dw_prod.sharedata(dw_1)
//dw_1.setrowfocusindicator(hand!)
//setpointer(arrow!)

setpointer(hourglass!)
dw_busca.insertrow(1)
dw_1.Settransobject(sqlca)
dw_1.Retrieve(str_appgeninfo.empresa)
dw_1.setrowfocusindicator(hand!)
setpointer(arrow!)
gb_por_consulta = true

end event

on closequery;//ib_directo = false
//this.visible = false
//w_marco.setfocus()
//message.returnvalue = 1
end on

on w_preparado_ubica.create
this.pb_ok=create pb_ok
this.dw_busca=create dw_busca
this.st_1=create st_1
this.pb_1=create pb_1
this.dw_1=create dw_1
this.Control[]={this.pb_ok,&
this.dw_busca,&
this.st_1,&
this.pb_1,&
this.dw_1}
end on

on w_preparado_ubica.destroy
destroy(this.pb_ok)
destroy(this.dw_busca)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.dw_1)
end on

event close;gb_por_consulta = false
end event

type pb_ok from picturebutton within w_preparado_ubica
integer x = 2085
integer y = 1032
integer width = 174
integer height = 152
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
end type

event clicked;string ls_codant_prep, li_lon_filtro
window lw_aux
datawindow ldw_aux
if dw_busca.accepttext()<1 then return
if ib_directo then
setpointer(hourglass!)
	ib_directo = false
	int li_fila, li_destino
	li_fila = dw_1.getrow()
	if li_fila < 1 then return
	ls_codant_prep = dw_1.GetItemString(li_fila,'codant')
	li_destino =  str_prodparam.fila
	if li_destino > 0 then
		lw_aux = str_prodparam.ventana
		ldw_aux = str_prodparam.datawindow
		ldw_aux.SetItem(li_destino,'codant_prep', ls_codant_prep)
		ldw_aux.postevent(itemchanged!)
   end if
//	dw_1.setfilter("")
	dw_1.filter()
	setpointer(arrow!)
	close(parent)
//	ldw_aux.setfocus()
//	w_marco.dw_det.setcolumn('barras')
	return
end if

string ls_texto, ls_col, ls, 	ls_filtro
ls_col = dw_busca.GetcolumnName()
ls_texto = upper(dw_busca.getitemstring(1, ls_col))
if (trim(ls_texto) = '' or isnull(ls_texto)) and ib_directo = false then
	dw_1.setfilter("")
	dw_1.filter()
	return
end if
li_lon_filtro = string(len(ls_texto))
ls_filtro = ls_col+ ' like '+ '"' + ls_texto + '"'
dw_1.setfilter(ls_filtro)
dw_1.filter()
//dw_busca.setfocus()
//dw_busca.setcolumn(ls_col)
end event

type dw_busca from datawindow within w_preparado_ubica
event ue_downkey pbm_dwnkey
integer x = 37
integer y = 16
integer width = 2592
integer height = 180
integer taborder = 10
string dataobject = "dw_productos_busca"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on ue_downkey;if (KeyDown(KeyControl!)) and (KeyDown(KeyEnter!)) then
	ib_directo = true
	pb_ok.triggerevent(clicked!)
	return
end if

if KeyDown(KeyEnter!) then
	pb_ok.triggerevent(clicked!)
	return
end if


if (KeyDown(KeyPageDown!)) then
	dw_1.ScrollnextPage()
	return
end if

if (KeyDown(KeyPageUp!)) then
	dw_1.ScrollPriorPage()
	return
end if


if (KeyDown(KeyUpArrow!)) then
	dw_1.ScrollPriorRow()
	return
end if

if (KeyDown(KeyDownArrow!)) then
	dw_1.ScrollNextRow()
	return
end if

end on

event itemfocuschanged;//STRING LS_COL
//
//choose case this.GETCOLUMNNAME()
//	case 'barras'
//		SETITEM(1,'NOMBRE','')
//		SETITEM(1,'CODANT','')
//	case 'codant' 	
//		SETITEM(1,'NOMBRE','')
//		SETITEM(1,'BARRAS','')
//	case 'nombre'
//		SETITEM(1,'BARRAS','')
//		SETITEM(1,'CODANT','')
//end choose
end event

type st_1 from statictext within w_preparado_ubica
integer x = 32
integer y = 1028
integer width = 1541
integer height = 124
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Teclee el c$$HEX1$$f300$$ENDHEX$$digo o nombre del producto que necesita ubicar y presione ENTER, para seleccionarlo emplee CTRL+ENTER"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_preparado_ubica
integer x = 2391
integer y = 1028
integer width = 174
integer height = 152
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
boolean originalsize = true
string picturename = "Imagenes\Cancel.Gif"
end type

on clicked;close(parent)
end on

type dw_1 from datawindow within w_preparado_ubica
integer x = 32
integer y = 220
integer width = 2601
integer height = 784
string dataobject = "dw_preparados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


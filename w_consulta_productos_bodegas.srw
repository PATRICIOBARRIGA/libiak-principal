HA$PBExportHeader$w_consulta_productos_bodegas.srw
$PBExportComments$Si.Consulta productos en las bodegas dependiendo de la Opci$$HEX1$$f300$$ENDHEX$$n. Para la Sra Nancy.
forward
global type w_consulta_productos_bodegas from window
end type
type st_5 from statictext within w_consulta_productos_bodegas
end type
type pb_2 from picturebutton within w_consulta_productos_bodegas
end type
type pb_ok from picturebutton within w_consulta_productos_bodegas
end type
type dw_busca from datawindow within w_consulta_productos_bodegas
end type
type st_1 from statictext within w_consulta_productos_bodegas
end type
type pb_1 from picturebutton within w_consulta_productos_bodegas
end type
type dw_2 from datawindow within w_consulta_productos_bodegas
end type
type dw_1 from datawindow within w_consulta_productos_bodegas
end type
end forward

global type w_consulta_productos_bodegas from window
integer x = 5
integer y = 452
integer width = 4210
integer height = 1696
boolean titlebar = true
string title = "Consulta de Productos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 81324524
event ue_filter pbm_custom02
st_5 st_5
pb_2 pb_2
pb_ok pb_ok
dw_busca dw_busca
st_1 st_1
pb_1 pb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_consulta_productos_bodegas w_consulta_productos_bodegas

type variables
boolean ib_directo
end variables

event ue_filter;dw_1.Setfilter("")
dw_1.filter()
end event

event open;setpointer(hourglass!)
dw_busca.insertrow(1)
dw_1.Settransobject(sqlca)
dw_2.Settransobject(sqlca)

dw_1.setredraw(false)
dw_1.Retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),integer(str_appgeninfo.seccion))
dw_1.setredraw(true)

dw_1.setrowfocusindicator(hand!)
setpointer(arrow!)
gb_por_consulta = true

end event

on w_consulta_productos_bodegas.create
this.st_5=create st_5
this.pb_2=create pb_2
this.pb_ok=create pb_ok
this.dw_busca=create dw_busca
this.st_1=create st_1
this.pb_1=create pb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.st_5,&
this.pb_2,&
this.pb_ok,&
this.dw_busca,&
this.st_1,&
this.pb_1,&
this.dw_2,&
this.dw_1}
end on

on w_consulta_productos_bodegas.destroy
destroy(this.st_5)
destroy(this.pb_2)
destroy(this.pb_ok)
destroy(this.dw_busca)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event close;gb_por_consulta = false
end event

type st_5 from statictext within w_consulta_productos_bodegas
integer x = 32
integer y = 1440
integer width = 1417
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Presione  Crt + F7 Para ver el detalle de Stocks por Bodega"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_consulta_productos_bodegas
integer x = 2633
integer y = 1384
integer width = 174
integer height = 152
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Stock.Gif"
alignment htextalign = left!
end type

event clicked;setpointer(hourglass!)

dw_1.setfilter("")
dw_1.filter()
dw_1.reset()
dw_2.reset()
dw_2.visible = false
w_marco.setmicrohelp("Espere por favor... Se esta Actualizando Stocks...")
dw_busca.insertrow(1)
dw_1.Settransobject(sqlca)
dw_2.Settransobject(sqlca)
dw_1.Setredraw(false)
dw_1.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
dw_1.Setredraw(true)
dw_1.setrowfocusindicator(hand!)
setpointer(arrow!)
gb_por_consulta = true

w_marco.setmicrohelp("Listo.")

dw_busca.Setfocus()
dw_busca.SetColumn("codant")

end event

type pb_ok from picturebutton within w_consulta_productos_bodegas
integer x = 2825
integer y = 1384
integer width = 183
integer height = 160
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
end type

event clicked;string ls_codant, li_lon_filtro
window lw_aux

datawindow ldw_aux

if dw_busca.accepttext()<1 then return

string ls_null
setNull(ls_null)


setpointer(arrow!)

string ls_texto, ls_col, ls, 	ls_filtro

ls_col = dw_busca.GetcolumnName()
ls_texto = upper(dw_busca.getitemstring(dw_busca.GetRow(), ls_col))

if (trim(ls_texto) = '' or isnull(ls_texto)) and ib_directo = false then
     dw_1.SetFilter(ls_null)
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

type dw_busca from datawindow within w_consulta_productos_bodegas
event ue_downkey pbm_dwnkey
integer x = 9
integer width = 4192
integer height = 160
integer taborder = 10
string dataobject = "dw_productos_busca_compras"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_downkey;string ls_columna

if dw_busca.RowCount() > 0 then
	ls_columna = dw_busca.GetcolumnName()
end if

CHOOSE CASE key
		
	CASE KeyEnter!
		pb_ok.triggerevent(clicked!)
		
	CASE KeyPageDown!
		dw_1.ScrollnextPage()
		
	CASE KeyPageUp!
		dw_1.ScrollPriorPage()
		
	CASE KeyUpArrow!
		dw_1.ScrollPriorRow()
		
	CASE KeyDownArrow!
		dw_1.ScrollNextRow()
		
		
	CASE ELSE
		if (KeyDown(KeyControl!)) and (keydown(KeyF7!))  then
			if dw_1.RowCount() >= 1 then
				string ls_codant
				dw_1.accepttext()
				dw_2.reset()
				dw_2.visible = true
				w_marco.SetMicroHelp('Espere por Favor... Se esta consultando el Stock en Bodegas......')
				ls_codant = upper(trim(dw_1.Getitemstring(dw_1.GetRow(),"codant")))
				if ls_codant ='' or isnull(ls_codant) then
					messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n....","Debe ingresar el C$$HEX1$$f300$$ENDHEX$$digo del Item para buscar el Stock en Bodegas.")
				else
					dw_2.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_codant)
					w_marco.SetMicroHelp('Listo.')
				end if
			else
				messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n....","No existen datos para recuperar Stocks de Bodegas.")		
			end if
//		else
//			if (KeyDown(KeyControl!)) and (keydown(KeyF8!))  then
//				dw_2.visible = false
//			end if
		end if	
		return
END CHOOSE

if ls_columna <> "" and Not (isnull(ls_columna)) then
	dw_busca.reset()
	dw_busca.InsertRow(0)
	dw_busca.SetColumn(ls_columna)
end if



//if KeyDown(KeyEnter!) then
//	pb_ok.triggerevent(clicked!)
//end if
//
//if (KeyDown(KeyPageDown!)) then
//	dw_1.ScrollnextPage()
//end if
//
//if (KeyDown(KeyPageUp!)) then
//	dw_1.ScrollPriorPage()
//end if
//
//if (KeyDown(KeyUpArrow!)) then
//	dw_1.ScrollPriorRow()
//end if
//
//if (KeyDown(KeyDownArrow!)) then
//	dw_1.ScrollNextRow()
//end if
//
//// encuentra el stock por bodega
//if (KeyDown(KeyControl!)) and (keydown(KeyF7!))  then
//	if dw_1.RowCount() > 1 then
//		string ls_codant
//		dw_1.accepttext()
//		dw_2.reset()
//		w_marco.SetMicroHelp('Espere por Favor... Se esta consultando el Stock en Bodegas......')
//		ls_codant = upper(trim(dw_1.Getitemstring(dw_1.GetRow(),"codant")))
//		if ls_codant ='' or isnull(ls_codant) then
//			messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n....","Debe ingresar el C$$HEX1$$f300$$ENDHEX$$digo del Item para buscar el Stock en Bodegas.")
//		else
//			dw_2.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_codant)
//			w_marco.SetMicroHelp('Listo.')
//		end if
//	else
//		messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n....","No existen datos para recuperar Stocks de Bodegas.")		
//	end if
//	return
//end if


end event

type st_1 from statictext within w_consulta_productos_bodegas
integer x = 32
integer y = 1376
integer width = 1797
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Teclee el c$$HEX1$$f300$$ENDHEX$$digo o nombre del producto que necesita ubicar y presione ENTER."
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_consulta_productos_bodegas
integer x = 3008
integer y = 1384
integer width = 183
integer height = 160
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

type dw_2 from datawindow within w_consulta_productos_bodegas
boolean visible = false
integer y = 1060
integer width = 3323
integer height = 308
string dataobject = "d_crosstab_stock_bodegas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within w_consulta_productos_bodegas
event ue_downkey pbm_dwnkey
integer x = 9
integer y = 156
integer width = 4192
integer height = 1120
string dataobject = "dw_consulta_productos_bodega"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


HA$PBExportHeader$w_producto_ubica.srw
$PBExportComments$Ubicaci$$HEX1$$f300$$ENDHEX$$n de producto
forward
global type w_producto_ubica from window
end type
type pb_ok1 from picturebutton within w_producto_ubica
end type
type dw_busca from datawindow within w_producto_ubica
end type
type st_1 from statictext within w_producto_ubica
end type
type pb_1 from picturebutton within w_producto_ubica
end type
type dw_1 from datawindow within w_producto_ubica
end type
end forward

global type w_producto_ubica from window
integer x = 5
integer y = 168
integer width = 3630
integer height = 1364
boolean titlebar = true
string title = "Ubicaci$$HEX1$$f300$$ENDHEX$$n de Productos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 81324524
pb_ok1 pb_ok1
dw_busca dw_busca
st_1 st_1
pb_1 pb_1
dw_1 dw_1
end type
global w_producto_ubica w_producto_ubica

type variables
boolean    ib_directo = false
end variables

event open;setpointer(hourglass!)
dw_busca.insertrow(1)
dw_busca.SetFocus()
dw_busca.SetColumn('nombre')
dw_1.settransobject(sqlca)


end event

on w_producto_ubica.create
this.pb_ok1=create pb_ok1
this.dw_busca=create dw_busca
this.st_1=create st_1
this.pb_1=create pb_1
this.dw_1=create dw_1
this.Control[]={this.pb_ok1,&
this.dw_busca,&
this.st_1,&
this.pb_1,&
this.dw_1}
end on

on w_producto_ubica.destroy
destroy(this.pb_ok1)
destroy(this.dw_busca)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.dw_1)
end on

type pb_ok1 from picturebutton within w_producto_ubica
integer x = 2226
integer y = 1064
integer width = 174
integer height = 152
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Ok.Gif"
end type

event clicked;string     ls_col, ls_texto,ls_codant,ls_sqloriginal,ls_addwhere,ls_sqldwnew,rc,ls_marca
int        li_fila,li_destino
window     lw_aux
datawindow ldw_aux


Setpointer(hourglass!)
dw_busca.accepttext()

/*Variables en donde se hara la insercion del producto seleccionado*/
lw_aux     = str_prodparam.ventana
ldw_aux    = str_prodparam.datawindow
li_destino = str_prodparam.fila

/*Pulso Ctrl + Enter*/
If ib_directo &
Then
   ib_directo = false
   If not Isvalid(ldw_aux) Then 
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Selecci$$HEX1$$f300$$ENDHEX$$n no permitida")
		Return
	End if 	
	li_fila = dw_1.getrow()
	If li_fila < 1 then return
	ls_codant = dw_1.GetItemString(li_fila,'codant')
	If li_destino > 0 Then
	ldw_aux.SetItem(ldw_aux.getrow(),'codant',ls_codant)
	Closewithreturn(parent,ls_codant)	
	ldw_aux.Postevent(itemchanged!)	
	Return
	End if
End if


/*Se realiza la b$$HEX1$$fa00$$ENDHEX$$squeda por cualquier campo*/
ls_col   = dw_busca.GetcolumnName()
ls_texto = upper(dw_busca.getitemstring(1,ls_col))		
If (isnull(ls_texto)) or (trim(ls_texto) = '') Then
	messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","Debe ingresar datos para ubicar el producto.")
	return
End if

dw_1.reset()
setnull(ls_codant)
ls_sqloriginal = dw_1.describe("DataWindow.Table.Select")
CHOOSE CASE ls_col
CASE 'cl_codigo'
	dw_busca.SetItem(1, "codant",ls_codant) 
	dw_busca.SetItem(1, "nombre",ls_codant) 
	dw_busca.SetItem(1, "barras",ls_codant) 
	ls_addwhere = " and ( ~~~"IN_ITEM~~~".~~~"CL_CODIGO~~~" like ~~~'"+ls_texto+"~~~')"

CASE 'codant' 	
	dw_busca.SetItem(1, "cl_codigo",ls_codant) 
	dw_busca.SetItem(1, "nombre",ls_codant) 
	dw_busca.SetItem(1, "barras",ls_codant) 
	ls_addwhere = " and ( ~~~"IN_ITEM~~~".~~~"IT_CODANT~~~" like ~~~'"+ls_texto+"~~~')"

CASE 'nombre'
	dw_busca.SetItem(1, "cl_codigo",ls_codant) 
	dw_busca.SetItem(1, "codant",ls_codant) 
	dw_busca.SetItem(1, "barras",ls_codant) 
	ls_addwhere = " and ( ~~~"IN_ITEM~~~".~~~"IT_NOMBRE~~~" like ~~~'"+ls_texto+"~~~')"

CASE 'barras'
	dw_busca.SetItem(1, "cl_codigo",ls_codant) 
	dw_busca.SetItem(1, "codant",ls_codant) 
	dw_busca.SetItem(1, "nombre",ls_codant) 
	ls_addwhere = " and ( ~~~"IN_ITEM~~~".~~~"IT_CODBAR~~~" like ~~~'"+ls_texto+"~~~')"

END CHOOSE

ls_sqldwnew = "DataWindow.Table.Select='"+ls_sqloriginal+ls_addwhere+"'"
rc = dw_1.modify(ls_sqldwnew)			
IF rc = "" THEN
dw_1.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_texto)
ELSE
MessageBox("Error", "Fallo Modify " + rc)
END IF			
dw_1.Modify("DataWindow.Table.Select ='"+ls_sqloriginal+"'")
dw_1.setfocus()
setpointer(arrow!)

end event

type dw_busca from datawindow within w_producto_ubica
event ue_downkey pbm_dwnkey
integer x = 9
integer y = 16
integer width = 3593
integer height = 212
integer taborder = 10
string dataobject = "dw_cab_productos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_downkey;if KeyDown(KeyEnter!) then
	pb_ok1.postevent(clicked!)
//	ib_sw = true
	return
end if


end event

event buttonclicked;string null_str
dw_1.SetRedraw(false)
SetNull(null_str)
dw_1.SetSort(null_str)
dw_1.Sort()
dw_1.SetRedraw(true)
end event

type st_1 from statictext within w_producto_ubica
integer x = 32
integer y = 1080
integer width = 1998
integer height = 124
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Digite el c$$HEX1$$f300$$ENDHEX$$digo o nombre del producto que necesita ubicar y presione ENTER.  Para seleccionarlo emplee CTRL+ ENTER."
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_producto_ubica
integer x = 2523
integer y = 1064
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

type dw_1 from datawindow within w_producto_ubica
event ue_downkey pbm_dwnkey
integer x = 9
integer y = 252
integer width = 3593
integer height = 784
string dataobject = "dw_productos_ubica"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_downkey;if (KeyDown(KeyControl!)) and (KeyDown(KeyEnter!)) then
	ib_directo = true
//	ib_sw = false
	//pb_ok.postevent(clicked!)
	pb_ok1.triggerevent(clicked!)
	return
end if

end event


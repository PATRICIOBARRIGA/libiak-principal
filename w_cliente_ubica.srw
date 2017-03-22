HA$PBExportHeader$w_cliente_ubica.srw
forward
global type w_cliente_ubica from window
end type
type pb_ok from picturebutton within w_cliente_ubica
end type
type st_1 from statictext within w_cliente_ubica
end type
type pb_1 from picturebutton within w_cliente_ubica
end type
type dw_busca from datawindow within w_cliente_ubica
end type
type dw_1 from datawindow within w_cliente_ubica
end type
end forward

global type w_cliente_ubica from window
integer x = 5
integer y = 168
integer width = 3113
integer height = 1392
boolean titlebar = true
string title = "Ubicaci$$HEX1$$f300$$ENDHEX$$n de Clientes"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 81324524
string icon = "C:\POSv2\Bmps\pos2.ico"
pb_ok pb_ok
st_1 st_1
pb_1 pb_1
dw_busca dw_busca
dw_1 dw_1
end type
global w_cliente_ubica w_cliente_ubica

type variables
boolean ib_directo, ib_sw
end variables

event open;setpointer(hourglass!)
dw_busca.insertrow(1)
dw_busca.SetFocus()
dw_busca.SetColumn('cliente')
dw_1.Settransobject(sqlca)
//dw_cliente_ruc.Settransobject(sqlca)
//dw_cliente_codigo.Settransobject(sqlca)
//f_recupera_empresa(dw_1,"ep_codigo")
ib_sw = true
setpointer(arrow!)

end event

on closequery;//ib_directo = false
//this.visible = false
//w_marco.setfocus()
//message.returnvalue = 1
end on

on w_cliente_ubica.create
this.pb_ok=create pb_ok
this.st_1=create st_1
this.pb_1=create pb_1
this.dw_busca=create dw_busca
this.dw_1=create dw_1
this.Control[]={this.pb_ok,&
this.st_1,&
this.pb_1,&
this.dw_busca,&
this.dw_1}
end on

on w_cliente_ubica.destroy
destroy(this.pb_ok)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.dw_busca)
destroy(this.dw_1)
end on

type pb_ok from picturebutton within w_cliente_ubica
integer x = 2391
integer y = 1092
integer width = 183
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
end type

event clicked;string        ls_col, ls_texto,ls_codclie,ls_sqloriginal,ls_addwhere,ls_sqldwnew,rc,ls_nulo
int             li_fila,li_destino
window      lw_aux
datawindow ldw_aux


Setpointer(hourglass!)
dw_busca.accepttext()

/*Variables en donde se hara la insercion del producto seleccionado*/
lw_aux     = str_cliparam.ventana
ldw_aux    = str_cliparam.datawindow
li_destino = str_cliparam.fila

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
	ls_codclie = dw_1.GetItemString(li_fila,'ce_codigo')
	
	If li_destino > 0 Then
	//gb_producto_lista = TRUE
	ldw_aux.SetItem(li_destino,'ce_codigo',ls_codclie)
	ldw_aux.postevent(itemchanged!)
	Close(parent)
	Return
	End if
End if


/*Se realiza la b$$HEX1$$fa00$$ENDHEX$$squeda por cualquier campo*/
ls_col   = dw_busca.GetcolumnName()
ls_texto = dw_busca.getitemstring(1,ls_col)
If (isnull(ls_texto)) or (trim(ls_texto) = '') Then
messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","Debe ingresar datos para ubicar el producto.")
return
End if


dw_1.reset()
setnull(ls_nulo)
ls_sqloriginal = dw_1.describe("DataWindow.Table.Select")

CHOOSE CASE ls_col
		case 'cliente'
			dw_busca.SetItem(1, "ruc_ic",ls_nulo) 
			dw_busca.SetItem(1, "codigo",ls_nulo) 
			ls_addwhere = " and ( ~~~"FA_CLIEN~~~".~~~"CE_ACTIVO~~~" = ~~'S~~' )" +&
			 " and (upper(~~~"FA_CLIEN~~~".~~~"CE_RAZONS~~~"||~~' ~~'||~~~"FA_CLIEN~~~".~~~"CE_NOMREP~~~"||~~' ~~'||~~~"FA_CLIEN~~~".~~~"CE_APEREP~~~"||~~' ~~'||~~~"FA_CLIEN~~~".~~~"CE_APEREP~~~"||~~' ~~'||~~~"FA_CLIEN~~~".~~~"CE_NOMBRE~~~"||~~' ~~'||~~~"FA_CLIEN~~~".~~~"CE_APELLI~~~") like ~~~'"+ls_texto+"~~~')"
			ls_sqldwnew = "DataWindow.Table.Select='"+ls_sqloriginal+ls_addwhere+"'"
			
		case 'ruc_ic' 	
			dw_busca.SetItem(1, "cliente",ls_nulo) 
			dw_busca.SetItem(1, "codigo",ls_nulo) 
			ls_addwhere = " and ( ~~~"FA_CLIEN~~~".~~~"CE_ACTIVO~~~" = ~~'S~~' ) and (~~~"FA_CLIEN~~~".~~~"CE_RUCIC~~~" like ~~~'"+ls_texto+"~~~')"
			ls_sqldwnew = "DataWindow.Table.Select='"+ls_sqloriginal+ls_addwhere+"'"
			
		case 'codigo'
			dw_busca.SetItem(1, "cliente",ls_nulo) 
			dw_busca.SetItem(1, "ruc_ic",ls_nulo) 
			ls_addwhere = " and ( ~~~"FA_CLIEN~~~".~~~"CE_ACTIVO~~~" = ~~'S~~' ) and (~~~"FA_CLIEN~~~".~~~"CE_CODIGO~~~" like ~~~'"+ls_texto+"~~~')"
			ls_sqldwnew = "DataWindow.Table.Select='"+ls_sqloriginal+ls_addwhere+"'"

End choose		
rc = dw_1.modify(ls_sqldwnew)
IF rc = "" THEN
dw_1.Retrieve(ls_texto)
ELSE
MessageBox("Error", "Fallo Modify " + rc)
END IF			

dw_1.Modify("DataWindow.Table.Select ='"+ls_sqloriginal+"'")
dw_1.setfocus()
setpointer(arrow!)

end event

type st_1 from statictext within w_cliente_ubica
integer x = 73
integer y = 1116
integer width = 1975
integer height = 124
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Teclee el RUC/CI, el c$$HEX1$$f300$$ENDHEX$$digo o el nombre del cliente que necesita ubicar y presione ENTER.  Para seleccionarlo emplee CTRL+ENTER."
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_cliente_ubica
integer x = 2679
integer y = 1092
integer width = 183
integer height = 160
integer taborder = 40
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

type dw_busca from datawindow within w_cliente_ubica
event ue_downkey pbm_dwnkey
integer x = 37
integer y = 16
integer width = 3031
integer height = 212
integer taborder = 10
string dataobject = "dw_busca_cliente"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_downkey;//if (KeyDown(KeyControl!)) and (KeyDown(KeyEnter!)) then
//	ib_directo = true
//	pb_ok.triggerevent(clicked!)
//	return
//end if

if KeyDown(KeyEnter!) then
	ib_sw = true
	pb_ok.postevent(clicked!)
	return
end if

//if (KeyDown(KeyPageDown!)) then
//	dw_1.ScrollnextPage()
//	return
//end if
//
//if (KeyDown(KeyPageUp!)) then
//	dw_1.ScrollPriorPage()
//	return
//end if
//
//if (KeyDown(KeyUpArrow!)) then
//	dw_1.ScrollPriorRow()
//	return
//end if
//
//if (KeyDown(KeyDownArrow!)) then
//	dw_1.ScrollNextRow()
//	return
//end if
//
end event

type dw_1 from datawindow within w_cliente_ubica
event ue_downkey pbm_dwnkey
integer x = 37
integer y = 288
integer width = 3031
integer height = 784
integer taborder = 20
string dataobject = "dw_cliente_ubica"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_downkey;if (KeyDown(KeyControl!)) and (KeyDown(KeyEnter!)) then
	ib_directo = true
	ib_sw = false
	//pb_ok.postevent(clicked!)
	pb_ok.triggerevent(clicked!)
	return
end if

end event


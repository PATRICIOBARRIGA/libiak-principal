HA$PBExportHeader$w_res_ubicaclientes.srw
forward
global type w_res_ubicaclientes from w_response_basic
end type
type sle_1 from singlelineedit within w_res_ubicaclientes
end type
type st_1 from statictext within w_res_ubicaclientes
end type
type st_2 from statictext within w_res_ubicaclientes
end type
type st_3 from statictext within w_res_ubicaclientes
end type
type st_4 from statictext within w_res_ubicaclientes
end type
end forward

global type w_res_ubicaclientes from w_response_basic
integer width = 2670
integer height = 1588
string title = "Clientes"
boolean controlmenu = false
sle_1 sle_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_res_ubicaclientes w_res_ubicaclientes

type variables
boolean ib_directo,ib_sw
end variables

on w_res_ubicaclientes.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
end on

on w_res_ubicaclientes.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

event open;call super::open;dw_response.SetTransObject(sqlca)
dw_response.Retrieve()
ib_sw = true

end event

type pb_cancel from w_response_basic`pb_cancel within w_res_ubicaclientes
integer x = 2341
integer y = 1292
integer width = 183
integer height = 160
integer taborder = 40
end type

type pb_ok from w_response_basic`pb_ok within w_res_ubicaclientes
integer x = 2112
integer y = 1296
integer width = 183
integer height = 160
integer taborder = 30
boolean default = false
end type

event pb_ok::clicked;call super::clicked;string        ls_col, ls_texto,ls_codclie,ls_sqloriginal,ls_addwhere,ls_sqldwnew,rc,ls_nulo
int             li_fila,li_destino
window      lw_aux
datawindow ldw_aux


Setpointer(hourglass!)


/*Variables en donde se hara la insercion del producto seleccionado*/
lw_aux       = str_cliparam.ventana
ldw_aux     = str_cliparam.datawindow
li_destino   = str_cliparam.fila

/*Pulso Ctrl + Enter*/
If ib_directo &
Then
   ib_directo = false
   If not Isvalid(ldw_aux) Then 
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Selecci$$HEX1$$f300$$ENDHEX$$n no permitida")
		Return
	End if 	
	li_fila = dw_response.getrow()
	If li_fila < 1 then return
	ls_codclie = dw_response.GetItemString(li_fila,'ce_codigo')
	
	If li_destino > 0 Then
	//gb_producto_lista = TRUE
	ldw_aux.SetItem(li_destino,'ce_codigo',ls_codclie)
	ldw_aux.postevent(itemchanged!)
	Close(parent)
	Return
	End if
End if



setpointer(arrow!)

end event

type dw_response from w_response_basic`dw_response within w_res_ubicaclientes
event ue_downkey pbm_dwnkey
integer x = 46
integer y = 160
integer width = 2546
integer height = 1096
integer taborder = 20
string dataobject = "d_clientes_listado"
boolean vscrollbar = true
boolean border = true
end type

event dw_response::ue_downkey;if (KeyDown(KeyControl!)) and (KeyDown(KeyEnter!)) then
	ib_directo = true
	ib_sw = false
	pb_ok.triggerevent(clicked!)
	return
end if
end event

event dw_response::clicked;call super::clicked;This.SelectRow(0,false)
This.SelectRow(row,true)
end event

type sle_1 from singlelineedit within w_res_ubicaclientes
integer x = 389
integer y = 36
integer width = 2194
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
textcase textcase = upper!
end type

event modified;string ls_data
long ll_nreg,ll_find



if not isnull(this.text )and this.text<>"" then
ls_data = this.text+'%'
else 
Setnull(ls_data)
end if

ll_nreg = dw_response.rowcount()
ll_find = dw_response.find("cliente like'"+ls_data+"'",1,ll_nreg)
if ll_find <> 0 then
dw_response.selectrow(0,false)
dw_response.scrolltorow(ll_find)
dw_response.selectrow(ll_find,true)
dw_response.Setrow(ll_find)
dw_response.SetColumn("ce_codigo")
dw_response.Setfocus()
else	
dw_response.selectrow(0,false)
end if
end event

type st_1 from statictext within w_res_ubicaclientes
integer x = 603
integer y = 1304
integer width = 873
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
string text = "para seleccionar la opci$$HEX1$$f300$$ENDHEX$$n resaltada."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_res_ubicaclientes
integer x = 325
integer y = 1308
integer width = 274
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Ctrl+Enter"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_res_ubicaclientes
integer x = 46
integer y = 1308
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
string text = "Presione"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_res_ubicaclientes
integer x = 59
integer y = 44
integer width = 320
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
string text = "Ubicar cliente:"
boolean focusrectangle = false
end type


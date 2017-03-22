HA$PBExportHeader$w_actualizar_precios.srw
$PBExportComments$Actualizar precios de los productos
forward
global type w_actualizar_precios from w_sheet_1_dw_maint
end type
type dw_ubica from datawindow within w_actualizar_precios
end type
type em_1 from editmask within w_actualizar_precios
end type
type pb_1 from picturebutton within w_actualizar_precios
end type
type pb_2 from picturebutton within w_actualizar_precios
end type
type st_3 from statictext within w_actualizar_precios
end type
type st_1 from statictext within w_actualizar_precios
end type
type rb_1 from radiobutton within w_actualizar_precios
end type
type rb_2 from radiobutton within w_actualizar_precios
end type
type rb_3 from radiobutton within w_actualizar_precios
end type
type st_2 from statictext within w_actualizar_precios
end type
type pb_3 from picturebutton within w_actualizar_precios
end type
type sle_1 from singlelineedit within w_actualizar_precios
end type
type sle_2 from singlelineedit within w_actualizar_precios
end type
type st_4 from statictext within w_actualizar_precios
end type
type st_5 from statictext within w_actualizar_precios
end type
type st_6 from statictext within w_actualizar_precios
end type
type pb_4 from picturebutton within w_actualizar_precios
end type
end forward

global type w_actualizar_precios from w_sheet_1_dw_maint
integer x = 5
integer y = 328
integer width = 4343
integer height = 2324
string title = "Actualizar Lista de Precios"
windowstate windowstate = maximized!
event ue_consultar ( )
dw_ubica dw_ubica
em_1 em_1
pb_1 pb_1
pb_2 pb_2
st_3 st_3
st_1 st_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
st_2 st_2
pb_3 pb_3
sle_1 sle_1
sle_2 sle_2
st_4 st_4
st_5 st_5
st_6 st_6
pb_4 pb_4
end type
global w_actualizar_precios w_actualizar_precios

type variables
Date id_hoy
long il_start
end variables

forward prototypes
public function integer wf_add_inprecam ()
end prototypes

event ue_consultar();dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

public function integer wf_add_inprecam ();Int i,li_reg 
String ls_itcodigo
li_reg = dw_datos.rowcount()


for i = 1 to li_reg
	
if dw_datos.Object.it_prefab.Primary.Original[i] <> dw_datos.Object.it_prefab.Primary.Current[i] then
		ls_itcodigo =  dw_datos.Object.it_codigo[i]
		dw_datos.Object.in_item_it_feccam[i] = id_hoy

/*La tabla ya no se usa 21-mar-07*/
//		update in_precam
//		set it_fecha = sysdate
//		where it_codigo = :ls_itcodigo;
//		if sqlca.sqlcode = - 1 then
//		rollback;
//		return -1
//  	     end if     
//			 
//		if sqlca.sqlcode = 0 and sqlca.sqlnrows = 0  then	  
//				insert into in_precam(it_codigo,it_fecha)
//				values(:ls_itcodigo,sysdate);
//				if sqlca.sqlcode = - 1 then
//				rollback;
//				return -1
//				end if
//		end if

end if


next
return 1



end function

event ue_insert;beep(1)
end event

event ue_delete;beep(1)
end event

on w_actualizar_precios.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.em_1=create em_1
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_3=create st_3
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.st_2=create st_2
this.pb_3=create pb_3
this.sle_1=create sle_1
this.sle_2=create sle_2
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.pb_4=create pb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.rb_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.pb_3
this.Control[iCurrent+12]=this.sle_1
this.Control[iCurrent+13]=this.sle_2
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.pb_4
end on

on w_actualizar_precios.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.em_1)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.st_2)
destroy(this.pb_3)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.pb_4)
end on

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

call super::open

id_hoy = date(f_hoy())
end event

event resize;call super::resize;dataWindow ldw_aux

if this.ib_inReportMode then
	ldw_aux = dw_report
else
	ldw_aux = dw_datos
end if

ldw_aux.resize(this.workSpaceWidth() - 50, this.workSpaceHeight() - 600)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_actualizar_precios
integer x = 23
integer y = 512
integer width = 4247
integer height = 1696
string dataobject = "d_cambia_precio_item"
boolean border = true
boolean hsplitscroll = true
end type

event dw_datos::doubleclicked;call super::doubleclicked;decimal lc_valor
long i

If dwo.name = 'it_codant' or dwo.name = 'it_nombre'&
Then
dw_datos.SetFilter('')
dw_datos.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
End if

//If dwo.name = 'it_prefab' &
//Then
//lc_valor = This.GetItemNumber(row,"it_prefab")
//for i = row to this.rowcount()
//this.setitem(i,"it_prefab",lc_valor)
//next	
//End if
//
//If dwo.name = 'it_precio' &
//Then
//lc_valor = This.GetItemNumber(row,"it_precio")
//for i = row to this.rowcount()
//this.setitem(i,"it_precio",lc_valor)
//next	
//End if





end event

event dw_datos::clicked;call super::clicked;string ls_marca[]
Long   ll_nreg,i

ll_nreg = This.Rowcount()
if dwo.name = 'b_1' then

   if this.Object.b_1.text = 'Marcar todo' then
	for i=1 to ll_nreg
	this.setitem(i,"it_imprimir",'S')
	next
	this.Object.b_1.text = 'Desmarcar todo'
   else
	for i=1 to ll_nreg
	this.setitem(i,"it_imprimir",'N')
	next
	this.Object.b_1.text = 'Marcar todo'
   end if
end if

//Establecer el valor de la columna calculada al  it_prefab
if dwo.name = 'b_3' then
   this.Object.it_prefab.primary = this.Object.cc_preciotarjeta.primary
end if



if dwo.name = 'st_prefab' then
	if Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El precio de f$$HEX1$$e100$$ENDHEX$$brica ser$$HEX2$$e1002000$$ENDHEX$$modificado..Est$$HEX2$$e1002000$$ENDHEX$$seguro?...",Question!,YesNo!,2) = 1 then
	   this.object.it_prefab.primary = this.object.it_precio.primary
	end if
end if

if dwo.name = 'st_pventa' then
	if Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El precio de venta ser$$HEX2$$e1002000$$ENDHEX$$modificado..Est$$HEX2$$e1002000$$ENDHEX$$seguro?...",Question!,YesNo!,2) = 1 then
   this.object.it_precio.primary = this.object.it_prefab.primary
   end if
end if
end event

event dw_datos::updatestart;call super::updatestart;if wf_add_inprecam() = 1 then	
return 0
else
return 1
end if


end event

event dw_datos::itemchanged;call super::itemchanged;This.AcceptText()

//INCLUYE EL 5% DE DESCUENTO POR PAGO EN EFECTIVO
if dwo.name = "it_margen"  then
this.object.it_prefab[row] =  this.object.cc_preciotarjeta[row]/.95
end if

if dwo.name = "it_costo"  then
this.object.it_prefab[row] =  this.object.cc_preciotarjeta[row]/.95
end if


end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_actualizar_precios
integer x = 809
integer y = 924
integer taborder = 40
end type

type dw_ubica from datawindow within w_actualizar_precios
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 750
integer y = 656
integer width = 1797
integer height = 360
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Producto"
string dataobject = "d_recupera_producto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_datos.SetFocus()
	dw_datos.SetFilter('')
	dw_datos.Filter()
end if
end event

event doubleclicked;dw_ubica.Visible = false
dw_datos.SetFocus()
dw_datos.SetFilter('')
dw_datos.Filter()
end event

event itemchanged;string ls, ls_criterio, ls_tipo
long ll_found

CHOOSE CASE this.GetColumnName()

	CASE 'codant'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "it_codant = " +  +"'"+ ls + "'"		
				ll_found = dw_datos.Find(ls_criterio,1,dw_datos.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_datos.SetFocus()
				  dw_datos.ScrollToRow(ll_found)
				  dw_datos.SetRow(ll_found)
				  dw_datos.SetColumn('it_codant')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Producto no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "it_codant like " +  +"'"+ ls + "'"		
				dw_datos.SetFilter(ls_criterio)
				dw_datos.Filter()
				dw_datos.SetFocus()
    		   dw_datos.SetColumn('it_codant')
				this.Visible = false	
				dw_datos.ScrollToRow(dw_datos.GetRow())
				dw_datos.SetRow(dw_datos.GetRow())				
				
		END CHOOSE
	CASE 'nombre'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "it_nombre = " +  +"'"+ ls + "'"		
				ll_found = dw_datos.Find(ls_criterio,1,dw_datos.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_datos.SetFocus()
				  dw_datos.ScrollToRow(ll_found)
				  dw_datos.SetRow(ll_found)
				  dw_datos.SetColumn('it_nombre')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Producto no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "it_nombre like " +  +"'"+ ls + "'"		
				dw_datos.SetFilter(ls_criterio)
				dw_datos.Filter()
				dw_datos.SetFocus()
			   dw_datos.SetColumn('it_nombre')
				this.Visible = false				
				dw_datos.ScrollToRow(dw_datos.GetRow())
				dw_datos.SetRow(dw_datos.GetRow())				
				
		END CHOOSE		

END CHOOSE





end event

type em_1 from editmask within w_actualizar_precios
integer x = 1321
integer y = 28
integer width = 370
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0.00"
end type

type pb_1 from picturebutton within w_actualizar_precios
integer x = 1947
integer y = 16
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
boolean default = true
boolean flatstyle = true
boolean originalsize = true
string picturename = "OutputPrevious!"
alignment htextalign = right!
string powertiptext = "Subir"
end type

event clicked;dec{2} lc_factor
dec{2} lc_valor
Long ll_reg,i

SetPointer(Hourglass!)
lc_factor = dec(em_1.text)

ll_reg = dw_datos.rowcount()
if rb_1.checked then
    for i = 1 to ll_reg
		dw_datos.Object.it_margen[i] = lc_factor
		lc_valor = dw_datos.Object.it_costo[i]
		if lc_valor <> 0 then
		dw_datos.Object.it_prefab[i] = round((lc_valor/(1 - lc_factor/100))/0.95,2)
		dw_datos.Object.it_precio[i] = round((lc_valor/( 1 - lc_factor/100))/0.95,2)
		end if
	next
end if

if rb_2.checked then
	for i = 1 to ll_reg
		dw_datos.Object.it_margen[i] = lc_factor
		lc_valor = dw_datos.Object.it_prefab[i]
		if lc_valor <> 0 then
		dw_datos.Object.it_prefab[i] = round((lc_valor /(1 - (lc_factor/100))),2)
		end if
	next
end if

if rb_3.checked then
	for i = 1 to ll_reg
		dw_datos.Object.it_margen[i] = lc_factor
		lc_valor = dw_datos.Object.it_precio[i]
		if lc_valor <> 0 then
		dw_datos.Object.it_precio[i] = round((lc_valor /(1 - (lc_factor/100))),2)
		end if
	next
end if
SetPointer(Arrow!)

end event

type pb_2 from picturebutton within w_actualizar_precios
integer x = 2089
integer y = 16
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean flatstyle = true
boolean originalsize = true
string picturename = "OutputNext!"
alignment htextalign = right!
string powertiptext = "Bajar"
end type

event clicked;dec{2} lc_factor
dec{2} lc_valor
Long ll_reg,i

SetPointer(Hourglass!)
lc_factor = dec(em_1.text)

ll_reg = dw_datos.rowcount()
if rb_1.checked then
    for i = 1 to ll_reg
		lc_valor = dw_datos.Object.it_costo[i]
		if lc_valor <> 0 then
		dw_datos.Object.it_prefab[i] = round((lc_valor*(1 - lc_factor/100))/0.95,2)
		dw_datos.Object.it_precio[i] = round((lc_valor*( 1 - lc_factor/100))/0.95,2)
		end if
	next
end if

if rb_2.checked then
	for i = 1 to ll_reg
		lc_valor = dw_datos.Object.it_prefab[i]
		if lc_valor <> 0 then
		dw_datos.Object.it_prefab[i] = round((lc_valor*(1 - lc_factor/100)),2)
		end if
	next
end if

if rb_3.checked then
	for i = 1 to ll_reg
		lc_valor = dw_datos.Object.it_precio[i]
		if lc_valor <> 0 then
		dw_datos.Object.it_precio[i] = round((lc_valor*(1 - lc_factor/100)),2)
		end if
	next
end if
SetPointer(Arrow!)
end event

type st_3 from statictext within w_actualizar_precios
integer x = 55
integer y = 32
integer width = 1225
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Para cambiar el precio ingrese aqu$$HEX2$$ed002000$$ENDHEX$$el factor de utilidad:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_actualizar_precios
boolean visible = false
integer x = 59
integer y = 176
integer width = 1042
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
string text = "El precio incluye el 5% por descuento adicional"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_actualizar_precios
integer x = 1211
integer y = 108
integer width = 672
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
string text = "Precios en base al costo"
end type

type rb_2 from radiobutton within w_actualizar_precios
integer x = 1211
integer y = 184
integer width = 1344
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
string text = "Precio de fabrica = precio fabrica / (1 - (factor/100))"
end type

type rb_3 from radiobutton within w_actualizar_precios
integer x = 1211
integer y = 264
integer width = 1266
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
string text = "Precio de venta = precio venta / (1 - (factor/100))"
end type

type st_2 from statictext within w_actualizar_precios
integer x = 59
integer y = 112
integer width = 846
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
string text = "Seleccione el dato que desea cambiar"
boolean focusrectangle = false
end type

type pb_3 from picturebutton within w_actualizar_precios
integer x = 2226
integer y = 16
integer width = 110
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean flatstyle = true
string picturename = "Undo!"
alignment htextalign = left!
vtextalign vtextalign = top!
string powertiptext = "Deshacer"
end type

event clicked;Setpointer(hourglass!)
dw_datos.retrieve(str_appgeninfo.empresa)
Setpointer(Arrow!)
end event

type sle_1 from singlelineedit within w_actualizar_precios
integer x = 370
integer y = 400
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
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;String ls_data,ls_nombre
Long ll_find

ls_data = this.text

select it_nombre into :ls_nombre from in_item where it_codant = :ls_data;
sle_2.text = ls_nombre

//ls_data = '%'+this.text+'%'
//ll_find = dw_datos.find("it_codant like '"+ls_data+"'",il_start,dw_datos.Rowcount())

ll_find = dw_datos.find("it_codant = '"+ls_data+"'",il_start,dw_datos.Rowcount())
if ll_find = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones...")
	return
end if
If ll_find > 0 then 
	dw_datos.ScrollToRow(ll_find)
	dw_datos.SetRow(ll_find)
	dw_datos.SetRowFocusIndicator(Hand!)
end if
end event

type sle_2 from singlelineedit within w_actualizar_precios
integer x = 878
integer y = 404
integer width = 3086
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean border = false
boolean displayonly = true
end type

event modified;String ls_data
Long ll_find

ls_data = '%'+this.text+'%'
ll_find = dw_datos.find("it_nombre like '"+ls_data+"'",1,dw_datos.Rowcount())

If ll_find <> 0 then 
	dw_datos.ScrollToRow(ll_find)
	dw_datos.SetRow(ll_find)
end if
end event

type st_4 from statictext within w_actualizar_precios
integer x = 46
integer y = 416
integer width = 288
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
boolean focusrectangle = false
end type

type st_5 from statictext within w_actualizar_precios
integer x = 882
integer y = 336
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

type st_6 from statictext within w_actualizar_precios
integer x = 379
integer y = 336
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

type pb_4 from picturebutton within w_actualizar_precios
boolean visible = false
integer x = 4018
integer y = 392
integer width = 110
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "FindNext!"
alignment htextalign = left!
string powertiptext = "Siguiente"
end type

event clicked;il_start  = dw_datos.getrow() + 1
sle_2.triggerevent(modified!)
end event


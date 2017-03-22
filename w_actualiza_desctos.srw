HA$PBExportHeader$w_actualiza_desctos.srw
forward
global type w_actualiza_desctos from w_sheet_1_dw_maint
end type
type rr_1 from roundrectangle within w_actualiza_desctos
end type
type st_1 from statictext within w_actualiza_desctos
end type
type dw_1 from datawindow within w_actualiza_desctos
end type
type st_3 from statictext within w_actualiza_desctos
end type
type pb_1 from picturebutton within w_actualiza_desctos
end type
type dw_2 from uo_dw_basic within w_actualiza_desctos
end type
type st_2 from statictext within w_actualiza_desctos
end type
type st_4 from statictext within w_actualiza_desctos
end type
type dw_ubica from datawindow within w_actualiza_desctos
end type
end forward

global type w_actualiza_desctos from w_sheet_1_dw_maint
integer width = 5431
integer height = 2260
string title = "Actualizar descuentos"
event ue_consultar pbm_custom01
rr_1 rr_1
st_1 st_1
dw_1 dw_1
st_3 st_3
pb_1 pb_1
dw_2 dw_2
st_2 st_2
st_4 st_4
dw_ubica dw_ubica
end type
global w_actualiza_desctos w_actualiza_desctos

type variables
datawindow idw_activo
end variables

event ue_consultar;dw_ubica.Reset()
dw_ubica.title = "Buscar producto"
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

on w_actualiza_desctos.create
int iCurrent
call super::create
this.rr_1=create rr_1
this.st_1=create st_1
this.dw_1=create dw_1
this.st_3=create st_3
this.pb_1=create pb_1
this.dw_2=create dw_2
this.st_2=create st_2
this.st_4=create st_4
this.dw_ubica=create dw_ubica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rr_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.dw_ubica
end on

on w_actualiza_desctos.destroy
call super::destroy
destroy(this.rr_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.dw_ubica)
end on

event open;gnv_help.of_register(This)
ib_notautoretrieve = true
dw_1.settransobject(sqlca)
dw_2.settransobject( sqlca)
dw_1.retrieve()
//dw_2.retrieve()
f_recupera_empresa(dw_datos,"cod_descto")


//d_um_fp_descto
dw_1.InsertRow(0)
call super::open
end event

event ue_retrieve;String ls_estado
///Int i
Long ll_reg

ll_reg  = dw_1.rowcount()
if ll_reg = 0 then return

//for i = 1 to  ll_reg
//   if dw_1.Object.flag[i] = 'S' then
//	ls_estado[i] = dw_1.Object.tc_codigo[i]
//   end if
//next
ls_estado = dw_1.Object.tc_codigo[1]
dw_2.retrieve(ls_estado)
dw_datos.retrieve(ls_estado)
end event

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 1.05*dw_datos.y)
return 1
end event

event close;call super::close;gnv_help.of_unregister(This)
end event

event ue_filter;string ls_null
integer li_res

setNull(ls_null)
li_res = idw_activo.SetFilter(ls_null)
if li_res = 1 then
	idw_activo.Filter()
	return idw_activo.groupcalc()
else
	return li_res
end if
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_actualiza_desctos
integer x = 46
integer y = 872
integer width = 5344
integer height = 1236
string dataobject = "d_actualiza_desctos"
boolean hsplitscroll = true
end type

event dw_datos::doubleclicked;call super::doubleclicked;String ls_tdcodigo,ls_sino
Long ll_totalmodificados,i

if   dwo.name = 'cod_descto' then
	for i = row  to  this.rowcount()
		ls_tdcodigo = this.getitemstring(row,'cod_descto')	
		this.setitem(i,'cod_descto',ls_tdcodigo)
   next
end if
if dwo.name = 'vigente' then
	for i = row  to  this.rowcount()
		ls_sino = this.getitemstring(row,'vigente')	
		this.setitem(i,'vigente',ls_sino)
   next
end if
end event

event dw_datos::updateend;call super::updateend;if  rowsupdated > 0 then
	w_marco.setmicrohelp("Listo.... Se han actualizado '"+string(rowsupdated)+"' items.")
end if
if  rowsinserted > 0 then
	w_marco.setmicrohelp("Listo.... Se han agregado '"+string(rowsinserted)+"' items.")
end if
parent.triggerevent("ue_retrieve")
end event

event dw_datos::getfocus;call super::getfocus;idw_activo = this
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;SetRowFocusIndicator(hand!)
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_actualiza_desctos
integer x = 4366
integer y = 20
integer width = 265
integer height = 272
string dataobject = "d_actualiza_descuentos"
end type

type rr_1 from roundrectangle within w_actualiza_desctos
long linecolor = 134217739
integer linethickness = 4
long fillcolor = 67108864
integer x = 46
integer y = 104
integer width = 1399
integer height = 116
integer cornerheight = 40
integer cornerwidth = 46
end type

type st_1 from statictext within w_actualiza_desctos
integer x = 55
integer y = 24
integer width = 1413
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Seleccione el tipo de cliente al cual va aplicar el descuento."
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_actualiza_desctos
integer x = 46
integer y = 84
integer width = 1367
integer height = 144
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_dctocli"
boolean border = false
boolean livescroll = true
end type

event getfocus;idw_activo = this
end event

event itemchanged;this.AcceptText()
parent.triggerevent("ue_retrieve")
end event

type st_3 from statictext within w_actualiza_desctos
integer x = 55
integer y = 244
integer width = 1362
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
string text = "Seleccione los items a los cuales desea asignar el descuento"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_actualiza_desctos
string tag = "BubbleHelp = Click aqu$$HEX2$$ed002000$$ENDHEX$$para a$$HEX1$$f100$$ENDHEX$$adir mas items al panel de descuentos"
integer x = 594
integer y = 764
integer width = 123
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string picturename = "Custom034!"
alignment htextalign = left!
end type

event clicked;Long ll_reg,ll_new,ll_find
int i
Dec{2} lc_costo,lc_precio,lc_prefab
String ls_pepa,ls_codant,ls_nombre,ls_fpcodigo,ls_cldescri,ls_fpdescri,ls_fbcodigo


Setpointer(Hourglass!)
//dw_datos.setredraw(false)
//ls_fpcodigo = dw_1.object.fa_formpag_fp_codigo[dw_1.getrow()]
//ls_fpdescri = dw_1.object.fa_formpag_fp_descri[dw_1.getrow()]

ls_fpcodigo = dw_1.object.tc_codigo[dw_1.getrow()]  //tipo de cliente
//ls_fpdescri = dw_1.object.dc_descri[dw_1.getrow()]   //descripcion del tipo de cliente



ll_reg = 	dw_2.rowcount( )
for i = 1 to ll_reg
	if dw_2.object.flag[i] = 'S' then
	ls_pepa =    dw_2.object.it_codigo[i]	
	ls_codant = dw_2.object.codant[i]	
	ls_nombre = dw_2.object.nombre[i]
	ls_cldescri = dw_2.object.cl_descri[i]
	ls_fbcodigo = dw_2.object.fb_codigo[i]
	lc_costo = dw_2.object.it_costo[i]
	lc_precio = dw_2.object.it_precio[i]
	lc_prefab = dw_2.object.it_prefab[i]
	
	
	
	ll_find = dw_datos.find("in_descitem_it_codigo = '"+ls_pepa+"' and es_codigo = '"+ls_fpcodigo+"'",1,dw_datos.Rowcount())
	if ll_find > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existe un descuento para el producto: ["+ls_codant+"] y la categor$$HEX1$$ed00$$ENDHEX$$a: ["+ls_fpdescri+"]... Por favor verifique... l$$HEX1$$ed00$$ENDHEX$$nea ["+string(ll_find)+"]")
	return
     end if
		  
	ll_new = 	dw_datos.insertrow(1)
	dw_datos.Object.in_descitem_em_codigo[ll_new] = str_appgeninfo.empresa
	dw_datos.Object.in_descitem_it_codigo[ll_new] = ls_pepa
	dw_datos.Object.codant[ll_new] = ls_codant
	dw_datos.Object.nombre[ll_new] = ls_nombre
	dw_datos.Object.es_codigo[ll_new] = ls_fpcodigo  //tipo de cliente
	dw_datos.Object.fa_dctocli_dc_descri[ll_new] = ls_fpdescri
	dw_datos.Object.clase[ll_new] = ls_cldescri
     dw_datos.Object.fb_codigo[ll_new] = ls_fbcodigo
	dw_datos.object.costo[ll_new] = lc_costo
	dw_datos.object.precio[ll_new]= lc_precio
	dw_datos.object.prefab[ll_new]= lc_prefab
	end if
next
//dw_datos.setredraw(true)
end event

type dw_2 from uo_dw_basic within w_actualiza_desctos
integer x = 55
integer y = 316
integer width = 5321
integer height = 452
integer taborder = 11
string dataobject = "d_um_items"
boolean vscrollbar = false
boolean hsplitscroll = true
boolean livescroll = false
end type

event getfocus;call super::getfocus;idw_activo = this

end event

event clicked;call super::clicked;int i

if dwo.name = 'b_1' then
 if  this.object.b_1.text = 'Seleccionar todo'	then

	for i=1 to this.rowcount()
	this.object.flag[i]= 'S'	
	next
	this.object.b_1.text  ='Limpiar todo'
else
	for i=1 to this.rowcount()
	this.object.flag[i]= 'N'	
	next
	this.object.b_1.text  ='Seleccionar todo'	
end if	
	
end if
end event

type st_2 from statictext within w_actualiza_desctos
string tag = "BubbleHelp = Click aqu$$HEX2$$ed002000$$ENDHEX$$para a$$HEX1$$f100$$ENDHEX$$adir mas items con descuentos"
integer x = 1440
integer y = 232
integer width = 59
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
string text = "+"
alignment alignment = center!
boolean border = true
long bordercolor = 134217739
boolean focusrectangle = false
end type

event clicked;//if dw_2.visible = false then
//	dw_2.visible = true
//	dw_2.retrieve(str_appgeninfo.empresa )
////	dw_datos.move( 50,1216)
////	dw_datos.resize(parent.workSpaceWidth() - 2*dw_datos.x, parent.workSpaceHeight() - 1.05*dw_datos.y)
//     this.text = '-' 
//	st_4.visible = true
//	pb_1.visible= true
//else
//	dw_2.visible = false
////	dw_datos.move( 50,364)
////	dw_datos.resize(parent.workSpaceWidth() - 2*dw_datos.x, parent.workSpaceHeight() - 1.05*dw_datos.y)
//	this.text = '+'
//	st_4.visible = false
//	pb_1.visible= false
//end if

///
//dw_2.visible = true
dw_2.retrieve(str_appgeninfo.empresa )

end event

type st_4 from statictext within w_actualiza_desctos
integer x = 41
integer y = 788
integer width = 475
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
string text = "Descuentos por item"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_ubica from datawindow within w_actualiza_desctos
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 1531
integer y = 8
integer width = 2313
integer height = 288
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Ubicar item"
string dataobject = "d_sel_item"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
end if
end event

event itemchanged;string ls_criterio, ls_tipo
long ll_found
int li_reg
datawindow ldw_aux

ldw_aux = idw_activo

li_reg = ldw_aux.rowcount()
 ls_tipo = this.GetItemString(1,'tipo')
 If dwo.name = 'producto' Then
 CHOOSE CASE ls_tipo
	CASE '1'  //Busca
		ls_criterio = "codant = '" +  data +"'"
		ll_found = ldw_aux.Find(ls_criterio,1,ldw_aux.RowCount())
		if ll_found > 0 and not isnull(ll_found) then
		  ldw_aux.ScrollToRow(ll_found)
		  ldw_aux.SelectRow(ll_found,true)
		  ldw_aux.SetRow(ll_found)
		  ldw_aux.SetFocus()		  
		else
		  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Producto no se encuentra, verifique datos')
		  return
	  end if
END CHOOSE
End if
end event

event editchanged;String ls_criterio,ls_data
Long  ll_find,ll_nreg
datawindow ldw_aux




ldw_aux = idw_activo

if this.object.tipo[1] = '2' then
if not isnull(data )and data<>"" then
ls_data = '%'+data+'%'
else 
Setnull(ls_data)
end if	

ll_nreg = ldw_aux.rowcount()	
ll_find =  ldw_aux.find("nombre like'"+ls_data+"'",1,ll_nreg)

if ll_find <> 0 then
ldw_aux.selectrow(0,false)
ldw_aux.scrolltorow(ll_find)
ldw_aux.Setrow(ll_find)
else	
ldw_aux.selectrow(0,false)
ldw_aux.Setrow(0)
end if   
end if
end event


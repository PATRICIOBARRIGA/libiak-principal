HA$PBExportHeader$w_um_crear_desctos_x_item.srw
$PBExportComments$Actualizar precios de los productos
forward
global type w_um_crear_desctos_x_item from w_sheet_1_dw_maint
end type
type dw_ubica from datawindow within w_um_crear_desctos_x_item
end type
type st_3 from statictext within w_um_crear_desctos_x_item
end type
type st_1 from statictext within w_um_crear_desctos_x_item
end type
type st_2 from statictext within w_um_crear_desctos_x_item
end type
type dw_1 from datawindow within w_um_crear_desctos_x_item
end type
end forward

global type w_um_crear_desctos_x_item from w_sheet_1_dw_maint
integer x = 5
integer y = 328
integer width = 3579
integer height = 2016
string title = "Actualizar Lista de Precios"
long backcolor = 67108864
dw_ubica dw_ubica
st_3 st_3
st_1 st_1
st_2 st_2
dw_1 dw_1
end type
global w_um_crear_desctos_x_item w_um_crear_desctos_x_item

type variables
Date id_hoy
end variables

forward prototypes
public function integer wf_add_inprecam ()
end prototypes

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

on w_um_crear_desctos_x_item.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.st_3=create st_3
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_1
end on

on w_um_crear_desctos_x_item.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
f_recupera_empresa(dw_1,"td_codigo")
dw_1.insertrow(0)
call super::open

id_hoy = date(f_hoy())
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_um_crear_desctos_x_item
integer y = 236
integer width = 3534
integer height = 1660
string dataobject = "d_um_items"
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

If dwo.name = 'it_prefab' &
Then
lc_valor = This.GetItemNumber(row,"it_prefab")
for i = row to this.rowcount()
this.setitem(i,"it_prefab",lc_valor)
next	
End if

If dwo.name = 'it_precio' &
Then
lc_valor = This.GetItemNumber(row,"it_precio")
for i = row to this.rowcount()
this.setitem(i,"it_precio",lc_valor)
next	
End if





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

type dw_report from w_sheet_1_dw_maint`dw_report within w_um_crear_desctos_x_item
integer x = 809
integer y = 924
end type

type dw_ubica from datawindow within w_um_crear_desctos_x_item
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 530
integer y = 312
integer width = 1797
integer height = 360
integer taborder = 11
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

type st_3 from statictext within w_um_crear_desctos_x_item
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

type st_1 from statictext within w_um_crear_desctos_x_item
boolean visible = false
integer x = 69
integer y = 116
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

type st_2 from statictext within w_um_crear_desctos_x_item
integer x = 59
integer y = 112
integer width = 1385
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
string text = "Seleccione el descuento que desea asignar a los productos."
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_um_crear_desctos_x_item
integer x = 1408
integer y = 100
integer width = 1189
integer height = 80
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_descuentos"
boolean border = false
boolean livescroll = true
end type


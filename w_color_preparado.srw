HA$PBExportHeader$w_color_preparado.srw
forward
global type w_color_preparado from window
end type
type st_2 from statictext within w_color_preparado
end type
type cb_1 from commandbutton within w_color_preparado
end type
type dw_1 from datawindow within w_color_preparado
end type
type pb_1 from picturebutton within w_color_preparado
end type
type pb_ok from picturebutton within w_color_preparado
end type
type st_1 from statictext within w_color_preparado
end type
type dw_color from datawindow within w_color_preparado
end type
end forward

global type w_color_preparado from window
integer x = 197
integer y = 680
integer width = 5595
integer height = 1648
boolean titlebar = true
string title = "Colores preparados y tintes"
windowtype windowtype = response!
long backcolor = 79741120
string icon = "Imagenes\Pos.Ico"
st_2 st_2
cb_1 cb_1
dw_1 dw_1
pb_1 pb_1
pb_ok pb_ok
st_1 st_1
dw_color dw_color
end type
global w_color_preparado w_color_preparado

type variables
boolean sw
string is_base,&
          is_itcodigo,&
	     is_unidad
end variables

on w_color_preparado.create
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.pb_1=create pb_1
this.pb_ok=create pb_ok
this.st_1=create st_1
this.dw_color=create dw_color
this.Control[]={this.st_2,&
this.cb_1,&
this.dw_1,&
this.pb_1,&
this.pb_ok,&
this.st_1,&
this.dw_color}
end on

on w_color_preparado.destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.pb_1)
destroy(this.pb_ok)
destroy(this.st_1)
destroy(this.dw_color)
end on

event open;
dw_color.insertrow(0)
dw_color.SetFocus()
dw_color.SetColumn('codigo')


is_itcodigo = str_prodparam.codant
is_base      = str_prodparam.cod_base
is_unidad   = str_prodparam.medida

choose case is_unidad
		
		
	case '3' //CANECA  
     dw_color.object.presentacion[1] = 'CANECA'		
     case '6' //GALON
	dw_color.object.presentacion[1] = 'GALON'		
     case '7' //LITRO
     dw_color.object.presentacion[1] = 'LITRO'		
    case '8' //OCTAVO
     dw_color.object.presentacion[1] = 'OCTAVO'		
	
end choose 
		



end event

type st_2 from statictext within w_color_preparado
integer x = 82
integer y = 336
integer width = 517
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "TINTES POR FORMULA"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_color_preparado
integer x = 3890
integer y = 128
integer width = 997
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CLICK AQUI PARA CALCULAR PRECIO"
end type

event clicked;long i
dec{4} lc_preciobase,lc_presentacion,lc_cantidad_x_preparar
string ls_codformula,ls_presentacion,ls_codbase


//La formulaci$$HEX1$$f300$$ENDHEX$$n de los tintes en IN_FORMULAS esta dado para la presentaci$$HEX1$$f300$$ENDHEX$$n de GALON
dw_color.AcceptText()

ls_codbase        = is_itcodigo
ls_codformula    = dw_color.object.codigo[1]
ls_presentacion  = dw_color.object.presentacion[1]
lc_cantidad_x_preparar = dw_color.object.cantidad[1]

f_tintes(ls_codbase,ls_codformula,ls_presentacion,lc_cantidad_x_preparar,dw_1)


end event

type dw_1 from datawindow within w_color_preparado
integer x = 37
integer y = 396
integer width = 5463
integer height = 884
integer taborder = 20
string title = "none"
string dataobject = "d_tinte_x_formula"
boolean vscrollbar = true
end type

event constructor;this.settransobject(sqlca)
end event

type pb_1 from picturebutton within w_color_preparado
event clicked pbm_bnclicked
integer x = 2085
integer y = 1312
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

event clicked;Decimal{2 } lc_preciobase
String lch_modifica='N'

//str_prodparam.precio    = lc_preciounit
//str_prodparam.formula = ls_formula
closewithreturn(parent,lch_modifica)
end event

type pb_ok from picturebutton within w_color_preparado
event clicked pbm_bnclicked
integer x = 1861
integer y = 1312
integer width = 183
integer height = 160
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\OK.Gif"
end type

event clicked;decimal{2} lc_precio,lc_cantid,lc_preciounit
int li_destino
string ls_codigo,ls_presentacion,ls_formula,lch_modifica


if dw_color.accepttext() < 1 then return
dw_1.acceptText()
setpointer(hourglass!)



lc_precio = dw_color.GetItemDecimal(1,'precio')
ls_presentacion = dw_color.GetItemString(1,'presentacion')
lc_cantid = dw_color.GetItemNumber(1,'cantidad')

if dw_1.rowcount( ) > 0 then
lc_precio = dw_1.GetItemdecimal(1,'cc_precio_total')
end if

lch_modifica  = 'S'
ls_formula = trim(dw_color.getitemstring(1,"codigo"))

if lc_precio = 0 or isnull(lc_precio) then lch_modifica = 'N'
if ls_formula = '' or isnull(ls_formula) then lch_modifica = 'N'

lc_preciounit = lc_precio/lc_cantid
str_prodparam.precio = lc_preciounit
str_prodparam.formula = ls_formula
str_prodparam.medida = ls_presentacion


closewithreturn(parent,lch_modifica)

return


end event

type st_1 from statictext within w_color_preparado
integer x = 46
integer y = 1396
integer width = 1769
integer height = 72
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = " Ingrese la f$$HEX1$$f300$$ENDHEX$$rmula del color preparado que necesita.  Para registrarla emplee CTRL+ENTER"
long bordercolor = 33554431
boolean focusrectangle = false
end type

type dw_color from datawindow within w_color_preparado
event ue_downkey pbm_dwnkey
integer x = 41
integer y = 40
integer width = 5454
integer height = 280
integer taborder = 10
string dataobject = "dw_color_preparado"
boolean livescroll = true
end type

event ue_downkey;if (KeyDown(KeyControl!) and KeyDown(KeyEnter!)) then
	if sw = true then
		pb_ok.triggerevent(clicked!)
		return
	end if
end if

end event

event itemchanged;string ls_nombre, ls_valor, ls_medida, ls_base, ls_simbolo
string ls_null, ls_codant, ls_unimed
decimal{2} ld_null, ld_aux, lc_preciof, lc_litros,ld_preciob
integer li_r, li_g, li_b

dw_color.AcceptText()
//verifica que se trata de una base
If dwo.name = 'codigo' then
sw = true

//Messagebox("is_base",is_base)
//Messagebox("cod_base",str_prodparam.cod_base)

if not isnull(is_base) then
	//halla el factor de c$$HEX1$$e100$$ENDHEX$$lculo para la base
 	select fo_total/4,fo_nombre,fo_cr,fo_cg,fo_cb,it_base
	into :lc_preciof ,:ls_nombre,:li_r,:li_g,:li_b,:ls_base
    from in_formulas  
     where em_codigo = :str_appgeninfo.empresa 
	and  fo_codigo = :data  
     and it_base = :is_base;

	if sqlca. sqlcode <> 0 then
		setnull(ls_null)
		setnull(ld_null)
		//this.SetItem(1,"codigo",ls_null)
		this.SetItem(1,"nombre",ls_null)
		this.SetItem(1,"precio",ld_null)
		dw_color.Object.Color.Brush.Color = rgb(237,235,222)
		beep(1)
		messagebox('Error','No existe c$$HEX1$$f300$$ENDHEX$$digo de color preparado')
		sw = false
		dw_color.SetFocus()
         dw_color.SetColumn('codigo')
		return 
	end if

	if is_base = ls_base then 
		select it_prefab,ub_codigo
   	     into :ld_preciob, :ls_unimed
	     from in_item
	     where em_codigo = :str_appgeninfo.empresa
	     and it_codigo = :is_itcodigo;		
		 if sqlca.sqlcode <> 0 then
			messagebox('Error','No puedo encontrar el c$$HEX1$$f300$$ENDHEX$$digo de la base')			
			return
		end if
		
		select eq_valor
		into :lc_litros
		from in_equivalencia
		where ub_codigo = :ls_unimed
		and ub_codequ = 7;		
		if sqlca.sqlcode <> 0 then
			messagebox('Error','No puedo encontrar la equivalencia')			
			return
		end if
		
		lc_preciof = lc_preciof * lc_litros
	else		
         setnull(ls_null)
		setnull(ld_null)
		//this.SetItem(1,"codigo",ls_null)
		this.SetItem(1,"nombre",ls_null)
		this.SetItem(1,"precio",ld_null)
		beep(1)
		messagebox('Error','El c$$HEX1$$f300$$ENDHEX$$digo no corresponde a la base')
		sw = false
		dw_color.SetFocus()
		dw_color.SetColumn('codigo')
		return 
	end if
	
	ld_preciob = ld_preciob + lc_preciof
	this.SetItem(1,"codigo",data)
	this.SetItem(1,"nombre",ls_nombre)
	this.SetItem(1,"precio",ld_preciob)
	dw_color.Object.Color.Brush.Color = rgb(li_r,li_g,li_b)
else
	setnull(ls_null)
	setnull(ld_null)
	this.SetItem(1,"codigo",ls_null)
	this.SetItem(1,"nombre",ls_null)
	this.SetItem(1,"precio",ld_null)
	beep(1)
	messagebox('Error','El producto no est$$HEX2$$e1002000$$ENDHEX$$definido como base')
	sw = false	
	close (parent)
	w_factura_standard.dw_detail.setfocus()
	return
end if
dw_color.SetFocus()
dw_color.SetColumn('codigo')

end if
end event


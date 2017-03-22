HA$PBExportHeader$w_color_preparado_sif_old.srw
forward
global type w_color_preparado_sif_old from window
end type
type pb_ok from picturebutton within w_color_preparado_sif_old
end type
type pb_1 from picturebutton within w_color_preparado_sif_old
end type
type st_1 from statictext within w_color_preparado_sif_old
end type
type dw_color from datawindow within w_color_preparado_sif_old
end type
end forward

global type w_color_preparado_sif_old from window
integer x = 197
integer y = 680
integer width = 2368
integer height = 612
boolean titlebar = true
string title = "Colores Preparados"
windowtype windowtype = response!
long backcolor = 79741120
pb_ok pb_ok
pb_1 pb_1
st_1 st_1
dw_color dw_color
end type
global w_color_preparado_sif_old w_color_preparado_sif_old

type variables


end variables

on w_color_preparado_sif_old.create
this.pb_ok=create pb_ok
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_color=create dw_color
this.Control[]={this.pb_ok,&
this.pb_1,&
this.st_1,&
this.dw_color}
end on

on w_color_preparado_sif_old.destroy
destroy(this.pb_ok)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_color)
end on

event open;dw_color.insertrow(0)


end event

event key;if KeyDown(KeyControl!) and KeyDown(KeyEnter!) then
		pb_ok.triggerevent(clicked!)
end if

end event

type pb_ok from picturebutton within w_color_preparado_sif_old
integer x = 1934
integer y = 308
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Ok.gif"
end type

event clicked;dec{2} lc_precio
string ls_codigo
char lch_modifica = 'S'

setpointer(hourglass!)
lc_precio = dw_color.getitemdecimal(1,"precio")
ls_codigo = dw_color.getitemstring(1,"codigo")
str_prodparam.precio = lc_precio
str_prodparam.cod_base = ls_codigo
closewithreturn(parent,lch_modifica)


end event

type pb_1 from picturebutton within w_color_preparado_sif_old
event clicked pbm_bnclicked
integer x = 2126
integer y = 308
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
boolean originalsize = true
string picturename = "Imagenes\Cancel.Gif"
end type

event clicked;char lch_modifica = 'N'
closewithreturn(parent,lch_modifica)
end event

type st_1 from statictext within w_color_preparado_sif_old
integer x = 37
integer y = 384
integer width = 1865
integer height = 72
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = " Ingrese la f$$HEX1$$f300$$ENDHEX$$rmula del color preparado y digite ENTER.  Para registrarla emplee CTRL+ENTER"
long bordercolor = 33554431
boolean focusrectangle = false
end type

type dw_color from datawindow within w_color_preparado_sif_old
event ue_downkey pbm_dwnkey
integer x = 37
integer y = 44
integer width = 2263
integer height = 240
integer taborder = 10
string dataobject = "dw_color_preparado"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_downkey;if KeyDown(KeyControl!) and KeyDown(KeyEnter!) then
		pb_ok.triggerevent(clicked!)
end if

end event

event itemchanged;string ls_nombre, ls_medida
string ls_null
string ls_codigo
decimal{2} ld_precio,ld_costo,ld_null,ld_prefab, ld_aux
integer li_r,li_g,li_b

dw_color.AcceptText()
If Right(str_prodparam.nombre, 4) ='CDTR' Then //Si es una base
ls_codigo = dw_color.GetItemString(1,'codigo')
//halla el factor de c$$HEX1$$e100$$ENDHEX$$lculo para la base
SELECT "IN_FORMULAS"."FO_TOTAL","IN_FORMULAS"."FO_NOMBRE","IN_FORMULAS"."FO_CR","IN_FORMULAS"."FO_CG","IN_FORMULAS"."FO_CB"
INTO :ld_costo,:ls_nombre,:li_r,:li_g,:li_b
FROM "IN_FORMULAS"  
WHERE ( "IN_FORMULAS"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
		( "IN_FORMULAS"."FO_CODIGO" = :ls_codigo )   ;

if sqlca.sqlcode <> 0 then
		setnull(ls_null)
		setnull(ld_null)
		this.SetItem(1,"nombre",ls_null)
		this.SetItem(1,"precio",ld_null)
		dw_color.Object.Color.Brush.Color = rgb(192,192,192)
		beep(1)
		messagebox('Error','No existe c$$HEX1$$f300$$ENDHEX$$digo de color de la base')
		dw_color.SetFocus()
          dw_color.SetColumn('codigo')
		return 
end if
if Left(Right(str_prodparam.codant,4),1) = Right(ls_codigo, 1) then
	select it_prefab
	  into :ld_prefab
	  from in_item
	  where em_codigo = :str_appgeninfo.empresa
	  and it_codant = :str_prodparam.codant;		
	if sqlca.sqlcode <> 0 then
		messagebox('Error','No puedo encontrar el c$$HEX1$$f300$$ENDHEX$$digo de la base')			
		return
	end if
else		
	setnull(ls_null)
	setnull(ld_null)
	this.SetItem(1,"nombre",ls_null)
	this.SetItem(1,"precio",ld_null)
	beep(1)
	messagebox('Error','El c$$HEX1$$f300$$ENDHEX$$digo no corresponde a la base')
	dw_color.SetFocus()
	dw_color.SetColumn('codigo')
	return 
end if
	
ls_medida = Right(str_prodparam.codant, 2)
CHOOSE CASE ls_medida
CASE 'CA'
	  ld_aux = ld_costo * 5
CASE 'GL'
	  ld_aux = ld_costo
CASE 'CU'
	  ld_aux = ld_costo* 0.25
END CHOOSE	
	
ld_precio = ld_prefab + ld_aux
this.SetItem(1,"codigo",ls_codigo)
this.SetItem(1,"nombre",ls_nombre)
this.SetItem(1,"precio",ld_precio)
dw_color.Object.Color.Brush.Color = rgb(li_r,li_g,li_b)

dw_color.SetFocus()
dw_color.SetColumn('codigo')
Else
	messagebox('Error','1.- El c$$HEX1$$f300$$ENDHEX$$digo interno del producto no es una base~r~n'+&
	                    '2.- El cursor no esta en el campo ( % Adic. )')
	return
End if
	
end event


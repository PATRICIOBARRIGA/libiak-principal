HA$PBExportHeader$w_color_preparado_sif.srw
forward
global type w_color_preparado_sif from window
end type
type pb_ok from picturebutton within w_color_preparado_sif
end type
type pb_1 from picturebutton within w_color_preparado_sif
end type
type st_1 from statictext within w_color_preparado_sif
end type
type dw_color from datawindow within w_color_preparado_sif
end type
end forward

shared variables

end variables

global type w_color_preparado_sif from window
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
global w_color_preparado_sif w_color_preparado_sif

type variables


end variables

on w_color_preparado_sif.create
this.pb_ok=create pb_ok
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_color=create dw_color
this.Control[]={this.pb_ok,&
this.pb_1,&
this.st_1,&
this.dw_color}
end on

on w_color_preparado_sif.destroy
destroy(this.pb_ok)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_color)
end on

event open;
dw_color.insertrow(0)
dw_color.SetFocus()
dw_color.SetColumn('codigo')



end event

event key;if KeyDown(KeyControl!) and KeyDown(KeyEnter!) then
		pb_ok.triggerevent(clicked!)
end if

end event

type pb_ok from picturebutton within w_color_preparado_sif
integer x = 1934
integer y = 308
integer width = 183
integer height = 160
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
string ls_formula
char lch_modifica = 'S'


setpointer(hourglass!)
lc_precio = dw_color.getitemdecimal(1,"precio")
ls_formula = trim(dw_color.getitemstring(1,"codigo"))
if lc_precio = 0 or isnull(lc_precio) then lch_modifica = 'N'
if ls_formula = '' or isnull(ls_formula) then lch_modifica = 'N'
str_prodparam.precio = lc_precio
str_prodparam.formula = ls_formula
closewithreturn(parent,lch_modifica)
end event

type pb_1 from picturebutton within w_color_preparado_sif
event clicked pbm_bnclicked
integer x = 2126
integer y = 308
integer width = 183
integer height = 160
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

event clicked;closewithreturn(parent,'N')
end event

type st_1 from statictext within w_color_preparado_sif
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

type dw_color from datawindow within w_color_preparado_sif
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

event itemchanged;string ls_nombre, ls_valor, ls_medida, ls_base, ls_simbolo
string ls_null, ls_lastchar, ls_codant, ls_unimed
decimal{2} ld_null, ld_aux, lc_preciof, lc_litros,ld_preciob
integer li_r, li_g, li_b

dw_color.AcceptText()
//verifica que se trata de una base
if not isnull(str_prodparam.cod_base) then
//	halla el factor de c$$HEX1$$e100$$ENDHEX$$lculo para la base
	 select fo_total/4,fo_nombre,fo_cr,fo_cg,fo_cb,it_base
	  into :lc_preciof,:ls_nombre,:li_r,:li_g,:li_b,:ls_base
     from in_formulas  
    where em_codigo = :str_appgeninfo.empresa 
	 and  fo_codigo = :data    
	 and it_base = :str_prodparam.cod_base;
	if sqlca.sqlcode <> 0 then
		setnull(ls_null)
		setnull(ld_null)
		this.SetItem(1,"codigo",ls_null)
		this.SetItem(1,"nombre",ls_null)
		this.SetItem(1,"precio",ld_null)
		dw_color.Object.Color.Brush.Color = rgb(237,235,222)
		beep(1)
		messagebox('Error','No existe c$$HEX1$$f300$$ENDHEX$$digo de color preparado')
		dw_color.SetFocus()
      dw_color.SetColumn('codigo')
		return 
	end if

//	if len(str_prodparam.cod_base) = 1 then
//		ls_lastchar = Right(data, 1)	
//	else
//		ls_lastchar = Right(data, 2)	
//	end if
	if str_prodparam.cod_base = ls_base then 
		select it_prefab,ub_codigo
	     into :ld_preciob, :ls_unimed
	     from in_item
	    where em_codigo = :str_appgeninfo.empresa
	      and it_codigo = :str_prodparam.codant;		
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
		this.SetItem(1,"codigo",ls_null)
		this.SetItem(1,"nombre",ls_null)
		this.SetItem(1,"precio",ld_null)
		beep(1)
		messagebox('Error','El c$$HEX1$$f300$$ENDHEX$$digo no corresponde a la base')
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
	close (parent)
	return
end if
dw_color.SetFocus()
dw_color.SetColumn('codigo')


end event


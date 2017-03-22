HA$PBExportHeader$w_alta_rotacion.srw
$PBExportComments$Vale
forward
global type w_alta_rotacion from window
end type
type st_5 from statictext within w_alta_rotacion
end type
type st_4 from statictext within w_alta_rotacion
end type
type hpb_1 from hprogressbar within w_alta_rotacion
end type
type st_3 from statictext within w_alta_rotacion
end type
type st_2 from statictext within w_alta_rotacion
end type
type sle_2 from singlelineedit within w_alta_rotacion
end type
type dw_2 from datawindow within w_alta_rotacion
end type
type cb_2 from commandbutton within w_alta_rotacion
end type
type dw_1 from datawindow within w_alta_rotacion
end type
type cb_1 from commandbutton within w_alta_rotacion
end type
type em_2 from editmask within w_alta_rotacion
end type
type em_1 from editmask within w_alta_rotacion
end type
end forward

global type w_alta_rotacion from window
integer width = 2341
integer height = 752
boolean titlebar = true
string title = "Productos de alta rotaci$$HEX1$$f300$$ENDHEX$$n"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
st_5 st_5
st_4 st_4
hpb_1 hpb_1
st_3 st_3
st_2 st_2
sle_2 sle_2
dw_2 dw_2
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
em_2 em_2
em_1 em_1
end type
global w_alta_rotacion w_alta_rotacion

type variables
string is_itcodigo
char ich_marca

end variables

forward prototypes
public function decimal wf_costopreparado (ref datastore ads_preparados, integer ai_row)
end prototypes

public function decimal wf_costopreparado (ref datastore ads_preparados, integer ai_row);String    ls_observ,ls_codprep,ls_ticket,ls_nro,&
              ls_nomprep,ls_itcomp
Long     i,j, ll_pos,ll_nreg,ll_nrow,ll_cantot,ll_cantiprep,ll_find
Integer  li_equival
decimal lc_costo,lc_costo_promedio,lc_costocomp

/*Cada vez que ingresa a la funcion se inicializa las variables*/
Setnull(ls_observ)
Setnull(ls_codprep)
Setnull(ls_ticket)
Setnull(ls_nro)

/*Por cada mov 11 recuperamos el ticket y el codigo del preparado*/
ls_observ = dw_1.GetItemString(ai_row,"mv_observ")
ll_pos = pos(ls_observ,' ',17)
ls_nomprep = mid(ls_observ,17,ll_pos - 17)
ll_pos = pos(ls_observ,'.',1)
ls_ticket = mid(ls_observ,ll_pos + 2)
ll_pos  = pos(ls_ticket,'.',1)
ls_nro  = mid(ls_ticket,ll_pos + 2 ) 		

select it_codigo
into: ls_codprep
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codant = :ls_nomprep;



/*Recuperar todo el ticket con los preparados*/
ads_preparados.retrieve(ls_nro,str_appgeninfo.empresa,str_appgeninfo.sucursal)

/*Filtramos solo los preparados encontrados en el movimiento */
ads_preparados.SetFilter("it_codprep = '"+ls_codprep+"'")
ads_preparados.Filter()
ll_nreg = ads_preparados.rowcount()
ll_nrow = dw_2.rowcount()


/*Determinar la equivalencia del preparado*/
select ri_cantid
into :li_equival
from in_relitem
where it_codigo1 = :ls_codprep
and it_codigo = :is_itcodigo;

lc_costocomp = 0
ll_cantot = 0			  
For j = 1 to ll_nreg
	ls_itcomp    = ads_preparados.getitemString(j,"it_codigo")
	ll_cantiprep = ads_preparados.getitemNumber(j,"pr_cantidad")
	/*buscar el costo del componente en d_costo anteriormente ya costeado*/
	ll_find  = dw_2.find("it_codigo = '"+ls_itcomp+"'",1,ll_nrow)
	if ll_find <> 0 then
	lc_costo = 	dw_2.GetItemDecimal(ll_find,"ct_costprom")	
	lc_costocomp = lc_costocomp + (ll_cantiprep * lc_costo)
	If   lc_costo <> 0 Then ll_cantot =   ll_cantot + (ll_cantiprep * li_equival)
	End if
Next
If ll_cantot <> 0 then 
lc_costo = lc_costocomp / ll_cantot
else
lc_costo = 0	
End if					
return lc_costo



end function

on w_alta_rotacion.create
this.st_5=create st_5
this.st_4=create st_4
this.hpb_1=create hpb_1
this.st_3=create st_3
this.st_2=create st_2
this.sle_2=create sle_2
this.dw_2=create dw_2
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.em_2=create em_2
this.em_1=create em_1
this.Control[]={this.st_5,&
this.st_4,&
this.hpb_1,&
this.st_3,&
this.st_2,&
this.sle_2,&
this.dw_2,&
this.cb_2,&
this.dw_1,&
this.cb_1,&
this.em_2,&
this.em_1}
end on

on w_alta_rotacion.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.hpb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.em_2)
destroy(this.em_1)
end on

event open;move(1,1)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)



end event

type st_5 from statictext within w_alta_rotacion
integer x = 1234
integer y = 208
integer width = 192
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_alta_rotacion
integer x = 1234
integer y = 112
integer width = 229
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_alta_rotacion
integer x = 1234
integer y = 468
integer width = 1029
integer height = 40
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_3 from statictext within w_alta_rotacion
integer x = 2030
integer y = 304
integer width = 133
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "min"
boolean focusrectangle = false
end type

type st_2 from statictext within w_alta_rotacion
integer x = 1234
integer y = 304
integer width = 457
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tiempo de proceso"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_alta_rotacion
integer x = 1733
integer y = 300
integer width = 288
integer height = 72
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 81324524
boolean border = false
end type

type dw_2 from datawindow within w_alta_rotacion
boolean visible = false
integer x = 1198
integer y = 648
integer width = 466
integer height = 396
integer taborder = 80
boolean titlebar = true
string dataobject = "d_altarotacion"
boolean hscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_alta_rotacion
boolean visible = false
integer x = 1915
integer y = 136
integer width = 343
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vista"
end type

event clicked;if dw_2.visible = true then
	dw_2.visible = false
else
	dw_2.visible = true
end if
end event

type dw_1 from datawindow within w_alta_rotacion
boolean visible = false
integer x = 18
integer y = 644
integer width = 1147
integer height = 636
integer taborder = 70
string dataobject = "d_kardex_altarotacion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_alta_rotacion
integer x = 1920
integer y = 32
integer width = 343
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ejecutar"
end type

event clicked;long          ll_nreg,i,ll_new,ll_start,ll_used,&
              ll_nreg1,ll_stock_ini,ll_row,ll_sumaceros,ll_stock,ll_mov,ll_count
integer       k
date          ld_fecini,ld_fecfin
decimal       lc_costo_ini,lc_min,lc_seg
datastore     lds_items
integer       li_fileNum
string        ls_itcodant,ls_nombre
dwobject      dwo_cc_sumaceros,dwo_em_codigo,dwo_it_codigo,dwo_it_codant,&
              dwo_it_nombre,dwo_it_precio,dwo_it_costo,dwo_it_cosini,&
				  dwo_it_fecha



Setpointer(hourglass!)

/**/
If messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro que desea procesar?",question!,yesno!,1)= 2 &
Then
Return
End if


dwo_cc_sumaceros = dw_1.Object.cc_sumaceros
dwo_em_codigo = dw_2.Object.em_Codigo
dwo_it_codigo= dw_2.Object.it_Codigo
dwo_it_codant= dw_2.Object.it_codant
dwo_it_nombre= dw_2.Object.it_nombre
dwo_it_precio= dw_2.Object.it_precio
dwo_it_costo = dw_2.Object.it_costo
dwo_it_cosini= dw_2.Object.it_cosini
dwo_it_fecha = dw_2.Object.it_fecha

ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)


/*Verificar si no existen mov con la fecha de finalizaci$$HEX1$$f300$$ENDHEX$$n*/
select count(*)
into :ll_count
from borrar
where trunc(it_fecha) = :ld_fecfin;

If ll_count > 0 Then
if messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya se proces$$HEX2$$f3002000$$ENDHEX$$con esta fecha~r~n"+&
"Desea continuar todas maneras?",Question!,YesNO!,2)=2 &
then
return
end if
End if 

lds_items = create datastore 
lds_items.dataobject = 'd_items_costo'
lds_items.settransobject(sqlca)
ll_nreg = lds_items.retrieve(str_appgeninfo.empresa)

li_fileNum = FileOpen("C:\ROTACION.xls",LineMode!,Write!)


ll_start = Cpu()
hpb_1.maxposition = ll_nreg
hpb_1.Setstep = 1
hpb_1.Position = 0

for k = 1 to ll_nreg
	is_itcodigo = 	lds_items.getitemstring(k,"it_codigo")
	ls_itcodant =  lds_items.getitemstring(k,"it_codant")
	ls_nombre   =  lds_items.getitemstring(k,"it_nombre")
	w_marco.SetMicroHelp('Procesando el item: '+ string(k) + ' de un total de '+string(ll_nreg)+' items. ['+is_itcodigo+']  Espere un momento...')
	
	select it_stock
	into: ll_stock
	from in_itesucur
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and it_codigo = :is_itcodigo;
	
	
	select sum(decode(tm_ioe,'E',mv_cantid,0)) - sum(decode(tm_ioe,'I',mv_cantid,0))
	into:ll_mov
	from in_movim
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and it_codigo = :is_itcodigo
	and trunc(mv_fecha) between :ld_fecini and trunc(sysdate);
	
	ll_stock_ini = ll_stock + ll_mov
	
	/*15. Recuperar Mov del producto*/
	ll_nreg1 = dw_1.retrieve(is_itcodigo,str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fecini,ld_fecfin,ll_stock_ini,lc_costo_ini)
   if ll_nreg1 <> 0 then
	//Cantidades vendidas
	ll_row = dw_1.getrow()
	ll_sumaceros = 0
	ll_sumaceros= dwo_cc_sumaceros.Primary[ll_row]
	if ll_sumaceros > 1 then
		FileWrite(li_fileNum,is_itcodigo+"~t"+ls_itcodant+"~t"+ls_nombre+"~t"+ String(ll_sumaceros) +"~r")
		//cantidades devueltas
		ll_new = dw_2.insertrow(0)
		dwo_em_codigo.primary[ll_new]= str_appgeninfo.empresa
		dwo_it_codigo.primary[ll_new]= is_itcodigo
		dwo_it_codant.primary[ll_new]=ls_itcodant
		dwo_it_nombre.primary[ll_new]=ls_nombre
		dwo_it_precio.primary[ll_new]=ll_sumaceros
		dwo_it_costo.primary[ll_new]= 0
		dwo_it_cosini.primary[ll_new]= 0
		dwo_it_fecha.primary[ll_new]= ld_fecfin
	end if
   end if
/**/
hpb_1.Stepit()
Next

FileClose(li_fileNum)
If dw_2.update() = 1 then
commit;
else
rollback;
return
end if

ll_used = Cpu() - ll_start
lc_min = int(ll_used/60000)
lc_seg =  int(mod(ll_used,60000) / 1000)
sle_2.text = string(lc_min) +'.'+ string(lc_seg)
w_marco.setmicrohelp("Listo....Proceso terminado")
destroy(lds_items)
setpointer(arrow!)
end event

type em_2 from editmask within w_alta_rotacion
integer x = 1472
integer y = 196
integer width = 352
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

event getfocus;ich_marca = 'F'
end event

type em_1 from editmask within w_alta_rotacion
integer x = 1472
integer y = 104
integer width = 352
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

event getfocus;ich_marca = 'I'
end event


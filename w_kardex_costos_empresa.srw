HA$PBExportHeader$w_kardex_costos_empresa.srw
$PBExportComments$Treabajando actualmente
forward
global type w_kardex_costos_empresa from window
end type
type shl_1 from statichyperlink within w_kardex_costos_empresa
end type
type cb_4 from commandbutton within w_kardex_costos_empresa
end type
type cb_1 from commandbutton within w_kardex_costos_empresa
end type
type st_6 from statictext within w_kardex_costos_empresa
end type
type sle_4 from singlelineedit within w_kardex_costos_empresa
end type
type st_5 from statictext within w_kardex_costos_empresa
end type
type sle_3 from singlelineedit within w_kardex_costos_empresa
end type
type cbx_2 from checkbox within w_kardex_costos_empresa
end type
type cbx_1 from checkbox within w_kardex_costos_empresa
end type
type st_prod from statictext within w_kardex_costos_empresa
end type
type sle_1 from singlelineedit within w_kardex_costos_empresa
end type
type cb_3 from commandbutton within w_kardex_costos_empresa
end type
type cb_2 from commandbutton within w_kardex_costos_empresa
end type
type st_4 from statictext within w_kardex_costos_empresa
end type
type st_1 from statictext within w_kardex_costos_empresa
end type
type st_3 from statictext within w_kardex_costos_empresa
end type
type st_2 from statictext within w_kardex_costos_empresa
end type
type sle_2 from singlelineedit within w_kardex_costos_empresa
end type
type em_2 from editmask within w_kardex_costos_empresa
end type
type em_1 from editmask within w_kardex_costos_empresa
end type
type dw_2 from datawindow within w_kardex_costos_empresa
end type
type dw_1 from datawindow within w_kardex_costos_empresa
end type
end forward

global type w_kardex_costos_empresa from window
integer width = 4923
integer height = 2004
boolean titlebar = true
string title = "Costo por empresa...19.07.07"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
shl_1 shl_1
cb_4 cb_4
cb_1 cb_1
st_6 st_6
sle_4 sle_4
st_5 st_5
sle_3 sle_3
cbx_2 cbx_2
cbx_1 cbx_1
st_prod st_prod
sle_1 sle_1
cb_3 cb_3
cb_2 cb_2
st_4 st_4
st_1 st_1
st_3 st_3
st_2 st_2
sle_2 sle_2
em_2 em_2
em_1 em_1
dw_2 dw_2
dw_1 dw_1
end type
global w_kardex_costos_empresa w_kardex_costos_empresa

type variables
string is_itcodigo,is_codant
DataStore ids_movim
end variables

forward prototypes
public function decimal wf_busca_costo (string as_tipo, string as_itcodigo, long al_venumero, date ad_fecfin)
public function decimal wf_costopreparado (ref datastore ads_preparados, integer ai_row, date ad_fcorte)
public function integer wf_actualiza_costo (decimal ac_costo, string as_itcodigo)
public function decimal wf_costopreparado_new (string as_sucursal, string as_ticket, ref datastore ads_preparados, integer ai_row, date ad_fcorte)
public function decimal wf_costo_preparados_empresa (ref datastore ads_preparados, string as_sucursal, string as_seccion, string as_ticket)
public function integer wf_elimina_item (string as_periodo)
end prototypes

public function decimal wf_busca_costo (string as_tipo, string as_itcodigo, long al_venumero, date ad_fecfin);Decimal lc_costo 

select nvl(mv_costo,0)
into :lc_costo
from in_movim 
where tm_codigo = :as_tipo
and it_codigo = :as_itcodigo
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ve_numero = :al_venumero
and trunc(mv_fecha) <= :ad_fecfin;           


return lc_costo
end function

public function decimal wf_costopreparado (ref datastore ads_preparados, integer ai_row, date ad_fcorte);/*No usada*/


String    ls_observ,ls_codprep,ls_ticket,ls_nro,&
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
	
	select distinct mv_costo
	into :lc_costo
	from in_movim 
	where tm_codigo = '10'
	and em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and it_codigo = :ls_itcomp
	and ve_numero = :ls_nro
	and trunc(mv_fecha) <= :ad_fcorte;
	
	
	lc_costocomp = lc_costocomp + (ll_cantiprep * lc_costo)
	If lc_costo <> 0 Then 
		ll_cantot =   ll_cantot + (ll_cantiprep * li_equival)
	End if
Next

If ll_cantot <> 0 then 
lc_costo = lc_costocomp / ll_cantot
else
lc_costo = 0	
End if					
return lc_costo



end function

public function integer wf_actualiza_costo (decimal ac_costo, string as_itcodigo);UPDATE IN_ITEM
SET IT_COSINI = :ac_costo
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND IT_CODIGO = :as_itcodigo;

If sqlca.sqlcode < 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el costo "+sqlca.sqlerrtext)
rollback;
return -1
End if 

return 1
end function

public function decimal wf_costopreparado_new (string as_sucursal, string as_ticket, ref datastore ads_preparados, integer ai_row, date ad_fcorte);
String    ls_itcomp,ls_itcodprep
Long      i,j,ll_nreg,ll_cantot,ll_cantiprep,al_ticket
Integer   li_equival
decimal   lc_costo,lc_costocomp


/*Por cada mov 11 recuperamos el ticket y el codigo del preparado*/
/*Recuperar todo el ticket con los preparados*/

al_ticket = long(as_ticket) 


ads_preparados.retrieve(as_ticket,str_appgeninfo.empresa,as_sucursal,is_itcodigo)
ll_nreg = ads_preparados.rowcount()
lc_costocomp = 0
ll_cantot = 0			  

For j = 1 to ll_nreg
		
	ls_itcomp    = ads_preparados.getitemString(j,"it_codigo")
	ls_itcodprep = ads_preparados.getitemString(j,"it_codprep")
	ll_cantiprep = ads_preparados.getitemNumber(j,"pr_cantidad")
	
	/*Determinar la equivalencia del preparado*/
	select ri_cantid
	into :li_equival
	from in_relitem
	where it_codigo1 = :ls_itcodprep
	and it_codigo = :is_itcodigo;
			
	/*buscar el costo del componente en d_costo anteriormente ya costeado*/
	select distinct mv_costo
	into :lc_costo
	from in_movim 
	where tm_codigo = '10'
	and em_codigo = :str_appgeninfo.empresa
	and su_codigo = :as_sucursal
	and it_codigo = :ls_itcomp
	and ve_numero = :al_ticket
	and trunc(mv_fecha) <= :ad_fcorte;
	
	
   if lc_costo = 0 then
		SELECT IT_COSINI
		INTO :lc_costo
		FROM IN_ITEM
		WHERE EM_CODIGO = :str_appgeninfo.empresa
		AND IT_CODIGO = :ls_itcomp;
	end if

	lc_costocomp = lc_costocomp + (ll_cantiprep * lc_costo)
	If lc_costo <> 0 Then 
		ll_cantot = ll_cantot + (ll_cantiprep * li_equival)
	End if
	
Next

If ll_cantot <> 0 then 
lc_costo = lc_costocomp / ll_cantot
else
lc_costo = 0	
End if					
return lc_costo



end function

public function decimal wf_costo_preparados_empresa (ref datastore ads_preparados, string as_sucursal, string as_seccion, string as_ticket);
String    ls_itcomp,ls_itcodprep
Long      i,j,ll_nreg,ll_cantot,ll_cantiprep,al_ticket
Integer   li_equival
decimal   lc_costo,lc_costocomp


/*Por cada mov 11 recuperamos el ticket y el codigo del preparado*/
/*Recuperar todo el ticket con los preparados*/

al_ticket = long(as_ticket) 


ads_preparados.retrieve(str_appgeninfo.empresa,as_sucursal,as_seccion,as_ticket,is_itcodigo)
//ads_preparados.Setfilter("in_relitem_it_codigo = '"+is_itcodigo+"'")
//ads_preparados.Filter()
lc_costocomp = 0
ll_cantot = 0			  
if ads_preparados.Rowcount() > 0 then 
lc_costocomp = ads_preparados.Object.cc_costocomp[1]
else
lc_costocomp = 0	
end if
return lc_costocomp



end function

public function integer wf_elimina_item (string as_periodo);/*Para volver a realizar el costeo con ajuste*/
/*Eliminamos de la tabla 	IN_COSTO los items que van a volver a ser costeados;
 se utliza cuando se va a realizar un ajuste al calculo del costeo original*/

/*Si se va a actualizar el costos del item seleccionado*/
If cbx_2.checked and cbx_1.checked then
DELETE FROM IN_COSTO
WHERE IT_CODIGO = :is_itcodigo
AND TO_CHAR(CT_FECHA,'mmyyyy') = :as_periodo;
end if

/*Si se va a actualizar los costos de TODOS los items*/
If cbx_2.checked and not cbx_1.checked  then
DELETE FROM IN_COSTO
WHERE TO_CHAR(CT_FECHA,'mmyyyy') = :as_periodo;
End if

If sqlca.sqlcode < 0 then
rollback;
return -1
end if

COMMIT;
RETURN 1
end function

on w_kardex_costos_empresa.create
this.shl_1=create shl_1
this.cb_4=create cb_4
this.cb_1=create cb_1
this.st_6=create st_6
this.sle_4=create sle_4
this.st_5=create st_5
this.sle_3=create sle_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.st_prod=create st_prod
this.sle_1=create sle_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.st_4=create st_4
this.st_1=create st_1
this.st_3=create st_3
this.st_2=create st_2
this.sle_2=create sle_2
this.em_2=create em_2
this.em_1=create em_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.shl_1,&
this.cb_4,&
this.cb_1,&
this.st_6,&
this.sle_4,&
this.st_5,&
this.sle_3,&
this.cbx_2,&
this.cbx_1,&
this.st_prod,&
this.sle_1,&
this.cb_3,&
this.cb_2,&
this.st_4,&
this.st_1,&
this.st_3,&
this.st_2,&
this.sle_2,&
this.em_2,&
this.em_1,&
this.dw_2,&
this.dw_1}
end on

on w_kardex_costos_empresa.destroy
destroy(this.shl_1)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.sle_4)
destroy(this.st_5)
destroy(this.sle_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.st_prod)
destroy(this.sle_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

//ids_movim = Create DataStore 
//ids_movim.DataObject = 'kardex_por_empresa'
//ids_movim.SetTr1ansObject(sqlca)
em_1.text = string(today(),'dd/mm/yyyy')
em_2.text = string(today(),'dd/mm/yyyy')


end event

event resize;/*Redimensionar los datawindows cuando la ventana se redimensiona*/

int li_width, li_height,li_wdetail, li_wcruce, li_df,  li_hm

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

li_hm = dw_1.height

dw_1.resize(li_width - 50,li_height - 250)

return 1
end event

type shl_1 from statichyperlink within w_kardex_costos_empresa
integer x = 4215
integer y = 84
integer width = 567
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Ver items con costo cero"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_kardex_costos_empresa
integer x = 3607
integer y = 156
integer width = 343
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordenar"
end type

event clicked;String ls_nulo
setnull(ls_nulo)
dw_1.SetSort(ls_nulo)
dw_1.Sort()
end event

type cb_1 from commandbutton within w_kardex_costos_empresa
integer x = 3607
integer y = 44
integer width = 338
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtrar"
end type

event clicked;String ls_nulo
setnull(ls_nulo)

dw_1.Setfilter(ls_nulo)
dw_1.filter()
end event

type st_6 from statictext within w_kardex_costos_empresa
integer x = 2834
integer y = 168
integer width = 270
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Costo Inicial"
boolean focusrectangle = false
end type

type sle_4 from singlelineedit within w_kardex_costos_empresa
integer x = 3131
integer y = 148
integer width = 265
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_kardex_costos_empresa
integer x = 2126
integer y = 168
integer width = 453
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ajustar Stock Inicial:"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_kardex_costos_empresa
integer x = 2578
integer y = 152
integer width = 197
integer height = 72
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_2 from checkbox within w_kardex_costos_empresa
integer x = 1618
integer y = 160
integer width = 480
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Actualizar Costo"
boolean checked = true
end type

type cbx_1 from checkbox within w_kardex_costos_empresa
integer x = 41
integer y = 156
integer width = 631
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Kardex por C$$HEX1$$f300$$ENDHEX$$digo"
boolean lefttext = true
end type

event clicked;If cbx_1.checked Then
st_prod.visible = true
sle_1.visible = true
Else
st_prod.visible = false
sle_1.visible = false
End if
end event

type st_prod from statictext within w_kardex_costos_empresa
boolean visible = false
integer x = 768
integer y = 164
integer width = 238
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Producto:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_kardex_costos_empresa
boolean visible = false
integer x = 1024
integer y = 156
integer width = 507
integer height = 76
integer taborder = 70
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

type cb_3 from commandbutton within w_kardex_costos_empresa
integer x = 2117
integer y = 40
integer width = 343
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ejecutar"
end type

event clicked;/*Proceso que realiza el costeo de productos que no KIT*/
decimal  lc_costotal,&
              lc_costpos,&
			  lc_costfact,&
                 lc_devalpos,&
			  lc_min,&
			  lc_seg,&
                 lc_devalfact,lc_ventaneta,lc_costoventas,&
			  lc_costprom,lc_costo_ini,&
			  lc_costexist,lc_equivale,&                          
			  lc_costop,lc_valunit
 decimal{4} lc_costo
long         ll_find,ll_cantpos,ll_cantfact,&
                 ll_devpos,ll_devfact,ll_stock,&
			  ll_row,k,ll_stock_ini,ll_nreg1,&
                 ll_nreg,i,ll_new,ll_n,&
			  ll_start,ll_used,ll_venumero,&
			  ll_count, ll_numrecep,ll_ajuste
integer      li_equival,li_year,li_mes
string        ls_tmcodigo,ls_criterio,ls_codant,ls_ticket,ls_atomo,ls_sucursal,ls_seccion,ls_periodo,ls_item,&
                ls_tmioe,ls_mvnumero,ls_itcodigo, ls_anio, ls_anio4, ls_mes, ls_dia, ls_periodo2
date          ld_fcorte,ld_ini,ld_fin
date          ld_fecini,ld_fecfin
boolean     lb_atomo,lb_entro

datastore lds_preparados,lds_items


Setpointer(hourglass!)

dw_1.AcceptText()

ld_fecini  = date(em_1.text)
ld_fecfin  = date(em_2.text)             

ls_anio = mid(string(ld_fecini),9,2)
ls_mes = mid(string(ld_fecini),4,2)

li_year    = year(date(ld_fecini))
li_mes    = Month(date(ld_fecini))
ll_ajuste  = Long(sle_3.text)

ls_periodo = string(li_mes)+string(li_year)
ls_periodo2 = ls_mes + ls_anio 


lds_items = create datastore 
/*Para procesar todos los productos*/
If not cbx_1.checked  then
  lds_items.dataobject = 'd_lista_items' /*Uno motor*/
  
//  lds_items.dataobject = 'd_items_para_costeo' /*Trecx*/
   // lds_items.dataobject = 'd_items_restantes' /*Trecx*/
//	lds_items.dataobject = 'd_items'
//      lds_items.dataobject = 'd_items_x_arreglar_costo' /*Trecx*/
      lds_items.settransobject(sqlca)
//    ll_nreg = lds_items.retrieve('0107')
//ll_nreg = lds_items.retrieve(ls_periodo2)
    ll_nreg = lds_items.retrieve(str_appgeninfo.empresa)
else   // Para costear de acuerdo al codigo del item ingresado por el usuario
    lds_items.dataobject = 'd_items_costo_prod'
    lds_items.settransobject(sqlca)
    ls_codant = sle_1.text 
   ll_nreg = lds_items.retrieve(str_appgeninfo.empresa,ls_codant)
End if


/*Para almacenar los tickets en los que se encuentran los preparados*/
lds_preparados = Create Datastore
lds_preparados.DataObject = "d_costo_componentes_preparados"
lds_preparados.SetTransObject(sqlca)

ll_start = Cpu()


/*Por cada item recuperar movimientos y costear*/
for k = 1 to ll_nreg
lc_ventaneta    = 0
lc_costoventas = 0
lc_costprom    = 0
ll_cantpos       = 0
ll_cantfact       = 0
lc_costpos       = 0
lc_costfact       = 0
ll_devpos        = 0
lc_devalpos     = 0
ll_devfact        = 0
lc_devalfact    = 0
ll_stock          = 0
lc_costexist    = 0
lc_costo_ini    = 0
ll_stock_ini     = 0 
lc_costop       = 0
lc_costo         = 0

is_itcodigo = ""
is_itcodigo = 	lds_items.getitemstring(k,"it_codigo")
is_codant   = 	lds_items.getitemstring(k,"it_codant")


////borrar in costo
if cbx_2.checked then
     	//if cbx_1.checked = false then 	is_itcodigo = '%'
	    string ls_fecdel
		ls_fecdel = mid(string(ld_fecini),4)
			delete from in_costo
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = '90'
			and it_codigo like :is_itcodigo
			and to_char(ct_fecha,'mm/yyyy') = :ls_fecdel ;
			if sqlca.sqlcode <> 0 then
				messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Problemas al anular in_costo ' +sqlca.sqlerrtext, Exclamation! )	
				rollback;
				return	
		   end if
end if


w_marco.SetMicroHelp('Procesando el item: '+ string(k) + ' de un total de '+string(ll_nreg)+' items. ['+is_itcodigo+']      Cod: ['+is_codant+']     Espere un momento...')

/*1.- Determinar el stock_inicial y el costo inicial*/
//ls_periodo = string(li_mes - 1,'00')+string(li_year)
//If  li_mes = 0210 then 
    
	 /*Todo el a$$HEX1$$f100$$ENDHEX$$o*/
	ls_periodo = string(li_mes,'00')+string(li_year)

//	select nvl(IT_STKINI,0),nvl(IT_COSINI,0)
//	into :ll_stock_ini,:lc_costo_ini
//	from  IN_ITEEMP
//	where EM_CODIGO = :str_appgeninfo.empresa
//	and IT_CODIGO =:is_itcodigo
//	and TO_CHAR(IT_FECHA,'mmyyyy') = :ls_periodo ;

//    /*Mes a mes*/
//	ls_periodo = string(li_mes,'00')+string(li_year)
//	select nvl(IT_STKINI,0),nvl(IT_COSINI,0)
//	into :ll_stock_ini,:lc_costo_ini
//	from  IN_ITEMOV
//	where EM_CODIGO = :str_appgeninfo.empresa
//	and IT_CODIGO =:is_itcodigo
//	and TO_CHAR(IT_FECHA,'mmyyyy') = :ls_periodo ;
/****************/

/*Determinar el saldo inicial anterior al per$$HEX1$$ed00$$ENDHEX$$odo que se est$$HEX2$$e1002000$$ENDHEX$$costeando*/
ll_stock_ini = f_inv_saldomov(is_itcodigo,date('01-jan-2000'),ld_fecini)
if isnull(ll_stock_ini) then ll_stock_ini = 0

lc_costo_ini = f_ultimo_costprom(is_itcodigo,ld_fecini)
if isnull(lc_costo_ini) then lc_costo_ini = 0


/*Desde aqui para UNOMOTOR*/
If     lc_costo_ini <= 0 then 
	  select nvl(it_cosini,0)
	  into :lc_costo_ini  
	  from in_item
	  where em_codigo = :str_appgeninfo.empresa
	  and it_codigo = :is_itcodigo;
end if

/*****************************************************************************/



/*Si existe algun ajuste en la cantidad */
if ll_ajuste > 0 then
ll_stock_ini = ll_ajuste
end if

if Dec(sle_4.text) > 0 then
lc_costo_ini = Dec(sle_4.text)
end if

/*15. Recuperar Mov del producto por empresa*/

ll_nreg1 = dw_1.retrieve(is_itcodigo,ld_fecini,ld_fecfin,ll_stock_ini,lc_costo_ini)
setpointer(hourglass!)
w_marco.SetMicroHelp('Listo...Total de movimientos para costear '+string(ll_nreg1))


/*Inicia el recorrido por la tabla de mov realizando el costeo*/
for i = 1 to ll_nreg1
     	w_marco.SetMicroHelp('Movimiento  '+string(i) +'  de '+string(ll_nreg1) )
		ls_sucursal  =  dw_1.Object.su_codigo[i]
		ls_seccion    =  dw_1.Object.bo_codigo[i]
		ls_tmcodigo =  dw_1.Object.tm_codigo[i]
		ls_tmioe       =  dw_1.Object.tm_ioe[i]
		ls_mvnumero = dw_1.Object.mv_numero[i]
		ll_venumero   =  dw_1.Object.ve_numero[i]
		
		ls_ticket   =  string(ll_venumero)
		lc_costo = 0
				
		CHOOSE CASE ls_tmcodigo

         CASE '1' // Mov 1.Ingreso por compra; buscar costo  en la factura de compra
				lc_costo = f_costocompra(ls_sucursal,ll_venumero,is_itcodigo)

         CASE '5' //Mov.5 Devolucion de venta; Buscar el mov.2 Factura de venta
				ls_criterio = "ve_numero = "+string(ll_venumero)+" and tm_codigo = '2' and su_codigo ='"+ls_sucursal+"'"
				ll_find = dw_1.find(ls_criterio,1,ll_nreg1)
				If ll_find <> 0 Then  
					lc_costo = dw_1.Object.cc_valunit[ll_find]
				else	/*Buscar en todo el Kardex del producto previamente costeado*/
					   /*Tomar el costo con el que se hizo la venta */
					select mv_costo
					into :lc_costo
					from in_movim 
					where tm_codigo = '2'
					and tm_ioe ='E'
					and em_codigo = '1'
					and su_codigo = :ls_sucursal
					and it_codigo = :is_itcodigo
					and ve_numero = :ll_venumero
					and mv_fecha <= :ld_fecfin;                                         	
				end if
			CASE '6'	//Mov.6  Devolucion de compra; Buscar el mov. 1 factura de compra
				/*Buscar el nro de recepcion de la factura de compra*/
				SELECT CO_NUMPAD
				INTO :ll_numrecep
			     FROM IN_COMPRA
				WHERE EC_CODIGO = '3'
				AND EM_CODIGO  = '1'
				AND SU_CODIGO  = :ls_sucursal
				AND CO_NUMERO = :ll_venumero;
				
				/*Con el nro de recepcion buscar el costo de la compra*/
				lc_costo = f_costocompra(ls_sucursal,ll_numrecep,is_itcodigo)
		CASE '11' //Mov. 11 Ingreso por preparados; Buscar preparados  
				lc_costo = wf_costo_preparados_empresa(lds_preparados,ls_sucursal,ls_seccion,ls_ticket)
         CASE ELSE
				if  i = 1 then /* tomar valor_inicial cuando no se enconttro el costo, y es el primer movimiento*/
				lc_costo = lc_costo_ini
			   else           /* tomar costo anterior cuando no se enconttro el costo, y no es el primer movimiento*/
				lc_costo = dw_1.Object.cc_costop2[i - 1]
			   end if
		END CHOOSE
				
		// Si el costo es cero tomar el ultimo costo 	
			if lc_costo = 0 then 
				SELECT NVL(IT_COSINI,0)
				INTO :lc_costo
				FROM IN_ITEM
				WHERE EM_CODIGO = :str_appgeninfo.empresa
				AND IT_CODIGO = :is_itcodigo;
			end if	
			
			if isnull(lc_costo) then lc_costo = 0
			if lc_costo <= 0 then 
			if i <> 1 then 	lc_costo = dw_1.Object.cc_costop2[i - 1]
 		     end if 
			dw_1.Object.cc_valunit[i] = lc_costo

next		
		

 //Actualizamos la columna mv_costo del kardex con el promedio
 //Para buscar el costo con del movimiento que origino su movimiento pareja
 //Ej. La devoluci$$HEX1$$f300$$ENDHEX$$n de una factura tiene que buscar la venta. 
   
	
 /*Hasta aqui va */

dw_1.groupcalc()
dw_1.AcceptText()

if dw_1.rowcount() > 0 then
dw_1.object.mv_costprom.primary = dw_1.object.cc_costop2.primary /*Actualiza el costo promedio en el kardex*/
dw_1.Object.mv_costtrans.primary = dw_1.Object.cc_valunit.primary /*Actualiza el costo de transaccion para efecto de reportes*/
end if


/*Inicia la grabaci$$HEX1$$f300$$ENDHEX$$n*/
/*Grabar el dw que actualiza el costo por producto*/
lc_ventaneta   = 0
lc_costoventas = 0
lc_costprom    = 0
ll_cantpos     = 0
ll_cantfact    = 0
lc_costpos     = 0
lc_costfact    = 0
ll_devpos      = 0
lc_devalpos    = 0
ll_devfact     = 0
lc_devalfact   = 0
ll_stock       = 0
lc_costexist   = 0
lc_costop      = 0
		
if dw_1.rowcount() > 0 then		
ll_cantpos = dw_1.Object.cc_cantpos[1]
ll_cantfact = dw_1.Object.cc_cantfact[1]

//cantidades devueltas
ll_devpos= dw_1.Object.cc_devpos[1]
ll_devfact = dw_1.Object.cc_devfact[1]

//costo ventas valorado
lc_costpos = dw_1.Object.cc_costpos[1]
lc_costfact = dw_1.Object.cc_costfact[1]

//costo devoluciones valorado
lc_devalpos = dw_1.Object.cc_devalpos[1]
lc_devalfact = dw_1.Object.cc_devalfact[1]

//ventas y costos totales
lc_ventaneta = dw_1.Object.cc_ventaneta[1]
lc_costoventas = dw_1.Object.cc_costoventas[1]
lc_costprom = dw_1.Object.cc_costprom[1]

//stock y costo promedio de existencias que quedan para costear el siguiente mes
ll_stock = dw_1.Object.saldo_unit[ll_nreg1]
lc_costexist = dw_1.Object.cc_costop2[ll_nreg1]
end if



/*Registramos en la tabla IN_COSTO SOLO SI VAMOS A ACTUALIZAR EL COSTO*/
ls_periodo2 = mid(string(ld_fecini),1,6) + mid(string(ld_fecini),9,2)
If cbx_2.checked then
		
	If ll_nreg1 > 0 then 
	ll_new = dw_2.insertrow(0)
	dw_2.setitem(ll_new,"em_codigo",str_appgeninfo.empresa)
	dw_2.setitem(ll_new,"su_codigo",'90')   /*Guardamos con  el c$$HEX1$$f300$$ENDHEX$$digo 90 toda la empresa*/
	dw_2.setitem(ll_new,"it_codigo",is_itcodigo)
	dw_2.setitem(ll_new,"ct_fecha",date(ls_periodo2)) /**/
	dw_2.setitem(ll_new,"ct_cantvend",lc_ventaneta)
	dw_2.setitem(ll_new,"ct_costvend",lc_costoventas)
	dw_2.setitem(ll_new,"ct_costprom",lc_costprom)  /*costo promedio de ventas*/
	dw_2.setitem(ll_new,"ct_cantpos",ll_cantpos)
	dw_2.setitem(ll_new,"ct_cantfact",ll_cantfact)
	dw_2.setitem(ll_new,"ct_costpos",lc_costpos)
	dw_2.setitem(ll_new,"ct_costfact",lc_costfact)
	dw_2.setitem(ll_new,"ct_devpos",ll_devpos)
	dw_2.setitem(ll_new,"ct_devalpos",lc_devalpos)
	dw_2.setitem(ll_new,"ct_devfact",ll_devfact)
	dw_2.setitem(ll_new,"ct_devalfact",lc_devalfact)
	dw_2.setitem(ll_new,"ct_stock",ll_stock)
	dw_2.setitem(ll_new,"ct_costpromexist",lc_costexist)
else /*No hay movimientos del producto que estamos costeando*/
	ll_new = dw_2.insertrow(0)
	dw_2.setitem(ll_new,"em_codigo",str_appgeninfo.empresa)
	dw_2.setitem(ll_new,"su_codigo",'90')
	dw_2.setitem(ll_new,"it_codigo",is_itcodigo)
	dw_2.setitem(ll_new,"ct_fecha",date(ls_periodo2))
	dw_2.setitem(ll_new,"ct_cantvend",0)
	dw_2.setitem(ll_new,"ct_costvend",0)
	dw_2.setitem(ll_new,"ct_costprom",lc_costo_ini)
	dw_2.setitem(ll_new,"ct_cantpos",0)
	dw_2.setitem(ll_new,"ct_cantfact",0)
	dw_2.setitem(ll_new,"ct_costpos",0)
	dw_2.setitem(ll_new,"ct_costfact",0)
	dw_2.setitem(ll_new,"ct_devpos",0)
	dw_2.setitem(ll_new,"ct_devalpos",0)
	dw_2.setitem(ll_new,"ct_devfact",0)
	dw_2.setitem(ll_new,"ct_devalfact",0)
	dw_2.setitem(ll_new,"ct_stock",ll_stock_ini)
	dw_2.setitem(ll_new,"ct_costpromexist",lc_costo_ini)	  
	End if
	
	w_marco.SetMicroHelp('Actualizando  ' +string(ll_nreg1)+ ' movimientos ...por favor espere.' )
	If dw_1.update() = 1 then
	commit;	
	else	
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el costo del  item " +sqlca.sqlerrtext)	
	rollback; 
	return
	end if
   /**/
 	If dw_2.update() = 1 then
	commit;
	else
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el costo del producto " +sqlca.sqlerrtext)
	rollback;
	return
	end if
	 
 	/*Actualizamos IN_ITEM para poder iniciar el proximo ciclo de costeo con los datos del periodo anteriormente costeado*/
	/*En el caso de no tener movimientos se mantienen los datos del ultimo costeo*/	 
	if ll_nreg1 > 0 then
			update in_item
			set it_stkini = :ll_stock,
			      it_cosini = :lc_costexist,
				 it_costprom = :lc_costexist	
			where it_codigo = :is_itcodigo;
			
			if sqlca.sqlcode <> 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha actualizado IN_ITEM  " +sqlca.sqlerrtext)
			rollback;
			return
			end if
			commit;
      end if
End if

Next

/*Para UNOMOTOR COMENTAR*/

ll_used = Cpu() - ll_start
lc_min = int(ll_used/60000)
lc_seg =  int(mod(ll_used,60000) / 1000)
sle_2.text = string(lc_min) +'.'+ string(lc_seg)
w_marco.setmicrohelp("Proceso de costeo terminado")
destroy(lds_items)
destroy(lds_preparados)
setpointer(arrow!)
end event

type cb_2 from commandbutton within w_kardex_costos_empresa
integer x = 1618
integer y = 40
integer width = 475
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ver Costo Mensual"
end type

event clicked;if dw_2.visible = true then 
	dw_2.visible = false
else
	dw_2.visible = true
end if 	
end event

type st_4 from statictext within w_kardex_costos_empresa
integer x = 850
integer y = 48
integer width = 238
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Fin:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_kardex_costos_empresa
integer x = 37
integer y = 48
integer width = 279
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicio:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_kardex_costos_empresa
integer x = 3419
integer y = 48
integer width = 101
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

type st_2 from statictext within w_kardex_costos_empresa
integer x = 2606
integer y = 48
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
string text = "Tiempo de proceso:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_kardex_costos_empresa
integer x = 3131
integer y = 40
integer width = 256
integer height = 72
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean border = false
end type

type em_2 from editmask within w_kardex_costos_empresa
integer x = 1106
integer y = 40
integer width = 352
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_1 from editmask within w_kardex_costos_empresa
integer x = 357
integer y = 40
integer width = 357
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type dw_2 from datawindow within w_kardex_costos_empresa
boolean visible = false
integer y = 720
integer width = 4064
integer height = 1152
integer taborder = 70
boolean titlebar = true
string dataobject = "d_costo_mes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

type dw_1 from datawindow within w_kardex_costos_empresa
integer x = 9
integer y = 276
integer width = 4046
integer height = 1608
integer taborder = 60
string dataobject = "d_kardex_costo_empresa_old"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type


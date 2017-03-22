HA$PBExportHeader$w_orden_compra.srw
$PBExportComments$Si.ORDENES DE COMPRA
forward
global type w_orden_compra from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_orden_compra
end type
type st_1 from statictext within w_orden_compra
end type
end forward

global type w_orden_compra from w_sheet_master_detail
integer x = 5
integer y = 392
integer width = 2939
integer height = 1520
string title = "Orden de Compra"
long backcolor = 79741120
event ue_consultar pbm_custom15
event type long ue_saveas ( )
dw_ubica dw_ubica
st_1 st_1
end type
global w_orden_compra w_orden_compra

type variables
decimal ic_iva
long ii_excento_iva
string  is_mensaje, is_estado='1'
datawindowchild idwc_plista
end variables

forward prototypes
public function integer wf_preprint ()
public function integer wf_actualiza_suma ()
end prototypes

event ue_consultar;call super::ue_consultar;dw_master.postevent(DoubleClicked!)
end event

event ue_saveas;return dw_report.saveas()
end event

public function integer wf_preprint ();dataWindowChild ldwc_aux
string ls_provee
long ll_filActMaestro
long ll_co_numero

dw_report.SetTransObject(sqlca)
ll_filActMaestro = dw_master.getRow()
ls_provee = dw_master.getItemString(ll_filActMaestro, "pv_codigo")
ll_co_numero = dw_master.getItemNumber(ll_filActMaestro, "co_numero")

dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
                   is_estado, ll_co_numero,ls_provee)
				
return 1

end function

public function integer wf_actualiza_suma ();// actualiza en el  maestro los valores del iva y total

long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
decimal ll_valortot,ll_valor,ll_costo,ll_valorsum,ld_area, ll_ivavalor, lc_transporte
decimal ll_subtot,ll_suma, ld_canti,ll_suma1, lc_newprecio, lc_indice
decimal lc_precio, lc_costo, lc_factor
string ls, ls_prove

ll_filActMaster = dw_master.GetRow()
ls_prove = dw_master.GetItemString(ll_filActMaster,'pv_codigo')

select pv_caract
into :ls
from in_prove
 where em_codigo = :str_appgeninfo.empresa
and pv_codigo = :ls_prove;
	
// controla si paga IVA o no
if ls = 'S' then
	ii_excento_iva = 0
else
	Select pr_valor
	into :ic_iva
	from pr_param
      where em_codigo = :str_appgeninfo.empresa
	and pr_nombre = 'IVA';
	ii_excento_iva = 1
end if

//inicializo la fila actual
if dw_detail.AcceptText() <> 1 then return -1

	ll_totFilas = dw_detail.rowCount()
	for ll_fila = 1 to ll_totFilas
  	    ll_valorsum += dw_detail.GetItemDecimal(ll_fila,"cc_total")
	next
	dw_master.setItem(ll_filActMaster,"co_subtot",ll_valorsum)

// actualiza los campos Total, Iva y Saldo en el maestro

 	lc_transporte  =dw_master.GetItemDecimal(ll_filActMaster,"co_transpor")
 	if isnull(lc_transporte) then
		 lc_transporte = 0
 	end if
 	ll_suma1=dw_master.GetItemDecimal(ll_filActMaster,"co_subtot")
 	ll_subtot= ll_suma1 - (ll_suma1*dw_master.GetItemDecimal(ll_filActMaster,"co_descup"))

	ll_ivavalor= round(ll_subtot*ic_iva,2)*ii_excento_iva
 	dw_master.SetItem(ll_filActMaster,"co_iva",ll_ivavalor)
 	dw_master.SetItem(ll_filActMaster,"co_total",ll_subtot + ll_ivavalor + lc_transporte)
return 1
end function

on w_orden_compra.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.st_1
end on

on w_orden_compra.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.st_1)
end on

event open;string ls_parametro[]
datawindowchild ldwc_fp

f_recupera_empresa(dw_master,"pv_codigo") 
f_recupera_empresa(dw_master,"fp_codigo") 
dw_master.getChild("fp_codigo", ldwc_fp)
ldwc_fp.setTransObject(sqlca)
ldwc_fp.retrieve(str_appgeninfo.empresa)
ldwc_fp.setfilter("fp_string like '%C%'")
ldwc_fp.filter()
/*Recupera los precios de lista de los proveedores del item*/

dw_detail.Getchild("dc_costo",idwc_plista)
idwc_plista.SetTransObject(sqlca)
idwc_plista.retrieve('x')


istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = is_estado

call super::open
dw_master.is_SerialCodeColumn = "co_numero"
dw_master.is_SerialCodeType = "NUM_ORD"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//dw_detail.is_serialCodeDetail = "dc_secue"

dw_master.ii_nrCols = 4
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "ec_codigo"
dw_master.is_connectionCols[4] = "co_numero"
dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "ec_codigo"
dw_detail.is_connectionCols[4] = "co_numero"
dw_detail.uf_setArgTypes()


//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()
dw_master.setFocus()
dw_master.uf_insertCurrentRow()
dw_detail.setrowfocusindicator(hand!)
end event

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()
end event

event ue_retrieve;return 1
end event

type dw_master from w_sheet_master_detail`dw_master within w_orden_compra
event ue_nextfield pbm_dwnprocessenter
integer x = 0
integer y = 0
integer width = 2903
integer height = 660
string dataobject = "d_orden_compra"
end type

event dw_master::ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event

event dw_master::itemchanged;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n : 
//
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 22/05/2000  
/*********************************************************************/

long    ll_numero
decimal lc_ivavalor,lc_valor,lc_subtot, lc_descup, lc_transporte
string  ls, ls_prove,ls_ruc,ls_fpcodigo


CHOOSE CASE dwo.name

CASE "co_descup"

	lc_descup = dec(this.gettext())/100
	lc_transporte  = this.GetItemNumber(row,"co_transpor")
	lc_subtot = this.GetItemNUmber(row,"co_subtot")
	
	// actualiza los campos Total, Iva y Saldo
	lc_valor = lc_subtot - (lc_subtot*lc_descup)
	lc_ivavalor = round(lc_valor * ic_iva,2) * ii_excento_iva
	this.SetItem(row,"co_iva",lc_ivavalor)
	this.SetItem(row,"co_total",lc_valor + lc_ivavalor + lc_transporte)
	
CASE "co_transpor"
	
	lc_transporte = dec(this.gettext())
	lc_descup = this.GetItemNUmber(row,"co_descup")
	lc_subtot = this.GetItemNUmber(row,"co_subtot")
	
	// actualiza los campos Total, Iva y Saldo
	lc_valor= lc_subtot - (lc_subtot*lc_descup)
	lc_ivavalor= round(lc_valor*ic_iva,0)*ii_excento_iva
	this.SetItem(row,"co_iva",lc_ivavalor)
	this.SetItem(row,"co_total",lc_valor + lc_ivavalor + lc_transporte)
	
CASE "pv_codigo"
	
	ls_prove = data
	
	// encuentra si el proveedor es con o sin iva
	select pv_caract,pv_rucci,fp_codigo
	into :ls,:ls_ruc,:ls_fpcodigo
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
 	and pv_codigo = :ls_prove;
	
	if sqlca.sqlcode = 100 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n",'Proveedor no registrado')
		return
	end if
	
	if ls = 'S' then
		ii_excento_iva = 0
	else
		// encuentro el valor del iva
		Select pr_valor
		  into :ic_iva
		  from pr_param
	    where em_codigo = :str_appgeninfo.empresa
		   and pr_nombre = 'IVA';
		ii_excento_iva = 1
	end if
	this.setitem( 1,"vp_codigo",'')
	this.SetItem(row,"em_codigo",str_appgeninfo.empresa)
	this.SetItem(row,"su_codigo",str_appgeninfo.sucursal)
	this.SetItem(row,"ec_codigo",is_estado)
	this.SetItem(row,"fp_codigo",ls_fpcodigo)
	this.Modify("st_ruc.text = '"+ls_ruc+"'")
END CHOOSE

end event

event dw_master::itemerror;return 1
end event

event dw_master::clicked;call super::clicked;//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = false

end event

event dw_master::losefocus;call super::losefocus;// si se encuentra en el ultimo campo de la obeservacion,
// al salir cambiarse al detalle

CHOOSE CASE this.GetColumnName()
CASE 'co_observ'
	dw_detail.SetFocus()
	//w_orden_compra.postevent('ue_insert')
	dw_detail.PostEvent(clicked!)
	if dw_detail.RowCount() = 0 then
		window lw_aux
		lw_aux = parent.getActiveSheet()
		if isValid(lw_aux) then lw_aux.postEvent("ue_insert")
		//dw_detail.postEvent(itemchanged!)
	end if
END CHOOSE
end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event dw_master::itemfocuschanged;call super::itemfocuschanged;datawindowchild ldwc_aux
string ls_prove,ls,ls_filtro

IF dwo.name="vp_codigo" Then
	
	ls_prove = this.getitemstring(row,"pv_codigo")
	
	// encuentra si el proveedor es con o sin iva
	select pv_caract
	into :ls
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
 	and pv_codigo =   :ls_prove;
	
	if sqlca.sqlcode = 100 then
      setcolumn("pv_codigo")
	end if
	
	If isnull(ls_prove) or ls_prove='' Then
		ls_prove='********'
	End IF

	ls_filtro = "pv_codigo = '"+ls_prove+"'"
	this.getChild("vp_codigo", ldwc_aux)
	ldwc_aux.SetFilter(ls_filtro)
	ldwc_aux.Filter()
end if
end event

event dw_master::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"co_fecha",f_hoy())
this.setitem(ll_row,"co_fecrep",f_hoy())

end event

event dw_master::updatestart;call super::updatestart;/*Actualizar los valores de orden de compra*/
if wf_actualiza_suma() <> 1 then
return 1
end if
return 0



end event

type dw_detail from w_sheet_master_detail`dw_detail within w_orden_compra
event ue_nextfield pbm_dwnprocessenter
integer x = 0
integer y = 740
integer width = 2903
integer height = 688
string dataobject = "d_detalle_orden_compra"
boolean hsplitscroll = true
end type

event dw_detail::ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event

event dw_detail::itemchanged;call super::itemchanged;long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
long ll_unidad,ll_clase,ll_cta,ll_cod
decimal ll_valortot,ll_valor,ll_costo,ll_valorsum,ld_area, ll_ivavalor, lc_transporte
decimal ll_subtot,ll_reten,ll_suma, ld_canti,ll_suma1,ld_null
decimal ld_area_pedida , lc_costo, lc_stk,lc_desc1,lc_desc2,lc_desc3
decimal{2} lc_prefab,lc_plista
string ls, ls_pepa, ls_nombre, ls_null, ls_codant, ls_codigo,&
       ls_prove,ls_kit,ls_borrar,ls_desctopos,ls_desctofxm
       

ll_filact = this.getRow()
str_prodparam.fila = ll_filact
ll_filActMaster = dw_master.getRow()
ls_borrar = this.getcolumnname()
ls_prove = dw_master.GetItemString(ll_filActMaster,'pv_codigo')


choose case this.getcolumnname()
	CASE 'codant'
		ls = this.gettext()
				
		//Con este voy a buscar
		//primero por codigo anterior
		select it_codigo, it_nombre, it_kit,it_prefab,it_costo                //(it_prefab*.95)*1.12
		into :ls_pepa, :ls_nombre, :ls_kit,:lc_prefab,:lc_costo
		from in_item
		where em_codigo = :str_appgeninfo.empresa
		and it_codant = :ls;
			   			
	
	   //Si no existe busco por codigo de barras
		if sqlca.sqlcode = 100 then
		 	select it_codigo, it_codant, it_nombre, it_kit , it_prefab,it_costo // (it_prefab*.95)*1.12
			into :ls_pepa, :ls_codant, :ls_nombre, :ls_kit,:lc_prefab,:lc_costo
			from in_item
		  	where em_codigo = :str_appgeninfo.empresa
		   and it_codbar = :ls;
			if sqlca.sqlcode = 100 then
				beep(1)
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe c$$HEX1$$f300$$ENDHEX$$digo de producto")
				return
			end if	   
	   end if
		
	   //Buscar los dsctos para la venta del item
		//para poder mostrar el factor de utilidad real
		select nvl(td_desc1,0)/100,nvl(td_desc2,0)/100,nvl(td_desc3,0)/100,nvl(td_descri,'Sin descuento')
		into :lc_desc1,:lc_desc2,:lc_desc3,:ls_desctopos
		from in_descitem x, in_tippre y,in_item z
		where x.em_codigo = z.em_codigo 
		and x.it_codigo = z.it_codigo 
		and x.em_codigo = y.em_codigo
		and x.td_codigo = y.td_codigo
		and z.em_codigo = y.em_codigo 
		and x.em_codigo = :str_appgeninfo.empresa
		and z.it_codigo = :ls_pepa
		and x.es_codigo = '2'
		and y.td_vigente = 'S';
					
	   		
		lc_prefab = ((lc_prefab*(1 - lc_desc1))*(1 - lc_desc2))*(1 - lc_desc3)
		lc_prefab = (lc_prefab*.95)*1.12

			
	   //Buscamos el Stock de ultima compra
		select it_stock
  		into  :lc_stk
	  	from in_itesucur
 		where em_codigo = :str_appgeninfo.empresa
	   and su_codigo = :str_appgeninfo.sucursal
		and it_codigo = :ls_pepa;
	
		if ls_kit = 'S' then
			select trunc(min(it_stock / ri_cantid))
		  	into :lc_stk
  			from in_itesucur x, in_relitem y
		 	where x.em_codigo = y.em_codigo
			and x.it_codigo = y.it_codigo
			and x.em_codigo = :str_appgeninfo.empresa
			and x.su_codigo = :str_appgeninfo.sucursal
			and y.it_codigo1 = :ls_pepa
			and y.tr_codigo = '1'; //Es kit
		end if

		if sqlca.sqlcode <> 0 then
			messageBox('Error Interno','No se encuentra producto: '+sqlca.sqlerrtext)
			rollback;
			return
		end if	
				
				
		/*Determinar los dsctos del producto en FXM*/
		select nvl(td_descri,'Sin descuento')
		into   :ls_desctofxm
		from    in_item x,in_descitem y ,in_tippre z
		where x.em_codigo = y.em_codigo
		and x.it_codigo = y.it_codigo
		and y.em_codigo = z.em_codigo
		and y.td_codigo = z.td_codigo
		and x.em_codigo = :str_appgeninfo.empresa
		and x.it_codigo = :ls_pepa
		and y.es_codigo = '4'
		and z.td_vigente = 'S';
				
	

		/*Determinar el precio de lista por proveedor*/
		select ip_plista,nvl(ip_desc1,0),nvl(ip_desc2,0),nvl(ip_desc3,0)
		into   :lc_plista,:lc_desc1,:lc_desc2,:lc_desc3
		from   in_itepro
		where  em_codigo = :str_appgeninfo.empresa
		and    it_codigo = :ls_pepa
		and    pv_codigo = :ls_prove;
		
		
		this.setitem(ll_filact, 'dc_cantid', 1)
		this.setitem(ll_filact, 'nombre',ls_nombre)
		this.setitem(ll_filact, 'it_codigo',ls_pepa)
		this.setitem(ll_filact, 'bo_codigo', str_appgeninfo.seccion)
		this.setitem(ll_filact, 'dc_costo', lc_plista)
		this.setitem(ll_filact, 'dc_desc1', lc_desc1)
		this.setitem(ll_filact, 'dc_desc2', lc_desc2)
		this.setitem(ll_filact, 'dc_desc3', lc_desc3)
		this.setitem(ll_filact, 'cosult', lc_costo)
		this.setitem(ll_filact, 'stock', lc_stk)
		this.setitem(ll_filact, 'cc_precio',lc_prefab)
		/*Anteriormente seleccionado*/
		this.setitem(ll_filact,"cc_pos",ls_desctopos)
		/*Para informacion sobre FXM*/
      this.setitem(ll_filact,"cc_fxm",ls_desctofxm)		
		this.SetColumn('dc_cantid')             
	
	CASE "dc_costo"
	
		if  dec(this.GetText()) < 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El costo no puede ser negativo")			
		   dw_detail.SetItem(ll_filact,"dc_costo",0)
		  	return 1
		end if
 		this.accepttext()
      
		If idwc_plista.rowcount() > 0 Then
			lc_desc1 = idwc_plista.GetItemNumber(idwc_plista.getrow(),"ip_desc1")
			lc_desc2 = idwc_plista.GetItemNumber(idwc_plista.getrow(),"ip_desc2")
			lc_desc3 = idwc_plista.GetItemNumber(idwc_plista.getrow(),"ip_desc3")
	      
			If isnull(lc_desc1) then lc_desc1 = 0
			If isnull(lc_desc2) then lc_desc2 = 0
			If isnull(lc_desc3) then lc_desc3 = 0
				
			This.SetItem(row,"dc_desc1",lc_desc1)
			This.SetItem(row,"dc_desc2",lc_desc2)
			This.SetItem(row,"dc_desc3",lc_desc3)
		End if
	 		   
	CASE "dc_desc1"
		this.SetColumn('dc_desc2')

	CASE "dc_desc2"
		this.SetColumn('dc_desc3')
	
	CASE "dc_cantid"
		if  dec(this.GetText()) < 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La cantidad debe ser mayor a cero")			
	   	dw_detail.SetItem(ll_filact,"dc_cantid",0)
			return 1
		end if	
 		this.SetColumn('dc_costo')
 		this.accepttext()
END CHOOSE



select pv_caract
into :ls
from in_prove
where em_codigo = :str_appgeninfo.empresa
  and pv_codigo = :ls_prove;

if sqlca.sqlcode < 0 then
	is_mensaje = sqlca.sqlerrtext
	return 1
end if

if ls = 'S' then
	 ii_excento_iva = 0
else
	 Select pr_valor
	  into :ic_iva
	  from pr_param
         where em_codigo = :str_appgeninfo.empresa
	  and pr_nombre = 'IVA';
	  ii_excento_iva = 1
end if

ll_valortot = this.GetItemNumber(ll_filact,"dc_costo")* this.GetItemNumber(ll_filact,"dc_cantid")
this.SetItem(ll_filact,"dc_subtot",ll_valortot)

ll_valor= this.GetItemNumber(ll_filact,"cc_total")
this.SetItem(ll_filact,"dc_total",ll_valor)

/*Inicializo la fila actual*/
//ll_totFilas = this.rowCount()
//for ll_fila = 1 to ll_totFilas
//	ll_valorsum += this.getItemNumber(ll_fila,"dc_total")
//next

ll_valorsum = dw_detail.getitemdecimal(ll_filact,"cc_subtotal")
dw_master.setItem(ll_filActMaster,"co_subtot",ll_valorsum)

// actualiza los campos Total, Iva y Saldo
lc_transporte  =dw_master.GetItemNUmber(ll_filActMaster,"co_transpor")
ll_suma1=dw_master.GetItemNumber(ll_filActMaster,"co_subtot")
ll_subtot= ll_suma1 - (ll_suma1*dw_master.GetItemNumber(ll_filActMaster,"co_descup"))

ll_ivavalor= round(ll_subtot*ic_iva,2)*ii_excento_iva
dw_master.SetItem(ll_filActMaster,"co_iva",ll_ivavalor)
dw_master.SetItem(ll_filActMaster,"co_total",ll_subtot + ll_ivavalor + lc_transporte)

end event

event dw_detail::itemerror;return 1
end event

event dw_detail::losefocus;call super::losefocus;CHOOSE CASE this.getcolumnName()
	CASE "dc_desc3"
	window lw_aux
	lw_aux = parent.getActiveSheet()
	dw_detail.SetFocus()
	if isValid(lw_aux) then lw_aux.postEvent("ue_insert")
	this.SetColumn('codant')
END CHOOSE
end event

event dw_detail::ue_postdelete;long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
decimal ll_valortot,ll_valor,ll_costo,ll_valorsum,ld_area, ll_ivavalor, lc_transporte
decimal ll_subtot,ll_reten,ll_suma, ld_canti,ll_suma1
decimal lc_costo, lc_stk
string ls, ls_pepa, ls_nombre, ls_null, ls_codant, ls_codigo, ls_prove

ll_filact = this.getRow()
ll_filActMaster = dw_master.getRow()
accepttext()
ls_prove = dw_master.GetItemString(ll_filActMaster,'pv_codigo')

select pv_caract
into :ls
from in_prove
where em_codigo = :str_appgeninfo.empresa
  and pv_codigo = :ls_prove;

if sqlca.sqlcode <> 0 then
	is_mensaje = 'Proveedor no registrado'
	return 1
end if
if ls = 'S' then
	ii_excento_iva = 0
else
	Select pr_valor
	  into :ic_iva
	  from pr_param
    where em_codigo = :str_appgeninfo.empresa
	   and pr_nombre = 'IVA';
	ii_excento_iva = 1
end if

If ll_filact <> 0 Then 
ll_valortot = this.GetItemDecimal(ll_filact,"dc_costo")* this.GetItemDecimal(ll_filact,"dc_cantid")
this.SetItem(ll_filact,"dc_subtot",ll_valortot)
ll_valor= this.GetItemDecimal(ll_filact,"cc_total")
this.SetItem(ll_filact,"dc_total",ll_valor)
End If


//inicializo la fila actual
ll_totFilas = this.rowCount()

for ll_fila = 1 to ll_totFilas
	ll_valorsum += this.getItemDecimal(ll_fila,"dc_total")
next
dw_master.setItem(ll_filActMaster,"co_subtot",ll_valorsum)

// actualiza los campos Total, Iva y Saldo
 lc_transporte  =dw_master.GetItemDecimal(ll_filActMaster,"co_transpor")
 ll_suma1=dw_master.GetItemDecimal(ll_filActMaster,"co_subtot")
 ll_subtot= ll_suma1 - (ll_suma1*dw_master.GetItemDecimal(ll_filActMaster,"co_descup"))

 ll_ivavalor= round(ll_subtot*ic_iva,2)*ii_excento_iva
 dw_master.SetItem(ll_filActMaster,"co_iva",ll_ivavalor)
 dw_master.SetItem(ll_filActMaster,"co_total",ll_subtot + ll_ivavalor + lc_transporte)
 return 1

end event

event dw_detail::getfocus;call super::getfocus;
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow()
str_prodparam.campo = "dc_cantid"
cantidad_producto_ubica = TRUE



end event

event dw_detail::updatestart;call super::updatestart;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n : 
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 30/03/1998  17:31

/*********************************************************************/

int li, max,i=0,li_i
long ll_numero, ll,ll_fila
string ls


ll_fila = dw_detail.RowCount()
// elimina las filas con items en blanco
for li_i = 1 to ll_fila
 	ls = dw_detail.GetItemString(li_i - i,'codant')
	if isnull(ls) or ls = '' then
		dw_detail.DeleteRow(li_i - i)
	  	i=i+1	  
	end if
next


//max = dw_detail.rowcount()
//if isnull(dw_detail.GetitemString(max,'nombre')) then
//	max = max -1
//end if

// asigna en el detalle el secuencial y el saldo de cada fila
For li = 1 to This.RowCount()
	dw_detail.SetItem(li,'dc_secue',li)
	dw_detail.SetItem(li,'dc_saldo',dw_detail.GetItemNumber(li,'dc_cantid'))
	dw_detail.SetItem(li,'dc_total',dw_detail.GetItemNumber(li,'cc_total'))
next

//dw_detail.Object.dc_saldo.Primary = dw_detail.Object.dc_cantid.Primary
//dw_detail.Object.dc_total.Primary = dw_detail.Object.cc_total.Primary

Return 0

end event

event dw_detail::doubleclicked;call super::doubleclicked;Decimal lc_valor
Long i

If dwo.name = 'dc_costo' &
Then
	lc_valor = This.GetItemNumber(row,"dc_costo")
	for i = row to this.rowcount()
	this.setitem(i,"dc_costo",lc_valor)
	next	
End if
If dwo.name = 'dc_desc1' &
Then
	lc_valor = This.GetItemNumber(row,"dc_desc1")
	for i = row to this.rowcount()
	this.setitem(i,"dc_desc1",lc_valor)
	next	
End if

If dwo.name = 'dc_desc2' &
Then
	lc_valor = This.GetItemNumber(row,"dc_desc2")
	for i = row to this.rowcount()
	this.setitem(i,"dc_desc2",lc_valor)
	next	
End if

If dwo.name = 'dc_desc3' &
Then
	lc_valor = This.GetItemNumber(row,"dc_desc3")
	for i = row to this.rowcount()
	this.setitem(i,"dc_desc3",lc_valor)
	next	
End if

wf_actualiza_suma()
return 1
end event

event dw_detail::itemfocuschanged;/*Recuperar los precios de lista*/
Long ll_nreg
String ls_pepa

if dwo.name = 'dc_costo' then
   ls_pepa = this.getitemstring(row,"it_codigo") 	
	ll_nreg = idwc_plista.retrieve(ls_pepa)
end if
return 1
end event

type dw_report from w_sheet_master_detail`dw_report within w_orden_compra
integer x = 0
integer y = 0
integer width = 2784
integer height = 1296
string dataobject = "d_rep_orden_compra"
end type

type dw_ubica from datawindow within w_orden_compra
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 576
integer y = 140
integer width = 1445
integer height = 260
integer taborder = 31
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Orden de Compra"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event itemchanged;string ls, ls_criterio, ls_tipo
long ll_found,ll_nreg,ll_numero

//CHOOSE CASE this.GetColumnName()
//
//	CASE 'factura'
//		ls_tipo = this.GetItemString(1,'tipo')
//		ls = this.getText()
//		CHOOSE CASE ls_tipo
//			CASE 'B'
//				ls_criterio = "co_numero = " +  ls
//				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
//				if ll_found > 0 and not isnull(ll_found) then
//				  dw_master.SetFocus()
//				  dw_master.ScrollToRow(ll_found)
//				  dw_master.SetRow(ll_found)
//				  this.Visible = false
//	  			else
//				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','N$$HEX1$$fa00$$ENDHEX$$mero no se encuentra, verifique datos')
//				  return
//			  end if
//		   CASE 'F'
//				ls_criterio = "co_numero" +  ls 
//				dw_master.SetFilter(ls_criterio)
//				dw_master.Filter()
//				dw_master.SetFocus()
//				this.Visible = false	
//				dw_master.ScrollToRow(dw_master.GetRow())
//				dw_master.SetRow(dw_master.GetRow())				
//				
//		END CHOOSE
//END CHOOSE


/* VERSION PARA RECUPERAR UNA POR UNA LA ORDEN DE COMPRA*/

CHOOSE CASE this.GetColumnName()
	CASE 'factura'
		ll_numero = long(this.getText())
		ll_nreg = dw_master.retrieve(str_appgeninfo.empresa,'1',ll_numero)
		if ll_nreg <= 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones <Por favor verifique>")
			return
		end if
	   if ll_nreg = 1 then
		dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'1',ll_numero)
		end if	
END CHOOSE


end event

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

type st_1 from statictext within w_orden_compra
integer y = 656
integer width = 489
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Tomar pedido"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;String ls_itcodant,ls_imp,ls_pvcodigo
Long   ll_cantidad,i,ll_new,ll_filact
Long   ll_filactmaster,ll_totfilas,ll_fila 
decimal lc_valorsum,lc_transporte,lc_suma1,lc_subtot,lc_ivavalor,lc_valor,lc_valortot
w_frame_basic lw_frame


lw_frame  = parent.parentwindow()
lw_frame.setMicrohelp("Tomando pedido, espere por favor...")

Setpointer(Hourglass!)

if not isvalid(gds_pedido)then return

ll_filActMaster = dw_master.getrow() 

ls_pvcodigo = dw_master.GetItemString(ll_filActMaster,"pv_codigo") 

if isnull(ls_pvcodigo) or ls_pvcodigo = "" then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Antes de capturar el pedido debe seleccionar un proveedor.",Exclamation!)
	Return
end if	
/*Sube el pedido*/
dw_detail.setredraw(false)
dw_detail.reset()
for i = 1 to gds_pedido.rowcount()
	
	ls_itcodant = gds_pedido.GetItemstring(i,"it_codant")
	ll_cantidad = gds_pedido.Getitemnumber(i,"it_cantidad")
	ll_new = dw_detail.insertrow(0)
	dw_detail.setrow(ll_new)
	dw_detail.scrolltorow(ll_new)
	dw_detail.setitem(ll_new,"codant",ls_itcodant) 
	dw_detail.triggerevent(itemchanged!)
	dw_detail.setitem(ll_new,"dc_cantid",ll_cantidad) 
	dw_detail.setcolumn("codant") 
	
	
	/*Para actualizar la cabecera*/
	lc_valortot = dw_detail.GetItemNumber(i,"dc_costo")* dw_detail.GetItemNumber(i,"dc_cantid")
	dw_detail.SetItem(i,"dc_subtot",lc_valortot)
	lc_valor= dw_detail.GetItemNumber(i,"cc_total")
	dw_detail.SetItem(i,"dc_total",lc_valor)
next
dw_detail.setredraw(true)



//inicializo la fila actual
ll_totFilas = dw_detail.rowCount()
for ll_fila = 1 to ll_totFilas
	lc_valorsum += dw_detail.getItemNumber(ll_fila,"dc_total")
next
dw_master.setItem(ll_filActMaster,"co_subtot",lc_valorsum)

// actualiza los campos Total, Iva y Saldo
lc_transporte  =dw_master.GetItemNUmber(ll_filActMaster,"co_transpor")
lc_suma1=dw_master.GetItemNumber(ll_filActMaster,"co_subtot")
lc_subtot= lc_suma1 - (lc_suma1*dw_master.GetItemNumber(ll_filActMaster,"co_descup"))
lc_ivavalor= round(lc_subtot*ic_iva,2)*ii_excento_iva
dw_master.SetItem(ll_filActMaster,"co_iva",lc_ivavalor)
dw_master.SetItem(ll_filActMaster,"co_total",lc_subtot + lc_ivavalor + lc_transporte)
lw_frame.SetMicrohelp("Listo...")
Setpointer(Arrow!)
end event


HA$PBExportHeader$w_importacion_transito.srw
$PBExportComments$Compras de productos de una empresa.Vale
forward
global type w_importacion_transito from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_importacion_transito
end type
type cb_1 from commandbutton within w_importacion_transito
end type
end forward

global type w_importacion_transito from w_sheet_master_detail
integer x = 5
integer y = 380
integer width = 2949
integer height = 1820
string title = "Importaci$$HEX1$$f300$$ENDHEX$$n en tr$$HEX1$$e100$$ENDHEX$$nsito"
long backcolor = 79741120
event ue_consultar pbm_custom16
dw_ubica dw_ubica
cb_1 cb_1
end type
global w_importacion_transito w_importacion_transito

type variables
decimal ic_iva
long ii_excento_iva
string  is_mensaje, is_estado='3',is_mpcodigo_mc
datastore ids_movim

end variables

forward prototypes
public function boolean wf_mov_inventario (string as_item, string as_numero, decimal ad_cantidad, date ad_fecha, long al_costo)
public function integer wf_preprint ()
public function boolean wf_costo_promedio (string as_item, decimal ad_cantidad, long al_costo)
public function integer wf_actualiza_suma ()
public function integer wf_anular_deuda ()
public function integer wf_busca_factura ()
end prototypes

event ue_consultar;dw_master.postevent(DoubleClicked!)
dw_master.Object.w_observacion.text = '          '
dw_detail.enabled = false
dw_master.enabled = false
end event

public function boolean wf_mov_inventario (string as_item, string as_numero, decimal ad_cantidad, date ad_fecha, long al_costo);long ll_num_movim,ll_costo

select pr_valor
  into :ll_num_movim
  from pr_param
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_MINV';

//select it_costo
//  into :ll_costo
//  from in_item
// where em_codigo = :str_appgeninfo.empresa
//   and it_codigo = :as_item;
//
//if sqlca.sqlcode <> 0 then
//	MessageBox("ERROR","No se pudo obtener el costo del item "+sqlca.sqlerrtext);
//   return(FALSE)
//end if

insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                     mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
							mv_observ)
values ('1','I',:as_item,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,
        :ll_num_movim,:ad_cantidad,:al_costo,:ad_fecha,:str_appgeninfo.empresa,
		  'Factura de compra No. '||:as_numero);
if sqlca.sqlcode <> 0 then
	MessageBox("ERROR","Error al grabar el mov. de inventario "+sqlca.sqlerrtext)
	return (FALSE)
else
	update pr_param
	   set pr_valor = pr_valor + 1
    where em_codigo = :str_appgeninfo.empresa
      and pr_nombre = 'NUM_MINV';	
	return (TRUE)
end if
end function

public function integer wf_preprint ();dataWindowChild ldwc_aux
long ll_filActMaestro
long ll_co_numero
string ls_prove

dw_report.SetTransObject(sqlca)
ll_filActMaestro = dw_master.getRow()
ll_co_numero = dw_master.getItemNumber(ll_filActMaestro, "co_numero")
ls_prove = dw_master.getItemString(ll_filActMaestro, "pv_codigo")

dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
                   is_estado, ll_co_numero, ls_prove)
				
return 1

end function

public function boolean wf_costo_promedio (string as_item, decimal ad_cantidad, long al_costo);long    ll_costo_actual,ll_nuevo_costo
decimal ld_total_stock

select it_stock,it_costo
  into :ld_total_stock, :ll_costo_actual
  from in_itesucur x, in_item y
 where x.em_codigo = y.em_codigo
   and x.it_codigo = y.it_codigo
   and x.em_codigo = :str_appgeninfo.empresa
   and x.su_codigo = :str_appgeninfo.sucursal;
	
if sqlca.sqlcode <> 0 then
	MessageBox("ERROR","No puedo obtener el stock del item "+sqlca.sqlerrtext)
	return(FALSE)
end if

ll_nuevo_costo = ((ld_total_stock*ll_costo_actual)+(ad_cantidad*al_costo))/(ld_total_stock+ad_cantidad)

	
return(TRUE)
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

public function integer wf_anular_deuda ();String  ls_mpcoddeb,ls_mpcodigo, ls_corucsuc_orig,ls_pvcodigo,ls_facpro
Long  ll_row,ll_npag
Decimal lc_conumero_orig
Date   ld_feccompra,ld_hoy
Datetime ld_now

ll_row  = dw_master.getrow()

ls_corucsuc_orig = dw_master.GetitemString(ll_row,"co_rucsuc",Primary!,true)
lc_conumero_orig = dw_master.GetitemNumber(ll_row,"co_numero",Primary!,true)
ls_facpro        = dw_master.GetitemString(ll_row,"co_facpro",Primary!,true)
ls_pvcodigo      = dw_master.GetitemString(ll_row,"pv_codigo",Primary!,true)
ld_feccompra     = date(dw_master.Getitemdatetime(ll_row,"co_fecha",Primary!,true))


/*Permitir la anulaci$$HEX1$$f300$$ENDHEX$$n de la compra solo si es de la misma fecha en la que 
  se  grabo la compra*/

select trunc(sysdate)
into :ld_now
from  dual;

ld_hoy = date(ld_now)

if ld_feccompra <> ld_hoy then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La factura que desea anular no es de hoy d$$HEX1$$ed00$$ENDHEX$$a...No se puede anular la compra")
   return -1	
end if	

/**/
select mp_codigo
into :ls_mpcodigo
from cp_movim
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :ls_corucsuc_orig
and co_numero = :lc_conumero_orig
and co_facpro = :ls_facpro
and tv_codigo = '1'
and tv_tipo = 'C'
and pv_codigo = :ls_pvcodigo;



/*Verificar si tiene a mas de las retenciones 
otros pagos ej.Cheque,Efectivo,etc*/
//select count(*)
//into :ll_npag
//from cp_pago x,cp_cruce y 
//where x.em_codigo = y.em_codigo
//and x.mp_codigo = y.mp_coddeb
//and x.tv_codigo = y.tv_coddeb
//and x.tv_tipo = y.tv_tipodeb
//and x.su_codigo = y.su_codigo
//and y.em_codigo = :str_appgeninfo.empresa
//and y.su_codigo = :ls_corucsuc_orig
//and y.tv_codigo = '1'
//and y.tv_tipo = 'C'
//and y.mp_codigo = :ls_mpcodigo
//and x.fp_codigo not in ('6','7');
//
//if ll_npag > 0 then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta factura ya tiene pagos registrados")
//Rollback;
//Return -1
//end if
	

declare cruce cursor for 
select mp_coddeb
from cp_cruce
where em_codigo = :str_appgeninfo.empresa 
and su_codigo  = :ls_corucsuc_orig 
and mp_codigo = :ls_mpcodigo 
and tv_codigo = '1'
and tv_tipo = 'C'
and tv_coddeb = '2'
and tv_tipodeb = 'D';

open cruce;
fetch cruce into :ls_mpcoddeb;
do while sqlca.sqlcode = 0 

		/*Delete el cruce*/
		delete
		from CP_CRUCE
		where mp_codigo = :ls_mpcodigo and
		mp_coddeb = :ls_mpcoddeb and
		tv_codigo = '1' and
		tv_tipo = 'C' and
		tv_coddeb = '2' and
		tv_tipodeb = 'D' and
		em_codigo  = :str_appgeninfo.empresa and
		su_codigo  = :ls_corucsuc_orig ;
		if sqlca.sqlcode < 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular el cruce"+sqlca.sqlerrtext)
		rollback;
		return -1
		end if

		/*Borrar las Notas de debito*/

			
		/*Delete el pago*/
		delete 
		from cp_pago
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :ls_corucsuc_orig
		and tv_codigo = '2'
		and tv_tipo = 'D'
		and mp_codigo = :ls_mpcoddeb;
		if sqlca.sqlcode < 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular el pago"+sqlca.sqlerrtext)
		rollback;
		return -1
		end if
		
fetch cruce into:ls_mpcoddeb;		
loop 
close cruce;

/*Delete el mov  de cp_movim*/
delete 
from cp_movim
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :ls_corucsuc_orig
and co_numero = :lc_conumero_orig
and co_facpro = :ls_facpro 
and pv_codigo = :ls_pvcodigo;
if sqlca.sqlcode < 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular la deuda"+sqlca.sqlerrtext)
rollback;
return -1
end if
return 1
end function

public function integer wf_busca_factura ();/*Busca la compra*/
long ll_count,ll_row
String ls_cofacpro,ls_corucsuc,ls_pvcodigo


ll_row = dw_master.getrow()

ls_cofacpro = dw_master.GetItemString(ll_row,"co_facpro")
ls_pvcodigo = dw_master.GetItemString(ll_row,"pv_codigo")
ls_corucsuc = dw_master.GetItemString(ll_row,"co_rucsuc")


SELECT COUNT(*)
INTO :ll_count
FROM CP_MOVIM
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :ls_corucsuc
AND TV_CODIGO = '1'
AND TV_TIPO = 'C'
AND EC_CODIGO = '3'
AND CO_FACPRO = :ls_cofacpro
AND PV_CODIGO = :ls_pvcodigo;


return ll_count



end function

on w_importacion_transito.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.cb_1
end on

on w_importacion_transito.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.cb_1)
end on

event open;string ls_parametro[]
datawindowchild ldwc_fp,dwc_mov,dwc_proveedor    

f_recupera_empresa(dw_master,"pv_codigo") 
f_recupera_empresa(dw_master,"fp_codigo")

dw_master.getChild("fp_codigo", ldwc_fp)
ldwc_fp.setTransObject(sqlca)
ldwc_fp.retrieve(str_appgeninfo.empresa)
ldwc_fp.setfilter("fp_string like '%C%'")
ldwc_fp.filter()

ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[2] = str_appgeninfo.sucursal
ls_parametro[3] = '2' 
f_recupera_datos(dw_master,"co_numpad", ls_parametro,3)
f_recupera_empresa(dw_master,"pv_codigo") 

istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = is_estado

call super::open
dw_master.is_SerialCodeColumn = "co_numero"
dw_master.is_SerialCodeType = "COMPRA"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//dw_detail.is_serialCodeDetail = "dc_secue"  /*Debe ser string el campo para que trabaje bien*/

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
dw_master.uf_insertCurrentRow()
dw_master.setFocus()

/*Para las cxp*/
ic_iva = f_iva()








end event

event close;
end event

event ue_insert;call super::ue_insert;dw_detail.enabled =true
dw_master.enabled =true

end event

event ue_delete;beep(1)
end event

event activate;m_marco.m_edicion.m_guardar.enabled = true
m_marco.m_edicion.m_insertar.enabled = true
m_marco.m_edicion.m_borrar.enabled = true

end event

event ue_lastrow;call super::ue_lastrow;//dw_detail.enabled= true
//dw_master.enabled= true
dw_master.Object.w_observacion.text = '          '
end event

event ue_nextrow;call super::ue_nextrow;//dw_detail.enabled = true
//dw_master.enabled = true
dw_master.Object.w_observacion.text = '          '
end event

event ue_priorrow;call super::ue_priorrow;//dw_detail.enabled = true
//dw_master.enabled = true
dw_master.Object.w_observacion.text = '          '
end event

event ue_firstrow;call super::ue_firstrow;//dw_detail.enabled = true
//dw_master.enabled = true
dw_master.Object.w_observacion.text = '          '
end event

event ue_printcancel;w_frame_basic lw_frame
m_frame_basic lm_frame

if this.wf_postPrint() = 1 then
	this.setRedraw(False)
	dw_report.enabled = False
	dw_report.visible = False
	dw_master.enabled = true
	dw_master.visible = True
	dw_detail.enabled = true
	dw_detail.visible = True
	this.ib_inReportMode = False
	this.triggerEvent(resize!)		// so the master and detail get the correct size
	lw_frame = this.parentWindow()
	lm_frame = lw_frame.menuid
	lm_frame.mf_outof_report_mode()
	this.setRedraw(True)
end if
end event

event ue_retrieve;dw_detail.enabled=false
dw_master.enabled=false
return 1

end event

type dw_master from w_sheet_master_detail`dw_master within w_importacion_transito
event ue_keyenter pbm_dwnprocessenter
integer x = 0
integer y = 0
integer width = 2921
integer height = 672
integer taborder = 10
string dataobject = "d_compra"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event dw_master::ue_keyenter;send(handle(this),256,9,long(0,0))
return 1
end event

event dw_master::itemchanged;long ll_filact,ll_numero, ll_fildet, ll_secue
decimal lc_ivavalor,lc_valor,lc_subtot, lc_descup, ld_cantid, lc_costo,lc_costunit,lc_pvp,lc_factor
DECIMAL lc_desc1, lc_desc2, lc_desc3, lc_total, lc_transporte, lc_precio, &
                lc_desc1_p, lc_desc2_p, lc_desc3_p, lc_costo_p // Costo y descuentos registrados en el pedido

string ls, ls_prove, ls_filtro, ls_venpro, ls_codant, ls_nombre, ls_codigo, ls_formpag, ls_completa
decimal a, b, c, lc_valorsum, ll_suma1, ll_subtot, ll_ivavalor

            
string ls_observacion,ls_codRuc,ls_ruc,ls_cofacpro
char lch_kit
datawindowChild ldwc_aux




ll_filact = dw_master.getRow()


CHOOSE CASE this.getColumnName()

CASE "co_descup"  // si cambia el valor del porcentaje de descuento
	
	lc_descup = dec(this.gettext())
	lc_transporte  = this.GetItemNUmber(ll_filact,"co_transpor")
	if isnull(lc_transporte) then
		lc_transporte = 0
		this.SetItem(ll_filact,"co_transpor",0)
	end if
	lc_subtot = this.GetItemNUmber(ll_filAct,"co_subtot")
	select nvl(pv_caract,'N')
	into :ls
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
	and pv_codigo = :ls_prove;
	
	// controla si el proveedor es excento de iva o no
	if ls = 'S' then
		ii_excento_iva = 0
	else
		 select pr_valor
		 into :ic_iva
		 from pr_param
	      where em_codigo = :str_appgeninfo.empresa
		 and pr_nombre = 'IVA';
		 ii_excento_iva = 1
	end if
	
	// actualiza los campos Total, Iva y Saldo
	lc_valor= lc_subtot - (lc_subtot*lc_descup)
	lc_ivavalor= round(lc_valor*ic_iva,2)*ii_excento_iva
	this.SetItem(ll_filAct,"co_iva",lc_ivavalor)
	this.SetItem(ll_filAct,"co_total",lc_valor + lc_ivavalor + lc_transporte)
	
CASE "co_transpor"  //si existe cambios en transporte
	
	lc_transporte = dec(this.gettext())
	lc_descup = this.GetItemNUmber(ll_filAct,"co_descup")
	if isnull(lc_descup) then
		lc_descup = 0
		this.SetItem(ll_filact,"co_descup",0)
	end if
	lc_subtot = this.GetItemNumber(ll_filAct,"co_subtot")

	// controla si se paga con iva o no
	select nvl(pv_caract,'N')
	into :ls
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
	and pv_codigo = :ls_prove;
	
	if ls = 'S' then
		ii_excento_iva = 0
	else
		  select pr_valor
		  into :ic_iva
		  from pr_param
	       where em_codigo = :str_appgeninfo.empresa
		  and pr_nombre = 'IVA';
		  ii_excento_iva = 1
	end if
	// actualiza los campos Total, Iva y Saldo
	lc_valor= lc_subtot - (lc_subtot*lc_descup)
	lc_ivavalor= round(lc_valor*ic_iva,2)*ii_excento_iva
	this.SetItem(ll_filAct,"co_iva",lc_ivavalor)
	this.SetItem(ll_filAct,"co_total",lc_valor + lc_ivavalor + lc_transporte)

	
END CHOOSE

end event

event dw_master::itemerror;call super::itemerror;return 1

end event

event dw_master::clicked;
end event

event dw_master::rowfocuschanged;call super::rowfocuschanged;datawindowChild ldw_aux
string ls_prove

dwitemstatus  l_status
l_status = dw_master.getitemstatus(currentrow,0,Primary!)

/*Deshabilitar cxp si la factura ya fue registrada*/
if l_status = datamodified! or l_status = notmodified! & 
then
dw_master.enabled = false
dw_detail.enabled = false

else
this.enabled = true
dw_detail.enabled = true
end if
/**/


if dw_master.GetRow() > 0 then
  ls_prove = dw_master.GetItemString(currentrow,'pv_codigo')
  if not isnull(ls_prove) then 
	  GetChild('vp_codigo',ldw_aux)
	  ldw_aux.SetFilter("pv_codigo ='"+ls_prove+"'")
	  ldw_aux.Filter()
  end if
end if
end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
dw_detail.Enabled = true
dw_master.Enabled = true
this.Object.w_observacion.text = '          '
end event

event dw_master::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"co_fecha",f_hoy())
this.setitem(ll_row,"co_fecrep",f_hoy())
this.setitem(ll_row,"ec_codigo",'6')
end event

event dw_master::updatestart;Long ll_row

ll_row = this.getrow()
this.Object.em_codigo[ll_row]  = str_appgeninfo.empresa
this.Object.su_codigo[ll_row]  = str_appgeninfo.sucursal
this.Object.ec_codigo[ll_row]  = '6'
call super::updatestart

end event

type dw_detail from w_sheet_master_detail`dw_detail within w_importacion_transito
integer x = 0
integer y = 744
integer width = 2917
integer height = 972
integer taborder = 20
string dataobject = "d_detalle_compra"
boolean hscrollbar = false
boolean livescroll = false
end type

event dw_detail::itemchanged;long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
decimal ll_valortot,ll_valor,ll_costo,ll_valorsum,ld_area, ll_ivavalor, lc_transporte
decimal ll_subtot,ll_suma, ld_canti,ll_suma1, lc_newprecio, lc_indice
decimal lc_precio, lc_costo, lc_factor, lc_descab, lc,lc_costunit
string ls, ls_pepa, ls_nombre, ls_null, ls_codant, ls_codigo,ls_borrar,ls_prove
char lch_kit
Int li_pagaiva





ll_filact = this.getRow()
str_prodparam.fila = ll_filact
ll_filActMaster = dw_master.getRow()
ls_borrar = this.getcolumnName()
ls_prove = dw_master.GetItemString(ll_filActMaster,'pv_codigo')

This.AcceptText()

choose case  this.getcolumnName()
CASE 'codant'
	ls = this.gettext()
	
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo, it_nombre, it_prefab,it_kit,it_tiemsec
	into :ls_pepa, :ls_nombre, :lc_precio,:lch_kit,:li_pagaiva
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls;
   
	if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
	 	select it_codigo, it_codant, it_nombre, it_prefab,it_kit,it_tiemsec
		into :ls_pepa, :ls_codant, :ls_nombre, :lc_precio,:lch_kit,:li_pagaiva
		from in_item
	  	where em_codigo = :str_appgeninfo.empresa
	   and it_codbar = :ls;
     	if sqlca.sqlcode <> 0 then
			setnull(ls_null)
			this.SetItem(ll_filact,"codant",ls_null)
			beep(1)
			is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
			return 1
	  	else
			this.SetItem(ll_filact,"codant",ls_codant)
		end if	 
 	end if 
	 
	//Busco el costo de ultima compra
	Select it_cosult
  	into :lc_costo
  	from in_itesucur
 	where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :str_appgeninfo.sucursal
	and it_codigo = :ls_pepa;
	if sqlca.sqlcode <> 0 then
		messageBox('Error Interno','No se encuentra producto: '+sqlca.sqlerrtext)
	end if		
	
//	asigna valores al dw
	this.setitem(ll_filact, 'dc_cantid', 1)
	this.setitem(ll_filact, 'nombre',ls_nombre)
	this.setitem(ll_filact, 'it_codigo',ls_pepa)
	this.setitem(ll_filact, 'bo_codigo', str_appgeninfo.seccion)
	this.setitem(ll_filact, 'dc_costo', lc_costo)
	this.setitem(ll_filact, 'it_kit', lch_kit)	
	this.setitem(ll_filact, 'it_tiemsec', li_pagaiva)	
	this.setitem(ll_filact, 'dc_preact', lc_precio)

	ll_valortot = lc_costo
	this.SetItem(ll_filact,"dc_subtot",ll_valortot)
	ll_valor= this.GetItemDecimal(ll_filact,"cc_total")
	this.SetItem(ll_filact,"dc_total",ll_valor)
	this.SetColumn('dc_cantid')
	// actualiza valores en el maestro
	wf_actualiza_suma()
	
CASE "dc_costo"

	if  dec(this.GetText()) < 0 then
		is_mensaje = "El costo no puede ser negativo"
	    dw_detail.SetItem(ll_filact,"dc_costo",0)
  		return 1
	end if
	ll_valortot = dec(this.GetText())	* this.GetItemDecimal(ll_filact,"dc_cantid")
	this.SetItem(ll_filact,"dc_subtot",ll_valortot)
	ll_valor= this.GetItemDecimal(ll_filact,"cc_total")
	this.SetItem(ll_filact,"dc_total",ll_valor)
	wf_actualiza_suma()
	
CASE "dc_desc1"

	ll_valortot = this.GetItemDecimal(ll_filact,"dc_costo")&
					* this.GetItemDecimal(ll_filact,"dc_cantid")
	this.SetItem(ll_filact,"dc_subtot",ll_valortot)
	ll_valor= this.GetItemDecimal(ll_filact,"cc_total")
	this.SetItem(ll_filact,"dc_total",ll_valor)	
	this.SetColumn('dc_desc2')
	wf_actualiza_suma()	
	
CASE "dc_desc2"

	ll_valortot = this.GetItemDecimal(ll_filact,"dc_costo")&
					* this.GetItemDecimal(ll_filact,"dc_cantid")
	this.SetItem(ll_filact,"dc_subtot",ll_valortot)
	ll_valor= this.GetItemDecimal(ll_filact,"cc_total")
	this.SetItem(ll_filact,"dc_total",ll_valor)		
	this.SetColumn('dc_desc3')
	wf_actualiza_suma()	
	
CASE "dc_desc3"

	ll_valortot = this.GetItemDecimal(ll_filact,"dc_costo")&
					* this.GetItemDecimal(ll_filact,"dc_cantid")
	this.SetItem(ll_filact,"dc_subtot",ll_valortot)
	ll_valor= this.GetItemDecimal(ll_filact,"cc_total")
	this.SetItem(ll_filact,"dc_total",ll_valor)		
	wf_actualiza_suma()

CASE "dc_cantid"
	if  dec(this.GetText()) < 0 then
		is_mensaje = "La cantidad no puede ser negativa"
   	    dw_detail.SetItem(ll_filact,"dc_cantid",0)
  		return 1
 	end if	
	ll_valortot = dec(this.GetText())&
		  		* this.GetItemDecimal(ll_filact,"dc_costo")
	this.SetItem(ll_filact,"dc_subtot",ll_valortot)
	ll_valor= this.GetItemDecimal(ll_filact,"cc_total")
	this.SetItem(ll_filact,"dc_total",ll_valor)
	this.SetColumn('dc_costo')
	wf_actualiza_suma()


CASE "dc_utilidad"
   
	if dec(this.GetText()) < 0 then
		is_mensaje = "La cantidad no puede ser negativa"
      dw_detail.SetItem(ll_filact,"dc_utilidad",0)
  		return 1
 	end if	
		
	lc_factor = dec(this.GetText())/100
  	lc_costo = this.GetItemDecimal(ll_filact,"cc_total") / &
             this.GetItemDecimal(ll_filact, 'dc_cantid')
	lc_costunit = lc_costo			 
  	lc_descab = dw_master.GetItemDecimal(ll_filActMaster, "co_descup")
  	lc_costo = round(lc_costo - lc_costo*lc_descab,2)
  	select pr_valor
      into :lc_indice
	from pr_param
	where em_codigo = :str_appgeninfo.empresa
	and pr_nombre = 'IVA';
	if sqlca.sqlcode <> 0 then
		is_mensaje = 'No se encuentra el par$$HEX1$$e100$$ENDHEX$$metro IVA: '+sqlca.sqlerrtext
		lc_newprecio = 0
		return 1
	end if
	/*El nuevo precio no debe depender de la caracter$$HEX1$$ed00$$ENDHEX$$stisca del proveedor
	  a todos se le debe a$$HEX1$$f100$$ENDHEX$$adir el 5% virtual*/
   //if ii_excento_iva = 0 then
   //lc_newprecio	= ceiling(lc_costunit  / (1 - lc_factor)*100)/100
   //else
   lc_newprecio = ceiling(((lc_costunit/(1 - lc_factor))/0.95)*100)/100
   this.setitem(ll_filact, 'dc_nuepre', lc_newprecio)

CASE 'dc_nuepre'
	lc_newprecio = dec(this.GetText())
	lc = this.GetItemDecimal(ll_filact,'dc_nuepre')
	lc_costo = this.GetItemDecimal(ll_filact,"cc_total") / &
              this.GetItemDecimal(ll_filact, 'dc_cantid')
	lc_costo = round(lc_costo - lc_costo*lc_descab,2)		
	if lc_newprecio <= lc_costo then
		messageBox('Revise por favor','El precio que acaba de ingresar es menor que el costo del producto')
		this.SetItem(ll_filact,'dc_nuepre',lc)
		return 0
	end if
END CHOOSE


end event

event dw_detail::itemerror;call super::itemerror;messageBox ("Error", is_mensaje)
return 1
end event

event dw_detail::losefocus;call super::losefocus;//CHOOSE CASE this.getcolumnName()
//
//CASE "dc_actualiza"
//window lw_aux
//lw_aux = parent.getActiveSheet()
//dw_detail.SetFocus()
//if isValid(lw_aux) then lw_aux.postEvent("ue_insert")
//this.SetColumn('codant')
//
//END CHOOSE

end event

event dw_detail::clicked;
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow()
str_prodparam.campo = 'dc_cantid'

end event

event dw_detail::doubleclicked;call super::doubleclicked;Long i
Decimal lc_valor,lc_costunit

This.AcceptText()
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

If dwo.name = 'dc_utilidad' &
Then
	lc_valor = This.GetItemNumber(row,"dc_utilidad")
	for i = row to this.rowcount()
	this.setitem(i,"dc_utilidad",lc_valor)
	triggerevent(itemchanged!)
	next	
End if

If dwo.name = 'dc_nuepre' &
Then
	lc_valor = This.GetItemNumber(row,"dc_nuepre")
	for i = row to this.rowcount()
	this.setitem(i,"dc_nuepre",lc_valor)
	next	
End if

/*Actualizar el  Nuevo precio*/
Decimal lc_indice,lc_newprecio,lc_descab,lc_factor,lc_costo,&
             lc_valortot,ll_valor

select pr_valor
into :lc_indice
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'IVA';

//if sqlca.sqlcode <> 0 then
//is_mensaje = 'No se encuentra el par$$HEX1$$e100$$ENDHEX$$metro IVA: '+sqlca.sqlerrtext
//lc_newprecio = 0
//return 1
//end if
lc_descab = dw_master.GetItemDecimal(dw_Master.getrow(), "co_descup")  	

for i = 1 to this.rowcount()

     lc_valortot = this.GetItemDecimal(i,"dc_costo")&
					* this.GetItemDecimal(i,"dc_cantid")
	this.SetItem(i,"dc_subtot",lc_valortot)
	ll_valor= this.GetItemDecimal(i,"cc_total")
	this.SetItem(i,"dc_total",ll_valor)		


   /*****/

	//lc_factor = this.GetitemDecimal(i,"dc_utilidad")/100 
	lc_factor = this.object.dc_utilidad[i]/100
  	lc_costo = this.object.cc_total[i]/ &
	                  this.object.dc_cantid[i]
//	  this.GetItemDecimal(i,"cc_total") /&
//	                 this.GetItemDecimal(i,"dc_cantid")
	lc_costunit = lc_costo						
  	lc_costo = round(lc_costo - lc_costo*lc_descab,2)
     /*El nuevo precio no debe depender de la caracter$$HEX1$$ed00$$ENDHEX$$stica del proveedor */
	 /*a todos los items se debe inflar el 5% virtual*/
//  	if ii_excento_iva = 0 then
// 	lc_newprecio	= round(lc_costo  / (1 - lc_factor),2)
     lc_newprecio = round(lc_costunit  / (1 - lc_factor),2)
//	else
//   lc_newprecio	= round((lc_costo * (1 + lc_indice) * ii_excento_iva) / (1 - lc_factor),2)		
//   lc_newprecio = (lc_costunit/(1 - lc_factor))/0.95
//	end if

	lc_newprecio = lc_newprecio/.95
   this.setitem(i,"dc_nuepre", lc_newprecio)
	  
next	
wf_actualiza_suma()
return 1

end event

event dw_detail::updatestart;call super::updatestart;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n : 
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 30/03/1998  17:31

/*********************************************************************/

int li, li_max,i=0,li_i
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

li_max = this.rowcount()
//if isnull(dw_detail.GetitemString(max,'nombre')) then
//	max = max -1
//end if

// asigna en el detalle el secuencial y el saldo de cada fila
For li = 1 to li_max
	dw_detail.SetItem(li,'dc_secue',li)
//	dw_detail.SetItem(li,'dc_saldo',dw_detail.GetItemNumber(li,'dc_cantid'))
next

//dw_detail.Object.dc_saldo.Primary = dw_detail.Object.dc_cantid.Primary
//dw_detail.Object.dc_total.Primary = dw_detail.Object.cc_total.Primary

Return 0
end event

type dw_report from w_sheet_master_detail`dw_report within w_importacion_transito
integer x = 5
integer y = 0
integer width = 2921
integer height = 1276
integer taborder = 30
string dataobject = "d_rep_compra"
end type

type dw_ubica from datawindow within w_importacion_transito
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 338
integer y = 108
integer width = 2400
integer height = 264
integer taborder = 90
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Factura de Compra"
string dataobject = "d_sel_factura_compras"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

event buttonclicked;//string ls_tipo, ls_criterio
//long ll_found,ll_recep, ll_numero
//
//         this.accepttext()
//		ls_tipo = this.GetItemString(1,"tipo")
//		ll_numero = this.GetitemNumber(1,"ticket")		
//		ll_recep = this.GetitemNumber(1,"factura")
//		If isnull(ll_numero) and isnull(ll_recep) Then
//			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Compra o Recepci$$HEX1$$f300$$ENDHEX$$n")
//			return
//		End if
//		CHOOSE CASE ls_tipo
//			CASE 'B'
//				If not isnull(ll_numero) Then ls_criterio = "co_numero ="+string(ll_numero)
//				If not isnull(ll_recep) Then ls_criterio = "co_numpad ="+string(ll_recep)
//				If not isnull(ll_numero) and not isnull(ll_recep) Then 
//					ls_criterio = "co_numero ="+string(ll_numero)+" and co_numpad ="+string(ll_recep)
//				End if
//				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
//				if ll_found > 0 and not isnull(ll_found) then
//				  dw_master.SetFocus()
//				  dw_master.ScrollToRow(ll_found)
//				  dw_master.SetRow(ll_found)
//				  this.Visible = false
//	  			else
//				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Compra no se encuentra, verifique datos')
//				  return
//			  end if
//		   CASE 'F'
////				If not isnull(ll_numero) Then ls_criterio like "co_numero ="+string(ll_numero)
////				If not isnull(ll_recep) Then ls_criterio = "co_numpad like"+string(ll_recep)
////				If not isnull(ll_numero) and not isnull(ll_recep) Then 
////					ls_criterio = "co_numero like"+string(ll_numero)+" and co_numpad like"+string(ll_recep)
////				End if
////				dw_master.SetFilter(ls_criterio)
////				If dw_master.Filter() <> 1 Then 
////					messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Compra no encontrada, verifique datos')
////					return
////				End if
////				dw_master.SetFocus()
////				this.Visible = false	
////				dw_master.ScrollToRow(dw_master.GetRow())
////				dw_master.SetRow(dw_master.GetRow())				
//		END CHOOSE

		
		
/* VERSION PARA RECUPERAR UNA POR UNA LA ORDEN DE COMPRA*/

Long ll_numero,ll_nreg,ll_recep,ll_filam
string ls_prove,ls_venpro,ls_filtro,ls_rucci
datawindowchild ldwc_aux

ll_numero = this.GetitemNumber(1,"ticket")		
ll_recep = this.GetitemNumber(1,"factura")
ll_filam = dw_master.getrow() 

If isnull(ll_numero) and isnull(ll_recep) Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Compra o Recepci$$HEX1$$f300$$ENDHEX$$n")
	return
End if

		
ll_nreg = dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'3',ll_numero)
ls_prove = dw_master.getItemstring(ll_filam,'pv_codigo')
ls_venpro = dw_master.getItemstring(ll_filam,'vp_codigo')		
ls_filtro = "pv_codigo = '"+ ls_prove + "' and vp_codigo ='"+ls_venpro+"'"
dw_master.getChild("vp_codigo", ldwc_aux)
ldwc_aux.SetFilter(ls_filtro)
ldwc_aux.Filter()
dw_master.SetItem(ll_filam,'vp_codigo',ls_venpro)		
select pv_rucci
into :ls_rucci
from in_prove
where em_codigo = :str_appgeninfo.empresa
and 	pv_codigo = :ls_prove;		
dw_master.modify("st_ruc.text = '"+ls_rucci+"'")
dw_master.SetItemStatus(ll_filam,0,Primary!,notmodified!)		

if ll_nreg <= 0 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones <Por favor verifique>")
	return
end if
if ll_nreg = 1 then
dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'3',ll_numero)
end if	

end event

type cb_1 from commandbutton within w_importacion_transito
integer y = 668
integer width = 521
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Capturar pedido"
end type

event clicked;String ls_itcodant,ls_imp,ls_pvcodigo
Long   ll_cantidad,i,ll_new,ll_filact
Long   ll_filactmaster,ll_totfilas,ll_fila 
decimal lc_valorsum,lc_transporte,lc_suma1,lc_subtot,lc_ivavalor,lc_valor,lc_valortot
w_frame_basic lw_frame


lw_frame  = parent.parentwindow()
lw_frame.setMicrohelp("Tomando pedido, espere por favor...")

Setpointer(Hourglass!)

if not isvalid(gds_importacion) then return

ll_filActMaster = dw_master.getrow() 

ls_pvcodigo = dw_master.GetItemString(ll_filActMaster,"pv_codigo") 

//if isnull(ls_pvcodigo) or ls_pvcodigo = "" then
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Antes de capturar el pedido debe seleccionar un proveedor.",Exclamation!)
//	Return
//end if	

/*Sube el pedido*/
dw_detail.setredraw(false)
dw_detail.reset()
for i = 1 to gds_importacion.rowcount()
	
	ls_itcodant = gds_importacion.GetItemstring(i,"it_codant")
	ll_cantidad = gds_importacion.Getitemnumber(i,"it_cantidad")
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


HA$PBExportHeader$w_compra_multiples_recepciones.srw
$PBExportComments$Pendiente.Si.Actualmente trabajando(10/01/07)Compras de productos de una empresa.Vale
forward
global type w_compra_multiples_recepciones from w_sheet_master_tabpage_detail
end type
type dw_compra from datawindow within w_compra_multiples_recepciones
end type
type dw_ubica from datawindow within w_compra_multiples_recepciones
end type
type dw_listarecep from datawindow within w_compra_multiples_recepciones
end type
end forward

global type w_compra_multiples_recepciones from w_sheet_master_tabpage_detail
integer width = 4384
integer height = 2536
string title = "Factura de compra V1.6"
event ue_consultar pbm_custom16
event ue_printcancel pbm_custom13
dw_compra dw_compra
dw_ubica dw_ubica
dw_listarecep dw_listarecep
end type
global w_compra_multiples_recepciones w_compra_multiples_recepciones

type variables
decimal ic_iva
Long  il_nros[]
Integer ii_numpag
long ii_excento_iva
date id_fecrecep
string  is_mensaje, is_estado='3',is_contribuyente_especial
datawindow  idw_m,idw_d,&
                      idw_cr,&
				  idw_p1,&
				  idw_fp
datastore ids_movim,ids_recep
	
end variables

forward prototypes
public function integer wf_preprint ()
public function boolean wf_costo_promedio (string as_item, decimal ad_cantidad, long al_costo)
public function integer wf_actualiza_suma ()
public function integer wf_anular_deuda ()
public function integer wf_items_compra ()
public function integer wf_aplica_retenciones ()
public function integer wf_notadebito ()
public function integer wf_pago_cxp (string as_sucursal, long al_conumero, string as_pvcodigo, string as_facpro, long al_numdoc, string as_autsri, string as_preimp, decimal ac_valor, string as_fpcodigo, string as_codpct, decimal ac_porcentaje, string as_mpcodigo)
public function integer wf_find_factura ()
public function integer wf_add_recepciones (string as_pvcodigo)
protected function boolean wf_mov_inventario (string as_item, string as_numero, decimal ad_cantidad, date ad_fecha, long al_costo)
end prototypes

event ue_consultar;dw_master.postevent(DoubleClicked!)
dw_master.Object.w_observacion.text = '          '
tab_detail.tabpage_detail1.dw_detail1.enabled = false
dw_master.enabled = false


end event

event ue_printcancel;w_frame_basic lw_frame
m_frame_basic lm_frame

if this.wf_postPrint() = 1 then
	this.setRedraw(False)
	dw_report.enabled = False
	dw_report.visible = False
	dw_master.enabled = true
	dw_master.visible = True
	tab_detail.tabpage_detail1.dw_detail1.enabled = true
	tab_detail.tabpage_detail1.dw_detail1.visible = True
	this.ib_inReportMode = False
	this.triggerEvent(resize!)		// so the master and detail get the correct size
	lw_frame = this.parentWindow()
	lm_frame = lw_frame.menuid
	lm_frame.mf_outof_report_mode()
	this.setRedraw(True)
end if
end event

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
decimal ll_subtot,ll_suma, ld_canti,ll_suma1, lc_newprecio
decimal lc_precio, lc_costo, lc_factor,lc_subtrf0,lc_subtotal
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
	ic_iva = f_iva_compras()
	ii_excento_iva = 1
end if

//inicializo la fila actual
if tab_detail.tabpage_detail1.dw_detail1.AcceptText() <> 1 then return -1

	ll_totFilas = tab_detail.tabpage_detail1.dw_detail1.rowCount()
	for ll_fila = 1 to ll_totFilas
  	    ll_valorsum += tab_detail.tabpage_detail1.dw_detail1.GetItemDecimal(ll_fila,"cc_total")
	next
	

     lc_subtotal = tab_detail.tabpage_detail1.dw_detail1.GetItemDecimal(1,"cc_subtotal")
     lc_subtrf0 =  tab_detail.tabpage_detail1.dw_detail1.GetItemDecimal(1,"cc_subtrf0")
	 
   //  dw_master.setItem(ll_filActMaster,"co_subtot",ll_valorsum)
    dw_master.setItem(ll_filActMaster,"co_subtot",lc_subtotal)
 	dw_master.Setitem(ll_filActMaster,"co_subtrf0",lc_subtrf0)
// actualiza los campos Total, Iva y Saldo en el maestro

 	lc_transporte  =dw_master.GetItemDecimal(ll_filActMaster,"co_transpor")
 	if isnull(lc_transporte) then
		 lc_transporte = 0
 	end if
 	ll_suma1=dw_master.GetItemDecimal(ll_filActMaster,"co_subtot")
 	ll_subtot= ll_suma1 - (ll_suma1*dw_master.GetItemDecimal(ll_filActMaster,"co_descup"))

	ll_ivavalor= round(ll_subtot*ic_iva,2)*ii_excento_iva
 	dw_master.SetItem(ll_filActMaster,"co_iva",ll_ivavalor)
   	dw_master.SetItem(ll_filActMaster,"co_total",ll_subtot + ll_ivavalor + lc_transporte + lc_subtrf0)

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

//if ld_feccompra <> ld_hoy then
//	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La factura que desea anular no es de hoy d$$HEX1$$ed00$$ENDHEX$$a...No se puede anular la compra")
//   return -1	
//end if	

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

public function integer wf_items_compra ();integer i,li_nreg,ll_new,ll_found
string ls_item
char lch_kit,lch_actualiza
dec{2} lc_cantid,lc_utilidad,lc_preact,lc_nuepre
dec{4} lc_costo,lc_total

li_nreg = tab_detail.tabpage_detail1.dw_detail1.rowcount()

for i = 1 to li_nreg
	ls_item = tab_detail.tabpage_detail1.dw_detail1.getItemstring(i,"it_codigo")
	lc_cantid = tab_detail.tabpage_detail1.dw_detail1.getItemdecimal(i,"dc_cantid")
	lc_total = tab_detail.tabpage_detail1.dw_detail1.getItemdecimal(i,"cc_totalaux")	
	lch_kit = tab_detail.tabpage_detail1.dw_detail1.getItemstring(i,"it_kit")		
	lch_actualiza = tab_detail.tabpage_detail1.dw_detail1.GetItemString(i,"dc_actualiza")	
	lc_utilidad = tab_detail.tabpage_detail1.dw_detail1.GetItemdecimal(i,"dc_utilidad")		
	lc_preact = tab_detail.tabpage_detail1.dw_detail1.GetItemdecimal(i,"dc_preact")	
	lc_nuepre = tab_detail.tabpage_detail1.dw_detail1.GetItemdecimal(i,"dc_nuepre")		
	ll_found = dw_compra.find("it_codigo = '"+ls_item+"'",1,dw_compra.rowcount())
	if ll_found <> 0 then
		lc_cantid = lc_cantid + dw_compra.getitemdecimal(ll_found,"dc_cantid")
		dw_compra.Setitem(ll_found,"dc_cantid",lc_cantid)			
		lc_total = lc_total + dw_compra.getitemdecimal(ll_found,"dc_total")
		dw_compra.Setitem(ll_found,"dc_total",lc_total)
		lc_costo = lc_total / lc_cantid
		dw_compra.Setitem(ll_found,"dc_costo",lc_costo)
	else
		ll_new = dw_compra.insertrow(0)
		dw_compra.SetItem(ll_new,"it_codigo",ls_item)
		dw_compra.Setitem(ll_new,"dc_total",lc_total)		
		dw_compra.Setitem(ll_new,"dc_costo",lc_total / lc_cantid)				
		dw_compra.SetItem(ll_new,"dc_cantid",lc_cantid)
		dw_compra.SetItem(ll_new,"it_kit",lch_kit)	
		dw_compra.setitem(ll_new,"dc_actualiza",lch_actualiza)	
		dw_compra.setitem(ll_new,"dc_utilidad",lc_utilidad)		
		dw_compra.setitem(ll_new,"dc_preact",lc_preact)	
		dw_compra.setitem(ll_new,"dc_nuepre",lc_nuepre)
	end if
Next	
return 1
end function

public function integer wf_aplica_retenciones ();Long             ll_filact,ll_row,ll_numdoc,ll_conumero
Decimal{2}    lc_basefte,lc_totalprov,lc_baseimp,&
                     lc_retfte,lc_ivaprov,l_flete,lc_retiva,lc_poriva,&
		           lc_porfte,lc_porcentaje,&
				 lc_bseimpbie,lc_retivabie,lc_pctbie,&
				 lc_bseimpsrv,lc_retivasrv,lc_pctsrv
String            ls_corucsuc,ls_mpcodigo,ls_mpcoddeb,&
                     ls_eccodigo,ls_cofacpro,ls_pvcodigo,ls_autsri,&
		           ls_preimp,ls_codpct,ls_codpctbie,ls_codpctsrv
Date             ld_fecha,ld_femision


SetPointer(Hourglass!)

lc_totalprov = 0
lc_retfte = 0
lc_retiva = 0

idw_m.AcceptText()


ll_filact    = idw_m.GetRow()
idw_m.ScrollToRow(ll_filact)

/*Para registrar  informacion de la factura del proveedor*/
ll_conumero      = idw_m.GetItemNumber(ll_filact,"co_numero")
ls_pvcodigo      = idw_m.GetItemString(ll_filact,"pv_codigo")
ls_cofacpro      = idw_m.GetItemString(ll_filact,"co_facpro")
ls_eccodigo      = idw_m.GetItemString(ll_filact,"ec_codigo")
ls_corucsuc     = idw_m.GetItemString(ll_filact,"co_rucsuc")
ld_fecha           = Date(idw_m.GetItemDateTime(ll_filact,"co_fecha"))



/**/
ll_row = idw_cr.getrow()
if ll_row <= 0 then return -1
ls_mpcodigo =  idw_cr.Object.mp_codigo[ll_row]


/*Los porcentajes de retenci$$HEX1$$f300$$ENDHEX$$n en la fuente e iva var$$HEX1$$ed00$$ENDHEX$$an de acuerdo al proveedor
Por eso seleccionamos los % asignados a cada proveedor*/

/*Datos del cr$$HEX1$$e900$$ENDHEX$$dito*/
lc_totalprov  =  round(idw_cr.GetItemDecimal(ll_row,"mp_valor"),2)
lc_baseimp   =  round(idw_cr.GetItemDecimal(ll_row,"mp_baseimp"),2)
lc_ivaprov    =  round(idw_cr.GetItemDecimal(ll_row,"mp_valret"),2)


/*Datos de las retenciones*/
/* bienes*/
lc_bseimpbie  =  round(idw_cr.GetItemDecimal(ll_row,"mp_biemntiva"),2)
ls_codpctbie  = idw_cr.GetItemString(ll_row,"mp_biepctiva")
lc_retivabie    =  round(idw_cr.GetItemDecimal(ll_row,"mp_bievlrret"),2)
if lc_bseimpbie <> 0 then 
lc_pctbie        = (lc_retivabie/lc_bseimpbie)*100
else
lc_pctbie = 0
end if


/* servicios*/
lc_bseimpsrv  =  round(idw_cr.GetItemDecimal(ll_row,"mp_srvmntiva"),2)
ls_codpctsrv  =  idw_cr.GetItemString(ll_row,"mp_srvpctiva")
lc_retivasrv    =  round(idw_cr.GetItemDecimal(ll_row,"mp_srvvlrret"),2)
if lc_bseimpsrv <> 0 then 
lc_pctsrv        = (lc_retivasrv/lc_bseimpsrv)*100
else
lc_pctsrv = 0
end if




/*En la fuente*/
lc_basefte   =  round(idw_cr.GetItemDecimal(ll_row,"cc_basefte"),2)
ls_codpct     = idw_cr.GetItemString(ll_row,"mp_codpctfte")
lc_retfte    =  round(idw_cr.GetItemDecimal(ll_row,"retfte"),2)
if lc_basefte <> 0 then 
lc_porcentaje = (lc_retfte/lc_basefte)*100
else
lc_porcentaje = 0
end if




/*Retenciones solo sobre la  : FACTURA*/
lc_retiva =  round((lc_ivaprov)*(lc_poriva/100),2) /*Retenci$$HEX1$$f300$$ENDHEX$$n del IVA*/

/*2.- */
/*Realizar  los mov de  debito por las retenciones y las notas de debito*/

/*Registrar la retenci$$HEX1$$f300$$ENDHEX$$n*/
If lc_retfte <> 0 then
	
    /*Determinar el secuencial del tipo de pago*/
	SELECT PS_VALOR,PS_NAUT
	INTO:ll_numdoc,:ls_autsri
	FROM PR_NUMSUC
	WHERE PR_NOMBRE = 'RET'
	AND SU_CODIGO  = :ls_corucsuc
	FOR UPDATE OF PS_VALOR;
	
	UPDATE PR_NUMSUC
	SET PS_VALOR = PS_VALOR + 1
	WHERE PR_NOMBRE = 'RET'
	AND SU_CODIGO  = :ls_corucsuc;
	IF SQLCA.SQLCODE < 0 &	
	THEN
	MESSAGEBOX("ATENCION","Problemas al Actualizar el secuencial del tipo de pago" +sqlca.sqlerrtext)
	ROLLBACK;
	RETURN -1
	END IF
	
	If wf_pago_cxp(ls_corucsuc,ll_conumero,ls_pvcodigo,ls_cofacpro,ll_numdoc,ls_autsri,ls_preimp,lc_retfte,'6','312',lc_porcentaje,ls_mpcodigo) < 0 &
	Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar la Retenci$$HEX1$$f300$$ENDHEX$$n en la Fuente")
	Rollback;
	Return -1
	End if
	
End if

/*Registrar la retenci$$HEX1$$f300$$ENDHEX$$n del IVA*/
If lc_retivabie <> 0 then

	/*Determinar el secuencial del tipo de pago*/
	SELECT PS_VALOR,PS_NAUT
	INTO:ll_numdoc,:ls_autsri
	FROM PR_NUMSUC
	WHERE PR_NOMBRE = 'RET' 
	AND SU_CODIGO  = :ls_corucsuc
	FOR UPDATE OF PS_VALOR;
	
	UPDATE PR_NUMSUC
	SET PS_VALOR = PS_VALOR + 1
	WHERE PR_NOMBRE = 'RET' 
	AND SU_CODIGO  = :ls_corucsuc;
	IF SQLCA.SQLCODE < 0 &	
	THEN
	MESSAGEBOX("ATENCION","Problemas al Actualizar el secuencial del tipo de pago" +sqlca.sqlerrtext)
	ROLLBACK;
	RETURN -1
	END IF
	
	
	If wf_pago_cxp(ls_corucsuc,ll_conumero,ls_pvcodigo,ls_cofacpro,ll_numdoc,ls_autsri,ls_preimp,lc_retivabie,'7',ls_codpctbie,lc_pctbie,ls_mpcodigo) < 0 &
	Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar la Retenci$$HEX1$$f300$$ENDHEX$$n de IVA...")
	Rollback;
	Return -1
	End if
	
End if

Return 1






end function

public function integer wf_notadebito ();String         ls_mpcodigo,ls_mpcoddeb,ls_autsri,ls_cofacpro,ls_sucursal,ls_nest,ls_npto,ls_nsec,ls_tvcodigo
Long          ll_numdoc
Date           ld_emision
Decimal{2} lc_valor,lc_baseimp,lc_iva,lc_ivadebito,lc_rftedebito,lc_rivadebito

lc_iva = f_iva()

/*Informaci$$HEX1$$f300$$ENDHEX$$n de la NOTA de Debito*/
lc_valor         = idw_p1.Object.mp_valor[1]
lc_iva             = idw_p1.Object.mp_valret[1]
lc_baseimp    = idw_p1.Object.mp_baseimp[1]
ls_nest          = idw_p1.Object.mp_docnroest[1]
ls_npto          = idw_p1.Object.mp_docnropto[1]
ls_nsec         = idw_p1.Object.mp_docnrosec[1]
ls_cofacpro  =  idw_p1.Object.co_facpro[1]
ls_autsri        = idw_p1.Object.mp_naut[1]
ld_emision     = date(idw_p1.Object.mp_fecemision[1])
ls_nsec         = idw_p1.Object.mp_docnrosec[1]
ls_mpcoddeb = idw_p1.Object.mp_codigo[1]

/**/
ls_tvcodigo = idw_cr.Object.tv_codigo[1]
ls_mpcodigo  = idw_cr.Object.mp_codigo[1]
ls_sucursal  =  idw_cr.Object.su_codigo[1]


/**/
INSERT INTO "CP_PAGO"  
( "TV_CODIGO","TV_TIPO","EM_CODIGO","SU_CODIGO","MP_CODIGO",   
"PM_SECUENCIA","PM_FECHA","PM_VALOR","PM_FECPA","PM_INTER",   
"PM_CXP","IF_CODIGO","CN_CODIGO","PM_DESCUE","ESTADO",   
"FP_CODIGO","PM_NUMDOC","PM_NAUT","PM_EMISION","PM_PREIMP","PM_NROEST","PM_NROPTO","PM_NROSEC" )  
VALUES ('2','D',:str_appgeninfo.empresa,:ls_sucursal,:ls_mpcoddeb,   
		1,sysdate,:lc_valor,sysdate,null,   
		null,0,null,0,null,   
'101',:ls_mpcoddeb,:ls_autsri,:ld_emision,:ls_cofacpro,:ls_nest,:ls_npto,:ls_nsec);
IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Registrar el pago" +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
END IF
	

/*Cruzar cada pago con el credito */
INSERT INTO "CP_CRUCE"  
			( "TV_CODDEB","TV_TIPODEB","MP_CODDEB","TV_CODIGO","TV_TIPO",   
			  "EM_CODIGO","SU_CODIGO", "MP_CODIGO","CX_FECHA","CX_VALCRE",
			  "CX_VALDEB","ESTADO" )  
VALUES ( '2','D',:ls_mpcoddeb,'1','C',
		  :str_appgeninfo.empresa,:ls_sucursal,:ls_mpcodigo,sysdate,:lc_valor,   
		  0,null )  ;
IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Cruzar el pago" +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
END IF

UPDATE CP_MOVIM
SET MP_SALDO = MP_SALDO - :lc_valor,
MP_NOTAND = :lc_valor,
MP_IVAND = (:lc_valor/1.12)*0.12,
MP_RFTEND = (:lc_valor/1.12)*0.01
WHERE TV_CODIGO = :ls_tvcodigo
AND TV_TIPO = 'C'
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :ls_sucursal
AND MP_CODIGO = :ls_mpcodigo;

IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Actualizar el saldo del cr$$HEX1$$e900$$ENDHEX$$dito" +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
END IF


RETURN 1




end function

public function integer wf_pago_cxp (string as_sucursal, long al_conumero, string as_pvcodigo, string as_facpro, long al_numdoc, string as_autsri, string as_preimp, decimal ac_valor, string as_fpcodigo, string as_codpct, decimal ac_porcentaje, string as_mpcodigo);String ls_mpcoddeb,ls_autsri
Long ll_numdoc,ll_rowd2
Decimal{2} lc_iva,lc_ivadebito,lc_rftedebito,lc_rivadebito,lc_bseimp,lc_base0,lc_basegrav,lc_basenograv




/**/
ll_rowd2 = idw_cr.getrow()
lc_base0         =  idw_cr.object.mp_bseimptrf0[ll_rowd2]
lc_basegrav     =  idw_cr.object.mp_baseimp[ll_rowd2]
lc_basenograv =  idw_cr.object.mp_bseimpice[ll_rowd2]

lc_bseimp = (ac_valor/ac_porcentaje)*100

/*Determinar el secuencial del mov. de debito*/

ls_mpcoddeb = string(f_secuencial(str_appgeninfo.empresa,'DEB_CXP'))

/**/
INSERT INTO "CP_MOVIM"  
				 ("TV_CODIGO","TV_TIPO","EM_CODIGO","SU_CODIGO","MP_CODIGO",   
				  "PV_CODIGO","EC_CODIGO","CO_NUMERO","RF_CODIGO","MP_FECHA",   
				  "MP_VALOR","MP_VALRET","MP_SALDO","ESTADO","MP_CONTAB",   
				  "MP_TRANSPORTE","EG_NUMERO","CO_FACPRO","MP_BASEIMP","MP_OBSERV",   
				  "MP_RETEN","MP_RETIVA","MP_NAUT","MP_FECEMISION","MP_PREIMP" )  
VALUES ('2','D',:str_appgeninfo.empresa,:as_sucursal,:ls_mpcoddeb,   
	:as_pvcodigo,null,:al_conumero,null,sysdate,
	:ac_valor,0,0,null,null,
	0,null,:as_facpro,0,'Pago Factura',
	0,0,:as_autsri,sysdate,:as_preimp);
	
IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Actualizar el Mov. de D$$HEX1$$e900$$ENDHEX$$bito" + sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
END IF
	


/**/
INSERT INTO "CP_PAGO"  
( "TV_CODIGO","TV_TIPO","EM_CODIGO","SU_CODIGO","MP_CODIGO",   
"PM_SECUENCIA","PM_FECHA","PM_VALOR","PM_FECPA","PM_INTER",   
"PM_CXP","IF_CODIGO","CN_CODIGO","PM_DESCUE","ESTADO",   
"FP_CODIGO","PM_NUMDOC","PM_NAUT","PM_EMISION","PM_PREIMP","PM_BSEIMP","PM_CODPCT","PM_PORCTJE",
"PM_BASE0","PM_BASEGRAV","PM_BASENOGRAV")  
VALUES ('2','D',:str_appgeninfo.empresa,:as_sucursal,:ls_mpcoddeb,   
		1,sysdate,:ac_valor,sysdate,null,   
		null,0,null,0,null,   
:as_fpcodigo,:al_numdoc,:as_autsri,sysdate,:as_preimp,:lc_bseimp,:as_codpct,:ac_porcentaje,:lc_base0,:lc_basegrav,:lc_basenograv);
IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Registrar el pago" +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
END IF
	

/*Cruzar cada pago con el credito */
INSERT INTO "CP_CRUCE"  
			( "TV_CODDEB","TV_TIPODEB","MP_CODDEB","TV_CODIGO","TV_TIPO",   
			  "EM_CODIGO","SU_CODIGO", "MP_CODIGO","CX_FECHA","CX_VALCRE",
			  "CX_VALDEB","ESTADO" )  
VALUES ('2','D',:ls_mpcoddeb,'1','C',
		  :str_appgeninfo.empresa,:as_sucursal,:as_mpcodigo,sysdate,:ac_valor,   
		  0,null )  ;
IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Cruzar el pago" +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
END IF


/*Actualizar el saldo*/
UPDATE "CP_MOVIM"
SET "MP_SALDO" = "MP_SALDO" - :ac_valor
WHERE "EM_CODIGO" = :str_appgeninfo.empresa
AND "SU_CODIGO"= :as_sucursal
AND "MP_CODIGO"= :as_mpcodigo
AND "TV_CODIGO"= '1'
AND "TV_TIPO"  ='C';
IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Actualizar la Cuenta por Pagar" +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
END IF


RETURN 1
end function

public function integer wf_find_factura ();/*Busca la compra*/
long ll_count,ll_row
String ls_cofacpro,ls_corucsuc,ls_pvcodigo


ll_row = idw_m.getrow()

ls_cofacpro = idw_m.GetItemString(ll_row,"co_facpro")
ls_pvcodigo = idw_m.GetItemString(ll_row,"pv_codigo")
ls_corucsuc = idw_m.GetItemString(ll_row,"co_rucsuc")


SELECT COUNT (*) 
INTO :ll_count
FROM CP_MOVIM 
WHERE (TV_TIPO = 'C' 
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :ls_corucsuc 
AND PV_CODIGO = :ls_pvcodigo
AND EC_CODIGO = '3' 
AND CO_FACPRO = :ls_cofacpro)
AND TV_CODIGO = '1' ;

return ll_count
end function

public function integer wf_add_recepciones (string as_pvcodigo);Int i,li_pagaiva
Long ll_new,ll_secue
String ls_codant,ls_nombre,lch_kit,ls_codigo
Dec{2} ld_cantid
Dec{4} lc_costo_p,lc_desc1_p,lc_desc2_p,lc_desc3_p,lc_precio,&
            lc_costo,lc_desc1,lc_desc2,lc_desc3 ,&
		  lc_pvp,a,b,C

DECLARE det_fact CURSOR FOR  
SELECT "IN_ITEM"."IT_CODANT","IN_ITEM"."IT_NOMBRE","IN_ITEM"."IT_KIT","IN_ITEM"."IT_TIEMSEC","IN_ITEM"."IT_PREFAB",
"IN_DETCO"."IT_CODIGO","IN_DETCO"."DC_CANTID",
"IN_DETCO"."DC_SECUE","IN_DETCO"."DC_COSTO",
"IN_DETCO"."DC_DESC1","IN_DETCO"."DC_DESC2",
"IN_DETCO"."DC_DESC3"				 
FROM "IN_DETCO",   
"IN_ITEM"  
WHERE ( "IN_DETCO"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO" ) and 
( "IN_DETCO"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO" ) and
( "IN_DETCO"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
( "IN_DETCO"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
( "IN_DETCO"."EC_CODIGO" = '2' ) AND  
( "IN_DETCO"."CO_NUMERO" = :il_nros[i])
ORDER BY "IN_DETCO"."DC_SECUE";

idw_d.reset()


FOR i = 1 to  upperbound(il_nros)
	open det_fact;		
	do

		fetch det_fact 
		 into :ls_codant,:ls_nombre,:lch_kit,:li_pagaiva,:lc_precio,:ls_codigo, :ld_cantid, :ll_secue,
		      :lc_costo_p, :lc_desc1_p, :lc_desc2_p, :lc_desc3_p;
		if sqlca.sqlcode <> 0 then
			exit;
		end if
		
		// encuentra el precio de f$$HEX1$$e100$$ENDHEX$$brica de cada item del detalle
		
		idw_d.SetFocus()
		ll_new = idw_d.InsertRow(0)
	
           /*Tomar de la lista de precios por fabricante*/
            select nvl(ip_plista,0),nvl(ip_desc1,0) , nvl(ip_desc2,0), nvl(ip_desc3,0)
		  into    :lc_costo,:lc_desc1,:lc_desc2,:lc_desc3
		  from    in_itepro
            where   em_codigo = :str_appgeninfo.empresa
		  and     it_codigo = :ls_codigo
		  and     pv_codigo = :as_pvcodigo;
		  
            if sqlca.sqlcode <> 0 then
     	       lc_costo = lc_costo_p 
			  lc_desc1 = lc_desc1_p
			  lc_desc2 = lc_desc2_p
			  lc_desc3 = lc_desc3_p
	       end if	
      

//		inserto datos en el detalle del dw
//        lc_pvp  = lc_precio*.95

		idw_d.SetItem(ll_new,'dc_preact',lc_precio)
		idw_d.SetItem(ll_new,'dc_secue',ll_new)
		idw_d.SetItem(ll_new,'codant',ls_codant)
		idw_d.SetItem(ll_new,'nombre',ls_nombre)
		idw_d.SetItem(ll_new,'it_codigo',ls_codigo)
		idw_d.SetItem(ll_new,'it_kit',lch_kit)
		idw_d.SetItem(ll_new,'it_tiemsec',li_pagaiva)
		idw_d.SetItem(ll_new,'dc_cantid',ld_cantid)
		idw_d.setitem(ll_new, 'em_codigo', str_appgeninfo.empresa)
		idw_d.setitem(ll_new, 'su_codigo', str_appgeninfo.sucursal)		
		idw_d.setitem(ll_new, 'bo_codigo', str_appgeninfo.seccion)
		idw_d.SetItem(ll_new,"ec_codigo",is_estado)		
		idw_d.setitem(ll_new, 'dc_costo', lc_costo)
		idw_d.setitem(ll_new, 'dc_desc1', lc_desc1)
		idw_d.setitem(ll_new, 'dc_desc2', lc_desc2)
		idw_d.setitem(ll_new, 'dc_desc3', lc_desc3)
		idw_d.Setitem(ll_new,'co_numpad',il_nros[i])
	
		idw_d.SetItem(ll_new,"dc_subtot",lc_costo * ld_cantid)
		a = lc_costo - (lc_costo * (lc_desc1/100))
		b = a - ( a * (lc_desc2/100))
		c = ld_cantid * ( b - ( b * (lc_desc3/100)))
				
		idw_d.SetItem(ll_new,"dc_total", c)


	loop while TRUE;
  close det_fact;
NEXT

RETURN 1
end function

protected function boolean wf_mov_inventario (string as_item, string as_numero, decimal ad_cantidad, date ad_fecha, long al_costo);long ll_num_movim,ll_costo

select pr_valor
  into :ll_num_movim
  from pr_param
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_MINV';


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

on w_compra_multiples_recepciones.create
int iCurrent
call super::create
this.dw_compra=create dw_compra
this.dw_ubica=create dw_ubica
this.dw_listarecep=create dw_listarecep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_compra
this.Control[iCurrent+2]=this.dw_ubica
this.Control[iCurrent+3]=this.dw_listarecep
end on

on w_compra_multiples_recepciones.destroy
call super::destroy
destroy(this.dw_compra)
destroy(this.dw_ubica)
destroy(this.dw_listarecep)
end on

event open;string ls_parametro[]
datawindowchild ldwc_fp,dwc_mov,dwc_proveedor    
Long ll_numero





dw_master.getChild("fp_codigo", ldwc_fp)
ldwc_fp.setTransObject(sqlca)
ldwc_fp.retrieve(str_appgeninfo.empresa)
ldwc_fp.setfilter("fp_string like '%C%'")
ldwc_fp.filter()


ls_parametro[1] =  str_appgeninfo.sucursal
ls_parametro[2] = '2'

f_recupera_datos(dw_master,"co_numpad", ls_parametro,2)
f_recupera_empresa(dw_master,"pv_codigo") 

istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = is_estado



call super::open
//dw_master.is_SerialCodeColumn = "co_numero"
//dw_master.is_SerialCodeType = "COMPRA"
//dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//tab_detail.tabpage_detail1.dw_detail1.is_serialCodeDetail = "dc_secue"

dw_master.ii_nrCols = 6
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "co_numero"
dw_master.is_connectionCols[4] = "co_rucsuc"
dw_master.is_connectionCols[5] = "co_facpro"
dw_master.is_connectionCols[6] = "pv_codigo"



/*Detalle de items*/
tab_detail.tabpage_detail1.dw_detail1.is_connectionCols[1] = "em_codigo"
tab_detail.tabpage_detail1.dw_detail1.is_connectionCols[2] = "su_codigo"
tab_detail.tabpage_detail1.dw_detail1.is_connectionCols[3] = "co_numero"
tab_detail.tabpage_detail1.dw_detail1.uf_setArgTypes()

/*Cuenta por pagar*/
tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[1] = "em_codigo"
tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[4] = "su_codigo"
tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[3] = "co_numero"
//tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[4] = ""
tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[5] = "co_facpro"
tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[6] = "pv_codigo"
tab_detail.tabpage_detail2.dw_detail2.uf_setArgTypes()

/*Nota de  cr$$HEX1$$e900$$ENDHEX$$dito*/
tab_detail.tabpage_detail3.dw_detail3.is_connectionCols[1] = "em_codigo"
tab_detail.tabpage_detail3.dw_detail3.is_connectionCols[2] = "su_codigo"
tab_detail.tabpage_detail3.dw_detail3.is_connectionCols[3] = "co_numero"
tab_detail.tabpage_detail3.dw_detail3.is_connectionCols[5] = "co_facpro"
tab_detail.tabpage_detail3.dw_detail3.is_connectionCols[6] = "pv_codigo"
tab_detail.tabpage_detail3.dw_detail3.uf_setArgTypes()

/*Detalle de la negociacion*/
tab_detail.tabpage_detail4.dw_detail4.is_connectionCols[1] = "em_codigo"
tab_detail.tabpage_detail4.dw_detail4.is_connectionCols[2] = "su_codigo"
tab_detail.tabpage_detail4.dw_detail4.is_connectionCols[3] = "co_numero"
tab_detail.tabpage_detail4.dw_detail4.uf_setArgTypes()





//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()
dw_master.uf_insertCurrentRow()
dw_master.setFocus()

/*Para las cxp*/
ic_iva = f_iva_compras()


ids_movim =  create datastore
ids_movim.dataobject = 'd_movim_recepciones'
ids_movim.settransobject(sqlca)

dw_listarecep.SetTransObject(sqlca)


ids_recep = Create DataStore 
ids_recep.DataObject = 'd_detalle_recepciones'
ids_recep.SetTransObject(sqlca)

/**/
idw_m = dw_master
idw_d = tab_detail.tabpage_detail1.dw_detail1
idw_cr = tab_detail.tabpage_detail2.dw_detail2
idw_p1 = tab_detail.tabpage_detail3.dw_detail3
idw_fp = tab_detail.tabpage_detail4.dw_detail4

/**/
f_recupera_empresa(dw_master,"pv_codigo") 
f_recupera_empresa(dw_master,"fp_codigo")
f_recupera_empresa(idw_fp,"fp_codigo")



end event

event ue_update;long   ll_filact,ll_num_nota,ll_mov_recep,ll_max,ll_i ,&
	    ll_find,ll_nrocompra,li,max,ll_rc,ll_end,&
	    ll_new,ll_found,ll_nreg,li_nros[] 
dec{2} ll_nuevoprecio,ld_cantatomo,ll_cantidad,ll_total
dec{6} ll_nuevocosto,ld_costo_atomo,lc_costprom
string ls_item,ls_atomo,ls_pvcodigo
char   lch_kit,lch_actualiza
dwitemstatus l_status




/* Busco la recepcion para actualizar con el ultimo costo */

idw_m.AcceptText()
idw_m.Setfocus()
dw_compra.reset()
ids_movim.reset()
ll_filact = idw_m.GetRow()
if ll_filact <= 0 then return

If idw_cr.rowcount() <= 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La Cuenta por pagar falta por registrar")
	rollback;
	return
end if	


/*Capturar el nro de la nota de recepcion*/
ls_pvcodigo =  idw_m.GetItemString(ll_filact,"pv_codigo")
//ll_mov_recep = ids_movim.retrieve('1','I',str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,il_nros)
//if ll_mov_recep <= 0 then
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Nota de recepci$$HEX1$$f300$$ENDHEX$$n no existe")
//	return 
//end if

ll_max = idw_d.rowcount()
if isnull(idw_d.GetitemString(ll_max,'nombre')) then
ll_max = ll_max -1
end if

wf_items_compra()

ll_nrocompra = f_secuencial_sucursal(str_appgeninfo.empresa,str_appgeninfo.sucursal,'COMPRA')
idw_m.setitem(ll_filact,"co_numero",ll_nrocompra)
idw_m.SetItem(ll_filact,"ec_codigo",is_estado)


idw_m.setitem(ll_filact,"co_numpad",il_nros[1])

for ll_i = 1 to idw_d.rowcount()
	idw_d.Object.co_numero[ll_i] = ll_nrocompra
Next


/*****************************************************/
/*Registrar la CXP                                   */
/*Se genera la cxp y d$$HEX1$$e900$$ENDHEX$$bitos                         */
/*Pagos por concepto de retenciones, notas de debito */
/*Generar el secuencial de la compra                 */
/*****************************************************/

/*****************************************************/
/*Actualiza costos de ITEMS                          */
/*****************************************************/


ll_nreg  = dw_compra.rowcount()
for ll_i = 1 to ll_nreg
	//actualiza los costos y precios en in_item
	lch_actualiza = dw_compra.GetItemString(ll_i,"dc_actualiza")
     lch_kit = dw_compra.getitemstring(ll_i,"it_kit")	
     ls_item = dw_compra.getitemstring(ll_i,"it_codigo")
	ll_nuevoprecio = dw_compra.GetItemNumber(ll_i,"dc_nuepre")
	ll_nuevocosto = dw_compra.GetItemNumber(ll_i,"dc_costo")
	ll_cantidad = dw_compra.GetItemNumber(ll_i,"dc_cantid")
	ll_total = dw_compra.GetItemNumber(ll_i,"cc_total")
    //lc_costo_unitario = ll_total/ll_cantidad

   /*Llenar  el dw que sirve para recorrer items*/ 
   
	
	/*Actualiza precio si tiene habilitado la propiedad de cambiar precio solo del
	  producto seleccionado 
	  Los atomos no actualizan el precio*/
	if lch_actualiza = 'S' then
		update in_item
	     set it_prefab = :ll_nuevoprecio,
		it_precio = :ll_nuevoprecio,
		it_feccam = sysdate
     	where em_codigo = :str_appgeninfo.empresa
		and it_codigo = :ls_item;
		if sqlca.sqlcode < 0 then
			MessageBox("ERROR","Al actualizar el precio del item, Window: w_compra,Evento : ue_update, L$$HEX1$$ed00$$ENDHEX$$nea: 53")
			rollback;
			return
		end if
	end if
   
	/*Actualiza tabla de items con el ultimo costo de compra*/
	If lch_kit = 'S' Then	

      /*Tomar datos del atomo*/		
		SELECT nvl("IN_ITEM"."IT_COSTO",0), "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
		INTO :ld_costo_atomo,:ls_atomo, :ld_cantatomo
		FROM "IN_ITEM"  , "IN_RELITEM"
		WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
		("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
		("IN_RELITEM"."TR_CODIGO" = '1' ) and
		( "IN_RELITEM"."IT_CODIGO1" = :ls_item ) and
		( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
	
		/*Actualiza el costo del atomo*/
		UPDATE IN_ITEM
		SET IT_COSTO = :ll_nuevocosto/:ld_cantatomo
		WHERE EM_CODIGO = :str_appgeninfo.empresa
		AND IT_CODIGO  = :ls_atomo;
		
		If sqlca.sqlcode < 0 then
		MessageBox("ERROR","Al actualizar el costo del Item(Atomo)."+sqlca.sqlerrtext)
		rollback;
		return
		end if
		



   end if	
	
/*Actualiza el item sea Kit o no*/		
update in_item
set it_costo  = :ll_nuevocosto,
      it_costprom = :lc_costprom
where em_codigo = :str_appgeninfo.empresa
and it_codigo = :ls_item;

if sqlca.sqlcode < 0 then
MessageBox("ERROR","Al actualizar el costo del item. "+sqlca.sqlerrtext)
rollback;
return
end if



NEXT



/*Inicia actualizaci$$HEX1$$f300$$ENDHEX$$n de la compra*/
ll_rc = idw_m.update(true,false)
w_marco.setmicrohelp("Registrando cabecera de la compra...")
if ll_rc = 1 then
  	  w_marco.setmicrohelp("Registrando detalle de la compra...")
	  ll_rc = idw_d.update(true,false)
	  if ll_rc = 1 then
//    		       w_marco.setmicrohelp("Actualizando costos...")
//	                ll_rc = ids_movim.update(true,false)
//  			       if ll_rc = 1 then
							        w_marco.setmicrohelp("Determinando si existe cuenta por pagar para esta factura...")
									IF wf_find_factura() = 0 THEN
													w_marco.setmicrohelp("Registrando cuenta por pagar...")
													 ll_rc =idw_cr.update(true,false)
													 if ll_rc = 1 then
																 w_marco.setmicrohelp("Aplicando retenciones...") 
																 ll_rc = wf_aplica_retenciones()
																 if ll_rc = 1 then
																		w_marco.setmicrohelp("Registrando Nota de cr$$HEX1$$e900$$ENDHEX$$dito...")
																		if idw_p1.rowcount() > 0 then
																				/*Verificar si hay nota de debito*/
																				 if idw_p1.update(true,false) = 1  and sqlca.sqlnrows > 0 then
																							if wf_notadebito() <= 0 then
																							 Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al cruzar  la nota de cr$$HEX1$$e900$$ENDHEX$$dito..."+sqlca.sqlerrtext)
																							rollback;
																							return
																							end if	
																				else			
																				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar la nota de cr$$HEX1$$e900$$ENDHEX$$dito..."+sqlca.sqlerrtext)
																				rollback;
																				return
																				end if			
																		 end if														
																	
																else	 
																Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar las retenciones..."+sqlca.sqlerrtext)	
																rollback;
																return
																end if	  
											else	 
											Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la cuenta por pagar..."+sqlca.sqlerrtext)		
											rollback;
											return
											end if	  
						    ELSE
							Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La cuenta por pagar correspondiente a esta factura ya ha sido registrada ....",Exclamation!)		
							END IF
					  
							idw_m.resetupdate()
							idw_d.resetupdate()
							idw_cr.resetupdate()
							idw_fp.resetupdate()
							ids_movim.resetupdate()			
							idw_p1.resetupdate()
							
							idw_m.enabled = false
							idw_d.enabled = false
							idw_cr.enabled = false
							idw_fp.enabled = false
							idw_p1.enabled = false
	
							
							//actualizo como completa la nota de recepci$$HEX1$$f300$$ENDHEX$$n
							ll_i = 0
							for ll_i = 1 to upperbound(il_nros)
							
							update in_compra
							set co_completa = 'S'
							where ec_codigo = '2'
							and em_codigo = :str_appgeninfo.empresa
							and su_codigo  = :str_appgeninfo.sucursal
							and co_numero = :il_nros[ll_i]
							and pv_codigo  = :ls_pvcodigo;
							
							if sqlca.sqlcode <> 0 then
							messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la nota de recepci$$HEX1$$f300$$ENDHEX$$n"+sqlca.sqlerrtext)
							rollback;
							return
							end if 
							
							if not isnull(il_nros[ll_i])  and il_nros[ll_i] <> 0 then
							if sqlca.sqlnrows < 1 then
							Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha actualizado la nota de recepci$$HEX1$$f300$$ENDHEX$$n...")	
							rollback;
							return
							end if
							end if
							next	

							il_nros[] = li_nros[]
							commit;  
						
//					 else	
//					 Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los movimientos...")	
//					 rollback;
//					 return
//					 end if	
	   else	 
	   Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el detalle de  la compra..."+sqlca.sqlerrtext)			
	   rollback;
	   return
	   end if
else
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la cabecera..."+sqlca.sqlerrtext)	
rollback;
return
end if


idw_m.enabled =TRUE
idw_d.enabled = FALSE
idw_cr.enabled = FALSE


/*Disparar la impresion*/
w_marco.Setmicrohelp("Preparando para impresi$$HEX1$$f300$$ENDHEX$$n...")
if wf_preprint() = 1 then
dw_report.Print()
end if
//dw_master.uf_insertCurrentRow()
tab_detail.SelectedTab = 1
dw_master.setFocus()
dw_master.Setcolumn("co_numpad")
end event

event ue_delete;call super::ue_delete;beep(1)
end event

event ue_firstrow;call super::ue_firstrow;dw_master.Object.w_observacion.text = '          '
end event

event ue_lastrow;call super::ue_lastrow;dw_master.Object.w_observacion.text = '          '	
end event

event ue_nextrow;call super::ue_nextrow;dw_master.Object.w_observacion.text = '          '
end event

event ue_priorrow;call super::ue_priorrow;dw_master.Object.w_observacion.text = '          '
end event

event ue_retrieve;tab_detail.tabpage_detail1.dw_detail1.enabled=false
dw_master.enabled=false
return 1
end event

event ue_insert;call super::ue_insert;Long li_aux[]
idw_m.enabled = true
idw_d.enabled = true

//il_nros[] = li_aux[]



end event

event resize;return 1
end event

event ue_anular;long   ll_numero,ll_res,ll_total_reg,ll_regactual

setpointer(hourglass!)
ll_total_reg = dw_master.RowCount()
ll_regactual = dw_master.GetRow()
ll_numero = dw_master.GetItemNumber(dw_master.GetRow(),"co_numero")

ll_res = MessageBox("Advertencia","Anular la factura de compra No. " + string(ll_numero), Question!, YesNo!)

if ll_res <> 1 then
return -1
end if


/*Empieza la anulaci$$HEX1$$f300$$ENDHEX$$n*/

/*1.-Borrar los movimientos de cxp*/	
if  wf_anular_deuda() < 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular  La factura de compra No. " + string(ll_numero) + sqlca.sqlerrtext)		
rollback;
return -1	
end if 

/*2.-llama a la funcion que realiza la anulaci$$HEX1$$f300$$ENDHEX$$n de la compra*/
 if f_anula_compra(ll_numero) < 0 then 
	rollback;
	return -1
end if
	
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La factura de compra No. " + string(ll_numero) + ' fue anulada exitosamente.')	

dw_master.setFocus()
if ll_total_reg > 1 then
dw_master.ScrollToRow(ll_regactual - 1)
end if
setpointer(arrow!)
return 1
end event

type dw_master from w_sheet_master_tabpage_detail`dw_master within w_compra_multiples_recepciones
integer width = 4352
integer height = 680
string dataobject = "d_compra"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;call super::itemchanged;long ll_filact,ll_numero, ll_fildet, ll_secue
decimal{4} lc_ivavalor,lc_valor,lc_subtot, lc_descup, ld_cantid, lc_costo,lc_costunit,lc_pvp,lc_factor
DECIMAL{4} lc_desc1, lc_desc2, lc_desc3, lc_total, lc_transporte, lc_precio, &
                lc_desc1_p, lc_desc2_p, lc_desc3_p, lc_costo_p // Costo y descuentos registrados en el pedido

string ls, ls_prove, ls_filtro, ls_venpro, ls_codant, ls_nombre, ls_codigo, ls_formpag, ls_completa
decimal a, b, c, lc_valorsum,lc_valortrf0, ll_suma1, ll_subtot, ll_ivavalor
Integer li_pagaiva
            
string ls_observacion,ls_codRuc,ls_ruc,ls_cofacpro
char lch_kit
datawindowChild ldwc_aux




ll_filact = dw_master.getRow()


CHOOSE CASE this.getColumnName()

CASE "co_numpad"   // si cambia el n$$HEX1$$fa00$$ENDHEX$$mero de la Recepci$$HEX1$$f300$$ENDHEX$$n
	
       ll_numero = long(this.GetText())
	  il_nros[1] = ll_numero  /*Para unificar con las multiples recepciones*/
	  
	  select pv_codigo, vp_codigo, fp_codigo, nvl(co_transpor,0), co_completa, co_observ, co_rucsuc, nvl(co_facpro,'0000000000000')
	  into :ls_prove, :ls_venpro, :ls_formpag, :lc_transporte, :ls_completa, :ls_observacion, :ls_codRuc,:ls_cofacpro
	  from in_compra
	  where em_codigo = :str_appgeninfo.empresa
	  and su_codigo = :str_appgeninfo.sucursal
	  and ec_codigo = '2' // es nota de recepcion
	  and co_numero = :ll_numero;
	
	// si la nota de recepcion esta completa 'S', salir 
	if ls_completa = 'S' then
		messageBox('Error','Nota de recepci$$HEX1$$f300$$ENDHEX$$n ya fue procesada')
		return 0
	end if
	// encuentra si paga iva o no
	select nvl(pv_caract,'N'),pv_rucci,pv_contesp
	into :ls,:ls_ruc,:is_contribuyente_especial
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
	and pv_codigo = :ls_prove;
	
	if ls = 'S' then
		ii_excento_iva = 0
	else
		// encuentra el valor del iva
	    ic_iva = f_iva_compras()
		ii_excento_iva = 1
	end if
	
	// asigna los valores al dw
	ls_codruc = '1' //Por default las compras ingresan a bodega
	
	this.modify("st_ruc.text = '"+ls_ruc+"'")
	this.SetItem(ll_filact,'pv_codigo',ls_prove)
	ls_filtro = "pv_codigo = '"+ ls_prove + "' and vp_codigo ='"+ls_venpro+"'"
	if isnull(ls_filtro) or ls_filtro = "" then ls_filtro = '@'
	this.getChild("vp_codigo", ldwc_aux)
	ldwc_aux.SetFilter(ls_filtro)
	ldwc_aux.Filter()
	this.SetItem(ll_filact,'vp_codigo',ls_venpro)	
	this.SetItem(ll_filact,'fp_codigo',ls_formpag)	
	this.SetItem(ll_filact,'co_rucsuc',ls_codRuc) 	
	this.SetItem(ll_filact,'co_transpor',lc_transporte)
	this.setItem(ll_filact,'co_facpro',ls_cofacpro)
	this.SetItem(ll_filact,'ec_codpad','2') //2 --> NOTA DE RECEPCION
	if not isnull (ls_observacion) then
		this.Object.w_observacion.text = ls_observacion
	else
		this.Object.w_observacion.text = '                                 '
   end if	
	tab_detail.tabpage_detail1.dw_detail1.Reset()
	
	// encuentra datos del detalle de la compra
	DECLARE det_fact CURSOR FOR  
	  SELECT "IN_ITEM"."IT_CODANT","IN_ITEM"."IT_NOMBRE","IN_ITEM"."IT_KIT","IN_ITEM"."IT_TIEMSEC",
      	   "IN_DETCO"."IT_CODIGO","IN_DETCO"."DC_CANTID",
				"IN_DETCO"."DC_SECUE","IN_DETCO"."DC_COSTO",
				"IN_DETCO"."DC_DESC1","IN_DETCO"."DC_DESC2",
				"IN_DETCO"."DC_DESC3"				 
	    FROM "IN_DETCO",   
   	      "IN_ITEM"  
   	WHERE ( "IN_DETCO"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO" ) and 
				( "IN_DETCO"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO" ) and
         	( "IN_DETCO"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
         	( "IN_DETCO"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
         	( "IN_DETCO"."EC_CODIGO" = '2' ) AND  
         	( "IN_DETCO"."CO_NUMERO" = :ll_numero )
		ORDER BY "IN_DETCO"."DC_SECUE";
	open det_fact;
	ll_fildet = 0
	do
		fetch det_fact 
		 into :ls_codant,:ls_nombre,:lch_kit,:li_pagaiva,:ls_codigo, :ld_cantid, :ll_secue,
		      :lc_costo_p, :lc_desc1_p, :lc_desc2_p, :lc_desc3_p;
		if sqlca.sqlcode <> 0 then
			exit;
		end if
		
		// encuentra el precio de f$$HEX1$$e100$$ENDHEX$$brica de cada item del detalle
		select it_prefab
		 into :lc_precio
		 from in_item
		 where em_codigo = :str_appgeninfo.empresa
		 and it_codigo = :ls_codigo;
			
		tab_detail.tabpage_detail1.dw_detail1.SetFocus()
		tab_detail.tabpage_detail1.dw_detail1.InsertRow(0)
		ll_fildet += 1
		
		//si no existe ingresado el costo, recupero el costo de la $$HEX1$$fa00$$ENDHEX$$ltima 
		// compra
		


           /*Tomar de la lista de precios por fabricante*/
            select nvl(ip_plista,0),nvl(ip_desc1,0) , nvl(ip_desc2,0), nvl(ip_desc3,0)
		  into    :lc_costo,:lc_desc1,:lc_desc2,:lc_desc3
		  from    in_itepro
            where   em_codigo = :str_appgeninfo.empresa
		  and     it_codigo = :ls_codigo
		  and     pv_codigo = :ls_prove;
		  
            if sqlca.sqlcode <> 0 then
     	       lc_costo = lc_costo_p 
			  lc_desc1 = lc_desc1_p
			  lc_desc2 = lc_desc2_p
			  lc_desc3 = lc_desc3_p
	       end if	
      
//		end if

//		inserto datos en el detalle del dw

           lc_pvp  = lc_precio*.95

		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,'dc_preact',lc_precio)
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,'dc_secue',ll_secue)
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,'codant',ls_codant)
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,'nombre',ls_nombre)
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,'it_codigo',ls_codigo)
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,'it_kit',lch_kit)
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,'it_tiemsec',li_pagaiva)
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,'dc_cantid',ld_cantid)
		tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet, 'em_codigo', str_appgeninfo.empresa)
		tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet, 'su_codigo', str_appgeninfo.sucursal)		
		tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet, 'bo_codigo', str_appgeninfo.seccion)
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,"ec_codigo",is_estado)		
		tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet, 'dc_costo', lc_costo)
		tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet, 'dc_desc1', lc_desc1)
		tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet, 'dc_desc2', lc_desc2)
		tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet, 'dc_desc3', lc_desc3)
		tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet, 'co_numpad', ll_numero)
	
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,"dc_subtot",lc_costo * ld_cantid)
		a = lc_costo - (lc_costo * (lc_desc1/100))
		b = a - ( a * (lc_desc2/100))
		c = ld_cantid * ( b - ( b * (lc_desc3/100)))
				
		tab_detail.tabpage_detail1.dw_detail1.SetItem(ll_fildet,"dc_total", c)

		lc_costunit = c/ld_cantid		
		/*Para evitar  la division por cero*/
		if lc_pvp <> 0 then
		lc_factor = round(((lc_pvp - lc_costunit)/lc_pvp)*100,2)
	   else
		lc_factor = 0	
	   end if
 	   lc_valorsum += c

		//tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet,"dc_utilidad",lc_factor) 
		//tab_detail.tabpage_detail1.dw_detail1.setitem(ll_fildet,"dc_nuepre",(lc_costunit/((100 - lc_factor)/100))/0.95)
	loop while TRUE;	
	close det_fact;
	dw_compra.sort()
     dw_compra.groupcalc()
  
     if  tab_detail.tabpage_detail1.dw_detail1.rowcount() > 0 then
   	lc_valorsum = tab_detail.tabpage_detail1.dw_detail1.Object.cc_subtotal[1]
   	lc_valortrf0 = tab_detail.tabpage_detail1.dw_detail1.Object.cc_subtrf0[1]
	end if	
		
	ll_numero=this.GetItemNumber(ll_filact,"co_numero")
	
	this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
	this.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
	this.SetItem(ll_filact,"ec_codigo",is_estado)
	this.SetItem(ll_filAct,"co_subtot",lc_valorsum)
	this.SetItem(ll_filAct,"co_subtrf0",lc_valortrf0)
	
	ll_suma1=lc_valorsum
     ll_subtot= ll_suma1 - (ll_suma1*this.GetItemNumber(ll_filAct,"co_descup"))
	ll_ivavalor= round(ll_subtot*ic_iva,2)*ii_excento_iva
	this.SetItem(ll_filAct,"co_iva",ll_ivavalor)
	this.SetItem(ll_filAct,"co_total",ll_subtot + ll_ivavalor+lc_valortrf0)
	this.SetColumn('co_facpro')
	dw_master.SetFocus()
	dw_master.SetColumn('co_fecha')
	dw_compra.groupcalc()
	
CASE "co_descup"  // si cambia el valor del porcentaje de descuento
	
	lc_descup = dec(this.gettext())
	lc_transporte  = this.GetItemNUmber(ll_filact,"co_transpor")
	lc_valortrf0 = this.GetItemNUmber(ll_filact,"co_subtrf0")
	
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
	ic_iva = f_iva_compras()
		 ii_excento_iva = 1
	end if
	
	// actualiza los campos Total, Iva y Saldo
	lc_valor= lc_subtot - (lc_subtot*lc_descup)
	lc_ivavalor= round(lc_valor*ic_iva,2)*ii_excento_iva
	this.SetItem(ll_filAct,"co_iva",lc_ivavalor)
	this.SetItem(ll_filAct,"co_total",lc_valor + lc_ivavalor + lc_transporte +lc_valortrf0 )
	
CASE "co_transpor"  //si existe cambios en transporte
	
	lc_transporte = dec(this.gettext())
	lc_descup = this.GetItemNUmber(ll_filAct,"co_descup")
	if isnull(lc_descup) then
		lc_descup = 0
		this.SetItem(ll_filact,"co_descup",0)
	end if
	lc_subtot = this.GetItemNumber(ll_filAct,"co_subtot")
	lc_valortrf0 = this.GetItemNumber(ll_filAct,"co_subtrf0")
	// controla si se paga con iva o no
	select nvl(pv_caract,'N')
	into :ls
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
	and pv_codigo = :ls_prove;
	
	if ls = 'S' then
		ii_excento_iva = 0
	else
		ic_iva = f_iva_compras()
		  ii_excento_iva = 1
	end if
	// actualiza los campos Total, Iva y Saldo
	lc_valor= lc_subtot - (lc_subtot*lc_descup)
	lc_ivavalor= round(lc_valor*ic_iva,2)*ii_excento_iva
	this.SetItem(ll_filAct,"co_iva",lc_ivavalor)
	this.SetItem(ll_filAct,"co_total",lc_valor + lc_ivavalor + lc_transporte + lc_valortrf0)
	
CASE "co_iva"

	//actualiza los campos Total, Iva y Saldo
	lc_descup = this.GetItemNUmber(ll_filAct,"co_descup")
	if isnull(lc_descup) then
		lc_descup = 0
		this.SetItem(ll_filact,"co_descup",0)
	end if
	lc_subtot = this.GetItemNumber(ll_filAct,"co_subtot")
	
	lc_valor= lc_subtot - (lc_subtot*lc_descup)
	lc_ivavalor = dec(data)
	
	if lc_ivavalor <> 0 then
		if lc_ivavalor <> lc_subtot*ic_iva then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El valor de IVA no corresponde a la base imponible...Por favor verifique...!")
			this.SetItem(ll_filAct,"co_total",0)
			return
		end if	
    end if
	lc_transporte = this.Object.co_transpor[row]
	lc_valortrf0    = this.Object.co_subtrf0[row]
	
	this.SetItem(ll_filAct,"co_total",lc_valor + lc_ivavalor + lc_transporte + lc_valortrf0)
	
END CHOOSE

end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
tab_detail.tabpage_detail1.dw_detail1.Enabled = true
dw_master.Enabled = true
this.Object.w_observacion.text = '          '
//dw_listarecep.Visible = true
end event

event dw_master::itemerror;call super::itemerror;String ls_colname,ls_datatype 

ls_colname = dwo.Name
ls_datatype = dwo.ColType
messagebox('Error',is_mensaje + ' '+ls_colname +' '+ls_datatype+' '+data)
return 1	



end event

event dw_master::rowfocuschanged;datawindowChild ldw_aux
//long ll_conumero
string ls_prove
//,ls_cofacpro,ls_corucsuc
//
dwitemstatus  l_status
l_status = dw_master.getitemstatus(currentrow,0,Primary!)
//
//ll_conumero  = this.Object.co_numero[currentrow]
//ls_cofacpro  = this.Object.co_facpro[currentrow]
//ls_corucsuc = this.Object.co_rucsuc[currentrow]
//ls_prove       = this.Object.pv_codigo[currentrow]
//
///*Recuperar la cxp*/
//tab_detail.tabpage_detail2.dw_detail2.retrieve(str_appgeninfo.empresa,ls_corucsuc,string(ll_conumero),ls_cofacpro,ls_prove)
//
//
///*Deshabilitar cxp si la factura ya fue registrada*/
if l_status = datamodified! or l_status = notmodified! & 
then
dw_master.enabled = false
tab_detail.tabpage_detail1.dw_detail1.enabled = false
tab_detail.tabpage_detail2.dw_detail2.enabled = false
else
this.enabled = true
tab_detail.tabpage_detail1.dw_detail1.enabled = true
tab_detail.tabpage_detail2.dw_detail2.enabled = true
end if
///**/
//
//
if dw_master.GetRow() > 0 then
  ls_prove = dw_master.GetItemString(currentrow,'pv_codigo')
  if not isnull(ls_prove) then 
	  GetChild('vp_codigo',ldw_aux)
	  ldw_aux.SetFilter("pv_codigo ='"+ls_prove+"'")
	  ldw_aux.Filter()
  end if
else
return
end if
call super::rowfocuschanged


return 1
end event

event dw_master::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0  then return
this.setitem(ll_row,"co_fecha",f_hoy())
this.setitem(ll_row,"co_fecrep",f_hoy())
end event

event dw_master::buttonclicked;call super::buttonclicked;If dwo.name = 'b_1' then
if string(this.Object.co_numpad[row]) <> "" and not isnull(this.Object.co_numpad[row]) then return
dw_listarecep.visible = true
dw_listarecep.retrieve(str_appgeninfo.sucursal,'2') 
end if
end event

type dw_report from w_sheet_master_tabpage_detail`dw_report within w_compra_multiples_recepciones
integer x = 2510
integer y = 1196
string dataobject = "d_rep_compra"
end type

type tab_detail from w_sheet_master_tabpage_detail`tab_detail within w_compra_multiples_recepciones
integer x = 0
integer y = 708
integer width = 4352
integer height = 1732
boolean powertips = true
end type

type tabpage_detail1 from w_sheet_master_tabpage_detail`tabpage_detail1 within tab_detail
integer width = 4315
integer height = 1612
string text = "Detalle compra"
string powertiptext = "Lista de productos con su costo"
end type

type dw_detail1 from w_sheet_master_tabpage_detail`dw_detail1 within tabpage_detail1
integer x = 9
integer y = 20
integer width = 4297
integer height = 1592
string dataobject = "d_detalle_compra"
boolean hscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_detail1::doubleclicked;call super::doubleclicked;Long i
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
Decimal{4}  lc_indice,lc_newprecio,lc_descab,lc_factor,lc_costo,&
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
	lc_costunit = lc_costo						
  	lc_costo = round(lc_costo - lc_costo*lc_descab,2)
 
     /*El nuevo precio no debe depender de la caracter$$HEX1$$ed00$$ENDHEX$$stica del proveedor */
	/*a todos los items se debe inflar el 5% virtual*/
     lc_newprecio = ceiling(((lc_costunit/(1 - lc_factor))/0.95)*100)/100
	
      this.setitem(i,"dc_nuepre", lc_newprecio)
	  
next	
wf_actualiza_suma()
return 1
	
end event

event dw_detail1::itemchanged;call super::itemchanged;long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
decimal ll_valortot,ll_valor,ll_costo,ll_valorsum,ld_area, ll_ivavalor, lc_transporte
decimal ll_subtot,ll_suma, ld_canti,ll_suma1, lc_newprecio, lc_indic
decimal lc_precio, lc_costo, lc_factor, lc_descab, lc,lc_costunit
string ls, ls_pepa, ls_nombre, ls_null, ls_codant, ls_codigo
char lch_kit

ll_filact = this.getRow()
str_prodparam.fila = ll_filact
ll_filActMaster = dw_master.getRow()

This.AcceptText()
choose case this.getcolumnname()
CASE 'codant'
	ls = this.gettext()
	
// con este voy a buscar
//primero por codigo anterior
	select it_codigo, it_nombre, it_prefab,it_kit
	into :ls_pepa, :ls_nombre, :lc_precio,:lch_kit
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls;
   
	if sqlca.sqlcode <> 0 then
//		luego por codigo de barras
		 select it_codigo, it_codant, it_nombre, it_prefab,it_kit
		into :ls_pepa, :ls_codant, :ls_nombre, :lc_precio,:lch_kit
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
	 
//	Busco el costo de ultima compra
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
	this.setitem(ll_filact, 'dc_preact', lc_precio)

	ll_valortot = lc_costo
	this.SetItem(ll_filact,"dc_subtot",ll_valortot)
	ll_valor= this.GetItemDecimal(ll_filact,"cc_total")
	this.SetItem(ll_filact,"dc_total",ll_valor)
	this.SetColumn('dc_cantid')
//	 actualiza valores en el maestro
	wf_actualiza_suma()
	
CASE "dc_costo"

	if  dec(this.GetText()) < 0 then
		is_mensaje = "El costo no puede ser negativo"
	    this.SetItem(ll_filact,"dc_costo",0)
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
	       this.SetItem(ll_filact,"dc_cantid",0)
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
		this.SetItem(ll_filact,"dc_utilidad",0)
		return 1
		end if	
		
		lc_factor = dec(this.GetText())/100
		lc_costo = this.GetItemDecimal(ll_filact,"cc_total") / &
		this.GetItemDecimal(ll_filact, 'dc_cantid')
		lc_costunit = lc_costo			 
		lc_descab = dw_master.GetItemDecimal(ll_filActMaster, "co_descup")
		lc_costo = round(lc_costo - lc_costo*lc_descab,2)
		

		
		/*El nuevo precio no debe depender de la caracter$$HEX1$$ed00$$ENDHEX$$stisca del proveedor
		a todos se le debe a$$HEX1$$f100$$ENDHEX$$adir el 5% virtual*/
		if ii_excento_iva = 0 then
		lc_newprecio	= ceiling(lc_costunit  / (1 - lc_factor)*100)/100
		else
		lc_newprecio = ceiling(((lc_costunit/(1 - lc_factor))/0.95)*100)/100
		this.setitem(ll_filact, 'dc_nuepre', lc_newprecio)
////		this.setitem(ll_filact, 'dc_utilidad',0)
		end if	
CASE  'dc_nuepre'
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

event dw_detail1::itemerror;call super::itemerror;messageBox ("Error Aquimismo", is_mensaje)
return 1	
end event

type tabpage_detail2 from w_sheet_master_tabpage_detail`tabpage_detail2 within tab_detail
integer width = 4315
integer height = 1612
string text = "Registro cr$$HEX1$$e900$$ENDHEX$$dito"
string powertiptext = "Registro de la cuenta por pagar"
end type

type dw_detail2 from w_sheet_master_tabpage_detail`dw_detail2 within tabpage_detail2
integer x = 0
integer y = 12
integer width = 4279
integer height = 1552
string dataobject = "d_sri_cxp_mercaderia"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_detail2::ue_postinsert;call super::ue_postinsert;/*Asignar los datos de la compra a la cxp */
Long ll_row,ll_new,ll_numrecep
Integer li_codfte,li_codiva
Date ld_fecha,ld_fpago,ld_fecrecep
String ls_fpcodigo,ls_pvcodigo
Real lr_plazo

ll_row  = dw_master.getrow()
ll_new = this.getrow()
ld_fecha = date(dw_master.Object.co_fecha[ll_row])
ls_fpcodigo = dw_master.Object.fp_codigo[ll_row]
ls_pvcodigo =dw_master.Object.pv_codigo[ll_row] 
ll_numrecep = dw_master.Object.co_numpad[ll_row]

/*Para determinar la fecha de pago*/
SELECT TO_DATE(CO_FECHA)
INTO   :ld_fecrecep
FROM IN_COMPRA
WHERE EC_CODIGO = '2'
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND CO_NUMERO  = :ll_numrecep
AND PV_CODIGO = :ls_pvcodigo;


SELECT NEXT_DAY(:ld_fecrecep,'TUE'),nvl(FP_NUMPAG,1)
INTO :ld_fpago,:ii_numpag
FROM FA_FORMPAG
WHERE FP_CODIGO = :ls_fpcodigo;


//ld_fpago = relativedate(ld_fecrecep,lr_plazo)


/*Cargamos por default los valores predeterminados de retenci$$HEX1$$f300$$ENDHEX$$n asignados al proveedor */
SELECT DECODE(C.RF_CODIGO,0,0,3,1,6,5,2,8,4,2),decode(D.RF_CODIGO,0,0,9,1,10,2,11,3)
INTO     :li_codfte,:li_codiva
FROM    IN_PROVE P,CC_RETEN C ,CC_RETEN  D
WHERE C.RF_CODIGO = P.RF_CODIGO
AND D.RF_CODIGO = P.RF_CODIGO2
and  P. PV_CODIGO = :ls_pvcodigo;
if sqlca.sqlcode = 100 then 
	li_codfte = 0 
	li_codiva = 0
end if


this.Object.pv_codigo[ll_new] = dw_master.Object.pv_codigo[ll_row]
this.Object.co_facpro[ll_new] = dw_master.Object.co_facpro[ll_row]
this.Object.mp_preimp[ll_new] = dw_master.Object.co_facpro[ll_row]
//this.Object.mp_docnroest[ll_new] = mid(dw_master.Object.co_facpro[ll_row],1,3)
//this.Object.mp_docnropto[ll_new] = mid(dw_master.Object.co_facpro[ll_row],4,3)
//this.Object.mp_docnrosec[ll_new] = mid(dw_master.Object.co_facpro[ll_row],7)
this.Object.mp_baseimp[ll_new] =   round(dw_master.Object.co_subtot[ll_row],2)
this.Object.mp_bseimptrf0[ll_new] = round(dw_master.Object.co_subtrf0[ll_row],2)
this.Object.mp_fecpago[ll_new] = ld_fpago

this.Object.mp_codpctiva[ll_new] = '2'
this.Object.mp_valret[ll_new] = round(dw_master.Object.co_iva[ll_row],2)
this.Object.mp_valor[ll_new]  = round(dw_master.Object.co_total[ll_row],2)



this.Object.in_prove_pv_contesp[ll_new] = is_contribuyente_especial
this.Object.mp_biemntiva[ll_new] = round(this.Object.mp_valret[ll_new]	,2)

/*Asignamos por default el % de retenci$$HEX1$$f300$$ENDHEX$$n definido en el proveedor*/
this.Object.mp_codpctfte[ll_new] = string(li_codfte)
If is_contribuyente_especial = 'S' then
this.Object.mp_biepctiva[ll_new] = '0' /*Por defaul el 0%*/
else
this.Object.mp_biepctiva[ll_new] = String(li_codiva)
end if

end event

event dw_detail2::updatestart;/*Asignar los datos de la compra a la cxp */
Long ll_row,ll_filact,ll_mpcodigo

ll_row  = dw_master.getrow()
ll_filact = this.getrow()


/*Inicia la validaci$$HEX1$$f300$$ENDHEX$$n*/

If wf_find_factura() > 0 then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Factura ya registrada.......  <Por favor verifique!>")
Rollback;
Return 0
end if


this.Object.co_facpro[ll_filact] = this.object.mp_docnroest[ll_filact]+this.object.mp_docnropto[ll_filact]+this.object.mp_docnrosec[ll_filact]
this.Object.mp_preimp[ll_filact] = this.object.mp_docnroest[ll_filact]+this.object.mp_docnropto[ll_filact]+this.object.mp_docnrosec[ll_filact]
if this.Object.co_facpro[ll_filact] <> dw_master.object.co_facpro[ll_row] then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Los de n$$HEX1$$fa00$$ENDHEX$$meros de serie y/o secuencial no coinciden por favor verifique. ",Exclamation!)
	Rollback;
	return 1
end if



if  round(this.Object.cc_totalfactura[ll_filact],2) <> round(this.object.mp_valor[ll_filact],2) then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La factura no cuadra por favor verifique",Exclamation!)
	Rollback;
	return 1
end if




ll_mpcodigo = f_secuencial(str_appgeninfo.empresa,'CRE_CXP')
this.Object.mp_codigo[ll_filact] = string(ll_mpcodigo)
this.Object.em_codigo[ll_filact] = str_appgeninfo.empresa
this.Object.su_codigo[ll_filact] = dw_master.Object.co_rucsuc[ll_row]
this.Object.co_numero[ll_filact] = dw_master.Object.co_numero[ll_row]
this.Object.pv_codigo[ll_filact] = dw_master.Object.pv_codigo[ll_row]
this.Object.ec_codigo[ll_filact] = dw_master.Object.ec_codigo[ll_row] 

this.Object.co_facpro[ll_filact]  = dw_master.Object.co_facpro[ll_row]
this.Object.mp_preimp[ll_filact] = dw_master.Object.co_facpro[ll_row]

this.Object.mp_saldo[ll_filact] = this.Object.mp_valor[ll_filact]
this.Object.mp_valret[ll_filact] = this.Object.cc_mpvalret[ll_filact]
this.Object.mp_montoice[ll_filact] = this.Object.cc_mpmontoice[ll_filact]

this.Object.mp_bievlrret[ll_filact] = this.Object.cc_bieretiva[ll_filact]
this.Object.mp_srvvlrret[ll_filact] = this.Object.cc_srvretiva[ll_filact]
this.Object.retiva[ll_filact] = this.Object.cc_retiva[ll_filact] /*Ret. Iva*/
this.Object.retfte[ll_filact] = this.Object.cc_retfte[ll_filact] /*Ret.fuente*/

this.Object.mp_montoice[ll_filact] = this.Object.cc_mpmontoice[ll_filact]
this.Object.mp_docnrosec[ll_filact] = mid(dw_master.Object.co_facpro[ll_row],7)
 


if  round(this.Object.cc_totaliva[ll_filact],2) <> round(this.object.cc_mpvalret[ll_filact],2) then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Los montos de Iva no cuadran por favor verifique",Exclamation!)
Rollback;
return 1
end if



return 0

end event

event dw_detail2::itemchanged;call super::itemchanged;Date ld_fecrecep
Date ld_fpago
Datetime ldt_fecha
Long li_numpag,ll_rowm

String ls_fpcodigo,ls_fpago

ll_rowm = idw_m.getrow()
This.AcceptText()
if dwo.name = 'mp_valor'  or dwo.name = 'mp_codpctiva'  then
this.object.mp_baseimp[row] = round(this.Object.mp_valor[row]/(1 + ic_iva),2)
end if 

//If dwo.name = 'mp_fecpago' then
//	if ll_rowm <= 0 then return
//    if idw_fp.rowcount() = 0 then
//	idw_fp.insertrow(0)	
//    ldt_fecha = this.GetItemDateTime(row,'mp_fecpago')
//	idw_fp.Object.dp_fecpago[1] = ldt_fecha
//	idw_fp.Object.fp_codigo[1] = idw_m.Object.fp_codigo[ll_rowm]
//	idw_fp.Object.dp_valor[1] = idw_m.Object.co_total[ll_rowm]
//	end if
//End if
	
end event

type tabpage_detail3 from w_sheet_master_tabpage_detail`tabpage_detail3 within tab_detail
boolean visible = false
integer width = 4315
integer height = 1612
string text = "Nota de Cr$$HEX1$$e900$$ENDHEX$$dito"
end type

type dw_detail3 from w_sheet_master_tabpage_detail`dw_detail3 within tabpage_detail3
integer x = 37
integer y = 28
integer width = 3342
integer height = 916
string dataobject = "d_sri_cxp_notadebito"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_detail3::updatestart;/*Asignar los datos de la compra a la cxp */
Long ll_row,ll_new,ll_mpcodigo

ll_row  = dw_master.getrow()
ll_new = this.getrow()

ll_mpcodigo = f_secuencial(str_appgeninfo.empresa,'DEB_CXP')
this.Object.mp_codigo[ll_new] = string(ll_mpcodigo)
this.Object.em_codigo[ll_new] = str_appgeninfo.empresa
this.Object.su_codigo[ll_new] = idw_m.Object.co_rucsuc[ll_row]
this.Object.pv_codigo[ll_new] = idw_m.Object.pv_codigo[ll_row]
this.Object.co_facpro[ll_new] =  this.Object.mp_docnroest[ll_row]+ this.Object.mp_docnropto[ll_row]+ this.Object.mp_docnrosec[ll_row]
this.Object.mp_preimp[ll_new]=  this.Object.mp_docnroest[ll_row]+ this.Object.mp_docnropto[ll_row]+ this.Object.mp_docnrosec[ll_row]

this.Object.mp_saldo[ll_new] = this.Object.mp_valor[ll_new]
this.Object.mp_valret[ll_new] = this.Object.cc_mpvalret[ll_new]
this.Object.mp_montoice[ll_new] =this.Object.cc_mpmontoice[ll_new]


return 0

end event

event dw_detail3::itemchanged;call super::itemchanged;if dwo.name = 'mp_valor'  or dwo.name = 'mp_codpctiva'  then
this.object.mp_baseimp[row] = this.Object.mp_valor[row]/(1 + ic_iva)
end if 
end event

event dw_detail3::ue_postinsert;call super::ue_postinsert;/*Asignar los datos de la compra a la cxp */
Long ll_row,ll_new,ll_rcr

ll_row  = idw_m.getrow()
ll_new = this.getrow()
ll_rcr    = idw_cr.getrow()

this.Object.pv_codigo[ll_new] = idw_m.Object.pv_codigo[ll_row]
this.Object.mp_codpctiva[ll_new] = '2'
this.Object.mp_modnroest[ll_new]  = idw_cr.Object.mp_docnroest[ll_rcr]
this.Object.mp_modnropto[ll_new]  = idw_cr.Object.mp_docnropto[ll_rcr]
this.Object.mp_modnrosec[ll_new] = idw_cr.Object.mp_docnrosec[ll_rcr]
this.Object.mp_modnaut[ll_new]     = idw_cr.Object.mp_naut[ll_rcr]
this.Object.mp_modfecemi[ll_new] = idw_cr.Object.mp_fecemision[ll_rcr]

end event

type tabpage_detail4 from w_sheet_master_tabpage_detail`tabpage_detail4 within tab_detail
boolean visible = false
integer width = 4315
integer height = 1612
string text = "Detalle de la Negociaci$$HEX1$$f300$$ENDHEX$$n"
end type

type dw_detail4 from w_sheet_master_tabpage_detail`dw_detail4 within tabpage_detail4
integer x = 50
integer y = 40
integer width = 4224
integer height = 1540
string dataobject = "d_detalle_negociacion_compras"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_compra from datawindow within w_compra_multiples_recepciones
boolean visible = false
integer x = 4475
integer y = 860
integer width = 485
integer height = 332
integer taborder = 12
boolean bringtotop = true
string title = "none"
string dataobject = "d_detalle_compra"
boolean border = false
boolean livescroll = true
end type

type dw_ubica from datawindow within w_compra_multiples_recepciones
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 713
integer y = 156
integer width = 2405
integer height = 288
integer taborder = 12
boolean bringtotop = true
boolean titlebar = true
string title = "Ubicar factura"
string dataobject = "d_sel_factura_compras"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

event buttonclicked;/* VERSION PARA RECUPERAR UNA POR UNA LA ORDEN DE COMPRA*/

Long ll_numero,ll_nreg,ll_recep,ll_filam
string ls_prove,ls_venpro,ls_filtro,ls_rucci,ls_corucsuc,ls_cofacpro
datawindowchild ldwc_aux

ll_numero = this.GetitemNumber(1,"ticket")		
ll_recep = this.GetitemNumber(1,"factura")


If isnull(ll_numero) and isnull(ll_recep) Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Compra o Recepci$$HEX1$$f300$$ENDHEX$$n")
	return
End if
		
ll_nreg = dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'3',ll_numero)
if ll_nreg <= 0 then 
	tab_detail.tabpage_detail1.dw_detail1.reset()
     tab_detail.tabpage_detail2.dw_detail2.reset()
	return
end if 
ll_filam = dw_master.getrow() 
ls_cofacpro = dw_master.getItemstring(ll_filam,'co_facpro')
ls_corucsuc = dw_master.getItemstring(ll_filam,'co_rucsuc')
ls_prove = dw_master.getItemstring(ll_filam,'pv_codigo')
ls_venpro = dw_master.getItemstring(ll_filam,'vp_codigo')		
ls_filtro = "pv_codigo = '"+ ls_prove + "' and vp_codigo ='"+ls_venpro+"'"
dw_master.getChild("vp_codigo", ldwc_aux)
if isnull(ls_filtro) or ls_filtro = "" then ls_filtro = '@'
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
tab_detail.tabpage_detail1.dw_detail1.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'3',ll_numero)
tab_detail.tabpage_detail2.dw_detail2.retrieve(str_appgeninfo.empresa,ls_corucsuc,string(ll_numero),ls_cofacpro,ls_prove)
end if	
end event

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()	
end event

type dw_listarecep from datawindow within w_compra_multiples_recepciones
boolean visible = false
integer x = 827
integer y = 48
integer width = 2446
integer height = 528
integer taborder = 22
boolean bringtotop = true
boolean titlebar = true
string title = "Recepciones"
string dataobject = "d_lista_recepciones"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event buttonclicked;Integer  i,li_nreg,k
Long ll_filAct
Decimal lc_subtot,lc_subtrf0,lc_ivavalor,lc_transporte
String ls_pvcodigo,ls_pvcodant,ls_cofacant,ls_cofacpro,ls,ls_ruc,ls_venpro,ls_formpag,ls_completa,ls_observacion,&
          ls_codruc,ls_filtro
Datawindowchild ldwc_aux			 

/*Tomar los nros de recepcion para recuperarlas*/
ll_filAct = idw_m.getrow()
If dwo.name = 'b_1' then
k = 1
/*1.-Validar que los proveedores asignados a las recepciones sean de un mismo proveedor*/
for i = 1 to this.rowcount()
	il_nros[i] = 0
	if this.object.marca[i] = 'S' then
		il_nros[k]    = this.object.co_numero[i]
		ls_pvcodigo = this.object.pv_codigo[i]
		ls_cofacpro = this.Object.co_facpro[i]
		
		if k = 1 then 
		ls_pvcodant = ls_pvcodigo 
		ls_cofacant = ls_cofacpro
	     end if	
		
		if ls_pvcodant <> ls_pvcodigo or ls_cofacant <> ls_cofacpro then 
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No coincide el proveedor y/o la referencia")
		return 1
		end if
		
		 /*Datos de las recepciones*/
		select pv_codigo, vp_codigo, fp_codigo, co_transpor, co_completa, co_observ, co_rucsuc, nvl(co_facpro,'0000000000000')
		into :ls_pvcodigo, :ls_venpro, :ls_formpag, :lc_transporte, :ls_completa, :ls_observacion, :ls_codRuc,:ls_cofacpro
		from in_compra
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
		and ec_codigo = '2' // es nota de recepcion
		and co_numero = :il_nros[k];
			
		// si la nota de recepcion esta completa 'S', salir 
		if ls_completa = 'S' then
		messageBox('Error','Nota de recepci$$HEX1$$f300$$ENDHEX$$n ya fue procesada')
		return 0
		end if
	
		ls_pvcodant = ls_pvcodigo
		ls_cofacant = ls_cofacpro
		k++
	end if
next

/*2.-Si son recepciones v$$HEX1$$e100$$ENDHEX$$lidas*/
/*Asignar datos comunes a todas las recepcionesen la cabecera  */
select nvl(pv_caract,'N'),pv_rucci,pv_contesp
into :ls,:ls_ruc,:is_contribuyente_especial
from in_prove
where em_codigo = :str_appgeninfo.empresa
and pv_codigo = :ls_pvcodigo;

if   ls = 'S' then
ii_excento_iva = 0
else
ii_excento_iva = 1
end if

ls_codruc = '1' //Por default las compras ingresan a bodega
idw_m.modify("st_ruc.text = '"+ls_ruc+"'")
idw_m.SetItem(ll_filact,'pv_codigo',ls_pvcodigo)
ls_filtro = "pv_codigo = '"+ ls_pvcodigo + "' and vp_codigo ='"+ls_venpro+"'"
idw_m.getChild("vp_codigo", ldwc_aux)
ldwc_aux.SetFilter(ls_filtro)
ldwc_aux.Filter()
idw_m.SetItem(ll_filact,'vp_codigo',ls_venpro)	
idw_m.SetItem(ll_filact,'fp_codigo',ls_formpag)	
idw_m.SetItem(ll_filact,'co_rucsuc',ls_codRuc) 	
idw_m.SetItem(ll_filact,'co_transpor',lc_transporte)
idw_m.setItem(ll_filact,'co_facpro',ls_cofacpro)
idw_m.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
idw_m.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
idw_m.Setitem(ll_filact,'ec_codigo',is_estado)

idw_m.SetItem(ll_filact,'ec_codpad','2') //2 --> NOTA DE RECEPCION
if not isnull (ls_observacion) then
idw_m.Object.w_observacion.text = ls_observacion
else
idw_m.Object.w_observacion.text = '                                 '
end if	


/*3.-Si son v$$HEX1$$e100$$ENDHEX$$lidas sube detalle de las recepciones*/

 If  wf_add_recepciones(ls_pvcodigo) = 1 then

	//Actualiza saldos en la cabecera
	if idw_d.rowcount() > 0 then
	lc_subtot = idw_d.Object.cc_subtotal[1]
	lc_subtrf0 = idw_d.Object.cc_subtrf0[1]

	idw_m.Object.co_subtot[ll_filAct] = lc_subtot
	idw_m.Object.co_subtrf0[ll_filAct] = lc_subtrf0
		
	lc_subtot= lc_subtot - (lc_subtot*idw_m.GetItemNumber(ll_filAct,"co_descup"))
	lc_ivavalor= round(lc_subtot*ic_iva,2)*ii_excento_iva
	idw_m.Setitem(ll_filAct,"pv_codigo",ls_pvcodigo)
	idw_m.SetItem(ll_filAct,"co_iva",lc_ivavalor)
	idw_m.SetItem(ll_filAct,"co_total",lc_subtot + lc_ivavalor+lc_subtrf0)
     end if
end if

	
End if
If dwo.name = 'b_2' then
this.visible = false
end if
end event

event editchanged;/*Permitir la ubicaci$$HEX1$$f300$$ENDHEX$$n en el proveedor que se desea*/

string ls_data
long ll_nreg,ll_find



if not isnull(data )and data<>"" then
ls_data = data+'%'
else 
Setnull(ls_data)
end if
ll_nreg = this.rowcount()
ll_find = this.find("cc_proveedor like'"+ls_data+"'",1,ll_nreg)
if ll_find <> 0 then
this.selectrow(0,false)
this.scrolltorow(ll_find)
this.selectrow(ll_find,true)
else	
this.selectrow(0,false)
end if
end event


HA$PBExportHeader$w_devolucion_nveces.srw
$PBExportComments$Si.Devolucion de facturas de venta
forward
global type w_devolucion_nveces from w_sheet_1_dw_maint
end type
type dw_cab from datawindow within w_devolucion_nveces
end type
type rb_1 from radiobutton within w_devolucion_nveces
end type
type rb_2 from radiobutton within w_devolucion_nveces
end type
type st_2 from statictext within w_devolucion_nveces
end type
type dw_movim from datawindow within w_devolucion_nveces
end type
end forward

global type w_devolucion_nveces from w_sheet_1_dw_maint
integer width = 4585
integer height = 1728
string title = "Devoluci$$HEX1$$f300$$ENDHEX$$n de Facturas"
long backcolor = 82899184
dw_cab dw_cab
rb_1 rb_1
rb_2 rb_2
st_2 st_2
dw_movim dw_movim
end type
global w_devolucion_nveces w_devolucion_nveces

type variables
string is_estado,is_estadofact,is_codant,is_mensaje
char   ich_exiva
dec{4} ic_costo

end variables

forward prototypes
public function integer wf_preprint ()
public function integer wf_devolucion_iva (string as_cliente, long ai_factura, decimal ad_total)
public function integer wf_nota_credito (string as_cliente, long ai_factura, decimal ad_total, string as_numnc)
public function integer wf_actualiza_saldo_cupo (string as_cliente, decimal ad_valor)
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costprom, decimal ac_costtrans)
end prototypes

public function integer wf_preprint ();long ll_ve_numero
string ls_estado,ls_preimpnc

//ll_ve_numero = dw_datos.GetItemNumber(1,'ve_numero')
//ls_estado       = dw_datos.GetItemString(1,'es_codigo ')
//ls_preimpnc    = dw_cab.GetItemString(1,'num_nc')
//
//
//dw_report.retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_preimpnc)

return 1
end function

public function integer wf_devolucion_iva (string as_cliente, long ai_factura, decimal ad_total);string ls_numero,ls_numnd
dec ll_numero

select pr_valor
  into :ll_numero
  from pr_param
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_NC';
update pr_param
   set pr_valor = pr_valor + 1
 where em_codigo = :str_appgeninfo.empresa
	and pr_nombre = 'NUM_NC';
	commit;

	
if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo obtener el numero de la nota de credito "+sqlca.sqlerrtext,StopSign!)
	return -1
end if
ls_numero = string(ll_numero+1)
insert into cc_movim(tt_codigo,tt_ioe,em_codigo,su_codigo,mt_codigo,
                     rf_codigo,ce_codigo,es_codigo,ve_numero,ig_numero,
							mt_valor,mt_fecha,mt_valret,mt_saldo,bo_codigo)
values('4','C',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,
       null,:as_cliente,'1',:ai_factura,null,:ad_total,sysdate,0,0,
		 :str_appgeninfo.seccion);
if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo generar la nota de credito: "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

select mt_codigo
  into :ls_numnd
  from cc_movim
 where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion
   and tt_codigo = '1'
   and tt_ioe = 'D'
	and ve_numero = :ai_factura
	and es_codigo = '1';
	
if sqlca.sqlcode <> 0 then
	MessageBox("ERROR","No puedo encontrar los datos del d$$HEX1$$e900$$ENDHEX$$bito")
	return -1
end if

insert into cc_cruce (tt_coddeb,tt_ioedeb,mt_coddeb,tt_codigo,tt_ioe,
                      em_codigo,su_codigo,mt_codigo,cr_fecha,cr_valdeb,
							 cr_valcre)
	values ('1','D',:ls_numnd,'4','C',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,
		     :ls_numero,sysdate,:ad_total,:ad_total); 
		  
if sqlca.sqlcode <> 0 then
	MessageBox("ERROR","No puedo realizar el cruce autom$$HEX1$$e100$$ENDHEX$$tico")
	return -1
end if

update cc_movim
   set mt_saldo = mt_saldo - :ad_total
 where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion
   and tt_codigo = '1'
   and tt_ioe = 'D'
	and ve_numero = :ai_factura
	and es_codigo = '1'
	and mt_codigo = :ls_numnd;

if sqlca.sqlcode <> 0 then
	MessageBox("ERROR","No puedo actualizar el saldo de la nota de d$$HEX1$$e900$$ENDHEX$$bito.")
	return -1
end if

commit;
return 1

end function

public function integer wf_nota_credito (string as_cliente, long ai_factura, decimal ad_total, string as_numnc);/*********************************************************************************/
/* Funcion: wf_nota_credito:                                                                                                                   */ 
/* Descripci$$HEX1$$f300$$ENDHEX$$n: Genera un movimiento de credito por el valor de la devolucion                                       */
/* y actualiza el saldo de la factura que genero la nc.                                                                             */
/* En el caso de que la factura tenga el saldo cero , no se debe cruzar la factura                                  */
/* y la nota de credito queda a favor del cliente                                                                                      */                                             
/*********************************************************************************/


String    ls_numero,&
             ls_numnd   //Numero del movimiento de debito
Long     ll_numero

Decimal{2}lc_valcruce, /*Valor del cruce*/  &
                lc_saldo, /*Saldo de la factura.*/ &
			 lc_nc,     /*valor de la nota de cr$$HEX1$$e900$$ENDHEX$$dito*/ &
			 lc_saldonc
boolean   lb_cruzar			 
integer     li_numcuotas			 

lc_nc = ad_total

/*Para obtener el secuencial de credito*/
select pr_valor
into :ll_numero
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'CRE_CXC'
for update of pr_valor;
	
update pr_param
set pr_valor = pr_valor + 1
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'CRE_CXC';
	
If sqlca.sqlcode < 0 then
MessageBox("Error","No se pudo obtener el numero de la nota de credito "+sqlca.sqlerrtext,StopSign!)
rollback;
return -1
end if


//Determinar si la factura ha generado cuotas
//En ese caso no se cruza la nota de credito, es decir queda abierta
//para cancelar con cualquier otra factura

select count(1)
into :li_numcuotas
from cc_movim
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and bo_codigo = :str_appgeninfo.seccion
and tt_codigo = '1'
and tt_ioe = 'D'
and ve_numero = :ai_factura
and es_codigo = '1';

if li_numcuotas > 1 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La factura ha generado mas de una cuenta por cobrar....La nota de cr$$HEX1$$e900$$ENDHEX$$dito no ser$$HEX2$$e1002000$$ENDHEX$$aplicada...")
	lc_saldo = 0
else

	/*Para obtener los datos del debito*/
	select mt_codigo,mt_saldo
	into :ls_numnd,:lc_saldo
	from cc_movim
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion
	and tt_codigo = '1'
	and tt_ioe = 'D'
	and ve_numero = :ai_factura
	and es_codigo = '1';
		
	if sqlca.sqlcode < 0 then
	messageBox("ERROR","No puedo encontrar los datos del d$$HEX1$$e900$$ENDHEX$$bito " +sqlca.sqlerrtext)
	rollback;
	return -1
	end if
end if

if lc_saldo = 0 then 
lb_cruzar = false
else
lb_cruzar = true
end if


//Controla si se cruza o no?
if lc_nc > lc_saldo  &
then
lc_saldonc  = lc_nc
lb_cruzar = false
else
lc_valcruce = lc_nc
lc_saldonc  = lc_nc - lc_valcruce
end if


/*Insertar un movimiento como nota de credito*/
ls_numero = string(ll_numero)
insert into cc_movim(tt_codigo,
							tt_ioe,
							em_codigo,
							su_codigo,
							mt_codigo,
							rf_codigo,
							ce_codigo,
							es_codigo,
							ve_numero,
							ig_numero,
							mt_valor,
							mt_fecha,
							mt_valret,
							mt_saldo,
							bo_codigo)
values (					'5',
							'C',
							:str_appgeninfo.empresa,
							:str_appgeninfo.sucursal,
							:ls_numero,
							null,
							:as_cliente,
							'1',
							:ai_factura,
							null,
							:lc_nc,
							sysdate,
							0,
							:lc_saldonc,
							:str_appgeninfo.seccion);
							
If sqlca.sqlcode < 0 then
	messageBox("Error","No se pudo generar el movimiento de cr$$HEX1$$e900$$ENDHEX$$dito: "+sqlca.sqlerrtext,StopSign!)
	rollback;
	return -1
end if


/*Realizar la Cancelacion con la nota de credito */
INSERT INTO "CC_CHEQUE"  (
				"TT_CODIGO",   
				"TT_IOE",   
				"EM_CODIGO",   
				"SU_CODIGO",   
				"MT_CODIGO",   
				"CH_SECUE",   
				"IF_CODIGO",   
				"CH_CUENTA",   
				"CH_NUMERO",   
				"CH_FECHA",   
				"CH_VALOR",   
				"CH_INTERES",   
				"CH_FECINTE",   
				"CH_PENDIENTE",   
				"CH_FECEFEC",   
				"FP_CODIGO",  
				"ESTADO",   
				"IG_NUMERO")   
VALUES ( 	'5',
				'C',
				:str_appgeninfo.empresa,   
				:str_appgeninfo.sucursal,
				:ls_numero,
				1,   
				'0',
				'NC',
				:as_numnc,
				sysdate,
				:lc_nc,   
				0,
				sysdate,
				'N',   
				sysdate,
				'2',
				null,
				null)  ;
If sqlca.sqlcode < 0 then
	MessageBox("ERROR","No puedo realizar el pago autom$$HEX1$$e100$$ENDHEX$$tico~r~n" +Sqlca.sqlerrtext)
	Rollback;
	return -1
end if

If lb_cruzar = false then
return 1
end if

/*Realizar el cruce de la  nota de credito */
insert into cc_cruce (	tt_coddeb,
							tt_ioedeb,
							mt_coddeb,
							tt_codigo,
							tt_ioe,
							em_codigo,
							su_codigo,
							mt_codigo,
							cr_fecha,
							cr_valdeb,
							cr_valcre)
values (					'1',
							'D',
							:ls_numnd,
							'5',
							'C',
							:str_appgeninfo.empresa,
							:str_appgeninfo.sucursal,
							:ls_numero,
							sysdate,
							:lc_valcruce,
							:lc_valcruce); 

If sqlca.sqlcode < 0 then
	messageBox("ERROR","No se pudo realizar el cruce autom$$HEX1$$e100$$ENDHEX$$tico")
	rollback;
	return -1
end if

/*Actualizar el valor del Movimiento de debito original*/

update cc_movim
set mt_saldo = mt_saldo - :lc_valcruce
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and bo_codigo = :str_appgeninfo.seccion
and tt_codigo = '1'
and tt_ioe = 'D'
and ve_numero = :ai_factura
and es_codigo = '1'
and mt_codigo = :ls_numnd;

if sqlca.sqlcode < 0 then
	messageBox("ERROR","No puedo actualizar el saldo del d$$HEX1$$e900$$ENDHEX$$bito.")
	rollback;
	return -1
end if 

ll_numero = long(as_numnc)

update fa_venta
set ve_valotros = ve_valotros - :lc_saldonc
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and bo_codigo = :str_appgeninfo.seccion
and es_codigo = '9'
and ve_numero = :ll_numero;

if sqlca.sqlcode < 0 then
	messageBox("ERROR","No puedo actualizar el saldo de la NC")
	rollback;
	return -1
end if 

return 1

end function

public function integer wf_actualiza_saldo_cupo (string as_cliente, decimal ad_valor);
UPDATE FA_CLIEN
SET CE_SALCRE = CE_SALCRE + :ad_valor
WHERE CE_CODIGO = :as_cliente
AND EM_CODIGO = :str_appgeninfo.empresa;
	
if sqlca.sqlcode < 0 then
messageBox('Error Interno', 'Funci$$HEX1$$f300$$ENDHEX$$n wf_acualiza_saldo_cupo ' +sqlca.sqlerrtext)
return -1
end if

return 1
end function

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costprom, decimal ac_costtrans);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
// sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=2, tm_ioe='E' es egreso por ventas


long    ll_num_movim,ll_fila
string  ls_num_movim,ls_observa,ls_obs_kit,ls_factura
boolean lb_exito = TRUE


ls_factura = string(al_factura)
ls_observa = 'Devol. Factura de Venta No. '+ls_factura
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Devol. Kit "+is_codant+" Factura de Venta No. "+ls_factura	
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'5')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_atomo)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad * ac_cantatomo)
     dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo_atomo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_obs_kit)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",is_estado)		

	// inserta el movimiento del kit (grande)
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		rollback;
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	// ingresa el Kit
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'5')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)	
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans)	
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_costo",ic_costo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",is_estado)		

else
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		rollback;		
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'5')
	dw_movim.setitem(ll_fila,"tm_ioe",'I')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)	
     dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans)	
     dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_costo",ic_costo)
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",is_estado)		
end if
return(TRUE)

end function

event open;this.ib_notautoretrieve = true
dw_cab.InsertRow(0)
dw_datos.settransobject(sqlca)
dw_movim.settransobject(sqlca)
call super::open
dw_cab.SetFocus()
end event

on w_devolucion_nveces.create
int iCurrent
call super::create
this.dw_cab=create dw_cab
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_2=create st_2
this.dw_movim=create dw_movim
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cab
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_movim
end on

on w_devolucion_nveces.destroy
call super::destroy
destroy(this.dw_cab)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_2)
destroy(this.dw_movim)
end on

event resize;dataWindow ldw_aux

if this.ib_inReportMode then
	ldw_aux = dw_report
	ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight() - 2*ldw_aux.y)
else
	ldw_aux = dw_datos
	ldw_aux.resize(this.workSpaceWidth() - ldw_aux.x, this.workSpaceHeight() - ldw_aux.y)
end if

end event

event ue_update;call super::ue_update;dec{2}    ld_total,  /* Total de la devolucion por la que se genera una NC de este valor*/ &
          ld_cantid, ld_iva, ld_subtot, ld_desc,ld_neto,lc_falta,lc_falta_orig
dec{2}    lc_candes,lc_precio,lc_desc1,lc_desc2,lc_desc3,lc_devolu,lc_descue,lc_total,lc_cantid
string    ls_numero,ls_caja, ls_empleado, ls_letras,ls_itcodigo,ls_numpre,ls_observ
string    ls_error, ls_cliente, ls_item, ls_estado,&
          ls_numdevol   /*Numero de la devolucion*/
long      li_num_venta, /*Numero de la factura*/ &
           ll_secue,ll_nreg,ll_reg
long      ll_total_registros, ll_numdevol,ll_numero,ll_devolu
datetime  hoy
char      lch_kit
dec{4}    lc_costo_atomo,lc_cantatomo,lc_costprom,lc_costtrans
integer   li_i,li_plazo,li
string	 ls_motivo,ls_status,ls_atomo,ls_motor,ls_chasis


SetPointer(HourGlass!)
If dw_datos.AcceptText() < 1 Then return
select sysdate
into: hoy
from dual;

//Control para verificar el estado de la devoluci$$HEX1$$f300$$ENDHEX$$n q sea el correcto
ll_numero = dw_cab.getitemnumber(1,'numero')
if rb_1.checked then 
	ls_estado = '1'
end if	
if rb_2.checked then 
	ls_estado = '2'
end if

If is_estadofact <> ls_estado then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Tipo de documento no corresponde al n$$HEX1$$fa00$$ENDHEX$$mero de factura~n"+&
				  "Cambie el Tipo o verif$$HEX1$$ed00$$ENDHEX$$que")
	return
end if

ll_total_registros = dw_datos.rowcount()
ls_observ    = dw_cab.getitemstring(1,'ve_observ')
ls_motivo	 = dw_cab.getitemstring(1,"ve_motivo")
ls_numpre	 = dw_cab.getitemstring(1,"num_nc")
li_num_venta =  dw_datos.getitemnumber(1,'ve_numero')
ls_cliente   =   dw_datos.getitemstring(1,"fa_venta_ce_codigo")
ls_empleado  = dw_datos.getitemstring(1,"fa_venta_ep_codigo")
//ls_numpre    = dw_datos.getitemstring(1,"fa_venta_ve_numpre")
ls_estado    = dw_datos.getitemstring(1,'es_codigo')
ld_subtot    = dw_datos.getitemnumber(1,"cc_neto") //--cc_tot
ld_desc      = dw_datos.getitemnumber(1,"cc_descto") //--desc
ld_total     = dw_datos.getitemnumber(1,"cc_totaldevol") //--cc_total
ld_iva       = dw_datos.getitemnumber(1,"cc_iva")//--iva
ld_neto      =  ld_subtot - ld_desc

//Sirve para cuando un usuario le cambiar$$HEX1$$f300$$ENDHEX$$n de sucursal, 
//por ende ya no tiene permiso para realizar devoluciones en la sucursal actual
If is_estado = '10' Then	
	select ep_codigo
	into:ls_empleado
	from no_emple
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and sa_login = :str_appgeninfo.username;
	if sqlca.sqlcode = 100 then
	messageBox('Error','No se puede generar la N/C en ventas~r~nUsuario no autorizado  ' + sqlca.sqlerrtext)
	return
	end if
End if
ls_letras = f_numero_a_letras(ld_total)
ls_caja = dw_datos.getitemstring(1,"fa_venta_cj_caja")
//else
//	setnull(ls_caja)

	
select pr_valor
into :ll_numdevol
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'COD_DEVOL'
for update of pr_valor;

update pr_param
set pr_valor = pr_valor + 1
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'COD_DEVOL';

ls_numdevol = string(ll_numdevol)


//Verificar que no exista un nro preimpreso igual
select count(1) into :li from fa_venta where es_codigo in (9,10) and ve_preant = :ls_numpre;
if li> 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existe una NC registrada con ese preimpreso...!!!")
	return
end if


//inserta nc
INSERT INTO "FA_VENTA"  ( "ES_CODIGO","EM_CODIGO","SU_CODIGO","BO_CODIGO","VE_NUMERO","CJ_CAJA",   
									 "CE_CODIGO","EP_CODIGO","VE_NUMPRE","VE_FECHA","VE_HORA","VE_SUBTOT",   
									 "VE_DESCUE","VE_NETO","VE_IVA","VE_CARGO","VE_VALPAG","VE_OBSERV",   
									 "VE_LEYENDA","VE_EFECTIVO","VE_VALOTROS","VE_CAMBIO","VE_PREANT",   
									 "VE_VALLETRAS","VE_MOTIVO","ESTADO","GU_NUMERO")  
VALUES ( :is_estado,:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,:ll_numdevol,:ls_caja,
               :ls_cliente,:ls_empleado,:li_num_venta,sysdate,sysdate,:ld_subtot,
			:ld_desc,:ld_neto,:ld_iva, 0,:ld_total,:ls_observ,
			'Nota de cr$$HEX1$$e900$$ENDHEX$$dito por devoluci$$HEX1$$f300$$ENDHEX$$n en ventas',0,:ld_total,0,:ls_numpre,
			:ls_letras,:ls_motivo,null,null ) ;
if sqlca.sqlcode < 0 then
messageBox('Error Interno','No se puede generar la N/C en ventas  ' + sqlca.sqlerrtext)
rollback;
return
end if

dw_movim.reset()
For li_i = 1 to ll_total_registros
	ll_devolu = dw_datos.getitemNumber(li_i,"dv_devolu")

	If not isnull(ll_devolu) and ll_devolu > 0 then 
		lc_falta = 0
		ls_itcodigo = dw_datos.getitemstring(li_i,'it_codigo')
		ll_secue = dw_datos.getitemnumber(li_i,'dv_secue')
		lc_cantid = dw_datos.getitemnumber(li_i,'dv_cantid')	
		lc_candes = dw_datos.getitemdecimal(li_i,'dv_candes')
		lc_precio = dw_datos.getitemdecimal(li_i,'dv_precio')
		lc_desc1 = dw_datos.getitemdecimal(li_i,'dv_desc1')
		lc_desc2 = dw_datos.getitemdecimal(li_i,'dv_desc2')	
		lc_desc3 = dw_datos.getitemdecimal(li_i,'dv_desc3')		
		lc_descue = dw_datos.getitemdecimal(li_i,'dv_descue')		
		lc_total = dw_datos.getitemdecimal(li_i,'cc_subtotal') //--cc_subtot	
		
		ls_motor = dw_datos.getitemstring(li_i,'dv_motor')
		ls_chasis = dw_datos.getitemstring(li_i,'dv_chasis')		
		is_codant = dw_datos.getitemstring(li_i,'codant')				
		lch_kit = dw_datos.getitemstring(li_i,'it_kit')
		ic_costo = dw_datos.getitemdecimal(li_i,'it_costo')
		lc_falta_orig = dw_datos.getitemdecimal(li_i,'dv_falta',primary!,true)				
		lc_falta = dw_datos.getitemdecimal(li_i,'dv_falta')						
		if isnull(lc_falta) then lc_falta = 0
		dw_datos.setitem(li_i,"dv_dfecha",hoy)
		dw_datos.setitem(li_i,"ve_numnc",ls_numdevol)
		lc_falta = lc_falta + ll_devolu
		dw_datos.setitem(li_i,"dv_falta",lc_falta)
		
		if lc_falta <= lc_candes then

			INSERT INTO "FA_DETVE"  ( "ES_CODIGO", "BO_CODIGO","VE_NUMERO","IT_CODIGO","EM_CODIGO","SU_CODIGO",
											"DV_SECUE", "DV_CANTID","DV_CANDES","DV_PRECIO","DV_DESC1","DV_DESC2",
											"DV_DESC3","DV_DESCUE","DV_TOTAL","DV_ENTREGA","DV_DEVOLU","DV_YANC",
											"DV_DFECHA","VE_NUMNC","DV_FALTA","ESTADO","DV_MOTOR","DV_CHASIS")  
			VALUES ( :is_estado,:str_appgeninfo.seccion,:ll_numdevol,:ls_itcodigo,:str_appgeninfo.empresa,:str_appgeninfo.sucursal,
								:ll_secue,:lc_candes,:ll_devolu,:lc_precio,:lc_desc1,:lc_desc2,:lc_desc3,:lc_descue,:lc_total,'E',:ll_devolu,'S',
						sysdate,:li_num_venta,:lc_falta,null,:ls_motor,:ls_chasis) ;
			if sqlca.sqlcode < 0 then
				messageBox('Error Interno','No se puede generar la N/C en ventas' + sqlca.sqlerrtext)
				rollback;
				return
			end if

			If lch_kit = 'S' Then
				SELECT "IN_ITEM"."IT_COSTO", "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
				INTO :lc_costo_atomo,:ls_atomo, :lc_cantatomo
				FROM "IN_ITEM"  , "IN_RELITEM"
				WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
				("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
				("IN_RELITEM"."TR_CODIGO" = '1' ) and
				( "IN_RELITEM"."IT_CODIGO1" = :ls_itcodigo ) and
				( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
			End if			
			
			if f_carga_stock_tdr_sucursal_new(ls_itcodigo,ll_devolu,lch_kit,ls_atomo,lc_cantatomo) = false Then
				rollback;
				return
			End if
			if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_itcodigo,ll_devolu,lch_kit,ls_atomo,lc_cantatomo) = false Then
				rollback;
				return
			End if			

			//Determinar el costo promedio
		     select NVL(mv_costtrans,0)
			into   :lc_costtrans
			from in_movim
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and tm_codigo = '2'
			and ve_numero = :li_num_venta
			and it_codigo = :ls_itcodigo;
			
					
			if sqlca.sqlcode <> 0 then
			lc_costtrans = 0	
			end if
			
			//El costo de la transacci$$HEX1$$f300$$ENDHEX$$n en este caso es el costo promedio  
			lc_costprom =  f_costprom(ls_itcodigo,'I',ll_devolu,lc_costtrans)
			
			if wf_mov_inventario(ls_itcodigo,ll_devolu,hoy,li_num_venta,&
								lch_kit,ls_atomo,lc_cantatomo,lc_costo_atomo,lc_costprom,lc_costtrans) = false then
						rollback;
				dw_movim.reset()
				messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario")
				return 
			end if	  		
		else
				rollback;
				messagebox("Error","No puede devolver mas de lo despachado o vendido...verifique")
				dw_datos.setitem(li_i,"dv_falta",lc_falta_orig)
				return
		end if
   End if
Next

If ls_estado = '1' then //solo en facturas al por mayor
	If wf_nota_credito(ls_cliente,li_num_venta,ld_total,ls_numdevol ) = -1 Then
		messagebox('Error Interno','No se puede actualizar la nota de credito a cxc')
		return
	End if
	wf_actualiza_saldo_cupo(ls_cliente,ld_total)	
End if

If ls_estado = '2' then //solo en facturas POS
	select ce_plazo
	into :li_plazo
	from fa_clien
	where ce_codigo = :ls_cliente
	and em_codigo = :str_appgeninfo.empresa;

	if li_plazo >= 30 then
		wf_actualiza_saldo_cupo(ls_cliente,ld_total)
	end if
end if


li_i = dw_datos.Update(true,false)
if li_i = 1 then
     li_i = dw_movim.update(true,false)
	  if li_i = 1 then			
		    dw_datos.resetupdate()
			 dw_movim.resetupdate()
		    commit;
	  else
	    rollback;
	 	 return
  	  end if			 
else
  rollback;
  messagebox('Error Interno','No se puede actualizar la nota de credito')
  return
end if	

dw_datos.Retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,li_num_venta,ich_exiva )

dw_report.SetTransObject(sqlca)
ll_nreg = dw_report.Retrieve(is_estado,str_appgeninfo.empresa, str_appgeninfo.sucursal,ls_numpre )
If ll_nreg = 0 Then 
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Error de la Nota de Cr$$HEX1$$e900$$ENDHEX$$dito pues no existen datos para imprimir")	
	return
end if
dw_report.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"' st_seccion.text ='"+gs_bo_nombre+"'" )	
dw_report.Modify("DataWindow.Footer.Height=2600")  //Para motegi
dw_report.Print()
SetPointer(Arrow!)
end event

event ue_insert;return 1

end event

event ue_delete;return 1
end event

event closequery;return
end event

event ue_retrieve;long   ll_numero
string ls_cod_cli,ls_nombre,ls_apellido,ls_razon,&
		 ls_nomrep,ls_aperep,ls_ce_codigo,ls_con_cliente,&
		 ls_preimpf,ls_preimpnc
int li_rc


setpointer(hourglass!)

if rb_1.checked then 
	is_estadofact = '1'
	is_estado = '9'
end if	
if rb_2.checked then 
	is_estadofact = '2'
	is_estado = '10'
end if

dw_cab.accepttext()	
ll_numero = dw_cab.getitemnumber(1,"numero")
ls_preimpf = trim(dw_cab.getitemstring(1,"num_fact"))
ls_preimpnc = trim(dw_cab.getitemstring(1,"num_nc"))

if isnull(ll_numero) then
 messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','N$$HEX1$$fa00$$ENDHEX$$mero de Factura no registrado o Ingrese el n$$HEX1$$fa00$$ENDHEX$$mero')
 dw_cab.setcolumn("numero")
 return
end if

if isnull(is_estadofact) or is_estadofact = '' then
 messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Seleccione el tipo de documento')
 dw_cab.setcolumn("numero")
 return
end if

if isnull(ls_preimpf) then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero preimpreso de la factura')
	dw_cab.setcolumn("num_fact")
	dw_cab.setfocus()
	return
end if


if isnull(ls_preimpnc) then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero preimpreso de la Nota de Cr$$HEX1$$e900$$ENDHEX$$dito')
	dw_cab.setcolumn("num_nc")
	dw_cab.setfocus()
	return
end if




//No permitir ingresar si ya existe una NC con ese preimpreso.
select count(1)
into :li_rc
from fa_venta
where es_codigo = :is_estado
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ve_preant = :ls_preimpnc;

if li_rc > 1 then 
	Messagebox("Atencion","Ya existe una NC con ese numero de preimpreso ...por favor verifique...!!!")
	return
end if

//
select ce_codigo
into :ls_ce_codigo
from fa_venta
where es_codigo = :is_estadofact
and em_codigo = :str_appgeninfo.empresa
and su_codigo =:str_appgeninfo.sucursal
and ve_numero = :ll_numero;

If sqlca.sqlcode = 100 Then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','No existe factura con este n$$HEX1$$fa00$$ENDHEX$$mero')
	dw_cab.setcolumn("numero")
	return
end if


SELECT "FA_CLIEN"."CE_CODIGO",   
		"FA_CLIEN"."CE_NOMBRE",   
		"FA_CLIEN"."CE_APELLI",   
		"FA_CLIEN"."CE_RAZONS",   
		"FA_CLIEN"."CE_NOMREP",   
		"FA_CLIEN"."CE_APEREP",
		NVL("FA_CLIEN"."CE_EXIVA",'N')		
 INTO :ls_cod_cli,   
		:ls_nombre,   
		:ls_apellido,   
		:ls_razon,   
		:ls_nomrep,   
		:ls_aperep,
		:ich_exiva		
 FROM "FA_CLIEN"
WHERE "FA_CLIEN"."CE_CODIGO" = :ls_ce_codigo 
 AND  "FA_CLIEN"."EM_CODIGO" = :str_appgeninfo.empresa;

ls_con_cliente = (ls_cod_cli+'/ ')
if not isnull(ls_razon) then
	ls_con_cliente = ls_con_cliente+ls_razon+' - '
end if
if not isnull(ls_nombre) then
	ls_con_cliente = ls_con_cliente+ls_nombre+' '
end if
if not isnull(ls_apellido) then
	ls_con_cliente = ls_con_cliente+ls_apellido+' '
end if
if not isnull(ls_nomrep) then
	ls_con_cliente = ls_con_cliente+ls_nomrep+' '
end if
if not isnull(ls_aperep) then
	ls_con_cliente = ls_con_cliente+ls_aperep
end if
if not isnull(ls_con_cliente) then
	dw_cab.modify("t_cliente.text = '"+ls_con_cliente+"'")
end if

dw_datos.Retrieve(is_estadofact,str_appgeninfo.empresa,str_appgeninfo.sucursal,ll_numero,ich_exiva) 
dw_report.Reset()
dw_datos.setfocus()
setpointer(arrow!)


end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_devolucion_nveces
integer x = 18
integer y = 448
integer width = 4489
integer height = 1160
integer taborder = 20
string dataobject = "d_devolucion_nveces"
boolean hscrollbar = false
end type

event dw_datos::rbuttondown;return 1
end event

event dw_datos::itemchanged;dec{2} lc_devolu = 0,lc_totdevol = 0,lc_candes

accepttext()
if dwo.name = "dv_devolu" Then
	
	If match(gettext(),"^[0-9]+$") = false then
		is_mensaje = "La cantidad a devolver debe ser numero(+)"
		return 1
	end if
	
	lc_devolu = getitemdecimal(row,"dv_devolu")
	lc_candes = getitemdecimal(row,"dv_candes")
	lc_totdevol = getitemdecimal(row,"dv_falta")
	if isnull(lc_totdevol) then lc_totdevol = 0
	lc_totdevol = lc_totdevol + lc_devolu
	If lc_totdevol > lc_candes Then
		is_mensaje = "No puede devolver mas de lo despachado"
		return 1
	End if
End if
end event

event dw_datos::itemerror;call super::itemerror;long ll_devolu
setnull(ll_devolu)
messagebox("Error",is_mensaje)
setitem(row,"dv_devolu",ll_devolu)		
return 1

end event

event dw_datos::clicked;call super::clicked;String ls_empresa,ls_suc,ls_bod,ls_codigo
Long ll_factura
datawindowchild  ldwc_nc

if  dwo.name = 'nc' then
	ls_empresa = this.getitemString(row,'em_codigo')
	ls_suc = this.getitemString(row,'su_codigo')
	ls_bod = this.getitemString(row,'bo_codigo')
	ll_factura = this.getitemNumber(row,'ve_numero')
	ls_codigo = this.getitemString(row,'it_codigo')
	this.getchild("nc",ldwc_nc)	
	ldwc_nc.SetTransObject(sqlca)
	ldwc_nc.retrieve(ls_empresa,ls_suc,ls_bod,ll_factura,ls_codigo)
     
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_devolucion_nveces
integer x = 37
integer y = 8
integer width = 3781
integer height = 1604
integer taborder = 0
string dataobject = "d_nc_preimp_devol_facytick_veh"
end type

type dw_cab from datawindow within w_devolucion_nveces
integer x = 23
integer y = 108
integer width = 3771
integer height = 304
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_fac_devolucion"
boolean border = false
boolean livescroll = true
end type

type rb_1 from radiobutton within w_devolucion_nveces
integer x = 539
integer y = 28
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Factura"
end type

type rb_2 from radiobutton within w_devolucion_nveces
integer x = 896
integer y = 28
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Ticket"
end type

type st_2 from statictext within w_devolucion_nveces
integer x = 64
integer y = 32
integer width = 425
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
string text = "Tipo de documento"
boolean focusrectangle = false
end type

type dw_movim from datawindow within w_devolucion_nveces
boolean visible = false
integer x = 1669
integer y = 16
integer width = 105
integer height = 80
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean border = false
boolean livescroll = true
end type


HA$PBExportHeader$w_devolucion.srw
$PBExportComments$Devolucion de facturas de venta
forward
global type w_devolucion from w_sheet_1_dw_maint
end type
type dw_cab from datawindow within w_devolucion
end type
type rb_1 from radiobutton within w_devolucion
end type
type rb_2 from radiobutton within w_devolucion
end type
type st_2 from statictext within w_devolucion
end type
end forward

global type w_devolucion from w_sheet_1_dw_maint
integer width = 4027
integer height = 1520
string title = "Devoluci$$HEX1$$f300$$ENDHEX$$n de Facturas"
long backcolor = 82899184
dw_cab dw_cab
rb_1 rb_1
rb_2 rb_2
st_2 st_2
end type
global w_devolucion w_devolucion

type variables
string is_estado,is_estadofact
end variables

forward prototypes
public function integer wf_preprint ()
public function integer wf_devolucion_iva (string as_cliente, long ai_factura, decimal ad_total)
public function integer wf_nota_credito (string as_cliente, long ai_factura, decimal ad_total, string as_numnc)
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura)
public function integer wf_actualiza_saldo_cupo (string as_cliente, decimal ad_valor)
end prototypes

public function integer wf_preprint ();//long ll_ve_numero
//ll_ve_numero = dw_datos.GetItemNumber(1,'ve_numero')
//dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
//                   ll_ve_numero, '1')
//	
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
/* Funcion: wf_nota_credito:                                                     */ 
/* Descripci$$HEX1$$f300$$ENDHEX$$n: Genera un movimiento de credito por el valor de la devolucion    */
/* y actualiza el saldo de la factura que genero la nc.                          */
/* En el caso de que la factura tenga el saldo cero ,no se debe cruzar la factura*/
/* y la nota de credito queda a favor del cliente                                */                                             
/*********************************************************************************/

String    ls_numero,&
          ls_numnd //Numero del movimiento de debito
Long      ll_numero
Decimal{2}lc_valcruce, /*Valor del cruce*/ &
          lc_saldo, /*Saldo de la factura.*/&
			 lc_nc,    /*valor de la nota de cr$$HEX1$$e900$$ENDHEX$$dito*/&
			 lc_saldonc
boolean   lb_cruzar			 
			 

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
Rollback;
return -1
End if

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
MessageBox("ERROR","No puedo encontrar los datos del d$$HEX1$$e900$$ENDHEX$$bito " +sqlca.sqlerrtext)
Rollback;
return -1
end if


if lc_saldo <= 0 then 
lb_cruzar = false
else
lb_cruzar = true
end if


if Abs(lc_nc  - lc_saldo) > 0.02 then
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
	MessageBox("Error","No se pudo generar el movimiento de cr$$HEX1$$e900$$ENDHEX$$dito: "+sqlca.sqlerrtext,StopSign!)
	Rollback;
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
				"ESTADO",   
				"IG_NUMERO",   
				"CH_FECEFEC",   
				"FP_CODIGO" ) 
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
				null,
				null,
				sysdate,
				'2' )  ;

If sqlca.sqlcode < 0 then
	MessageBox("ERROR","No puedo realizar el pago autom$$HEX1$$e100$$ENDHEX$$tico~r~n" +Sqlca.sqlerrtext)
	Rollback;
	return -1
end if

If lb_cruzar = false &
Then
Return 1
End if

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
values (						'1',
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


return 1

end function

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
// sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=2, tm_ioe='E' es egreso por ventas

long ll_num_movim,ll_contador = 0,ll_max,li_i
decimal ld_costo,ld_cantidad,ld_costo_kit
string ls_num_movim,ls_factura,ls_es_kit,ls_componente,ls_codant
boolean lb_exito = TRUE
s_kit   lstr_kit[]

ls_factura = string(al_factura)

// busca los componentes de un kit
declare kit_cursor cursor for
select it_codigo,ri_cantid
from in_relitem
where em_codigo = :str_appgeninfo.empresa
and it_codigo1 = :as_item
and tr_codigo = '1';   

// inserto el movimiento del item
ll_num_movim = f_dame_sig_numero('NUM_MINV')
ls_num_movim = string(ll_num_movim) 
SELECT "IN_ITEM"."IT_COSTO"  
INTO :ld_costo
FROM "IN_ITEM"  
WHERE ( "IN_ITEM"."EM_CODIGO" = :str_appgeninfo.empresa ) and  
( "IN_ITEM"."IT_CODIGO" = :as_item );

insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                     mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
	     				   mv_observ,mv_usado,ve_numero,es_codigo)
values ('5','I',:as_item,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,
        :ls_num_movim,:ad_cantidad,:ld_costo,:ad_fecha,:str_appgeninfo.empresa,
	     'Devoluci$$HEX1$$f300$$ENDHEX$$n en Ticket/Factura de Venta No. '||:ls_factura,'N',:ls_factura,:is_estado);
//commit;
if sqlca.sqlcode <> 0 and sqlca.sqldbcode = 1 then
	do
		ll_num_movim = f_dame_sig_numero('NUM_MINV')
		ls_num_movim = string(ll_num_movim) 
		insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                     		mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
	     				   		mv_observ,mv_usado,ve_numero,es_codigo)
		values ('5','I',:as_item,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,
        	  	  :ls_num_movim,:ad_cantidad,:ld_costo,:ad_fecha,:str_appgeninfo.empresa,
	     	  	  'Devoluci$$HEX1$$f300$$ENDHEX$$n en Ticket/Factura de Venta No. '||:ls_factura,'N',:ls_factura,:is_estado);
	  //  commit; 
      loop while sqlca.sqlcode <> 0 and sqlca.sqldbcode = 1
end if
if sqlca.sqlcode <> 0 and sqlca.sqldbcode <> 1 then
	lb_exito = FALSE
	rollback;
	return false
End if
if lb_exito then
// busca si el item es kit o no 
select it_kit,it_codant
into :ls_es_kit,:ls_codant
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codigo = :as_item;
if ls_es_kit = 'S' then	// es un kit
 	  select count(*)
	  into :ll_max
	  from in_relitem
	  where em_codigo = :str_appgeninfo.empresa
	  and it_codigo1 = :as_item
	  and tr_codigo = '1';
	  open kit_cursor;
	  li_i = 1
	 do
		// se inserta los componentes del item tipo kit
		fetch kit_cursor into :lstr_kit[li_i].codigo,:lstr_kit[li_i].cantidad;
		if sqlca.sqlcode <> 0 then exit;
		li_i ++
	 loop while TRUE;
	close kit_cursor;		
	 for li_i = 1 to ll_max
		  ll_num_movim = f_dame_sig_numero('NUM_MINV')
		  ls_num_movim = string(ll_num_movim)
		  SELECT "IN_ITEM"."IT_COSTO"  
            INTO :ld_costo_kit
   	       FROM "IN_ITEM"  
  		  WHERE ( "IN_ITEM"."EM_CODIGO" = :str_appgeninfo.empresa ) and  
            ( "IN_ITEM"."IT_CODIGO" = :lstr_kit[li_i].codigo);

		  insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
										mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
										mv_observ,mv_usado,ve_numero,es_codigo)
		  values ('5','I',:lstr_kit[li_i].codigo,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,
					  :ls_num_movim,:ad_cantidad*:lstr_kit[li_i].cantidad,:ld_costo_kit,:ad_fecha,:str_appgeninfo.empresa,
					  'Devoluci$$HEX1$$f300$$ENDHEX$$n de Kit '||:ls_codant||' Ticket/Factura No. '||:ls_factura,'N',:ls_factura,:is_estado);
//	       commit;
		  if sqlca.sqlcode <> 0 and sqlca.sqldbcode = 1 then
			do
				ll_num_movim = f_dame_sig_numero('NUM_MINV')
				ls_num_movim = string(ll_num_movim)
				insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                       				mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
		  					  				mv_observ,mv_usado,ve_numero,es_codigo)
  				values ('5','I',:lstr_kit[li_i].codigo,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,
          	  	  	  :ls_num_movim,:ad_cantidad*:lstr_kit[li_i].cantidad,:ld_costo_kit,:ad_fecha,:str_appgeninfo.empresa,
		    	  	  	  'Devoluci$$HEX1$$f300$$ENDHEX$$n de Kit '||:ls_codant||' Ticket/Factura No. '||:ls_factura,'N',:ls_factura,:is_estado);
			    // commit;
		    loop while sqlca.sqlcode <> 0 and sqlca.sqldbcode = 1
		end if
		if sqlca.sqlcode <> 0 then 
			lb_exito = FALSE
			rollback;
			return false
		End if
	next
end if // de si es kit
end if // de si lb_exito
if lb_exito then
//	commit;
	return (TRUE)
else
	return(FALSE)
end if
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

event open;this.ib_notautoretrieve = true
dw_cab.InsertRow(0)
dw_datos.settransobject(sqlca)


//if gs_estado = '2' then
//	this.title = 'Devoluci$$HEX1$$f300$$ENDHEX$$n de Tickets (POS)'
//	is_estado = '10'
//else
//	this.title = 'Devoluci$$HEX1$$f300$$ENDHEX$$n de Facturas'
//	is_estado = '9'
//end if
call super::open
dw_cab.SetFocus()
end event

on w_devolucion.create
int iCurrent
call super::create
this.dw_cab=create dw_cab
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cab
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.st_2
end on

on w_devolucion.destroy
call super::destroy
destroy(this.dw_cab)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_2)
end on

event resize;dataWindow ldw_aux

if this.ib_inReportMode then
	ldw_aux = dw_report
	ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight() - 2*ldw_aux.y)
else
	ldw_aux = dw_datos
	ldw_aux.resize(this.workSpaceWidth(), this.workSpaceHeight() - (dw_cab.height +50 ))
end if

end event

event ue_update;dec{2}   ld_total,  /* Total de la devolucion por la que se genera una NC de este valor*/ &
              ld_cantid, ld_iva, ld_subtot, ld_desc,ld_neto
dec{2}   lc_candes,lc_precio,lc_desc1,lc_desc2,lc_desc3,lc_devolu,lc_descue,lc_total,lc_cantid
string      ls_numero,ls_caja, ls_empleado, ls_letras,ls_itcodigo,ls_numpre,ls_observ
string      ls_error, ls_cliente, ls_codant, ls_item, ls_estado,&
              ls_numdevol   /*Numero de la devolucion*/
long        li_num_venta, /*Numero de la factura*/ &
              li_indice, li,ll_secue,ll_nreg,ll_reg
long        ll_total_registros, ll_numdevol
datetime hoy
integer    li_i,li_devolu
string		ls_motivo,ls_status

SetPointer(HourGlass!)
If dw_datos.AcceptText() < 1 Then return
select sysdate
into: hoy
from dual;

ll_total_registros = dw_datos.rowcount()
ls_observ = dw_cab.getitemstring(1,'ve_observ')
li_num_venta =  dw_datos.getitemnumber(1,'ve_numero')
ls_cliente      =   dw_datos.getitemstring(1,"fa_venta_ce_codigo")
ls_empleado  = dw_datos.getitemstring(1,"fa_venta_ep_codigo")
ls_numpre  = dw_datos.getitemstring(1,"fa_venta_ve_numpre")
ls_estado      = dw_datos.getitemstring(1,'es_codigo')
ld_subtot       = dw_datos.getitemnumber(1,"cc_neto") //--cc_tot
ld_desc         = dw_datos.getitemnumber(1,"cc_descto") //--desc
ld_total          = dw_datos.getitemnumber(1,"cc_totaldevol") //--cc_total
ld_iva            = dw_datos.getitemnumber(1,"cc_iva")//--iva
ld_neto         =  ld_subtot - ld_desc
ls_motivo	  = dw_cab.getitemstring(1,"ve_motivo")

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

INSERT INTO "FA_VENTA"  ( "ES_CODIGO","EM_CODIGO","SU_CODIGO","BO_CODIGO","VE_NUMERO","CJ_CAJA",   
									 "CE_CODIGO","EP_CODIGO","VE_NUMPRE","VE_FECHA","VE_HORA","VE_SUBTOT",   
									 "VE_DESCUE","VE_NETO","VE_IVA","VE_CARGO","VE_VALPAG","VE_OBSERV",   
									 "VE_LEYENDA","VE_EFECTIVO","VE_VALOTROS","VE_CAMBIO","VE_PREANT",   
									 "VE_VALLETRAS","VE_MOTIVO","ESTADO","GU_NUMERO")  
VALUES ( :is_estado,:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,:ll_numdevol,
			  :ls_caja,:ls_cliente,:ls_empleado,:li_num_venta,sysdate,sysdate,:ld_subtot,:ld_desc,:ld_neto,:ld_iva,
			  0,:ld_total,:ls_observ,'Nota de cr$$HEX1$$e900$$ENDHEX$$dito por devoluci$$HEX1$$f300$$ENDHEX$$n en ventas',0,:ld_total,0,null,:ls_letras,:ls_motivo,null,null ) ;
if sqlca.sqlcode < 0 then
messageBox('Error Interno','No se puede generar la N/C en ventas  ' + sqlca.sqlerrtext)
rollback;
return
end if

For li_i = 1 to ll_total_registros
	li_devolu = dw_datos.getitemNumber(li_i,"dv_devolu")
	ls_status = dw_datos.getitemstring(li_i,"cc_status")
	If not isnull(li_devolu) and li_devolu > 0 and ls_status = "datamodified!" then
		ls_itcodigo = dw_datos.getitemstring(li_i,'it_codigo')
		ll_secue = dw_datos.getitemnumber(li_i,'dv_secue')
		lc_cantid = dw_datos.getitemnumber(li_i,'dv_cantid')	
		li_devolu = dw_datos.getitemnumber(li_i,'dv_devolu')			
		lc_candes = dw_datos.getitemdecimal(li_i,'dv_candes')
		lc_precio = dw_datos.getitemdecimal(li_i,'dv_precio')
		lc_desc1 = dw_datos.getitemdecimal(li_i,'dv_desc1')
		lc_desc2 = dw_datos.getitemdecimal(li_i,'dv_desc2')	
		lc_desc3 = dw_datos.getitemdecimal(li_i,'dv_desc3')		
		lc_descue = dw_datos.getitemdecimal(li_i,'dv_descue')		
		lc_total = dw_datos.getitemdecimal(li_i,'cc_subtotal') //--cc_subtot	
		dw_datos.setitem(li_i,"dv_dfecha",hoy)
		dw_datos.setitem(li_i,"ve_numnc",ls_numdevol)

	   INSERT INTO "FA_DETVE"  ( "ES_CODIGO", "BO_CODIGO","VE_NUMERO","IT_CODIGO","EM_CODIGO","SU_CODIGO",
									   "DV_SECUE", "DV_CANTID","DV_CANDES","DV_PRECIO","DV_DESC1","DV_DESC2",
										"DV_DESC3","DV_DESCUE","DV_TOTAL","DV_ENTREGA","DV_DEVOLU","DV_YANC",
										"DV_DFECHA","VE_NUMNC","DV_FALTA","ESTADO" )  
	   VALUES ( :is_estado,:str_appgeninfo.seccion,:ll_numdevol,:ls_itcodigo,:str_appgeninfo.empresa,:str_appgeninfo.sucursal,
	                  :ll_secue,:lc_candes,:li_devolu,:lc_precio,:lc_desc1,:lc_desc2,:lc_desc3,:lc_descue,:lc_total,'E',:li_devolu,'S',
					sysdate,:li_num_venta,0,null ) ;
		if sqlca.sqlcode < 0 then
		messageBox('Error Interno','No se puede generar la N/C en ventas' + sqlca.sqlerrtext)
		rollback;
		return
		end if
   End if
Next

ll_total_registros = dw_datos.rowcount()
for li_indice = 1 to ll_total_registros
	ls_codant = dw_datos.GetItemString(li_indice,"codant")
	ld_cantid = dw_datos.GetItemNumber(li_indice,"dv_devolu")
	ls_status = dw_datos.GetitemString(li_indice,"cc_status")
	select it_codigo
	into :ls_item
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	if sqlca.sqlcode < 0 then
		MessageBox("ERROR","No puedo recuperar el c$$HEX1$$f300$$ENDHEX$$digo del producto",StopSign!)
		return(1)
	end if
	if ld_cantid > 0 and not isnull(ld_cantid) and ls_status = "datamodified!"then
		If wf_mov_inventario(ls_item,ld_cantid,hoy,li_num_venta) = false Then
			messagebox("Error","Problemas al actualizar el inventario ... wf_mov_inventario")
			return
		End if
		f_carga_stock_tdr_sucursal(ls_item,ld_cantid)
		f_carga_stock_bodega(str_appgeninfo.seccion,ls_item,ld_cantid)
	end if
next


If ls_estado = '1' then //solo en facturas al por mayor
	If wf_nota_credito(ls_cliente,li_num_venta,ld_total,ls_numdevol) = -1 Then
		messagebox('Error Interno','No se puede actualizar la nota de credito a cxc')
		return
	End if
End if

wf_actualiza_saldo_cupo(ls_cliente,ld_total)


If dw_datos.update(True, False) = 1 then
  commit;	
else
  rollback;
  messagebox('Error Interno','No se puede actualizar la nota de credito')
  return
end if

SetPointer(HourGlass!)
dw_datos.Retrieve(ls_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,li_num_venta) 

dw_report.SetTransObject(sqlca)
ll_nreg = dw_report.Retrieve(is_estado,str_appgeninfo.empresa, str_appgeninfo.sucursal,ll_numdevol)
If ll_nreg = 0 Then 
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Error de la Nota de Cr$$HEX1$$e900$$ENDHEX$$dito pues no existen datos para imprimir")	
	return
end if
dw_report.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"' st_seccion.text ='"+gs_bo_nombre+"'" )	
dw_report.Print()
SetPointer(Arrow!)
end event

event ue_insert;return 1

end event

event ue_delete;return 1
end event

event closequery;return
end event

event ue_retrieve;return 1

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_devolucion
integer x = 9
integer y = 348
integer width = 3950
integer height = 1048
integer taborder = 30
string dataobject = "d_devolucion_nveces"
end type

event dw_datos::rbuttondown;return 1
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_devolucion
integer y = 1040
integer taborder = 0
string dataobject = "d_nc_preimp_devol_facytick_REDCOLOR"
end type

type dw_cab from datawindow within w_devolucion
integer x = 18
integer y = 120
integer width = 2939
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sel_fac_devolucion"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long ll_numero
string ls_cod_cli,ls_nombre,ls_apellido,ls_razon,ls_nomrep,ls_aperep,ls_ce_codigo,ls_con_cliente



setpointer(hourglass!)

if rb_1.checked then 
	is_estadofact = '1'
	is_estado = '9'
end if	
if rb_2.checked then 
	is_estadofact = '2'
	is_estado = '10'
end if
	

If dwo.name = "numero" Then
ll_numero = long(this.GetText())
this.setitem(1,"ve_observ",'')
dw_cab.setcolumn(2)
dw_cab.setfocus()
istr_argInformation.nrArgs = 4
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.argType[4] = "number"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = is_estadofact
istr_argInformation.NumberValue[4] = ll_numero

select ce_codigo
into :ls_ce_codigo
from fa_venta
where es_codigo = :is_estadofact
and em_codigo = :str_appgeninfo.empresa
and su_codigo =:str_appgeninfo.sucursal
and ve_numero = :ll_numero;

If sqlca.sqlcode <> 100 Then
 SELECT "FA_CLIEN"."CE_CODIGO",   
         "FA_CLIEN"."CE_NOMBRE",   
         "FA_CLIEN"."CE_APELLI",   
         "FA_CLIEN"."CE_RAZONS",   
         "FA_CLIEN"."CE_NOMREP",   
         "FA_CLIEN"."CE_APEREP"
    INTO :ls_cod_cli,   
         :ls_nombre,   
         :ls_apellido,   
         :ls_razon,   
    		:ls_nomrep,   
         :ls_aperep
    FROM "FA_CLIEN"
   WHERE "FA_CLIEN"."CE_CODIGO" = :ls_ce_codigo ;

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

dw_datos.Retrieve(is_estadofact,str_appgeninfo.empresa,str_appgeninfo.sucursal,ll_numero) 
dw_report.Reset()
setpointer(arrow!)
else
   messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','N$$HEX1$$fa00$$ENDHEX$$mero de ticket no registrado')
   setpointer(arrow!)
   this.setfocus()
   return
end if
End if
end event

type rb_1 from radiobutton within w_devolucion
integer x = 539
integer y = 28
integer width = 343
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Factura"
end type

type rb_2 from radiobutton within w_devolucion
integer x = 896
integer y = 28
integer width = 343
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ticket"
end type

type st_2 from statictext within w_devolucion
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


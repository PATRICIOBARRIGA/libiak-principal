HA$PBExportHeader$w_devolucion_compra_nveces.srw
$PBExportComments$Devolucion de facturas de venta
forward
global type w_devolucion_compra_nveces from w_sheet_1_dw_maint
end type
type dw_cab from datawindow within w_devolucion_compra_nveces
end type
type dw_movim from datawindow within w_devolucion_compra_nveces
end type
type sle_1 from singlelineedit within w_devolucion_compra_nveces
end type
type st_1 from statictext within w_devolucion_compra_nveces
end type
type st_2 from statictext within w_devolucion_compra_nveces
end type
type st_3 from statictext within w_devolucion_compra_nveces
end type
type em_1 from editmask within w_devolucion_compra_nveces
end type
type sle_2 from singlelineedit within w_devolucion_compra_nveces
end type
type dw_1 from datawindow within w_devolucion_compra_nveces
end type
type st_4 from statictext within w_devolucion_compra_nveces
end type
end forward

global type w_devolucion_compra_nveces from w_sheet_1_dw_maint
integer width = 4635
integer height = 2208
string title = "Devoluci$$HEX1$$f300$$ENDHEX$$n de Compras"
dw_cab dw_cab
dw_movim dw_movim
sle_1 sle_1
st_1 st_1
st_2 st_2
st_3 st_3
em_1 em_1
sle_2 sle_2
dw_1 dw_1
st_4 st_4
end type
global w_devolucion_compra_nveces w_devolucion_compra_nveces

type variables
string is_estado,is_codant,is_mensaje


end variables

forward prototypes
public function integer wf_preprint ()
public function integer wf_nota_debito_motos ()
public function integer wf_nota_debito (decimal ac_total, long ai_factura, decimal ac_neto, decimal ac_iva, long ac_numdevol, string as_corucsuc, string as_cofacpro, string as_proveedor, string as_preimp, string as_naut, date ad_fecemision)
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, long al_numnd, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo, long al_nrorecep, decimal ac_costprom, decimal ac_costtrans)
end prototypes

public function integer wf_preprint ();//long ll_ve_numero
//ll_ve_numero = dw_datos.GetItemNumber(1,'ve_numero')
//dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal, &
//                   ll_ve_numero, '1')
//	
return 1
end function

public function integer wf_nota_debito_motos ();/*ESTADO = 'N' : indica devoluci$$HEX1$$f300$$ENDHEX$$n en compra y quedan habilitados*/

long ll_reg,i
String ls_motor

dw_1.SetFilter("")
dw_1.Filter()

ll_reg = dw_1.rowcount()

for i = 1 to ll_reg

if  dw_1.object.cc_opcion[i] = '1' then
	ls_motor =  dw_1.object.di_ref1[i]
	UPDATE IN_ITEDET
	SET ESTADO = 'N',
	       DI_REF1 = DI_REF1||'@'
	WHERE EM_CODIGO = :str_appgeninfo.empresa
	AND SU_CODIGO = :str_appgeninfo.sucursal
	AND DI_REF1 = :ls_motor;
	
	If sqlca.sqlcode <> 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el detalle del item "+sqlca.sqlerrtext)
	Rollback;
	return -1
	end if
end if

next
return 1

end function

public function integer wf_nota_debito (decimal ac_total, long ai_factura, decimal ac_neto, decimal ac_iva, long ac_numdevol, string as_corucsuc, string as_cofacpro, string as_proveedor, string as_preimp, string as_naut, date ad_fecemision);/* Funcion: wf_nota_debito                                                     
Descripci$$HEX1$$f300$$ENDHEX$$n: Genera un movimiento de d$$HEX1$$e900$$ENDHEX$$bito por el valor de la devolucion de compra    
                     y actualiza el saldo de la factura que genero la nd.                          
                    En el caso de que la factura tenga el saldo cero ,no se debe cruzar la factura
                    y la nota de d$$HEX1$$e900$$ENDHEX$$bito queda a favor del proveedor */                                             


String    ls_numero,&
          ls_mpcodigo,/*Numero del movimiento de cr$$HEX1$$e900$$ENDHEX$$dito*/ & 
		ls_facpro, ls_pvcodigo	 
			 
Long      ll_numero
Decimal{2} lc_valcruce, /*Valor del cruce*/ &
                lc_saldo, /*Saldo de la factura.*/&
			  lc_nd,    /*valor de la nota de d$$HEX1$$e900$$ENDHEX$$bito*/&
			  lc_saldond
boolean   lb_cruzar			 
			 

lc_nd = ac_total

/*Para obtener el secuencial del d$$HEX1$$e900$$ENDHEX$$bito*/
select pr_valor
into :ll_numero
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'DEB_CXP'
for update of pr_valor;
	
update pr_param
set pr_valor = pr_valor + 1
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'DEB_CXP';
	
If sqlca.sqlcode < 0 then
MessageBox("Error","No se pudo obtener el numero de la nota de d$$HEX1$$e900$$ENDHEX$$bito "+sqlca.sqlerrtext,StopSign!)
Rollback;
return -1
End if

/*Para obtener los datos del debito*/
select mp_codigo,mp_saldo,pv_codigo
into :ls_mpcodigo,:lc_saldo,:ls_pvcodigo
from cp_movim
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :as_corucsuc
and tv_codigo = '1'
and tv_tipo = 'C'
and co_facpro = :as_cofacpro
//and co_numero = :ai_factura
and pv_codigo = :as_proveedor
and ec_codigo = '3';
	
if sqlca.sqlcode < 0 then
MessageBox("ERROR","No puedo encontrar los datos del cr$$HEX1$$e900$$ENDHEX$$dito " +sqlca.sqlerrtext)
Rollback;
return -1
end if


if lc_saldo = 0 then 
lb_cruzar = false
else
lb_cruzar = true
end if



if lc_nd > lc_saldo  &
then
lc_saldond  = lc_nd
lb_cruzar = false
else
lc_valcruce = lc_nd
lc_saldond  = lc_nd - lc_valcruce
end if



/*Insertar un movimiento como nota de credito*/
//ls_numero = string(ll_numero + 1)

INSERT INTO "CP_MOVIM"  
         ( "TV_CODIGO",   
           "TV_TIPO",   
           "EM_CODIGO",   
           "SU_CODIGO",   
           "MP_CODIGO",   
           "PV_CODIGO",   
           "EC_CODIGO",   
           "CO_NUMERO",   
           "RF_CODIGO",   
           "MP_FECHA",   
           "MP_VALOR",   
           "MP_VALRET",   
           "MP_SALDO",   
           "ESTADO",   
           "MP_CONTAB",   
           "MP_TRANSPORTE",   
           "EG_NUMERO",   
           "CO_FACPRO",   
           "MP_BASEIMP",   
           "MP_OBSERV",   
           "CP_NUMERO",   
           "MP_NOTAND",   
           "MP_RETIVA",   
           "MP_IVAND",   
           "MP_RETEN",
		 "MP_PREIMP",
		 "MP_NAUT",
		 "MP_FECEMISION" )  
VALUES ('2','D',:str_appgeninfo.empresa,:as_corucsuc,:ll_numero,:ls_pvcodigo,null,:ai_factura, 
        null,sysdate,:lc_nd,:ac_neto*.12,:lc_saldond,null,null,0,null,:as_cofacpro ,:ac_neto,'Devoluci$$HEX1$$f300$$ENDHEX$$n de Producto # Fprov: '||:as_cofacpro,
   	  null,null,null,null,null,:as_preimp,:as_naut,:ad_fecemision );

If sqlca.sqlcode < 0 then
	MessageBox("Error","No se pudo generar el movimiento de d$$HEX1$$e900$$ENDHEX$$bito: "+sqlca.sqlerrtext,StopSign!)
	Rollback;
	return -1
end if


/*Realizar la Cancelacion con la nota de d$$HEX1$$e900$$ENDHEX$$bito */
  INSERT INTO "CP_PAGO"  
         ( "TV_CODIGO",   
           "TV_TIPO",   
           "EM_CODIGO",   
           "SU_CODIGO",   
           "MP_CODIGO",   
           "PM_SECUENCIA",   
           "PM_FECHA",   
           "PM_VALOR",   
           "PM_FECPA",   
           "PM_INTER",   
           "PM_CXP",   
           "IF_CODIGO",   
           "CN_CODIGO",   
           "PM_DESCUE",   
           "ESTADO",   
           "FP_CODIGO",   
           "PM_NUMDOC",
		  "PM_PREIMP",
		  "PM_NAUT",
		  "PM_EMISION")  
  VALUES ( '2','D',:str_appgeninfo.empresa,:as_corucsuc,:ll_numero,1,sysdate,:lc_nd,sysdate,null,
                  null,0,null,null,null,'60',:ac_numdevol,:as_preimp,:as_naut,:ad_fecemision);
If sqlca.sqlcode < 0 then
	MessageBox("ERROR","No puedo realizar el pago autom$$HEX1$$e100$$ENDHEX$$tico~r~n" +Sqlca.sqlerrtext)
	Rollback;
	return -1
end if

If lb_cruzar = false &
Then
Return 1
End if

/*Realizar el cruce de la  nota de d$$HEX1$$e900$$ENDHEX$$bito */
  INSERT INTO "CP_CRUCE"  
         ( "TV_CODDEB",   
           "TV_TIPODEB",   
           "MP_CODDEB",   
           "TV_CODIGO",   
           "TV_TIPO",   
           "EM_CODIGO",   
           "SU_CODIGO",   
           "MP_CODIGO",   
           "CX_FECHA",   
           "CX_VALCRE",   
           "CX_VALDEB",   
           "ESTADO" )  
  VALUES ( '2','D',:ll_numero,'1','C',:str_appgeninfo.empresa,:as_corucsuc,:ls_mpcodigo,sysdate,
  				:lc_valcruce,:lc_valcruce,null);

If sqlca.sqlcode < 0 then
	messageBox("ERROR","No se pudo realizar el cruce autom$$HEX1$$e100$$ENDHEX$$tico")
	rollback;
	return -1
end if

/*Actualizar el valor del Movimiento de debito original*/

update cp_movim
set mp_saldo = mp_saldo - :lc_valcruce
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :as_corucsuc
and tv_codigo = '1'
and tv_tipo = 'C'
//and co_numero = :ai_factura
and co_facpro = :as_cofacpro
and pv_codigo = :as_proveedor
and ec_codigo = '3'
and mp_codigo = :ls_mpcodigo;

if sqlca.sqlcode < 0 then
	messageBox("ERROR","No puedo actualizar el saldo del cr$$HEX1$$e900$$ENDHEX$$dito.")
	rollback;
	return -1
end if 







return 1

end function

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_factura, long al_numnd, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo, long al_nrorecep, decimal ac_costprom, decimal ac_costtrans);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
// sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=6, tm_ioe='E' es devoluci$$HEX1$$f300$$ENDHEX$$n en compra

string ls_observa,ls_obs_kit,ls_num_movim,ls_nulo
long ll_num_movim,ll_fila

ls_observa = "Devol.ND "+string(al_numnd)+" de Fact. Compra No. "+string(al_factura)+" Recep No. "+string(al_nrorecep)
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Devol.ND "+string(al_numnd)+" de Kit "+is_codant+" Fact. Compra No. "+string(al_factura)
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'6')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_atomo)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad * ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo_atomo)	
     dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_obs_kit)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		

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
	dw_movim.setitem(ll_fila,"tm_codigo",'6')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans)	
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		

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
	dw_movim.setitem(ll_fila,"tm_codigo",'6')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costtrans)	
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",al_factura)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return(TRUE)

end function

event open;this.ib_notautoretrieve = true
dw_cab.InsertRow(0)
call super::open
dw_movim.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_cab.SetFocus()

end event

on w_devolucion_compra_nveces.create
int iCurrent
call super::create
this.dw_cab=create dw_cab
this.dw_movim=create dw_movim
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.em_1=create em_1
this.sle_2=create sle_2
this.dw_1=create dw_1
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cab
this.Control[iCurrent+2]=this.dw_movim
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_1
this.Control[iCurrent+8]=this.sle_2
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.st_4
end on

on w_devolucion_compra_nveces.destroy
call super::destroy
destroy(this.dw_cab)
destroy(this.dw_movim)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.sle_2)
destroy(this.dw_1)
destroy(this.st_4)
end on

event resize;call super::resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_cab.resize(li_width - 2*dw_cab.x, dw_cab.height)
dw_datos.resize(dw_cab.width,li_height - dw_datos.y - dw_cab.y)
this.setRedraw(True)
end event

event ue_update;decimal   lc_total,  /* Total de la devolucion por la que se genera una ND de este valor*/ &
                lc_iva, lc_subtot, ld_desc,lc_subtotal,lc_total_aux,lc_devolu
decimal   lc_stock,lc_desc1,lc_desc2,lc_desc3
dec{4}    ld_costo_atomo,ld_cantatomo,lc_costo,lc_costtrans,lc_costprom
string    ls_num_compra, ls_vendedor,ls_itcodigo,ls_facpro,ls_fp,ls_rucsuc,ls_mpcoddeb
string    ls_error, ls_proveedor,ls_item, ls_estadop,ls_mpcodigo,&
          ls_numnd/*Numero de la devolucion*/,ls_atomo,ls_preimp,ls_naut	 
long      ll_num_compra, /*Numero de la factura de compra*/ &
             ll_numpad,ll_cantid,li_indice, li,ll_nreg,ll_reg
long      ll_total_registros, ll_numnd,ll_numdoc,ll_falta_orig,ll_falta
date      ld_fecha,ld_femision
datetime  ldt_hoy
integer   li_i,li_secue,rc
char      lch_kit


SetPointer(HourGlass!)

//Verificar que existan los datos de la NC
ls_preimp   =  sle_1.text
ls_naut     =  sle_2.text
ld_femision = date(em_1.text)

if isnull(ls_preimp) or ls_preimp = '' then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ingrese el n$$HEX1$$fa00$$ENDHEX$$mero de nota de cr$$HEX1$$e900$$ENDHEX$$dito debe tener 13  d$$HEX1$$ed00$$ENDHEX$$gitos")
return
end if

If Not Match(ls_preimp, "^[0-9]+$")  or  len(ls_preimp) <> 13  Then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El N$$HEX1$$fa00$$ENDHEX$$mero de la Nota de D$$HEX1$$e900$$ENDHEX$$bito debe tener 13  d$$HEX1$$ed00$$ENDHEX$$gitos")
return
end if

if isnull(ls_naut) or ls_naut = '' then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ingrese el n$$HEX1$$fa00$$ENDHEX$$mero de autorizaci$$HEX1$$f300$$ENDHEX$$n del SRI debe tener 10  d$$HEX1$$ed00$$ENDHEX$$gitos")	
return
end if

If Not Match(ls_naut, "^[0-9]+$")  or  len(ls_naut) <> 10  Then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El N$$HEX1$$fa00$$ENDHEX$$mero  de autorizaci$$HEX1$$f300$$ENDHEX$$n debe tener 10  d$$HEX1$$ed00$$ENDHEX$$gitos")
return
end if

If not Isdate(em_1.text) then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ingrese la fecha de emisi$$HEX1$$f300$$ENDHEX$$n")	
return
end if	



If dw_datos.AcceptText() < 1 Then return

ldt_hoy = f_hoy()
ll_total_registros = dw_datos.rowcount()

ll_num_compra =dw_datos.getitemnumber(1,'in_detco_co_numero')
ls_num_compra = string(ll_num_compra)
//ll_numpad =  dw_datos.getitemnumber(1,'co_numpad')
ls_proveedor  =dw_datos.getitemstring(1,"pv_codigo")
ls_vendedor   =dw_datos.getitemstring(1,"vp_codigo")
ls_estadop    =dw_datos.getitemstring(1,"ec_codigo")
ls_facpro     =dw_datos.getitemstring(1,"co_facpro")
ld_fecha      =date(dw_datos.getitemdatetime(1,'co_fecha'))
lc_subtot     =dw_datos.getitemnumber(1,"cc_tot")
lc_iva        =dw_datos.getitemnumber(1,"cc_iva")
lc_total      =dw_datos.getitemnumber(1,"cc_total")
ls_fp         =dw_datos.getitemstring(1,"fp_codigo")
ls_rucsuc     =dw_datos.getitemstring(1,"co_rucsuc")

select mp_codigo
into: ls_mpcodigo
from cp_movim
where tv_codigo = '1'
and tv_tipo = 'C'
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ec_codigo = '3'
and co_numero = :ll_num_compra
and pv_codigo = :ls_proveedor
and co_facpro = :ls_facpro;
IF SQLCA.SQLCODE < 0 THEN
	messagebox("ATENCION","No se ha encontrado el codigo en cxp " +sqlca.sqlerrtext)
	rollback;
	return
END IF

/*secuencial para las devoluciones de compras*/
select pr_valor
into :ll_numnd
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'COD_DEVCOM'
for update of pr_valor;

update pr_param
set pr_valor = pr_valor + 1
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'COD_DEVCOM';

ls_numnd = string(ll_numnd)

/*Determinar el secuencial del tipo de pago*/
SELECT PS_VALOR
INTO:ll_numdoc
FROM PR_NUMSUC
WHERE EM_CODIGO  = :str_appgeninfo.empresa
AND SU_CODIGO  = :str_appgeninfo.sucursal
and PR_NOMBRE = 'NUM_ND_CXP'
FOR UPDATE OF PS_VALOR;

UPDATE PR_NUMSUC
SET PS_VALOR = PS_VALOR + 1
WHERE EM_CODIGO  = :str_appgeninfo.empresa
AND SU_CODIGO  = :str_appgeninfo.sucursal
and PR_NOMBRE = 'NUM_ND_CXP';
IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Actualizar el secuencial del tipo de pago " +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
END IF

/*Registra de la devoluci$$HEX1$$f300$$ENDHEX$$n de la compra con estado = 5*/
  INSERT INTO "IN_COMPRA"  ( "EC_CODIGO", "EM_CODIGO", "SU_CODIGO", "CO_NUMERO","PV_CODIGO", "VP_CODIGO",   
           "CO_FACPRO","CO_FECHA", "CO_FECREP","CO_SUBTOT", "CO_IVA", "CO_DESCUP", "CO_TOTAL", "EC_CODPAD",   
           "CO_NUMPAD", "CO_COMPLETA", "FP_CODIGO", "CO_TRANSPOR","CO_FECENT","CO_ENVIADA","CO_ENCXP",   
           "CO_OBSERV", "ESTADO", "CO_RUCSUC",   "CO_CONTAB" )  
  VALUES ( '5', :str_appgeninfo.empresa,:str_appgeninfo.sucursal, :ll_numnd, :ls_proveedor,   :ls_vendedor,   
           :ls_facpro, sysdate,:ld_fecha,  :lc_subtot, :lc_iva,   0, :lc_total,:ls_estadop,   
           :ll_num_compra,   null,:ls_fp, null,  null, null,   null,   
           'La nota de d$$HEX1$$e900$$ENDHEX$$bito debera ser usada por completo',   null,:ls_rucsuc,   null )  ;

	if sqlca.sqlcode < 0 then
	messageBox('Error Interno','No se puede generar la N/D en compras  ' + sqlca.sqlerrtext)
	rollback;
	return
	end if

For li_i = 1 to ll_total_registros
	lc_devolu = dw_datos.getitemNumber(li_i,"dc_devolu")	
	If not isnull(lc_devolu) and lc_devolu > 0 then
		     ll_numpad  = dw_datos.GetitemNumber(li_i,"co_numpad")
			ls_itcodigo = dw_datos.getitemstring(li_i,'it_codigo')
			li_secue = dw_datos.getitemnumber(li_i,'dc_secue')
			ll_cantid = dw_datos.getitemnumber(li_i,'dc_cantid')	
			lc_costo = dw_datos.getitemdecimal(li_i,'dc_costo')
			lc_desc1 = dw_datos.getitemdecimal(li_i,'dc_desc1')
			lc_desc2 = dw_datos.getitemdecimal(li_i,'dc_desc2')	
			lc_desc3 = dw_datos.getitemdecimal(li_i,'dc_desc3')		
			lc_subtotal = dw_datos.getitemdecimal(li_i,'dc_costo') * lc_devolu
			lc_total_aux = dw_datos.getitemdecimal(li_i,'cc_subtdesc3') 
			
			ll_falta_orig = dw_datos.getitemdecimal(li_i,'dc_totdev',primary!,true)				
			ll_falta = dw_datos.getitemdecimal(li_i,'dc_totdev')
			if isnull(ll_falta) then ll_falta = 0
			dw_datos.setitem(li_i,"dc_dfecha",ldt_hoy)
			dw_datos.setitem(li_i,"dc_numnd",ls_numnd)
			ll_falta = ll_falta + lc_devolu
			dw_datos.setitem(li_i,"dc_totdev",ll_falta)		
	
			if ll_falta <= ll_cantid then
						
			INSERT INTO "IN_DETCO"  ( "EM_CODIGO",   "SU_CODIGO",   "BO_CODIGO",   "IT_CODIGO",   "EC_CODIGO",   "CO_NUMERO",   
				  "DC_SECUE",   "DC_CANTID",   "DC_COSTO",   "DC_DESC1",   "DC_DESC2",   "DC_DESC3",   "DC_SUBTOT",   "DC_TOTAL",   
				  "DC_UTILIDAD",   "DC_PREACT",   "DC_NUEPRE",   "DC_ACTUALIZA",   "DC_SALDO",   "ESTADO",   "DC_DEVOLU",   
				  "DC_DFECHA","DC_NUMND","DC_TOTDEV","CO_NUMPAD")  
			VALUES ( :str_appgeninfo.empresa, :str_appgeninfo.sucursal, :str_appgeninfo.seccion,:ls_itcodigo, '5',  :ll_numnd,   
				  :li_secue,  :ll_cantid, :lc_costo, :lc_desc1, :lc_desc2, :lc_desc3, :lc_subtotal, :lc_total_aux, 
				  0,   0,   0,   'N',   null,   null,   :lc_devolu,   
				  sysdate,:ls_num_compra,:ll_falta,:ll_numpad)  ;
	      if sqlca.sqlcode < 0 then
				messageBox('Error Interno','No se puede generar la N/D en compras ' + sqlca.sqlerrtext)
				rollback;
				return
	      end if

			is_codant = dw_datos.getitemstring(li_i,'codant')	
			lc_stock = dec(lc_devolu)	
			lch_kit = dw_datos.getitemstring(li_i,'it_kit')	
			
			If lch_kit = 'S' Then
				SELECT "IN_ITEM"."IT_COSTO", "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
				INTO :ld_costo_atomo,:ls_atomo, :ld_cantatomo
				FROM "IN_ITEM"  , "IN_RELITEM"
				WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
				("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
				("IN_RELITEM"."TR_CODIGO" = '1' ) and
				( "IN_RELITEM"."IT_CODIGO1" = :ls_itcodigo ) and
				( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
			End if
			if f_descarga_stock_rt_sucursal(ls_itcodigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = False Then
				rollback;
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+is_codant)
				return
			end if
			if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_itcodigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = false Then
				rollback;
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+is_codant)
				return
			End if		
			
			//Inicia el c$$HEX1$$e100$$ENDHEX$$lculo del costo promedio
			//Determina el costo de la transacci$$HEX1$$f300$$ENDHEX$$n en la que se origino la venta
			select NVL(mv_costtrans,0)
			into   :lc_costtrans
			from in_movim
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and tm_codigo = '1'
			and ve_numero = :ll_numpad //Nro de la nota de recepci$$HEX1$$f300$$ENDHEX$$n
			and it_codigo = :ls_itcodigo;
			
			if sqlca.sqlcode <> 0 then
			lc_costtrans = 0	
			end if
			
			//El costo de la transacci$$HEX1$$f300$$ENDHEX$$n en este caso es el costo promedio  
			lc_costprom =  f_costprom(ls_itcodigo,'E',lc_devolu,lc_costtrans)
			
			
			if wf_mov_inventario(ls_itcodigo,lc_stock,ldt_hoy,ll_num_compra,ll_numnd,lch_kit,ls_atomo,ld_cantatomo,ld_costo_atomo,lc_costo,ll_numpad,lc_costprom,lc_costtrans) = false Then
				rollback;
				dw_movim.reset()
				Messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario")
				Return
			End if		
		else
				rollback;
				messagebox("Error","No puede devolver mas de lo comprado...verifique")
				dw_datos.setitem(li_i,"dc_totdev",ll_falta_orig)
				return
		end if
     End if
next
//Inserta la nota de d$$HEX1$$e900$$ENDHEX$$bito en las tablas de cxp
If wf_nota_debito(lc_total,ll_num_compra,lc_subtot,lc_iva,ll_numnd,ls_rucsuc,ls_facpro,ls_proveedor,ls_preimp,ls_naut,ld_femision) < 0 Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al realizar la devoluci$$HEX1$$f300$$ENDHEX$$n de compra")
	rollback;
	return
End if

If wf_nota_debito_motos() <> 1 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se actualizo el detalle del item")
Rollback;
return
end if


rc =  dw_datos.update(True, False)
if rc = 1 then
	rc =  dw_movim.update(true,false)
	  if rc = 1 then		
		dw_datos.resetupdate()
		dw_movim.resetupdate()			
		commit;	
	  else
		rollback;
		messagebox('Error Interno','No se puede actualizar la nota de d$$HEX1$$e900$$ENDHEX$$bito al inventario')
		return
	  end if
else
	rollback;
	messagebox('Error Interno','No se puede actualizar la nota de d$$HEX1$$e900$$ENDHEX$$bito en compras')
	return
end if

dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ll_num_compra)

dw_report.SetTransObject(sqlca)
ll_nreg = dw_report.Retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,ll_numnd)
If ll_nreg = 0 Then 
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para imprimir")	
return
end if
dw_report.Print()
SetPointer(Arrow!)
end event

event ue_retrieve;long ll_numero,ll_nreg
String ls_numpad
string ls_razon,ls_pvcodigo

setpointer(hourglass!)
dw_cab.accepttext()
ll_numero = dw_cab.getitemnumber(dw_cab.getrow(),"numero")
ll_nreg = dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ll_numero) 
If ll_nreg = 0 Then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','N$$HEX1$$fa00$$ENDHEX$$mero de Factura no registrado')
     setpointer(arrow!)
     this.setfocus()
	return
End if


select p.pv_razons,p.pv_codigo,c.co_numpad
into :ls_razon,:ls_pvcodigo,:ls_numpad
from in_prove p, in_compra c
where p.em_codigo = c.em_codigo
and p.pv_codigo = c.pv_codigo
and c.ec_codigo = '3'
and c.em_codigo = :str_appgeninfo.empresa
and c.su_codigo = :str_appgeninfo.sucursal
and c.co_numero = :ll_numero;

If sqlca.sqlcode = 100 Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proveedor no encontrado")
	return
End if 
/*Recupera el detalle de los items EN el caso de MOTOS*/

dw_1.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_numpad) 

dw_cab.modify("t_cliente.text = ' "+ls_pvcodigo+'/'+ls_razon+"'")
dw_report.Reset()
setpointer(arrow!)
end event

event ue_insert;return 1

end event

event ue_delete;return 1
end event

event closequery;return
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_devolucion_compra_nveces
integer y = 284
integer width = 4562
integer height = 1132
integer taborder = 50
string dataobject = "d_devolucion_compra_nveces"
boolean maxbox = true
boolean hscrollbar = false
boolean livescroll = false
end type

event dw_datos::rbuttondown;return 1
end event

event dw_datos::itemchanged;call super::itemchanged;dec{2} lc_devolu = 0,lc_totdevol = 0,lc_candes


accepttext()
if dwo.name = "dc_devolu" Then
	If Real(gettext()) < 0 then
		is_mensaje = "La cantidad a devolver debe ser numero(+)"
		return 1
	end if
	lc_devolu = getitemnumber(row,"dc_devolu")
	lc_candes = getitemnumber(row,"dc_cantid")
	lc_totdevol = getitemnumber(row,"dc_totdev")
	if isnull(lc_totdevol) then lc_totdevol = 0
	lc_totdevol = lc_totdevol + lc_devolu
	If lc_totdevol > lc_candes Then
		is_mensaje = "No puede devolver mas de lo comprado...<verif$$HEX1$$ed00$$ENDHEX$$que>"
		return 1
	End if
	
End if
end event

event dw_datos::itemerror;call super::itemerror;long ll_devolu
setnull(ll_devolu)
messagebox("Error",is_mensaje)
setitem(row,"dc_devolu",ll_devolu)		
return 1

end event

event dw_datos::clicked;call super::clicked;/*Recupera el detalle del item */
If dwo.name = 'b_1' then
dw_1.visible = true	
dw_1.Setfilter("it_codigo = '"+dw_datos.object.it_codigo[row]+"'")
dw_1.Filter()
SetRow(row)
ScrolltoRow(row)
SetColumn("dc_devolu")
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_devolucion_compra_nveces
integer x = 3698
integer y = 88
integer width = 105
integer height = 96
integer taborder = 0
string dataobject = "d_redcolor_nd_preimpresa_devcomp"
end type

type dw_cab from datawindow within w_devolucion_compra_nveces
integer width = 2939
integer height = 144
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ext_devol_fact_comp"
boolean border = false
boolean livescroll = true
end type

type dw_movim from datawindow within w_devolucion_compra_nveces
boolean visible = false
integer x = 3470
integer y = 92
integer width = 91
integer height = 72
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_devolucion_compra_nveces
integer x = 494
integer y = 176
integer width = 466
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 13
borderstyle borderstyle = stylelowered!
end type

event losefocus;If Not Match(This.Text, "^[0-9]+$")  or  len(This.text) <> 13  Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El Nro de la Nota de Cr$$HEX1$$e900$$ENDHEX$$dito debe tener 13  d$$HEX1$$ed00$$ENDHEX$$gitos")
this.setfocus()
end if
end event

type st_1 from statictext within w_devolucion_compra_nveces
integer x = 64
integer y = 180
integer width = 430
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
string text = "N$$HEX2$$ba002000$$ENDHEX$$Nota de Cr$$HEX1$$e900$$ENDHEX$$dito:  "
boolean focusrectangle = false
end type

type st_2 from statictext within w_devolucion_compra_nveces
integer x = 1042
integer y = 184
integer width = 389
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
string text = "Autorizaci$$HEX1$$f300$$ENDHEX$$n SRI:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_devolucion_compra_nveces
integer x = 1934
integer y = 184
integer width = 238
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
string text = "Emitida el:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_devolucion_compra_nveces
integer x = 2158
integer y = 176
integer width = 343
integer height = 76
integer taborder = 40
boolean bringtotop = true
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
end type

type sle_2 from singlelineedit within w_devolucion_compra_nveces
integer x = 1445
integer y = 172
integer width = 466
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event losefocus;If Not Match(This.Text, "^[0-9]+$")  or  len(This.text) <> 10 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El Nro de Autorizaci$$HEX1$$f300$$ENDHEX$$n debe tener 10 d$$HEX1$$ed00$$ENDHEX$$gitos")
end if
end event

type dw_1 from datawindow within w_devolucion_compra_nveces
boolean visible = false
integer x = 18
integer y = 1492
integer width = 4073
integer height = 588
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_detalle_items"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;Long ll_row,i
String ls_cero[] = {'0'}

ll_row = dw_datos.getrow()

if dwo.name = 'b_1' then
dw_datos.Object.dc_devolu[ll_row] = this.object.total[1]
end if

if dwo.name = 'b_2' then
this.object.cc_opcion.primary[1,this.rowcount()] = ls_cero
dw_datos.Object.dc_devolu[ll_row] = 0
end if
end event

type st_4 from statictext within w_devolucion_compra_nveces
integer x = 32
integer y = 1428
integer width = 462
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "Detalle de Productos"
boolean focusrectangle = false
end type


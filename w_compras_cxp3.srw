HA$PBExportHeader$w_compras_cxp3.srw
$PBExportComments$Si.Movimientos de credito en CXP... (Facturas de servicio). Vale
forward
global type w_compras_cxp3 from w_sheet_1_dw_maint
end type
type dw_ubica from datawindow within w_compras_cxp3
end type
type em_1 from editmask within w_compras_cxp3
end type
type em_2 from editmask within w_compras_cxp3
end type
type st_2 from statictext within w_compras_cxp3
end type
type st_3 from statictext within w_compras_cxp3
end type
type dw_a from datawindow within w_compras_cxp3
end type
type dw_c from datawindow within w_compras_cxp3
end type
type dw_anexo from datawindow within w_compras_cxp3
end type
type dw_b from datawindow within w_compras_cxp3
end type
type dw_3 from datawindow within w_compras_cxp3
end type
type cb_1 from commandbutton within w_compras_cxp3
end type
type st_5 from statictext within w_compras_cxp3
end type
type st_6 from statictext within w_compras_cxp3
end type
type dw_asiento from uo_dw_basic within w_compras_cxp3
end type
type dw_cab from datawindow within w_compras_cxp3
end type
type cb_2 from commandbutton within w_compras_cxp3
end type
type dw_cc from uo_dw_comprobante within w_compras_cxp3
end type
type dw_2 from datawindow within w_compras_cxp3
end type
type cb_3 from commandbutton within w_compras_cxp3
end type
type cb_4 from commandbutton within w_compras_cxp3
end type
type st_8 from statictext within w_compras_cxp3
end type
type st_9 from statictext within w_compras_cxp3
end type
type st_4 from commandbutton within w_compras_cxp3
end type
type st_leyenda from statictext within w_compras_cxp3
end type
type st_10 from statictext within w_compras_cxp3
end type
type dw_op from datawindow within w_compras_cxp3
end type
type cb_5 from commandbutton within w_compras_cxp3
end type
type sle_1 from singlelineedit within w_compras_cxp3
end type
type shl_1 from statichyperlink within w_compras_cxp3
end type
type st_1 from statictext within w_compras_cxp3
end type
type dw_4 from datawindow within w_compras_cxp3
end type
type sle_2 from singlelineedit within w_compras_cxp3
end type
type st_11 from statictext within w_compras_cxp3
end type
type ln_1 from line within w_compras_cxp3
end type
type dw_crenocru from datawindow within w_compras_cxp3
end type
type cb_6 from commandbutton within w_compras_cxp3
end type
type dw_1 from datawindow within w_compras_cxp3
end type
end forward

global type w_compras_cxp3 from w_sheet_1_dw_maint
integer width = 6126
integer height = 2568
string title = "(*) Movimientos de Cr$$HEX1$$e900$$ENDHEX$$dito 26.01.2015"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 79741120
boolean ib_notautoretrieve = true
event ue_consultar pbm_custom28
event type integer ue_contabilizar ( )
dw_ubica dw_ubica
em_1 em_1
em_2 em_2
st_2 st_2
st_3 st_3
dw_a dw_a
dw_c dw_c
dw_anexo dw_anexo
dw_b dw_b
dw_3 dw_3
cb_1 cb_1
st_5 st_5
st_6 st_6
dw_asiento dw_asiento
dw_cab dw_cab
cb_2 cb_2
dw_cc dw_cc
dw_2 dw_2
cb_3 cb_3
cb_4 cb_4
st_8 st_8
st_9 st_9
st_4 st_4
st_leyenda st_leyenda
st_10 st_10
dw_op dw_op
cb_5 cb_5
sle_1 sle_1
shl_1 shl_1
st_1 st_1
dw_4 dw_4
sle_2 sle_2
st_11 st_11
ln_1 ln_1
dw_crenocru dw_crenocru
cb_6 cb_6
dw_1 dw_1
end type
global w_compras_cxp3 w_compras_cxp3

type variables
Datetime  id_hoy
Decimal  ic_iva
Long il_cpnumero
String is_ctaret,is_ctaiva,&
          is_obs,&
is_tvcodigo,is_tvtipo,is_empresa,is_sucursal,is_mpcodigo,is_pvcodigo,is_cofacpro,&
is_op

datawindowchild dwc_cuentas,dwc_tipo,idwc_reten,idwc_retiva
boolean ib_credito_grabado

end variables

forward prototypes
public function integer wf_anular_deuda ()
public function integer wf_preprint ()
public function integer wf_actualiza_saldo ()
public function integer wf_crea_pago (ref datawindow adw_fp)
public function integer wf_modifica_pago (ref datawindow adw_fp)
public function integer wf_determina_estado (ref datawindow adw_fp)
public function integer wf_cruza_pago (ref datawindow adw_fp, integer ai_status)
public function integer wf_elimina_pago (ref datawindow adw_fp)
public function integer wf_validacion ()
public function integer wf_aplica_cambios (ref datawindow adw_1, ref datawindow adw_2, ref datawindow adw_3)
public subroutine wf_calcula_retencion ()
public subroutine wf_calculo_retencion (ref datawindow adw_aux)
public function integer wf_postprint ()
end prototypes

event ue_consultar;dw_datos.postevent(DoubleClicked!)
dw_datos.enabled = true
end event

event type integer ue_contabilizar();/*Contabiliza el */
long ll_reg,ll_row,ll_find
int i
Dec{2} lc_neto,lc_iva,lc_valpag,lc_retfte,lc_retiva,lc_baseimp,lc_tarifa0,lc_baseice
String ls_cta,ls_codpct,ls_obs,ls_tipo = '3',&
          ls_codprv, ls_ctaprv,ls_ctaiva,ls_ctagto,ls_pvrazons
Long   v_cpnumero,v_cpnumdoc,ll_new    
Date   ld_ini,ld_fin
Datetime  ld_fecha


DataStore  lds_datos

dw_datos.AcceptText()
dw_cab.reset()
dw_cc.reset()
dw_cc.visible = true
st_3.text = ' - '

w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n...por favor espere...")
Setpointer(Hourglass!)

  	  
/*Asignar valores a las cuentas*/
ll_row        = dw_datos.getrow()
ls_codprv   = dw_datos.Object.pv_codigo[ll_row]
ld_fecha     = dw_datos.object.mp_fecemision[ll_row]

SELECT  G.PL_CODIGO
INTO     :ls_ctaprv
FROM    IN_PROVE  P, PR_GRUPCONT G
WHERE  P.GT_CODIGO = G.GT_CODIGO
AND       PV_CODIGO = :ls_codprv;

SELECT PL_CODIGO
INTO    :ls_ctagto
FROM   PR_GRUPCONT
WHERE  GT_CODIGO = 'PRV_GTO';

SELECT PL_CODIGO
INTO    :ls_ctaiva
FROM   PR_GRUPCONT
WHERE GT_CODIGO = 'PRV_IVA';


if ll_row = 0 then return -1

SELECT nvl(PV_RAZONS,pv_nombre||' '||pv_apelli)
into :ls_pvrazons
FROM IN_PROVE
WHERE PV_CODIGO = :ls_codprv;


is_obs = 'F:'+dw_datos.Object.mp_docnrosec[ll_row]+' / '+mid(ls_pvrazons,1,20)+'/'+ mid(dw_datos.Object.mp_observ[ll_row],1,15)
//is_obs = dw_datos.Object.mp_observ[ll_row]

/*Retenciones de fte*/
for i = 1 to dw_3.rowcount( )

	ls_codpct       = dw_3.Object.cp_pago_pm_codpct[i]
	
	SELECT PL_CODIGO
	into  :ls_cta
	FROM CC_RETEN
	WHERE RF_TIPO = :ls_codpct;

	 ll_new = dw_cc.insertrow(0)	 
	dw_cc.Object.em_codigo[ll_new] = str_appgeninfo.empresa
	dw_cc.Object.su_codigo[ll_new] = str_appgeninfo.sucursal	
	dw_cc.Object.ti_codigo[ll_new] = ls_tipo
	dw_cc.Object.cp_numero[ll_new] = 9999999
	dw_cc.Object.pl_codigo[ll_new] = ls_cta
	dw_cc.Object.cs_codigo[ll_new] = '1'
	dw_cc.Object.dt_secue[ll_new] =  string(i)
	dw_cc.Object.dt_signo[ll_new] = 'C'
	dw_cc.Object.dt_valor[ll_new] = dw_3.Object.cp_pago_pm_valor[i]
	dw_cc.Object.dt_detalle[ll_new] = is_obs
	lc_retfte      =  lc_retfte +  dw_3.Object.cp_pago_pm_valor[i]
	dw_cc.Object.fecha[ll_new] = ld_fecha
next




/*Retenciones de iva*/
for i = 1 to dw_b.rowcount()
	ls_codpct       = dw_b.Object.cp_pago_pm_codpct[i]

	SELECT PL_CODIGO
	into  :ls_cta
	FROM CC_RETEN
	WHERE RF_TIPO = :ls_codpct;
	
      ll_new = dw_cc.insertrow(0)	 
	dw_cc.Object.em_codigo[ll_new] = str_appgeninfo.empresa
	dw_cc.Object.su_codigo[ll_new] = str_appgeninfo.sucursal	
	dw_cc.Object.ti_codigo[ll_new] = ls_tipo
	dw_cc.Object.cp_numero[ll_new] = 9999999
	dw_cc.Object.pl_codigo[ll_new] = ls_cta
	dw_cc.Object.cs_codigo[ll_new] = '1'
	dw_cc.Object.dt_secue[ll_new] =  string(i)
	dw_cc.Object.dt_signo[ll_new] = 'C'
	dw_cc.Object.dt_valor[ll_new] = dw_b.Object.cp_pago_pm_valor[i]
	dw_cc.Object.dt_detalle[ll_new] = is_obs
	lc_retiva       =  lc_retiva  +  dw_b.Object.cp_pago_pm_valor[i]
	dw_cc.Object.fecha[ll_new] = ld_fecha
next

lc_tarifa0 =  dw_datos.Object.mp_bseimptrf0[ll_row]
lc_baseimp = dw_datos.Object.mp_baseimp[ll_row]
lc_baseice  = dw_datos.Object.mp_bseimpice[ll_row] 

if isnull(lc_tarifa0) then lc_tarifa0 =0
if isnull(lc_baseimp) then lc_baseimp =0
if isnull(lc_baseice) then lc_baseice =0

// Se desglosa en las cuentas de gasto

lc_neto     =  lc_baseimp + lc_tarifa0 + lc_baseice
If lc_neto <> 0 then
     ll_new = dw_cc.insertrow(0)	 
	dw_cc.Object.em_codigo[ll_new] = str_appgeninfo.empresa
	dw_cc.Object.su_codigo[ll_new] = str_appgeninfo.sucursal	
	dw_cc.Object.ti_codigo[ll_new] = ls_tipo
	dw_cc.Object.cp_numero[ll_new] = 9999999
	dw_cc.Object.pl_codigo[ll_new] = ls_ctagto
	dw_cc.Object.cs_codigo[ll_new] = '1'
	dw_cc.Object.dt_secue[ll_new] =  '1'
	dw_cc.Object.dt_signo[ll_new] = 'D'
	dw_cc.Object.dt_valor[ll_new] = lc_neto
	dw_cc.Object.dt_detalle[ll_new] = is_obs
	dw_cc.Object.fecha[ll_new] = ld_fecha
end if


/*Adicionar las cuentas de gasto si es que existe*/
/*Para SATEXPRO*/
//for i = 1 to dw_3.rowcount( )
//	ls_cta = dw_3.object.pl_codigo[i]
//	if isnull(ls_cta) or ls_cta= "" then  continue
//	ll_new = dw_cc.insertrow(0)	 
//	dw_cc.Object.em_codigo[ll_new]  = str_appgeninfo.empresa
//	dw_cc.Object.su_codigo[ll_new]   = str_appgeninfo.sucursal	
//	dw_cc.Object.ti_codigo[ll_new]     = ls_tipo
//	dw_cc.Object.cp_numero[ll_new]  = 9999999
//	dw_cc.Object.pl_codigo[ll_new]     = ls_cta
//	dw_cc.Object.cs_codigo[ll_new]    = '1'
//	dw_cc.Object.dt_secue[ll_new]     =  string(i)
//	dw_cc.Object.dt_signo[ll_new]      = 'D'
//	dw_cc.Object.dt_valor[ll_new]      = dw_3.Object.cp_pago_pm_bseimp[i]
//	dw_cc.Object.dt_detalle[ll_new]    = is_obs
//	dw_cc.Object.fecha[ll_new] = ld_fecha
//next
///*Hasta aqui Satexpro*/


lc_iva        = dw_datos.Object.mp_valret[ll_row] 
If lc_iva <> 0 then
     ll_new = dw_cc.insertrow(0)	 
	dw_cc.Object.em_codigo[ll_new] = str_appgeninfo.empresa
	dw_cc.Object.su_codigo[ll_new] = str_appgeninfo.sucursal	
	dw_cc.Object.ti_codigo[ll_new] = ls_tipo
	dw_cc.Object.cp_numero[ll_new] = 9999999
	dw_cc.Object.pl_codigo[ll_new] = ls_ctaiva
	dw_cc.Object.cs_codigo[ll_new] = '1'
	dw_cc.Object.dt_secue[ll_new]  =  '2'
	dw_cc.Object.dt_signo[ll_new]   = 'D'
	dw_cc.Object.dt_valor[ll_new]    = lc_iva
	dw_cc.Object.dt_detalle[ll_new] = is_obs
	dw_cc.Object.fecha[ll_new] = ld_fecha
end if



lc_valpag  = dw_datos.Object.mp_valor[ll_row] - (lc_retfte + lc_retiva) 
If lc_valpag <> 0 then
     ll_new = dw_cc.insertrow(0)	 
	dw_cc.Object.em_codigo[ll_new] = str_appgeninfo.empresa
	dw_cc.Object.su_codigo[ll_new] = str_appgeninfo.sucursal	
	dw_cc.Object.ti_codigo[ll_new] = ls_tipo
	dw_cc.Object.cp_numero[ll_new] = 9999999
	dw_cc.Object.pl_codigo[ll_new]    =  ls_ctaprv
	dw_cc.Object.cs_codigo[ll_new]   = '1'
	dw_cc.Object.dt_secue[ll_new] =  '5'
	dw_cc.Object.dt_signo[ll_new] = 'C'
	dw_cc.Object.dt_valor[ll_new] = lc_valpag
	dw_cc.Object.dt_detalle[ll_new] = is_obs
	dw_cc.Object.fecha[ll_new] = ld_fecha
end if
dw_cc.SetSort("dt_signo  desc , pl_codigo desc ")		 
dw_cc.Sort()



Setpointer(Arrow!)     
w_marco.SetMicrohelp("Listo...")
RETURN 1


end event

public function integer wf_anular_deuda ();String  ls_mpcoddeb,ls_mpcodigo, ls_cofacpro
Long  ll_row


ll_row  = dw_datos.getrow()
if ll_row = 0 then return 0

ls_cofacpro = dw_datos.GetitemString(ll_row,"co_facpro",Primary!,true )
ls_mpcodigo = dw_datos.GetitemString(ll_row,"mp_codigo",Primary!,true )

declare cruce cursor for 
select mp_coddeb
from cp_cruce
where tv_coddeb = '2'
and tv_tipodeb = 'D'
and tv_codigo = '10'
and tv_tipo = 'C'
and em_codigo = :str_appgeninfo.empresa 
and su_codigo  = :str_appgeninfo.sucursal 
and mp_codigo = :ls_mpcodigo ;

open cruce;
fetch cruce into :ls_mpcoddeb;
do while sqlca.sqlcode = 0 

		/*Delete el cruce*/
		delete
		from CP_CRUCE
		where tv_coddeb = '2' and
		tv_tipodeb = 'D' and
		mp_coddeb = :ls_mpcoddeb and
		tv_codigo = '10' and
		tv_tipo = 'C' and
		em_codigo  = :str_appgeninfo.empresa and
		su_codigo  = :str_appgeninfo.sucursal and
		mp_codigo = :ls_mpcodigo ;
		
		if sqlca.sqlcode < 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular el cruce"+sqlca.sqlerrtext)
		rollback;
		return -1
		end if

		/*Borrar las Notas de debito*/

			
		/*Delete el pago*/
		delete 
		from cp_pago
		where tv_codigo = '2'
		and tv_tipo = 'D'
		and em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
		and mp_codigo = :ls_mpcoddeb;
		if sqlca.sqlcode < 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular el pago"+sqlca.sqlerrtext)
		rollback;
		return -1
		end if
		
fetch cruce into:ls_mpcoddeb;		
loop 
close cruce;

/*Delete el mov de debito de cp_movim*/
delete 
from cp_movim
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and tv_codigo = '2'
and tv_tipo = 'D'
and co_facpro = :ls_cofacpro;

if sqlca.sqlcode < 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular la deuda"+sqlca.sqlerrtext)
rollback;
return -1
end if
return 1
end function

public function integer wf_preprint ();long ll_row
String ls_mpcodigo
String ls_tipo = '3',ls_tipiva /*Tipo de diario contable*/



string ls_empresa, ls_sucursal, ls_numero[]

ll_row      = dw_datos.getRow()

if ll_row = 0 then return -1
ls_mpcodigo  = dw_datos.GetItemString(ll_row,"mp_codigo")
il_cpnumero =  Long(dw_datos.GetItemString(ll_row,"cp_numero"))

ls_tipiva = dw_datos.GetitemString(ll_row,"mp_tipoiva")
if ls_tipiva = '1' then 
	ls_tipo = '3'
else
	ls_tipo = '18'
end if
ls_numero[1] = ls_mpcodigo




open(w_res_opc_prn)
is_op = message.StringParm
choose case is_op
	case 'C'
		dw_report.dataobject="d_prn_cxp"
		dw_report.SetTransObject(sqlca)
		dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mpcodigo,ls_tipo,il_cpnumero)

	case 'R'
     // 	dw_report.dataobject = "d_prn_retenciones_remel" 
		dw_report.dataobject="d_prn_retenciones_prismacolor"	
     //	dw_report.dataobject="d_prn_retenciones_inselair"	
	//	dw_report.dataobject="d_prn_retenciones_pintaexpress"	 // pintaexpress
		
		dw_report.SetTransObject(sqlca)
          dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_numero)
         
			
			
end choose

return 1
end function

public function integer wf_actualiza_saldo ();/*Actualiza el saldo de la factura dependiendo de lo cruzado */
long ll_filact
decimal lc_totalcruce,lc_retiva,lc_retfte,lc_base0,lc_basegrav,lc_basenograv,lc_valor,lc_iva,lc_reten,lc_saldo,lc_otrospagos
string  ls_tvcodigo,ls_tvtipo,ls_nromov,ls_pvcodigo

dw_datos.AcceptText()
dw_c.AcceptText()

ll_filact = dw_datos.getrow()

If ll_filact <= 0 then return -1


ls_tvcodigo = dw_datos.object.tv_codigo[ll_filact]
ls_tvtipo     = dw_datos.object.tv_tipo[ll_filact]
ls_nromov  = dw_datos.object.mp_codigo[ll_filact]
ls_pvcodigo = dw_datos.object.pv_codigo[ll_filact]

lc_base0         = dw_3.object.cc_base0[1]
lc_basegrav     = dw_3.object.cc_basegrav[1]
lc_basenograv = dw_3.object.cc_basenograv[1]
ic_iva =             dw_3.object.cp_pago_pm_codpctiva[1]

if ic_iva = 0.00 then dw_datos.object.mp_codpctiva[ll_filact]  = '0'
if ic_iva = 0.10 then dw_datos.object.mp_codpctiva[ll_filact]  = '1'
if ic_iva = 0.12 then dw_datos.object.mp_codpctiva[ll_filact]  = '2'
if ic_iva = 0.14 then dw_datos.object.mp_codpctiva[ll_filact]  = '3'

lc_iva =  lc_basegrav*ic_iva

dw_datos.object.mp_bseimptrf0[ll_filact]  = lc_base0
dw_datos.object.mp_baseimp[ll_filact]     = lc_basegrav
dw_datos.object.mp_bseimpice[ll_filact]   = lc_basenograv
dw_datos.object.mp_valret[ll_filact]         = lc_basegrav*ic_iva
lc_valor   = lc_base0 + lc_basegrav + lc_basenograv + (lc_basegrav*ic_iva)
dw_datos.object.mp_valor[ll_filact]    = lc_valor     





/*Tomar el total del cruce y actualizar el saldo*/
If dw_c.rowcount() > 0 then
lc_totalcruce =  dw_c.object.cc_totalcruce[1]
else
lc_totalcruce = dw_datos.Object.mp_valor[ll_filact] 
end if



/*Actualiza retenciones en el cr$$HEX1$$e900$$ENDHEX$$dito*/
if dw_3.rowcount() > 0 then
lc_retfte =  dw_3.Object.cc_totalpago[1]
else
lc_retfte = 0
end if
dw_datos.Object.retfte[ll_filact] = lc_retfte


if dw_b.rowcount() > 0 then
        //iterar para obtener el valor correspondiente a cada tipo de retencion	
	    
	
	
		lc_retiva = dw_b.Object.cc_totalpago[1]
		else
		lc_retiva = 0
end if
dw_datos.Object.retiva[ll_filact] = lc_retiva


/*Solo para pintar en el datawindow del credito*/
lc_reten = lc_retfte + lc_retiva
lc_saldo = lc_valor - lc_totalcruce
dw_datos.object.mp_saldo[ll_filact]    = lc_saldo  


//Refresca detalle de pagos
dw_op.Retrieve(ls_nromov,ls_pvcodigo)
if dw_op.rowcount() > 0 then
lc_otrospagos = dw_op.object.cc_otrospagos[1]
end if
dw_datos.object.st_op.text = string(lc_otrospagos,'#,##0.00')


dw_datos.SetItemStatus(ll_filact, 0, Primary!, NotModified!)


UPDATE CP_MOVIM
SET  MP_BSEIMPTRF0 = :lc_base0,
	   MP_BASEIMP       = :lc_basegrav,
	   MP_BSEIMPICE    = :lc_basenograv,
       MP_RETIVA         = :lc_retiva,
       MP_RETEN          = :lc_retfte,
	   MP_VALOR         = :lc_valor ,
       MP_VALRET        = :lc_iva,
       MP_SALDO          =  :lc_saldo
WHERE TV_CODIGO = :ls_tvcodigo
AND TV_TIPO = :ls_tvtipo
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND MP_CODIGO = :ls_nromov;

IF SQLCA.SQLCODE <> 0 THEN
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el cr$$HEX1$$e900$$ENDHEX$$dito..."+sqlca.sqlerrtext)
		Rollback;
		Return -1
End if




return 1

end function

public function integer wf_crea_pago (ref datawindow adw_fp);String ls_nromov
Integer i
long ll_new, ll_row


/*Determinar secuencial del mov de d$$HEX1$$e900$$ENDHEX$$bito*/
ll_row = dw_datos.getrow()
ls_nromov = string(f_secuencial(str_appgeninfo.empresa,'DEB_CXP'))	
ll_new =  dw_a.insertrow(0)


/*Asignar datos de la clave para la cabecera del pago*/
dw_a.Object.cp_movim_mp_codigo[ll_new]  = ls_nromov
dw_a.Object.cp_movim_em_codigo[ll_new]  = str_appgeninfo.empresa
dw_a.Object.cp_movim_su_codigo[ll_new]   = is_sucursal
dw_a.Object.cp_movim_tv_codigo[ll_new]    = '2'
dw_a.Object.cp_movim_tv_tipo[ll_new]        = 'D'
dw_a.Object.cp_movim_pv_codigo[ll_new]   = is_pvcodigo
dw_a.Object.mp_fecreg[ll_new]   = id_hoy /*fecha en la que se realiza la modificaci$$HEX1$$f300$$ENDHEX$$n*/
dw_a.Object.cp_movim_mp_fecha[ll_new]   = dw_datos.object.mp_fecemision[ll_row] 
dw_a.Object.cp_movim_mp_valor[ll_new]    =  adw_fp.Object.cc_totalpago[1]

ic_iva = dw_3.Object.cp_pago_pm_codpctiva[1]
dw_a.Object.cp_movim_mp_valret[ll_new]   = (adw_fp.Object.cc_totalpago[1]/(1+ ic_iva))*ic_iva

//El saldo del debito debe quedar en 0 porque se debe cruzar totalmente los valores de la retenci$$HEX1$$f300$$ENDHEX$$n
dw_a.Object.cp_movim_mp_saldo[ll_new]    = adw_fp.Object.cc_totalpago[1] 


/*Completar datos de la clave para el detalle del pago*/
for i = 1 to adw_fp.rowcount()
	adw_fp.Object.cp_pago_mp_codigo[i] = ls_nromov
	adw_fp.Object.cp_pago_em_codigo[i] = str_appgeninfo.empresa
	adw_fp.Object.cp_pago_su_codigo[i]  = str_appgeninfo.sucursal
	adw_fp.Object.cp_pago_tv_codigo[i]  = '2'
	adw_fp.Object.cp_pago_tv_tipo[i]      = 'D'
	adw_fp.Object.cp_pago_pm_secuencia[i] = i
	adw_fp.Object.cp_pago_pm_fecha[i] = dw_datos.object.mp_fecemision[ll_row] 
	adw_fp.Object.cp_pago_pm_fecpa[i] = dw_datos.object.mp_fecemision[ll_row] 
next


/*Cruce del debito con el cr$$HEX1$$e900$$ENDHEX$$dito*/
ll_new =  dw_c.insertrow(0)

/*datos del cr$$HEX1$$e900$$ENDHEX$$dito*/ 
dw_c.Object.cp_cruce_mp_codigo[ll_new]  = dw_datos.Object.mp_codigo[ll_row]
dw_c.Object.cp_cruce_tv_codigo[ll_new]    = dw_datos.Object.tv_codigo[ll_row]
dw_c.Object.cp_cruce_tv_tipo[ll_new]        = dw_datos.Object.tv_tipo[ll_row]
dw_c.Object.cp_cruce_em_codigo[ll_new]  = dw_datos.Object.em_codigo[ll_row]
dw_c.Object.cp_cruce_su_codigo[ll_new]   = dw_datos.Object.su_codigo[ll_row]

/*datos del debito*/
dw_c.Object.cp_cruce_mp_coddeb[ll_new] = adw_fp.Object.cp_pago_mp_codigo[1]
dw_c.Object.cp_cruce_tv_coddeb[ll_new]   = adw_fp.Object.cp_pago_tv_codigo[1]
dw_c.Object.cp_cruce_tv_tipodeb[ll_new]   = adw_fp.Object.cp_pago_tv_tipo[1]
dw_c.Object.cp_cruce_cx_valcre[ll_new]     = adw_fp.Object.cc_totalpago[1] 
dw_c.Object.cp_cruce_cx_valdeb[ll_new]    = adw_fp.Object.cc_totalpago[1] 
dw_c.Object.cp_cruce_cx_fecha[ll_new]     = dw_datos.object.mp_fecemision[ll_row]
    
return 1
end function

public function integer wf_modifica_pago (ref datawindow adw_fp);String ls_nrodeb,ls_nrocre
Integer i
long ll_find, ll_row,ll_filamod
Datetime ldt_fecha,ldt_fecpa

/*Determinar secuencial del mov de d$$HEX1$$e900$$ENDHEX$$bito*/
ll_row = dw_datos.getrow()
ls_nrocre  = dw_datos.Object.mp_codigo[ll_row]

/*En el caso de modificacion tomar el nro de debito de la fila 1*/
ls_nrodeb = adw_fp.Object.cp_pago_mp_codigo[1]
ldt_fecha = adw_fp.Object.cp_pago_pm_fecha[1]
ldt_fecpa = adw_fp.Object.cp_pago_pm_fecpa[1]

/*Buscar en la cabecera del pago el movimiento*/
ll_find = dw_a.find("cp_movim_mp_codigo = '"+ls_nrodeb+"'",1,dw_a.rowcount())

if ll_find <= 0 then return -1
/* Si encontro entonces modifica el total del pago*/

/*1.-
Modificar la cabecera del pago
Los datos de la clave no deben ser modificados*/







dw_a.Object.cp_movim_mp_valor[ll_find]    =  adw_fp.Object.cc_totalpago[1] 
dw_a.Object.cp_movim_mp_valret[ll_find]   = (adw_fp.Object.cc_totalpago[1]/(1+ ic_iva))*ic_iva
dw_a.Object.cp_movim_mp_saldo[ll_find]    = adw_fp.Object.cc_totalpago[1] 


/*2.-
   En caso de modificaci$$HEX1$$f300$$ENDHEX$$n la misma es sobre los campos visibles para el usuario
   Por lo tanto los valores de la clave permanecen inalterables en el detalle del pago*/
for i = 1 to adw_fp.rowcount()
	adw_fp.Object.cp_pago_mp_codigo[i] = ls_nrodeb
	adw_fp.Object.cp_pago_em_codigo[i] = str_appgeninfo.empresa
	adw_fp.Object.cp_pago_su_codigo[i]  = is_sucursal
	adw_fp.Object.cp_pago_tv_codigo[i]   = '2'
	adw_fp.Object.cp_pago_tv_tipo[i]        = 'D'
	adw_fp.Object.cp_pago_pm_secuencia[i] = i
	adw_fp.Object.cp_pago_pm_fecha[i] = ldt_fecha /*fecha , en el caso de modificaci$$HEX1$$f300$$ENDHEX$$n la fecha debe ser la de la 1ra vez que se realizo la retenci$$HEX1$$f300$$ENDHEX$$n*/
	adw_fp.Object.cp_pago_pm_fecpa[i] = ldt_fecpa /*fecha , en el caso de modificaci$$HEX1$$f300$$ENDHEX$$n la fecha debe ser la de la 1ra vez que se realizo la retenci$$HEX1$$f300$$ENDHEX$$n*/
next


/*3.-
   Modificar el cruce */
   ll_find = dw_c.find("cp_cruce_mp_codigo = '"+ls_nrocre+"' and cp_cruce_mp_coddeb = '"+ls_nrodeb+"'",1,dw_c.rowcount())
   if ll_find <= 0 then return -1

/*Encontro*/ 
dw_c.Object.cp_cruce_cx_valcre[ll_find]     = adw_fp.Object.cc_totalpago[1] 
dw_c.Object.cp_cruce_cx_valdeb[ll_find]    = adw_fp.Object.cc_totalpago[1] 
    
return 1
end function

public function integer wf_determina_estado (ref datawindow adw_fp);//Integer li_nreg,i
//Long ll_mpcodigo
//
//li_nreg = adw_fp.rowcount()
//
//
//If li_nreg <= 0 then return -1
//
//for i = 1 to li_nreg
//	ll_mpcodigo = adw_fp.Object.mp_codigo[i]
//	if not isnull(ll_mpcodigo) then
//	ib_viejo = true	
//	exit
//    else 
//	ib_viejo = false	
//	end if
//next
return 1


end function

public function integer wf_cruza_pago (ref datawindow adw_fp, integer ai_status);String ls_nrocre,ls_nromov
Long ll_row,ll_fila,ll_new
Integer i


ll_row = dw_datos.getrow()
/*Solo cruzar cuando hay un cr$$HEX1$$e900$$ENDHEX$$dito para cruzar*/
If ll_row <= 0 then return -1

/*Tomar datos del cr$$HEX1$$e900$$ENDHEX$$dito*/
ls_nrocre    = dw_datos.Object.mp_codigo[ll_row]
is_pvcodigo = dw_datos.Object.pv_codigo[ll_row]

/*1.- Determinar si el pago es nuevo, modificado o est$$HEX2$$e1002000$$ENDHEX$$en el buffer de borrado*/
choose case ai_status
	case 0 /*pago nuevo*/
     wf_crea_pago(adw_fp)
    case 1 /*Ya hay realizado al menos un pago*/
	wf_modifica_pago(adw_fp)	
    case 2
	wf_elimina_pago(adw_fp)	
end choose
    
return 1
     
		
		
	 
end function

public function integer wf_elimina_pago (ref datawindow adw_fp);String ls_nrodeb,ls_nrocre
long ll_find, ll_row


/*Determinar secuencial del mov de d$$HEX1$$e900$$ENDHEX$$bito*/
ll_row = dw_datos.getrow()
ls_nrocre  = dw_datos.Object.mp_codigo[ll_row]

/*En el caso de modificacion tomar el nro de debito de la fila 1 del buffer de borrado*/
ls_nrodeb = adw_fp.Object.cp_pago_mp_codigo.delete[1]

/*Modificar el cruce */
ll_find = dw_c.find("cp_cruce_mp_codigo = '"+ls_nrocre+"' and cp_cruce_mp_coddeb = '"+ls_nrodeb+"'",1,dw_c.rowcount())
if ll_find <= 0 then return -1
dw_c.deleterow(ll_find)

/*Buscar en la cabecera del pago el movimiento*/
ll_find = dw_a.find("cp_movim_mp_codigo = '"+ls_nrodeb+"'",1,dw_a.rowcount())
if ll_find <= 0 then return -1
dw_a.deleterow(ll_find)
    
return 1
end function

public function integer wf_validacion ();/*Funci$$HEX1$$f300$$ENDHEX$$n que valida la informaci$$HEX1$$f300$$ENDHEX$$n para consolidar los datos entre los d$$HEX1$$e900$$ENDHEX$$bitos y los cr$$HEX1$$e900$$ENDHEX$$ditos*/
Long ll_row
dwitemstatus l_status 
decimal{2} lc_iva,lc_bseimp
dw_datos.AcceptText()
dw_b.AcceptText()
dw_3.AcceptText()


ll_row = dw_datos.getrow()
If ll_row = 0 then return -1
l_status =    dw_datos.getitemstatus(ll_row,0,Primary!)

If dw_datos.object.mp_saldo[ll_row]	 =  0 and (l_status = datamodified! or l_status = notmodified!)  then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El cr$$HEX1$$e900$$ENDHEX$$dito ya ha sido cancelado; los cambios no ser$$HEX1$$e100$$ENDHEX$$n aplicados....<por favor confirme>") 
rollback;
return -1
end if

/*Validar el monto de iva contra suma de bases para la retenci$$HEX1$$f300$$ENDHEX$$n de iva*/
If dw_b.rowcount() > 0 then 
	lc_iva = 	dw_datos.object.cc_mpvalret[ll_row]
	lc_bseimp =  dw_b.Object.cc_bseimp_retiva[1]
	If  lc_iva <> lc_bseimp then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El Monto de IVA es diferente de la base imponible para la retenci$$HEX1$$f300$$ENDHEX$$n....<Por favor verifique!!!>") 
	rollback;
	return -1
	end if
end if

/*Validar la suma de bases (tarifa 0 +tarifa 12)  contra suma de bases para la retenci$$HEX1$$f300$$ENDHEX$$n de la fuente*/
If dw_3.rowcount() > 0 then
	choose case  dw_3.Object.cp_pago_pm_codpct[1] /*Caso especial para facturas de seguros*/
//		case '322'
//		If dw_3.Object.cp_pago_pm_bseimp[1] > dw_datos.Object.mp_baseimp[ll_row] then
//		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La base imponible para el c$$HEX1$$f300$$ENDHEX$$digo de retenci$$HEX1$$f300$$ENDHEX$$n no es v$$HEX1$$e100$$ENDHEX$$lido.....<Por favor verifique!!!>") 
//		rollback;
//		return -1
//		end if			
		case '331'			
			If dw_3.Object.cp_pago_pm_bseimp[1] > ( dw_datos.Object.mp_bseimptrf0[ll_row] +  dw_datos.object.mp_baseimp[ll_row]) then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La base imponible para el c$$HEX1$$f300$$ENDHEX$$digo de retenci$$HEX1$$f300$$ENDHEX$$n no es v$$HEX1$$e100$$ENDHEX$$lido.....<Por favor verifique!!!>") 
			rollback;
			return -1
			end if
		case else
		If (dw_datos.object.mp_bseimptrf0[ll_row] + dw_datos.object.mp_baseimp[ll_row] + dw_datos.object.mp_bseimpice[ll_row])	<>  dw_3.Object.cc_bseimp_retfte[1] then 
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La base imponible para la retenci$$HEX1$$f300$$ENDHEX$$n no corresponde a la factura.....<Por favor verifique!!!>") 
		rollback;
		return -1
		end if
		end choose
end if

return 1

end function

public function integer wf_aplica_cambios (ref datawindow adw_1, ref datawindow adw_2, ref datawindow adw_3);Long rc

		 rc = adw_1.update(true,false)
		 if rc = 1 then
				 rc =   adw_2.update(true,false)
				 if rc = 1 then
						rc = adw_3.update(true,false)
						if rc = 1 then
							rc = wf_actualiza_saldo()	
							if rc = 1 then
								adw_1.resetupdate()
								adw_2.resetupdate()
								adw_3.resetupdate()
								commit;	
								else
								Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n... Actualizaci$$HEX1$$f300$$ENDHEX$$n de Saldos",sqlca.sqlerrtext)
								rollback;
								return -1
							end if	
						else
						Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n3",sqlca.sqlerrtext)	
						rollback;
						return -1
					    end if
				else
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n2",sqlca.sqlerrtext)	
				rollback;
				return -1
				end if	
		else
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n1",sqlca.sqlerrtext)
		rollback;
		return -1
		end if	

return 1
end function

public subroutine wf_calcula_retencion ();
end subroutine

public subroutine wf_calculo_retencion (ref datawindow adw_aux);long ll_row

adw_aux.AcceptText()
ll_row = adw_aux.getrow()
if ll_row = 0 then return
adw_aux.object.cp_pago_pm_bseimp[ll_row] = adw_aux.object.cp_pago_pm_base0[ll_row] + adw_aux.object.cp_pago_pm_basegrav[ll_row] + adw_aux.object.cp_pago_pm_basenograv[ll_row]
adw_aux.object.cp_pago_pm_valor[ll_row]    = adw_aux.Object.cp_pago_pm_porctje[ll_row]*adw_aux.object.cp_pago_pm_bseimp[ll_row] 

end subroutine

public function integer wf_postprint ();//Registra la retencion que se ha impreso.


// 1 = FAC
// 2 = NC
// 3 = ND
// 4 = RET

Date ld_fecemi
String ls_pvcodigo,ls_preimp,ls_cofacpro
Long  ll_row

if is_op = 'R' then
	ll_row = dw_datos.getrow()
	ls_preimp     = dw_datos.Object.mp_estabret[ll_row]+dw_datos.Object.mp_ptoemiret[ll_row]+dw_datos.Object.mp_secret[ll_row]
	ld_fecemi     = date(dw_datos.Object.mp_fecemiret[ll_row])
	ls_pvcodigo  = dw_datos.Object.pv_codigo[ll_row]
	ls_cofacpro  = dw_datos.Object.co_facpro[ll_row]
	
	INSERT INTO PR_DOCEMP (EM_CODIGO,SU_CODIGO,BO_CODIGO,DE_CODIGO,DE_PREIMP,DE_FECEMI,DE_DOCPAD,PV_CODIGO)
	VALUES(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,'4',:ls_preimp,:ld_fecemi,:ls_cofacpro,:ls_pvcodigo);
	
	IF SQLCA.SQLCODE <> 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas  al  insertar el documento...."+sqlca.sqlerrtext)
	Rollback;
	Return -1
	END IF
	COMMIT;
end if
RETURN 1

end function

on w_compras_cxp3.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_3=create st_3
this.dw_a=create dw_a
this.dw_c=create dw_c
this.dw_anexo=create dw_anexo
this.dw_b=create dw_b
this.dw_3=create dw_3
this.cb_1=create cb_1
this.st_5=create st_5
this.st_6=create st_6
this.dw_asiento=create dw_asiento
this.dw_cab=create dw_cab
this.cb_2=create cb_2
this.dw_cc=create dw_cc
this.dw_2=create dw_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.st_8=create st_8
this.st_9=create st_9
this.st_4=create st_4
this.st_leyenda=create st_leyenda
this.st_10=create st_10
this.dw_op=create dw_op
this.cb_5=create cb_5
this.sle_1=create sle_1
this.shl_1=create shl_1
this.st_1=create st_1
this.dw_4=create dw_4
this.sle_2=create sle_2
this.st_11=create st_11
this.ln_1=create ln_1
this.dw_crenocru=create dw_crenocru
this.cb_6=create cb_6
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.dw_a
this.Control[iCurrent+7]=this.dw_c
this.Control[iCurrent+8]=this.dw_anexo
this.Control[iCurrent+9]=this.dw_b
this.Control[iCurrent+10]=this.dw_3
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.dw_asiento
this.Control[iCurrent+15]=this.dw_cab
this.Control[iCurrent+16]=this.cb_2
this.Control[iCurrent+17]=this.dw_cc
this.Control[iCurrent+18]=this.dw_2
this.Control[iCurrent+19]=this.cb_3
this.Control[iCurrent+20]=this.cb_4
this.Control[iCurrent+21]=this.st_8
this.Control[iCurrent+22]=this.st_9
this.Control[iCurrent+23]=this.st_4
this.Control[iCurrent+24]=this.st_leyenda
this.Control[iCurrent+25]=this.st_10
this.Control[iCurrent+26]=this.dw_op
this.Control[iCurrent+27]=this.cb_5
this.Control[iCurrent+28]=this.sle_1
this.Control[iCurrent+29]=this.shl_1
this.Control[iCurrent+30]=this.st_1
this.Control[iCurrent+31]=this.dw_4
this.Control[iCurrent+32]=this.sle_2
this.Control[iCurrent+33]=this.st_11
this.Control[iCurrent+34]=this.ln_1
this.Control[iCurrent+35]=this.dw_crenocru
this.Control[iCurrent+36]=this.cb_6
this.Control[iCurrent+37]=this.dw_1
end on

on w_compras_cxp3.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_a)
destroy(this.dw_c)
destroy(this.dw_anexo)
destroy(this.dw_b)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.dw_asiento)
destroy(this.dw_cab)
destroy(this.cb_2)
destroy(this.dw_cc)
destroy(this.dw_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_4)
destroy(this.st_leyenda)
destroy(this.st_10)
destroy(this.dw_op)
destroy(this.cb_5)
destroy(this.sle_1)
destroy(this.shl_1)
destroy(this.st_1)
destroy(this.dw_4)
destroy(this.sle_2)
destroy(this.st_11)
destroy(this.ln_1)
destroy(this.dw_crenocru)
destroy(this.cb_6)
destroy(this.dw_1)
end on

event open;
dw_report.SetTransObject(sqlca)
dw_op.SetTransObject(sqlca)

dw_crenocru.SetTransObject(sqlca)
st_1.text = string(dw_crenocru.retrieve())



f_recupera_empresa(dw_datos,'co_numero')
f_recupera_empresa(dw_datos,'tv_codigo')
f_recupera_empresa(dw_datos,"pv_codigo")
f_recupera_empresa(dw_asiento,"pl_codigo")
f_recupera_empresa(dw_asiento,"pl_codigo_1")
f_recupera_empresa(dw_asiento,"cs_codigo")
f_recupera_empresa(dw_b,"cp_pago_pm_codpct")
f_recupera_empresa(dw_3,"cp_pago_pm_codpct")
f_recupera_empresa(dw_b,"cp_pago_pm_codpct_1")
f_recupera_empresa(dw_3,"cp_pago_pm_codpct_1")
f_recupera_empresa(dw_3,"pl_codigo")
f_recupera_empresa(dw_3,"pl_codigo_1")

//Establecer solo cuentas de gasto



dw_3.getchild("pl_codigo",dwc_cuentas)
dwc_cuentas.setTransObject(sqlca)
dwc_cuentas.setfilter("pl_codigo like '5%' or pl_codigo like '6%'")
dwc_cuentas.filter()


istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"

istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal


call super::open

dw_datos.is_SerialCodeColumn = "mp_codigo"
dw_datos.is_SerialCodeType = "CRE_CXP"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

//ic_iva  =  f_iva_compras()
id_hoy =  f_hoy()

/*El listado de cr$$HEX1$$e900$$ENDHEX$$ditos es compartido con la ficha de ingreso o mantenimiento*/
dw_datos.sharedata(dw_1)
//dw_datos.SetTransObject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.Settransobject(sqlca)


/*Auxiliares para el cruce*/
dw_a.SetTransObject(sqlca)
dw_b.SetTransObject(sqlca)
dw_c.SetTransObject(sqlca)
dw_anexo.SetTransObject(sqlca)

/*Para la contabilizaci$$HEX1$$f300$$ENDHEX$$n*/
dw_cab.SetTransObject(sqlca)
dw_asiento.SetTransObject(sqlca)


dw_b.getchild("cp_pago_pm_codpct",idwc_retiva)
idwc_retiva.SetTransObject(sqlca)
idwc_retiva.retrieve(str_appgeninfo.empresa)
idwc_retiva.Setfilter("cc_reten_fp_codigo  = '7'")
idwc_retiva.Filter()
//
dw_3.getchild("cp_pago_pm_codpct",idwc_reten)
idwc_reten.SettransObject(sqlca)
idwc_reten.retrieve(str_appgeninfo.empresa)
idwc_reten.Setfilter("cc_reten_fp_codigo  = '6'")
idwc_reten.Filter()



/*Seteo por default*/
em_1.text = string(today(),'dd/mm/yyyy')
em_2.text = string(today(),'dd/mm/yyyy')
this.triggerevent("ue_insert")



end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
//if this.ib_inReportMode then
//	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
//else
dw_1.resize(li_width -2*dw_1.x,dw_1.height)
dw_datos.resize(li_width - 2*dw_datos.x, dw_datos.height)
dw_b.resize(li_width - 2*dw_b.x, dw_b.height)
dw_2.resize(li_width -2*dw_2.x,dw_2.height)
dw_3.resize(li_width - 2*dw_3.x, dw_3.height)
dw_4.resize(li_width - 2*dw_4.x, dw_4.height)
dw_op.resize(li_width - 2*dw_op.x, dw_op.height)
//end if	
this.setRedraw(True)
end event

event ue_printcancel;w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then

	if this.wf_postPrint() = 1 then
		this.setRedraw(False)
		dw_report.enabled = False
		dw_report.visible = False
		dw_datos.enabled = True
		dw_datos.visible = True
		this.ib_inReportMode = False
		this.triggerEvent(resize!)		// so dw_datos get the correct size
		lw_frame = this.parentWindow()
		lm_frame = lw_frame.menuid
		lm_frame.mf_outof_report_mode()
	end if

else
	beep(1)
end if

this.setRedraw(True)
end event

event ue_retrieve;date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
dw_1.bringtotop = true
return dw_1.retrieve(str_appgeninfo.empresa,ld_ini,ld_fin)
end event

event ue_saveas;call super::ue_saveas;long ll_nreg
w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n ....por favor espere!!!")
ll_nreg = dw_anexo.retrieve(date(em_1.text),date(em_2.text))
w_marco.SetMicrohelp("Listo...!")
Setpointer(Hourglass!)
If ll_nreg > 0 then
dw_anexo.saveas()	
end if
Setpointer(Arrow!)

end event

event activate;call super::activate;m_marco.m_archivo.m_salvarcomo.visible = True
m_marco.m_archivo.m_salvarcomo.enabled = True
move(1,1)
end event

event deactivate;call super::deactivate;m_marco.m_archivo.m_salvarcomo.visible = false
m_marco.m_archivo.m_salvarcomo.enabled = false
end event

event ue_anular;String  ls_mpcoddeb,ls_mpcodigo, ls_tvcodigo,ls_tvtipo,ls_pvcodigo,ls_facpro,ls_cpnumero,&
            ls_tipo = '3'
Long  ll_row
Date   ld_fecha,ld_hoy
Datetime ld_now




If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El movimiento de cr$$HEX1$$e900$$ENDHEX$$dito ser$$HEX2$$e1002000$$ENDHEX$$anulado completamente~n~rEst$$HEX2$$e1002000$$ENDHEX$$seguro ...?",Question!,YesNo!,2) = 2 then
Return -1
End if


w_marco.SetMicrohelp("Procesando....por favor espere!!!")

SetPointer(Hourglass!)

ll_row  = dw_datos.getrow()

ls_mpcodigo      = dw_datos.GetitemString(ll_row,"mp_codigo",Primary!,true)
ls_tvcodigo      = dw_datos.GetitemString(ll_row,"tv_codigo",Primary!,true)
ls_tvtipo        = dw_datos.GetitemString(ll_row,"tv_tipo",Primary!,true)
ls_facpro        = dw_datos.GetitemString(ll_row,"co_facpro",Primary!,true)
ls_pvcodigo      = dw_datos.GetitemString(ll_row,"pv_codigo",Primary!,true)
ls_cpnumero     = dw_datos.GetitemString(ll_row,"cp_numero",Primary!,true)
ld_fecha         = date(dw_datos.Getitemdatetime(ll_row,"mp_fecha",Primary!,true))


/*Permitir la anulaci$$HEX1$$f300$$ENDHEX$$n de la compra solo si es de la misma fecha en la que 
  se  grabo la compra*/

select trunc(sysdate)
into :ld_now
from  dual;

ld_hoy = date(ld_now)

//if ld_fecha <> ld_hoy then
//	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El cr$$HEX1$$e900$$ENDHEX$$dito que desea anular no es de hoy d$$HEX1$$ed00$$ENDHEX$$a...No se puede anular",Exclamation!)
//   return -1	
//end if	




	
/*Eliminar todos los cruces que tenga este cr$$HEX1$$e900$$ENDHEX$$dito*/
declare cruce cursor for 
select mp_coddeb
from cp_cruce
where em_codigo = :str_appgeninfo.empresa 
and su_codigo  = :str_appgeninfo.sucursal
and mp_codigo = :ls_mpcodigo 
and tv_codigo = :ls_tvcodigo
and tv_tipo = :ls_tvtipo
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
		tv_codigo = :ls_tvcodigo and
		tv_tipo = :ls_tvtipo and
		tv_coddeb = '2' and
		tv_tipodeb = 'D' and
		em_codigo  = :str_appgeninfo.empresa and
		su_codigo  = :str_appgeninfo.sucursal;
		if sqlca.sqlcode < 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular el cruce"+sqlca.sqlerrtext)
		rollback;
		return -1
		end if

			
		/*Delete el pago*/
		delete 
		from cp_pago
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
		and tv_codigo = '2'
		and tv_tipo = 'D'
		and mp_codigo = :ls_mpcoddeb;
		if sqlca.sqlcode < 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas la forma de pago"+sqlca.sqlerrtext)
		rollback;
		return -1
		end if
		
		
		delete 
		from cp_movim
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
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

/*Delete el credito cp_movim*/
delete 
from cp_movim
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and tv_codigo = :ls_tvcodigo
and tv_tipo   = :ls_tvtipo
and mp_codigo = :ls_mpcodigo
and co_facpro = :ls_facpro 
and pv_codigo = :ls_pvcodigo;

if sqlca.sqlcode < 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular la deuda"+sqlca.sqlerrtext)
rollback;
return -1
end if


/*Anular el comprobante contable*/
UPDATE CO_CABCOM
SET CP_ANULADO ='S',CP_FECANU = SYSDATE
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND TI_CODIGO = :ls_tipo
AND CP_NUMERO = :ls_cpnumero;

if sqlca.sqlcode < 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular el comprobante contable"+sqlca.sqlerrtext)
rollback;
return -1
end if



commit;
dw_datos.reset()
w_marco.SetMicrohelp("Listo ...Movimiento de Cr$$HEX1$$e900$$ENDHEX$$dito anulado completamente")
SetPointer(Arrow!)
return 1



end event

event ue_insert;call super::ue_insert;Long ll_row
//Por cada nueva compra limpiar los 
dw_a.reset()
dw_b.reset()
dw_2.reset()
dw_3.reset()
dw_4.reset()

ll_row = dw_datos.getrow()
if not isnull(dw_datos.Object.mp_codigo[ll_row] ) then
	dw_3.object.b_1.enabled = false
	dw_3.object.b_2.enabled = false
	dw_3.object.b_3.enabled = false
	dw_b.object.b_1.enabled = false
	dw_b.object.b_2.enabled = false
	dw_b.object.b_3.enabled = false
end if
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_compras_cxp3
integer x = 50
integer y = 128
integer width = 6034
integer height = 1244
integer taborder = 130
string dataobject = "d_sri_transacciones"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
end type

event dw_datos::itemchanged;call super::itemchanged;decimal{2} lc_basegrav,lc_basecero,lc_ice,lc_iva
String  ls_pvcodigo,ls_cofacpro,ls_pvrazons,ls_ptoemi,ls_estab
long ll_count,li_rango,ll_dias,ll_new

date ld_fecha


This.accepttext()
if dwo.name = 'pv_codigo' then
	SELECT nvl(PV_RAZONS,pv_nombre||' '||pv_apelli)
	into :ls_pvrazons
	FROM IN_PROVE
	WHERE PV_CODIGO = :data;
	is_pvcodigo  = data
	this.object.in_prove_pv_razons[row] = ls_pvrazons
end if


if dwo.name = 'mp_codpctiva' or dwo.name = 'mp_baseimp' then 
this.object.mp_valret[row] = this.object.cc_mpvalret[row]
end if

if dwo.name = "mp_biepctiva" then
this.object.mp_bievlrret[row] = this.object.cc_bievlrret[row]
end if 

if dwo.name = "mp_srvpctiva" then
this.object.mp_srvvlrret[row] = this.object.cc_srvvlrret[row]
end if 

if dwo.name = 'mp_codpctice' or dwo.name  = 'mp_bseimpice' then
this.object.mp_montoice[row] = this.object.cc_montoice[row]
end if

//Actualizar total
if dwo.name = "mp_bseimptrf0" or dwo.name = "mp_baseimp" &
or dwo.name="mp_codpctiva" or dwo.name = "mp_bseimpice" or dwo.name = "mp_codpctice" then

		If isnull(this.object.mp_bseimptrf0[row]) then 
		lc_basecero = 0
		else
		lc_basecero = this.object.mp_bseimptrf0[row]
		end if
		
		If isnull(this.object.mp_baseimp[row]) then
		lc_basegrav = 0
		else
		lc_basegrav = this.object.mp_baseimp[row]
		end if
		
		If isnull(this.object.mp_valret[row]) then 
		lc_iva = 0
		else
		lc_iva	= this.object.mp_valret[row]
		end if
		
		If isnull(this.object.mp_montoice[row]) then 
			lc_ice = 0
		else
			lc_ice = this.object.mp_montoice[row]
		end if
		this.object.mp_valor[row] = lc_basecero + lc_basegrav + lc_iva + lc_ice
end if



//Asignar datos de la factura



if dwo.name = 'mp_docnrosec' then
	integer li_data
	string   ls_naut
	date ld_femi,ld_fven
	
	
	li_data = 	integer(data)
	
//	SELECT  DC_PTOEMI,DC_ESTAB,DC_NAUT,DC_FECEMI,DC_FECVEN
//	INTO     :ls_ptoemi,:ls_estab,:ls_naut,:ld_femi,:ld_fven
//	FROM    IN_DOCPRO
//	WHERE  PV_CODIGO = :is_pvcodigo
//	AND       DC_TIPODOC = 'F'
//	AND       DC_SECINI < :li_data
//	AND       DC_SECFIN >:li_data;
//	
//	//Mensaje de advertencia 
//	IF SQLCA.SQLCODE = 100 THEN
//		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se han registrado documentos con esta secuencia ...Por favor verifique...!"+sqlca.sqlerrtext)
//		ld_femi = today()
//		ld_fven = today()
//	End IF
			
	
	If not isnull(ls_estab) and ls_estab <> '' then 	this.object.mp_docnroest[ row ] = ls_estab
	If not isnull(ls_ptoemi) and ls_ptoemi <> '' then this.object.mp_docnropto[ row ] = ls_ptoemi
//	If not isnull(ld_femi ) and string(ld_femi) <> '01/01/1900' then this.object.mp_fecemision[row] = ld_femi
//	If not isnull(ld_fven ) and string(ld_fven) <> '01/01/1900' then this.object.mp_feccaduci[row] = ld_fven
	If not isnull(ls_naut) and ls_naut <> '' then this.object.mp_naut[row] = ls_naut
	
	/*************/
	ls_pvcodigo = this.object.pv_codigo[row]
	ls_cofacpro = this.Object.mp_docnroest[row] + this.Object.mp_docnropto[row] + this.Object.mp_docnrosec[row]
	SELECT COUNT(1)
	INTO :ll_count
	FROM CP_MOVIM
	WHERE TV_TIPO = 'C'
	AND PV_CODIGO = :ls_pvcodigo
	AND CO_FACPRO = :ls_cofacpro;
	If ll_count > 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existe una factura con este n$$HEX1$$fa00$$ENDHEX$$mero '"+ls_cofacpro+"' para este proveedor...<Por favor verifique > ")
		Rollback;
		return
	end if

end if



if dwo.name = 'mp_fecemision' then
	select pr_valor
	into :li_rango
	from pr_param
	where em_codigo = :str_appgeninfo.empresa
	and pr_nombre = 'NDIAS_EDIC';
	
	ld_fecha = date(data)
	ll_dias = daysafter(ld_fecha,date(id_hoy))
	
	If  (ll_dias >= li_rango)  then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha de emisi$$HEX1$$f300$$ENDHEX$$n est$$HEX2$$e1002000$$ENDHEX$$fuera de l$$HEX1$$ed00$$ENDHEX$$mite permitido ["+string(li_rango)+"] d$$HEX1$$ed00$$ENDHEX$$as...<Por favor verifique!>")
	return 1
	end if
	
	this.object.mp_fecemiret[row] = date(data)

end if



if dwo.name = 'co_numero' then
	dec{2} lc_neto,lc_total,lc_pctjefte,lc_pctjeiva
	datetime ldt_fecha
	string     ls_codretfte,ls_codretiva
	
	
    //Asignar datos de la compra
	select c.co_facpro,c.pv_codigo,c.co_subtot,c.co_iva,c.co_total,c.co_fecha,rf.rf_tipo,rf.rf_procen,ri.rf_tipo,ri.rf_procen
	into   :ls_cofacpro,:ls_pvcodigo,:lc_neto,:lc_iva,:lc_total,:ldt_fecha,:ls_codretfte,:lc_pctjefte,:ls_codretiva,:lc_pctjeiva
	from IN_COMPRA  C, IN_PROVE P, CC_RETEN RF, CC_RETEN RI
	where C.PV_CODIGO = P.PV_CODIGO
	and  P.RF_CODIGO = RF.RF_CODIGO(+)
	and  P.RF_CODIGO2 = RI.RF_CODIGO(+)
	and  c.ec_codigo = '3'
	and c.em_codigo = :str_appgeninfo.empresa
	and c.co_rucsuc = :str_appgeninfo.sucursal
	and c.co_numero = :data
	and nvl(c.co_completa,'N')='N';
	
	IF SQLCA.SQLCODE = 100 THEN
 	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe compra con $$HEX1$$e900$$ENDHEX$$ste n$$HEX1$$fa00$$ENDHEX$$mero o ya ha sido registrada....Por favor verifique...!!!", Exclamation!)
     Return 1
     END IF
	
	
	is_sucursal = str_appgeninfo.sucursal
	
	this.object.tv_codigo[row] = '1'
	this.object.mp_tipoiva[row] = '1'
	this.object.ec_codigo[row] = '3'
	this.object.mp_codtribu[row] = '06'
	this.object.su_codigo[row] = is_sucursal
	
	this.object.co_facpro[row] = ls_cofacpro
	this.object.mp_docnroest[row] = mid(ls_cofacpro,1,3)
	this.object.mp_docnropto[row] = mid(ls_cofacpro,4,3)
	this.object.mp_docnrosec[row] = mid(ls_cofacpro,7)

	this.object.pv_codigo[row] = ls_pvcodigo
	this.object.mp_fecha[row] = ldt_fecha
	this.object.mp_fecemision[row] = ldt_fecha	
	
	
	//Insertar valores de la factura
	dw_3.reset()
     ll_new = dw_3.insertrow(0)
     dw_3.object.cp_pago_pm_codpct[ll_new] = ls_codretfte
	dw_3.object.cp_pago_pm_basegrav[ll_new] = lc_neto
	dw_3.object.cp_pago_pm_porctje[ll_new]  = lc_pctjefte
     dw_3.object.cp_pago_pm_bseimp[ll_new] = lc_neto
	dw_3.object.cp_pago_pm_valor[ll_new]  = (lc_pctjefte/100)*lc_neto 
	

	//La retenci$$HEX1$$f300$$ENDHEX$$n del IVA la debe realizar manualemente
	  
	  
	  
	  
end if


end event

event dw_datos::updatestart;String  ls_cofacpro,ls_deviva,ls_pvcodigo
long    ll_row,ll_count,ll_dias
integer li_rango
Date ld_fecha
Decimal{2}lc_saldo,lc_totalcruce
Char lch_estado
dwitemstatus l_status


Setpointer(Hourglass!)

/* 1.- Validar datos */
ll_row    =    this.getrow()
l_status  =    this.getitemstatus(ll_row,0,Primary!)

If ll_row = 0 then return 1




/*Permitir hasta 20 d$$HEX1$$ed00$$ENDHEX$$as antes de la fecha actual*/
select pr_valor
into :li_rango
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'NDIAS_EDIC';

ld_fecha = date(dw_datos.Object.mp_fecha[ll_row])
ll_dias = daysafter(ld_fecha,date(id_hoy))


//if string(ld_fecha,'yyyy') = '2017' then return 1


If  (ll_dias >= li_rango)  then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha de emisi$$HEX1$$f300$$ENDHEX$$n est$$HEX2$$e1002000$$ENDHEX$$fuera de l$$HEX1$$ed00$$ENDHEX$$mite permitido ["+string(li_rango)+"] d$$HEX1$$ed00$$ENDHEX$$as...<Por favor verifique!>")
return 1
end if

this.Object.co_facpro[ll_row] = this.Object.mp_docnroest[ll_row] + this.Object.mp_docnropto[ll_row] + this.Object.mp_docnrosec[ll_row]
ls_cofacpro = dw_datos.GetItemString(ll_row,"co_facpro")

If isnull(ls_cofacpro) or ls_cofacpro = ' '  then 
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El campo Factura de Proveedor no puede estar en blanco")
return 1
End if 

/*Validar que solo exista una factura por proveedor*/
If l_status = newmodified! or l_status = new! then
	ls_pvcodigo = this.object.pv_codigo[ll_row]
	SELECT COUNT(1)
	INTO :ll_count
	FROM CP_MOVIM
	WHERE TV_TIPO = 'C'
	AND PV_CODIGO = :ls_pvcodigo
	AND CO_FACPRO = :ls_cofacpro;
	If ll_count > 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existe una factura con este n$$HEX1$$fa00$$ENDHEX$$mero '"+ls_cofacpro+"' para este proveedor...<Por favor verifique > ")
		Rollback;
		return 1
	end if
end if


lch_estado = dw_datos.getitemstring(ll_row,"cp_movim_estado")
if isnull(lch_estado) or trim(lch_estado) = '' then
dw_datos.setitem(ll_row,"cp_movim_estado",'S')
end if

ls_deviva = dw_datos.getitemstring(ll_row,"mp_docdeviva")
if isnull(ls_deviva) or trim(ls_deviva) = '' then
dw_datos.setitem(ll_row,"cp_movim_estado",'S')
end if


/*Determinar el secuencial del credito*/
if isnull(is_empresa) or is_empresa = ""  then is_empresa = str_appgeninfo.empresa
if isnull(is_sucursal) or is_sucursal = ""  then is_sucursal = str_appgeninfo.sucursal
this.Object.em_codigo[ll_row] = str_appgeninfo.empresa
this.Object.su_codigo[ll_row]  = is_sucursal
this.Object.mp_fecreg[ll_row] = id_hoy
this.Object.mp_fecha[ll_row]   = this.Object.mp_fecemision[ll_row]

/*Actualiza el saldo del cr$$HEX1$$e900$$ENDHEX$$dito*/

this.Object.sa_login[ll_row] = str_appgeninfo.username
call super::updatestart
RETURN 0








end event

event dw_datos::doubleclicked;call super::doubleclicked;dw_datos.enabled = true
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true

end event

event dw_datos::clicked;call super::clicked;Long ll_numero
String ls_tipo,ls_tipcom

if dwo.name = 't_5' then
	if dw_cc.visible then	
		dw_cc.visible = false	
		this.object.t_5.text = '+'
		else
			dw_cc.visible = true
		    this.object.t_5.text = '-'
			ll_numero = long(this.object.cp_numero[row])
			if not isnull(ll_numero) and ll_numero <> 0 then
			ls_tipo = this.object.mp_tipoiva[row]	
			if ls_tipo = '1' then ls_tipcom = '3'     // DCO diario de compras
			if ls_tipo = '2' then ls_tipcom = '18'   // DPS  diario de proveedores de servicios
			dw_cc.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipcom,ll_numero)
			end if
     end if
end if
end event

event dw_datos::itemfocuschanged;call super::itemfocuschanged;//Filtrar los tipos de comprobante en base
// a la identificaci$$HEX1$$f300$$ENDHEX$$n del proveedor
String ls_cadena,ls_idprv

datawindowchild    ldwc_tc

ls_idprv = this.object.mp_tipidprv[row]
ls_cadena  = "tc_sectrans like '%"+ls_idprv+"%'"

if dwo.name = 'mp_tipodoc' then
	dw_datos.Getchild("mp_tipodoc",ldwc_tc)
	ldwc_tc.SetTransObject(sqlca)
	ldwc_tc.Setfilter(ls_cadena)
	ldwc_tc.filter()
end if
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;String ls_nrodeb[]
Int i,li_reg

Decimal lc_basegrav,lc_baseimpgrav,lc_op

//SetRowfocusIndicator(Hand!)
if currentrow=0 then return
dw_datos.scrolltorow(currentrow)
dw_datos.setrow(currentrow)

is_tvcodigo   = dw_datos.Object.tv_codigo[currentrow]
is_tvtipo       = dw_datos.Object.tv_tipo[currentrow]
is_empresa  = dw_datos.Object.em_codigo[currentrow]
is_sucursal   = dw_datos.Object.su_codigo[currentrow]
is_mpcodigo = dw_datos.Object.mp_codigo[currentrow]
is_pvcodigo  = dw_datos.Object.pv_codigo[currentrow]


/*Recupera todos los cruces del cr$$HEX1$$e900$$ENDHEX$$dito*/
dw_c.reset()
li_reg = dw_c.retrieve(is_empresa,is_sucursal,is_tvcodigo,is_tvtipo,is_mpcodigo)

for i = 1 to li_reg
ls_nrodeb[i] = dw_c.Object.cp_cruce_mp_coddeb[i]  
next

dw_a.reset()
if li_reg > 0 then dw_a.retrieve(is_sucursal,ls_nrodeb)

/*Retenciones de IVA*/
dw_b.reset()
dw_b.retrieve(is_empresa,is_sucursal,is_mpcodigo)

/*Limpia las retenciones en LA FUENTE*/
dw_2.reset()
dw_2.retrieve(is_empresa,is_sucursal,is_mpcodigo)

dw_3.reset()
dw_3.retrieve(is_empresa,is_sucursal,is_mpcodigo,ic_iva)

dw_4.reset()
dw_op.reset()

dw_op.Retrieve(is_mpcodigo,is_pvcodigo)
if dw_op.rowcount() > 0 then
lc_op = dw_op.object.cc_otrospagos[1]
end if
dw_datos.object.st_op.text = string(lc_op,'#,##0.00')

lc_basegrav       = dw_3.object.cc_basegrav[1]
lc_baseimpgrav  = dw_b.object.cc_bseimp_retiva[1]



if (lc_basegrav*ic_iva) <> lc_baseimpgrav then
     st_leyenda.visible = true
else
	st_leyenda.visible = false
end if
end event

event dw_datos::ue_postinsert;call super::ue_postinsert;//Refrescar dddw - compras
f_recupera_empresa(this,"co_numero")
this.Setcolumn("co_numero")
end event

event dw_datos::itemerror;call super::itemerror;return 1
end event

event dw_datos::updateend;call super::updateend;Long ll_row
ll_row = this.getrow()
if not isnull(this.Object.mp_codigo[ll_row] ) then
	dw_3.object.b_1.enabled = true
	dw_3.object.b_2.enabled = true
	dw_3.object.b_3.enabled = true
	dw_b.object.b_1.enabled = true
	dw_b.object.b_2.enabled = true
	dw_b.object.b_3.enabled = true
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_compras_cxp3
integer x = 23
integer y = 12
integer width = 4978
integer height = 2764
integer taborder = 0
boolean titlebar = true
string title = "Impresi$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_prn_retenciones_prismacolor"
boolean controlmenu = true
boolean hscrollbar = false
boolean resizable = true
end type

type dw_ubica from datawindow within w_compras_cxp3
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 1225
integer y = 148
integer width = 1513
integer height = 272
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Consultar"
string dataobject = "d_sel_factura"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_datos.SetFocus()
end if
end event

event itemchanged;String ls_numero
Long ll_nreg

If dwo.name = "factura" &
Then
ls_numero = data
dw_datos.reset()
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,ls_numero)
	if ll_nreg = 0 then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones...",Exclamation!)
	dw_datos.reset()
	dw_a.reset()
	dw_b.reset()
	dw_2.reset()
	dw_3.reset()
	dw_4.reset()
	return
	end if
end if
end event

type em_1 from editmask within w_compras_cxp3
integer x = 325
integer y = 32
integer width = 430
integer height = 76
integer taborder = 10
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
boolean autoskip = true
boolean spin = true
end type

event modified;sle_1.text = ''
sle_2.text= ''
end event

type em_2 from editmask within w_compras_cxp3
integer x = 1234
integer y = 32
integer width = 430
integer height = 76
integer taborder = 50
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
boolean autoskip = true
boolean spin = true
end type

event modified;sle_1.text = ''
sle_2.text=''
end event

type st_2 from statictext within w_compras_cxp3
integer x = 128
integer y = 40
integer width = 183
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_compras_cxp3
integer x = 1079
integer y = 40
integer width = 137
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
string text = "hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_a from datawindow within w_compras_cxp3
boolean visible = false
integer x = 4663
integer y = 1420
integer width = 1504
integer height = 528
integer taborder = 180
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

type dw_c from datawindow within w_compras_cxp3
boolean visible = false
integer x = 4677
integer y = 2004
integer width = 2629
integer height = 492
integer taborder = 210
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

type dw_anexo from datawindow within w_compras_cxp3
boolean visible = false
integer x = 4137
integer y = 2452
integer width = 123
integer height = 76
integer taborder = 190
boolean bringtotop = true
string title = "none"
string dataobject = "d_anexo_transaccional_compras_retfte"
boolean livescroll = true
end type

type dw_b from datawindow within w_compras_cxp3
event ue_postinsert pbm_custom01
integer x = 46
integer y = 2072
integer width = 6034
integer height = 396
integer taborder = 140
string title = "none"
string dataobject = "d_retiva"
boolean vscrollbar = true
end type

event ue_postinsert;String ls_codretiva,ls_pvcodigo
Long ll_new
Decimal lc_iva,lc_pctjeiva


ls_pvcodigo= dw_datos.object.pv_codigo[dw_datos.getrow()]
lc_iva      = dw_3.object.cc_iva[1]

select ri.rf_tipo,ri.rf_procen
into   :ls_codretiva,:lc_pctjeiva
from  IN_PROVE P,  CC_RETEN RI
where  P.RF_CODIGO2 = RI.RF_CODIGO(+)
and  P.PV_CODIGO = :ls_pvcodigo;

//Insertar valores 
dw_b.reset()
ll_new = dw_b.insertrow(0)
dw_b.object.cp_pago_pm_codpct[ll_new] = ls_codretiva
dw_b.object.cp_pago_pm_porctje[ll_new]  = lc_pctjeiva
dw_b.object.cp_pago_pm_bseimp[ll_new] = lc_iva
dw_b.object.cp_pago_pm_valor[ll_new]    = (lc_pctjeiva/100)*(lc_iva)
end event

event itemchanged;decimal lc_pctje
String    ls_codretfte,ls_codretiva

this.AcceptText()

if dwo.name ='cp_pago_pm_codpct' or dwo.name = 'cp_pago_pm_bseimp' then
	lc_pctje        = idwc_retiva.getitemdecimal(idwc_retiva.getrow(),"rf_procen")
	this.object.cp_pago_pm_porctje[row] = lc_pctje
//	this.object.cp_pago_pm_bseimp[row] = dw_datos.Object.mp_valret[dw_datos.getrow()]
end if


this.object.cp_pago_pm_valor.primary = this.object.cc_retiva.primary
end event

event buttonclicked;String ls_nromov,ls_nrocre,ls_codretfte,ls_codretiva
Long ll_new,ll_find,i,ll_row,ll_fila,rc
Dec  lc_totalcruce,lc_mntivabie,lc_mntivasrv,lc_retivabie,lc_retivasrv,lc_iva
Integer li_status


/*Validar que el nro registros no sea mas de 2*/
ll_row = dw_datos.getrow()
if ll_row = 0 then return
//ls_nrocre    = dw_datos.Object.mp_codigo[ll_row]
//is_pvcodigo = dw_datos.Object.pv_codigo[ll_row]
//lc_iva          = dw_datos.Object.mp_valret[ll_row] 



If dwo.name = 'b_1' then
this.postevent("ue_postinsert")
End if

If  dwo.name = 'b_3' then

/*Solo cruzar cuando haya un cr$$HEX1$$e900$$ENDHEX$$dito que cruzar*/
if ll_row <= 0 then return

  		/*Inicia validaci$$HEX1$$f300$$ENDHEX$$n*/
//          if wf_validacion() < 0 then return
        
        
		
         /*Determinar el estado de todo el dw*/
		If this.rowcount() > 0 then
		li_status = this.Object.cc_status[1]
		end if
		
		if li_status > 0 then 
			li_status  = 1 /*Se ha realizado un pago con anterioridad*/
		else
			/*Ver si existen filas marcadas para borrado*/
			if this.deletedcount() > 0 then 
			li_status  = 2 
	 	    else
			li_status  = 0 /*Pago nuevo*/
		    end if
			  
		end if
      		
		
		/*Pago nuevo*/
		wf_cruza_pago(dw_b,li_status)	
		
		
		/*Modificaci$$HEX1$$f300$$ENDHEX$$n al pago*/
//       wf_actualiza_saldo()
				
//		dw_datos.Object.mp_biemntiva[ll_row] = lc_mntivabie
//		dw_datos.Object.mp_srvmntiva[ll_row] = lc_mntivasrv
//		dw_datos.Object.retiva[ll_row] = dw_b.Object.cc_totalpago[1]
         

         If li_status = 2 then
		rc = wf_aplica_cambios(dw_c,dw_b,dw_a)
  	    else
		rc = wf_aplica_cambios(dw_a,dw_b,dw_c)	
        end if


       

end if

end event

event buttonclicking;Long ll_row

Decimal lc_iva



If dwo.name = 'b_1' then
	
	ll_row = dw_datos.getrow()
	
	If ll_row = 0 then return 1  // previene la ejecucion
	lc_iva          = dw_datos.Object.mp_valret[ll_row] 


	//Permitir a$$HEX1$$f100$$ENDHEX$$adir solo si existen datos en el comprobante de venta
	if lc_iva = 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Movimiento no permitido ...Para ingresar la retenci$$HEX1$$f300$$ENDHEX$$n el valor del IVA debe ser mayor a Cero... ")
     	return 1
	end if
	
	
	
	if this.rowcount() > 2 then
	w_marco.Setmicrohelp("No se puede realizar mas de dos(2) retenciones de IVA por factura...Por favor verifique!!!")
	return 1
    end if
	 
	 
end if
end event

event retrieveend;Long ll_row
ll_row = dw_datos.getrow()
if not isnull(dw_datos.Object.mp_codigo[ll_row] ) then
	this.object.b_1.enabled = true
	this.object.b_2.enabled = true
	this.object.b_3.enabled = true
else
	this.object.b_1.enabled = false
	this.object.b_2.enabled = false
	this.object.b_3.enabled = false
end if
end event

type dw_3 from datawindow within w_compras_cxp3
event ue_postinsert pbm_custom01
integer x = 46
integer y = 1480
integer width = 6034
integer height = 484
integer taborder = 170
string title = "none"
string dataobject = "d_retfte"
boolean vscrollbar = true
end type

event ue_postinsert;String   ls_cod1
decimal lc_%
long ll_row



ll_row = dw_datos.GetRow()


SELECT R.RF_TIPO
INTO    :ls_cod1
FROM   CC_RETEN R, IN_PROVE P
WHERE R.RF_CODIGO = P.RF_CODIGO
AND     P.PV_CODIGO  = :is_pvcodigo;

If sqlca.sqlcode<>0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha definido el concepto de retenci$$HEX1$$f300$$ENDHEX$$n para este Proveedor...por favor verifique..."+sqlca.sqlerrtext)
end if


this.Object.cp_pago_pm_codpct[this.getrow()] = ls_cod1
lc_%       = idwc_reten.getitemdecimal(idwc_reten.getrow(),"rf_procen")


this.object.cp_pago_pm_porctje[this.getrow()] = lc_%
this.Object.cp_pago_fp_codigo[this.getrow()]   = idwc_reten.getitemstring(idwc_reten.getrow(),"cc_reten_fp_codigo")
this.object.cp_pago_pm_base0[this.getrow()]   =  dw_datos.Object.mp_bseimptrf0[ll_row]
this.object.cp_pago_pm_basegrav[this.getrow()]   =  dw_datos.Object.mp_baseimp[ll_row]
this.object.cp_pago_pm_basenograv[this.getrow()]   =  dw_datos.Object.mp_bseimpice[ll_row]
this.object.cp_pago_pm_bseimp[this.getrow()] =  dw_datos.Object.mp_bseimptrf0[ll_row] + &
                                                                        dw_datos.Object.mp_baseimp[ll_row] + &
																dw_datos.Object.mp_bseimpice[ll_row]
this.object.cp_pago_pm_valor.primary = this.object.cc_retfte.primary
this.object.cp_pago_pm_codpctiva[this.getrow()]    = ic_iva
end event

event itemchanged;Long ll_row
decimal lc_pctje,lc_baseretfte

this.AcceptText()

ll_row = dw_datos.getrow()

if ll_row = 0 then return

//Para facturas que vienen desde compras
//ic_iva = Dec(dw_datos.Object.mp_codpctiva[dw_datos.getrow()])
//this.object.cp_pago_pm_codpctiva[row] = ic_iva

if dwo.name ='cp_pago_pm_codpct' then
	lc_pctje = idwc_reten.getitemdecimal(idwc_reten.getrow(),"rf_procen")
//	this.object.cp_pago_pm_bseimp[row] = lc_baseretfte
	this.object.cp_pago_pm_porctje[row] = lc_pctje
end if
wf_calculo_retencion(dw_3)
this.object.cp_pago_pm_valor.primary = this.object.cc_retfte.primary

end event

event buttonclicked;String   ls_nromov,ls_nrocre,ls_codretfte,ls_cod1
Long     ll_new,ll_find,i,ll_row,ll_fila,rc
Dec{2}  lc_totalcruce,lc_mntivabie,lc_mntivasrv,lc_retivabie,lc_retivasrv,lc_baseretfte
Integer  li_status


/*Validar que el nro registros no sea mas de 2*/


/*Validar que el nro registros no sea mas de 2*/
ll_row = dw_datos.getrow()
if ll_row = 0 then return
ls_nrocre    = dw_datos.Object.mp_codigo[ll_row]
is_pvcodigo = dw_datos.Object.pv_codigo[ll_row]
lc_baseretfte = dw_datos.Object.mp_bseimptrf0[ll_row] +&
                       dw_datos.Object.mp_baseimp[ll_row] + &
					dw_datos.Object.mp_bseimpice[ll_row] 


If dwo.name = 'b_1' then
this.postevent("ue_postinsert")
End if


if  dwo.name = 'b_3' then
ll_row = dw_datos.getrow()

/*Solo cruzar cuando haya un cr$$HEX1$$e900$$ENDHEX$$dito que cruzar*/
if ll_row <= 0 then return

         /*Validar si el cr$$HEX1$$e900$$ENDHEX$$dito no ha sido cancelado para aplicar los cambios*/
		/*Inicia validaci$$HEX1$$f300$$ENDHEX$$n*/
//         if wf_validacion() < 0 then return 

          ls_nrocre = dw_datos.Object.mp_codigo[ll_row]
	   	is_pvcodigo = dw_datos.Object.pv_codigo[ll_row]
		
         /*Determinar el estado de todo el dw*/
		If this.rowcount() > 0 then
		li_status = this.Object.cc_status[1]
		end if
		
		if li_status > 0 then 
			li_status  = 1 /*Se ha realizado un pago con anterioridad*/
		else
			/*Ver si existen filas marcadas para borrado*/
			if this.deletedcount() > 0 then 
			li_status  = 2 
	 	    else
			li_status  = 0 /*Pago nuevo*/
		    end if
			  
		end if
      		
		
		/*Pago nuevo*/
		wf_cruza_pago(dw_3,li_status)	
		
		
         if li_status = 2 then
		   wf_aplica_cambios(dw_c,dw_3,dw_a)
	        else
		  wf_aplica_cambios(dw_a,dw_3,dw_c)	
        end if

		
end if

end event

event buttonclicking;Long ll_row
Decimal lc_baseretfte
ll_row = dw_datos.getrow()
 

If dwo.name = 'b_1' then
		
	if ll_row = 0 then return 1
	is_pvcodigo = dw_datos.Object.pv_codigo[ll_row]
	lc_baseretfte = dw_datos.Object.mp_bseimptrf0[ll_row] +&
						dw_datos.Object.mp_baseimp[ll_row] + &
						dw_datos.Object.mp_bseimpice[ll_row]
	
	
	//Permitir a$$HEX1$$f100$$ENDHEX$$adir solo si existen datos en el comprobante de venta

	if this.rowcount() >= 3 then
	w_marco.Setmicrohelp("No se puede realizar mas de dos(2) retenciones en la fuente por factura...Por favor verifique!!!")
	return 1
    end if
	
end if
end event

event updateend;//Actualizar la compra como completa

Integer li_conumero

li_conumero = dw_datos.object.co_numero[dw_datos.getrow()]

If not isnull(li_conumero) and li_conumero <> 0 then

UPDATE IN_COMPRA
SET CO_COMPLETA = 'S'
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND CO_RUCSUC =:str_appgeninfo.sucursal
AND EC_CODIGO = '3'
AND CO_NUMERO = :li_conumero;


End if

Return 0
end event

event retrieveend;Long ll_row
ll_row = dw_datos.getrow()
if not isnull(dw_datos.Object.mp_codigo[ll_row] ) then
	this.object.b_1.enabled = true
	this.object.b_2.enabled = true
	this.object.b_3.enabled = true
else
	this.object.b_1.enabled = false
	this.object.b_2.enabled = false
	this.object.b_3.enabled = false
end if
end event

type cb_1 from commandbutton within w_compras_cxp3
integer x = 46
integer y = 1384
integer width = 1056
integer height = 84
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CONCEPTO AIR"
boolean flatstyle = true
end type

event clicked;String ls_nromov,ls_nrodeb,ls_empresa,ls_sucursal,ls_codpctiva
long   ll_row ,ll_reg,ll_new

ll_row          = dw_datos.getrow()
if ll_row = 0 then return
ls_empresa  = dw_datos.Object.em_codigo[ll_row]
ls_sucursal   = dw_datos.Object.su_codigo[ll_row]
ls_nromov    = dw_datos.Object.mp_codigo[ll_row]

//ls
ls_codpctiva           =  dw_datos.Object.mp_codpctiva[ll_row]
choose case  ls_codpctiva
	case'0'
	 ic_iva = 0 	
     case '1'
	ic_iva = 0.10
	case '2'
		ic_iva = 0.12
	case  '3'
		ic_iva = 0.14
	case else
		ic_iva = 0
end choose

/*Recupera las retenciones*/
//dw_2.retrieve(ls_empresa,ls_sucursal,ls_nromov)
//ll_reg = dw_3.retrieve(ls_empresa,ls_sucursal,ls_nromov)

//if ll_reg = 0 then 
    /*Detalle de las retenciones*/
	 
if dw_datos.rowcount() > 0 then
	
//Leer la retenci$$HEX1$$f300$$ENDHEX$$n definida para el proveedor	
	
	
dw_2.reset()
dw_3.reset()
if dw_2.rowcount() > 0 then return
dw_2.insertrow(0)
ll_new = dw_3.insertrow(0)
dw_3.object.cp_pago_pm_codpctiva[ll_new]    = ic_iva
dw_3.object.cp_pago_pm_base0[ll_new]         = dw_datos.Object.mp_bseimptrf0[ll_row]
dw_3.object.cp_pago_pm_basegrav[ll_new]     = dw_datos.Object.mp_baseimp[ll_row]
dw_3.object.cp_pago_pm_basenograv[ll_new] = dw_datos.Object.mp_bseimpice[ll_row]
dw_3.object.cp_pago_pm_bseimp[ll_new] =       dw_datos.Object.mp_bseimptrf0[ll_row] + &
                                                                        dw_datos.Object.mp_baseimp[ll_row] + &
																dw_datos.Object.mp_bseimpice[ll_row]
end if



end event

type st_5 from statictext within w_compras_cxp3
boolean visible = false
integer x = 5399
integer y = 1316
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "CP_MOVIM"
boolean focusrectangle = false
end type

type st_6 from statictext within w_compras_cxp3
boolean visible = false
integer x = 4101
integer y = 1308
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "CP_CRUCE"
boolean focusrectangle = false
end type

type dw_asiento from uo_dw_basic within w_compras_cxp3
boolean visible = false
integer x = 5362
integer y = 612
integer width = 704
integer height = 412
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_aux_detallecomprobante"
boolean controlmenu = true
boolean border = true
boolean hsplitscroll = true
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;/*Listo*/
Decimal{2} lc_creditos,lc_debitos
Long ll_sectipo,ll_cont,ll_row
Integer i,li_rc
String  ls_sectipo,ls_sigla,&
           ls_tipo = '3',&
		 ls_cofacpro	,ls_mpcodigo 
 Date ld_fecreg
		 	  


Setpointer(Hourglass!)
If dwo.name = 'b_1' then

If this.rowcount() <= 0 then return -1

ll_row = dw_datos.getrow()
if ll_row = 0 then return
ls_mpcodigo = dw_datos.Object.mp_codigo[ll_row]
ls_cofacpro  = dw_datos.Object.co_facpro[ll_row]
ld_fecreg     = date(dw_datos.Object.mp_fecha[ll_row])

/*Validar que no haya sido contabilizado*/
SELECT count(1)
into :ll_cont
FROM CP_MOVIM
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND TV_TIPO = 'C'
AND MP_CONTAB = 'S'
AND MP_CODIGO = :ls_mpcodigo
AND CO_FACPRO = :ls_cofacpro;

if ll_cont > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La factura  ya ha sido contabilizada...<por favor verifique!!!>")
	return -1
end if	

lc_creditos = this.Object.cc_totcreditos[1]
lc_debitos  = this.Object.cc_totdebitos[1]

IF lc_creditos = 0 and lc_debitos = 0 THEN
return -1
END IF

IF lc_creditos <> lc_debitos THEN
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El asiento no cuadra...<Por favor verifique!!>",Exclamation!)
return -1	
END IF

il_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
ll_sectipo     = f_secuencial(str_appgeninfo.empresa,'DCO')
ls_sectipo    = String(ll_sectipo)


/**/
If il_cpnumero < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return -1
End if 

If ll_sectipo < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial por tipo de comprobante...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return -1
End if 




dw_cab.insertrow(0)
dw_cab.SetItem(1,"em_codigo",str_appgeninfo.empresa)
dw_cab.SetItem(1,"cp_numero",il_cpnumero)
dw_cab.SetItem(1,"su_codigo",str_appgeninfo.sucursal)
dw_cab.SetItem(1,"cp_numcomp",ls_sectipo)
dw_cab.SetItem(1,"ti_codigo",ls_tipo)
dw_cab.SetItem(1,"cp_fecha",ld_fecreg)
dw_cab.SetItem(1,"cp_debito",lc_debitos)
dw_cab.SetItem(1,"cp_credito",lc_creditos)
dw_cab.SetItem(1,"cp_observ",dw_asiento.object.dt_detalle[1])


/*Inserta clave del detalle solo si es nuevo*/
for i = 1 to dw_asiento.RowCount()
dw_asiento.SetItem(i,"em_codigo",str_appgeninfo.empresa)
dw_asiento.SetItem(i,"su_codigo",str_appgeninfo.sucursal)
dw_asiento.SetItem(i,"ti_codigo",ls_tipo)
dw_asiento.SetItem(i,"cp_numero",il_cpnumero)
dw_asiento.SetItem(i,"dt_secue",String(i))
next 	

/**/
li_rc = dw_cab.Update(TRUE, FALSE) 
if li_rc = 1 then
		li_rc = dw_asiento.update(TRUE, FALSE)
		if li_rc = 1 then
		dw_cab.resetupdate()
		dw_asiento.resetupdate()	
		
		//Marcar las compras como Contabilizadas
		UPDATE CP_MOVIM
		SET MP_CONTAB = 'S',
		       CP_NUMERO = :il_cpnumero
		WHERE EM_CODIGO = :str_appgeninfo.empresa
		AND SU_CODIGO = :str_appgeninfo.sucursal
		AND TV_TIPO = 'C'
		AND MP_CODIGO = :ls_mpcodigo
		AND CO_FACPRO = :ls_cofacpro;

		If sqlca.sqlcode < 0 Then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar la factura de compra"+sqlca.sqlerrtext)
		Rollback;
		return -1
		End if
		
		//Solo para efecto informativo, el dw no graba el numero de comprobante.
		dw_datos.Object.cp_numero[ll_row] = STRING(il_cpnumero)
			
		commit;
		w_marco.Setmicrohelp("Asiento contable creado exitosamente....<Por favor verifique asiento N$$HEX1$$ba00$$ENDHEX$$:"+String(il_cpnumero)+">")
		else
	     Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas  el detalle del comprobante..."+sqlca.sqlerrtext)
		rollback;
		return -1
		end if 	
else
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el comprobante..."+sqlca.sqlerrtext)
rollback;
return -1
End if
End if

If dwo.name = 'b_2' then
this.visible = false
End if
Setpointer(Arrow!)
end event

event editchanged;call super::editchanged;String ls_data

If dwo.name = "pl_codigo" Then
	ls_data = data+'%'
	dwc_cuentas.SetFilter("pl_codigo like '"+ls_data+"' ")
	dwc_cuentas.Filter()
End if 

Return 1
end event

event getfocus;call super::getfocus;if getrow() > 0 Then
	dwc_cuentas.SetFilter("")
	dwc_cuentas.Filter()
	This.GetChild("pl_codigo",dwc_cuentas)
End if
end event

type dw_cab from datawindow within w_compras_cxp3
boolean visible = false
integer x = 5929
integer y = 28
integer width = 347
integer height = 76
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_aux_comprobante"
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_compras_cxp3
integer x = 1239
integer y = 1384
integer width = 1157
integer height = 84
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Activar DOC"
boolean flatstyle = true
end type

event clicked;String ls_pvcodigo

if dw_datos.rowcount() = 0 then
	return
else
	ls_pvcodigo = dw_datos.Object.pv_codigo[dw_datos.getrow()]
	dw_4.visible = true
	dw_4.retrieve(str_appgeninfo.empresa,ls_pvcodigo)
end if
end event

type dw_cc from uo_dw_comprobante within w_compras_cxp3
boolean visible = false
integer x = 59
integer y = 908
integer width = 4457
integer height = 1028
integer taborder = 240
boolean bringtotop = true
boolean titlebar = true
string title = "Comprobante contable"
end type

event buttonclicked;//
If dwo.name = 'b_3' then
	
	IF 	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta opci$$HEX1$$f300$$ENDHEX$$n solo imprimir$$HEX2$$e1002000$$ENDHEX$$el comprobante contable....Si desea imprimir el comprobante y la factura," +&
	                       "seleccione la opci$$HEX1$$f300$$ENDHEX$$n IMPRIMIR desde el men$$HEX2$$fa002000$$ENDHEX$$principal...Desea continuar...?",Question!,YesNo!,2) = 2 then
	return					
	END IF
end if
call super::buttonclicked
end event

event updateend;call super::updateend;Long ll_row,ll_cont,ll_cpnumero
String ls_cofacpro,ls_mpcodigo
Date   ld_fecreg


If this.rowcount() <= 0 then return 1

ll_row = dw_datos.getrow()
if ll_row = 0 then return
ls_mpcodigo = dw_datos.Object.mp_codigo[ll_row]
ls_cofacpro  = dw_datos.Object.co_facpro[ll_row]
ld_fecreg     = date(dw_datos.Object.mp_fecha[ll_row])
ll_cpnumero = this.object.cp_numero[1]


//Marcar las compras como Contabilizadas
UPDATE CP_MOVIM
SET MP_CONTAB = 'S',
	  CP_NUMERO = :ll_cpnumero
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND TV_TIPO = 'C'
AND MP_CODIGO = :ls_mpcodigo
AND CO_FACPRO = :ls_cofacpro;

If sqlca.sqlcode < 0 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar la factura de compra"+sqlca.sqlerrtext)
Rollback;
return 1
End if

//Solo para efecto informativo, el dw no graba el numero de comprobante.
dw_datos.Object.cp_numero[ll_row] = STRING(ll_cpnumero)


return 0


end event

event updatestart;call super::updatestart;Long ll_row,ll_cont,ll_cpnumero
String ls_cofacpro,ls_mpcodigo
Date   ld_fecreg


If this.rowcount() <= 0 then return 1

ll_row = dw_datos.getrow()
if ll_row = 0 then return
ls_mpcodigo = dw_datos.Object.mp_codigo[ll_row]
ls_cofacpro  = dw_datos.Object.co_facpro[ll_row]
ld_fecreg     = date(dw_datos.Object.mp_fecha[ll_row])

/*Validar que no haya sido contabilizado*/
SELECT count(1)
into :ll_cont
FROM CP_MOVIM
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND TV_TIPO = 'C'
AND MP_CONTAB = 'S'
AND MP_CODIGO = :ls_mpcodigo
AND CO_FACPRO = :ls_cofacpro;

if ll_cont > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La factura  ya ha sido contabilizada...<por favor verifique!!!>")
	return 1
end if	
return 0
end event

type dw_2 from datawindow within w_compras_cxp3
boolean visible = false
integer x = 3918
integer y = 3228
integer width = 1102
integer height = 172
integer taborder = 160
boolean bringtotop = true
string title = "none"
string dataobject = "d_sri_cruce_creditos_vs_debitos_cabecera"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cb_3 from commandbutton within w_compras_cxp3
integer x = 768
integer y = 28
integer width = 96
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_1.text = em_2.text
end event

type cb_4 from commandbutton within w_compras_cxp3
integer x = 978
integer y = 28
integer width = 82
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_2.text = em_1.text
end event

type st_8 from statictext within w_compras_cxp3
boolean visible = false
integer x = 4430
integer y = 40
integer width = 535
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 134217856
long backcolor = 67108864
string text = "Ver listado de facturas"
boolean focusrectangle = false
end type

event clicked;long j
		
		//Maximiza SRI NC
		//si esta abierto  no volver a abrir
		if dw_datos.y = 112  then 
              st_8.text = 'Ocultar listado de facturas'
			 long i[] = {110,168,1552,1640,2036,2852,2132,2628,2712,436,10}
			 for j = 1 to 436  STEP 10
					i[1] = i[1] + i[11]
//					st_1.y =i[1]  
					
					i[2] = i[2] + i[11]
					dw_datos.y= i[2] 
					
					i[3] = i[3] + i[11]
					st_4.y  = i[3]
					
					i[4] = i[4] + i[11]
					dw_b.Y = i[4]
  			      
					i[5] = i[5] + i[11]
					cb_1.y = i[5] 
					
					i[6] = i[6] + i[11]
					dw_2.Y = i[6]
					
					i[7] = i[7] + i[11]
					dw_3.Y = i[7]
					
					i[8] = i[8] + i[11]
					cb_2.Y = i[8]
					
					i[9] = i[9] + i[11]
                       dw_4.y  = i[9]
			next

		else
		 i[] = {480,552,1724,1780,2196,2280,2480,2916,2996,436,10}
			st_8.text = 'Ver listado de facturas'
              for j = 1 to 436  STEP 10

					i[1] = i[1] - i[11]
//					st_1.y =i[1]
					

					i[2] = i[2] - i[11]
					dw_datos.y= i[2] 
					

					i[3] = i[3] - i[11]
					st_4.y  = i[3]
					

					i[4] = i[4] - i[11]
					dw_b.Y = i[4]
					 

					 i[5] = i[5] - i[11]
					 cb_1.y = i[5] 
					

					i[6] = i[6] - i[11]
					dw_2.Y = i[6]


					i[7] = i[7] - i[11]
					dw_3.Y = i[7]
					

					i[8] = i[8] - i[11]
					cb_2.Y = i[8]
					

					i[9] = i[9] - i[11]
                      dw_4.y  = i[9]
			next

		end if
		

end event

type st_9 from statictext within w_compras_cxp3
integer x = 1682
integer y = 40
integer width = 370
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Comprobante N$$HEX1$$ba00$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_4 from commandbutton within w_compras_cxp3
integer x = 1234
integer y = 1976
integer width = 1179
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RETENCION SOBRE IVA"
boolean flatstyle = true
end type

type st_leyenda from statictext within w_compras_cxp3
integer x = 2661
integer y = 2116
integer width = 1893
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "El monto de IVA  no coincide con el definido para la retenci$$HEX1$$f300$$ENDHEX$$n...Por favor verifique...!"
boolean focusrectangle = false
end type

type st_10 from statictext within w_compras_cxp3
boolean visible = false
integer x = 5193
integer y = 36
integer width = 581
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
string text = "Ver cr$$HEX1$$e900$$ENDHEX$$ditos"
boolean focusrectangle = false
end type

event clicked;if  dw_1.bringtotop = true then
    this.text = 'Ver cr$$HEX1$$e900$$ENDHEX$$ditos'
	dw_1.bringtotop = false 
else
	dw_1.bringtotop = true
	this.text = 'Ocultar cr$$HEX1$$e900$$ENDHEX$$ditos'
end if
end event

type dw_op from datawindow within w_compras_cxp3
boolean visible = false
integer x = 50
integer y = 184
integer width = 4974
integer height = 628
integer taborder = 200
boolean bringtotop = true
boolean titlebar = true
string title = "Otros Pagos"
string dataobject = "d_pagos_x_fact"
boolean controlmenu = true
boolean livescroll = true
end type

type cb_5 from commandbutton within w_compras_cxp3
integer x = 2523
integer y = 1388
integer width = 1161
integer height = 80
integer taborder = 250
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "VER PAGOS"
boolean flatstyle = true
end type

event clicked;Long ll_row
String ls_pvcodigo,ls_nromov

ll_row  = dw_datos.getrow()

if ll_row = 0 then return
ls_nromov   = dw_datos.Object.mp_codigo[ll_row]
ls_pvcodigo = dw_datos.Object.pv_codigo[ll_row]

if dw_op.Retrieve(ls_nromov,ls_pvcodigo) > 0 then
	dw_op.visible = true
else
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No tiene ningun pago asociado...")
	return
end if



end event

type sle_1 from singlelineedit within w_compras_cxp3
integer x = 2085
integer y = 32
integer width = 635
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event modified;em_1.text = ''
em_2.text = ''
sle_2.text = ''
end event

type shl_1 from statichyperlink within w_compras_cxp3
integer x = 4073
integer y = 40
integer width = 430
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Cr$$HEX1$$e900$$ENDHEX$$ditos sin cruzar"
boolean focusrectangle = false
end type

type st_1 from statictext within w_compras_cxp3
integer x = 4539
integer y = 20
integer width = 155
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

event clicked;if  dw_crenocru.visible = false then
	dw_crenocru.visible = true
else
	dw_crenocru.visible = false
end if
end event

type dw_4 from datawindow within w_compras_cxp3
integer x = 197
integer y = 380
integer width = 4101
integer height = 988
integer taborder = 220
boolean titlebar = true
string title = "Documentos legales"
string dataobject = "d_legales_x_prov_lista"
boolean controlmenu = true
boolean livescroll = true
end type

event buttonclicked;String  ls_sec,ls_pvcodigo
Long ll_row

if dwo.name = 'b_1' then
	ll_row = dw_datos.getrow()
	if ll_row = 0 then return -1
	
	ls_pvcodigo   =  dw_datos.Object.pv_codigo[ll_row]
	if isnull(ls_pvcodigo) or ls_pvcodigo = '' then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha seleccionado ningun proveedor.....Por favor verifique...!")
		return -1
	else
		this.setitem(ll_row,"pv_codigo",ls_pvcodigo )
	end if
end if


end event

event itemchanged;String ls_pvcodigo
integer li_secini





//Validar n$$HEX1$$fa00$$ENDHEX$$mero de autorizaci$$HEX1$$f300$$ENDHEX$$n por documento y por proveedor




//Validar rango de secuencia por documento y por proveedor

//IF dwo.name = 'dc_tipodoc' then
//	ls_pvcodigo = dw_datos.object.pv_codigo[dw_datos.getrow()]
//	SELECT MAX(DC_SECFIN)  + 1 
//	INTO    :li_secini
//	FROM   IN_DOCPRO
//	WHERE DC_TIPODOC = :data
//	AND      PV_CODIGO = :ls_pvcodigo;
//
//     if li_secini  = 0 or isnull(li_secini) then li_secini = 1
//	this.object.dc_secini[row] = li_secini
//end if


if dwo.name = 'dc_fecemi' then
	if date(data) >= date(this.object.dc_fecven[row]) then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rango de fechas inv$$HEX1$$e100$$ENDHEX$$lido")
	return 1
	end if
end if


if dwo.name = 'dc_fecven' then
	if date(data) <= date(this.object.dc_fecemi[row]) then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rango de fechas inv$$HEX1$$e100$$ENDHEX$$lido")
	return 1
	end if
end if
end event

event updatestart;
String ls_proveedor
integer li,ll,li_row,li_cod

li_row = this.getrow()

if li_row = 0 then return 1
for li = 1 to this.rowcount( )
	     li_cod = this.GetItemNumber(li,'id')
		 if isnull(li_cod) or li_cod = 0 then
			 select nvl(max( id ),0 ) +1
			 into :ll
			 from in_docpro;
			 this.SetItem(li,'id',ll  ) 
		end if
next
return 0



end event

type sle_2 from singlelineedit within w_compras_cxp3
integer x = 2926
integer y = 32
integer width = 581
integer height = 76
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event modified;em_1.text = ''
em_2.text = ''
sle_1.text = ''
end event

type st_11 from statictext within w_compras_cxp3
integer x = 2757
integer y = 40
integer width = 160
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "RUC/CI"
boolean focusrectangle = false
end type

type ln_1 from line within w_compras_cxp3
long linecolor = 134217730
integer linethickness = 4
integer beginx = 82
integer beginy = 128
integer endx = 5051
integer endy = 128
end type

type dw_crenocru from datawindow within w_compras_cxp3
boolean visible = false
integer x = 64
integer y = 136
integer width = 5943
integer height = 1236
integer taborder = 110
string title = "none"
string dataobject = "d_creditos_sin_cruce"
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;String ls_nrodeb[]
Int i,li_reg
Long ll_find
Decimal lc_op

SetRowfocusIndicator(Hand!)

is_mpcodigo = this.Object.mp_codigo[row]
is_pvcodigo   = this.Object.pv_codigo[row]
is_cofacpro   = this.Object.co_facpro[row]


ll_find = dw_datos.retrieve(str_appgeninfo.empresa,is_cofacpro,is_pvcodigo,is_mpcodigo)

if ll_find = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos....")
	return
end if

dw_datos.BringtoTop = true
this.BringtoTop = false
dw_datos.ScrolltoRow(ll_find)




dw_datos.scrolltorow(1)
dw_datos.setrow(1)

is_tvcodigo   = dw_datos.Object.tv_codigo[1]
is_tvtipo       = dw_datos.Object.tv_tipo[1]
is_empresa  = dw_datos.Object.em_codigo[1]
is_sucursal   = dw_datos.Object.su_codigo[1]
is_mpcodigo = dw_datos.Object.mp_codigo[1]
is_pvcodigo  = dw_datos.Object.pv_codigo[1]


/*Recupera todos los cruces del cr$$HEX1$$e900$$ENDHEX$$dito*/
dw_c.reset()
li_reg = dw_c.retrieve(is_empresa,is_sucursal,is_tvcodigo,is_tvtipo,is_mpcodigo)

for i = 1 to li_reg
ls_nrodeb[i] = dw_c.Object.cp_cruce_mp_coddeb[i]  
next

dw_a.reset()
if li_reg > 0 then dw_a.retrieve(is_sucursal,ls_nrodeb)

/*Retenciones de IVA*/
dw_b.reset()
dw_b.retrieve(is_empresa,is_sucursal,is_mpcodigo)

/*Limpia las retenciones en LA FUENTE*/
dw_2.reset()
dw_2.retrieve(is_empresa,is_sucursal,is_mpcodigo)

dw_3.reset()
dw_3.retrieve(is_empresa,is_sucursal,is_mpcodigo,ic_iva)

dw_4.reset()
dw_op.reset()

dw_op.Retrieve(is_mpcodigo,is_pvcodigo)
if dw_op.rowcount() > 0 then
lc_op = dw_op.object.cc_otrospagos[1]
end if
dw_datos.object.st_op.text = string(lc_op,'#,##0.00')
end event

event buttonclicked;if dwo.name = 'b_1' then
		/*Refresca creditos no cruzados*/
		st_1.text = string(this.retrieve())
end if
end event

type cb_6 from commandbutton within w_compras_cxp3
integer x = 3593
integer y = 24
integer width = 398
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
boolean default = true
end type

event clicked;String ls_cofacpro,ls_ruc
Long ll_reg,ll_find


ls_cofacpro = sle_1.text
ls_ruc          = sle_2.text

dw_1.retrieve(str_appgeninfo.empresa)

if dw_1.rowcount() = 0 then 
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones ...")
	return
end if

if dw_1.bringtotop then
	dw_1.bringtotop= false
else
	dw_1.bringtotop = true
end if
end event

type dw_1 from datawindow within w_compras_cxp3
integer x = 64
integer y = 128
integer width = 6021
integer height = 1236
integer taborder = 120
boolean titlebar = true
string title = "Cr$$HEX1$$e900$$ENDHEX$$ditos"
string dataobject = "d_sri_lista_de_transacciones"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;//String ls_nrodeb[]
//Int i,li_reg
//Long ll_find
//Decimal lc_op
//
//SetRowfocusIndicator(Hand!)
//
//
//
//
//
//dw_1.scrolltorow(currentrow)
//dw_1.setrow(currentrow)
//
//is_tvcodigo  = dw_1.Object.tv_codigo[currentrow]
//is_tvtipo      = dw_1.Object.tv_tipo[currentrow]
//is_empresa = dw_1.Object.em_codigo[currentrow]
//is_sucursal   = dw_1.Object.su_codigo[currentrow]
//is_mpcodigo = dw_1.Object.mp_codigo[currentrow]
//is_pvcodigo   = dw_1.Object.pv_codigo[currentrow]
//is_cofacpro   = dw_1.Object.co_facpro[currentrow]
//
//
//ll_find = dw_datos.retrieve(str_appgeninfo.empresa,is_cofacpro,is_pvcodigo)
//
//if ll_find = 0 then
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos....")
//	return
//end if
//
//dw_datos.BringtoTop = true
//dw_datos.ScrolltoRow(ll_find)


/*Recupera todos los cruces del cr$$HEX1$$e900$$ENDHEX$$dito*/
//dw_c.reset()
//li_reg = dw_c.retrieve(is_empresa,is_sucursal,is_tvcodigo,is_tvtipo,is_mpcodigo)
//
//for i = 1 to li_reg
//ls_nrodeb[i] = dw_c.Object.cp_cruce_mp_coddeb[i]  
//next
//
//dw_a.reset()
//if li_reg > 0 then dw_a.retrieve(is_sucursal,ls_nrodeb)
//
///*Retenciones de IVA*/
//dw_b.reset()
//dw_b.retrieve(is_empresa,is_sucursal,is_mpcodigo)
//
///*Limpia las retenciones en LA FUENTE*/
//dw_2.reset()
//dw_2.retrieve(is_empresa,is_sucursal,is_mpcodigo)
//
//dw_3.reset()
//dw_3.retrieve(is_empresa,is_sucursal,is_mpcodigo,ic_iva)
//
//dw_4.reset()
//dw_op.reset()
//dw_op.reset()
//dw_op.Retrieve(is_mpcodigo,is_pvcodigo)
//if dw_op.rowcount() > 0 then
//lc_op = dw_op.object.cc_otrospagos[1]
//end if
//dw_datos.object.st_op.text = string(lc_op,'#,##0.00')
	
end event

event sqlpreview;String  sql,ls_cofacpro,ls_ruc
Date  ld_ini ,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

ls_cofacpro =sle_1.text
ls_ruc = sle_2.text

if not isnull(ld_ini) and not isnull(ld_fin) and string(ld_ini) <> '01/01/1900' and string(ld_fin) <> '01/01/1900' then
sql = sqlsyntax + " AND (TRUNC(CP_MOVIM.MP_FECHA) BETWEEN '"+string(ld_ini,'dd-mmm-yyyy') +"' and '"+string(ld_fin,'dd-mmm-yyyy')+"')"
elseif not isnull(ls_cofacpro ) and ls_cofacpro <>''  then
sql = sqlsyntax + " AND (CP_MOVIM.CO_FACPRO like '"+ls_cofacpro+"')"
else
sql = sqlsyntax + " AND (IN_PROVE.PV_RUCCI like '"+ls_ruc+"')"	
end if
dw_1.SetSqlPreview(sql)
end event

event doubleclicked;String ls_nrodeb[]
Int i,li_reg
Long ll_find
Decimal lc_op

SetRowfocusIndicator(Hand!)

//
//dw_1.scrolltorow(row)
//dw_1.setrow(row)

is_tvcodigo  = dw_1.Object.tv_codigo[row]
is_tvtipo      = dw_1.Object.tv_tipo[row]
is_empresa = dw_1.Object.em_codigo[row]
is_sucursal   = dw_1.Object.su_codigo[row]
is_mpcodigo = dw_1.Object.mp_codigo[row]
is_pvcodigo   = dw_1.Object.pv_codigo[row]
is_cofacpro   = dw_1.Object.co_facpro[row]


ll_find = dw_datos.retrieve(str_appgeninfo.empresa,is_cofacpro,is_pvcodigo,is_mpcodigo)

if ll_find = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos....")
	return
end if

dw_datos.BringtoTop = true
this.BringtoTop = false
dw_datos.ScrolltoRow(ll_find)




dw_datos.scrolltorow(1)
dw_datos.setrow(1)

is_tvcodigo   = dw_datos.Object.tv_codigo[1]
is_tvtipo       = dw_datos.Object.tv_tipo[1]
is_empresa  = dw_datos.Object.em_codigo[1]
is_sucursal   = dw_datos.Object.su_codigo[1]
is_mpcodigo = dw_datos.Object.mp_codigo[1]
is_pvcodigo  = dw_datos.Object.pv_codigo[1]


/*Recupera todos los cruces del cr$$HEX1$$e900$$ENDHEX$$dito*/
dw_c.reset()
li_reg = dw_c.retrieve(is_empresa,is_sucursal,is_tvcodigo,is_tvtipo,is_mpcodigo)

for i = 1 to li_reg
ls_nrodeb[i] = dw_c.Object.cp_cruce_mp_coddeb[i]  
next

dw_a.reset()
if li_reg > 0 then dw_a.retrieve(is_sucursal,ls_nrodeb)

/*Retenciones de IVA*/
dw_b.reset()
dw_b.retrieve(is_empresa,is_sucursal,is_mpcodigo)

/*Limpia las retenciones en LA FUENTE*/
dw_2.reset()
dw_2.retrieve(is_empresa,is_sucursal,is_mpcodigo)

dw_3.reset()
dw_3.retrieve(is_empresa,is_sucursal,is_mpcodigo,ic_iva)

dw_4.reset()
dw_op.reset()

dw_op.Retrieve(is_mpcodigo,is_pvcodigo)
if dw_op.rowcount() > 0 then
lc_op = dw_op.object.cc_otrospagos[1]
end if
dw_datos.object.st_op.text = string(lc_op,'#,##0.00')

//lc_basegrav       = dw_3.object.cc_basegrav[1]
//lc_baseimpgrav  = dw_b.object.cc_bseimp_retiva[1]
//
//
//
//if (lc_basegrav*ic_iva) <> lc_baseimpgrav then
//     st_leyenda.visible = true
//else
//	st_leyenda.visible = false
//end if
end event


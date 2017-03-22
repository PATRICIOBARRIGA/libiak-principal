HA$PBExportHeader$w_otros_pagos.srw
$PBExportComments$Si.No contabiliza
forward
global type w_otros_pagos from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_otros_pagos
end type
type dw_cruce from uo_dw_detail within w_otros_pagos
end type
type st_1 from statictext within w_otros_pagos
end type
type st_pagos from statictext within w_otros_pagos
end type
type st_4 from statictext within w_otros_pagos
end type
type st_2 from statictext within w_otros_pagos
end type
type ln_1 from line within w_otros_pagos
end type
type dw_lp from datawindow within w_otros_pagos
end type
end forward

shared variables

end variables

global type w_otros_pagos from w_sheet_master_detail
integer x = 27
integer y = 68
integer width = 5362
integer height = 2620
string title = " (**) Movimiento de D$$HEX1$$e900$$ENDHEX$$bito(CXP)"
long backcolor = 79741120
event ue_consultar pbm_custom15
dw_ubica dw_ubica
dw_cruce dw_cruce
st_1 st_1
st_pagos st_pagos
st_4 st_4
st_2 st_2
ln_1 ln_1
dw_lp dw_lp
end type
global w_otros_pagos w_otros_pagos

type variables
boolean    ib_cruzar = true,&
           ib_fallo = false
string     is_mensaje
Datetime   id_hoy
Date       id_ahora
decimal    ic_iva

end variables

forward prototypes
public function integer wf_preprint ()
public function integer wf_crea_actualiza_cuenta ()
public function integer wf_actualiza_saldo_valor (decimal ad_valor)
public function long wf_crea_debito (string as_cliente, decimal ac_saldo)
public function integer wf_recupera_pendientes ()
public function integer wf_actualiza_saldo_cupo ()
public function decimal wf_refresca_saldo ()
public function integer wf_limpia_campos (integer li_val)
end prototypes

event ue_consultar;//dw_master.postevent(DoubleClicked!)

dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

public function integer wf_preprint ();long ll_filAct
string ls_mt_numero, ls_tt_codigo, ls_valletras,ls_fp
decimal lc_valor
int li_res

ll_filAct = dw_master.getRow()
ls_mt_numero = dw_master.getItemString(ll_filAct, "mt_codigo")
ls_tt_codigo = dw_master.getItemString(ll_filAct, "tt_codigo")
//lc_valor = dw_master.getItemNumber(ll_filAct, "mt_valor")
ls_fp = dw_detail.getItemString(dw_detail.getrow(), "fp_codigo")
lc_valor = dw_detail.getItemNumber(dw_detail.getrow(), "ch_valor")
ls_valletras = f_numero_a_letras (lc_valor)
dw_report.setTransObject(sqlca)
f_recupera_empresa(dw_report,"fp_codigo") 
dw_report.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,ls_tt_codigo, ls_mt_numero,ls_fp,ls_valletras)   

return 1

end function

public function integer wf_crea_actualiza_cuenta ();///////////////////////////////////////////////////////////////////////
//	DESCRIPCI$$HEX1$$d300$$ENDHEX$$N : Crea o actualiza cada una de las cuentas del detalle
//               registrano en la tabla FA_CTACLI, el banco y la cuenta
//	FECHA DE ULTIMA REVISION : 18/02/2003
// 
///////////////////////////////////////////////////////////////////////

string ls, ls_clien, ls_rucci,ls_tipo, as_numero, as_banco, as_clien, ls_estado,ls_fp
decimal ad_valor
long li_res,ll_max, li
dwItemStatus l_status

// encuentra el estado del dw_maestro
l_status = dw_master.GetItemStatus(dw_master.GetRow(), 0, Primary!)
// encuentra el n$$HEX1$$fa00$$ENDHEX$$mero de filas del detalle
ll_max = dw_detail.rowcount()
// encuentra el c$$HEX1$$f300$$ENDHEX$$digo del cliente
as_clien = dw_master.GetItemString(dw_master.GetRow(),'ce_codigo')
//Actualiza el saldo, solo la primera vez, si es nuevo
if l_status = NewModified! then 
	if ll_max > 0 then
		// por cada fila del detalle hacer lo siguiente
		for li = 1 to ll_max
     		as_numero = trim(dw_detail.GetitemString(li,'ch_cuenta'))
     		as_banco = dw_detail.GetitemString(li,'if_codigo')
		     ad_valor	 = dw_detail.GetitemNumber(li,'ch_valor')
			ls_fp	 = dw_detail.GetitemString(li,'fp_codigo')
			If ls_fp = '1' Then
				// encuentra el c$$HEX1$$f300$$ENDHEX$$digo del cliente y el estado, dado el banco y n$$HEX1$$fa00$$ENDHEX$$mero de cuenta
				Select ce_codigo, cs_estado
				  into :ls, :ls_estado
				  from fa_ctacli
				 where if_codigo = :as_banco
					and cs_numero = :as_numero;
				// Si no existe, inserto la cuenta con estado N (Nueva)
				if sqlca.sqlcode <> 0 then
					INSERT INTO "FA_CTACLI"( "IF_CODIGO", "CS_NUMERO","CE_CODIGO","CS_VALCHE",   
													 "CS_VALPRO", "CS_NUMCHE","CS_NUMPRO","CS_ESTADO" )  
						  VALUES (:as_banco,:as_numero,:as_clien,:ad_valor,0,1,0,'N')  ;
						 
//					commit;
				else
					// Si es una cuenta pasiva, no se debe facturar
					if ls_estado = 'P' then 
						 messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La cuenta corriente tiene problemas, revise estad$$HEX1$$ed00$$ENDHEX$$sticas.')
					end if
					
					// si el cliente coincide con el due$$HEX1$$f100$$ENDHEX$$o del n$$HEX1$$fa00$$ENDHEX$$mero de la cuenta registrada
					if ls = as_clien then
						// actualiza los valores en cheques de la cuenta y el n$$HEX1$$fa00$$ENDHEX$$mero de cheque recibidos
						Update fa_ctacli
							set cs_valche = cs_valche + :ad_valor,
								 cs_numche = cs_numche + 1
						 where if_codigo = :as_banco
							and cs_numero = :as_numero;
//						commit;
					else	
						// si el cliente con el que se va ha realizar el pago no coincide 
						// con el due$$HEX1$$f100$$ENDHEX$$o de la cuenta se confirma si desea remplazarla.
						SELECT "FA_CLIEN"."CE_CODIGO"||' '||NVL("FA_CLIEN"."CE_RAZONS",'')||' / '||DECODE("FA_CLIEN"."CE_TIPO",'N',"FA_CLIEN"."CE_NOMBRE"||' '||"FA_CLIEN"."CE_APELLI","FA_CLIEN"."CE_NOMREP"||' '||"FA_CLIEN"."CE_APEREP") "cliente"
						  INTO :ls_clien
						  FROM "FA_CLIEN"  
						 WHERE "FA_CLIEN"."EM_CODIGO" = :str_appgeninfo.empresa
							AND "FA_CLIEN"."CE_CODIGO" = :ls;
						
						li_res = messageBox('Confirme por favor','Esta cuenta fue ya asignada al cliente ' + ls_clien + ' de RUC/CI ' + ls_rucci + '. Desea reemplazar ? ',Question!,YesNoCancel!)
						// actualiza el valor de los cheques y el n$$HEX1$$fa00$$ENDHEX$$mero de cheques
						// dado el banco y la cuenta
						CHOOSE CASE li_res
							CASE 1
								Update fa_ctacli
									set cs_valche = cs_valche + :ad_valor,
										 cs_numche = cs_numche + 1,
										 ce_codigo = :as_clien
								 where if_codigo = :as_banco
									and cs_numero = :as_numero;
//								commit;
							CASE 2
								Update fa_ctacli
									set cs_valche = cs_valche + :ad_valor,
										 cs_numche = cs_numche + 1
								 where if_codigo = :as_banco
									and cs_numero = :as_numero;
//									commit;
							CASE 3
								return -1
						end choose
					end if
				end if						
			  end if
			next
	  end if
	end if

return 1
end function

public function integer wf_actualiza_saldo_valor (decimal ad_valor);string ls_cliente, ls_codigo
date ld_fecha
long li, ll_max, ll_plazo, ll_fila
dwItemStatus l_status

ll_fila = dw_master.GetRow()
l_status = dw_master.GetItemStatus(ll_fila, 0, Primary!)
if l_status = NewModified! then //Actualiza el saldo, solo la primera vez
  ls_cliente = dw_master.GetItemString(ll_fila,'ce_codigo')
    UPDATE FA_CLIEN
	    SET CE_SALCRE = CE_SALCRE + :ad_valor
	  WHERE CE_CODIGO = :ls_cliente
	    AND EM_CODIGO = :str_appgeninfo.empresa;
   if sqlca.sqlcode <> 0 then
		messageBox('Error Interno', 'Funci$$HEX1$$f300$$ENDHEX$$n wf_acualiza_saldo_cupo ' +sqlca.sqlerrtext)
		return -1
	end if
//	commit;
end if
return 1
end function

public function long wf_crea_debito (string as_cliente, decimal ac_saldo);/*Retorna el N$$HEX1$$fa00$$ENDHEX$$mero de debito generado*/
Long ll_sec
String ls_sec

SELECT PR_VALOR
INTO :ll_sec
FROM  PR_PARAM
WHERE EM_CODIGO = :str_appgeninfo.empresa AND
PR_NOMBRE = 'NUM_ND'
FOR UPDATE OF PR_VALOR;

If SQLCA.SQLCODE = 0 Then
ls_sec = String(ll_sec)
End if	  

UPDATE PR_PARAM
SET PR_VALOR = PR_VALOR + 1
WHERE EM_CODIGO = :str_appgeninfo.empresa AND
PR_NOMBRE = 'NUM_ND';

If SQLCA.SQLCODE < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar el Secuencial de D$$HEX1$$e900$$ENDHEX$$bitos" +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1 
End if


INSERT INTO	  "CC_MOVIM"
("CC_MOVIM"."MT_CODIGO",   
"CC_MOVIM"."TT_CODIGO",   
"CC_MOVIM"."TT_IOE",   
"CC_MOVIM"."VE_NUMERO",   
"CC_MOVIM"."CE_CODIGO",   
"CC_MOVIM"."ES_CODIGO",   
"CC_MOVIM"."EM_CODIGO",   
"CC_MOVIM"."MT_FECHA",   
"CC_MOVIM"."SU_CODIGO",   
"CC_MOVIM"."MT_VALOR",   
"CC_MOVIM"."MT_SALDO",   
"CC_MOVIM"."MT_VALRET",   
"CC_MOVIM"."MT_CTACOR",   
"CC_MOVIM"."RF_CODIGO",   
"CC_MOVIM"."BO_CODIGO",   
"CC_MOVIM"."IG_NUMERO",   
"CC_MOVIM"."MT_VALIVA",   
"CC_MOVIM"."MT_CTACLI",   
"CC_MOVIM"."MT_NUMCH",   
"CC_MOVIM"."IF_CODIGO")
VALUES(:ls_sec,
'9',
'D',
null,
:as_cliente,
null,
:str_appgeninfo.empresa,
sysdate,
:str_appgeninfo.sucursal,
:ac_saldo,
0,
0,
null,
null,
:str_appgeninfo.seccion,
null,
0,
null,
null,
null );

If SQLCA.SQLCODE < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al INSERTAR el  Debito " +sqlca.sqlerrtext)
ROLLBACK;
RETURN -1
End if

Return ll_sec
end function

public function integer wf_recupera_pendientes ();///////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Permite recuperar los movimientos de d$$HEX1$$e900$$ENDHEX$$bito pendientes
// Fecha de $$HEX1$$fc00$$ENDHEX$$ltima revisi$$HEX1$$f300$$ENDHEX$$n : 08/04/1999   10:35
///////////////////////////////////////////////////////////////////////
datetime ld_mpfecha
long ll_filact, ll_filmas ,ll_fila,ll_co_numero
decimal lc_mp_saldo
string ls_pv_codigo, ls_tv_codigo, ls_mp_codigo
string ls_tv_coddeb, ls_mp_coddeb, ls_tv_descri,ls_cofacpro

dw_master.AcceptText()
ll_filmas = dw_master.getrow()

// encuentra el c$$HEX1$$f300$$ENDHEX$$digo del cliente, tipo de movimiento y n$$HEX1$$fa00$$ENDHEX$$mero de movimieto
// de cr$$HEX1$$e900$$ENDHEX$$dito
ls_pv_codigo = dw_master.GetItemString(ll_filmas,'pv_codigo')
ls_tv_coddeb = dw_master.GetItemString(ll_filmas,'tv_codigo')
ls_mp_coddeb = dw_master.GetItemString(ll_filmas,'mp_codigo')

DECLARE cur_cre_pendientes CURSOR FOR  
SELECT cp_movim.tv_codigo,   
       cp_movim.mp_codigo,   
       cp_movim.mp_saldo,  
       cp_tipmov.tv_dexcri,
       cp_movim.co_numero,
		 trunc(cp_movim.mp_fecha),
		 cp_movim.co_facpro
   FROM cp_movim , cp_tipmov
   WHERE ( cp_movim.tv_tipo = 'C' ) AND
			( cp_movim.mp_saldo > 0 ) AND  
			( cp_movim.em_codigo =  :str_appgeninfo.empresa ) AND  
			( cp_movim.su_codigo =  :str_appgeninfo.sucursal ) AND			
			( cp_movim.pv_codigo =  :ls_pv_codigo )   AND
			( cp_movim.tv_codigo =   cp_tipmov.tv_codigo) AND
			( cp_movim.tv_tipo   =   cp_tipmov.tv_tipo)
using sqlca;

dw_cruce.setTransObject(sqlca);
dw_cruce.Reset()
open cur_cre_pendientes;

DO WHILE True
	fetch cur_cre_pendientes into :ls_tv_codigo, 
									:ls_mp_codigo, :lc_mp_saldo,:ls_tv_descri,
									:ll_co_numero,:ld_mpfecha,:ls_cofacpro;
	if sqlca.sqlcode <> 0 then exit

	ll_fila =dw_cruce.insertRow(0)
	// registra el cruce de d$$HEX1$$e900$$ENDHEX$$bitos vs cr$$HEX1$$e900$$ENDHEX$$ditos
	dw_cruce.setItem(ll_fila, "tv_codigo", ls_tv_codigo)
	dw_cruce.setItem(ll_fila, "mp_codigo", ls_mp_codigo)
	dw_cruce.setItem(ll_fila, "tv_tipo", 'C')
	dw_cruce.setItem(ll_fila, "mp_saldo", lc_mp_saldo)
	dw_cruce.setItem(ll_fila, "tv_coddeb", ls_tv_coddeb)
	dw_cruce.setItem(ll_fila, "mp_coddeb", ls_mp_coddeb)
	dw_cruce.setItem(ll_fila, "tv_tipodeb", 'D')
	dw_cruce.setItem(ll_fila, "cx_valcre", 0)
	dw_cruce.setItem(ll_fila, "cx_valdeb", 0)
	dw_cruce.setItem(ll_fila, "tv_dexcri", ls_tv_descri)
   dw_cruce.setItem(ll_fila, "em_codigo", str_appgeninfo.empresa)
   dw_cruce.setItem(ll_fila, "su_codigo", str_appgeninfo.sucursal)	
   dw_cruce.setItem(ll_fila, "co_numero", ll_co_numero)
	dw_cruce.setitem(ll_fila, "co_facpro",ls_cofacpro)
   dw_cruce.setItemStatus(ll_fila, 0, Primary!, NotModified!)

LOOP

close cur_cre_pendientes;
return 1
end function

public function integer wf_actualiza_saldo_cupo ();////////////////////////////////////////////////////////////////////////
// DESCRIPCION: Actualiza el cupo de cr$$HEX1$$e900$$ENDHEX$$dito que tiene el cliente
// FECHA DE ULTIMA REVISION : 08/04/1999  10:50
// REVISADO POR : ING HUGO V OROZCO CH
////////////////////////////////////////////////////////////////////////

string ls_cliente, ls_codigo
decimal lc_valor = 0
date ld_fecha
long li, ll_max, ll_plazo, ll_fila
dwItemStatus l_status

ll_fila = dw_master.GetRow()
l_status = dw_master.GetItemStatus(ll_fila, 0, Primary!)

//Actualiza el saldo del cr$$HEX1$$e900$$ENDHEX$$dito del cliente, solo la primera vez

if l_status = NewModified! then 
	ls_cliente = dw_master.GetItemString(ll_fila,'ce_codigo')
  	lc_valor = dw_master.GetItemNumber(ll_fila,'mt_valor')
   UPDATE FA_CLIEN
	   SET CE_SALCRE = CE_SALCRE + :lc_valor
	 WHERE CE_CODIGO = :ls_cliente
	   AND EM_CODIGO = :str_appgeninfo.empresa;
   
	if sqlca.sqlcode <> 0 then
		messageBox('Error Interno', 'Funci$$HEX1$$f300$$ENDHEX$$n wf_acualiza_saldo_cupo ' +sqlca.sqlerrtext)
		return -1
	end if
	//commit;
end if

return 1
end function

public function decimal wf_refresca_saldo ();decimal lc_totcheques,lc_abono,lc_saldo
long ll_rowd,ll_rowc

ll_rowd = dw_detail.getrow()
if ll_rowd = 0 then return 0

ll_rowc = dw_cruce.getrow()
if ll_rowc = 0 then return 0

lc_totcheques  = dw_detail.getitemdecimal(ll_rowd,"cc_total_pago")
lc_abono = dw_cruce.getitemdecimal(ll_rowc,"cc_sumvalcre")

lc_saldo = lc_totcheques - lc_abono
return lc_saldo

end function

public function integer wf_limpia_campos (integer li_val);Date null_date
	  SetNull(null_date)
	  		dw_master.SetItem(dw_master.GetRow(),'mp_codtribu','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_tipidprv','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_tipodoc','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_docnroest','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_docnropto','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_docnrosec','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_naut','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_bseimptrf0',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_baseimp',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_bseimpice',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_reten',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_codpctiva','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_codpctice','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_valret',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_montoice',0)
         dw_master.SetItem(dw_master.GetRow(),'mp_fecemision', null_date)
		dw_master.SetItem(dw_master.GetRow(),'mp_feccaduci',null_date )  //
		dw_master.SetItem(dw_master.GetRow(),'mp_biemntiva',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_srvmntiva',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_biepctiva','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_srvpctiva','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_bievlrret',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_srvvlrret',0 )
		dw_master.SetItem(dw_master.GetRow(),'mp_modtipodoc','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_modnroest','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_modnropto','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_modnrosec','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_modfecemi',null_date)  //
		dw_master.SetItem(dw_master.GetRow(),'mp_modnaut','' )
		dw_master.SetItem(dw_master.GetRow(),'mp_docdeviva','' )
return 1
end function

on w_otros_pagos.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.dw_cruce=create dw_cruce
this.st_1=create st_1
this.st_pagos=create st_pagos
this.st_4=create st_4
this.st_2=create st_2
this.ln_1=create ln_1
this.dw_lp=create dw_lp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.dw_cruce
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_pagos
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.ln_1
this.Control[iCurrent+8]=this.dw_lp
end on

on w_otros_pagos.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.dw_cruce)
destroy(this.st_1)
destroy(this.st_pagos)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.ln_1)
destroy(this.dw_lp)
end on

event open;call super::open;///////////////////////////////////////////////////////////////////////
//	DESCRIPCI$$HEX1$$d300$$ENDHEX$$N : Cuando se abre la ventana, se recupera los drop y luego
//               se recupera para el campo "mt_codigo", el secuencial
// de pr_param con pr_nombre = "CRE_CXC".
//	FECHA DE ULTIMA REVISION : 16/01/2003  12:15
/////////////////////////////////////////////////////////////////////////

string            ls_parametro[]
long   ll_reg
DataWindowChild   ldwc_aux,dwc,ldwc_ctabco


//



f_recupera_empresa(dw_master,"tv_codigo") 
f_recupera_empresa(dw_master,"pv_codigo")




// recupera las cuentas corrientes de la empresa y sucursal conectada
dw_detail.GetChild("fp_codigo",dwc)
dwc.SetTransObject(SQLCA)
dwc.Retrieve(str_appgeninfo.empresa)
dwc.SetFilter("fp_string Like '%P%'")
dwc.Filter()

dw_detail.Getchild("cn_codigo",ldwc_ctabco)
ldwc_ctabco.settransobject(sqlca)
ldwc_ctabco.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)


f_recupera_empresa(dw_detail,"if_codigo")
f_recupera_empresa(dw_ubica,"proveedor")

//Lista de pagos
dw_lp.SetTransObject(sqlca)
ll_reg = dw_lp.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal )
st_pagos.text = string(ll_reg ) 

istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal

call super::open

// datos para recuperar el secuencial del movimiento
//dw_master.is_SerialCodeColumn = "mp_codigo"
//dw_master.is_SerialCodeType = "DEB_CXP"
//dw_master.is_serialCodeCompany = str_appgeninfo.empresa

// columnas de conecci$$HEX1$$f300$$ENDHEX$$n
dw_master.ii_nrCols = 5
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "tv_codigo"
dw_master.is_connectionCols[4] = "tv_tipo"
dw_master.is_connectionCols[5] = "mp_codigo"

dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "tv_codigo"
dw_detail.is_connectionCols[4] = "tv_tipo"
dw_detail.is_connectionCols[5] = "mp_codigo"
dw_detail.uf_setArgTypes()


//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()
//ib_detalle_pago = false
//dw_detalle_pago.Reset()

dw_master.uf_insertCurrentRow()
dw_master.setFocus()


Date ld_fefec,ld_ahora
Datetime ld_hoy
Long i

SELECT TRUNC( SYSDATE)
INTO :id_hoy
FROM DUAL;
id_ahora = Date(id_hoy)
dw_master.SetTabOrder("pv_codigo",10)

ic_iva = f_iva()


end event

event ue_update;//////////////////////////////////////////////////////////////////////////////
//	DESCRIPCI$$HEX1$$d300$$ENDHEX$$N : Graba los cr$$HEX1$$e900$$ENDHEX$$ditos de los clientes
//	FECHA DE ULTIMA REVISION : 04/02/2003 
//////////////////////////////////////////////////////////////////////////////


Long    ll_row
Int     rc
int     li,max
long    ll_filact 
dec{2}  lc_saldo,lc_valor,lc_iva,lc_valret
string  ls_tvcoddeb,ls_tvtipodeb,ls_mpcoddeb, ls_fpcodigo, ls_prueba
dwitemstatus  l_status




If dw_master.AcceptText() <> 1 then return
If dw_detail.AcceptText() <> 1 then return
If dw_cruce.AcceptText()  <> 1 then return  

ll_filact = dw_master.GetRow()
ll_row = dw_cruce.GetRow()

//CAMPOS OBLIGATORIOS ENCASO DE SER NC
ls_fpcodigo = dw_detail.GetItemString(dw_detail.GetRow(),'fp_codigo')
if ls_fpcodigo = '49' or ls_fpcodigo = '50' or ls_fpcodigo = '60' or ls_fpcodigo = '101' then 
		if isnull(dw_master.GetItemDateTime(ll_filact,'mp_feccaduci'))  then
			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese campo obligatorio <Fecha de Caducidad>')
			return
		end if
		if isnull(dw_master.GetItemString(ll_filact,'mp_modnaut'))  then
			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese campo obligatorio <N$$HEX2$$ba002000$$ENDHEX$$Autorizaci$$HEX1$$f300$$ENDHEX$$n de Factura.>')
			return
		end if
		if isnull(dw_master.GetItemDateTime(ll_filact,'mp_modfecemi')) then
			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese campo obligatorio <Fecha de Emisi$$HEX1$$f300$$ENDHEX$$n>')
			return
		end if
	if isnull(dw_master.GetItemString(ll_filact,'mp_modnroest')) then
			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese campo obligatorio <N$$HEX2$$ba002000$$ENDHEX$$Comprobante Modificado 3 digitos primeros>')
			return
	end if		
	if isnull(dw_master.GetItemString(ll_filact,'mp_modnropto')) then
			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese campo obligatorio <N$$HEX2$$ba002000$$ENDHEX$$Comprobante Modificado 3 digitos segundos>')
			return
	end if
	if isnull(dw_master.GetItemString(ll_filact,'mp_modnrosec')) then
			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese campo obligatorio <N$$HEX2$$ba002000$$ENDHEX$$Comprobante Modificado 7 digitos terceros>')
			return
	end if

end if


lc_saldo = round(dw_master.GetItemDecimal(ll_filact,"mp_saldo"),2)

if lc_saldo < 0 &
then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ha cancelado un valor superior al pago~n~r"+&
           "El D$$HEX1$$e900$$ENDHEX$$bito no se registrar$$HEX1$$e100$$ENDHEX$$",Exclamation!)	
return			  
end if	


if lc_saldo > 0 &
then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Existe un saldo pendiente de cruce~n~r"+&
           "Si no existen m$$HEX1$$e100$$ENDHEX$$s movimientos de Cr$$HEX1$$e900$$ENDHEX$$dito debe crear uno por Anticipo")	
return			  
end if	

/*Calcula el iva del mov de debito*/
l_status = dw_master.GetItemStatus(ll_filact,0,Primary!)
if l_status = new! or l_status  = newmodified! then
ls_mpcoddeb = string(f_secuencial(str_appgeninfo.empresa,"DEB_CXP"))	
dw_master.setitem(ll_filact,"mp_codigo",ls_mpcoddeb)
lc_valor  = dw_master.GetItemDecimal(ll_filact,"mp_valor")
lc_valret = (lc_valor/(1 + ic_iva))*ic_iva
dw_master.setitem(ll_filact,"mp_valret",lc_valret)
end if

rc = dw_master.Update(TRUE,FALSE)
IF rc = 1 THEN
        ls_mpcoddeb   =  dw_master.GetItemString(ll_filact,"mp_codigo")
        ls_tvcoddeb   =  dw_master.GetItemString(ll_filact,"tv_codigo")
        ls_tvtipodeb  =  dw_master.GetItemString(ll_filact,"tv_tipo")

	   for li = 1 to dw_detail.RowCount()
		dw_detail.SetItem(li,'pm_secuencia',li)
		dw_detail.SetItem(li,'em_codigo',str_appgeninfo.empresa)
		dw_detail.SetItem(li,'su_codigo',str_appgeninfo.sucursal)
		dw_detail.SetItem(li,'mp_codigo',ls_mpcoddeb)
		dw_detail.SetItem(li,'tv_codigo',ls_tvcoddeb)
	     dw_detail.SetItem(li,'tv_tipo',ls_tvtipodeb)
  	   next 
	   rc = dw_detail.Update(TRUE, FALSE)
	   If rc = 1 Then
			/**/
			for li = 1 to dw_cruce.RowCount()
			    lc_valor = dw_cruce.GetItemNumber(li,'cx_valcre')  
        	          if lc_valor > 0 then
				dw_cruce.setItem(li,"tv_coddeb", ls_tvcoddeb)
				dw_cruce.setItem(li,"mp_coddeb", ls_mpcoddeb)
				dw_cruce.setItem(li,"cx_fecha",id_hoy)
			     else
				dw_cruce.SetItemStatus(li,0, Primary!,NotModified!)
			     end if
			next
			
		     rc = dw_cruce.Update(TRUE,FALSE)
			IF rc = 1 Then
					 dw_master.ResetUpdate() // Both updates are OK
					 dw_detail.ResetUpdate()// Clear update flags
					 dw_cruce.ResetUpdate()
					 /*Actualiza saldos*/
					 If dw_cruce.Triggerevent('ue_guardar') < 1 then
					 Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar saldos" +sqlca.sqlerrtext)	
					 Rollback;
					 Return
				      end if	
			Else
			ROLLBACK ; // 2nd update failed
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al cruzar el d$$HEX1$$e900$$ENDHEX$$bito" +sqlca.sqlerrtext)	
			Return
	   	     END IF
  	    Else
	    Rollback;		
 	    Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar el d$$HEX1$$e900$$ENDHEX$$bito" +sqlca.sqlerrtext)	
	    Return
	    End if	
Else		
Rollback;
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al grabar el d$$HEX1$$e900$$ENDHEX$$bito" +sqlca.sqlerrtext)	
Return
END IF

COMMIT;
/*Ver detalle de cruce*/
wf_recupera_pendientes()


end event

event ue_insert;long ll_filact
graphicObject lgo_curObject

ll_filact = dw_master.GetRow()
if ll_filact > 0 and not isnull(ll_filact) then
	lgo_curObject = getFocus()
	if lower(lgo_curObject.className()) = "dw_detail" and &
		dw_master.GetItemString(ll_filact,'tv_codigo') <> '2' then //Pago no es con cheque
		beep(1)
	  return
	end if
end if
call super::ue_insert

end event

event activate;call super::activate;
//m_marco.m_edicion.m_consultar1.enabled = TRUE
//m_marco.m_edicion.m_consultar1.visible = TRUE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = TRUE
end event

event close;call super::close;
//m_marco.m_edicion.m_consultar1.enabled = FALSE
//m_marco.m_edicion.m_consultar1.visible = FALSE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = FALSE
end event

event deactivate;
//m_marco.m_edicion.m_consultar1.enabled = FALSE
//m_marco.m_edicion.m_consultar1.visible = FALSE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = FALSE
end event

event resize;/*Redimensionar los datawindows cuando la ventana se redimensiona*/

int li_width, li_height,li_wdetail, li_wcruce, li_df,  li_hm,li_hd
//
li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()
//
li_hm = dw_master.height
//
//li_wdetail = dw_detail.width
li_hd = dw_detail.height
li_wcruce = dw_cruce.width
//
//li_df = li_width - (li_wdetail + li_wcruce)
//
//dw_detail.resize(li_wdetail,   li_height - li_hm)
dw_cruce.resize(li_wcruce, li_height - (li_hm + li_hd + 400))
//
//this.setRedraw(False)
//if this.ib_inReportMode then
//   dw_report.resize(this.workSpaceWidth() - 2*dw_report.x, this.workSpaceHeight() - 2*dw_report.y)
//end if
//this.setRedraw(True)
//return 1
end event

event ue_retrieve;//string ls_nomcli,ls_proveedor
//
//If dw_master.rowcount() = 0 Then return
//ls_proveedor = dw_master.getitemstring(1,"pv_codigo")
//select ltrim(decode(pv_razons,null,pv_nombre||'  '||pv_apelli,pv_razons||' '||pv_nomrep||' '||pv_aperep))
//into :ls_nomcli
//from in_prove
//where em_codigo = :str_appgeninfo.empresa
//and pv_codigo = :ls_proveedor;
//dw_master.modify(" st_nombre.text ='"+ls_nomcli+"'")
//wf_recupera_pendientes()
//dw_master.enabled = true
//dw_detail.enabled = true
end event

event ue_print;dwItemStatus   lst_estado
integer li_rc
long ll_curRowMaster
w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then
	openwithparm(w_dw_print_options,dw_report)
	li_rc = message.DoubleParm
	if li_rc = 1 then	
	  if dw_report.print() = 1 then
		if this.wf_postPrint() = 1 then
			this.setRedraw(False)
			dw_report.enabled = False
			dw_report.visible = False
			dw_master.enabled = True
			dw_master.visible = True
			dw_detail.enabled = True
			dw_detail.visible = True
			this.ib_inReportMode = False
			this.triggerEvent(resize!)		// so the master and detail get the correct size
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_outof_report_mode()
			//this.triggerEvent('ue_outedition')
		end if
	end if
   end if
else
	ll_curRowMaster = dw_master.getRow()
	if ll_curRowMaster < 1 then
		beep(1)
		return
	end if
	lst_estado = dw_master.GetItemStatus(dw_master.GetRow(),0,Primary!)
	if lst_estado = NewModified! then 
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Primero debe digitar F5 antes de imprimir")
		return
	end if
	if dw_master.uf_updateCommit(ll_curRowMaster, False) = 1 then
		if this.wf_prePrint() = 1 then
			this.setRedraw(False)
			dw_report.modify("datawindow.print.preview.zoom=75~t" + &
								  "datawindow.print.preview=yes")
			dw_master.enabled = False
			dw_master.visible = False
			dw_detail.enabled = False
			dw_detail.visible = False
			dw_report.enabled = True
			dw_report.visible = True
			this.ib_inReportMode = True
			this.triggerEvent(resize!)		// so the report gets the correct size
			lw_frame = this.parentWindow()
			lm_frame = lw_frame.menuid
			lm_frame.mf_into_report_mode()
		end if
	end if
end if
end event

event closequery;return
end event

event ue_filter;graphicObject lgo_curObject
uo_dw_basic ludw_basic
String ls_classname
Long ll_curRow

lgo_curObject = getFocus()
If isvalid(lgo_curObject) = false  then 
return -1
end if

if lgo_curObject.typeof() <> DataWindow! then
beep(1)
return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_filter()

if ludw_basic.classname() = 'dw_master' then
	wf_recupera_pendientes()	
	ll_curRow = dw_master.getRow()
	if ll_curRow > 0 then
		dw_detail.uf_retrieve(ll_curRow)
	else
		dw_detail.reset()
	end if
end if
return 1

end event

event ue_nextrow;call super::ue_nextrow;dw_master.enabled = true
dw_detail.enabled = true
end event

event ue_lastrow;call super::ue_lastrow;dw_master.enabled = true
dw_detail.enabled = true
end event

event ue_firstrow;call super::ue_firstrow;dw_master.enabled = true
dw_detail.enabled = true
end event

event ue_priorrow;call super::ue_priorrow;dw_master.enabled = true
dw_detail.enabled = true
end event

type dw_master from w_sheet_master_detail`dw_master within w_otros_pagos
event ue_dwnkey pbm_dwnkey
event ue_nextfield pbm_dwnprocessenter
integer x = 0
integer y = 80
integer width = 5326
integer height = 188
integer taborder = 10
string dataobject = "d_cancelacion_cpmovim"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_master::ue_dwnkey;dwitemStatus l_status


l_status =  This.GetItemStatus(This.GetRow(),0,Primary!)
If ( (Key = Keyenter! or Key = KeyTab! ) and & 
    (l_status = Newmodified! or l_status = new!) and &
	GetcolumnName() = "pv_codigo" ) &
Then
dw_detail.InsertRow(0)
dw_detail.Triggerevent("ue_postinsert")
dw_detail.SetFocus()
End if
Return 0

end event

event dw_master::itemchanged;////////////////////////////////////////////////////////////////////////
// DESCRIPCION: Realiza ciertos c$$HEX1$$e100$$ENDHEX$$lculos dependiendo del campo en el
//              que se encuentra.
// FECHA DE ULTIMA REVISION : 13/07/2000
// ////////////////////////////////////////////////////////////////////////

string ls,ls_pvcodigo,ls_nomcli, ls_mpcodpct
double ld_mpbaseimp


This.AcceptText()
CHOOSE CASE This.GetColumnName()
case 'pv_codigo'
     
	// con el c$$HEX1$$f300$$ENDHEX$$digo del cliente buscar la firma
	select pv_codigo,ltrim(decode(pv_razons,null,pv_nombre||'  '||pv_apelli,pv_razons||' '||pv_nomrep||' '||pv_aperep))
	into :ls_pvcodigo,:ls_nomcli
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
	and pv_codigo = :data;
	
	If isnull(ls_pvcodigo) or ls_pvcodigo = "" Then
   	is_mensaje ='Proveedor no registrado'
	return 1
	End if  
	this.SetItem(row,"em_codigo",str_appgeninfo.empresa)
	this.SetItem(row,"su_codigo",str_appgeninfo.sucursal)
	wf_recupera_pendientes()	
case 'mp_valor'
	 
//case  'mp_baseimp', 'mp_codpctiva'
//		if long(data) > 0 then
//
//			ld_mpbaseimp = dw_master.GetItemNumber(row,'mp_baseimp')
//			ls_mpcodpct = dw_master.GetItemString(row,'mp_codpctiva')
//			
//			if ls_mpcodpct = '1' then dw_master.SetItem(row,'mp_valret',ld_mpbaseimp * 0.1)
//			if ls_mpcodpct = '2' then dw_master.SetItem(row,'mp_valret',ld_mpbaseimp * 0.12)
//			if ls_mpcodpct = '3' then dw_master.SetItem(row,'mp_valret',ld_mpbaseimp * 0.14)
//		else
//			dw_master.setItem(row,'mp_valret',0)
//		end if
case 'mp_bseimpice', 'mp_codpctice'
	if long(data) > 0 then
			ld_mpbaseimp = dw_master.GetItemNumber(row,'mp_bseimpice')
			ls_mpcodpct = dw_master.GetItemString(row,'mp_codpctice')
			
			if ls_mpcodpct = '8' then dw_master.SetItem(row,'mp_montoice',ld_mpbaseimp * 0.15)
		else
			dw_master.setItem(row,'mp_montoice',0)
		end if
		
case 'mp_biepctiva'
	this.object.mp_bievlrret[row] = this.object.cc_bievlrret[row]

case 'mp_srvpctiva' 
	this.object.mp_srvvlrret[row] = this.object.cc_srvvlrret[row]
	// controla que el valor del pago (cr$$HEX1$$e900$$ENDHEX$$dito) no sea negativo
	// 	if  dec(this.GetText()) < 0 then
	//   	messageBox ("Error", "El valor no puede ser negativo")
	//		this.ib_inErrorCascade = True
	//   	return 1
	//	end if

	//	//asigna el saldo igual al valor del cr$$HEX1$$e900$$ENDHEX$$dito
	//	this.SetItem(ll_filact,"mt_saldo",dec(this.GetText()))
	
	// si es pago con cheque insertamos el detalle
	// si es efectivo, no hace falta detalle	
	//	if dw_master.GetItemString(ll_filact,'tt_codigo') = '5' then
	//		dw_detail.SetFocus()
	//		dw_detail.InsertRow(0)
	//		dw_detail.SetColumn('if_codigo')
	//	end if

	
End choose
	

end event

event dw_master::clicked;//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = true
str_cliparam.ventana = parent
str_cliparam.datawindow = dw_master
str_cliparam.fila = this.GetRow() 
end event

event dw_master::doubleclicked;call super::doubleclicked;//dw_master.SetFilter('')
//dw_master.Filter()
//dw_ubica.Reset()
//dw_ubica.InsertRow(0)
//dw_ubica.SetFocus()
//dw_ubica.Visible = true
end event

event dw_master::itemerror;//messageBox('Error',is_mensaje)
return 1
end event

event dw_master::rowfocuschanged;call super::rowfocuschanged;string ls_nomcli,ls_proveedor

ls_proveedor = this.getitemstring(currentrow,"pv_codigo")

select ltrim(decode(pv_razons,null,pv_nombre||'  '||pv_apelli,pv_razons||' '||pv_nomrep||' '||pv_aperep))
into :ls_nomcli
from in_prove
where em_codigo = :str_appgeninfo.empresa
and pv_codigo = :ls_proveedor;
this.modify("st_nombre.text='"+ls_nomcli+"'")


wf_recupera_pendientes()
return 0
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_otros_pagos
event ue_nextfield pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
integer x = 0
integer y = 352
integer width = 5330
integer height = 384
integer taborder = 20
string title = "Recepci$$HEX1$$f300$$ENDHEX$$n de Pago"
string dataobject = "d_pagos"
boolean hscrollbar = false
boolean livescroll = false
end type

event dw_detail::ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event

event dw_detail::ue_dwnkey;Long ll_row
dwitemStatus l_status

l_status =  This.GetItemStatus(This.GetRow(),0,Primary!)
If ( Key = Keyenter! and l_status = Newmodified! ) and GetcolumnName() = "pm_fecpa" & 
Then
If  ib_fallo<> false Then 
ll_row  = dw_detail.InsertRow(0)
This.SetItem(ll_row,"pm_fecpa",relativedate(id_ahora,1))
ib_fallo = false
End if
End if
Return 0
end event

event dw_detail::itemchanged;//////////////////////////////////////////////////////////////////////
// DESCRIPCION : Controla que no sea la fecha menor que la actual
// FECHA DE ULTIMA REVISION : 07/04/1999  12:07
// REVISADO POR : 
//////////////////////////////////////////////////////////////////////
decimal lc_valor,lc_valret,lc_valiva,lc_total,lc,lc_saldo
long ll_filact
String ls,ls_codigo
date  ld_hoy,ld_fefec, null_date

ll_filact = this.GetRow()

This.Accepttext()
// Controla que la fecha de vencimiento no sea menor que la actual
If dwo.name = 'pm_fecpa' Then
      ld_hoy      =  date(string(today(),'dd/mm/yyyy'))
		ls =  left(gettext(),10)
		ld_fefec    =  date(ls)
		if  ld_fefec < ld_hoy then
			messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La fecha de Vencimiento debe ser mayor a la fecha de hoy ('+string(today(),'dd/mm/yyyy')+')')
			this.ib_inErrorCascade = true
			ib_fallo = true
		end if
end if

If dwo.name = 'pm_valor'	Then
	   lc_valor = This.getItemNumber(this.getrow(),"cc_total_pago")
//		lc_valret = dw_master.GetItemNumber(dw_master.getrow(),'mp_valret')
//		lc_valiva = dw_master.GetItemNumber(dw_master.getrow(),'mp_valiva')
		lc_total = lc_valor + lc_valret + lc_valiva
		dw_master.Setitem(dw_master.Getrow(),"mp_valor",lc_total) 
		lc_saldo = wf_refresca_saldo()
	   dw_master.Setitem(dw_master.Getrow(),"mp_saldo",lc_saldo) 
end if

/*PARA MAXIMIZAR VENTANA EN CASO DE SER NOTA DE CREDITO*/
If dwo.name = 'fp_codigo'	Then
	if data = '49' or data = '50' or data = '60' or data = '101'  then
		dw_master.SetItem(dw_master.GetRow(),'mp_codtribu','06' ) 
		dw_master.SetItem(dw_master.GetRow(),'mp_tipidprv','01' )
		dw_master.SetItem(dw_master.GetRow(),'mp_modtipodoc','1' )
		dw_master.SetItem(dw_master.GetRow(),'mp_codpctiva','2' )
		dw_master.SetItem(dw_master.GetRow(),'mp_docdeviva','N' )
		dw_master.SetItem(dw_master.GetRow(),'mp_tipodoc','4' )
		//Maximiza SRI NC
		//si esta abierto  no volver a abrir
		if dw_master.Height <> 868  then 
			long i[] = {288,796,728,352,292,188,10}, j
				 for j = 1 to 676  STEP 10
					i[6] = i[6] + i[7]
					dw_master.Height = i[6] 
					i[5] = i[5] + i[7]
					st_1.y = i[5] 
					i[4] = i[4] + i[7]
					dw_detail.Y = i[4]
					i[3] = i[3] + i[7]
					st_2.y = i[3] 
					i[2] = i[2] + i[7]
					dw_cruce.Y = i[2]
					i[1] = i[1] + i[7]
					ln_1.Beginy = i[1]
					ln_1.Endy = i[1]
			next
			dw_cruce.Height = 1096 
		end if
	else 
		wf_limpia_campos(1)
		//si ya esta cerrado ya no volver a cerrar
		if dw_master.Height <> 188  then 
			//Minimiza SRI NC
			i[] = {964,1472,1404,1028,968,868,10}
				 for j = 1 to 676  STEP 10
					i[6] = i[6] - i[7]
					dw_master.Height = i[6] 
					i[5] = i[5] - i[7]
					st_1.y = i[5] 
					i[4] = i[4] - i[7]
					dw_detail.Y = i[4]
					i[3] = i[3] - i[7]
					st_2.y = i[3] 
					i[2] = i[2] - i[7]
					dw_cruce.Y = i[2]
					i[1] = i[1] - i[7]
					ln_1.Beginy = i[1]
					ln_1.Endy = i[1]
			next
			dw_cruce.Height = 1764
		end if
	end if
end if

Choose case dw_detail.getItemString(dw_detail.getrow(),"fp_codigo")
	case '49','50','60','101'
		Choose Case string(dwo.name)
			Case 'pm_preimp'
				dw_master.SetItem(dw_master.GetRow(),'mp_docnroest',Mid(data, 1, 3))
				dw_master.SetItem(dw_master.GetRow(),'mp_docnropto',Mid(data, 4, 3))
				dw_master.SetItem(dw_master.GetRow(),'mp_docnrosec',Mid(data, 7, 7))
			Case 'pm_naut'
				dw_master.SetItem(dw_master.GetRow(),'mp_naut',data)		
			Case 'pm_emision'
				dw_master.SetItem(dw_master.GetRow(),'mp_fecemision',date(data))
		end choose
end choose

//If dwo.name = 'pm_numdoc'	Then
//		ls = this.GetText()
//		ls_codigo = this.GetItemString(ll_filact,'fp_codigo',primary!,false)		
//		lc = this.GetItemNumber(ll_filact,'ch_valor')		
//		If ls_codigo = '2' then // 2 es NOTA DE CREDITO
//		   Select ve_valotros
//		   into :lc_valor
//		   from fa_venta
//		   where es_codigo = '10'
//		   and em_codigo = :str_appgeninfo.empresa
//		   and su_codigo = :str_appgeninfo.sucursal
//		   and bo_codigo = :str_appgeninfo.seccion			
//             and ve_numero = :ls; 
//		    If sqlca.sqlcode <> 0 then
//			    messageBox('Error','No existe la N/C, verifique informaci$$HEX1$$f300$$ENDHEX$$n')
//			    return
//			End if
//         If  lc > lc_valor then
//			    messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La Nota de Cr$$HEX1$$e900$$ENDHEX$$dito solo tiene un saldo de '+string(lc_valor, "#,##0.00"))
//				this.SetItem(ll_filact,'rp_valor',lc_valor)
//			End if
//		End if	
//End if
end event

event dw_detail::updatestart;call super::updatestart;///*Validar que la fecha de Vencimiento no sea menor a Sysdate */
//Date ld_fefec
//Long i
//
//This.AcceptText()
//For i = 1 to This.Rowcount()
//	ld_fefec       = Date(This.GetItemDateTime(i,"pm_fecpa"))
//	If ld_fefec <  id_ahora &
//	Then
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha de Vencimiento debe ser posterior a la de hoy~r~n" +&
//	                        "Por favor verifique en RECEPCION DE PAGO fila:' "+String(i)+"' ",Exclamation!)
//	Return 1							  
//   End if
//Next	
Return 0
end event

event dw_detail::ue_postinsert;Long ll_row 


ll_row = This.GetRow()
This.SetItem(ll_row,"pm_fecpa",id_ahora)
Return 0
end event

event dw_detail::ue_postdelete;call super::ue_postdelete;/*Actualizar el valor de Pago y el saldo*/
decimal{2} lc_pago,lc_saldo
long       ll_row,ll_rowm

ll_row = this.getrow()
ll_rowm = dw_master.getrow()

if ll_row = 0 then 
	dw_master.setitem(ll_rowm,'mp_valor',0)
	dw_master.setitem(ll_rowm,'mp_saldo',0)
	wf_recupera_pendientes()
	return
end if

lc_pago = this.getitemdecimal(ll_row,"cc_total_pago")
lc_saldo = wf_refresca_saldo()

if lc_saldo <= 0 then 
	/*Recalcula el nuevo saldo*/
	wf_recupera_pendientes()
	lc_saldo = wf_refresca_saldo()
end if	

dw_master.setitem(ll_rowm,'mp_valor',lc_pago)
dw_master.setitem(ll_rowm,'mp_saldo',lc_saldo)


end event

event dw_detail::itemfocuschanged;call super::itemfocuschanged;string ls_fpcodigo

ls_fpcodigo = dw_detail.GetItemString(row,'fp_codigo')

if ls_fpcodigo = '49' or ls_fpcodigo = '50' or ls_fpcodigo = '60' or ls_fpcodigo = '101' then 
		//si ya esta abierto ya no volver a abrir
				dw_master.SetItem(dw_master.GetRow(),'mp_docnroest',Mid(this.GetItemstring(row,'pm_preimp'), 1, 3))
				dw_master.SetItem(dw_master.GetRow(),'mp_docnropto',Mid(this.GetItemstring(row,'pm_preimp'), 4, 3))
				dw_master.SetItem(dw_master.GetRow(),'mp_docnrosec',Mid(this.GetItemstring(row,'pm_preimp'), 7, 7))
				dw_master.SetItem(dw_master.GetRow(),'mp_naut',this.GetItemstring(row,'pm_naut'))		
				dw_master.SetItem(dw_master.GetRow(),'mp_fecemision',date(this.GetItemdatetime(row,'pm_emision')))
				dw_master.SetItem(dw_master.GetRow(),'mp_codtribu','06' ) 
				dw_master.SetItem(dw_master.GetRow(),'mp_tipidprv','01' )
				dw_master.SetItem(dw_master.GetRow(),'mp_modtipodoc','1' )
				dw_master.SetItem(dw_master.GetRow(),'mp_codpctiva','2' )
				dw_master.SetItem(dw_master.GetRow(),'mp_docdeviva','N' )
				dw_master.SetItem(dw_master.GetRow(),'mp_tipodoc','4' )
	if dw_master.Height <> 868  then 
			long i[] = {288,796,728,352,292,188,10}, j
				 for j = 1 to 676  STEP 10
					i[6] = i[6] + i[7]
					dw_master.Height = i[6] 
					i[5] = i[5] + i[7]
					st_1.y = i[5] 
					i[4] = i[4] + i[7]
					dw_detail.Y = i[4]
					i[3] = i[3] + i[7]
					st_2.y = i[3] 
					i[2] = i[2] + i[7]
					dw_cruce.Y = i[2]
					i[1] = i[1] + i[7]
					ln_1.Beginy = i[1]
					ln_1.Endy = i[1]
			next
			dw_cruce.Height = 1096 
		end if
	else 
		if not isnull(ls_fpcodigo)  then
			//si ya esta cerrado ya no volver a cerrar
			if dw_master.Height <> 188  then 
			//Minimiza SRI NC
					i[] = {964,1472,1404,1028,968,868,10}
					 for j = 1 to 676  STEP 10
						i[6] = i[6] - i[7]
						dw_master.Height = i[6] 
						i[5] = i[5] - i[7]
						st_1.y = i[5] 
						i[4] = i[4] - i[7]
						dw_detail.Y = i[4]
						i[3] = i[3] - i[7]
						st_2.y = i[3] 
						i[2] = i[2] - i[7]
						dw_cruce.Y = i[2]
						i[1] = i[1] - i[7]
						ln_1.Beginy = i[1]
						ln_1.Endy = i[1]
				next
				dw_cruce.Height = 1764
			end if
		end if
end if



end event

type dw_report from w_sheet_master_detail`dw_report within w_otros_pagos
integer x = 0
integer y = 112
integer height = 392
integer taborder = 0
string dataobject = "d_nc_cxc_preimpresa"
end type

event dw_report::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_ubica from datawindow within w_otros_pagos
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 2414
integer y = 1340
integer width = 1737
integer height = 344
integer taborder = 40
boolean titlebar = true
string title = "Buscar Registro"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_dwnkey;if keyDown(KeyEscape!) then
dw_ubica.Visible = false
dw_cruce.SetFocus()
end if
end event

event itemchanged;Long ll_found,ll_rows
string ls_numero
ll_rows = dw_cruce.rowcount()

ls_numero = data

ll_found = dw_cruce.find("co_facpro = '"+ls_numero+"'",1,ll_rows)
if ll_found > 0 and not isnull(ll_found) then
	dw_cruce.ScrollToRow(ll_found)
	dw_cruce.SetRow(ll_found)
	dw_cruce.SetFocus()	
end if
end event

type dw_cruce from uo_dw_detail within w_otros_pagos
event ue_guardar pbm_custom30
event ue_keydown pbm_dwnkey
event ue_tabout pbm_dwntabout
integer y = 736
integer width = 5330
integer height = 1764
integer taborder = 30
string title = "Cruzar Movimiento"
string dataobject = "d_cruce_cxp"
boolean hsplitscroll = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event ue_guardar;///////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Actualizo el Saldo del d$$HEX1$$e900$$ENDHEX$$bito en CC_MOVIM, por cada
//               fila del detalle de pago.
// de la cabecera
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 05/03/2003 16:07
///////////////////////////////////////////////////////////////////

int     li,ll_max
string  ls_mp_codigo,ls_tv_codigo,ls_pv_codigo
decimal lc_valor
long    ll_row

 
ll_row = dw_master.getrow()
This.AcceptText()

ll_max     = This.RowCount()

for li = 1 to ll_max
	// encuentra el valor del cruce
	lc_valor = This.Object.cx_valcre[li]

	//Actualizo el Saldo del cr$$HEX1$$e900$$ENDHEX$$dito en CP_MOVIM
	if lc_valor > 0 then
		ls_tv_codigo = This.Object.tv_codigo[li]
	     ls_mp_codigo = This.Object.mp_codigo[li]
		ls_pv_codigo = dw_master.Object.pv_codigo[ll_row]

		update cp_movim
		set mp_saldo = mp_saldo - :lc_valor
		where tv_codigo = :ls_tv_codigo
		and tv_tipo = 'C'
		and em_codigo = :str_appgeninfo.empresa
		and su_codigo   = :str_appgeninfo.sucursal
		and mp_codigo  = :ls_mp_codigo
		and pv_codigo    = :ls_pv_codigo;
				
		if sqlca.sqlcode <> 0  or  sqlca.sqlnrows < 1 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el saldo del cr$$HEX1$$e900$$ENDHEX$$dito" +sqlca.sqlerrtext) 
			rollback;
			return -1
		end if	
	end if
next

return 1
end event

event ue_keydown;///////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Cuando presiona control + Enter asigna automaticamente
//               a la fila del detalle lo que pueda cubrir con el saldo
// de la cabecera
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 08/04/1999  11:39
///////////////////////////////////////////////////////////////////

long ll_filact, ll_filmas
decimal lc_saldo, lc_valor,lc_pago


This.AcceptText()
ll_filact = this.Getrow()
ll_filmas = dw_master.Getrow()


if (KeyDown(KeyControl!)) and (KeyDown(KeyEnter!)) then
// encuentra el saldo del maestro y el saldo de la fila actual del detalle
	ll_filact = this.GetRow()
	lc_pago   = dw_master.getitemdecimal(ll_filmas,'mp_valor') 
   lc_saldo  = dw_master.getitemdecimal(ll_filmas,'mp_saldo')
	lc_valor  = this.GetItemNumber(ll_filact,"mp_saldo")
	// si el saldo de restar el maestro del detalle es negativo
	// asigno en el valora pagar solo lo del maestro y en el maestro
	// asigno cero de salo
	if lc_saldo = 0 then return
	if lc_saldo < lc_valor  then
   	this.SetItem(ll_filact,"cx_valcre", dw_master.GetItemNumber(ll_filmas,'mp_saldo')) 
 	else
	// si el saldo de la resta es positivo asigno todo el valor del
	// detalle al pago y en el maestro asigno la diferencia	
 		this.SetItem(ll_filact,"cx_valcre",lc_valor)
 	end if
	lc_saldo = wf_refresca_saldo()
	dw_master.SetItem(ll_filmas,'mp_saldo',lc_saldo) 
end if
end event

event ue_tabout;long ll_filact, ll_filmas
dec{2} lc_valor,lc_saldo


/*Se utiliza cuando se escribe el valor*/
If rowcount() = 1 Then
 
  this.AcceptText()
  ll_filmas = dw_master.GetRow()
 
  If getcolumnname() =  "cx_valcre" Then
   lc_valor = dec(GetText())
   //Actualizo el saldo del movimiento de cr$$HEX1$$e900$$ENDHEX$$dito
	lc_saldo = dw_master.GetItemDecimal(ll_filmas, 'mp_saldo')
	lc_saldo = lc_saldo - lc_valor
	If lc_saldo < 0 then
	   messageBox ("Error", "El valor no puede superar el saldo del cr$$HEX1$$e900$$ENDHEX$$dito")
		this.SetItem(getrow(),"cx_valdeb",0)
      /*Recalcular el saldo*/ 
      lc_saldo = wf_refresca_saldo()
	   dw_master.SetItem(ll_filmas, 'mp_saldo', lc_saldo)
      return 1
	end if
   lc_saldo = wf_refresca_saldo()
	dw_master.SetItem(ll_filmas, 'mp_saldo', lc_saldo)
 End if
	
End if
end event

event rowfocuschanged;call super::rowfocuschanged;long   ll_filmas
dec{2} lc_saldo


This.AcceptText()
ll_filmas = dw_master.GetRow()
If rowcount() = 1 then return
If getcolumnname() =  "cx_valcre" Then
//Actualizo el saldo del movimiento de cr$$HEX1$$e900$$ENDHEX$$dito
lc_saldo = wf_refresca_saldo()
dw_master.SetItem(ll_filmas, 'mp_saldo', lc_saldo)
End if
end event

type st_1 from statictext within w_otros_pagos
integer x = 5
integer y = 292
integer width = 512
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Detalle"
boolean focusrectangle = false
end type

type st_pagos from statictext within w_otros_pagos
integer x = 1861
integer y = 8
integer width = 206
integer height = 60
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
boolean focusrectangle = false
end type

event clicked;if dw_lp.visible = false and dw_lp.rowcount() > 0 then
	dw_lp.visible = true
	dw_lp.bringtotop = true
else
	dw_lp.visible = false
	dw_lp.bringtotop = false
end if
end event

type st_4 from statictext within w_otros_pagos
integer x = 1285
integer y = 8
integer width = 530
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Movimientos  sin cruzar"
boolean focusrectangle = false
end type

type st_2 from statictext within w_otros_pagos
integer x = 18
integer y = 620
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
boolean focusrectangle = false
end type

type ln_1 from line within w_otros_pagos
boolean visible = false
long linecolor = 255
integer linethickness = 4
integer beginy = 288
integer endx = 4663
integer endy = 288
end type

type dw_lp from datawindow within w_otros_pagos
boolean visible = false
integer y = 80
integer width = 3671
integer height = 1512
integer taborder = 20
string title = "none"
string dataobject = "d_lista_pagos"
boolean vscrollbar = true
boolean border = false
end type

event doubleclicked;String ls_pvcodigo,ls_mpcodigo



ls_pvcodigo = this.Object.pv_codigo[row ]
ls_mpcodigo = this.Object.mp_codigo [ row ]

dw_master.retrieve( str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mpcodigo,ls_pvcodigo )
dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'2','D',ls_mpcodigo )
wf_recupera_pendientes()
this.visible = false
end event


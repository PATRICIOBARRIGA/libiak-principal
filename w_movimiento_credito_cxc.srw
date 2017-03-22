HA$PBExportHeader$w_movimiento_credito_cxc.srw
$PBExportComments$Si.
forward
global type w_movimiento_credito_cxc from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_movimiento_credito_cxc
end type
type st_1 from statictext within w_movimiento_credito_cxc
end type
type dw_cruce from uo_dw_detail within w_movimiento_credito_cxc
end type
type dw_nc from datawindow within w_movimiento_credito_cxc
end type
type shl_1 from statichyperlink within w_movimiento_credito_cxc
end type
type st_2 from statictext within w_movimiento_credito_cxc
end type
end forward

shared variables

end variables

global type w_movimiento_credito_cxc from w_sheet_master_detail
integer x = 27
integer y = 68
integer width = 5664
integer height = 1948
string title = "Movimiento de Cr$$HEX1$$e900$$ENDHEX$$dito"
long backcolor = 79741120
event ue_consultar pbm_custom15
dw_ubica dw_ubica
st_1 st_1
dw_cruce dw_cruce
dw_nc dw_nc
shl_1 shl_1
st_2 st_2
end type
global w_movimiento_credito_cxc w_movimiento_credito_cxc

type variables
 /*ib_ok = true: Si se realizo la grabacion del movimiento completamente y bien*/
boolean    ib_ok= false,&
  ib_cruzar = true,&
   ib_fallo = false
string     is_mensaje
Datetime   id_hoy
Date       id_ahora
decimal    ic_saldo_nc    /*Para llevar el saldo , cuando se trata de NC
                            cuando la NC no ha sido cancelada, por completo*/



end variables

forward prototypes
public function integer wf_preprint ()
public function long wf_crea_debito (string as_cliente, decimal ac_saldo)
public function integer wf_actualiza_saldo_valor (decimal ad_valor)
public function integer wf_recupera_pendientes ()
public function integer wf_crea_actualiza_cuenta ()
public function decimal wf_refresca_saldo ()
public function integer wf_actualiza_saldo_cupo ()
public function integer wf_valida_fp ()
end prototypes

event ue_consultar;call super::ue_consultar;dw_master.postevent(DoubleClicked!)
end event

public function integer wf_preprint ();long ll_filAct,ll_reg

string ls_mt_numero, ls_tt_codigo, ls_valletras,ls_fp,ls_numnc

decimal lc_valor
int li_res

ll_filAct = dw_master.getRow()
ls_mt_numero = dw_master.getItemString(ll_filAct, "mt_codigo")
ls_tt_codigo = dw_master.getItemString(ll_filAct, "tt_codigo")

//lc_valor = dw_master.getItemNumber(ll_filAct, "mt_valor")

ls_fp = dw_detail.getItemString(dw_detail.getrow(), "fp_codigo")
lc_valor = dw_detail.getItemNumber(dw_detail.getrow(), "ch_valor")
ls_numnc = dw_detail.getItemString(dw_detail.getrow(),"ch_numero")
ls_valletras = f_numero_a_letras (lc_valor)

f_recupera_empresa(dw_report,"fp_codigo") 
ll_reg = dw_report.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,ls_mt_numero,ls_numnc,ls_fp,ls_valletras )   

if ll_reg <= 0 then return -1


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

public function integer wf_recupera_pendientes ();///////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Permite recuperar los movimientos de d$$HEX1$$e900$$ENDHEX$$bito pendientes
// Fecha de $$HEX1$$fc00$$ENDHEX$$ltima revisi$$HEX1$$f300$$ENDHEX$$n : 08/04/1999   10:35
///////////////////////////////////////////////////////////////////////
datetime ld_mtfecha,ld_mtfecven

long ll_filact, ll_filmas, ll_fila,ll_plazo
long ll_ve_numero
decimal ld_saldo, lc_mt_saldo
string ls_tipo, ls_empresa, ls_ce_codigo, ls_tt_codigo, ls_mt_codigo
string ls_tt_coddeb, ls_mt_coddeb, ls_tt_descri,ls_fp

Setpointer(Hourglass!)
w_marco.SetMicrohelp("Recuperando cuentas por cobrar......Por favor espere!!!")

dw_master.AcceptText()
ll_filmas = dw_master.getrow()

// encuentra el c$$HEX1$$f300$$ENDHEX$$digo del cliente, tipo de movimiento y n$$HEX1$$fa00$$ENDHEX$$mero de movimieto
// de cr$$HEX1$$e900$$ENDHEX$$dito
ls_ce_codigo = dw_master.GetItemString(ll_filmas,'ce_codigo')
ls_tt_codigo = dw_master.GetItemString(ll_filmas,'tt_codigo')
ls_mt_codigo = dw_master.GetItemString(ll_filmas,'mt_codigo')

DECLARE cur_deb_pendientes CURSOR FOR  
	SELECT cc_movim.tt_codigo,   
       cc_movim.mt_codigo,   
       cc_movim.mt_saldo,  
       cc_tipo.tt_descri,
       cc_movim.ve_numero,
		 trunc(cc_movim.mt_fecha),
		 cc_movim.mt_fecven
   FROM cc_movim , cc_tipo
   WHERE ( cc_movim.tt_ioe = 'D' ) AND
         ( cc_movim.mt_saldo > 0 ) AND  
         ( cc_movim.em_codigo =  :str_appgeninfo.empresa ) AND  
         ( cc_movim.su_codigo =  :str_appgeninfo.sucursal ) AND			
         ( cc_movim.ce_codigo =  :ls_ce_codigo )   AND
		   ( cc_movim.tt_codigo =  cc_tipo.tt_codigo) AND
		   ( cc_movim.tt_ioe    =  cc_tipo.tt_ioe)
	using sqlca;

dw_cruce.setTransObject(sqlca);
dw_cruce.Reset()
open cur_deb_pendientes;

DO WHILE True
	fetch cur_deb_pendientes into :ls_tt_coddeb, 
									:ls_mt_coddeb, :lc_mt_saldo,:ls_tt_descri,
									:ll_ve_numero,:ld_mtfecha,:ld_mtfecven;
	if sqlca.sqlcode <> 0 then exit
   
 select fp_descri
	into :ls_fp
	from fa_recpag x,fa_formpag y
	where x.em_codigo = y.em_codigo
	and x.fp_codigo = y.fp_codigo
	and x.em_codigo = :str_appgeninfo.empresa
	and x.su_codigo = :str_appgeninfo.sucursal
	and x.bo_codigo = :str_appgeninfo.seccion
	and x.es_codigo = '1'
	and x.ve_numero = :ll_ve_numero;
   

	ll_fila =dw_cruce.insertRow(0)
	// registra el cruce de d$$HEX1$$e900$$ENDHEX$$bitos vs cr$$HEX1$$e900$$ENDHEX$$ditos
	dw_cruce.setItem(ll_fila, "tt_coddeb", ls_tt_coddeb)
	dw_cruce.setItem(ll_fila, "mt_coddeb", ls_mt_coddeb)
	dw_cruce.setItem(ll_fila, "tt_ioedeb", 'D')
	dw_cruce.setItem(ll_fila, "mt_saldo", lc_mt_saldo)
	dw_cruce.setItem(ll_fila, "tt_codigo", ls_tt_codigo)
	dw_cruce.setItem(ll_fila, "mt_codigo", ls_mt_codigo)
	dw_cruce.setItem(ll_fila, "tt_ioe", 'C')
	dw_cruce.setItem(ll_fila, "cr_valcre", 0)
	dw_cruce.setItem(ll_fila, "cr_valdeb", 0)
	dw_cruce.setItem(ll_fila, "tt_descri", ls_tt_descri)
   dw_cruce.setItem(ll_fila, "em_codigo", str_appgeninfo.empresa)
   dw_cruce.setItem(ll_fila, "su_codigo", str_appgeninfo.sucursal)	
   dw_cruce.setItem(ll_fila, "ve_numero", ll_ve_numero)
   dw_cruce.setitem(ll_fila,"mt_fecven",ld_mtfecven)	
   dw_cruce.setitem(ll_fila,"cc_fpago",ls_fp)
   dw_cruce.setItemStatus(ll_fila, 0, Primary!, NotModified!)
LOOP

close cur_deb_pendientes;
Setpointer(Arrow!)
w_marco.SetMicrohelp("Listo...!")
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
If l_status = NewModified! then /* 1.-*/
If ll_max > 0 then              /* 2.-*/

// por cada fila del detalle hacer lo siguiente

for li = 1 to ll_max            /* 3.-*/
	as_numero = trim(dw_detail.GetitemString(li,'ch_cuenta'))
	as_banco  = dw_detail.GetitemString(li,'if_codigo')
	ad_valor	 = dw_detail.GetitemNumber(li,'ch_valor')
	ls_fp	    = dw_detail.GetitemString(li,'fp_codigo')
	If ls_fp = '1' Then          /* 4.-*/
		
		//encuentra el c$$HEX1$$f300$$ENDHEX$$digo del cliente y el estado, dado el banco y n$$HEX1$$fa00$$ENDHEX$$mero de cuenta
		select ce_codigo, cs_estado
		into :ls, :ls_estado
		from fa_ctacli
		where if_codigo = :as_banco
		and cs_numero = :as_numero;
		If sqlca.sqlcode < 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al determinar el estado de la cuenta..."+sqlca.sqlerrtext)
		rollback;
		return -1
		End if
						
		
		// Si no existe, inserto la cuenta con estado N (Nueva)
		if sqlca.sqlcode = 100 then /*5.-*/
			INSERT INTO "FA_CTACLI"( "IF_CODIGO", "CS_NUMERO","CE_CODIGO","CS_VALCHE",   
			"CS_VALPRO", "CS_NUMCHE","CS_NUMPRO","CS_ESTADO" )  
			VALUES (:as_banco,:as_numero,:as_clien,:ad_valor,0,1,0,'N')  ;
			
			if sqlca.sqlcode < 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al crear la cuenta..."+sqlca.sqlerrtext)
			rollback;
			return -1
		   end if
		end if 	

      //Si existe un cliente con esa cuenta 
      If not isnull(ls) then

			//Si es una cuenta pasiva, no se debe facturar
			if ls_estado = 'P' then 
			messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La cuenta corriente tiene problemas, revise estad$$HEX1$$ed00$$ENDHEX$$sticas.')
			end if
			
			// si el cliente coincide con el due$$HEX1$$f100$$ENDHEX$$o del n$$HEX1$$fa00$$ENDHEX$$mero de la cuenta registrada
			if ls = as_clien then
					//actualiza los valores en cheques de la cuenta y el n$$HEX1$$fa00$$ENDHEX$$mero de cheque recibidos
					update fa_ctacli
					set cs_valche = cs_valche + :ad_valor,
					cs_numche = cs_numche + 1
					where if_codigo = :as_banco
					and cs_numero = :as_numero;
					If sqlca.sqlcode < 0 then
					messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el Nro de Cheque..."+sqlca.sqlerrtext)
					rollback;
					return -1
					End if
	
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
					update fa_ctacli
					set cs_valche = cs_valche + :ad_valor,
					cs_numche = cs_numche + 1,
					ce_codigo = :as_clien
					where if_codigo = :as_banco
					and cs_numero = :as_numero;
					If sqlca.sqlcode < 0 then
					Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la cuenta..."+sqlca.sqlerrtext)
					rollback;
					return -1
					end if

					CASE 2
					update fa_ctacli
					set cs_valche = cs_valche + :ad_valor,
					cs_numche = cs_numche + 1
					where if_codigo = :as_banco
					and cs_numero = :as_numero;
					If sqlca.sqlcode < 0 then
					Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la cuenta..."+sqlca.sqlerrtext)
					rollback;
					return -1
					end if

					CASE 3
					return -1
					END CHOOSE
          end if
		end if /*5.-*/
	end if    /*4.-*/
next         /*3.-*/

end if       /*2.-*/
end if       /*1.-*/

return 1
end function

public function decimal wf_refresca_saldo ();
Decimal lc_totcheques,lc_abono,lc_saldo
Long ll_rowd,ll_rowc,ll_rowm
dwitemstatus l_status 

ll_rowm = dw_master.getrow()
if ll_rowm = 0 then return 0

ll_rowd = dw_detail.getrow()
if ll_rowd = 0 then return 0

ll_rowc = dw_cruce.getrow()
if ll_rowc = 0 then return 0

l_status = dw_master.getitemstatus(ll_rowm,0,Primary!)

if l_status = new! or l_status =  newmodified! then
lc_totcheques  = dw_detail.getitemdecimal(ll_rowd,"tot_cheques")
lc_abono = dw_cruce.getitemdecimal(ll_rowc,"cc_sumvaldeb")
lc_saldo = lc_totcheques - lc_abono
else
lc_abono = dw_cruce.getitemdecimal(ll_rowc,"cc_sumvaldeb")	
lc_saldo = ic_saldo_nc - lc_abono
end if

return lc_saldo


end function

public function integer wf_actualiza_saldo_cupo ();////////////////////////////////////////////////////////////////////////
// DESCRIPCION: Actualiza el cupo de cr$$HEX1$$e900$$ENDHEX$$dito que tiene el cliente
// FECHA DE ULTIMA REVISION : 08/04/1999  10:50
// REVISADO POR : ING Hugo Orozco CH
////////////////////////////////////////////////////////////////////////

string ls_cliente, ls_codigo,ls_fpcodigo
decimal lc_valor = 0
date ld_fecha,ld_fecefec
long li, ll_max, ll_plazo, ll_fila
dwItemStatus l_status

ll_fila = dw_master.GetRow()
l_status = dw_master.GetItemStatus(ll_fila, 0, Primary!)
ll_max = dw_detail.rowcount()

//Actualiza el saldo del cr$$HEX1$$e900$$ENDHEX$$dito del cliente, solo la primera vez

// OJO AQUI HAY QUE CONTROLAR: SI ES CHEQUE POSTFECHADO NO ACTUALIZA EL CUPO


if l_status = NewModified! then 
	ls_cliente = dw_master.GetItemString(ll_fila,'ce_codigo')
	  
	//Acumula el valor siempre que no sea cheque postfechado  
	for li = 1 to ll_max
		ls_fpcodigo = dw_detail.getitemstring(li,"fp_codigo")
		ld_fecha    = date(dw_detail.getitemdatetime(li,"ch_fecha"))
		ld_fecefec  = date(dw_detail.getitemdatetime(li,"ch_fecefec"))
		if ls_fpcodigo <> '1' or ld_fecefec = ld_fecha then 
			lc_valor = lc_valor + dw_detail.getitemnumber(li,"ch_valor") 	
		end if
	next  
		  
   UPDATE FA_CLIEN
	SET CE_SALCRE = CE_SALCRE + :lc_valor
	WHERE CE_CODIGO = :ls_cliente
	AND EM_CODIGO = :str_appgeninfo.empresa;
   
	if sqlca.sqlcode < 0 then
		messageBox('Error Interno', 'Funci$$HEX1$$f300$$ENDHEX$$n wf_acualiza_saldo_cupo ' +sqlca.sqlerrtext)
		rollback;
		return -1
	end if
end if

return 1
end function

public function integer wf_valida_fp ();Long ll_reg,ll_contador_efectivo_cheque

ll_reg = dw_detail.getitemNumber(1,"regtotal")
ll_contador_efectivo_cheque = dw_detail.getitemNumber(1,"contador_fp")

if ll_contador_efectivo_cheque  >=1 and ll_reg > 1  then
	Messagebox("Atencion","La forma de pago Cheque o Efectivo no puede estar registrada junto a otras formas de pago....")
	dw_detail.deleterow(dw_detail.getrow())
	return -1
end if
return 1
end function

on w_movimiento_credito_cxc.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.st_1=create st_1
this.dw_cruce=create dw_cruce
this.dw_nc=create dw_nc
this.shl_1=create shl_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_cruce
this.Control[iCurrent+4]=this.dw_nc
this.Control[iCurrent+5]=this.shl_1
this.Control[iCurrent+6]=this.st_2
end on

on w_movimiento_credito_cxc.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.st_1)
destroy(this.dw_cruce)
destroy(this.dw_nc)
destroy(this.shl_1)
destroy(this.st_2)
end on

event open;///////////////////////////////////////////////////////////////////////
//	DESCRIPCI$$HEX1$$d300$$ENDHEX$$N : Cuando se abre la ventana, se recupera los drop y luego
//               se recupera para el campo "mt_codigo", el secuencial
// de pr_param con pr_nombre = "CRE_CXC".
//	FECHA DE ULTIMA REVISION : 22/09/2003  18:00
/////////////////////////////////////////////////////////////////////////

string            ls_parametro[]
DataWindowChild   ldwc_aux,dwc


SELECT trunc(SYSDATE)
INTO :id_hoy
FROM DUAL;
id_ahora = Date(id_hoy)


f_recupera_empresa(dw_master,"tt_codigo") 


// recupera las cuentas corrientes de la empresa y sucursal conectada

dw_detail.GetChild("fp_codigo",dwc)
dwc.SetTransObject(SQLCA)
dwc.Retrieve(str_appgeninfo.empresa)
dwc.SetFilter("fp_string Like '%T%'")
dwc.Filter()


dw_master.GetChild("mt_ctacor",ldwc_aux)
ldwc_aux.SetTransObject(sqlca)
ldwc_aux.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

f_recupera_empresa(dw_detail,"fp_codigo")
f_recupera_empresa(dw_detail,"if_codigo")
f_recupera_empresa(dw_ubica,"proveedor")


istr_argInformation.nrArgs = 4
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.argType[4] = "string"


istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = '@'
istr_argInformation.StringValue[4] = '@'


call super::open

// datos para recuperar el secuencial del movimiento
dw_master.is_SerialCodeColumn = "mt_codigo"
dw_master.is_SerialCodeType = "CRE_CXC"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa

// columnas de conecci$$HEX1$$f300$$ENDHEX$$n
dw_master.ii_nrCols = 5
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "mt_codigo"
dw_master.is_connectionCols[4] = "tt_codigo"
dw_master.is_connectionCols[5] = "tt_ioe"

dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "mt_codigo"
dw_detail.is_connectionCols[4] = "tt_codigo"
dw_detail.is_connectionCols[5] = "tt_ioe"
dw_detail.uf_setArgTypes()

/*Para abrir Insertando una nueva cancelacion*/
dw_master.uf_insertCurrentRow()
dw_master.setFocus()


dw_nc.SetTransObject(sqlca)
st_2.text = String(dw_nc.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal))



end event

event ue_update;///////////////////////////////////////////////////////////////////////
//	DESCRIPCI$$HEX1$$d300$$ENDHEX$$N : Graba los cr$$HEX1$$e900$$ENDHEX$$ditos de los clientes
//	FECHA DE ULTIMA REVISION : 18/09/2003 
// ///////////////////////////////////////////////////////////////////////
Long    ll_row,ll_venumero,ll_filact,ll_find
Int     rc,i,li
Dec{2}  lc_saldo,lc_valor
Date    ld_fefec
String  ls_mtcodigo,ls_ttcodigo,ls_ttioe,ls_fp,ls_cliente

//Inicia una nueva grabacion con la bandera en false
ib_ok = false

If dw_master.AcceptText() <> 1 then return
If dw_detail.AcceptText() <> 1 then return
If dw_cruce.AcceptText()  <> 1 then return  

ll_filact = dw_master.GetRow()
ll_row = dw_cruce.GetRow()

if ll_filact = 0 then return
if ll_row = 0 then return


/*Actualizar el saldo del cr$$HEX1$$e900$$ENDHEX$$dito con el valor del pago menos lo cancelado*/
lc_saldo = Round(dw_master.GetItemDecimal(ll_filact,"mt_saldo"),2)
If lc_saldo < 0 &
then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ha cancelado un valor superior al pago~n~r"+&
                                      "El Cr$$HEX1$$e900$$ENDHEX$$dito no se registrar$$HEX1$$e100$$ENDHEX$$",Exclamation!)
rollback;
return			  
end if	

If lc_saldo > 0 &
then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Existe un saldo pendiente de cruce~n~r"+&
           "Si no existen m$$HEX1$$e100$$ENDHEX$$s movimientos de D$$HEX1$$e900$$ENDHEX$$bito debe crear uno por Anticipo")	
rollback;
return			  
end if	

/*Nos aseguramos que la cancelaci$$HEX1$$f300$$ENDHEX$$n sea completa*/
If lc_saldo = 0 then
	dw_master.SetItem(ll_filact,"mt_saldo",0)
	w_marco.setmicrohelp("Cancelaci$$HEX1$$f300$$ENDHEX$$n Lista")
End if	

ls_cliente = dw_master.GetItemString(ll_filact,"ce_codigo")

/*Verificar que no existen pagos con valor Cero*/

ll_find = dw_detail.find("ch_valor = 0",1,dw_detail.rowcount())
If ll_find > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Existen formas de pago con valor Cero[0]...<Verifique!>",Exclamation!)
	rollback;
	return
End if
 



/*Validar que la fecha de Vencimiento no sea menor a Sysdate */
/**/
for i = 1 to dw_detail.rowcount()
 ls_fp = dw_detail.GetItemString(i,"fp_codigo")
 ld_fefec       = Date(dw_detail.GetItemDateTime(i,"ch_fecefec"))
 	
 If ld_fefec <  id_ahora  and ls_fp = '1'&
 Then
 Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha de Vencimiento del cheque debe ser posterior a la de hoy~r~n" +&
	                        "Por favor verifique en RECEPCION DE PAGO fila:' "+String(i)+"' ",Exclamation!)
 rollback;
 return
 End if
  
 If ls_fp = '2' Then
   //Actualiza saldo de la Nota de cr$$HEX1$$e900$$ENDHEX$$dito
	lc_valor = dw_detail.getitemNumber(dw_detail.getrow(),"ch_valor")
	ll_venumero = long(dw_detail.getitemString(dw_detail.getrow(),"ch_numero"))
	If isnull(ll_venumero) Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de la Nota de Cr$$HEX1$$e900$$ENDHEX$$dito")
	rollback;
	return
	End if
	
	update fa_venta
	set ve_valotros = ve_valotros - :lc_valor
	where es_codigo = '9'
	and em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion			
	and ve_numero = :ll_venumero; 
	If sqlca.sqlcode < 0 then
		 messageBox('Error','No existe la N/C, verifique informaci$$HEX1$$f300$$ENDHEX$$n')
		 rollback;
		 return
	End if
	If lc_valor <= 0.02 then
		 messageBox('Error','La nota de cr$$HEX1$$e900$$ENDHEX$$dito ha sido cancelada en su totalidad.....<verif$$HEX1$$ed00$$ENDHEX$$que>')
		 rollback;
		 return
	End if
 End if
Next


// crea o actualiza cada una de las cuentas del detalle
//If wf_crea_actualiza_cuenta() < 0 Then 
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La cuenta no ha sido actualizada...Por favor revise e intente nuevamente")
//Rollback;
//return
//End if


if wf_actualiza_saldo_cupo() < 0 then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El cupo no ha sido actualizado...Por favor revise e intente nuevamente")
Rollback;
return
end if	



/*Permitir grabar solo cuando exista cruces de movimientos*/
//If ll_row = 0 Then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Este movimiento no puede ser registrado no existen datos para cruzar.")
//Return
//End if

//lc_valdeb = dw_cruce.GetItemNumber(ll_row,"cc_sumvaldeb")
//If  lc_valdeb = 0  Then  
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El Movimiento de cr$$HEX1$$e900$$ENDHEX$$dito no tiene realizado cruces.")
//Return 
//End if 	

/*Empieza actualizaci$$HEX1$$f300$$ENDHEX$$n*/
rc = dw_master.Update(TRUE,FALSE)
IF rc = 1 THEN
		ls_mtcodigo  =  dw_master.GetItemString(ll_filact,"mt_codigo")
		ls_ttcodigo   =  dw_master.GetItemString(ll_filact,"tt_codigo")
		ls_ttioe         =  dw_master.GetItemString(ll_filact,"tt_ioe")
	    for li = 1 to dw_detail.RowCount()
			dw_detail.SetItem(li,'ch_secue',li)
			dw_detail.SetItem(li,'em_codigo',str_appgeninfo.empresa)
			dw_detail.SetItem(li,'su_codigo',str_appgeninfo.sucursal)
			dw_detail.SetItem(li,'mt_codigo',ls_mtcodigo)
			dw_detail.SetItem(li,'tt_codigo',ls_ttcodigo)
			dw_detail.SetItem(li,'tt_ioe',ls_ttioe)
			dw_detail.Setitem(li,'ch_fecha',id_hoy)
  	     next 
		rc = dw_detail.Update(TRUE, FALSE)
		If rc = 1 Then
			   
			/**/
			for li = 1 to dw_cruce.RowCount()
			dw_cruce.setItem(li, "tt_codigo", ls_ttcodigo)
			dw_cruce.setItem(li, "mt_codigo", ls_mtcodigo)
			next
			if dw_cruce.Triggerevent('ue_guardar') < 0 then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el saldo de los d$$HEX1$$e900$$ENDHEX$$bitos")
			rollback;
			return
			end if	
			
			rc = dw_cruce.Update(TRUE,FALSE)
			IF rc = 1 Then
				dw_master.ResetUpdate() // Both updates are OK
				dw_detail.ResetUpdate()   // Clear update flags
				dw_cruce.ResetUpdate()
				COMMIT;								
				dw_master.setfocus()
				dw_master.setcolumn(11)
				ib_ok = true
//		
		    ELSE
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al cruzar el cr$$HEX1$$e900$$ENDHEX$$dito" +sqlca.sqlerrtext)	
				ROLLBACK ;                       // 2nd update failed
				Return
	     	END IF
  	    Else
			 Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar la forma de pago" +sqlca.sqlerrtext)	
			 Rollback;		
			 Return
	    End if	
Else		
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al grabar el cr$$HEX1$$e900$$ENDHEX$$dito" +sqlca.sqlerrtext)	
Rollback;
Return
END IF


/*Ver detalle de cruce*/
wf_recupera_pendientes()


end event

event ue_insert;long ll_filact
graphicObject lgo_curObject


ll_filact = dw_master.GetRow()
if ll_filact > 0 and not isnull(ll_filact) then
	
	lgo_curObject = getFocus()
	if lower(lgo_curObject.className()) = "dw_detail" and &
	dw_master.GetItemString(ll_filact,'tt_codigo') <> '5' then //Pago no es con cheque
	beep(1)
	return
	end if
	
	
	
	if  lower(lgo_curObject.className())="dw_detail" and ib_ok then
	beep(1)
	return
	end if
	
	
	if lower(lgo_curObject.className()) = "dw_cruce" &
	then
	beep(1)
	return
     end if
		
		
end if
dw_detail.triggerevent("ue_postinsert")
call super::ue_insert
//dw_cruce.Reset()
//dw_detail.visible = true
//dw_cruce.visible = false
//cb_1.text = '&Cruzar Movimiento'
//dw_master.SetFocus()
//ib_cruzar = true
//dw_master.settaborder("ce_codigo",10)
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

int li_width, li_height,li_wdetail, li_wcruce, li_df,  li_hm

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

li_hm = dw_master.height

li_wdetail = dw_detail.width
li_wcruce = dw_cruce.width

li_df = li_width - (li_wdetail + li_wcruce)

dw_detail.resize(li_wdetail,   li_height - li_hm -250) 
dw_cruce.resize(li_wcruce + li_df, li_height - 50)

this.setRedraw(False)
if this.ib_inReportMode then
   dw_report.resize(this.workSpaceWidth() - 2*dw_report.x, this.workSpaceHeight() - 2*dw_report.y)
end if
this.setRedraw(True)
return 1
end event

event ue_retrieve;return 1
end event

event ue_print;
//Sobreescrito el evento del padre.
//Necesito habilitar los datawindows para poder moverme por los campos del detalle.

dwItemStatus   lst_estado
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
			
			dw_master.enabled = False
			dw_master.visible = True
			
			dw_detail.enabled = true
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
			
			dw_detail.enabled = True
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
return 1
end event

event closequery;return
end event

event ue_printcancel;call super::ue_printcancel;m_frame_basic lm_frame

dw_master.enabled = False
dw_master.visible = True
dw_detail.enabled = True
dw_detail.visible = True

//Deshabilitar opciones de menu 
//lm_frame.
end event

event ue_delete;long ll_filact
dwitemstatus l_status
graphicObject lgo_curObject

ll_filact = dw_master.GetRow()
if ll_filact > 0 and not isnull(ll_filact) then
	l_status = dw_master.getitemstatus(ll_filact,0,Primary!)
	lgo_curObject = getFocus()
	if lower(lgo_curObject.className()) = "dw_cruce" &
	then
	beep(1)
	return
   end if
	
	if lower(lgo_curObject.className()) = "dw_master" & 
	and (l_status = notmodified! or l_Status = datamodified!) &
	then
	beep(1)
	return
     end if
	  
	if lower(lgo_curObject.className()) = "dw_detail" & 
	and (l_status = notmodified! or l_Status = datamodified!) &
	then
	beep(1)
	return
     end if  
	  
	  
end if

call super::ue_delete
end event

event ue_firstrow;string ls_status 
decimal lc_valor,lc_saldo
long ll_row

/*Permitir cambiar de registro solo cuando se */
ll_row = dw_master.getrow()
ls_status = dw_master.getitemstring(ll_row,"cc_status")
lc_valor = dw_master.getitemdecimal(ll_row,"mt_valor")
lc_saldo = dw_master.getitemdecimal(ll_row,"mt_saldo")

if ls_status = 'datamodified!' and lc_saldo <> lc_valor then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe primero grabar la cancelaci$$HEX1$$f300$$ENDHEX$$n antes de ir a otros registros.")
	return
end if

call super::ue_firstrow

end event

event ue_nextrow;string ls_status 
decimal lc_valor,lc_saldo
long ll_row

/*Permitir cambiar de registro solo cuando se */
ll_row = dw_master.getrow()
ls_status = dw_master.getitemstring(ll_row,"cc_status")
lc_valor = dw_master.getitemdecimal(ll_row,"mt_valor")
lc_saldo = dw_master.getitemdecimal(ll_row,"mt_saldo")

if ls_status = 'datamodified!' and lc_saldo <> lc_valor then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe primero grabar la cancelaci$$HEX1$$f300$$ENDHEX$$n antes de ir a otros registros.")
	return
end if

call super::ue_nextrow
end event

event ue_priorrow;string ls_status 
decimal lc_valor,lc_saldo
long ll_row

/*Permitir cambiar de registro solo cuando se */
ll_row = dw_master.getrow()
ls_status = dw_master.getitemstring(ll_row,"cc_status")
lc_valor = dw_master.getitemdecimal(ll_row,"mt_valor")
lc_saldo = dw_master.getitemdecimal(ll_row,"mt_saldo")

if ls_status = 'datamodified!' and lc_saldo <> lc_valor then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe primero grabar la cancelaci$$HEX1$$f300$$ENDHEX$$n antes de ir a otros registros.")
	return
end if

call super::ue_priorrow
end event

event ue_lastrow;string ls_status 
decimal lc_valor,lc_saldo
long ll_row

/*Permitir cambiar de registro solo cuando se */
ll_row = dw_master.getrow()
ls_status = dw_master.getitemstring(ll_row,"cc_status")
lc_valor = dw_master.getitemdecimal(ll_row,"mt_valor")
lc_saldo = dw_master.getitemdecimal(ll_row,"mt_saldo")

if ls_status = 'datamodified!' and lc_saldo <> lc_valor then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe primero grabar la cancelaci$$HEX1$$f300$$ENDHEX$$n antes de ir a otros registros.")
	return
end if

call super::ue_lastrow
end event

type dw_master from w_sheet_master_detail`dw_master within w_movimiento_credito_cxc
event ue_dwnkey pbm_dwnkey
event ue_nextfield pbm_dwnprocessenter
integer y = 140
integer width = 2935
integer height = 456
integer taborder = 10
string dataobject = "d_movimiento_credito_cjb_cxc"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_master::ue_dwnkey;dwitemStatus l_status


l_status =  This.GetItemStatus(This.GetRow(),0,Primary!)
If ( (Key = Keyenter! or Key = KeyTab! ) and & 
    (l_status = Newmodified! or l_status = new!) and &
	GetcolumnName() = "ce_codigo" ) &
Then
	if dw_detail.rowcount()=0 then 
	dw_detail.InsertRow(0)
	dw_detail.Triggerevent("ue_postinsert")
	dw_detail.SetFocus()
	end if
End if
Return 0

end event

event dw_master::itemchanged;////////////////////////////////////////////////////////////////////////
// DESCRIPCION: Realiza ciertos c$$HEX1$$e100$$ENDHEX$$lculos dependiendo del campo en el
//              que se encuentra.
// FECHA DE ULTIMA REVISION : 13/07/2000
// ////////////////////////////////////////////////////////////////////////

long ll_row
decimal ld_saldo, lc_retencion, lc_valret, lc_valiva,lc_totdeb,lc_valor,lc
dataWindowChild ldwc_aux
string ls_firma,ls,ls_cecodigo,ls_nomcli

This.AcceptText()
CHOOSE CASE This.GetColumnName()
case 'ce_codigo'
     
	// con el c$$HEX1$$f300$$ENDHEX$$digo del cliente buscar la firma
	select ce_firma,ce_codigo,ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep))
	into :ls_firma,:ls_cecodigo,:ls_nomcli
	from fa_clien
	where em_codigo = :str_appgeninfo.empresa
	and ce_codigo = :data;
	
	If isnull(ls_cecodigo) or ls_cecodigo = "" Then
   	is_mensaje ='Cliente no registrado'
	return 1
	End if  
	this.modify(" st_nombre.text ='"+ls_nomcli+"'")
	this.SetItem(row,"em_codigo",str_appgeninfo.empresa)
	this.SetItem(row,"su_codigo",str_appgeninfo.sucursal)
	this.SetItem(row,"ce_firma",ls_firma)
case 'mt_valor'
	// controla que el valor del pago (cr$$HEX1$$e900$$ENDHEX$$dito) no sea negativo
	// 	if  dec(this.GetText()) < 0 then
	//   	messageBox ("Error", "El valor no puede ser negativo")
	//		this.ib_inErrorCascade = True
	//   	return 1
	//	end if
	//	
	//	//asigna el saldo igual al valor del cr$$HEX1$$e900$$ENDHEX$$dito
	//	this.SetItem(ll_filact,"mt_saldo",dec(this.GetText()))
	
	// si es pago con cheque insertamos el detalle
	// si es efectivo, no hace falta detalle	
	//	if dw_master.GetItemString(ll_filact,'tt_codigo') = '5' then
	//		dw_detail.SetFocus()
	//		dw_detail.InsertRow(0)
	//		dw_detail.SetColumn('if_codigo')
	//	end if


case 'mt_valret'
	ll_row = dw_detail.GetRow()
	If ll_row <> 0 Then
	lc_totdeb = dw_detail.GetItemNumber(ll_row,'tot_cheques')
    End if
	lc_valret =  dec(data)
	lc_valiva =  This.GetItemNumber(row,"mt_valiva")
	lc_valor = lc_totdeb + lc_valret + lc_valiva
	This.SetItem(row,'mt_valor',lc_valor)
	This.SetItem(row,'mt_saldo',lc_valor)


case 'mt_valiva'
	ll_row = dw_detail.GetRow()
	If ll_row <> 0 Then 
	lc_totdeb = dw_detail.GetItemNumber(ll_row,'tot_cheques')
    End if
	lc_valiva =  dec(data)
	lc_valret =  This.GetItemNumber(row,"mt_valret")
	lc_valor  = lc_totdeb + lc_valret + lc_valiva
	This.SetItem(row,'mt_valor',lc_valor)
	This.SetItem(row,'mt_saldo',lc_valor)


case 'rf_codigo'
	
	//ls = this.GetText()
	// encuentra el valor del cr$$HEX1$$e900$$ENDHEX$$dito
	lc = dw_master.GetItemNumber(row,'mt_valor')
	
	// encuentra de las retenciones activas el porcentaje de la retenci$$HEX1$$f300$$ENDHEX$$n
	Select rf_procen
	 into :lc_retencion
     from cc_reten
	 where rf_codigo = :data // encuentra el c$$HEX1$$f300$$ENDHEX$$digo de la retenci$$HEX1$$f300$$ENDHEX$$n
	 and rf_activa = 'S';
	
	if sqlca.sqlcode <> 0 then
		is_mensaje ='Forma de Pago no existe o no est$$HEX2$$e1002000$$ENDHEX$$activa'
		return 1
	end if
	// encuentra el valor de la retenci$$HEX1$$f300$$ENDHEX$$n
	lc_valret = round(lc * lc_retencion ,0)
	this.SetItem(row,'mt_valret',lc_valret)
	
case 'tt_codigo'
	ls = data
End choose
	
wf_recupera_pendientes()	
end event

event dw_master::clicked;//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = true
str_cliparam.ventana = parent
str_cliparam.datawindow = dw_master
str_cliparam.fila = this.GetRow() 
end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event dw_master::itemerror;messageBox('Error',is_mensaje)
return 1
end event

event dw_master::rowfocuschanged;string ls_nomcli,ls_cliente
Long   ll_row
string ls_status
decimal lc_valor,lc_saldo

ll_row = this.getrow()

if ll_row = 0 then return

ls_cliente = this.getitemstring(ll_row,"ce_codigo")
select ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep))
into :ls_nomcli
from fa_clien
where em_codigo = :str_appgeninfo.empresa
and ce_codigo = :ls_cliente;
this.modify(" st_nombre.text ='"+ls_nomcli+"'")




wf_recupera_pendientes()
ic_saldo_nc = dw_master.GetitemDecimal(ll_row,'mt_saldo')
dw_master.enabled = true

call super::rowfocuschanged

return 0
end event

event dw_master::ue_postinsert;call super::ue_postinsert;Long ll_row

ll_row = dw_master.getrow()
if ll_row = 0 then return
This.Setcolumn("ce_codigo")
This.SetItem(ll_row,"mt_fecha",id_ahora)
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_movimiento_credito_cxc
event ue_nextfield pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
integer x = 27
integer y = 684
integer width = 2939
integer height = 1108
integer taborder = 20
string title = "Recepci$$HEX1$$f300$$ENDHEX$$n de Pago"
string dataobject = "d_cheque"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_detail::ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event

event dw_detail::ue_dwnkey;Long ll_row
dwitemStatus l_status

l_status =  This.GetItemStatus(This.GetRow(),0,Primary!)
If ( Key = Keyenter! and l_status = Newmodified! ) and GetcolumnName() = "ch_fecefec" & 
Then
If  ib_fallo<> false Then 
ll_row  = dw_detail.InsertRow(0)
This.SetItem(ll_row,"ch_fecefec",relativedate(id_ahora,1))
ib_fallo = false
End if
End if
Return 0
end event

event dw_detail::losefocus;call super::losefocus;//CHOOSE CASE this.getcolumnName()
//
//CASE 'ch_fecefec'
//	dw_detail.SetFocus()
//	if dw_master.GetItemNumber(dw_master.GetRow(),'mt_valor') > dw_detail.GetItemNumber(dw_detail.GetRow(),'tot_cheques') then
//    	dw_detail.InsertRow(0)
//		this.SetColumn('if_codigo')
//	end if
//END CHOOSE
end event

event dw_detail::itemchanged;//////////////////////////////////////////////////////////////////////
// DESCRIPCION : Controla que no sea la fecha menor que la actual
// FECHA DE ULTIMA REVISION : 07/04/1999  12:07
// REVISADO POR : 
//////////////////////////////////////////////////////////////////////
decimal lc_valor,lc_valret,lc_valiva,lc_total,lc,lc_saldo,lc_saldonc
long ll_filact,ll_find,ll_end,ll_count, ll_count1
String ls,ls_codigo,ls_fp,ls_nulo, ls_cecodigo
date  ld_hoy,ld_fefec 



ll_filact = this.GetRow()
Setnull(ls_nulo)
This.Accepttext()

// Controla que la fecha de vencimiento no sea menor que la actual
If dwo.name = 'ch_fecefec' Then
	
	   ld_hoy =  date(string(today(),'dd/mm/yyyy'))
		ls =  left(gettext(),10)
		ls_fp = this.getitemstring(ll_filact,"fp_codigo")
		ld_fefec    =  date(ls)
		if  ld_fefec < ld_hoy  and ls_fp = '1' then
			messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La fecha de Vencimiento debe ser mayor a la fecha de hoy ('+string(today(),'dd/mm/yyyy')+')')
			this.ib_inErrorCascade = true
			ib_fallo = true
		end if
end if

If dwo.name = 'ch_valor'	Then
      lc_valor  = This.getItemNumber(this.getrow(),"tot_cheques")
		lc_valret = dw_master.GetItemNumber(dw_master.getrow(),'mt_valret')
		lc_valiva = dw_master.GetItemNumber(dw_master.getrow(),'mt_valiva')
		lc_total  = lc_valor + lc_valret + lc_valiva
		dw_master.Setitem(dw_master.Getrow(),"mt_valor",lc_total) 
		lc_saldo  = wf_refresca_saldo()
	   dw_master.Setitem(dw_master.Getrow(),"mt_saldo",lc_saldo) 
end if

//En caso de poner primero el numero de retenci$$HEX1$$f300$$ENDHEX$$n y luego elegir la forma de pago, deja el campo ch_numero en blanco 
if dwo.name = 'fp_codigo'  then 
	this.acceptText()
	ls = this.GetText()
	
	if wf_valida_fp() < 0 then
	return 1
    end if

	
	if ls = '6' or ls = '7' or ls = '111' then 
		this.setitem(row,"ch_numero",ls_nulo)
		this.setitem(row,"ch_cuenta",ls_nulo)
	end if
end if


//CUANDO SEA RETENCION SE PUSO EL ESTE CONTROL PORQUE SIEMPRE DEBE SER 10 DIGITOS.
If dwo.name = 'ch_cuenta'	Then
ls_codigo = this.GetItemString(ll_filact,'fp_codigo',primary!,false)		
	if ls_codigo = '6' or ls_codigo = '7' or ls_codigo = '111' then 
		 if len(this.GetItemstring(row,'ch_cuenta')) <> 10 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El n$$HEX1$$fa00$$ENDHEX$$mero de Autorizaci$$HEX1$$f300$$ENDHEX$$n debe ser de 10 d$$HEX1$$ed00$$ENDHEX$$gitos...<Vuelva a ingresar!.>",Exclamation!)
			this.setitem(row,"ch_cuenta",ls_nulo)
			return 1
		 end if
	end if
end if

If dwo.name = 'ch_numero'	Then
		ls = this.GetText()
		ls_codigo = this.GetItemString(ll_filact,'fp_codigo',primary!,false)		
		lc = this.GetItemNumber(ll_filact,'ch_valor')		
		If ls_codigo = '2' then // 2 es NOTA DE CREDITO
		   Select ve_valotros
		   into :lc_valor
		   from fa_venta
		   where es_codigo = '9'
		   and em_codigo = :str_appgeninfo.empresa
		   and su_codigo = :str_appgeninfo.sucursal
		   and bo_codigo = :str_appgeninfo.seccion			
             and ve_numero = :ls; 
		   If sqlca.sqlcode <> 0 then
			    messageBox('Error','No existe la N/C, verifique informaci$$HEX1$$f300$$ENDHEX$$n')
			    return 1
			End if
         If  lc > lc_valor then
			    messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La Nota de Cr$$HEX1$$e900$$ENDHEX$$dito solo tiene un saldo de '+string(lc_valor, "#,##0.00"))
				this.SetItem(ll_filact,'ch_valor',lc_valor)
			End if
		End if	
		
		//Para verificar que la retenci$$HEX1$$f300$$ENDHEX$$n no este ya ingresada
		if ls_codigo = '6' or ls_codigo = '7'  or ls_codigo = '111' then 
			dw_master.AcceptText()
			ls_cecodigo = 	dw_master.GetItemstring(dw_master.GetRow(),'ce_codigo')
			 If isnull(ls_cecodigo)  or ls_cecodigo = "" then
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Antes de ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de retenci$$HEX1$$f300$$ENDHEX$$n, favor ingrese el cliente en la parte superior...",Exclamation!)
				this.setitem(row,"ch_numero",ls_nulo)
				return 1
			End if
			
			//debe ser 13 digitos para retenci$$HEX1$$f300$$ENDHEX$$n	
			if len(this.GetItemstring(row,'ch_numero')) <> 13 then
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El n$$HEX1$$fa00$$ENDHEX$$mero de retenci$$HEX1$$f300$$ENDHEX$$n (#Doc/Preimp) debe ser de 13 d$$HEX1$$ed00$$ENDHEX$$gitos...<Vuelva a ingresar!.>",Exclamation!)
				this.setitem(row,"ch_numero",ls_nulo)
				return 1
			 end if
			 
  			  select count (*) //select cc_movim.mt_codigo , ch_fecha
			  into :ll_count1
			  from cc_cheque, cc_movim
			  where cc_cheque.tt_codigo = cc_movim.tt_codigo and cc_cheque.tt_ioe = cc_movim.tt_ioe and
			  cc_cheque.em_codigo = cc_movim.em_codigo and cc_cheque.su_codigo = cc_movim.su_codigo and
			  cc_cheque.mt_codigo = cc_movim.mt_codigo and cc_cheque.tt_ioe = 'C' and cc_cheque.fp_codigo in ('6','7','111') and
			 cc_cheque.em_codigo = :str_appgeninfo.empresa and  cc_cheque.su_codigo = :str_appgeninfo.sucursal and
			  ch_numero = :ls and ce_codigo = :ls_cecodigo ;
				 If ll_count1 > 0 then
					Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El n$$HEX1$$fa00$$ENDHEX$$mero de retenci$$HEX1$$f300$$ENDHEX$$n ya existe...<Por favor verifique!.>",Exclamation!)
					this.setitem(row,"ch_numero",ls_nulo)
					return 1
				End if
		end if
		
		
		If ls_codigo ='52' then //NOTA DE CREDITO POR ANTICIPO
        
		  	/*Verificar si existe o no el Anticipo*/
			 /*Solo se  puede cruzar notas de cr$$HEX1$$e900$$ENDHEX$$dito realizadas en la misma sucursal*/ 
			select mt_valor
			into :lc_saldonc
 		    from cc_movim
			where tt_codigo = 9 
			and  tt_ioe = 'D'
			and em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and mt_codigo = :data;
			If sqlca.sqlcode <> 0 then
			    messageBox('Error','No existe el D$$HEX1$$e900$$ENDHEX$$bito por Anticipo, verifique informaci$$HEX1$$f300$$ENDHEX$$n',Exclamation!)
  				 this.setitem(row,"ch_numero",ls_nulo)
				 lc_saldonc = 0
				 return 1
			End if

			/*Verificar que no este cruzada la NC*/
			SELECT count(*)
			INTO :ll_count
			FROM CC_CHEQUE
			WHERE TT_CODIGO = '5'
			AND TT_IOE='C'
			AND EM_CODIGO = :str_appgeninfo.empresa
//			AND SU_CODIGO = :str_appgeninfo.sucursal
			AND FP_CODIGO = '52'
			AND CH_NUMERO = :data;
			
			If ll_count > 0 then
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta NC ya ha sido utilizada...<Por favor verifique!.>",Exclamation!)
				lc_saldonc = 0
				this.setitem(row,"ch_numero",ls_nulo)
				return 1
			End if
			
         /*Verificar que no existan duplicados*/
			ll_end = this.RowCount() + 1
         ll_find = 1

         ll_find = this.Find("fp_codigo = '52' and ch_numero = '"+data+"'", ll_find, ll_end)
         DO WHILE ll_find > 0
			if ll_find <> row then 
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya est$$HEX2$$e1002000$$ENDHEX$$ingresada una NC con est$$HEX2$$e9002000$$ENDHEX$$N$$HEX1$$ba00$$ENDHEX$$....<Verifique!>")
				this.setitem(row,"ch_numero",ls_nulo)
            return 1
			end if
			ll_find++
			ll_find = this.Find("fp_codigo = '52' and ch_numero = '"+data+"'", ll_find, ll_end)
         LOOP
						
		this.SetItem(ll_filact,'ch_valor',lc_saldonc)
		lc_valor = This.getItemNumber(this.getrow(),"tot_cheques")
		lc_valret = dw_master.GetItemNumber(dw_master.getrow(),'mt_valret')
		lc_valiva = dw_master.GetItemNumber(dw_master.getrow(),'mt_valiva')
		lc_total = lc_valor + lc_valret + lc_valiva
		dw_master.Setitem(dw_master.Getrow(),"mt_valor",lc_total) 
		lc_saldo = wf_refresca_saldo()
		dw_master.Setitem(dw_master.Getrow(),"mt_saldo",lc_saldo) 
		End if
End if
end event

event dw_detail::ue_postinsert;Long ll_row ,ll_reg,ll_contador_fp


ll_row = This.GetRow()
if ll_row = 0 then return


//Validar que solo ingrese un registro si la fp es cheque o efectivo
if wf_valida_fp() < 0 then
	return 1
end if

This.SetItem(ll_row,"ch_fecefec",id_ahora)
Return 0
end event

event dw_detail::ue_postdelete;call super::ue_postdelete;/*Actualizar el valor de Pago y el saldo*/
decimal{2} lc_pago,lc_saldo
long       ll_row,ll_rowm

ll_row = this.getrow()
ll_rowm = dw_master.getrow()

if ll_row = 0 then 
	dw_master.setitem(ll_rowm,'mt_valor',0)
	dw_master.setitem(ll_rowm,'mt_saldo',0)
	wf_recupera_pendientes()
	return
end if

lc_pago = this.getitemdecimal(ll_row,"tot_cheques")
lc_saldo = wf_refresca_saldo()

if lc_saldo <= 0 then 
	/*Recalcula el nuevo saldo*/
	wf_recupera_pendientes()
	lc_saldo = wf_refresca_saldo()
end if	

dw_master.setitem(ll_rowm,'mt_valor',lc_pago)
dw_master.setitem(ll_rowm,'mt_saldo',lc_saldo)


end event

event dw_detail::itemerror;return 1	
end event

event dw_detail::rowfocuschanged;call super::rowfocuschanged;SetRowFocusIndicator(Hand!)
end event

event dw_detail::buttonclicked;call super::buttonclicked;

if dwo.name = 'b_1' then
	this.Setrow(row)
	parent.triggerevent("ue_print")
end if

return 1
end event

type dw_report from w_sheet_master_detail`dw_report within w_movimiento_credito_cxc
integer x = 27
integer y = 16
integer width = 3470
integer height = 1728
integer taborder = 0
string dataobject = "d_nc_cxc_preimpresa"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_report::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

event dw_report::constructor;call super::constructor;dw_report.setTransObject(sqlca)
end event

type dw_ubica from datawindow within w_movimiento_credito_cxc
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 1202
integer y = 100
integer width = 1632
integer height = 344
integer taborder = 40
boolean titlebar = true
string title = "Buscar Registro"
string dataobject = "d_busca_cxc"
boolean border = false
boolean livescroll = true
end type

event ue_dwnkey;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event itemchanged;string ls, ls_criterio, ls_tipo
long ll_found

CHOOSE CASE this.GetColumnName()

	CASE 'factura'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "mt_codigo = " +  +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('tt_codigo')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Registro no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "mt_codigo like " +  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
    		   dw_master.SetColumn('tt_codigo')
				this.Visible = false	
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE
	CASE 'proveedor'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ce_codigo = " +  +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('ce_codigo')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Registro no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ce_codigo like " +  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
			   dw_master.SetColumn('ce_codigo')
				this.Visible = false				
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE		

END CHOOSE
end event

type st_1 from statictext within w_movimiento_credito_cxc
integer x = 73
integer y = 616
integer width = 512
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 81324524
string text = "Recepci$$HEX1$$f300$$ENDHEX$$n de pago"
boolean focusrectangle = false
end type

type dw_cruce from uo_dw_detail within w_movimiento_credito_cxc
event ue_guardar pbm_custom30
event ue_keydown pbm_dwnkey
event ue_tabout pbm_dwntabout
integer x = 2994
integer y = 20
integer width = 2610
integer height = 1784
integer taborder = 30
boolean bringtotop = true
string title = "Cruzar Movimiento"
string dataobject = "d_cruce_cxc"
boolean hscrollbar = false
boolean livescroll = false
end type

event ue_guardar;///////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Actualizo el Saldo del d$$HEX1$$e900$$ENDHEX$$bito en CC_MOVIM, por cada
//               fila del detalle de pago.
// de la cabecera
// Fecha de Ultima revisi$$HEX1$$f300$$ENDHEX$$n : 08/04/1999  11:39
///////////////////////////////////////////////////////////////////

int li, li_filmas, ll_max
string ls_num_mov, ls_tipo, ls_ioe, ls_mt_coddeb, ls_tt_coddeb
decimal lc_valor


li_filmas = dw_master.GetRow()
if li_filmas = 0 then return -1

// encuentro el n$$HEX1$$fa00$$ENDHEX$$mero de movimiento, tipo y si es ingreso
// o egreso del maestro

ls_num_mov = dw_master.GetItemString(li_filmas,'mt_codigo')
ls_tipo    = dw_master.GetItemString(li_filmas,'tt_codigo')
ls_ioe     = dw_master.GetItemString(li_filmas,'tt_ioe')
ll_max     = this.RowCount()

// por cada fila del cruce hacer
for li = 1 to ll_max
	// encuentra el valor del cruce
	lc_valor = this.GetItemNumber(li,'cr_valdeb')  

	//Actualizo el Saldo del d$$HEX1$$e900$$ENDHEX$$bito en CC_MOVIM
	if lc_valor > 0 then
		this.SetItem(li,'cr_fecha',id_hoy)
		ls_tt_coddeb = this.GetItemString(li, "tt_coddeb")
	   ls_mt_coddeb =  this.GetItemString(li, "mt_coddeb")
		
		update cc_movim
		set mt_saldo = mt_saldo - :lc_valor
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :str_appgeninfo.sucursal
		and tt_codigo = :ls_tt_coddeb
		and tt_ioe = 'D'
		and mt_codigo = :ls_mt_coddeb;
		
		if sqlca.sqlcode < 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el saldo del Mov.de D$$HEX1$$e900$$ENDHEX$$bito..."+sqlca.sqlerrtext)
		rollback;
		return -1
   	end if
		

	else
		this.SetItemStatus(li,0, Primary!,NotModified!)
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
decimal lc_saldo, lc_valor

This.AcceptText()
ll_filact = this.getRow()
ll_filmas = dw_master.GetRow()


if (KeyDown(KeyControl!)) and (KeyDown(KeyEnter!)) then
// encuentra el saldo del maestro y el saldo de la fila actual del detalle
	ll_filact = this.GetRow()
   lc_saldo  = dw_master.getitemdecimal(ll_filmas,'mt_saldo')
	lc_valor  = this.GetItemNumber(ll_filact,"mt_saldo")
	// si el saldo de restar el maestro del detalle es negativo
	// asigno en el valora pagar solo lo del maestro y en el maestro
	// asigno cero de salo
	if lc_saldo = 0 then return
	if lc_saldo < lc_valor  then
   	this.SetItem(ll_filact,"cr_valdeb", dw_master.GetItemNumber(ll_filmas, 'mt_saldo')) 
 	else
	// si el saldo de la resta es positivo asigno todo el valor del
	// detalle al pago y en el maestro asigno la diferencia	
 		this.SetItem(ll_filact,"cr_valdeb",lc_valor)
 	end if

	lc_saldo = wf_refresca_saldo()
	dw_master.SetItem(ll_filmas,'mt_saldo',lc_saldo) 
end if
end event

event ue_tabout;long ll_filact, ll_filmas
dec{2} lc_valor,lc_saldo


/*Se utiliza cuando se escribe el valor*/
If rowcount() = 1 Then
 This.AcceptText()
 ll_filmas = dw_master.GetRow()
 If getcolumnname() =  "cr_valdeb" Then
   lc_valor = dec(GetText())
   //Actualizo el saldo del movimiento de cr$$HEX1$$e900$$ENDHEX$$dito
	lc_saldo = dw_master.GetItemDecimal(ll_filmas, 'mt_saldo')
	lc_saldo = lc_saldo - lc_valor
	If lc_saldo < 0 then
	   messageBox ("Error", "El valor no puede superar el saldo del cr$$HEX1$$e900$$ENDHEX$$dito")
		this.SetItem(getrow(),"cr_valdeb",0)
      /*Recalcular el saldo*/ 
      lc_saldo = wf_refresca_saldo()
	   dw_master.SetItem(ll_filmas, 'mt_saldo', lc_saldo)
      return 1
	end if
   lc_saldo = wf_refresca_saldo()
	dw_master.SetItem(ll_filmas, 'mt_saldo', lc_saldo)
 End if
	
End if
end event

event itemchanged;call super::itemchanged;long   ll_filmas
dec{2} lc_saldo


This.AcceptText()
ll_filmas = dw_master.GetRow()

If rowcount() = 1 then return
If getcolumnname() =  "cr_valdeb" Then
//Actualizo el saldo del movimiento de cr$$HEX1$$e900$$ENDHEX$$dito
lc_saldo = wf_refresca_saldo()
dw_master.SetItem(ll_filmas, 'mt_saldo', lc_saldo)
End if

end event

type dw_nc from datawindow within w_movimiento_credito_cxc
boolean visible = false
integer x = 837
integer y = 140
integer width = 2857
integer height = 1012
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Cr$$HEX1$$e900$$ENDHEX$$ditos pendientes"
string dataobject = "d_um_mov_pendientes"
boolean controlmenu = true
boolean vscrollbar = true
boolean border = false
end type

event rowfocuschanged;This.SetRowFocusIndicator(Hand!)
end event

event doubleclicked;//Recuperar credito pendiente
String ls_movcre,ls_ttcodigo,ls_ttioe,ls_suc

if row = 0 then return

ls_ttcodigo = this.Object.tt_codigo[row]
ls_ttioe =     this.Object.tt_ioe[row]
ls_movcre = this.Object.mt_codigo[row]

//istr_argInformation.StringValue[1] = str_appgeninfo.empresa
//istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
//istr_argInformation.StringValue[3] = ls_movcre
//istr_argInformation.StringValue[4] = ls_ttcodigo
//

if dw_master.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_movcre,ls_ttcodigo) > 0 then
	dw_detail.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_movcre,ls_ttcodigo,ls_ttioe)
end if

string ls_nomcli,ls_cliente
Long ll_row

If dw_master.rowcount() = 0 Then return
	
ls_cliente = dw_master.getitemstring(1,"ce_codigo")
select ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep))
into :ls_nomcli
from fa_clien
where em_codigo = :str_appgeninfo.empresa
and ce_codigo = :ls_cliente;


wf_recupera_pendientes()
ll_row = dw_master.getrow()
ic_saldo_nc = dw_master.GetitemDecimal(ll_row,'mt_saldo')

dw_master.modify(" st_nombre.text ='"+ls_nomcli+"'")
dw_master.enabled = true
end event

event buttonclicked;if dwo.name = 'b_1' then
this.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
end if
end event

type shl_1 from statichyperlink within w_movimiento_credito_cxc
integer x = 2235
integer y = 52
integer width = 544
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
long backcolor = 81324524
string text = " Cr$$HEX1$$e900$$ENDHEX$$ditos Pendientes:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_movimiento_credito_cxc
integer x = 2807
integer y = 40
integer width = 146
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 81324524
boolean focusrectangle = false
end type

event doubleclicked;if dw_nc.visible then
dw_nc.visible = false
else
	dw_nc.visible = true
end if
end event


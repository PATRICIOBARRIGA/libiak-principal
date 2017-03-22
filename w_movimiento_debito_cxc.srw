HA$PBExportHeader$w_movimiento_debito_cxc.srw
$PBExportComments$Si.Debitos de clientes del sistema
forward
global type w_movimiento_debito_cxc from w_sheet_1_dw_maint
end type
type dw_master from datawindow within w_movimiento_debito_cxc
end type
end forward

global type w_movimiento_debito_cxc from w_sheet_1_dw_maint
integer width = 2912
integer height = 1532
string title = "Movimiento de D$$HEX1$$e900$$ENDHEX$$bito (Cuentas por Cobrar)"
long backcolor = 79741120
dw_master dw_master
end type
global w_movimiento_debito_cxc w_movimiento_debito_cxc

type variables
long il_nreg
end variables

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();long ll_filAct
string ls_mt_numero, ls_tt_codigo, ls_valletras,ls_fp
decimal lc_valor
int li_res

ll_filAct = dw_datos.getRow()
ls_mt_numero = dw_datos.getItemString(ll_filAct, "mt_codigo")
ls_tt_codigo = dw_datos.getItemString(ll_filAct, "tt_codigo")
lc_valor = dw_datos.getItemNumber(ll_filAct, "mt_valor")
ls_valletras = f_numero_a_letras (lc_valor)
dw_report.setTransObject(sqlca)
dw_report.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,ls_tt_codigo, ls_mt_numero,ls_valletras)   
return 1

end function

event open;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n :  llena la estructura istr_argInformation, luego le indica 
//                la columna que se va asignar el c$$HEX1$$f300$$ENDHEX$$digo secuencial y el
// nombre de la columna de pr_param de donde se va a tomar el secuencial
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : E.V.  10/05/2004 15:27 
/*********************************************************************/

ib_notautoretrieve = true
f_recupera_empresa(dw_datos,"tt_codigo") 
f_recupera_empresa(dw_datos,"if_codigo") 

dw_master.InsertRow(0)
dw_datos.SetRowFocusIndicator(hand!)

istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal

dw_datos.is_SerialCodeColumn = "mt_codigo"
dw_datos.is_SerialCodeType = "NUM_ND"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

call super::open

end event

on w_movimiento_debito_cxc.create
int iCurrent
call super::create
this.dw_master=create dw_master
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_master
end on

on w_movimiento_debito_cxc.destroy
call super::destroy
destroy(this.dw_master)
end on

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)

if this.ib_inReportMode then
   dw_report.resize(this.workSpaceWidth() - 2*dw_report.x, this.workSpaceHeight() - 2*dw_report.y)
	dw_master.visible = false	
else
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	dw_datos.resize(dw_master.width,li_height - dw_master.y - dw_master.height)
	dw_master.visible = true
end if

this.setRedraw(True)
end event

event ue_retrieve;string ls_nombre, ls_cliente

dw_master.accepttext()
ls_cliente = dw_master.getitemstring(1,"cliente")

if not isnull(ls_cliente) and trim(ls_cliente) <> ""  then
	Select ltrim(decode(length(ce_rucic),13,'R.U.C.: '||ce_rucic||' '||ce_razons||' '||ce_nomrep||' '||ce_aperep,ce_nombre||'  '||ce_apelli))
	into :ls_nombre
	from fa_clien
	where em_codigo = :str_appgeninfo.empresa
	and ce_codigo = :ls_cliente;
	if sqlca.sqlcode <> 0 then
		messageBox('Error','Cliente no registrado')
		dw_master.selecttext(1,len(ls_cliente))
		return
	End if
	dw_master.modify("st_cliente.text = '"+ls_nombre+"'")	
end if

il_nreg = dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cliente)
if il_nreg < 1 then
	beep(1)
	messageBox('Error','No existen movimientos de d$$HEX1$$e900$$ENDHEX$$bito para este cliente')
	dw_master.modify("st_cliente.text = ''")	
end if			

end event

event ue_update;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n :  Asigna datos internos al dw, actualiza el cupo de 
// 		              cr$$HEX1$$e900$$ENDHEX$$dito del cliente y registra el n$$HEX1$$fa00$$ENDHEX$$mero de cheques
// 					protestados en caso de ser el d$$HEX1$$e900$$ENDHEX$$bito por cheque protestado.
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : Edivas 10/05/2007  16:55 
/*********************************************************************/

dwItemStatus l_status
long li, ll_max
string ls_clien, ls_cuenta, ls_tipo,ls_banco
decimal lc_valor,ld_valor

ll_max = dw_datos.GetRow()
ls_clien = dw_master.GetItemString(dw_master.GetRow(),'cliente')

for li = 1 to ll_max
  	l_status = 	dw_datos.GetItemStatus(li, 0, Primary!)
	// si se insertaron filas en el detalle  
	if l_status = NewModified! then
	   dw_datos.SetItem(li, 'ce_codigo', ls_clien)
		dw_datos.SetItem(li,"em_codigo",str_appgeninfo.empresa)
		dw_datos.SetItem(li,"su_codigo",str_appgeninfo.sucursal)
		lc_valor = dw_datos.GetItemNumber(li,'mt_valor')
		
		// disminuye el saldo de cr$$HEX1$$e900$$ENDHEX$$dito del cliente
		UPDATE FA_CLIEN
		SET CE_SALCRE = CE_SALCRE - :lc_valor
		WHERE CE_CODIGO = :ls_clien
		AND EM_CODIGO = :str_appgeninfo.empresa;
		if sqlca.sqlcode <> 0 then
			messageBox('Error Interno', 'Funci$$HEX1$$f300$$ENDHEX$$n wf_acualiza_saldo_cupo ' +sqlca.sqlerrtext)
			return -1
		end if
		
		ls_tipo = dw_datos.GetItemString(li,'tt_codigo')
		//si el tipo es cheque devuelto, llevo las estad$$HEX1$$ed00$$ENDHEX$$sticas
		choose case ls_tipo
		case '2','10','13','14'
			ls_cuenta = dw_datos.GetItemString(li,'mt_ctacli')
			ls_banco = dw_datos.GetItemString(li,'if_codigo')
			ld_valor = dw_datos.GetItemNumber(li,'mt_valor')
			if isnull(ls_cuenta) or ls_cuenta = '' or isnull(ls_banco) or ls_banco = '' then 
				messageBox('Revise Informaci$$HEX1$$f300$$ENDHEX$$n','Ingrese los datos del cheque devuelto')
				return -1
			end if
		end choose
	end if
next
//		UPDATE "FA_CLIEN"
//			   SET "FA_CLIEN"."CE_FACTURAR" = 'N'
//		 WHERE "FA_CLIEN"."CE_CODIGO" = :ls_clien
//			   AND EXISTS (
//			SELECT "FA_CLIEN"."CE_CODIGO"
//			  FROM "FA_VENTA",   
//					"FA_RECPAG",   
//					"FA_FORMPAG",   
//					"CC_MOVIM"  
//			 WHERE ( "FA_RECPAG"."ES_CODIGO" = "FA_VENTA"."ES_CODIGO" ) and  
//					( "FA_RECPAG"."EM_CODIGO" = "FA_VENTA"."EM_CODIGO" ) and  
//					( "FA_RECPAG"."SU_CODIGO" = "FA_VENTA"."SU_CODIGO" ) and  
//					( "FA_RECPAG"."BO_CODIGO" = "FA_VENTA"."BO_CODIGO" ) and  
//					( "FA_RECPAG"."VE_NUMERO" = "FA_VENTA"."VE_NUMERO" ) and  
//					( "FA_FORMPAG"."FP_CODIGO" = "FA_RECPAG"."FP_CODIGO" ) and  
//					( "FA_FORMPAG"."EM_CODIGO" = "FA_RECPAG"."EM_CODIGO" ) and  
//					( "CC_MOVIM"."ES_CODIGO" = "FA_VENTA"."ES_CODIGO" ) and  
//					( "CC_MOVIM"."EM_CODIGO" = "FA_VENTA"."EM_CODIGO" ) and  
//					( "CC_MOVIM"."SU_CODIGO" = "FA_VENTA"."SU_CODIGO" ) and  
//					( "CC_MOVIM"."BO_CODIGO" = "FA_VENTA"."BO_CODIGO" ) and  
//					( "CC_MOVIM"."VE_NUMERO" = "FA_VENTA"."VE_NUMERO" ) and  
//					( "CC_MOVIM"."CE_CODIGO" = "FA_VENTA"."CE_CODIGO" ) and  
//					( ( "FA_VENTA"."ES_CODIGO" = '1' ) AND  
//					( "FA_VENTA"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
//					( "FA_VENTA"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
//					( TRUNC("FA_VENTA"."VE_FECHA" + "FA_FORMPAG"."FP_PLAZO") < SYSDATE ) AND  
//					( "FA_FORMPAG"."FP_PLAZO" > 0 ) AND  
//					( "CC_MOVIM"."MT_SALDO" > 0 ) AND
//					( TRUNC(SYSDATE - ("FA_VENTA"."VE_FECHA" + "FA_FORMPAG"."FP_PLAZO")) > 10 ) AND
//					( "FA_CLIEN"."CE_CODIGO" = :ls_clien))
//					UNION
//			SELECT "CC_MOVIM"."CE_CODIGO"
//			  FROM "CC_MOVIM"
//			 WHERE ( "CC_MOVIM"."TT_CODIGO" <> '1' ) AND  
//					( "CC_MOVIM"."TT_IOE" = 'D' ) AND  
//					( "CC_MOVIM"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
//					( "CC_MOVIM"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
//					( "CC_MOVIM"."CE_CODIGO" = :ls_clien) AND
//					( trunc("CC_MOVIM"."MT_FECHA") < SYSDATE ) AND  
//					( "CC_MOVIM"."MT_SALDO" > 0 )
//					);
commit;
call super::ue_update

end event

event ue_delete;dwitemstatus lstatus
Long     ll_row
ll_row =  dw_datos.GetRow()
lstatus = dw_datos.GetitemStatus(ll_row,0,Primary!)

If lstatus = Newmodified!  or lstatus = New! then
dw_datos.deleterow(0)
return 1
else
return -1
end if	


end event

event closequery;int li_res
long ll_reg

ll_reg = dw_datos.rowcount()
if  ll_reg > il_nreg then
	li_res = messageBox(this.title, &
						"Hay cambios que no se han guardado~n" + &
						"$$HEX1$$bf00$$ENDHEX$$Desea guardarlos?", Question!, YesNoCancel!)
	choose case li_res
		case 1
			if dw_datos.uf_updateCommit() = -1 then
				message.returnValue = 1
			end if
			return
		case 2
			return
		case 3
			message.returnValue = 1
			return
	end choose
end if

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_movimiento_debito_cxc
integer y = 172
integer width = 2885
integer height = 1252
integer taborder = 20
string dataobject = "d_movimiento_debito_cxc"
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::itemchanged;call super::itemchanged;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n :  Controla que el valor no sea negativo
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : EdiVas
/*********************************************************************/
long ll_filact
ll_filact = this.getRow()
CHOOSE CASE this.getColumnName()
CASE "mt_valor"
	if  dec(this.GetText()) < 0 then
   		messageBox ("Error", "El valor no puede ser negativo")
		this.ib_inErrorCascade = True
	   	return 1
	end if
	this.SetItem(ll_filact,"mt_saldo",dec(this.GetText()))
	
END CHOOSE
end event

event dw_datos::retrieveend;call super::retrieveend;//long i,ll_plazo
//string ls_fp
//decimal lc_venumero
//date  ld_fecha,ld_vencimiento
//
//for i=1 to rowcount
//   lc_venumero = this.getitemnumber(i,"ve_numero")
//	ld_fecha = date(this.getitemdatetime(i,"mt_fecha"))
//	
//	select fp_descri,fp_plazo
//	into :ls_fp,:ll_plazo
//	from fa_recpag x,fa_formpag y
//	where x.em_codigo = y.em_codigo
//	and x.fp_codigo = y.fp_codigo
//	and x.em_codigo = :str_appgeninfo.empresa
//	and x.su_codigo = :str_appgeninfo.sucursal
//	and x.bo_codigo = :str_appgeninfo.seccion
//	and x.es_codigo = '1'
//	and x.ve_numero = :lc_venumero;
//
//   ld_vencimiento = relativedate(ld_fecha,ll_plazo)  
//   this.object.cc_fp[i] = ls_fp
//   this.object.cc_plazo[i] = string(ld_vencimiento)
//next
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_movimiento_debito_cxc
integer y = 4
integer width = 119
integer taborder = 0
string dataobject = "d_nd_cxc_preimpresa"
end type

type dw_master from datawindow within w_movimiento_debito_cxc
event ue_keydown pbm_dwnkey
integer width = 4965
integer height = 172
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_cliente"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n :  Recuperar todos los d$$HEX1$$e900$$ENDHEX$$bitos con saldo > 0 del cliente
//                y si no se recupera verifico si esta registrado
// el cliente. Si esta registrado inserto una fila del detalle, sino mensaje. 
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : Edivas 04/05/2004 
/*********************************************************************/
parent.triggerevent("ue_retrieve")

end event


HA$PBExportHeader$w_cuentasxcliente.srw
$PBExportComments$Cuentas de un cliente dado
forward
global type w_cuentasxcliente from w_sheet_1_dw_maint
end type
type dw_master from datawindow within w_cuentasxcliente
end type
end forward

global type w_cuentasxcliente from w_sheet_1_dw_maint
integer width = 2912
integer height = 1888
string title = "Cuentas Corrientes por Cliente"
long backcolor = 79741120
dw_master dw_master
end type
global w_cuentasxcliente w_cuentasxcliente

forward prototypes
public function integer wf_preprint ()
public function integer wf_actualiza_crea_cuenta (string as_clien, string as_banco, string as_numero, integer ad_valor)
end prototypes

public function integer wf_preprint ();long ll_filAct
string ls_mt_numero, ls_tt_codigo, ls_valletras
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

public function integer wf_actualiza_crea_cuenta (string as_clien, string as_banco, string as_numero, integer ad_valor);string ls, ls_clien, ls_rucci,ls_tipo
long li_res,ll_max, li

Select ce_codigo
  into :ls
  from fa_ctacli
 where if_codigo = :as_banco
	and cs_numero = :as_numero;
if sqlca.sqlcode <> 0 then
  //No existe, inserto la cuenta con estado P (Protestada)
  INSERT INTO "FA_CTACLI"( "IF_CODIGO", "CS_NUMERO","CE_CODIGO","CS_VALCHE",   
									"CS_VALPRO", "CS_NUMCHE","CS_NUMPRO","CS_ESTADO" )  
		 VALUES (:as_banco,:as_numero,:as_clien,0,:ad_valor,0,1,'P')  ;
		 commit;
else
	if ls = as_clien then
		Update fa_ctacli
			set cs_valpro = cs_valpro + :ad_valor,
				 cs_numpro = cs_numpro + 1,
				 cs_estado = 'P'
		 where if_codigo = :as_banco
			and cs_numero = :as_numero;
			commit;
	else
	  SELECT "FA_CLIEN"."CE_CODIGO"||' '||NVL("FA_CLIEN"."CE_RAZONS",'')||' / '||DECODE("FA_CLIEN"."CE_TIPO",'N',"FA_CLIEN"."CE_NOMBRE"||' '||"FA_CLIEN"."CE_APELLI","FA_CLIEN"."CE_NOMREP"||' '||"FA_CLIEN"."CE_APEREP") "cliente",   
				"FA_CLIEN"."CE_RUCIC"  
		 INTO :ls_clien,   
				:ls_rucci  
		 FROM "FA_CLIEN"  
		WHERE "FA_CLIEN"."EM_CODIGO" = :str_appgeninfo.empresa
		  AND "FA_CLIEN"."CE_CODIGO" = :ls;
		li_res = messageBox('Confirme por favor','Esta cuenta fue ya asignada al cliente ' + ls_clien + ' de RUC/CI ' + ls_rucci + '. Desea reemplazar ? ',Question!,YesNoCancel!)
		CHOOSE CASE li_res
			CASE 1
				Update fa_ctacli
					set cs_valpro = cs_valpro + :ad_valor,
						 cs_numpro = cs_numpro + 1,
						 ce_codigo = :as_clien,
				       cs_estado = 'P'						 
				 where if_codigo = :as_banco
					and cs_numero = :as_numero;
					commit;
			CASE 2
				Update fa_ctacli
					set cs_valpro = cs_valpro + :ad_valor,
						 cs_numpro = cs_numpro + 1,
				 		 cs_estado = 'P'						 
				 where if_codigo = :as_banco
					and cs_numero = :as_numero;
					commit;
			CASE 3
					return -1
			end choose
   end if						
  end if
return 1
end function

event open;ib_notautoretrieve = true

f_recupera_empresa(dw_datos,"if_codigo") 
//f_recupera_empresa(dw_master,'cliente')


dw_master.InsertRow(0)
dw_master.SetFocus()
dw_master.PostEvent(Clicked!)

//istr_argInformation.nrArgs = 2
//istr_argInformation.argType[1] = "string"
//istr_argInformation.argType[2] = "string"
//istr_argInformation.StringValue[1] = str_appgeninfo.empresa
//istr_argInformation.StringValue[2] = str_appgeninfo.sucursal

call super::open


end event

on w_cuentasxcliente.create
int iCurrent
call super::create
this.dw_master=create dw_master
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_master
end on

on w_cuentasxcliente.destroy
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

event ue_retrieve;string ls_nombre, ls_cliente, ls_cuenta

dw_master.accepttext()
ls_cliente = dw_master.getitemstring(1,"cliente")
ls_cuenta = dw_master.getitemstring(1,"cuenta")

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
else
	ls_cliente = 'x%$'
end if

if dw_datos.retrieve(ls_cliente,ls_cuenta) < 1 then
	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','El cliente no tiene cuentas o no hay la cuenta')
	dw_master.modify("st_cliente.text = ''")
else
	if not isnull(ls_cuenta) and trim(ls_cuenta) <> "" then 	
		dw_datos.setfilter("cs_numero = '"+ls_cuenta+"'")
		dw_datos.filter()
	else
		dw_datos.setfilter("")
		dw_datos.filter()
	end if
	dw_datos.SetFocus()
	
end if


end event

event ue_insert;beep(1)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_cuentasxcliente
integer y = 224
integer width = 2885
integer height = 1568
string dataobject = "d_cuentasxcliente"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
decimal ld_saldo, lc_retencion, lc_valret, lc
dataWindowChild ldwc_aux
string ls_cliente, ls_firma, LS
ll_filact = this.getRow()

CHOOSE CASE this.getColumnName()

//CASE "ce_codigo"
//
//ls_cliente = this.GetText()
//select ce_firma
//into :ls_firma
//from fa_clien
//where em_codigo = :str_appgeninfo.empresa
//  and ce_codigo = :ls_cliente;
//if sqlca.sqlcode <> 0 then
//   messageBox ("Error", 'Cliente no registrado')
//	this.ib_inErrorCascade = True
//   return 1	
//end if  
//this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
//this.SetItem(ll_filact,"su_codigo",str_appgeninfo.sucursal)
//
CASE "mt_valor"

 if  dec(this.GetText()) < 0 then
   messageBox ("Error", "El valor no puede ser negativo")
	this.ib_inErrorCascade = True
   return 1
end if
this.SetItem(ll_filact,"mt_saldo",dec(this.GetText()))

END CHOOSE

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_cuentasxcliente
integer x = 37
integer y = 272
integer width = 123
integer height = 100
string dataobject = "d_reporte_movimiento_debito_cxc"
end type

type dw_master from datawindow within w_cuentasxcliente
event ue_keydown pbm_dwnkey
integer width = 4965
integer height = 224
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_cliente_cta"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if (KeyDown(KeyF2!))	 then
	dw_master.Reset()
	dw_datos.Reset()
	dw_master.InsertRow(0)
	dw_master.SetFocus()
end if
end event

event clicked;
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = true
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_master.GetRow() 
dw_master.SetFocus()
end event


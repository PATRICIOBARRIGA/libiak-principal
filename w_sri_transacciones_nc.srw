HA$PBExportHeader$w_sri_transacciones_nc.srw
$PBExportComments$Si.Movimientos de credito en CXP... (Facturas de servicio). Vale
forward
global type w_sri_transacciones_nc from w_sheet_1_dw_maint
end type
type dw_ubica from datawindow within w_sri_transacciones_nc
end type
type dw_1 from datawindow within w_sri_transacciones_nc
end type
type em_1 from editmask within w_sri_transacciones_nc
end type
type em_2 from editmask within w_sri_transacciones_nc
end type
type st_3 from statictext within w_sri_transacciones_nc
end type
type st_1 from statictext within w_sri_transacciones_nc
end type
type dw_fp from datawindow within w_sri_transacciones_nc
end type
type st_4 from statictext within w_sri_transacciones_nc
end type
type dw_codair from datawindow within w_sri_transacciones_nc
end type
type st_2 from statictext within w_sri_transacciones_nc
end type
end forward

global type w_sri_transacciones_nc from w_sheet_1_dw_maint
integer width = 4311
integer height = 2548
string title = "(*) Movimientos de Cr$$HEX1$$e900$$ENDHEX$$dito"
long backcolor = 79741120
boolean ib_notautoretrieve = true
event ue_consultar pbm_custom28
dw_ubica dw_ubica
dw_1 dw_1
em_1 em_1
em_2 em_2
st_3 st_3
st_1 st_1
dw_fp dw_fp
st_4 st_4
dw_codair dw_codair
st_2 st_2
end type
global w_sri_transacciones_nc w_sri_transacciones_nc

type variables
String is_ctaret,is_ctaiva
Decimal ic_iva	
datawindowchild dwc_cuentas,dwc_tipo,idwc_reten


end variables

forward prototypes
public function integer wf_anular_deuda ()
public function integer wf_preprint ()
end prototypes

event ue_consultar;dw_datos.postevent(DoubleClicked!)
dw_datos.enabled = true
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

ll_row      = dw_datos.getRow()
ls_mpcodigo = dw_datos.getItemString(ll_row,"mp_codigo")
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mpcodigo)

return 1
end function

on w_sri_transacciones_nc.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.dw_1=create dw_1
this.em_1=create em_1
this.em_2=create em_2
this.st_3=create st_3
this.st_1=create st_1
this.dw_fp=create dw_fp
this.st_4=create st_4
this.dw_codair=create dw_codair
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_fp
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.dw_codair
this.Control[iCurrent+10]=this.st_2
end on

on w_sri_transacciones_nc.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.dw_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.dw_fp)
destroy(this.st_4)
destroy(this.dw_codair)
destroy(this.st_2)
end on

event open;Integer li_rc

dw_report.SetTransObject(sqlca)
f_recupera_empresa(dw_datos,'tv_codigo')
f_recupera_empresa(dw_datos,"pv_codigo")
f_recupera_empresa(dw_report,"tv_codigo")
f_recupera_empresa(dw_report,"pv_codigo")



istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"

istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal


//ib_notautoretrieve = true
//ib_inReportMode = false

call super::open

dw_datos.is_SerialCodeColumn = "mp_codigo"
dw_datos.is_SerialCodeType = "CRE_CXP"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
//dw_datos.uf_insertcurrentrow()

ic_iva = f_iva()
dw_1.SetTransObject(sqlca)
dw_codair.SetTransObject(sqlca)
dw_fp.SetTransObject(sqlca)
li_rc = dw_fp.sharedata(dw_codair)
em_1.text = '01/01/2015'
em_2.text = '01/02/2015'



end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
//if this.ib_inReportMode then
//	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
//else
dw_1.resize(li_width -20,dw_1.height)
dw_datos.resize(li_width - 2*dw_datos.x, dw_datos.height)

//end if	
this.setRedraw(True)
end event

event ue_print;string ls_range
int li_res,li_rc
w_frame_basic lw_frame
m_frame_basic lm_frame


if this.wf_prePrint() = 1 then
	this.setRedraw(False)
	dw_report.modify("datawindow.print.preview.zoom=95~t" + &
								"datawindow.print.preview=yes")
	dw_datos.enabled = False
	dw_datos.visible = False
	dw_report.enabled = True
	dw_report.visible = True
	this.ib_inReportMode = true
	this.triggerEvent(resize!)		// so the report gets the correct size
	lw_frame = this.parentWindow()
	lm_frame = lw_frame.menuid
	lm_frame.mf_into_report_mode()
	this.setRedraw(True)
end if
openwithparm(w_dw_print_options,dw_report)
li_rc = message.DoubleParm
if li_rc = 1 then	
 dw_report.print()
end if

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

event ue_retrieve;return dw_1.retrieve(date(em_1.text),date(em_2.text),str_appgeninfo.empresa)
end event

event ue_update;Long rc
char lch_estado

lch_estado = dw_datos.getitemstring(dw_datos.getrow(),"cp_movim_estado")
if isnull(lch_estado) or trim(lch_estado) = '' then
	dw_datos.setitem(dw_datos.getrow(),"cp_movim_estado",'S')
end if

rc = dw_datos.update(true,false)
if rc = 1 then
 	dw_datos.resetupdate()
	commit;
	else
	rollback;
	return
end if
end event

event ue_anular;call super::ue_anular;String  ls_mpcoddeb,ls_mpcodigo, ls_tvcodigo,ls_tvtipo,ls_pvcodigo,ls_facpro
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
ld_fecha         = date(dw_datos.Getitemdatetime(ll_row,"mp_fecha",Primary!,true))


/*Permitir la anulaci$$HEX1$$f300$$ENDHEX$$n de la compra solo si es de la misma fecha en la que 
  se  grabo la compra*/

select trunc(sysdate)
into :ld_now
from  dual;

ld_hoy = date(ld_now)

if ld_fecha <> ld_hoy then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El cr$$HEX1$$e900$$ENDHEX$$dito que desea anular no es de hoy d$$HEX1$$ed00$$ENDHEX$$a...No se puede anular",Exclamation!)
   return -1	
end if	




	
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

commit;
dw_datos.reset()
w_marco.SetMicrohelp("Listo ...Movimiento de Cr$$HEX1$$e900$$ENDHEX$$dito anulado completamente")
SetPointer(Arrow!)
return 1



end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_sri_transacciones_nc
integer x = 46
integer y = 520
integer width = 4192
integer height = 1032
integer taborder = 0
string dataobject = "d_sri_transacciones_nc"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
end type

event dw_datos::itemchanged;call super::itemchanged;decimal{2} lc_baseimp,lc_percfte,lc_perciva,lc_perc,&
           lc_reten,lc_iva,lc_total,lc_pagar
String  ls_pvcodigo,ls_codretfte,ls_codretiva,ls_ctaiva,ls_ctaret
long ll_new,ll_count
dwItemStatus l_status

This.accepttext()
if dwo.name = 'mp_codpctiva' then 
this.object.mp_valret[row] = this.object.cc_mpvalret[row]
end if
if dwo.name = "mp_biepctiva" then
this.object.mp_bievlrret[row] = this.object.cc_bievlrret[row]
end if 

if dwo.name = "mp_srvpctiva" then
this.object.mp_srvvlrret[row] = this.object.cc_srvvlrret[row]
end if 

end event

event dw_datos::updateend;call super::updateend;Long   ll_row,ll_numdoc,i
String ls_mpcodigo,ls_tvcodigo,ls_pvcodigo,&
       ls_cofacpro,ls_observ,ls_fpcodigo,&
		 ls_mpcoddeb
Decimal{2} lc_credito,lc_reten,lc_sumaret,lc_saldo
Date ld_fecha
dwitemstatus l_status


ll_row = dw_datos.GetRow()
l_status = dw_datos.GetItemStatus(ll_row,0,Primary!)

If l_status = datamodified! or l_status = notmodified! then
RETURN 0
End if 	

/*2.-Procesar los pagos*/
ls_mpcodigo = dw_datos.getitemstring(ll_row,"mp_codigo")
ls_tvcodigo = dw_datos.getitemstring(ll_row,"tv_codigo")
ls_pvcodigo = dw_datos.getitemstring(ll_row,"pv_codigo")
ls_cofacpro = dw_datos.getitemstring(ll_row,"co_facpro")
lc_credito  = dw_datos.getitemdecimal(ll_row,"mp_valor")
ls_observ   = dw_datos.GetitemString(ll_row,"mp_observ")
ld_fecha    = Date(dw_datos.GetitemDateTime(ll_row,"mp_fecha"))


/*Realizar los mov. de debito . para las Dos tipos de .Retenciones que se realizan */
for i = 1 to 2 
	lc_reten = 0
   if i = 1 then 
	lc_reten  = dw_datos.getitemdecimal(ll_row,"retfte")
	ls_fpcodigo = '6'
	else	
	lc_reten  = dw_datos.getitemdecimal(ll_row,"retiva")
	ls_fpcodigo = '7'
   end if 
   
	lc_sumaret = lc_sumaret + lc_reten
	
	if lc_reten = 0 then continue
		
	SELECT PR_VALOR
	INTO: ls_mpcoddeb
	FROM PR_PARAM
	WHERE PR_NOMBRE = 'DEB_CXP'
	FOR UPDATE OF PR_VALOR;
		
	UPDATE PR_PARAM
	SET PR_VALOR = PR_VALOR + 1
	WHERE PR_NOMBRE = 'DEB_CXP';
	
	IF SQLCA.SQLCODE < 0 &	
	THEN
	MESSAGEBOX("ATENCION","Problemas al Actualizar el secuencial" +sqlca.sqlerrtext)
	ROLLBACK;
	RETURN 1
	END IF

	/*Determinar el secuencial de la retencion*/
	SELECT PS_VALOR
	INTO:ll_numdoc
	FROM PR_NUMSUC
	WHERE PR_NOMBRE = 'RET' 
	AND SU_CODIGO  = :str_appgeninfo.sucursal
	FOR UPDATE OF PS_VALOR;
	
	UPDATE PR_NUMSUC
	SET PS_VALOR = PS_VALOR + 1
	WHERE PR_NOMBRE = 'RET' 
	AND SU_CODIGO  = :str_appgeninfo.sucursal;
	

	/**/
	INSERT INTO "CP_MOVIM"  
				 ("TV_CODIGO","TV_TIPO","EM_CODIGO","SU_CODIGO","MP_CODIGO",   
				  "PV_CODIGO","EC_CODIGO","CO_NUMERO","RF_CODIGO","MP_FECHA",   
				  "MP_VALOR","MP_VALRET","MP_SALDO","ESTADO","MP_CONTAB",   
				  "MP_TRANSPORTE","EG_NUMERO","CO_FACPRO","MP_BASEIMP","MP_OBSERV",   
				  "MP_RETEN" )  
	VALUES ('2','D',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_mpcoddeb,   
	:ls_pvcodigo,null,null,null,:ld_fecha,
	:lc_reten,0,0,null,null, 
	0,	null,	:ls_cofacpro,0,'Retenci$$HEX1$$f300$$ENDHEX$$n en la fuente',NULL);
	
	IF SQLCA.SQLCODE < 0 &	
	THEN
	MESSAGEBOX("ATENCION","Problemas al Actualizar el Mov. de D$$HEX1$$e900$$ENDHEX$$bito" + sqlca.sqlerrtext)
	ROLLBACK;
	RETURN 1
	END IF
	
	/**/
	INSERT INTO "CP_PAGO"  
	( "TV_CODIGO","TV_TIPO","EM_CODIGO","SU_CODIGO","MP_CODIGO",   
	  "PM_SECUENCIA","PM_FECHA","PM_VALOR","PM_FECPA","PM_INTER",   
	  "PM_CXP","IF_CODIGO","CN_CODIGO","PM_DESCUE","ESTADO",   
	  "FP_CODIGO","PM_NUMDOC" )  
	VALUES ('2','D',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_mpcoddeb,   
				1,sysdate,:lc_reten,:ld_fecha,null,   
				null,0,null,0,null,   
				:ls_fpcodigo,:ll_numdoc);
	IF SQLCA.SQLCODE < 0 &	
	THEN
	MESSAGEBOX("ATENCION","Problemas al Registrar el pago" +sqlca.sqlerrtext)
	ROLLBACK;
	RETURN 1
	END IF
	
	/*Cruzar cada pago con el credito */
	INSERT INTO "CP_CRUCE"  
				( "TV_CODDEB","TV_TIPODEB","MP_CODDEB","TV_CODIGO","TV_TIPO",   
				  "EM_CODIGO","SU_CODIGO", "MP_CODIGO","CX_FECHA","CX_VALCRE",
				  "CX_VALDEB","ESTADO" )  
	VALUES ( '2','D',:ls_mpcoddeb,:ls_tvcodigo,'C',
				  :str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_mpcodigo,:ld_fecha,:lc_reten,   
				  0,null )  ;
	
	IF SQLCA.SQLCODE < 0 &	
	THEN
	MESSAGEBOX("ATENCION","Problemas al Cruzar el pago" +sqlca.sqlerrtext)
	ROLLBACK;
	RETURN 1
	END IF

Next

/*Actualizar el saldo*/
lc_saldo = lc_credito - lc_sumaret

UPDATE "CP_MOVIM"
SET "MP_SALDO" = :lc_saldo
WHERE  "TV_CODIGO"= :ls_tvcodigo
AND "TV_TIPO"  ='C'
AND "EM_CODIGO" = :str_appgeninfo.empresa
AND "SU_CODIGO"= :str_appgeninfo.sucursal
AND "MP_CODIGO"= :ls_mpcodigo;
IF SQLCA.SQLCODE < 0 &	
THEN
MESSAGEBOX("ATENCION","Problemas al Actualizar la Cuenta por Pagar" +sqlca.sqlerrtext)
ROLLBACK;
RETURN 1
END IF

COMMIT;
RETURN 0

end event

event dw_datos::ue_postinsert;call super::ue_postinsert;/*Inicializamos la fecha con la del servidor*/
long ll_row

ll_row = This.getrow()
if ll_row = 0 then return
This.setitem(ll_row,"mp_fecha",f_hoy())
end event

event dw_datos::doubleclicked;call super::doubleclicked;dw_datos.enabled = true
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true

end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;if currentrow = 0 then
//dw_codair.reset()
dw_fp.reset()
return
end if
//dw_fp.retrieve(this.getitemstring(currentrow,"mp_codigo"),str_appgeninfo.empresa,str_appgeninfo.sucursal,this.getitemstring(currentrow,"tv_codigo"),this.getitemstring(currentrow,"tv_tipo"))
end event

event dw_datos::retrieverow;call super::retrieverow;dw_fp.retrieve(this.getitemstring(row,"mp_codigo"),str_appgeninfo.empresa,str_appgeninfo.sucursal,this.getitemstring(row,"tv_codigo"),this.getitemstring(row,"tv_tipo"))
//dw_fp.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,this.getitemstring(row,"mp_codigo"))
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_sri_transacciones_nc
integer x = 2423
integer y = 1612
integer width = 827
integer height = 208
integer taborder = 0
boolean hscrollbar = false
boolean vscrollbar = false
end type

type dw_ubica from datawindow within w_sri_transacciones_nc
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 585
integer y = 220
integer width = 1513
integer height = 272
integer taborder = 10
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
ll_nreg = dw_datos.retrieve(ls_numero,str_appgeninfo.empresa,str_appgeninfo.sucursal)
End if 
end event

type dw_1 from datawindow within w_sri_transacciones_nc
integer x = 46
integer y = 112
integer width = 4192
integer height = 380
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sri_lista_de_transacciones_nc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event rowfocuschanged;String ls_tvcodigo,ls_tvtipo,ls_mpcodigo

if currentrow = 0 then 
	dw_datos.reset()
	return
end if


ls_tvcodigo = dw_1.getitemString(currentrow,"cp_movim_tv_codigo")
ls_tvtipo = dw_1.getitemString(currentrow,"cp_movim_tv_tipo")
ls_mpcodigo = dw_1.getitemstring(currentrow,"cp_movim_mp_codigo")
dw_datos.retrieve(str_appgeninfo.empresa,ls_tvcodigo,ls_tvtipo,ls_mpcodigo)

dw_datos.scrolltorow(dw_datos.getrow())
dw_datos.setrow(dw_datos.getrow())

end event

type em_1 from editmask within w_sri_transacciones_nc
integer x = 681
integer y = 16
integer width = 343
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
end type

type em_2 from editmask within w_sri_transacciones_nc
integer x = 1289
integer y = 16
integer width = 343
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_3 from statictext within w_sri_transacciones_nc
integer x = 1138
integer y = 24
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

type st_1 from statictext within w_sri_transacciones_nc
integer x = 55
integer y = 24
integer width = 603
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
string text = "Fecha de Emisi$$HEX1$$f300$$ENDHEX$$n desde :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_fp from datawindow within w_sri_transacciones_nc
integer x = 41
integer y = 1624
integer width = 4201
integer height = 320
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_um_cxp_detallepago"
boolean livescroll = true
end type

type st_4 from statictext within w_sri_transacciones_nc
integer x = 82
integer y = 1956
integer width = 393
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
string text = "CONCEPTO AIR"
boolean focusrectangle = false
end type

type dw_codair from datawindow within w_sri_transacciones_nc
integer x = 41
integer y = 2012
integer width = 4206
integer height = 392
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_retfte_nc"
boolean livescroll = true
end type

type st_2 from statictext within w_sri_transacciones_nc
integer x = 91
integer y = 1560
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
string text = "DOCUMENTO"
boolean focusrectangle = false
end type


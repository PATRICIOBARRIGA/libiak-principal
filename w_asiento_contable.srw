HA$PBExportHeader$w_asiento_contable.srw
$PBExportComments$Si. Vale
forward
global type w_asiento_contable from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_asiento_contable
end type
type cb_3 from commandbutton within w_asiento_contable
end type
type dw_maux from datawindow within w_asiento_contable
end type
type dw_detaux from datawindow within w_asiento_contable
end type
type st_2 from statictext within w_asiento_contable
end type
type cb_1 from commandbutton within w_asiento_contable
end type
end forward

global type w_asiento_contable from w_sheet_master_detail
integer width = 4736
integer height = 2072
string title = "Contabilizaci$$HEX1$$f300$$ENDHEX$$n"
long backcolor = 79741120
event ue_consultar pbm_custom16
dw_ubica dw_ubica
cb_3 cb_3
dw_maux dw_maux
dw_detaux dw_detaux
st_2 st_2
cb_1 cb_1
end type
global w_asiento_contable w_asiento_contable

type variables
datawindowchild dwc_cuentas,dwc_tipo
integer ii_diasedic
end variables

forward prototypes
public function integer wf_preprint ()
public function integer observa_saldo ()
end prototypes

event ue_consultar;dw_master.postevent(DoubleClicked!)
//dw_master.Object.w_observacion.text = '          '
//dw_detail.enabled = true
//dw_master.enabled = true
end event

public function integer wf_preprint ();Long ll_row,ll_nreg
Decimal lc_cpnumero
string ls_ticodigo

ll_row  = dw_master.Getrow()
If ll_row = 0 then return -1
lc_cpnumero = dw_master.GetItemDecimal(ll_row,"cp_numero")
ls_ticodigo = dw_master.GetItemString(ll_row,"ti_codigo")

dw_report.modify("st_empresa.text  = '"+gs_empresa+"' st_sucursal = '"+gs_su_nombre+"'")
ll_nreg = dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_ticodigo,lc_cpnumero)
if ll_nreg = 0 then
return -1
else
return 1
end if

end function

public function integer observa_saldo ();long ll_filact
decimal ld_debito, ld_credito, ld_saldo

ll_filact = dw_master.GetRow()

ld_debito = dw_master.GetItemNumber (ll_filact, "cp_debito")
ld_credito = dw_master.GetItemNumber (ll_filact, "cp_credito")

ld_saldo = ld_debito - ld_credito

if ld_saldo <> 0 then
	messageBox ("Atenci$$HEX1$$f300$$ENDHEX$$n", 'El Comprobante no cuadra')
	return 1
end if

return 0
end function

on w_asiento_contable.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.cb_3=create cb_3
this.dw_maux=create dw_maux
this.dw_detaux=create dw_detaux
this.st_2=create st_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_maux
this.Control[iCurrent+4]=this.dw_detaux
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_1
end on

on w_asiento_contable.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.cb_3)
destroy(this.dw_maux)
destroy(this.dw_detaux)
destroy(this.st_2)
destroy(this.cb_1)
end on

event open;/*Modificado para trabajar con un plan de ctas general de la empresa
  Las sucursales estan en l$$HEX1$$ed00$$ENDHEX$$nea
  El secuencial de los comprobantes es por empresa 10-apr-04*/
string ls_parametro[]

ls_parametro[1]= str_appgeninfo.empresa
ls_parametro[2] = str_appgeninfo.sucursal

ib_inReportMode  = false

f_recupera_empresa(dw_master,"ti_codigo")

//jaic
//dw_master.GetChild("ti_codigo",dwc_cuentas)
//if str_appgeninfo.username = 'mfreire' then 
//	dwc_cuentas.SetFilter(" ti_codigo not in ('2')")
//else
//	dwc_cuentas.SetFilter(" ti_codigo not in ('1','2')")
//end if

//dwc_cuentas.Filter()


f_recupera_empresa(dw_detail,"cs_codigo")
f_recupera_empresa(dw_ubica,"ticodigo")
f_recupera_empresa(dw_report,"cs_codigo")

istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal

call super::open


/*Determinar el nro de d$$HEX1$$ed00$$ENDHEX$$as permitidos para edicion*/
SELECT PR_VALOR
INTO   :ii_diasedic
FROM PR_PARAM
WHERE PR_NOMBRE = 'NDIAS_EDIC';


dw_master.is_serialCodeCompany = str_appgeninfo.empresa
dw_master.ii_nrCols = 4
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codigo"
dw_master.is_connectionCols[3] = "ti_codigo"
dw_master.is_connectionCols[4] = "cp_numero"
dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codigo"
dw_detail.is_connectionCols[3] = "ti_codigo"
dw_detail.is_connectionCols[4] = "cp_numero"
dw_detail.uf_setArgTypes()

dw_detail.GetChild("pl_codigo",dwc_cuentas)
dwc_cuentas.SetTransObject(SQLCA)
dwc_cuentas.Retrieve(str_appgeninfo.empresa)

f_recupera_empresa(dw_detail,"pl_codigo_1")


//dwc_cuentas.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)


/*Para impresion del asiento*/
dw_report.SetTransObject(SQLCA)

/*Para duplicar asientos*/
dw_maux.SetTransobject(sqlca)
dw_detaux.SetTransobject(sqlca)

/**/
dw_master.setFocus()
dw_master.uf_insertCurrentRow()




end event

event resize;call super::resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	dw_detail.resize(dw_master.width,li_height - dw_detail.y - dw_master.y)
end if	
this.setRedraw(True)

end event

event ue_update;/*Modificado para  trabajar con sucursales en l$$HEX1$$ed00$$ENDHEX$$nea; 
  El sucuencial de los comprobantes contables es por empresa*/

decimal  lc_numero,lc_valordeb,lc_valorcre,lc_saldo
Long     ll_row ,lc_rc,ll_rowm,ll_cpnumero,ll_sectipo
Integer  i
String   ls_tipo,ls_sigla,ls_sectipo
dwitemstatus l_status
date      ld_hoy,ld_fecha
Char     lch_cambio


dw_master.AcceptText()
dw_detail.AcceptText()

/*Validar para evitar el ingreso de transacciones para meses cerrados*/



/*si no actualiza nada no entra al update*/
if dw_master.ModifiedCount() = 0 then
	if dw_detail.ModifiedCount() = 0 then 
		rollback;
		return   
	end if
end if
/**/

ll_rowm = dw_master.GetRow()
If ll_rowm = 0 Then return
l_status  = dw_master.getitemStatus(ll_rowm,0,primary!)


/*detalle sin filas retorna*/
If dw_detail.rowcount() = 0 then return 

ll_row = dw_detail.Getrow()
lc_valordeb = dw_detail.GetItemDecimal(ll_row,"cc_tot_debitos")
lc_valorcre  = dw_detail.GetItemDecimal(ll_row,"cc_tot_creditos")

/*Control para no dejar grabar con 0 un asiento*/
if lc_valordeb = 0 and lc_valorcre = 0 then
	MessageBox ('Atenci$$HEX1$$f300$$ENDHEX$$n','Lo sentimos, no se puede guardar un asiento contable con valor cero (0)...')
	Rollback;
	return
end if

/**/
If  f_valida_fechatransac(date(dw_master.Object.cp_fecha[ll_rowm]))  = -1 then
MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','El $$HEX1$$fa00$$ENDHEX$$ltimo mes cerrado es :'+string(gdt_mescerrado,'MMM/YYYY')+ '......< Por favor VERIFIQUE la fecha de transacci$$HEX1$$f300$$ENDHEX$$n>')
Rollback;
return
end if


dw_master.SetItem(ll_rowm,"cp_debito",lc_valordeb )
dw_master.SetItem(ll_rowm,"cp_credito",lc_valorcre)
dw_master.SetItem(ll_rowm,"sa_login",str_appgeninfo.username)

lc_saldo = dw_master.GetItemNumber(ll_rowm,"cc_saldo")
ls_tipo   =  dw_master.GetItemString(ll_rowm,"ti_codigo")

////no puede hacer diarios de ingreso ni egresos xq deben generarlce al crear un ingreso o egreso
if str_appgeninfo.username = 'mfreire' then 
	if (ls_tipo = '2') and (l_status = new! or l_status = newmodified!) then 
		rollback;
		messagebox ('Alerta','No puede crear un Diario Egreso manualmente... <Favor Verifique>')
		return 
	end if
else
	if (ls_tipo = '1' or ls_tipo = '2') and (l_status = new! or l_status = newmodified!) then 
		rollback;
		messagebox ('Alerta','No puede crear un Diario de Ingreso o Egreso manualmente... <Favor Verifique>')
		return 
	end if
end if
////

SELECT ti_sigla
INTO   :ls_sigla
FROM   CO_TIPCOM
WHERE  TI_CODIGO = :ls_tipo;


dw_master.SetItem(ll_rowm,"cp_saldo",lc_saldo)
If observa_saldo() = 1 Then Return 1

if l_status = new! or l_status = newmodified! then
	//ll_cpnumero = f_secuencial_sucursal(str_appgeninfo.empresa,str_appgeninfo.sucursal,"CONTA_COMP")
	//ll_sectipo  = f_secuencial_sucursal(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_sigla)
	ll_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
	ll_sectipo  = f_secuencial(str_appgeninfo.empresa,ls_sigla)
	ls_sectipo  = String(ll_sectipo)
else
	ll_cpnumero  = dw_master.GetitemNumber(ll_rowm, "cp_numero")	
	ls_sectipo   = dw_master.GetitemString(ll_rowm, "cp_numcomp")	
end if


/**/
If ll_cpnumero < 0 Then
	Rollback;
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial..Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
	Return 
End if 

If ll_sectipo < 0 Then
	Rollback;
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial por tipo de comprobante...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
	Return 
End if 


dw_master.SetItem(ll_rowm,"em_codigo",str_appgeninfo.empresa)
dw_master.SetItem(ll_rowm,"cp_numero",ll_cpnumero)
dw_master.SetItem(ll_rowm,"su_codigo",str_appgeninfo.sucursal)
dw_master.SetItem(ll_rowm,"cp_numcomp",ls_sectipo)


/*Inserta clave del detalle solo si es nuevo*/
for i = 1 to dw_detail.RowCount()
dw_detail.SetItem(i,"em_codigo",str_appgeninfo.empresa)
dw_detail.SetItem(i,"su_codigo",str_appgeninfo.sucursal)
dw_detail.SetItem(i,"ti_codigo",ls_tipo)
dw_detail.SetItem(i,"cp_numero",ll_cpnumero)
dw_detail.SetItem(i,"dt_secue",String(i))
next 	

/**/
lc_rc = dw_master.Update(TRUE, FALSE) 
if lc_rc = 1 then
	lc_rc = dw_detail.update(TRUE, FALSE)
	if lc_rc = 1 then
		dw_master.resetupdate()
		dw_detail.resetupdate()	
		commit;
		w_marco.SetMicrohelp("Listo...Transacci$$HEX1$$f300$$ENDHEX$$n Exitosa...")		
	else
		rollback;
		return
	end if 	
else
	rollback;
	return 
End if

dwc_cuentas.SetFilter("")
dwc_cuentas.Filter() 
dw_detail.GetChild("pl_codigo",dwc_cuentas)
dw_master.Setfocus()

If dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo,ll_cpnumero) <= 0 Then
	Return 
End if

dw_report.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")

end event

event ue_print;/*Evento que imprime el asiento contable una vez grabado */
/*Tambien ,se impide modificar el comprobante despues de grabado*/


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
			dw_detail.enabled = False
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

/*Modificar la empresa y sucursal*/


	
end event

event activate;call super::activate;//m_marco.m_opcion2.m_facturacin.m_anularfactura.visible = true 
//m_marco.m_opcion2.m_facturacin.m_anularfactura.toolbaritemvisible = true
//m_marco.m_edicion.m_consultar1.enabled = true
//m_marco.m_edicion.m_consultar1.visible = true
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = true
dw_master.enabled = true
dw_detail.enabled = true



end event

event deactivate;//m_marco.m_opcion2.m_facturacin.m_anularfactura.visible = false  
//m_marco.m_opcion2.m_facturacin.m_anularfactura.toolbaritemvisible = false
//m_marco.m_edicion.m_consultar1.enabled = false
//m_marco.m_edicion.m_consultar1.visible = false
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = false


end event

event ue_printcancel;call super::ue_printcancel;dw_master.visible = true
dw_master.enabled = false
dw_detail.visible = true
dw_detail.enabled = false
end event

event ue_delete;/**/
long ll_row
dwitemstatus l_status
ll_row = dw_master.getrow()
l_status = dw_master.getitemstatus(ll_row,0,Primary!)
If l_status= notmodified! or l_status = datamodified! then
return
else
call super::ue_delete	
end if	
	
end event

event ue_retrieve;return 1

dw_master.enabled = true
dw_detail.enabled = true

end event

event ue_edit;call super::ue_edit;datetime ldt_hoy
date ld_fecha
long ll_dias,ll_row
integer li_rango
char lch_cambio



window lw_aux
lw_aux = getActiveSheet()

/*Begin Para no dejar modificar en caso que sea diario de un ingreso o egreso.*/
long ll_cpnumero, ll_cpnumeroI, ll_cpnumeroE
ll_cpnumero = dw_master.GetItemNumber(dw_master.getrow(),"cp_numero")

select cp_numero
into :ll_cpnumeroI
from cb_ingreso
where em_codigo = :str_appgeninfo.empresa
and cp_numero = :ll_cpnumero;

select cp_numero
into :ll_cpnumeroE
from cb_egreso
where em_codigo = :str_appgeninfo.empresa
and cp_numero = :ll_cpnumero;

if ll_cpnumeroE <> 0  or  ll_cpnumeroI <> 0 then
	MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','No se puede modificar un diario relacionado con un Ingreso o Egreso.... Favor revisar.')	
	rollback;
	return
end if
/*Fin Para no dejar modificar en caso que sea diario de un ingreso o egreso.*/


ll_row = dw_master.getrow()
If ll_row <= 0 then return -1

/**/
select pr_valor
into :li_rango
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'NDIAS_EDIC';

/**/	
select trunc(sysdate)
into :ldt_hoy
from dual;

ld_fecha = date(dw_master.GetitemDatetime(ll_row,"cp_fecha"))
ll_dias = daysafter(ld_fecha,date(ldt_hoy))

If  (ll_dias >= li_rango)  and  (ii_controledit = 1) then
    	openwithparm(w_response_clave,lw_aux)
	lch_cambio = message.stringParm
     If lch_cambio = 'S' then
	ib_edit = true	
	else
	ib_edit = false
    end if 
else
	ib_edit = true	
end if

dw_master.ii_nrocolsAct = 3			
dw_master.is_activecols[1] = 'cp_fecha'
dw_master.is_activecols[2] = 'ti_codigo'
dw_master.is_activecols[3] = 'cp_observ'
dw_master.uf_active(ib_edit)
dw_master.uf_changebackground(ib_edit,16777215 , 67108864)


/*Activa detalle*/
dw_detail.ii_nrocolsAct = 5			
dw_detail.is_activeCols[1] = 'pl_codigo'
dw_detail.is_activeCols[2] = 'cs_codigo'
dw_detail.is_activeCols[3] = 'dt_signo'
dw_detail.is_activeCols[4] = 'dt_valor'
dw_detail.is_activeCols[5] = 'dt_detalle'

dw_detail.uf_active(ib_edit)
dw_detail.uf_changebackground(ib_edit,16777215 , 67108864)
return 1
end event

event ue_insert;call super::ue_insert;dw_master.Object.t_3.Visible = 0
dw_master.Object.t_4.Visible = 0

dw_master.GetChild("ti_codigo",dwc_cuentas)
dwc_cuentas.SetFilter(" ti_codigo not in ('1','2')")
dwc_cuentas.Filter()

dw_master.enabled = true
dw_detail.enabled = true


end event

event ue_anular;/*  Evento:ue_anular																*/	
/*  Descripcion: Anula el comprobante cambiando el status del registro */
/******************************************************************/
string ls_tipo, ls_objeto
Long   ll_cpnumero,ll_row,ll_nreg, ll_dias
Integer li_rango
Date ldt_hoy, ld_fecha
char lch_cambio

window lw_aux
lw_aux = getActiveSheet()
ls_objeto = lw_aux.classname()

ll_nreg = dw_master.Rowcount()
if ll_nreg = 0 then return -1
ll_row = dw_master.Getrow()
if ll_row = 0 then return -1

ll_cpnumero = dw_master.getitemnumber(ll_row,"cp_numero")
ls_tipo = dw_master.getitemstring(ll_row,"ti_codigo")

//no dejar anular si esta relacionado con ingreso o egreso
long ll_cpnumeg, ll_cpnumin;
	select cp_numero
	into :ll_cpnumeg
	from cb_egreso
	where cp_numero = :ll_cpnumero
	and em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal;

	select cp_numero
	into :ll_cpnumin
	from cb_ingreso
	where cp_numero = :ll_cpnumero
	and em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal;
	
	If (ll_cpnumero = ll_cpnumeg) or (ll_cpnumero = ll_cpnumin) then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No puede anular un asiento contable si esta ligado con un Ingreso o Egreso... Favor revisar "+sqlca.sqlerrtext)
		Rollback;
		Return -1
	End if
//fin no dejar anular si esta relacionado con ingreso o egreso

/**/
select pr_valor
into :li_rango
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'NDIAS_EDIC';

select trunc(sysdate)
into :ldt_hoy
from dual; 

ld_fecha = date(dw_master.GetitemDatetime(ll_row,"cp_fecha"))
ll_dias = daysafter(ld_fecha,date(ldt_hoy))

If  ll_dias >= li_rango then 
	w_marco.SetMicrohelp("Mayor a los 21 d$$HEX1$$ed00$$ENDHEX$$as permitidos para eliminar...!")
    	openwithparm(w_response_clave,lw_aux)
	lch_cambio = message.stringParm
    If lch_cambio <> 'S' then
		Rollback;
		Return -1
    end if 
end if
/**/

If messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El comprobante'"+string(ll_cpnumero)+"' ser$$HEX2$$e1002000$$ENDHEX$$anulado completamente.."+&
              "Est$$HEX2$$e1002000$$ENDHEX$$seguro de anular...?",Question!,YesNo!,2) = 2 &
Then
Return -1
End if

Setpointer(Hourglass!)
update co_cabcom
set cp_anulado = 'S',
    cp_fecanu = sysdate
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ti_codigo = :ls_tipo
and cp_numero = :ll_cpnumero;

If sqlca.sqlcode <> 0 Then
	Rollback;
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al anular el diario "+sqlca.sqlerrtext)
	Return -1
End if

//Deshacer la contabilizaci$$HEX1$$f300$$ENDHEX$$n de documentos
//f_descontabiliza()




commit;
MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","El diario fue anulado exitosamente.")


dw_master.setFocus()
if ll_nreg > 1 then
	dw_master.ScrollToRow(ll_row - 1)
end if
Setpointer(Arrow!)
w_marco.Setmicrohelp("Listo...!")
close(this)
return  1

end event

type dw_master from w_sheet_master_detail`dw_master within w_asiento_contable
event ue_ponfecha ( string ar_name,  date ar_hoy )
integer x = 0
integer y = 0
integer width = 4686
integer height = 496
integer taborder = 0
string dataobject = "d_cab_comprobante"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_master::ue_ponfecha(string ar_name, date ar_hoy);//if ar_name = 'cp_fecha' then dw_master.SetItem(dw_master.GetRow(), "cp_fecha",today()) ;
this.SetItem(this.GetRow(), ar_name,ar_hoy) 
end event

event dw_master::itemchanged;dwItemStatus l_status
date ld_fectrans, ld_hoy
String ls_fectransac
char lch_cambio
integer li_diaspermitidos


window lw_aux
lw_aux = getActiveSheet()

If  dwo.name  =  "cp_fecha" Then
	this.AcceptText()
	
	SELECT TRUNC(SYSDATE)
	INTO :ld_hoy
	FROM DUAL;
	
	SELECT PR_VALOR
	INTO :li_diaspermitidos
	FROM PR_PARAM
	WHERE PR_NOMBRE = 'DIAS_FECHA';
	
		
	ld_fectrans      = 	date(data)
     if f_valida_fechatransac(ld_fectrans) = -1 then
	MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','El $$HEX1$$fa00$$ENDHEX$$ltimo mes cerrado es :'+string(gdt_mescerrado,'MMM/YYYY')+ '......< Por favor Verifique>')	
	this.post event ue_ponfecha(string(dwo.name),ld_hoy)
     end if
	
	
	if date(dw_master.GetItemdatetime(row,'cp_fecha')) > ld_hoy then
				MessageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','No puede ingresar fecha mayor a la actual.... <Por favor Verifique>')	
				this.post event ue_ponfecha(string(dwo.name),ld_hoy)
	end if
	
	if date(dw_master.GetItemdatetime(row,'cp_fecha')) < RelativeDate(ld_hoy,  - li_diaspermitidos) then
				if Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Revise la fecha, $$HEX1$$e900$$ENDHEX$$sta puede ser menor m$$HEX1$$e100$$ENDHEX$$ximo a '"+string(li_diaspermitidos)+"' d$$HEX1$$ed00$$ENDHEX$$as ...  Desea Ingresar con autorizaci$$HEX1$$f300$$ENDHEX$$n?. ", Exclamation!, YesNo! , 2) = 1 then
					openwithparm(w_response_clave,lw_aux)
					lch_cambio = message.stringParm
					if lch_cambio <> 'S' then
					  	this.post event ue_ponfecha(string(dwo.name),ld_hoy)
					 End If
				else
					this.post event ue_ponfecha(string(dwo.name),ld_hoy)
				End if	
	end if
End if
 
If  dwo.name  =  "cp_observ" Then
	l_status  = dw_master.getitemStatus(row,0,primary!)
	If l_status =  new! or l_status = newmodified! then
     	dw_detail.SetFocus()
//		dw_detail.Reset()
		dw_detail.InsertRow(0)
		dw_detail.SetColumn('pl_codigo')
	end if 
End if
end event

event dw_master::updatestart;return 0
end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true

end event

event dw_master::rowfocuschanged;call super::rowfocuschanged;/************/
Long ll_row
dwitemstatus l_status
//ll_row = dw_master.getrow()

l_status = dw_master.getitemstatus(currentrow,0,Primary!)
if l_status = new! or l_status = newmodified! then 
	ib_edit = true
else
	ib_edit = false
end if

dw_master.setcolumn("cp_numero")
dw_master.ii_nrocolsAct = 3			
dw_master.is_activecols[1] = 'cp_fecha'
dw_master.is_activecols[2] = 'ti_codigo'
dw_master.is_activecols[3] = 'cp_observ'
dw_master.uf_active(ib_edit)
dw_master.uf_changebackground(ib_edit,16777215 , 67108864)


/*Activa detalle*/
dw_detail.ii_nrocolsAct = 5			
dw_detail.is_activeCols[1] = 'pl_codigo'
dw_detail.is_activeCols[2] = 'cs_codigo'
dw_detail.is_activeCols[3] = 'dt_signo'
dw_detail.is_activeCols[4] = 'dt_valor'
dw_detail.is_activeCols[5] = 'dt_detalle'

dw_detail.uf_active(ib_edit)
dw_detail.uf_changebackground(ib_edit,16777215,67108864)


end event

event dw_master::retrieveend;call super::retrieveend;Long ll_row
dwitemstatus l_status

ll_row = dw_master.getrow()
if  ll_row <= 0 then return
l_status = dw_master.getitemstatus(ll_row,0,Primary!)
if l_status = new! or l_status = newmodified! then 
	ib_edit = true
else
	ib_edit = false
end if

dw_master.setcolumn("cp_numero")
dw_master.ii_nrocolsAct = 3			
dw_master.is_activecols[1] = 'cp_fecha'
dw_master.is_activecols[2] = 'ti_codigo'
dw_master.is_activecols[3] = 'cp_observ'
dw_master.uf_active(ib_edit)
dw_master.uf_changebackground(ib_edit,16777215 , 67108864)


/*Activa detalle*/
dw_detail.ii_nrocolsAct = 5			
dw_detail.is_activeCols[1] = 'pl_codigo'
dw_detail.is_activeCols[2] = 'cs_codigo'
dw_detail.is_activeCols[3] = 'dt_signo'
dw_detail.is_activeCols[4] = 'dt_valor'
dw_detail.is_activeCols[5] = 'dt_detalle'

dw_detail.uf_active(ib_edit)
dw_detail.uf_changebackground(ib_edit,16777215,67108864)


end event

type dw_detail from w_sheet_master_detail`dw_detail within w_asiento_contable
event ue_tabout pbm_dwntabout
integer x = 0
integer y = 496
integer width = 4686
integer height = 1048
integer taborder = 0
string dataobject = "d_det_comprobante"
boolean hscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_detail::ue_tabout;Long ll_new
If getcolumnName() = "dt_detalle" Then
	ll_new = This.insertrow(0)
	This.SetRow(ll_new)
	This.Scrolltorow(ll_new)
	This.SetColumn(4)
End if 
end event

event dw_detail::editchanged;call super::editchanged;String ls_data
If dwo.name = "pl_codigo" Then
	ls_data = data+'%'
	dwc_cuentas.SetFilter("pl_codigo like '"+ls_data+"' ")
	dwc_cuentas.Filter()
	This.GetChild("pl_codigo",dwc_cuentas)
End if 

Return 1
end event

event dw_detail::ue_postinsert;call super::ue_postinsert;This.SetColumn(4)
end event

event dw_detail::itemchanged;call super::itemchanged;String ls_cencos,ls_null
Setnull(ls_null)

if dwo.name = "pl_codigo" then
	select pl_cencos
	into :ls_cencos
	from co_placta
	where em_codigo = :str_appgeninfo.empresa
	and pl_codigo = :data;
	
	if sqlca.sqlcode < 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al determinar el Centro de costos"+sqlca.sqlerrtext)
		Return
	end if
	
    if ls_cencos ='N'or ls_cencos = ' ' or isnull(ls_cencos) then
		this.Modify("cs_codigo.Protect=1")
		this.setitem(row,"cs_codigo",ls_null)
    else
		this.Modify("cs_codigo.Protect=0")	
    end if
end if	


end event

event dw_detail::getfocus;call super::getfocus;if getrow() > 0 Then
	dwc_cuentas.SetFilter("")
	dwc_cuentas.Filter()
	This.GetChild("pl_codigo",dwc_cuentas)
End if


end event

event dw_detail::updatestart;return 0
end event

event dw_detail::losefocus;If dw_detail.GetColumnName()  =  "pl_codigo" Then
     	dw_detail.SetFocus()
		dw_detail.SetColumn('pl_codigo')
End if


end event

type dw_report from w_sheet_master_detail`dw_report within w_asiento_contable
integer y = 0
integer width = 3589
string dataobject = "d_prn_asiento_contable"
end type

type dw_ubica from datawindow within w_asiento_contable
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 594
integer y = 684
integer width = 1920
integer height = 356
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Busca Asiento"
string dataobject = "d_busca_asiento"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if


if KeyDown(KeyEnter!) then 
   //dw_ubica.TriggerEvent(itemchanged!)
end if
end event

event itemchanged;string ls_ticodigo,ls_tipo,  ls_cpnumero, ls_cpfecha
long   ll_row, ll_ticodigo, ll_numcom, ll_retrieve
boolean lb_editar=false


ls_tipo = this.GetItemString(1,'tipo')
If dwo.name = 'cpnumero'  then
	CHOOSE CASE ls_tipo
	CASE 'B'
		dw_ubica.AcceptText()
		//uno para q aparezca en caso de ser ingreso o egreso
					dw_master.GetChild("ti_codigo",dwc_cuentas)
					dwc_cuentas.SetFilter('')
					dwc_cuentas.Filter()
		//fin uno
		ll_retrieve = dw_master.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,data)
if ll_retrieve <> 0 then
			ls_ticodigo = dw_master.GetItemString(dw_master.GetRow(),"ti_codigo")
			/*Para poner el numero del ingreo o egreso*/
		if ls_ticodigo = '2' then	 
			select eg_numero 	into :ll_numcom from cb_egreso
			where (em_codigo = '1' and
			su_codigo = :str_appgeninfo.sucursal and
			eg_numero like '%' ) and
			cp_numero = :data ;
				dw_master.Object.t_3.Visible = 1
				dw_master.Object.t_4.Visible = 1
				dw_master.Object.t_4.Text = string(ll_numcom);
				dw_master.Object.t_3.Text =  'Egreso No.:';
		elseif ls_ticodigo = '1' then
      
				select ig_numero into :ll_numcom from cb_ingreso
				where (em_codigo = '1' and
				su_codigo = :str_appgeninfo.sucursal and
				ig_numero like '%' ) and
				cp_numero = :data ; 

				dw_master.Object.t_3.Visible = 1
				dw_master.Object.t_4.Visible = 1
				dw_master.Object.t_3.Text =  'Ingreso No.:';
				dw_master.Object.t_4.Text = string(ll_numcom);
		else 
				dw_master.Object.t_3.Visible = 0
				dw_master.Object.t_4.Visible = 0
		end if
		/**/
			ll_row = dw_master.getrow()
			if ll_row <> 0 then
				ls_ticodigo = dw_master.GetItemString(ll_row,"ti_codigo")
				dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_ticodigo,long(data))
			end if
else
	dw_detail.reset()
end if
	CASE 'F'
	END CHOOSE	
End if

end event

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter() 
end event

type cb_3 from commandbutton within w_asiento_contable
integer x = 3013
integer y = 316
integer width = 517
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Duplicar Asiento"
end type

event clicked;String ls_tipo,ls_sigla
Long ll_cpnumero,ll_sectipo,i,lc_rc
Datetime ldt_hoy

If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro que desea duplicar el asiento?",Question!,YesNo!,2) = 2 then
	return
end if

SELECT SYSDATE
INTO :ldt_hoy
FROM DUAL;



dw_maux.reset()
dw_detaux.reset()

dw_master.rowsCopy(1, 1, Primary!, dw_maux, 1, Primary!)
dw_detail.rowscopy(1,dw_detail.rowcount(),Primary!,dw_detaux,1,Primary!)

/*Asigna nuevos secuenciales*/
ls_tipo   =  dw_master.GetItemString(1,"ti_codigo")

SELECT ti_sigla
INTO   :ls_sigla
FROM   CO_TIPCOM
WHERE  TI_CODIGO = :ls_tipo;

ll_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
ll_sectipo  = f_secuencial(str_appgeninfo.empresa,ls_sigla)

dw_maux.SetItem(1,"cp_numero",ll_cpnumero)
dw_maux.SetItem(1,"cp_numcomp",string(ll_sectipo))
dw_maux.SetItem(1,"cp_fecha",ldt_hoy)


/*Inserta clave del detalle solo si es nuevo*/
for i = 1 to dw_detaux.RowCount()
dw_detaux.SetItem(i,"cp_numero",ll_cpnumero) 
next 	


lc_rc = dw_maux.Update(TRUE, FALSE) 
if lc_rc = 1 then
		lc_rc = dw_detaux.update(TRUE, FALSE)
		if lc_rc = 1 then
		dw_maux.resetupdate()
		dw_detaux.resetupdate()	
		commit;
		else
		rollback;
		return
		end if 	
else
		rollback;
		return
End if
 
//w_marco.SetMicrohelp("Asiento creado....Por favor revise el asiento N$$HEX1$$ba00$$ENDHEX$$'"+string(ll_cpnumero)+"'")
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Asiento creado....Por favor revise el asiento N$$HEX1$$ba00$$ENDHEX$$'"+string(ll_cpnumero)+"'")

end event

type dw_maux from datawindow within w_asiento_contable
boolean visible = false
integer x = 1422
integer y = 1260
integer width = 466
integer height = 400
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_cab_comprobante"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_detaux from datawindow within w_asiento_contable
boolean visible = false
integer x = 928
integer y = 1252
integer width = 466
integer height = 400
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_det_comprobante"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_asiento_contable
integer x = 27
integer y = 436
integer width = 343
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
string text = "Detalle"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_asiento_contable
integer x = 3017
integer y = 208
integer width = 517
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asientos recurrentes"
end type

event clicked;long ll_nreg,i,ll_new,ll_row
string ls_plcodigo,ls_cscodigo,ls_signo,ls_obs,ls_tipo
dwitemstatus l_status

ll_row = dw_master.getrow()
If ll_row = 0 then return
l_status = dw_master.Getitemstatus(ll_row,0,Primary!)

If l_status = datamodified! or l_status = notmodified! then return

declare  c1 cursor for
select pl_codigo,cs_codigo,ct_debcre,ct_descri
from co_comaut
where em_codigo =:str_appgeninfo.empresa
and su_codigo =:str_appgeninfo.sucursal
and ct_codigo =:ls_tipo
order by to_number(ct_colum);



open(w_recurrentes)
ls_tipo = message.stringparm

dw_detail.reset()
open c1;
fetch c1 into :ls_plcodigo,:ls_cscodigo,:ls_signo,:ls_obs ;
do while sqlca.sqlcode = 0
	ll_new = dw_detail.insertrow(0)
	dw_detail.setitem(ll_new,"pl_codigo",ls_plcodigo)
	dw_detail.setitem(ll_new,"cs_codigo",ls_cscodigo)
	dw_detail.setitem(ll_new,"dt_signo",ls_signo)
	dw_detail.setitem(ll_new,"dt_detalle",ls_obs)
	fetch c1 into :ls_plcodigo,:ls_cscodigo,:ls_signo,:ls_obs ;	
loop
close c1;
return
end event


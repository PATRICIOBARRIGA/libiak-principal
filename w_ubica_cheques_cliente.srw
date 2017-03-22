HA$PBExportHeader$w_ubica_cheques_cliente.srw
$PBExportComments$Si.Pantalla para ubicar los cheques de un cliente dado
forward
global type w_ubica_cheques_cliente from w_sheet_1_dw_maint
end type
type dw_master from uo_dw_basic within w_ubica_cheques_cliente
end type
end forward

global type w_ubica_cheques_cliente from w_sheet_1_dw_maint
integer width = 2930
integer height = 1640
string title = "Consulta: Cheques Pendientes "
long backcolor = 67108864
dw_master dw_master
end type
global w_ubica_cheques_cliente w_ubica_cheques_cliente

forward prototypes
public function integer wf_genera_interes (string as_cliente, decimal ac_total)
public function integer wf_preprint ()
end prototypes

public function integer wf_genera_interes (string as_cliente, decimal ac_total);string ls_numero
dec    ll_numero

select pr_valor
  into :ll_numero
  from pr_param
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_ND';
	
if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo obtener el numero de la nota de debito "+sqlca.sqlerrtext,StopSign!)
	return -1
end if

ls_numero = string(ll_numero)

insert into cc_movim(tt_codigo,tt_ioe,em_codigo,su_codigo,mt_codigo,
                     rf_codigo,ce_codigo,es_codigo,ve_numero,ig_numero,
							mt_valor,mt_fecha,mt_valret,mt_saldo,bo_codigo)
values('3','D',:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:ls_numero,
       null,:as_cliente,null,null,null,:ac_total,sysdate,0,
		 :ac_total,:str_appgeninfo.seccion);

if sqlca.sqlcode <> 0 then
	MessageBox("Error","No se pudo generar la nota de debito: "+sqlca.sqlerrtext,StopSign!)
	return -1
end if
commit;
update pr_param
   set pr_valor = pr_valor + 1
 where em_codigo = :str_appgeninfo.empresa
   and pr_nombre = 'NUM_ND';
commit;
return 1
end function

public function integer wf_preprint ();long ll_filActMaestro
string ls_cliente

dw_report.SetTransObject(sqlca)
ll_filActMaestro = dw_master.getRow()
ls_cliente = dw_master.getItemString(ll_filActMaestro, "cliente")
dw_report.modify("st_empresa.text = '"+gs_empresa+"'")
dw_report.retrieve(str_appgeninfo.empresa,ls_cliente)
return 1

end function

on w_ubica_cheques_cliente.create
int iCurrent
call super::create
this.dw_master=create dw_master
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_master
end on

on w_ubica_cheques_cliente.destroy
call super::destroy
destroy(this.dw_master)
end on

event open;ib_notautoretrieve = true
f_recupera_empresa(dw_master,'cliente')
f_recupera_empresa(dw_datos, 'if_codigo')
f_recupera_empresa(dw_report, 'if_codigo')
dw_master.InsertRow(0)
dw_master.SetFocus()
dw_master.PostEvent(Clicked!)
dw_datos.SetRowFocusIndicator(hand!)
call super::open
end event

event resize;dataWindow ldw_aux

if this.ib_inReportMode then
	ldw_aux = dw_report
	dw_master.resize(this.workSpaceWidth() - dw_master.x, dw_master.height)	
   ldw_aux.resize(dw_master.width,this.workSpaceHeight() - ldw_aux.y - dw_master.y)
else
	ldw_aux = dw_datos
	dw_master.resize(this.workSpaceWidth() - dw_master.x, dw_master.height)
   ldw_aux.resize(dw_master.width,this.workSpaceHeight() - dw_datos.y - dw_master.y)
end if



end event

event ue_insert;beep(1)
end event

event ue_delete;BEEP(1)
end event

event ue_retrieve;call super::ue_retrieve;beep(1)
end event

event ue_update;decimal lc_valch
long li, ll_max
string ls_clien
datetime ld_hoy, ld,ld_fecefec

if dw_datos.AcceptText() <> 1 then return

Select trunc(sysdate)
into :ld_hoy
from dual;

ll_max = dw_datos.GetRow()
ls_clien = dw_master.GetItemString(dw_master.GetRow(),'cliente')
for li = 1 to ll_max
  ld_fecefec =  dw_datos.GetitemDateTime(li,"cc_cheque_ch_fecefec")
  If date(ld_fecefec) <  date(ld_hoy) then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha de vencimiento no puede ser menor a la fecha actual")
	exit
  end if	
  lc_valch = dw_datos.GetItemNumber(li,'ch_interes')
  if not isnull(lc_valch) and  lc_valch > 0 then
	   ld = dw_datos.GetItemDateTime(li,'ch_fecinte')
		if isnull(ld) then //cambio el valor del inter$$HEX1$$e900$$ENDHEX$$s, genero N/D
		   if wf_genera_interes(ls_clien,lc_valch) <> 1 then
				return
			end if
			dw_datos.SetItem(li,'ch_fecinte',ld_hoy)
	   end if
  end if
next
call super::ue_update

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ubica_cheques_cliente
event ue_keydown pbm_dwnkey
integer y = 168
integer width = 2894
integer height = 1368
integer taborder = 20
string dataobject = "d_ubica_cheque_cliente"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::rowfocuschanged;call super::rowfocuschanged;decimal lc_valch
long ll_filact

ll_filact = this.GetRow()
if ll_filact > 0 and not isnull(ll_filact) then
	lc_valch = this.GetItemNumber(ll_filact,'ch_interes')
	if isnull(lc_valch) or lc_valch = 0 then
		this.SetTabOrder('ch_interes',20)
	else
		this.SetTabOrder('ch_interes',0)
	end if
end if
end event

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
decimal lc_valche
CHOOSE CASE this.GetColumnName()
	CASE 'ch_valor'
		lc_valche = dec(this.GetText())
END CHOOSE
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_ubica_cheques_cliente
integer y = 188
integer width = 517
integer height = 148
integer taborder = 30
string dataobject = "d_rep_ubica_cheque_cliente"
end type

type dw_master from uo_dw_basic within w_ubica_cheques_cliente
event ue_keydown pbm_dwnkey
integer width = 2894
integer height = 168
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_cliente"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event ue_keydown;call super::ue_keydown;if (KeyDown(KeyF2!))	 then
	dw_master.Reset()
	dw_datos.Reset()
	dw_master.InsertRow(0)
	dw_master.SetFocus()
end if
end event

event clicked;call super::clicked;
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = true
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_master.GetRow() 
dw_master.SetFocus()
end event

event itemchanged;call super::itemchanged;string ls_nombre, ls_cliente

choose case this.GetColumnName()
	case "cliente"
		ls_cliente = this.gettext()
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
	if dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cliente) < 1 then
		messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','El cliente no tiene cheques pendientes')
	else
		dw_datos.SetFocus()
	end if
end choose
end event


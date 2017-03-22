HA$PBExportHeader$w_actualiza_rol_opcion2.srw
$PBExportComments$Si.Para actualizar los valores de los rubros que se ingresan manualmente o requieren un ajuste.
forward
global type w_actualiza_rol_opcion2 from w_sheet_master_detail
end type
type st_1 from statictext within w_actualiza_rol_opcion2
end type
type st_2 from statictext within w_actualiza_rol_opcion2
end type
type dw_2 from datawindow within w_actualiza_rol_opcion2
end type
type cb_1 from commandbutton within w_actualiza_rol_opcion2
end type
type dw_1 from datawindow within w_actualiza_rol_opcion2
end type
type dw_ubica from datawindow within w_actualiza_rol_opcion2
end type
type cb_2 from commandbutton within w_actualiza_rol_opcion2
end type
type cb_3 from commandbutton within w_actualiza_rol_opcion2
end type
end forward

global type w_actualiza_rol_opcion2 from w_sheet_master_detail
integer x = 18
integer y = 360
integer width = 3675
integer height = 2072
string title = "Actualiza Rol de Pagos"
long backcolor = 67108864
event ue_consultar pbm_custom15
st_1 st_1
st_2 st_2
dw_2 dw_2
cb_1 cb_1
dw_1 dw_1
dw_ubica dw_ubica
cb_2 cb_2
cb_3 cb_3
end type
global w_actualiza_rol_opcion2 w_actualiza_rol_opcion2

type variables

end variables

event ue_consultar;call super::ue_consultar;dw_master.postevent(DoubleClicked!)
end event

on w_actualiza_rol_opcion2.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_ubica=create dw_ubica
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_ubica
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_3
end on

on w_actualiza_rol_opcion2.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_ubica)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;string ls_parametro[], ls_datos[]

dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'dt_codigo')
f_recupera_empresa(dw_1,"su_codigo")

call super::open
istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
//istr_argInformation.StringValue[1] = str_appgeninfo.empresa
//istr_argInformation.DateValue[2] = today()
//istr_argInformation.StringValue[2] = '1'

dw_master.ii_nrCols = 3
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "ep_codigo"
dw_master.is_connectionCols[3] = "rr_codigo"
dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "ep_codigo"
dw_detail.is_connectionCols[3] = "rr_codigo"
dw_detail.uf_setArgTypes()
f_recupera_empresa(dw_detail,'ru_codigo')
f_recupera_empresa(dw_2,'ru_codigo')
dw_2.SetTransObject(sqlca)
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
dw_detail.resize(dw_detail.width,li_height - dw_master.height - dw_1.height)
dw_2.resize(dw_2.width,li_height - dw_master.height - dw_1.height)

return 1
end event

event activate;call super::activate;//m_marco.m_edicion.m_consultar1.enabled = TRUE
//m_marco.m_edicion.m_consultar1.visible = TRUE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = TRUE
//
end event

event close;call super::close;//m_marco.m_edicion.m_consultar1.enabled = FALSE
//m_marco.m_edicion.m_consultar1.visible = FALSE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = FALSE
end event

event deactivate;call super::deactivate;//m_marco.m_edicion.m_consultar1.enabled = FALSE
//m_marco.m_edicion.m_consultar1.visible = FALSE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = FALSE
end event

event closequery;//m_marco.m_edicion.m_consultar1.enabled = FALSE
//m_marco.m_edicion.m_consultar1.visible = FALSE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = FALSE
return
end event

event ue_lastrow;call super::ue_lastrow;dw_master.enabled = true 
dw_detail.enabled = true 
dw_2.enabled = true
//return 1
end event

event ue_firstrow;call super::ue_firstrow;dw_master.enabled = true 
dw_detail.enabled = true 
dw_2.enabled = true
//return 1
end event

event ue_nextrow;call super::ue_nextrow;dw_master.enabled = true 
dw_detail.enabled = true 
dw_2.enabled = true
//return 1
end event

event ue_retrieve;call super::ue_retrieve
dw_master.enabled = true 
dw_detail.enabled = true 
dw_2.enabled = True



end event

event ue_priorrow;call super::ue_priorrow;dw_master.enabled = true 
dw_detail.enabled = true 
dw_2.enabled = true
//return 1
end event

event doubleclicked;call super::doubleclicked;dw_master.enabled = true 
dw_detail.enabled = true 
end event

event ue_update;Long ll_rc,ll_row
Decimal{2} lc_totingresos,lc_totegresos


/*Actualizar la cabecera con el total de ingresos y egresos*/

dw_detail.AcceptText()
dw_2.AcceptText()
ll_row = dw_master.getrow()


if dw_detail.rowcount() > 0 and dw_2.rowcount()> 0 then
lc_totingresos = dw_detail.Object.cc_totalingresos[1]
lc_totegresos  = dw_2.Object.cc_totalegresos[1]
else
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El Rol no ha sido procesado por favor verifique!",Exclamation!)
Rollback;
Return
end if

dw_master.Object.rr_totingr[ll_row] = lc_totingresos
dw_master.Object.rr_totegre[ll_row] = lc_totegresos
dw_master.Object.rr_liquido[ll_row] = lc_totingresos - lc_totegresos

ll_rc = dw_master.update(true,false)
If ll_rc = 1 Then
   ll_rc = dw_detail.update(true,false)
	If ll_rc = 1 Then
		ll_rc  = dw_2.Update(true,false)
		If ll_rc = 1 Then
			dw_master.resetupdate()
			dw_detail.resetupdate()
			dw_2.resetupdate()
			dw_master.enabled = False
			dw_detail.enabled = False
			dw_2.enabled = False
			commit;
		else
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la cabecera del Rol"+sqlca.sqlerrtext)	
		Rollback;
		Return
		end if
	else
   Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el Rol"+sqlca.sqlerrtext)	
	Rollback;
	Return
	end if
else
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el dw_2"+sqlca.sqlerrtext)	
Rollback;
Return
end if
end event

event ue_printcancel;call super::ue_printcancel;dw_2.enabled = true
end event

type dw_master from w_sheet_master_detail`dw_master within w_actualiza_rol_opcion2
integer x = 5
integer y = 220
integer width = 3616
integer height = 288
integer taborder = 20
string dataobject = "d_cabecera_actualiza_rol"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;call super::itemchanged;long ll_filas,ll_filact,li
decimal lq_valor
string ls_ru_tipcam
Choose case this.GetcolumnName()
	case 'rr_horas'
		if long(data) > 240 then 
			if messageBox('Atencion','Aseg$$HEX1$$fa00$$ENDHEX$$rese de que el n$$HEX1$$fa00$$ENDHEX$$mero de horas trabajadas es correcto.',Exclamation!, OKCancel!) = 2 then
				data=string(this.GetItemNumber(row,'rr_horas'))
				return
			end if
		end if
		ll_filas=dw_detail.RowCount()
		for li=1 to ll_filas
			if dw_detail.GetItemDecimal(li,'lq_numhor')<>0 then
				dw_detail.SetItem(li,'lq_numhor',dec(data))
				dw_detail.SetItem(li,'lq_total',dec(data)*dw_detail.GetItemDecimal(li,'lq_valor'))
			end if
		next
			dw_master.SetItem(row,'rr_totingr',dw_detail.GetItemDecimal(1,'total_i'))
			dw_master.SetItem(row,'rr_totegre',dw_detail.GetItemDecimal(1,'total_e'))
			dw_master.SetItem(row,'rr_liquido',dw_detail.GetItemDecimal(1,'total'))
END CHOOSE		

end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()

dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
dw_detail.enabled= true
dw_master.enabled= true
end event

event dw_master::rowfocuschanging;dec{2} lc_detingresos,lc_detegresos,lc_ingresosbd,lc_egresosbd

dw_detail.accepttext()
dw_2.accepttext()
If currentrow > 0 then
lc_ingresosbd = dw_master.getItemdecimal(currentrow,'rr_totingr',primary!,true)
lc_egresosbd = dw_master.getItemdecimal(currentrow,'rr_totegre',primary!,true)
lc_detingresos = dw_detail.getItemdecimal(1,'cc_totalingresos')
lc_detegresos = dw_2.getItemdecimal(1,'cc_totalegresos')

if lc_ingresosbd <> lc_detingresos or lc_egresosbd <> lc_detegresos then
	if messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea guardar los cambios...?",question!,yesno!,2) = 1 then 	
	parent.triggerevent("ue_update")
	else
	return 0
	end if		
end if
end if



end event

event dw_master::rowfocuschanged;dec{2} lc_ingresos,lc_egresos
String ls_epcodigo,ls_nro

If currentrow > 0 then 
   ls_epcodigo = This.GetItemString(currentrow,"ep_codigo")
   ls_nro      = This.GetItemString(currentrow,"rr_codigo")
    
   dw_detail.Retrieve(str_appgeninfo.empresa,ls_epcodigo,ls_nro)
	dw_2.Retrieve(str_appgeninfo.empresa,ls_epcodigo,ls_nro)

	lc_ingresos = dw_detail.GetItemDecimal(1,'cc_totalingresos')
	lc_egresos  = dw_2.GetItemDecimal(1,'cc_totalegresos')
	dw_master.SetItem(currentrow,'rr_totingr',lc_ingresos)
	dw_master.SetItem(currentrow,'rr_totegre',lc_egresos)
	dw_master.SetItem(currentrow,'rr_liquido',lc_ingresos - lc_egresos)			

	if GetItemString(currentrow,'rr_pagado')='S' then
		dw_detail.enabled = true
		dw_2.enabled = true
	else
		dw_detail.enabled = false
		dw_2.enabled = false
	end if
End if
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_actualiza_rol_opcion2
integer x = 23
integer y = 504
integer width = 1934
integer height = 1404
integer taborder = 30
string dataobject = "d_actualiza_rol_ingresos"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_detail::itemchanged;call super::itemchanged;dec{2} ld_total,lc_ingresos,lc_egresos,lc_aporteiess
// para los rubros calculados
long ll_fila_IESS,ll_rowm

this.AcceptText()
ll_rowm = dw_master.GetRow()
if ll_rowm <= 0 then return

choose Case this.GetColumnName()
	case 'lq_numhor'
			dw_detail.SetItem(row,'lq_total',dec(data)*dw_detail.GetItemDecimal(row,'lq_valor'))
	case 'lq_valor'
			dw_detail.SetItem(row,'lq_total',dec(data)*dw_detail.GetItemDecimal(row,'lq_numhor'))
	case 'lq_total'
end choose


lc_aporteiess = this.object.cc_iess[1]
ll_fila_iess     = dw_2.Find("ru_codigo='18'",1,dw_2.RowCount())
if ll_fila_iess <> 0 then
dw_2.Object.lq_total[ll_fila_iess] = lc_aporteiess  
end if	

lc_ingresos = dw_detail.GetItemDecimal(1,'cc_totalingresos')
lc_egresos  = dw_2.GetItemDecimal(1,'cc_totalegresos')
dw_master.SetItem(ll_rowm,'rr_totingr',lc_ingresos)
dw_master.SetItem(ll_rowm,'rr_totegre',lc_egresos)
dw_master.SetItem(ll_rowm,'rr_liquido',lc_ingresos - lc_egresos)			
			
end event

type dw_report from w_sheet_master_detail`dw_report within w_actualiza_rol_opcion2
integer y = 888
integer width = 206
integer height = 112
integer taborder = 0
end type

type st_1 from statictext within w_actualiza_rol_opcion2
integer x = 64
integer y = 440
integer width = 343
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Ingresos"
boolean focusrectangle = false
end type

type st_2 from statictext within w_actualiza_rol_opcion2
integer x = 2016
integer y = 436
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Egresos"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_actualiza_rol_opcion2
integer x = 1979
integer y = 504
integer width = 1614
integer height = 1404
integer taborder = 40
string title = "none"
string dataobject = "d_actualiza_rol_egresos"
boolean border = false
end type

event itemchanged;decimal lc_ingresos,lc_egresos
long ll_rowm

this.AcceptText()

ll_rowm = dw_master.GetRow()
if ll_rowm <= 0 then return

choose Case this.GetColumnName()
	case 'lq_numhor'
			This.SetItem(row,'lq_total',dec(data)*This.GetItemDecimal(row,'lq_valor'))
	case 'lq_valor'
			This.SetItem(row,'lq_total',dec(data)*This.GetItemDecimal(row,'lq_numhor'))
	case 'lq_total'
end choose

lc_ingresos = dw_detail.GetItemDecimal(1,'cc_totalingresos')
lc_egresos  = This.GetItemDecimal(1,'cc_totalegresos')
dw_master.SetItem(ll_rowm,'rr_totingr',lc_ingresos)
dw_master.SetItem(ll_rowm,'rr_totegre',lc_egresos)
dw_master.SetItem(ll_rowm,'rr_liquido',lc_ingresos - lc_egresos)
			
end event

type cb_1 from commandbutton within w_actualiza_rol_opcion2
integer x = 2665
integer y = 112
integer width = 425
integer height = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Impuesto &Renta"
end type

event clicked;string ls_epcodigo,ls_periodo,ls_hoy,ls_fecini,ls_fecfin,ls_anio,ls_secuen
dec{2} lq_valor,lc_acumulado,lq_total,ld_valor,lc_impren,lc_acumrenta,&
		 ld_valiess,ld_totirenta,lc_catorce,lc_iess_mes,lc_iess_mesant
dec{6} lc_trece,lc_iess
int li_mes,li_si,li_mescal

//select to_char(sysdate,'mm/yyyy')
//into :ls_hoy
//from dual;
//
ls_periodo = string(dw_1.getitemdate(1,"periodo"),'mm/yyyy')
//if ls_hoy <> ls_periodo then 
//	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha del periodo no es la actual...verifique")
//	return
//end if

li_mes = month(dw_1.getitemdate(1,"periodo"))
ls_anio = string(year(dw_1.getitemdate(1,"periodo")))

//control para q no se repita el calculo del imp. a la renta
select sum(d.lq_total) 
into :ld_totirenta
from no_cabrol c, no_rolpago d
where c.ep_codigo = d.ep_codigo
and c.rr_codigo = d.rr_codigo
and to_char(c.rr_fecha,'mm/yyyy') = :ls_periodo
and d.ru_codigo = 32;

if ld_totirenta = 0 then
	li_si = messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro que desea calcular el~r~n"+& 
						  "Impuesto a la Renta de este per$$HEX1$$ed00$$ENDHEX$$odo",question!,yesno!,2)
	if li_si = 2 then return
	setpointer(hourglass!)
	w_marco.SetMicroHelp('Procesando Impuesto a la Renta...')	
	ls_fecini = '01'
	if len(string(li_mes)) = 1 then 
		if  li_mes = 1 then
			ls_fecfin = '01'
		else
			ls_fecfin = '0'+string(li_mes - 1)
		end if
	else
		if li_mes = 10 then
			ls_fecfin = '0'+string(li_mes - 1)
		else
			ls_fecfin = string(li_mes - 1)
		end if
	end if
		
	// rubro treceavo
	SELECT rc_porcen/100   
	INTO :lc_trece   
	FROM  no_rubcal
	WHERE ru_codigo = '12';
	
	// rubro catorceavo
	SELECT rc_porcen   
	INTO :lc_catorce   
	FROM  no_rubcal
	WHERE ru_codigo = '13';
	
	// rubro aporte al iess
	SELECT rc_porcen/100   
	INTO :lc_iess   
	FROM  no_rubcal
	WHERE ru_codigo = '18';


	declare imp_renta cursor for

	SELECT c.ep_codigo ,to_char(max(to_number(c.rr_codigo)))
	FROM no_emple e,no_cabrol c
	WHERE e.ep_codigo = c.ep_codigo
	and to_char(c.rr_fecha,'mm/yyyy') = :ls_periodo
	and c.rr_tipo = 'R'
	and em_codigo = :str_appgeninfo.empresa
	AND ep_nonom = 'S' 
	AND ep_fecsal is null
	group by c.ep_codigo
	order by to_number(c.ep_codigo);
	
	open imp_renta;
	do
	fetch imp_renta into :ls_epcodigo,:ls_secuen;	
	if sqlca.sqlcode <> 0 then exit

	//total de ingresos en el mes
	select round(SUM(y.lq_total),2)
	into   :lq_valor
	from   no_cabrol  x,  no_rolpago y,no_rubro z
	where  x. ep_codigo = y.ep_codigo
	and    x.rr_codigo = y.rr_codigo
	and    z.ru_codigo = y.ru_codigo
	and    x.rr_tipo = 'R'	
	and    to_char(x.rr_fecha,'MM/YYYY') = :ls_periodo
	and    x.ep_codigo = :ls_epcodigo
	and    z.ru_sigla like 'I%' ;
	
	//acumulado de ingresos de meses anteriores al mes de pago del presente a$$HEX1$$f100$$ENDHEX$$o
	select round(SUM(y.lq_total),2)
	into   :lc_acumulado
	from   no_cabrol  x,  no_rolpago y, no_rubro z
	where  x. ep_codigo = y.ep_codigo
	and    x.rr_codigo = y.rr_codigo
	and    z.ru_codigo = y.ru_codigo
	and    x.rr_tipo = 'R'
	and    to_char(x.rr_fecha,'MM') between :ls_fecini and :ls_fecfin
	and    to_char(x.rr_fecha,'YYYY') = :ls_anio
	and    x.ep_codigo = :ls_epcodigo
	and    z.ru_sigla like 'I%' ;
	
	//Acumulado de aportes al iess 
	select round(SUM(y.lq_total),2)
	into   :lc_iess_mesant
	from   no_cabrol  x,  no_rolpago y, no_rubro z
	where  x. ep_codigo = y.ep_codigo
	and    x.rr_codigo = y.rr_codigo
	and    z.ru_codigo = y.ru_codigo
	and    x.rr_tipo = 'R'	
	and    to_char(x.rr_fecha,'MM') between :ls_fecini and :ls_fecfin
	and    to_char(x.rr_fecha,'YYYY') = :ls_anio
	and    x.ep_codigo = :ls_epcodigo
	and    z.ru_codigo = '18' ;

	//Aporte mensual al iess
	select round(SUM(y.lq_total),2)
	into   :lc_iess_mes
	from   no_cabrol  x,  no_rolpago y,no_rubro z
	where  x. ep_codigo = y.ep_codigo
	and    x.rr_codigo = y.rr_codigo
	and    z.ru_codigo = y.ru_codigo
	and    x.rr_tipo = 'R'	
	and    to_char(x.rr_fecha,'MM/YYYY') = :ls_periodo
	and    x.ep_codigo = :ls_epcodigo
	and    z.ru_codigo = '18' ;


	li_mescal = (12 - li_mes) + 1
	if li_mescal = 12 then
		lq_valor = lq_valor * li_mescal
	else
		lq_valor = lq_valor * li_mescal + lc_acumulado
	end if
	//Total de ingresos anual + treceavo + catorceavo + utilid + incentivos
	
   //Antes de la ley de equidad tributaria	
  //lq_total = lq_valor  + (lq_valor * lc_trece) + lc_catorce
   lq_total = lq_valor
	//Calculo del aporte al iess
//	ld_valiess = lq_valor * lc_iess
	if li_mescal = 12 then
		lc_iess = lc_iess_mes * li_mescal
	else
		lc_iess = lc_iess_mesant + (lc_iess_mes * li_mescal)
	end if
//	lq_total = lq_total - ld_valiess
	
	lq_total = lq_total - lc_iess
	
	//calculo de imp. a la renta en base a la tabla
	select round((:lq_total - ir_frbasica)*ir_impexceso/100 + ir_impbasica,2)
	into  :lc_impren
	from pr_renta 
	where ir_frbasica <= :lq_total and :lq_total <= ir_exceso;
	
	//Impuesto renta mensual
	if li_mescal = 12 then
		lq_total = lc_impren / li_mescal
	else
		select round(SUM(y.lq_total),2)
		into   :lc_acumrenta
		from   no_cabrol  x,  no_rolpago y
		where  x. ep_codigo = y.ep_codigo
		and    x.rr_codigo = y.rr_codigo
		and    x.rr_tipo = 'R'		
		and    to_char(x.rr_fecha,'MM') between :ls_fecini and :ls_fecfin
		and    to_char(x.rr_fecha,'YYYY') = :ls_anio		
		and    x.ep_codigo = :ls_epcodigo
		and 	 y.ru_codigo = '32';
		
		lq_total = (lc_impren - lc_acumrenta) / li_mescal
	end if
	
	if lq_total > 0 then 
		update no_rolpago
		set lq_total = :lq_total
		where ep_codigo = :ls_epcodigo
		and 	rr_codigo = :ls_secuen
		and 	ru_codigo = '32';
	
		update no_cabrol
		set rr_totegre = rr_totegre +:lq_total,
			 rr_liquido = rr_liquido -:lq_total
		where ep_codigo = :ls_epcodigo
		and 	rr_codigo = :ls_secuen;
		if sqlca.sqlcode < 0 then
			rollback;			
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el impuesto a la renta "+sqlca.sqlerrtext)
			return
		end if

	end if
	loop while true
	close imp_renta;
	commit;

//	dw_1.reset()
//	dw_master.reset()
//	dw_detail.reset()
//	dw_2.reset()
//	parent.triggerevent("open")
//	dw_1.setfocus()
	close(parent)
	w_marco.SetMicroHelp('Listo, fin del proceso')
	setpointer(arrow!)
else
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El c$$HEX1$$e100$$ENDHEX$$lculo del Impuesto a la Renta de este periodo ya fue realizado")
	return
end if
end event

type dw_1 from datawindow within w_actualiza_rol_opcion2
integer width = 3250
integer height = 216
integer taborder = 10
string dataobject = "d_sel_actualiza_rol_pagos"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
String ls_filtro,ls_sucodigo,ls_dtcodigo,ls_epcodigo,ls_nro
string periodo
long ll_rowm

Setpointer(Hourglass!)
This.AcceptText()
ls_sucodigo =  This.GetItemString(row,'su_codigo')
ls_dtcodigo =  This.GetItemString(row,'dt_codigo')
periodo     =  string(This.GetItemDate(row,'periodo'),'mm-yyyy')

Choose case this.GetColumnName()
case 'periodo'
	dw_master.enabled = true 
	dw_detail.enabled = true
	dw_master.retrieve(str_appgeninfo.empresa,periodo)
	dw_master.enabled = true 
	dw_detail.enabled = true
	dw_2.enabled = true

end Choose

if isnull(ls_sucodigo) then
ls_filtro="(su_codigo like '%')"
else
ls_filtro="su_codigo='"+ls_sucodigo+"'"
end if

if not isnull(ls_dtcodigo) then
ls_filtro=ls_filtro+" and dt_codigo='"+ls_dtcodigo+"'"
end if


dw_master.SetFilter(ls_filtro)
dw_master.Filter()
dw_master.GroupCalc()
dw_master.enabled = true
ll_rowm = dw_master.GetRow()
dw_master.SetRow(ll_rowm)
dw_master.ScrollToRow(ll_rowm)
dw_master.SetFocus()
dw_master.SetColumn('rr_horas')

If ll_rowm > 0 then
ls_epcodigo = dw_master.GetitemString(ll_rowm,"ep_codigo")
ls_nro      = dw_master.GetItemString(ll_rowm,"rr_codigo")
dw_detail.Retrieve(str_appgeninfo.empresa,ls_epcodigo,ls_nro)
dw_2.Retrieve(str_appgeninfo.empresa,ls_epcodigo,ls_nro)
else
dw_detail.reset()
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rol de pago para este per$$HEX1$$ed00$$ENDHEX$$odo no existe")
return
end if
Setpointer(arrow!)
end event

type dw_ubica from datawindow within w_actualiza_rol_opcion2
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_downkey pbm_dwnkey
boolean visible = false
integer x = 727
integer y = 440
integer width = 2066
integer height = 304
boolean bringtotop = true
boolean titlebar = true
string title = "B$$HEX1$$fa00$$ENDHEX$$squeda de empleado"
string dataobject = "d_busca_empleado"
boolean livescroll = true
end type

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

event itemchanged;string ls,ls_periodo, ls_criterio, ls_tipo,ls_epcodigo,ls_nro
long ll_found,ll_rowm



//ls_periodo =  string(dw_1.GetItemDate(1,'periodo'),'mm-yyyy')
//dw_master.retrieve(str_appgeninfo.empresa,ls_periodo)
//dw_master.SetFilter('')
//dw_master.Filter()
//dw_master.GroupCalc()
//ll_rowm = dw_master.GetRow()
//dw_master.SetRow(ll_rowm)
//dw_master.ScrollToRow(ll_rowm)
//dw_master.SetFocus()
//dw_master.SetColumn('rr_horas')

//If ll_rowm > 0 then
//	ls_epcodigo = dw_master.GetitemString(ll_rowm,"ep_codigo")
//	ls_nro      = dw_master.GetItemString(ll_rowm,"rr_codigo")
//	dw_detail.Retrieve(str_appgeninfo.empresa,ls_epcodigo,ls_nro)
//	dw_2.Retrieve(str_appgeninfo.empresa,ls_epcodigo,ls_nro)
//end if

CHOOSE CASE this.GetColumnName()

	CASE 'codant'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
					ls_criterio = "ep_codigo = " +  +"'"+ ls + "'"		
					ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
					if ll_found > 0 and not isnull(ll_found) then
					  dw_master.SetFocus()
					  dw_master.ScrollToRow(ll_found)
					  dw_master.SetRow(ll_found)
					  dw_master.SetColumn('rr_horas')
					  this.Visible = false
					else
					  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Empleado no se encuentra, verifique datos')
					  return
					end if
		   CASE 'F'
				ls_criterio = "ep_codigo like " +  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
    		   		dw_master.SetColumn('rr_horas')
				this.Visible = false	
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE
	CASE 'rucic'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ep_ci = " +  +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('rr_horas')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Cliente no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ep_ci like " +  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
		 	    dw_master.SetColumn('rr_horas')
				this.Visible = false	
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE
	CASE 'nombre'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ep_nombre = " +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('rr_horas')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Empleado no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ep_nombre like "  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
			    dw_master.SetColumn('rr_horas')
				this.Visible = false				
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE		
	CASE 'apellido'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ep_apepat = "   +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('rr_horas')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Empleado no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ep_apepat like "   +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
			   dw_master.SetColumn('rr_horas')
				this.Visible = false				
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE		
END CHOOSE

ls_epcodigo = dw_master.GetitemString(ll_found,"ep_codigo")
ls_nro      = dw_master.GetItemString(ll_found,"rr_codigo")
dw_detail.Retrieve(str_appgeninfo.empresa,ls_epcodigo,ls_nro)
dw_2.Retrieve(str_appgeninfo.empresa,ls_epcodigo,ls_nro)		

end event

event ue_downkey;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
//	dw_master.SetFilter('')
//	dw_master.Filter()
end if
end event

type cb_2 from commandbutton within w_actualiza_rol_opcion2
boolean visible = false
integer x = 2665
integer y = 4
integer width = 425
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar imp. renta"
end type

event clicked;string ls_epcodigo,ls_secuen,ls_periodo
dec{2} lq_total
int li_si

li_si = messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro que desea encerar el~r~n"+& 
					  "Impuesto a la Renta de este per$$HEX1$$ed00$$ENDHEX$$odo",question!,yesno!,2)
if li_si = 2 then return

setpointer(hourglass!)
ls_periodo = string(dw_1.getitemdate(1,"periodo"),'mm/yyyy')
	declare imp_renta cursor for
	select y.ep_codigo,y.rr_codigo,y.lq_total
	from   no_cabrol  x,  no_rolpago y,no_rubro z
	where  x. ep_codigo = y.ep_codigo
	and    x.rr_codigo = y.rr_codigo
	and    z.ru_codigo = y.ru_codigo
	and    to_char(x.rr_fecha,'MM/YYYY') = :ls_periodo
	and    y.lq_total > 0
	and    z.ru_codigo = '32' ;
open imp_renta;
	do
	fetch imp_renta into :ls_epcodigo,:ls_secuen,:lq_total;	
	if sqlca.sqlcode <> 0 then exit
		update no_rolpago
		set lq_total = 0
		where ep_codigo = :ls_epcodigo
		and 	rr_codigo = :ls_secuen
		and 	ru_codigo = '32';
	
		update no_cabrol
		set rr_totegre = rr_totegre -:lq_total,
			 rr_liquido = rr_liquido +:lq_total
		where ep_codigo = :ls_epcodigo
		and 	rr_codigo = :ls_secuen;

loop while true
close imp_renta;
commit;
setpointer(arrow!)
w_marco.setmicrohelp("Proceso Terminado")
end event

type cb_3 from commandbutton within w_actualiza_rol_opcion2
boolean visible = false
integer x = 3328
integer y = 12
integer width = 215
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;string ls_epcodigo,ls_rucodigo,ls_rrcodigo
dec{2} lc_total
int li_si

li_si = messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro que desea arreglar el~r~n"+& 
					  "rubro comisiones",question!,yesno!,2)
if li_si = 2 then return

setpointer(hourglass!)
declare imp_renta cursor for

SELECT "NO_PRESTAMO"."EP_CODIGO",   
		"NO_PRESTAMO"."RU_CODIGO",
		nvl(sum("NO_PRESTAMO"."PP_VALOR"),0)/"NO_PRESTAMO"."PP_CUOTAS"
 FROM "NO_PRESTAMO"  
WHERE "NO_PRESTAMO"."PP_ESTADO" not in ('A')    
AND "NO_PRESTAMO" ."PP_CUOTAS" > 1
and TRUNC("NO_PRESTAMO"."PP_FECHA") BETWEEN '01-mar-07' AND '29-mar-07' 
group by "NO_PRESTAMO"."EP_CODIGO","NO_PRESTAMO"."RU_CODIGO","NO_PRESTAMO"."PP_CUOTAS"		
order by to_number("NO_PRESTAMO"."EP_CODIGO");
open imp_renta;
do
	fetch imp_renta into :ls_epcodigo,:ls_rucodigo,:lc_total;	
	if sqlca.sqlcode <> 0 then exit
	select rr_codigo 
	into :ls_rrcodigo
	from no_cabrol
	where ep_codigo = :ls_epcodigo
	and rr_fecha = '28-mar-07'
	and rr_tipo = 'R';
	
	update no_rolpago  
	set lq_total = :lc_total
	where ep_codigo = :ls_epcodigo
	and rr_codigo = :ls_rrcodigo
	and ru_codigo = :ls_rucodigo;
loop while true
close imp_renta;
commit;
setpointer(arrow!)
w_marco.setmicrohelp("Proceso Terminado")




end event


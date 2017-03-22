HA$PBExportHeader$w_prestamo.srw
$PBExportComments$Si.Prestamos de los empleados
forward
global type w_prestamo from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_prestamo
end type
type pb_negociar from picturebutton within w_prestamo
end type
type st_2 from statictext within w_prestamo
end type
type pb_anular from picturebutton within w_prestamo
end type
type st_1 from statictext within w_prestamo
end type
type pb_pagar from picturebutton within w_prestamo
end type
type st_3 from statictext within w_prestamo
end type
end forward

global type w_prestamo from w_sheet_master_detail
integer width = 3063
integer height = 1540
string title = "Descuentos"
long backcolor = 67108864
event ue_consultar pbm_custom10
dw_ubica dw_ubica
pb_negociar pb_negociar
st_2 st_2
pb_anular pb_anular
st_1 st_1
pb_pagar pb_pagar
st_3 st_3
end type
global w_prestamo w_prestamo

type variables

end variables

forward prototypes
public function integer wf_preprint ()
end prototypes

event ue_consultar;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

public function integer wf_preprint ();long ll_filActMaestro
string ls_empresa, ls_empleado, ls_numero

ll_filActMaestro = dw_master.GetRow()
ls_empleado = dw_master.getItemString(ll_filActMaestro, "ep_codigo")
ls_numero = dw_master.getItemString(ll_filActMaestro, "pp_numero")

dw_report.setTransObject(sqlca)
dw_report.retrieve(str_appgeninfo.empresa,ls_empleado, ls_numero)

return 1

end function

on w_prestamo.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.pb_negociar=create pb_negociar
this.st_2=create st_2
this.pb_anular=create pb_anular
this.st_1=create st_1
this.pb_pagar=create pb_pagar
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.pb_negociar
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.pb_anular
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.pb_pagar
this.Control[iCurrent+7]=this.st_3
end on

on w_prestamo.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.pb_negociar)
destroy(this.st_2)
destroy(this.pb_anular)
destroy(this.st_1)
destroy(this.pb_pagar)
destroy(this.st_3)
end on

event open;string  ls_datos[]
date ld_hoy
datawindowchild dwc

select trunc(sysdate)
into :ld_hoy
from dual;

f_recupera_empresa(dw_master,'ep_codigo')
f_recupera_empresa(dw_ubica,'proveedor')
dw_ubica.GetChild('clase',dwc)
dwc.SetTransObject(sqlca)
dwc.Retrieve()
ls_datos[1] = 'P'
f_recupera_datos(dw_master,'ru_codigo',ls_datos,1)
call super::open
dw_master.is_SerialCodeColumn = "pp_numero"
dw_master.is_SerialCodeType = "PRESTAMO"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa

dw_master.ii_nrCols = 2
dw_master.is_connectionCols[1] = "ep_codigo"
dw_master.is_connectionCols[2] = "pp_numero"
dw_detail.is_connectionCols[1] = "ep_codigo"
dw_detail.is_connectionCols[2] = "pp_numero"
dw_detail.uf_setArgTypes()
//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()
pb_anular.BringToTop = true
st_1.BringToTop = true
pb_negociar.BringToTop = true
st_2.BringToTop = true
dw_master.uf_insertCurrentRow()
dw_master.setitem(dw_master.getrow(),"pp_fecha",ld_hoy)
dw_master.setFocus()
dw_detail.SetRowFocusIndicator(Hand!)
end event

event ue_insert;graphicObject lgo_curObject
long ll_curRow
date ld_hoy
uo_dw_basic ludw_basic

select trunc(sysdate)
into :ld_hoy
from dual;

lgo_curObject = getFocus()
if lgo_curObject.typeof() <> DataWindow! then
	beep(1)
	return
end if

// you can only insert in the detail of a valid master row
if lower(lgo_curObject.className()) = "dw_detail" then
	beep(1)
	return
end if

ludw_basic = lgo_curObject
ludw_basic.uf_insertCurrentRow()
dw_master.setitem(dw_master.getrow(),"pp_fecha",ld_hoy)

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)

else
	dw_master.resize(li_width - dw_master.x, dw_master.height)
	dw_detail.resize(dw_master.width,li_height - dw_detail.y - dw_master.y)
	pb_anular.BringToTop = true
	st_1.BringToTop = true
	pb_negociar.BringToTop = true
	st_2.BringToTop = true	
	pb_pagar.BringToTop = true
	st_3.BringToTop = true		
	
end if	
this.setRedraw(True)


end event

event ue_delete;beep(1)
end event

event ue_retrieve;call super::ue_retrieve;dw_master.enabled = True

end event

event ue_update;call super::ue_update;dw_master.Settaborder("ep_codigo",10)
dw_master.Settaborder("ru_codigo",20)
dw_master.Settaborder("tp_codigo",30)
dw_master.Settaborder("pp_valor",40)
dw_master.Settaborder("pp_observ",60)

end event

type dw_master from w_sheet_master_detail`dw_master within w_prestamo
event ue_nextfield pbm_dwnprocessenter
integer x = 0
integer y = 0
integer width = 3003
integer height = 588
integer taborder = 10
string dataobject = "d_prestamo"
boolean vscrollbar = false
end type

event dw_master::ue_nextfield;send(handle(this),256,9,long(0,0))
return 1
end event

event dw_master::itemchanged;call super::itemchanged;string pp_estado
long i,ll_filact
dec{4} pp_valor,ld_cuota
date dp_fecpag


if dwo.name = "pp_valor" then
	pp_valor = dec(data)
	setitem(row,"pp_cuotas",0)
	setitem(row,"pp_saldo",pp_valor)	
	dw_detail.reset()
end if
if dwo.name = "pp_cuotas" then
	//Seg$$HEX1$$fa00$$ENDHEX$$n el n$$HEX1$$fa00$$ENDHEX$$mero de cuotas, inserto las l$$HEX1$$ed00$$ENDHEX$$neas de detalle
	pp_valor=dw_master.GetItemDecimal(row,'pp_valor')
	if long(data) <= 0 then 
		dw_detail.reset()
		return
	end if
	ld_cuota= pp_valor/long(data)
	dp_fecpag= date(GetItemDateTime(row,'pp_fecha'))
	if day(dp_fecpag) > 15 then	
		dp_fecpag = Relativedate(dp_fecpag,30)
	end if
	dw_detail.reset()
	for i = 1 to long(data)
		ll_filact=dw_detail.InsertRow(0)
		dw_detail.SetItem(ll_filact,'dp_numero',i)
		dw_detail.SetItem(ll_filact,'dp_valcuo',ld_cuota)
		dw_detail.SetItem(ll_filact,'dp_fecpag',dp_fecpag)		
		dp_fecpag = Relativedate(dp_fecpag,30)			
	next
end if		



end event

event dw_master::updatestart;call super::updatestart;string ls_estado

ls_estado = trim(getitemstring(getrow(),"pp_estado"))
if ls_estado = 'X' then
	setitem(getrow(),"pp_estado",'P')
end if
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_prestamo
integer x = 0
integer y = 588
integer width = 3003
integer height = 840
integer taborder = 20
string dataobject = "d_detalle_pago_ptmo"
end type

type dw_report from w_sheet_master_detail`dw_report within w_prestamo
integer x = 0
integer y = 0
integer taborder = 50
string dataobject = "d_rep_prestamo"
end type

type dw_ubica from datawindow within w_prestamo
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_dwnkey pbm_dwnkey
boolean visible = false
integer x = 233
integer y = 104
integer width = 1970
integer height = 344
integer taborder = 31
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Pr$$HEX1$$e900$$ENDHEX$$stamo"
string dataobject = "d_busca_prestamo"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

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
				ls_criterio = "pp_numero = " +  +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('pp_observ')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Registro no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "pp_numero like " +  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
    		   dw_master.SetColumn('pp_observ')
				this.Visible = false	
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE
	CASE 'proveedor'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "ep_codigo = " +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('ep_codigo')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Registro no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "ep_codigo like "  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
			   dw_master.SetColumn('ep_codigo')
				this.Visible = false				
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE		
	CASE 'clase'
		ls_tipo = this.GetItemString(1,'tipo')
		ls = this.getText()
		CHOOSE CASE ls_tipo
			CASE 'B'
				ls_criterio = "tp_codigo = " +"'"+ ls + "'"		
				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
				if ll_found > 0 and not isnull(ll_found) then
				  dw_master.SetFocus()
				  dw_master.ScrollToRow(ll_found)
				  dw_master.SetRow(ll_found)
				  dw_master.SetColumn('tp_codigo')
				  this.Visible = false
	  			else
				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Registro no se encuentra, verifique datos')
				  return
			  end if
		   CASE 'F'
				ls_criterio = "tp_codigo like "  +"'"+ ls + "'"		
				dw_master.SetFilter(ls_criterio)
				dw_master.Filter()
				dw_master.SetFocus()
			   dw_master.SetColumn('tp_codigo')
				this.Visible = false				
				dw_master.ScrollToRow(dw_master.GetRow())
				dw_master.SetRow(dw_master.GetRow())				
				
		END CHOOSE	
END CHOOSE
end event

event ue_dwnkey;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

type pb_negociar from picturebutton within w_prestamo
integer x = 2299
integer y = 128
integer width = 178
integer height = 184
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Renegociar.Gif"
alignment htextalign = left!
end type

event clicked;long ll_fila,pp_cuotas,ll_new_fila
decimal pp_saldo,pp_valor
string ru_codigo,ls_rubro,pp_estado,tp_codigo,pp_numero,ep_codigo
date pp_fecha
datawindowChild ldw_aux

ll_fila          =dw_master.GetRow()
pp_saldo  =dw_master.GetItemDecimal(ll_fila,'pp_saldo')
pp_estado=dw_master.GetItemString(ll_fila,'pp_estado')
pp_valor    =dw_master.GetItemDecimal(ll_fila,'pp_valor')
ru_codigo =dw_master.GetItemString(ll_fila,'ru_codigo')

//Renegociado
if (trim(pp_estado)='R') then
	MessageBox("Error",ls_rubro+" : ya fue negociado anteriormente, no se puede negociar",StopSign!)
	return
end if
//Anulados
if (trim(pp_estado)='A') then
	MessageBox("Error",ls_rubro+" : anulado, no se puede negociar",StopSign!)
	return
end if
//Prestamo Pagado
if (trim(pp_estado)='T') then
	MessageBox("Error",ls_rubro+" : se termin$$HEX2$$f3002000$$ENDHEX$$de pagar, no se puede negociar",StopSign!)
	return
end if	


select ru_abrevi
into :ls_rubro
from no_rubro
where ru_codigo = :ru_codigo;

if trim(pp_estado)='P' and pp_saldo <> pp_valor then // si esta pendiente de pago
	// inserto un nuevo pr$$HEX1$$e900$$ENDHEX$$stamo con valor igual al saldo pendiente.
		if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea negociar el registro actual?",Question!,YesNo!)=1 then

			select trunc(sysdate)
			into :pp_fecha
			from dual;
			
			ep_codigo=dw_master.GetItemString(ll_fila,'ep_codigo')
			tp_codigo=dw_master.GetItemString(ll_fila,'tp_codigo')
			pp_numero=dw_master.GetItemString(ll_fila,'pp_numero')
			pp_valor=pp_saldo
			ll_new_fila=dw_master.InsertRow(0)
			dw_master.ScrollToRow(ll_new_fila)
			dw_master.SetItem(ll_fila,'pp_estado','R') // cambio el estado
			dw_master.SetItem(ll_new_fila,'pp_fecha',pp_fecha)			
			dw_master.SetItem(ll_new_fila,'ep_codigo',ep_codigo)
			dw_master.SetItem(ll_new_fila,'ru_codigo',ru_codigo)
			dw_master.SetItem(ll_new_fila,'tp_codigo',tp_codigo)
			dw_master.SetItem(ll_new_fila,'pp_valor',pp_valor)
			dw_master.SetItem(ll_new_fila,'pp_saldo',pp_saldo)
			dw_master.SetItem(ll_new_fila,'pp_observ',"Renegociaci$$HEX1$$f300$$ENDHEX$$n de "+ls_rubro+" N$$HEX1$$ba00$$ENDHEX$$: "+pp_numero)
			dw_master.Settaborder("pp_valor",0)
			dw_master.Settaborder("ep_codigo",0)
			dw_master.Settaborder("tp_codigo",0)			
			dw_master.Settaborder("ru_codigo",0)
			dw_master.Settaborder("pp_observ",0)
		end if
end if

end event

type st_2 from statictext within w_prestamo
integer x = 2245
integer y = 308
integer width = 293
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Renegociar"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_anular from picturebutton within w_prestamo
integer x = 2542
integer y = 128
integer width = 178
integer height = 184
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "imagenes\Anulado.gif"
end type

event clicked;long ll_fila
decimal pp_valor,pp_saldo
ll_fila=dw_master.GetRow()
pp_valor=dw_master.GetItemDecimal(ll_fila,'pp_valor')
pp_saldo=dw_master.GetItemDecimal(ll_fila,'pp_saldo')
//Renegociado
if (trim(dw_master.GetItemString(ll_fila,'pp_estado'))='R') then
	MessageBox("Error","No se puede anular un pr$$HEX1$$e900$$ENDHEX$$stamo renegociado",StopSign!)
	return
end if
//Anulados
if (trim(dw_master.GetItemString(ll_fila,'pp_estado'))='A') then
	MessageBox("Error","El pr$$HEX1$$e900$$ENDHEX$$stamo est$$HEX2$$e1002000$$ENDHEX$$anulado",StopSign!)
	return
end if
//Prestamo Pagado
if (trim(dw_master.GetItemString(ll_fila,'pp_estado'))='T') then
	MessageBox("Error","El pr$$HEX1$$e900$$ENDHEX$$stamo se termin$$HEX2$$f3002000$$ENDHEX$$de pagar, no se puede anular",StopSign!)
	return
end if
// Pendiente de pago
if (trim(dw_master.GetItemString(ll_fila,'pp_estado'))='P' and pp_valor<>pp_saldo) then
	MessageBox("Error","No se puede anular un pr$$HEX1$$e900$$ENDHEX$$stamo con saldo pendiente",StopSign!)
   return
else
// Anular pr$$HEX1$$e900$$ENDHEX$$stamos	
	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro de que desea anular este pr$$HEX1$$e900$$ENDHEX$$stamo?",Question!,YesNo!)=1 then
			dw_master.SetItem(ll_fila,'pp_estado','A')
	end if
end if	



end event

type st_1 from statictext within w_prestamo
integer x = 2537
integer y = 308
integer width = 187
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Anular"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_pagar from picturebutton within w_prestamo
integer x = 2784
integer y = 128
integer width = 178
integer height = 184
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "imagenes\dolar.gif"
end type

event clicked;long ll_fila
decimal pp_saldo,pp_valor
string pp_estado,pp_numero,ep_codigo
date pp_fecha

ll_fila  = dw_master.GetRow()
pp_saldo  = dw_master.GetItemDecimal(ll_fila,'pp_saldo')
pp_valor    = dw_master.GetItemDecimal(ll_fila,'pp_valor')
pp_estado = dw_master.GetItemString(ll_fila,'pp_estado')	

if trim(pp_estado) = 'P' and pp_saldo <= pp_valor then // si esta pendiente de pago
	// inserto un nuevo pr$$HEX1$$e900$$ENDHEX$$stamo con valor igual al saldo pendiente.
		if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea pagar el saldo de este prestamo?",Question!,YesNo!)=1 then

			pp_numero = dw_master.GetItemString(ll_fila,'pp_numero')
			ep_codigo = dw_master.GetItemString(ll_fila,'ep_codigo')			

			select trunc(sysdate)
			into :pp_fecha
			from dual;
			
			dw_master.SetItem(ll_fila,'pp_estado','T') // cambio el estado
			dw_master.SetItem(ll_fila,'pp_saldo',0)
			dw_master.SetItem(ll_fila,'pp_observ',"Prestamo terminado de pagar el: "+string(pp_fecha,'dd/mm/yyyy'))
			
			update no_detpag
			set  dp_cuocanc = 'S'
			where ep_codigo = :ep_codigo
			and pp_numero = :pp_numero
			and dp_cuocanc = 'N';
			if  sqlca.sqlcode < 0 then
				rollback;
				MessageBox("Error","Problemas al actualizar el prestamo")
				return				
			end if
			if dw_master.update() = 1 then
				commit;
			else
				rollback;
			end if
			dw_detail.retrieve(ep_codigo,pp_numero)
		end if
else
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","El prestamo ya no esta pendiente de pago y no puede modificarse.")
		return
end if




end event

type st_3 from statictext within w_prestamo
integer x = 2798
integer y = 308
integer width = 169
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Pagar"
alignment alignment = center!
boolean focusrectangle = false
end type


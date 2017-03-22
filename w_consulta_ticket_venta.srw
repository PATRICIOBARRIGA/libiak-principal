HA$PBExportHeader$w_consulta_ticket_venta.srw
forward
global type w_consulta_ticket_venta from w_sheet_master_detail
end type
type cb_formpag from commandbutton within w_consulta_ticket_venta
end type
type dw_ubica from datawindow within w_consulta_ticket_venta
end type
type dw_detalle_pago from uo_dw_detail within w_consulta_ticket_venta
end type
end forward

global type w_consulta_ticket_venta from w_sheet_master_detail
integer width = 4005
integer height = 1760
string title = "Consulta de Tickets de venta"
long backcolor = 79741120
event ue_consultar pbm_custom16
cb_formpag cb_formpag
dw_ubica dw_ubica
dw_detalle_pago dw_detalle_pago
end type
global w_consulta_ticket_venta w_consulta_ticket_venta

type variables
decimal ic_iva, ic_descuento
int il_descue
long ii_excento_iva
string  is_mensaje, is_estado='2'
boolean ib_detalle_pago = true
boolean ib_ubica = false,  prod_visible = false
integer ii_pagesize = 10
end variables

event ue_consultar;call super::ue_consultar;dw_master.postevent(DoubleClicked!)
end event

on w_consulta_ticket_venta.create
int iCurrent
call super::create
this.cb_formpag=create cb_formpag
this.dw_ubica=create dw_ubica
this.dw_detalle_pago=create dw_detalle_pago
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_formpag
this.Control[iCurrent+2]=this.dw_ubica
this.Control[iCurrent+3]=this.dw_detalle_pago
end on

on w_consulta_ticket_venta.destroy
call super::destroy
destroy(this.cb_formpag)
destroy(this.dw_ubica)
destroy(this.dw_detalle_pago)
end on

event open;call super::open;dw_master.SetTransObject(sqlca)
dw_detail.SetTransObject(sqlca)
dw_detalle_pago.SetTransObject(SQLCA)
end event

event ue_retrieve;	beep(1)

end event

event ue_nextrow;dw_detalle_pago.Visible = false
dw_detail.visible = true
ib_detalle_pago = true
dw_master.SetFocus()
//vsb_1.Position = vsb_1.Position + 1
call super::ue_nextrow
end event

event ue_print;call super::ue_print;dw_detalle_pago.Visible = false
//dw_master.Reset()
//dw_detail.Reset()
//dw_master.InsertRow(0)
//dw_master.uf_insertCurrentRow()
end event

event ue_outedition;call super::ue_outedition;dw_detail.Reset()
dw_detalle_pago.Reset()
dw_master.Reset()
dw_master.InsertRow(0)
dw_master.SetFocus()
//dw_master.uf_insertCurrentRow()
end event

event ue_anular;//EVENTO PARA ANULAR UN TICKET DE VENTA
//Ultima modificaci$$HEX1$$f300$$ENDHEX$$n 21/05/2007 por edivas

dec{2}    ld_cantidad,ld_valor,lc_valor
long       ll_totalreg,ll_i,ll_regactual,ll_factura,ll_resul,ll_totalregdp
string     ls_item,ls_sucursal,ls_bodega, ls_tipo
string     ls_rpnumdoc ,ls_fpcod,ls_codcli,ls_motor
char       lch_kit
int          li_res, li_fp,li_contador
datetime ldt_fecha,ldt_now
date 		ld_fecha, ld_fecven


ll_regactual = dw_master.GetRow()
ll_factura = dw_master.GetItemNumber(ll_regactual,"ve_numero")
ldt_fecha = dw_master.getitemdatetime(ll_regactual,"ve_fecha")
ls_codcli = dw_master.GetItemString(ll_regactual,"ce_codigo")

SELECT  sysdate
INTO      :ldt_now
FROM    dual;

Select sa_tipo
into :ls_tipo
from sg_acceso
where em_codigo = :str_appgeninfo.empresa
and sa_login = :str_appgeninfo.username;

If ls_tipo <> 'A' Then
        if date(ldt_fecha) <> date(ldt_now) then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'No puede anular este Ticket por:~r~n1.No es de hoy d$$HEX1$$ed00$$ENDHEX$$a,'+&
		                          '~r~n2.No Tiene Permiso.')
		return -1
        end if
End if

setpointer(hourglass!)
this.setmicrohelp("Verificando si el ticket tiene devoluci$$HEX1$$f300$$ENDHEX$$n")

select count(*)
into :li_contador
from fa_venta
where  em_codigo = 1
and su_codigo = :str_appgeninfo.sucursal
and es_codigo = 10
and ve_numpre = :ll_factura;

if li_contador > 0 then
messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'Existe una Devoluci$$HEX1$$f300$$ENDHEX$$n del ticket No.' + string(ll_factura)+ ' y no se puede anular.')
return -1
end if
this.setmicrohelp("")
li_res = messageBox('Confirme por favor', 'Est$$HEX2$$e1002000$$ENDHEX$$seguro que desea anular el ticket No.' + string(ll_factura) , Question!, YesNo!)
If li_res <> 1 Then 
return -1
End if
this.setmicrohelp("Anulando el ticket de venta")
ls_sucursal = dw_master.GetItemString(ll_regactual,"su_codigo")
ls_bodega = dw_master.GetItemString(ll_regactual,"bo_codigo")
ll_totalreg = dw_detail.RowCount()
// devolver valor de Nota de credito
ll_totalregdp = dw_detalle_pago.RowCount()
for li_fp = 1 to ll_totalregdp
	ls_fpcod = dw_detalle_pago.GetItemString(li_fp,"fp_codigo")
	ld_fecha = date(dw_detalle_pago.GetItemdatetime(li_fp,"rp_fecha"))
	ld_fecven = date(dw_detalle_pago.GetItemdatetime(li_fp,"rp_fecven"))
	if ls_fpcod = '2'  then
		ld_valor = dw_detalle_pago.GetItemDecimal(li_fp,"rp_valor")
		ls_rpnumdoc = dw_detalle_pago.GetItemString(li_fp,"rp_numdoc")

		update fa_venta
		set ve_valotros = ve_valotros + :ld_valor
		where em_codigo = 1
		and su_codigo = :str_appgeninfo.sucursal
		and es_codigo = 10
		and ve_numero = :ls_rpnumdoc ;
	 end if
	 if (ls_fpcod = '1') and (ld_fecha <> ld_fecven) then
		lc_valor += dw_detalle_pago.GetItemDecimal(li_fp,'rp_valor')
	end if
next 

if lc_valor > 0 then
	UPDATE FA_CLIEN
	SET CE_SALCRE = CE_SALCRE + :lc_valor
	WHERE CE_CODIGO = :ls_codcli
	AND EM_CODIGO = :str_appgeninfo.empresa;
	if sqlca.sqlcode <> 0 then
		messageBox('Error Interno', 'No se puede actualizar el saldo del cliente ' +sqlca.sqlerrtext)
		return -1
	end if
end if


ll_resul = f_anula_factura(ls_sucursal,ls_bodega,ll_factura,'2','6')

If ll_resul = 1 then
	for ll_i = 1 to ll_totalreg
		ls_item = dw_detail.GetItemString(ll_i,"it_codigo")
		ld_cantidad = dw_detail.GetItemNumber(ll_i,"dv_candes")
		ls_motor = dw_detail.GetItemString(ll_i,"dv_motor")		
		lch_kit = dw_detail.GetItemString(ll_i,"it_kit")	
		if lch_kit = 'V' then		
				update in_itedet
				set estado = 'R'
				where em_codigo = :str_appgeninfo.empresa
				and su_codigo = :str_appgeninfo.sucursal
				and di_ref1 = :ls_motor;
				if sqlca.sqlcode <> 0 then
					messageBox('Error Interno', 'No se puede encontrar el n$$HEX1$$fa00$$ENDHEX$$mero de motor...Por favor avise a sistemas el error : ' + sqlca.sqlerrtext )
					rollback;
					return -1
				end if			
		end if
		//llamada a la funci$$HEX1$$f300$$ENDHEX$$n para devolver todos los stocks a la sucursal
		f_carga_stock_tdr_sucursal(ls_item,ld_cantidad)
		//lamada a la funci$$HEX1$$f300$$ENDHEX$$n para devolver el stock a la bodega
		f_carga_stock_bodega(str_appgeninfo.seccion,ls_item,ld_cantidad)
	next
	

	//borro los movimientos de inventario que genero el ticket
	delete from in_movim
	where em_codigo = '1'
	and su_codigo = :str_appgeninfo.sucursal
	and tm_codigo = '2'
	and tm_ioe = 'E'
	and ve_numero = :ll_factura
	and es_codigo = '2';
	
	commit using sqlca;
End if
messageBox('Resultado', 'El Ticket No.' + string(ll_factura) + ' fue anulado completamente ' )
dw_master.reset()
dw_detail.reset()
dw_detalle_pago.reset()
dw_master.setFocus()
this.setmicrohelp("Listo")
setpointer(arrow!)
//vsb_1.MinPosition = 1
//vsb_1.MaxPosition = dw_master.RowCount()
//ii_pagesize = dw_master.RowCount()*0.1


end event

type dw_master from w_sheet_master_detail`dw_master within w_consulta_ticket_venta
integer x = 0
integer y = 0
integer width = 3963
integer height = 592
integer taborder = 50
string dataobject = "d_ticket_venta_2"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_master::itemerror;call super::itemerror;messagebox('Error',is_mensaje)
return 1
end event

event dw_master::clicked;call super::clicked;
//m_marco.m_opcion1.m_buscarproducto.enabled = false
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = true
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

type dw_detail from w_sheet_master_detail`dw_detail within w_consulta_ticket_venta
event ue_recuperar pbm_custom41
event ue_darimagen pbm_custom42
event ue_keydown pbm_dwnkey
integer x = 0
integer y = 712
integer width = 3959
integer height = 924
integer taborder = 20
boolean titlebar = true
string title = "Detalle de Ticket de Venta"
string dataobject = "d_consulta_detalle_venta"
end type

event dw_detail::clicked;call super::clicked;
//m_marco.m_opcion1.m_buscarproducto.enabled = true
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = false
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 

end event

type dw_report from w_sheet_master_detail`dw_report within w_consulta_ticket_venta
integer x = 247
integer y = 0
integer width = 2821
integer height = 552
integer taborder = 30
boolean hsplitscroll = true
end type

type cb_formpag from commandbutton within w_consulta_ticket_venta
integer y = 588
integer width = 434
integer height = 120
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Detalle de Pago"
end type

event clicked;
if ib_detalle_pago &
Then
	dw_detail.visible = false
	dw_detalle_pago.visible = true
	cb_formpag.text = '&Detalle de Ticket'
	ib_detalle_pago = false
else
	dw_detail.visible = true
	dw_detalle_pago.visible = false
	cb_formpag.text = 'Detalle de Pago'
	dw_detail.SetFocus()
	ib_detalle_pago = true
end if



end event

type dw_ubica from datawindow within w_consulta_ticket_venta
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 750
integer y = 200
integer width = 1472
integer height = 260
integer taborder = 51
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Ticket"
string dataobject = "d_sel_factura"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
    dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

event itemchanged;string ls, ls_criterio, ls_tipo
long ll_numero,ll_nreg

f_recupera_empresa(dw_detalle_pago,"fp_codigo") 
f_recupera_empresa(dw_detalle_pago,"if_codigo") 

If dwo.name  = "factura" &
Then
ll_numero = long(data)
dw_master.Reset()
dw_detail.Reset()
dw_detalle_pago.Reset()
ll_nreg = dw_master.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ll_numero)

If ll_nreg <= 0 Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No est$$HEX2$$e1002000$$ENDHEX$$registrado el Ticket N$$HEX2$$ba002000$$ENDHEX$$"+string(ll_numero)+"  $$HEX2$$f3002000$$ENDHEX$$ya ha sido anulado....<Por favor verifique...!!!>")
	Return
End if

dw_detail.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ll_numero)
dw_detalle_pago.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,is_estado,str_appgeninfo.seccion,ll_numero)
dw_master.enabled = True
dw_detail.enabled = True
dw_detalle_pago.enabled = True
End if 






//CHOOSE CASE this.GetColumnName()
//CASE 'factura'
//		 ls_tipo = this.GetItemString(1,'tipo')
//		 ls = this.getText()
//		 CHOOSE CASE ls_tipo
//			CASE 'B'
//				ls_criterio = "ve_numero = " +  ls
//				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
//				if ll_found > 0 and not isnull(ll_found) then
//				  dw_master.SetFocus()
//				  dw_master.ScrollToRow(ll_found)
//				  dw_master.SetRow(ll_found)
//				  this.Visible = false
//	  			else
//				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Factura no se encuentra, verifique datos')
//				  return
//			  end if
//		   CASE 'F'
//				ls_criterio = "ve_numero" +  ls 
//				dw_master.SetFilter(ls_criterio)
//				dw_master.Filter()
//				dw_master.SetFocus()
//				this.Visible = false	
//				dw_master.ScrollToRow(dw_master.GetRow())
//				dw_master.SetRow(dw_master.GetRow())				
//				
//		END CHOOSE
//END CHOOSE
end event

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event

type dw_detalle_pago from uo_dw_detail within w_consulta_ticket_venta
event ue_guardar pbm_custom09
boolean visible = false
integer y = 712
integer width = 3333
integer height = 920
integer taborder = 10
boolean titlebar = true
string title = "Detalle de Pago"
string dataobject = "d_consulta_detalle_pago"
end type


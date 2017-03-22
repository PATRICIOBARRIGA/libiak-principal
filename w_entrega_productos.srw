HA$PBExportHeader$w_entrega_productos.srw
$PBExportComments$Si
forward
global type w_entrega_productos from w_sheet_1_dw_maint
end type
type p_producto from picture within w_entrega_productos
end type
type em_timer from editmask within w_entrega_productos
end type
type st_1 from statictext within w_entrega_productos
end type
type st_2 from statictext within w_entrega_productos
end type
end forward

global type w_entrega_productos from w_sheet_1_dw_maint
integer x = 5
integer y = 268
integer width = 2633
integer height = 1516
string title = "Entrega de Productos"
long backcolor = 12632256
p_producto p_producto
em_timer em_timer
st_1 st_1
st_2 st_2
end type
global w_entrega_productos w_entrega_productos

type variables
string  is_parametro[],is_estado = '2'
//decimal ic_stock, ic_requerida = 0
//boolean primera = true,  prod_visible = false
long il_minutos = 3, il_time = 1  //, il_facturas[4], il_num, il_tiempo = 10
end variables

event open;SetPointer(Hourglass!)
this.ib_notautoretrieve = true
is_parametro[1] = str_appgeninfo.empresa
is_parametro[2] = str_appgeninfo.sucursal
dw_datos.SetTransObject(sqlca)
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
f_recupera_datos(dw_datos,"fa_venta_ep_codigo",is_parametro,2)
dw_datos.Retrieve(integer(str_appgeninfo.sucursal),2)
call super::open
SetPointer(arrow!)

end event

event ue_insert;beep(1)
end event

on w_entrega_productos.create
int iCurrent
call super::create
this.p_producto=create p_producto
this.em_timer=create em_timer
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_producto
this.Control[iCurrent+2]=this.em_timer
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_entrega_productos.destroy
call super::destroy
destroy(this.p_producto)
destroy(this.em_timer)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_delete;beep(1)
end event

event ue_enterqry;beep(1)
end event

event ue_execqry;beep(1)
end event

event ue_print;beep(1)
end event

event ue_retrieve;SetPointer(Hourglass!)
is_parametro[1] = str_appgeninfo.empresa
is_parametro[2] = str_appgeninfo.sucursal
f_recupera_datos(dw_datos,"fa_venta_ep_codigo",is_parametro,2)
dw_datos.Retrieve(integer(str_appgeninfo.sucursal),2)
SetPointer(arrow!)
end event

event timer;call super::timer;//long li, max
//if il_time = il_minutos then
//	il_time = 0
//	max = dw_datos.RowCount()
//		if isnull(max) or max = 0 then 
//			this.TriggerEvent('ue_retrieve')
//			return
//		end if
//		for li = 1 to max 
//				dw_datos.SetItem(li,'dv_entrega','S')
//		next
//	dw_datos.Update()
//	this.TriggerEvent('ue_retrieve')
//else
//	il_time++
//end if
end event

event resize;call super::resize;//dataWindow ldw_aux
//
//if this.ib_inReportMode then
//	ldw_aux = dw_report
//else
//	ldw_aux = dw_datos
//end if
//
//ldw_aux.resize(this.workSpaceWidth() - pb_1.width , this.workSpaceHeight())
//
end event

event activate;call super::activate;//m_marco.m_edicion.m_recuperar.enabled = true
//m_marco.m_edicion.m_recuperar.toolbarItemVisible = true
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_entrega_productos
event ue_keydown pbm_dwnkey
event ue_darimagen pbm_custom24
integer y = 0
integer width = 2601
integer height = 1408
integer taborder = 20
string dataobject = "d_despacho_tickets"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::ue_keydown;call super::ue_keydown;long ll_numero, ll_filact, li, max
if (KeyDown(KeyControl!)) and (KeyDown(KeyEnter!)) and not (KeyDown(KeyAlt!)) then
	max = this.RowCount()
	if isnull(max) or max = 0 then return
	ll_filact = this.GetRow()
	ll_numero = this.GetItemNumber(ll_filact, 've_numero')
	if isnull(ll_numero) then return
	for li = 1 to max 
		if this.GetItemNumber(li, 've_numero') = ll_numero then
			this.SetRow(li)
			this.SetItem(li,'dv_entrega','S')
//			this.TriggerEvent(itemchanged!)
		end if
	next
end if
if (KeyDown(KeyControl!)) and (KeyDown(KeyAlt!)) and (KeyDown(KeyEnter!)) then
if is_estado = '2' then
	is_estado = '1'
	parent.title = 'Entrega de Productos - ' + ' Facturaci$$HEX1$$f300$$ENDHEX$$n'
else
	is_estado = '2'
	parent.title = 'Entrega de Productos - ' + ' Punto de Venta'
end if
	dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,is_estado)
end if
if keydown(KeyF12!) then
	this.TriggerEvent('ue_darimagen')
end if
end event

event dw_datos::ue_darimagen;call super::ue_darimagen;//int li_fila, li
//string ls_produ, ls
//
//if prod_visible then
//	prod_visible = false
//	p_producto.Visible = false
//else
//prod_visible = true 
//li_fila = this.getrow()
//ls_produ = this.GetItemString(li_fila,'codant')
//if not isnull(ls_produ) and ls_produ <> '' then
//	Select it_imagen
//	  into :ls
//	  from in_item
//    where em_codigo = :str_appgeninfo.empresa
//	   and it_codant = :ls_produ;
//	if sqlca.sqlcode <> 0 then
//		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Ingrese primero un producto')
//	end if
//	p_producto.PictureName = ls
//	p_producto.Height = 56.5
//	p_producto.Width = 91.9
//	p_producto.Visible = true
//	for li = 1 to 10 //565 es el alto m$$HEX1$$e100$$ENDHEX$$ximo (factor 6)
//		p_producto.Visible = false
//		p_producto.Height = p_producto.Height+56.5
//		p_producto.Width = p_producto.Width + 91.9//(919 es ancho m$$HEX1$$e100$$ENDHEX$$ximo)
//		p_producto.Visible = true
//	next
//end if	
//end if
end event

event dw_datos::retrieverow;call super::retrieverow;//long ll_numero
//ll_numero=dw_datos.GetItemNumber(row,'ve_numero')
//if row=1 then
//	il_facturas[1]=ll_numero
//	il_num=1
//else
//	if ll_numero<>il_facturas[il_num] then
//		il_num++
//		il_facturas[il_num]=ll_numero
//	end if
//end if
//
//if il_num>3 then
//	return 1
//end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_entrega_productos
integer x = 18
integer y = 20
integer taborder = 30
end type

type p_producto from picture within w_entrega_productos
boolean visible = false
integer x = 695
integer y = 292
integer width = 1367
integer height = 796
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_timer from editmask within w_entrega_productos
boolean visible = false
integer x = 562
integer y = 32
integer width = 238
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "3"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,##0"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "1~~60"
end type

event modified;il_minutos=long(this.text)
il_time = 1
timer(60)
end event

type st_1 from statictext within w_entrega_productos
boolean visible = false
integer x = 73
integer y = 32
integer width = 489
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Refrescar en:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_entrega_productos
boolean visible = false
integer x = 827
integer y = 32
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "minutos"
alignment alignment = right!
boolean focusrectangle = false
end type


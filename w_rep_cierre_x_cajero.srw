HA$PBExportHeader$w_rep_cierre_x_cajero.srw
$PBExportComments$si
forward
global type w_rep_cierre_x_cajero from w_sheet_1_dw
end type
type dw_sel_rep from datawindow within w_rep_cierre_x_cajero
end type
type dw_cc from uo_dw_comprobante within w_rep_cierre_x_cajero
end type
type dw_sd from datawindow within w_rep_cierre_x_cajero
end type
type cb_1 from commandbutton within w_rep_cierre_x_cajero
end type
type dw_1 from datawindow within w_rep_cierre_x_cajero
end type
end forward

global type w_rep_cierre_x_cajero from w_sheet_1_dw
integer width = 5061
integer height = 2348
string title = "Cierre Diario de Caja"
event type integer ue_contabilizar ( )
dw_sel_rep dw_sel_rep
dw_cc dw_cc
dw_sd dw_sd
cb_1 cb_1
dw_1 dw_1
end type
global w_rep_cierre_x_cajero w_rep_cierre_x_cajero

type variables
string is_numero,is_cajero
date id_fecha
boolean ib_permitir_contabilizacion = false

end variables

forward prototypes
public function integer wf_verifica_parametros ()
end prototypes

event type integer ue_contabilizar();/*Contabiliza el */
long ll_reg,ll_row,ll_find
int  i,j 
Dec{2} lc_neto,lc_iva,lc_valpag,lc_valor,lc_dif
String ls_cta,ls_codpct,ls_obs,ls_tipo = '1',&
          ls_codprv, ls_ctaprv,ls_ctaiva,ls_ctagto,ls_signo,ls_cc,ls_nulo
Long   v_cpnumero,v_cpnumdoc,ll_new    
Date   ld_ini,ld_fin
Datetime  ld_fecha

Setnull(ls_nulo)

dw_cc.reset()



w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n...por favor espere...")
Setpointer(Hourglass!)
If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Recuerde ejecutar el cierre de todas las cajas y todas las sucursales para realizar la contabilizaci$$HEX1$$f300$$ENDHEX$$n....Desea continuar....?", Question!,YesNo!,2) = 2 then
return -1
end if

if ib_permitir_contabilizacion = false then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para contabilizar debe primero presionar el boton VER DETALLE POR SUCURSAL...")
	return -1
end if
  	  
dw_cc.visible = true		 
dw_cc.bringtotop = true		 
/*Asignar valores a las cuentas*/
SELECT PL_CODIGO
INTO    :ls_ctagto
FROM   PR_GRUPCONT
WHERE  GT_CODIGO = 'V_POS_NETO';

SELECT PL_CODIGO
INTO    :ls_ctaiva
FROM   PR_GRUPCONT
WHERE GT_CODIGO = 'V_POS_IVA';


ls_obs = 'Ventas POS'+'/'+string(id_fecha,'dd-mm-yy')


//recupera detalle de las formas de pago
ll_reg = dw_sd.rowcount( )
if ll_reg = 0 then return -1

//Asiento parte I
//Por cada sucursal se registra la forma de pago en el asiento
for i = 1 to ll_reg

	ls_signo         = dw_sd.Object.signo[i]
	ls_cta            = dw_sd.Object.cuenta[i]
	lc_valor         = dw_sd.object.valor[i]
	ls_cc             = string(dw_sd.object.centro[i])

	ll_new = dw_cc.insertrow(0)
	dw_cc.Object.em_codigo[ll_new] = str_appgeninfo.empresa
	dw_cc.Object.su_codigo[ll_new] = str_appgeninfo.sucursal	
	dw_cc.Object.ti_codigo[ll_new] = ls_tipo
	dw_cc.Object.cp_numero[ll_new] = 9999999
	dw_cc.Object.pl_codigo[ll_new] = ls_cta
	dw_cc.Object.cs_codigo[ll_new] = ls_cc
	dw_cc.Object.dt_secue[ll_new] =  string(i)
	dw_cc.Object.dt_signo[ll_new] = ls_signo
	dw_cc.Object.dt_valor[ll_new] = lc_valor
	dw_cc.Object.dt_detalle[ll_new] = ls_obs+'/'+ls_cc
	dw_cc.Object.fecha[ll_new] = id_fecha

next

//Asiento Parte II
//Incluir las cuentas de NETO e IVA por cada sucursal
ll_reg = dw_1.rowcount()
dw_1.Setfilter("descri = '"+'POS'+"'")
dw_1.filter()
for i = 1 to dw_1.rowcount()
	lc_neto          = dw_1.object.neto[i]
	lc_iva            = dw_1.object.iva[i]
    ls_cc              = string(dw_1.object.centro[i])
	 
    for j = 1 to 2
		if j = 1 then 
			lc_valor = lc_neto
			ls_cta    = ls_ctagto
		end if
		if j = 2 then 
			lc_valor = lc_iva
			ls_cta    = ls_ctaiva
		end if
		
		ll_new = dw_cc.insertrow(0)
		dw_cc.Object.em_codigo[ll_new]   = str_appgeninfo.empresa
		dw_cc.Object.su_codigo[ll_new]    = str_appgeninfo.sucursal	
		dw_cc.Object.ti_codigo[ll_new]      = ls_tipo
		dw_cc.Object.cp_numero[ll_new]  = 9999999
		dw_cc.Object.pl_codigo[ll_new]     = ls_cta
		dw_cc.Object.cs_codigo[ll_new]     = ls_cc
		dw_cc.Object.dt_secue[ll_new]       = string(i)
		dw_cc.Object.dt_signo[ll_new]        = 'C'
		dw_cc.Object.dt_valor[ll_new]        = lc_valor
		dw_cc.Object.dt_detalle[ll_new]      = ls_obs+'/'+ls_cc
		dw_cc.Object.fecha[ll_new]            = id_fecha
    next
next

//Asiento Parte III
//Para cuadrar con los d$$HEX1$$e900$$ENDHEX$$bitos
dw_1.Setfilter("descri = '"+'DIF'+"'")
dw_1.filter()

for i = 1 to dw_1.rowcount()
	     lc_dif          = dw_1.object.neto[i]
         ls_cc           = string(dw_1.object.centro[i])
			
		if lc_dif = 0 then continue
		if lc_dif  > 0  then
		ls_signo = 'D'
		else
		ls_signo = 'C'
		end if
		
		ll_new = dw_cc.insertrow(0)
		dw_cc.Object.em_codigo[ll_new]   = str_appgeninfo.empresa
		dw_cc.Object.su_codigo[ll_new]    = str_appgeninfo.sucursal	
		dw_cc.Object.ti_codigo[ll_new]      = ls_tipo
		dw_cc.Object.cp_numero[ll_new]   = 9999999
		dw_cc.Object.pl_codigo[ll_new]      = '1010101000'
		dw_cc.Object.cs_codigo[ll_new]     = ls_cc
		dw_cc.Object.dt_secue[ll_new]       = string(i)
		dw_cc.Object.dt_signo[ll_new]        = ls_signo
		dw_cc.Object.dt_valor[ll_new]        = Abs(lc_dif)
		dw_cc.Object.dt_detalle[ll_new]      = ls_obs+'/'+ls_cc
		dw_cc.Object.fecha[ll_new]            = id_fecha
next

dw_cc.SetSort("cs_codigo  desc, dt_signo  desc , dt_secue asc")		 
dw_cc.Sort()
dw_1.SetFilter("")
dw_1.Filter()

Setpointer(Arrow!)     
w_marco.SetMicrohelp("Listo...")
RETURN 1


end event

public function integer wf_verifica_parametros ();long ll_filact
ll_filact = dw_sel_rep.GetRow()

//is_caja = dw_sel_rep.GetItemString(ll_filact, 'caja')
is_cajero= dw_sel_rep.GetItemString(ll_filact, 'cajero')
id_fecha= dw_sel_rep.GetItemDate(ll_filact, 'fecha')


if isnull(is_cajero) then
		messageBox('Por Favor','Seleccione un cajero para obtener el reporte')
		return -1
end if	
if isnull(id_fecha) then
		messageBox('Por Favor','Ingrese la fecha de cierre para obtener el reporte')
		return -1
	end if		
return 1
end function

event activate;w_frame_basic lw_frame
m_frame_basic lm_frame

lw_frame = this.parentWindow()
lm_frame = lw_frame.menuid
lm_frame.mf_into_report_mode()
end event

event open;string ls_parametro[]
datetime ldt_hoy

this.ib_notautoretrieve = true

Select trunc(sysdate) into: ldt_hoy from dual;

ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[2] = str_appgeninfo.sucursal
//f_recupera_datos(dw_sel_rep,'caja',ls_parametro,2)
f_recupera_datos(dw_sel_rep,'cajero',ls_parametro,2)
f_recupera_datos(dw_sel_rep,'numero',ls_parametro,2)
//f_recupera_empresa(dw_sel_rep,'banco')

dw_sel_rep.InsertRow(0)

dw_sel_rep.setitem(1,"fecha",ldt_hoy)


dw_sd.SetTransObject(sqlca)  //fuente de datos para contabilizar
dw_1.SetTransObject(sqlca)    //ventas netas
call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event ue_print;dw_datos.print()	


end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

event ue_printcancel;beep(1)
end event

event ue_saveas;dw_datos.saveas()
end event

on w_rep_cierre_x_cajero.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
this.dw_cc=create dw_cc
this.dw_sd=create dw_sd
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
this.Control[iCurrent+2]=this.dw_cc
this.Control[iCurrent+3]=this.dw_sd
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_rep_cierre_x_cajero.destroy
call super::destroy
destroy(this.dw_sel_rep)
destroy(this.dw_cc)
destroy(this.dw_sd)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event ue_retrieve;return 1
end event

type dw_datos from w_sheet_1_dw`dw_datos within w_rep_cierre_x_cajero
integer y = 348
integer width = 3698
integer height = 1880
string dataobject = "d_cierre_caja"
boolean border = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_datos::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_report from w_sheet_1_dw`dw_report within w_rep_cierre_x_cajero
integer x = 5
integer y = 364
integer width = 741
integer height = 260
boolean enabled = true
borderstyle borderstyle = styleraised!
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_sel_rep from datawindow within w_rep_cierre_x_cajero
integer width = 2944
integer height = 340
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_cierre_caja_dia"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//long ll_filact
//string ls_caja, ls_cajero, ls_null, ls_ifcodigo, ls_fecha
//string ls_fecha
//datetime ld_fecie
//decimal lc_total
//datawindowchild ldwc_caja

//ll_filact = this.GetRow()
//If dwo.name = 'numero' Then
//		is_numero = data
//		  SELECT "FA_CIERRE"."CJ_CAJA",   
//         		"FA_CIERRE"."EP_CODIGO",   
//		         "FA_CIERRE"."CI_FECHA",   
//		         "FA_CIERRE"."CI_TOTREC",  
//				"FA_CIERRE"."CN_CODIGO"
//		    INTO :ls_caja,:ls_cajero,:ld_fecie,:lc_total,:ls_ifcodigo
//		    FROM "FA_CIERRE"  
//		   WHERE ( "FA_CIERRE"."EM_CODIGO" = :str_appgeninfo.empresa )
//			AND  ( "FA_CIERRE"."SU_CODIGO" = :str_appgeninfo.sucursal )
//      		 AND  ( "FA_CIERRE"."CI_CODIGO" = :is_numero ) ;
//		if sqlca.sqlcode <> 0 then
//			setnull(ls_null)
//			messageBox('Error','N$$HEX1$$fa00$$ENDHEX$$mero de documento de cierre no existe')
//			this.SetItem(ll_filact, 'numero', ls_null)
//			this.SetItem(ll_filact, 'caja', ls_null)
//			this.SetItem(ll_filact, 'cajero', ls_null)
//			this.SetItem(ll_filact, 'fecha', ls_null)
//			this.SetItem(ll_filact, 'recibido', ls_null)
//			this.SetItem(ll_filact, 'banco', ls_null)
//			this.AcceptText()
//			return
//		else
//			this.SetItem(ll_filact, 'caja', ls_caja)
//			this.SetItem(ll_filact, 'cajero', ls_cajero)
//			this.SetItem(ll_filact, 'fecha', date(ld_fecie))
//			this.SetItem(ll_filact, 'recibido', lc_total)
//			this.SetItem(ll_filact, 'banco', ls_ifcodigo)
//			this.AcceptText()			
//		end if
//End if
//If dwo.name = "fecha" Then	
//ls_fecha = string(this.getitemdate(row,"fecha"),'dd/mm/yyyy')
//this.getchild("cajero",ldwc_caja)
//ldwc_caja.settransobject(sqlca)
//ldwc_caja.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_fecha)
//end if	
end event

event buttonclicked;string  ls_cuenta,ls_titulo,ls_cierre,ls_fecha,ls_if_cuenta
char    lch_tipo
decimal lc_cheq_pag,lc_deposito,lc_efectivo,lc_totalventa
dec{2}  lc_totrec,lc_cambio,lc_chdif,lc_falta,lc_diferencia,lc_ret_pag
long    ll_nreg
date 	  ld_fecini,ld_fecfin

//char lc_estado
boolean lb_fp  = false

datawindowchild ldwc_cajero
id_fecha = this.GetItemdate(row,'fecha')

If dwo.name = 'b_1' Then

	SetPointer(HourGlass!)
	ls_titulo = parent.title
	parent.Title = 'Espere un momento por favor, Procesando...'
	dw_datos.DataObject = 'd_cierre_caja'
	dw_datos.SetTransObject(SQLCA)
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"'" )	
	dw_datos.getchild("fa_venta_ep_codigo",ldwc_cajero)
	ldwc_cajero.settransobject(sqlca)
	ldwc_cajero.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
	f_recupera_empresa(dw_datos,"fp_codigo")	
	dw_sel_rep.AcceptText()
	If wf_verifica_parametros() = -1 Then
			return
	End if

	ld_fecini = date(f_hoy())
	ld_fecfin = relativedate(id_fecha,1)
	if id_fecha = ld_fecini	then 
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No puede ver el cierre de hoy d$$HEX1$$ed00$$ENDHEX$$a...")
		return
	end if

	select nvl(sum(ve_cambio),0)
	into :lc_cambio
	from fa_venta
	where em_codigo = :str_appgeninfo.empresa and
	su_codigo = :str_appgeninfo.sucursal and
	bo_codigo = :str_appgeninfo.seccion and
	es_codigo = 2 and
	trunc(ve_fecha) = :id_fecha 
	ep_codigo = to_number(:is_cajero);
	
	if isnull(lc_cambio) then lc_cambio = 0
	
	

	dw_datos.setredraw(false)	
	ll_nreg = dw_datos.Retrieve(integer(str_appgeninfo.sucursal),integer(str_appgeninfo.seccion),is_cajero,id_fecha,id_fecha,lc_cambio)
	If ll_nreg < 1 Then 
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estos parametros...<Verifique>")
		return
	End if
	
	/*Cheques pagados*/
	SELECT nvl(sum(MC_VALOR),0)
	INTO: lc_cheq_pag
	FROM FA_MOVCAJA
	WHERE EM_CODIGO = :str_appgeninfo.empresa
	AND SU_CODIGO = :str_appgeninfo.sucursal
//	AND CJ_CAJA = :is_caja
	AND TJ_CODIGO = '3'
	AND EP_CODIGO = :is_cajero
	AND TRUNC(MC_FECHA) =:id_fecha;
	if isnull(lc_cheq_pag) then lc_cheq_pag = 0
	
	
	/*Retenciones pagadas*/
	SELECT nvl(sum(MC_VALOR),0)
	INTO: lc_ret_pag
	FROM FA_MOVCAJA
	WHERE EM_CODIGO = :str_appgeninfo.empresa
	AND SU_CODIGO = :str_appgeninfo.sucursal
//	AND CJ_CAJA = :is_caja
	AND TJ_CODIGO in ( '6','7' )
	AND EP_CODIGO = :is_cajero
	AND TRUNC(MC_FECHA) =:id_fecha;
	if isnull(lc_ret_pag) then lc_ret_pag = 0
	
		
	/****************/
	select ci_codigo,ci_totrec,cn_codigo,ci_falta
	into :ls_cierre,:lc_totrec,:ls_cuenta,:lc_falta
	from fa_cierre
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
//	and cj_caja = :is_caja
	and ep_codigo = :is_cajero
	and trunc(ci_fecha) = :id_fecha;

	
	
	SELECT "PR_INSTFIN"."IF_NOMBRE" || ' '|| "CB_CTAINS"."CN_NUMERO"
	INTO : ls_if_cuenta
	FROM "CB_CTAINS",   
			"PR_INSTFIN"  
	WHERE ( "CB_CTAINS"."IF_CODIGO" = "PR_INSTFIN"."IF_CODIGO" )   
	AND		(  "CB_CTAINS"."EM_CODIGO" = :str_appgeninfo.empresa 
	//AND  "CB_CTAINS"."SU_CODIGO" = :str_appgeninfo.sucursal 
	AND  "CB_CTAINS"."CN_CODIGO" = :ls_cuenta );
	
	
     lc_totalventa = dw_datos.Getitemdecimal(dw_datos.getrow(),"cc_tot_ventas")
	lc_diferencia = lc_totrec - lc_totalventa
	if abs(lc_diferencia) <> lc_falta and lc_falta > 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas con la diferencia de este cierre ...comunique a sistemas")
	end if
	lc_efectivo = dw_datos.Getitemdecimal(dw_datos.getrow(),"cc_efectivo") - (lc_cheq_pag+lc_ret_pag ) + lc_diferencia
	lc_deposito = lc_efectivo + dw_datos.Getitemdecimal(dw_datos.getrow(),"cc_cheque") + lc_cheq_pag + lc_ret_pag
	dw_datos.modify("st_secuencial.text ='"+ls_cierre+"' st_diferencia.text = '"+string(lc_diferencia,'$#,##0.00')+"'" +&
						  "st_cheq_pag.text = '"+string(lc_cheq_pag,'$#,##0.00')+"'"+& 
						  "st_ret_pag.text = '"+string(lc_ret_pag,'$#,##0.00')+"'"+& 
						  "st_efectivo.text = '"+string(lc_efectivo,'$#,##0.00')+"'"+&
						  "st_cuenta.text = '"+ls_if_cuenta+"' st_deposito.text = '"+string(lc_deposito,'$#,##0.00')+"'"+&
						  "st_recibido.text ='"+string(lc_totrec,'$#,##0.00')+"'"+& 
						  "DataWindow.Print.Preview='Yes'")
	dw_datos.setredraw(true)	 
	
	//Para pintamax
    //Actualiza diferencias en cierre
	 UPDATE FA_CIERRE
     SET CI_SOBRA =  DECODE(SIGN(CI_TOTREC - :lc_totalventa), 1,CI_TOTREC - :lc_totalventa,0), 
            CI_FALTA =  DECODE(SIGN(CI_TOTREC - :lc_totalventa),-1,ABS(CI_TOTREC - :lc_totalventa),0) 
     where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
//	and cj_caja = :is_caja
	and ep_codigo = :is_cajero
	and trunc(ci_fecha) = :id_fecha;

    COMMIT;


End if

If dwo.name = 'b_2' Then
	this.Accepttext()
	ls_fecha = string(this.getitemdate(row,"fecha"),'dd/mm/yyyy')
	openwithparm(w_res_cierre_caja_diario,ls_fecha)
End if

If dwo.name = 'b_3' Then
	Select sa_tipo
	into :lch_tipo
	from sg_acceso
	where em_codigo = :str_appgeninfo.empresa
	and sa_login = :str_appgeninfo.username;
	If lch_tipo = 'A' or lch_tipo = 'C' Then
		this.accepttext()
		//id_fecha = This.GetItemdate(row,'fecha')
		dw_datos.DataObject = 'd_resumen_pos_diario_caja_new'
		dw_datos.SetTransObject(SQLCA)	
		dw_datos.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"'" )	
		dw_datos.Retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),integer(str_appgeninfo.seccion),id_fecha)
		dw_datos.modify("datawindow.print.preview=yes")
	else
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No es usuario autorizado")
		return
	end if
end if
w_marco.setmicrohelp("Proceso Terminado")
parent.Title = ls_titulo
setpointer(arrow!)
end event

type dw_cc from uo_dw_comprobante within w_rep_cierre_x_cajero
boolean visible = false
integer y = 508
integer height = 1676
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Comprobante contable"
boolean controlmenu = true
end type

type dw_sd from datawindow within w_rep_cierre_x_cajero
boolean visible = false
integer x = 1888
integer y = 356
integer width = 3109
integer height = 1128
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Resumen Cierre"
string dataobject = "d_asiento_cierre_pos"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event losefocus;ib_permitir_contabilizacion = false
end event

type cb_1 from commandbutton within w_rep_cierre_x_cajero
integer x = 2857
integer y = 40
integer width = 855
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ver detalle por sucursal"
end type

event clicked;string  ls_ctafaltante,ls_ctasobrante,ls_ctachdif
decimal lc_cambio
id_fecha = dw_sel_rep.GetItemdate(dw_sel_rep.getrow(),'fecha')

ib_permitir_contabilizacion = true
dw_sd.visible = true

//Sobrantes
SELECT PL_CODIGO
INTO    :ls_ctasobrante
FROM    PR_GRUPCONT
WHERE  GT_CODIGO = 'V_POS_SOB';

//Faltantes
SELECT PL_CODIGO
INTO    :ls_ctafaltante
FROM    PR_GRUPCONT
WHERE  GT_CODIGO = 'V_POS_FAL';

//Cheques diferidos
SELECT PL_CODIGO
INTO    :ls_ctachdif
FROM    PR_GRUPCONT
WHERE  GT_CODIGO = 'CAN_CHDIF';

//Recupera detalle por forma de pago por sucursal
dw_sd.retrieve(str_appgeninfo.empresa,id_fecha,ls_ctasobrante,ls_ctafaltante,ls_ctachdif)

//Recupera totales de netos y faltantes por sucursal
dw_1.retrieve(str_appgeninfo.empresa,id_fecha)

end event

type dw_1 from datawindow within w_rep_cierre_x_cajero
boolean visible = false
integer x = 1893
integer y = 1512
integer width = 3109
integer height = 324
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_rep_ventas_netas_pos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


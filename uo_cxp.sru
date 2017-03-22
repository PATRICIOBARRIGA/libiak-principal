HA$PBExportHeader$uo_cxp.sru
forward
global type uo_cxp from userobject
end type
type cb_3 from commandbutton within uo_cxp
end type
type dw_c from datawindow within uo_cxp
end type
type dw_a from datawindow within uo_cxp
end type
type cb_2 from commandbutton within uo_cxp
end type
type cb_1 from commandbutton within uo_cxp
end type
type dw_3 from datawindow within uo_cxp
end type
type dw_2 from datawindow within uo_cxp
end type
type dw_datos from datawindow within uo_cxp
end type
end forward

global type uo_cxp from userobject
boolean visible = false
integer width = 6048
integer height = 2096
long backcolor = 15780518
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_3 cb_3
dw_c dw_c
dw_a dw_a
cb_2 cb_2
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
dw_datos dw_datos
end type
global uo_cxp uo_cxp

type variables
datetime id_hoy
dec{2} ic_iva
datawindowchild dwc_cuentas,dwc_tipo,idwc_reten,idwc_retiva
end variables

forward prototypes
public function integer wf_aplica_cambios (datawindow adw_1, datawindow adw_2, datawindow adw_3)
public function integer wf_cruza_pago (ref datawindow adw_fp, integer ai_status)
public function integer wf_crea_pago (ref datawindow adw_fp)
public subroutine wf_calculo_retencion (ref datawindow adw_aux)
public function integer wf_actualiza_saldo ()
end prototypes

public function integer wf_aplica_cambios (datawindow adw_1, datawindow adw_2, datawindow adw_3);Long rc

		 rc = adw_1.update(true,false)
		 if rc = 1 then
				 rc =   adw_2.update(true,false)
				 if rc = 1 then
						rc = adw_3.update(true,false)
						if rc = 1 then
							rc = wf_actualiza_saldo()	
							if rc = 1 then
								adw_1.resetupdate()
								adw_2.resetupdate()
								adw_3.resetupdate()
								commit;	
								else
								Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n... Actualizaci$$HEX1$$f300$$ENDHEX$$n de Saldos",sqlca.sqlerrtext)
								rollback;
								return -1
							end if	
						else
						Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n3",sqlca.sqlerrtext)	
						rollback;
						return -1
					    end if
				else
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n2",sqlca.sqlerrtext)	
				rollback;
				return -1
				end if	
		else
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n1",sqlca.sqlerrtext)
		rollback;
		return -1
		end if	

return 1
end function

public function integer wf_cruza_pago (ref datawindow adw_fp, integer ai_status);String ls_nrocre,ls_nromov
Long ll_row,ll_fila,ll_new
Integer i


ll_row = dw_datos.getrow()
/*Solo cruzar cuando hay un cr$$HEX1$$e900$$ENDHEX$$dito para cruzar*/
If ll_row <= 0 then return -1

/*Tomar datos del cr$$HEX1$$e900$$ENDHEX$$dito*/
ls_nrocre    = dw_datos.Object.mp_codigo[ll_row]
//is_pvcodigo = dw_datos.Object.pv_codigo[ll_row]

/*1.- Determinar si el pago es nuevo, modificado o est$$HEX2$$e1002000$$ENDHEX$$en el buffer de borrado*/
// Por el momento en esta ventana solo se puede crear pagos

choose case ai_status
	case 0 /*pago nuevo*/
     wf_crea_pago(adw_fp)
    case 1 /*Ya hay realizado al menos un pago*/
//	wf_modifica_pago(adw_fp)	
    case 2
//	wf_elimina_pago(adw_fp)	
end choose
    
return 1
     
		
		
	 
end function

public function integer wf_crea_pago (ref datawindow adw_fp);//Registrar pago


 String ls_nromov
Integer i
long ll_new, ll_row


/*Determinar secuencial del mov de d$$HEX1$$e900$$ENDHEX$$bito*/
ll_row = dw_datos.getrow()
ls_nromov = string(f_secuencial(str_appgeninfo.empresa,'DEB_CXP'))	
ll_new =  dw_a.insertrow(0)


/*Asignar datos de la clave para la cabecera del pago*/
dw_a.Object.cp_movim_mp_codigo[ll_new]  = ls_nromov
dw_a.Object.cp_movim_em_codigo[ll_new]  = str_appgeninfo.empresa
dw_a.Object.cp_movim_su_codigo[ll_new]   = str_appgeninfo.sucursal
dw_a.Object.cp_movim_tv_codigo[ll_new]    = '2'
dw_a.Object.cp_movim_tv_tipo[ll_new]        = 'D'
dw_a.Object.cp_movim_pv_codigo[ll_new]   = dw_datos.object.pv_codigo[ll_row]
dw_a.Object.mp_fecreg[ll_new]   = id_hoy
dw_a.Object.cp_movim_mp_fecha[ll_new]   = dw_datos.object.mp_fecemision[ll_row] 
dw_a.Object.cp_movim_mp_valor[ll_new]    =  adw_fp.Object.cc_totalpago[1] 
dw_a.Object.cp_movim_mp_valret[ll_new]   = (adw_fp.Object.cc_totalpago[1]/(1+ ic_iva))*ic_iva
dw_a.Object.cp_movim_mp_saldo[ll_new]   = adw_fp.Object.cc_totalpago[1] 


/*Completar datos de la clave para el detalle del pago*/
for i = 1 to adw_fp.rowcount()
adw_fp.Object.cp_pago_mp_codigo[i] = ls_nromov
adw_fp.Object.cp_pago_em_codigo[i] = str_appgeninfo.empresa
adw_fp.Object.cp_pago_su_codigo[i]  = str_appgeninfo.sucursal
adw_fp.Object.cp_pago_tv_codigo[i]   = '2'
adw_fp.Object.cp_pago_tv_tipo[i]        = 'D'
adw_fp.Object.cp_pago_pm_secuencia[i] = i
adw_fp.Object.cp_pago_pm_fecha[i] = dw_datos.object.mp_fecemision[ll_row] 
adw_fp.Object.cp_pago_pm_fecpa[i] = dw_datos.object.mp_fecemision[ll_row] 
next


/*Cruce del debito con el cr$$HEX1$$e900$$ENDHEX$$dito*/
ll_new =  dw_c.insertrow(0)

/*datos del cr$$HEX1$$e900$$ENDHEX$$dito*/ 
dw_c.Object.cp_cruce_mp_codigo[ll_new]   = dw_datos.Object.mp_codigo[ll_row]
dw_c.Object.cp_cruce_tv_codigo[ll_new]     = dw_datos.Object.tv_codigo[ll_row]
dw_c.Object.cp_cruce_tv_tipo[ll_new]         = dw_datos.Object.tv_tipo[ll_row]
dw_c.Object.cp_cruce_em_codigo[ll_new]   = dw_datos.Object.em_codigo[ll_row]
dw_c.Object.cp_cruce_su_codigo[ll_new]    = dw_datos.Object.su_codigo[ll_row]

/*datos del debito*/
dw_c.Object.cp_cruce_mp_coddeb[ll_new] = adw_fp.Object.cp_pago_mp_codigo[1]
dw_c.Object.cp_cruce_tv_coddeb[ll_new]    = adw_fp.Object.cp_pago_tv_codigo[1]
dw_c.Object.cp_cruce_tv_tipodeb[ll_new]    = adw_fp.Object.cp_pago_tv_tipo[1]
dw_c.Object.cp_cruce_cx_valcre[ll_new]      = adw_fp.Object.cc_totalpago[1] 
dw_c.Object.cp_cruce_cx_valdeb[ll_new]    = adw_fp.Object.cc_totalpago[1] 
dw_c.Object.cp_cruce_cx_fecha[ll_new]       = dw_datos.object.mp_fecemision[ll_row]
    
return 1
end function

public subroutine wf_calculo_retencion (ref datawindow adw_aux);long ll_row

adw_aux.AcceptText()
ll_row = adw_aux.getrow()
if ll_row = 0 then return
adw_aux.object.cp_pago_pm_bseimp[ll_row] = adw_aux.object.cp_pago_pm_base0[ll_row] + adw_aux.object.cp_pago_pm_basegrav[ll_row] + adw_aux.object.cp_pago_pm_basenograv[ll_row]
adw_aux.object.cp_pago_pm_valor[ll_row]    = adw_aux.Object.cp_pago_pm_porctje[ll_row]*adw_aux.object.cp_pago_pm_bseimp[ll_row] 

end subroutine

public function integer wf_actualiza_saldo ();/*Actualiza el saldo de la factura dependiendo de lo cruzado */
long ll_filact
decimal lc_totalcruce,lc_retiva,lc_retfte,lc_base0,lc_basegrav,lc_basenograv,lc_valor,lc_iva,lc_reten,lc_saldo,lc_otrospagos
string  ls_tvcodigo,ls_tvtipo,ls_nromov

dw_datos.AcceptText()
dw_c.AcceptText()

ll_filact = dw_datos.getrow()

If ll_filact <= 0 then return -1


ls_tvcodigo = dw_datos.object.tv_codigo[ll_filact]
ls_tvtipo     = dw_datos.object.tv_tipo[ll_filact]
ls_nromov  = dw_datos.object.mp_codigo[ll_filact]



lc_base0         = dw_2.object.cc_base0[1]
lc_basegrav     = dw_2.object.cc_basegrav[1]
lc_basenograv = dw_2.object.cc_basenograv[1]

lc_iva =  lc_basegrav*ic_iva

dw_datos.object.mp_bseimptrf0[ll_filact]  = lc_base0
dw_datos.object.mp_baseimp[ll_filact]     = lc_basegrav
dw_datos.object.mp_bseimpice[ll_filact]   = lc_basenograv
dw_datos.object.mp_valret[ll_filact]         = lc_basegrav*ic_iva
lc_valor   = lc_base0 + lc_basegrav + lc_basenograv + (lc_basegrav*ic_iva)
dw_datos.object.mp_valor[ll_filact]    = lc_valor     





/*Tomar el total del cruce y actualizar el saldo*/
If dw_c.rowcount() > 0 then
lc_totalcruce =  dw_c.object.cc_totalcruce[1]
else
lc_totalcruce = dw_datos.Object.mp_valor[ll_filact] 
end if



/*Actualiza retenciones en el cr$$HEX1$$e900$$ENDHEX$$dito*/
if dw_2.rowcount() > 0 then
lc_retfte =  dw_2.Object.cc_totalpago[1]
else
lc_retfte = 0
end if
dw_datos.Object.retfte[ll_filact] = lc_retfte


if dw_3.rowcount() > 0 then
lc_retiva = dw_3.Object.cc_totalpago[1]
else
lc_retiva = 0
end if
dw_datos.Object.retiva[ll_filact] = lc_retiva

/*Solo para pintar en el datawindow del credito*/
lc_reten = lc_retfte + lc_retiva
lc_saldo = lc_valor - lc_totalcruce
dw_datos.object.mp_saldo[ll_filact]    = lc_saldo
dw_datos.object.mp_fecreg[ll_filact] = id_hoy


//Refresca detalle de pagos
//cb_5.triggerevent(clicked!)

//if dw_op.rowcount() > 0 then
//lc_otrospagos = dw_op.object.cc_otrospagos[1]
//end if

dw_datos.object.st_op.text = string(lc_otrospagos,'#,##0.00')
dw_datos.SetItemStatus(ll_filact, 0, Primary!, NotModified!)


UPDATE CP_MOVIM
SET  MP_BSEIMPTRF0 = :lc_base0,
	   MP_BASEIMP       = :lc_basegrav,
	   MP_BSEIMPICE    = :lc_basenograv,
       MP_RETIVA         = :lc_retiva,
       MP_RETEN          = :lc_retfte,
	   MP_VALOR         = :lc_valor ,
       MP_VALRET        = :lc_iva,
       MP_SALDO          =  :lc_saldo,
	  MP_FECREG         = :id_hoy	 
WHERE TV_CODIGO = :ls_tvcodigo
AND TV_TIPO = :ls_tvtipo
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND MP_CODIGO = :ls_nromov;

IF SQLCA.SQLCODE <> 0 THEN
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el cr$$HEX1$$e900$$ENDHEX$$dito..."+sqlca.sqlerrtext)
		Rollback;
		Return -1
End if




return 1

end function

on uo_cxp.create
this.cb_3=create cb_3
this.dw_c=create dw_c
this.dw_a=create dw_a
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_datos=create dw_datos
this.Control[]={this.cb_3,&
this.dw_c,&
this.dw_a,&
this.cb_2,&
this.cb_1,&
this.dw_3,&
this.dw_2,&
this.dw_datos}
end on

on uo_cxp.destroy
destroy(this.cb_3)
destroy(this.dw_c)
destroy(this.dw_a)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_datos)
end on

event constructor;//Factura
dw_datos.settransobject(sqlca)

// Cabecera total del pago
dw_a.SetTransObject(sqlca)

//Pagos
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

//Detalle del pago
dw_c.SetTransObject(sqlca)

f_recupera_empresa(dw_datos,"pv_codigo")
f_recupera_empresa(dw_datos,"mp_tipodoc")
f_recupera_empresa(dw_datos,"tv_codigo")

f_recupera_empresa(dw_2,"cp_pago_pm_codpct")
f_recupera_empresa(dw_2,"cp_pago_pm_codpct_1")
f_recupera_empresa(dw_2,"pl_codigo")
f_recupera_empresa(dw_2,"pl_codigo_1")

f_recupera_empresa(dw_3,"cp_pago_pm_codpct")
f_recupera_empresa(dw_3,"cp_pago_pm_codpct_1")

dw_3.getchild("cp_pago_pm_codpct",idwc_retiva)
idwc_retiva.SetTransObject(sqlca)
idwc_retiva.retrieve(str_appgeninfo.empresa)
idwc_retiva.Setfilter("cc_reten_fp_codigo  = '7'")
idwc_retiva.Filter()
//
dw_2.getchild("cp_pago_pm_codpct",idwc_reten)
idwc_reten.SettransObject(sqlca)
idwc_reten.retrieve(str_appgeninfo.empresa)
idwc_reten.Setfilter("cc_reten_fp_codigo  = '6'")
idwc_reten.Filter()

ic_iva  = f_iva() 
id_hoy = f_hoy()
end event

type cb_3 from commandbutton within uo_cxp
integer x = 5161
integer y = 236
integer width = 599
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retornar"
end type

event clicked;parent.visible = false
end event

type dw_c from datawindow within uo_cxp
boolean visible = false
integer x = 539
integer y = 1452
integer width = 4960
integer height = 424
integer taborder = 30
boolean titlebar = true
string title = "none"
string dataobject = "d_3"
boolean resizable = true
boolean livescroll = true
end type

type dw_a from datawindow within uo_cxp
boolean visible = false
integer x = 951
integer y = 1136
integer width = 4974
integer height = 84
integer taborder = 20
string title = "none"
string dataobject = "d_1"
boolean livescroll = true
end type

type cb_2 from commandbutton within uo_cxp
integer x = 41
integer y = 1640
integer width = 731
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RETENCION SOBRE IVA"
end type

type cb_1 from commandbutton within uo_cxp
integer x = 37
integer y = 1144
integer width = 718
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CONCEPTO AIR"
end type

type dw_3 from datawindow within uo_cxp
integer x = 41
integer y = 1724
integer width = 5870
integer height = 328
integer taborder = 30
string title = "none"
string dataobject = "d_retiva"
boolean livescroll = true
end type

event buttonclicked;Long ll_row
Integer li_status
String ls_nrocre

if  dwo.name = 'b_3' then
	
ll_row = dw_datos.getrow()

/*Solo cruzar cuando haya un cr$$HEX1$$e900$$ENDHEX$$dito que cruzar*/
if ll_row <= 0 then return

          ls_nrocre = dw_datos.Object.mp_codigo[ll_row]
	   //is_pvcodigo = dw_datos.Object.pv_codigo[ll_row]
		
         /*Determinar el estado de todo el dw*/
		If this.rowcount() > 0 then
		li_status = this.Object.cc_status[1]
		end if
		
		if li_status > 0 then 
			li_status  = 1 /*Se ha realizado un pago con anterioridad*/
		else
			/*Ver si existen filas marcadas para borrado*/
			if this.deletedcount() > 0 then 
			li_status  = 2 
	 	    else
			li_status  = 0 /*Pago nuevo*/
		    end if
			  
		end if
      		
		
		/*Pago nuevo*/
		wf_cruza_pago(dw_3,li_status)	
				
		/*Modificaci$$HEX1$$f300$$ENDHEX$$n al pago*/
              If li_status = 2 then
			wf_aplica_cambios(dw_c,dw_3,dw_a)
	       else
			wf_aplica_cambios(dw_a,dw_3,dw_c)	
              end if
end if
end event

event buttonclicking;Long ll_row

Decimal lc_iva



If dwo.name = 'b_1' then
	
	ll_row = dw_datos.getrow()
	
	If ll_row = 0 then return 1  // previene la ejecucion
	lc_iva          = dw_datos.Object.mp_valret[ll_row] 


	//Permitir a$$HEX1$$f100$$ENDHEX$$adir solo si existen datos en el comprobante de venta
	if lc_iva = 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Movimiento no permitido ...Para ingresar la retenci$$HEX1$$f300$$ENDHEX$$n el valor del IVA debe ser mayor a Cero... ")
     	return 1
	end if
	
	
	
	if this.rowcount() >= 2 then
	w_marco.Setmicrohelp("No se puede realizar mas de dos(2) retenciones de IVA por factura...Por favor verifique!!!")
	return 1
    end if
	 
	 
end if
end event

event itemchanged;decimal lc_pctje
String    ls_codretfte,ls_codretiva

this.AcceptText()

if dwo.name ='cp_pago_pm_codpct' or dwo.name = 'cp_pago_pm_bseimp' then
	lc_pctje        = idwc_retiva.getitemdecimal(idwc_retiva.getrow(),"rf_procen")
	this.object.cp_pago_pm_porctje[row] = lc_pctje
	this.object.cp_pago_pm_bseimp[row] = dw_datos.Object.mp_valret[dw_datos.getrow()]
end if


this.object.cp_pago_pm_valor.primary = this.object.cc_retiva.primary
end event

type dw_2 from datawindow within uo_cxp
integer x = 41
integer y = 1220
integer width = 5879
integer height = 420
integer taborder = 20
string title = "none"
string dataobject = "d_retfte"
boolean livescroll = true
end type

event buttonclicked;Long ll_row
Integer li_status
String ls_nrocre

if  dwo.name = 'b_3' then
	
ll_row = dw_datos.getrow()

		/*Solo cruzar cuando haya un cr$$HEX1$$e900$$ENDHEX$$dito que cruzar*/
		if ll_row <= 0 then return

          ls_nrocre = dw_datos.Object.mp_codigo[ll_row]
	   //is_pvcodigo = dw_datos.Object.pv_codigo[ll_row]
		
         /*Determinar el estado de todo el dw*/
		If this.rowcount() > 0 then
		    li_status = this.Object.cc_status[1]
		end if
		
		if li_status > 0 then 
			li_status  = 1 /*Se ha realizado un pago con anterioridad*/
		else
			/*Ver si existen filas marcadas para borrado*/
			if this.deletedcount() > 0 then 
			li_status  = 2 
	 	    else
			li_status  = 0 /*Pago nuevo*/
		    end if
		end if
      		
		
		/*Pago nuevo*/
		wf_cruza_pago(dw_2,li_status)	
				
		/*Modificaci$$HEX1$$f300$$ENDHEX$$n al pago*/
              If li_status = 2 then
			wf_aplica_cambios(dw_c,dw_2,dw_a)
	       else
			wf_aplica_cambios(dw_a,dw_2,dw_c)	
              end if
end if
end event

event buttonclicking;Long ll_row
Decimal lc_baseretfte
ll_row = dw_datos.getrow()
 

If dwo.name = 'b_1' then
		
	if ll_row = 0 then return 1
//	is_pvcodigo  = dw_datos.Object.pv_codigo[ll_row]
	lc_baseretfte = dw_datos.Object.mp_bseimptrf0[ll_row] +&
						dw_datos.Object.mp_baseimp[ll_row] + &
						dw_datos.Object.mp_bseimpice[ll_row]
	
	
	//Permitir a$$HEX1$$f100$$ENDHEX$$adir solo si existen datos en el comprobante de venta

	if this.rowcount() >= 3 then
	w_marco.Setmicrohelp("No se puede realizar mas de dos(2) retenciones en la fuente por factura...Por favor verifique!!!")
	return 1
    end if
	
end if
end event

event itemchanged;Long ll_row
decimal lc_pctje,lc_baseretfte

this.AcceptText()

ll_row = dw_datos.getrow()

if ll_row = 0 then return

//Para facturas que vienen desde compras
this.object.cp_pago_pm_codpctiva[row] = ic_iva

if dwo.name ='cp_pago_pm_codpct' then
	lc_pctje = idwc_reten.getitemdecimal(idwc_reten.getrow(),"rf_procen")
	//this.object.cp_pago_pm_bseimp[row] = this.object.cp_pago_base0[row] + this.object.cp_pago_basegrav[row]  +this.object.cp_pago_basenograv[row] 
	this.object.cp_pago_pm_porctje[row] = lc_pctje
end if
wf_calculo_retencion(dw_2)
this.object.cp_pago_pm_valor.primary = this.object.cc_retfte.primary

end event

type dw_datos from datawindow within uo_cxp
integer x = 37
integer y = 56
integer width = 5879
integer height = 1092
integer taborder = 10
string title = "none"
string dataobject = "d_credito_cxp"
boolean livescroll = true
end type

event updatestart;String  ls_cofacpro,ls_deviva,ls_pvcodigo,ls_mpcodigo
long    ll_row,ll_count,ll_dias,ll_conumero
integer li_rango
Date ld_fecha
Decimal{2}lc_saldo,lc_totalcruce
Char lch_estado
dwitemstatus l_status


Setpointer(Hourglass!)

/* 1.- Validar datos */
ll_row    =    this.getrow()
l_status  =    this.getitemstatus(ll_row,0,Primary!)

If ll_row = 0 then return 1

/*Permitir hasta 20 d$$HEX1$$ed00$$ENDHEX$$as antes de la fecha actual*/
select pr_valor
into :li_rango
from pr_param
where em_codigo = :str_appgeninfo.empresa
and pr_nombre = 'NDIAS_EDIC';

ld_fecha = date(dw_datos.Object.mp_fecha[ll_row])
ll_dias = daysafter(ld_fecha,date(id_hoy))

If  (ll_dias >= li_rango)  then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha de emisi$$HEX1$$f300$$ENDHEX$$n est$$HEX2$$e1002000$$ENDHEX$$fuera de l$$HEX1$$ed00$$ENDHEX$$mite permitido ["+string(li_rango)+"] d$$HEX1$$ed00$$ENDHEX$$as...<Por favor verifique!>")
return 1
end if

/******/
this.Object.co_facpro[ll_row] = this.Object.mp_docnroest[ll_row] + this.Object.mp_docnropto[ll_row] + this.Object.mp_docnrosec[ll_row]
ls_cofacpro = dw_datos.GetItemString(ll_row,"co_facpro")

If isnull(ls_cofacpro) or ls_cofacpro = ' '  then 
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El campo Factura de Proveedor no puede estar en blanco")
return 1
End if 


/*******/







/*Validar que solo exista una factura por proveedor*/
If l_status = newmodified! or l_status = new! then
	
	ls_pvcodigo = this.object.pv_codigo[ll_row]
	SELECT COUNT(*)
	INTO :ll_count
	FROM CP_MOVIM
	WHERE TV_TIPO = 'C'
	AND PV_CODIGO = :ls_pvcodigo
	AND CO_FACPRO = :ls_cofacpro;
	
	If ll_count > 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existe una factura con este n$$HEX1$$fa00$$ENDHEX$$mero '"+ls_cofacpro+"' para este proveedor...<Por favor verifique > ")
		Rollback;
		return 1
	end if
	
       ls_mpcodigo = string(f_secuencial(str_appgeninfo.empresa,"CRE_CXP"))
       this.object.mp_codigo[ll_row] = ls_mpcodigo
/**/
/*Validar que se haya registrado primero la compra*/
SELECT CO_NUMERO
INTO  :ll_conumero
FROM IN_COMPRA 
WHERE EM_CODIGO = :str_appgeninfo.empresa 
AND SU_CODIGO = :str_appgeninfo.sucursal
AND CO_FACPRO = :ls_cofacpro
AND PV_CODIGO = :ls_pvcodigo
AND EC_CODIGO = '3';

If ll_conumero = 0 or isnull(ll_conumero) then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha registrado ninguna compra con este n$$HEX1$$fa00$$ENDHEX$$mero de factura....Por favor verifique...!!!")
Return
End if 

if isnull(ll_conumero) or ll_conumero = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La compra no ha sido registrada por favor verifique...!" )
	return
end if 




end if







lch_estado = dw_datos.getitemstring(ll_row,"cp_movim_estado")
if isnull(lch_estado) or trim(lch_estado) = '' then
dw_datos.setitem(ll_row,"cp_movim_estado",'S')
end if

ls_deviva = dw_datos.getitemstring(ll_row,"mp_docdeviva")
if isnull(ls_deviva) or trim(ls_deviva) = '' then
dw_datos.setitem(ll_row,"cp_movim_estado",'S')
end if


/*Determinar el secuencial del credito*/

this.Object.em_codigo[ll_row] = str_appgeninfo.empresa
this.Object.su_codigo[ll_row]  = str_appgeninfo.sucursal
this.Object.mp_fecreg[ll_row] = id_hoy
this.Object.mp_fecha[ll_row]   = this.Object.mp_fecemision[ll_row]

/*Actualiza el saldo del cr$$HEX1$$e900$$ENDHEX$$dito*/
this.Object.sa_login[ll_row]     = str_appgeninfo.username
RETURN 0








end event

event rowfocuschanged;String ls_nrocredito

if currentrow=0 then return
ls_nrocredito = dw_datos.Object.mp_codigo[currentrow]
dw_2.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_nrocredito)
dw_3.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_nrocredito)
end event


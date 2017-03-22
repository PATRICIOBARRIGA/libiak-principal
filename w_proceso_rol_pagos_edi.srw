HA$PBExportHeader$w_proceso_rol_pagos_edi.srw
$PBExportComments$Si.Proceso de Rol de Pagos.
forward
global type w_proceso_rol_pagos_edi from w_response_basic
end type
type dw_1 from datawindow within w_proceso_rol_pagos_edi
end type
type dw_2 from datawindow within w_proceso_rol_pagos_edi
end type
type dw_3 from datawindow within w_proceso_rol_pagos_edi
end type
type dw_4 from datawindow within w_proceso_rol_pagos_edi
end type
type cb_1 from commandbutton within w_proceso_rol_pagos_edi
end type
type dw_5 from datawindow within w_proceso_rol_pagos_edi
end type
type cb_2 from commandbutton within w_proceso_rol_pagos_edi
end type
end forward

global type w_proceso_rol_pagos_edi from w_response_basic
integer width = 2661
integer height = 1516
string title = "Procesar Rol de Pagos Edi"
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
cb_1 cb_1
dw_5 dw_5
cb_2 cb_2
end type
global w_proceso_rol_pagos_edi w_proceso_rol_pagos_edi

type variables

end variables

forward prototypes
protected function integer wf_rol_pagos (datetime ad_fecfin, ref datawindow ad_dw, datawindow ad_dw_ep, datawindow ad_dw_ru)
end prototypes

protected function integer wf_rol_pagos (datetime ad_fecfin, ref datawindow ad_dw, datawindow ad_dw_ep, datawindow ad_dw_ru);dec{2}  lc_impren,lc_acumulado,lc_acumrenta
integer li_mes,li_numveces,li_cuotas
string  ls_anio,ls_fecini,ls_fecfin,ls_fecing,ls_fecent
date    ld_fecini,ld_fecfin

li_mes = month(date(ad_fecfin))
ls_fecini = string(year(date(ad_fecfin)) - 1)
ls_anio = string(year(date(ad_fecfin)))

choose case li_mes
	case 1
		ls_fecini = '25/'+'12'+'/'+ls_fecini
		ls_fecfin = '24/'+'0'+string(li_mes)+'/'+ls_anio
	case 10
		ls_fecini = '25/'+'0'+string(li_mes - 1)+'/'+ls_anio
		ls_fecfin = '24/'+string(li_mes)+'/'+ls_anio
	case 11,12
		ls_fecini = '25/'+string(li_mes - 1)+'/'+ls_anio
		ls_fecfin = '24/'+string(li_mes)+'/'+ls_anio
	case else
		ls_fecini = '25/'+'0'+string(li_mes - 1)+'/'+ls_anio
		ls_fecfin = '24/'+'0'+string(li_mes)+'/'+ls_anio
end choose

ld_fecini = date(ls_fecini)
ld_fecfin = date(ls_fecfin)
ls_fecing = string(date(ad_fecfin),'mm/yyyy')


// para el encabezado de rol
string      ep_codigo,rr_codigo,ep_nombre,ep_centcos
datetime ld_fecha_calculo
integer tt_horas,li_dia,li_num_empleados,li_count_empleados=0
dec{2} lq_total,lq_valor,ld_total_ingresos=0,ld_total_egresos=0,&
           ep_sueldo,lq_numhor,ld_valor,ep_respon
// para los rubros calculados
dec{4} rc_porcen //rc_valnum,rc_valsup,rc_valinf,rc_smvs,rc_sn  

// para los pr$$HEX1$$e900$$ENDHEX$$stamos
long ll_num_prestamos,i,li_tt_rubros, li_rubros,ll_cod_max_rol
string pp_numero
dec{2} pp_valor, pp_saldo

// para calculo de cada rubro			
string ru_codigo,ru_tipcam,ru_ioe
// para verificar que el pago de rol no se haga el mismo mes
ad_dw.retrieve(date(ad_fecfin))
ad_dw_ep.retrieve(str_appgeninfo.empresa)
ad_dw_ru.retrieve(str_appgeninfo.empresa)

// tomo un empleado activo
li_num_empleados  =  ad_dw_ep.RowCount()
li_tt_rubros             =  ad_dw_ru.RowCount()

If li_num_empleados > 0 Then MessageBox('ATENCION','Procesando los roles...Espere por favor!')

FOR li_count_empleados = 1 to li_num_empleados	
	// para cada uno proceso el rol
	ep_codigo    =  ad_dw_ep.GetItemString(li_count_empleados,'ep_codigo')
	ep_sueldo    =  ad_dw_ep.GetItemDecimal(li_count_empleados,'ep_sueldo')
	ep_respon    =  ad_dw_ep.GetItemDecimal(li_count_empleados,'ep_comision')	
	ep_centcos    =  ad_dw_ep.GetItemString(li_count_empleados,'cs_codigo')		
	ls_fecent    =  string(date(ad_dw_ep.GetItemDateTime(li_count_empleados,'ep_fecent')),'mm/yyyy')
	If ls_fecent = ls_fecing Then
	     li_dia  =  day(date((ad_dw_ep.GetItemDateTime(li_count_empleados,'ep_fecent'))))
         tt_horas = (30 - li_dia + 1) * 8	
	Else
	    tt_horas=240
	End if

	w_marco.SetMicroHelp('Procesando empleado '+string(li_count_empleados)+' de '+string(li_num_empleados))			
	// tomo el n$$HEX1$$fa00$$ENDHEX$$mero secuencial para el pago del rol
	SELECT nvl(max(to_number("NO_CABROL"."RR_CODIGO")),0)
	INTO  :ll_cod_max_rol
	FROM  "NO_CABROL"  
	WHERE "NO_CABROL"."EP_CODIGO" = :ep_codigo   ;	
	If ll_cod_max_rol = 0 then
		  rr_codigo = '1'
     else
		  rr_codigo = string(ll_cod_max_rol + 1)
	End if
    INSERT INTO "NO_CABROL"  
					  ( "EP_CODIGO",   
					    "RR_CODIGO",   
					    "RR_FECHA",   
					    "RR_HORAS",   
					    "RR_TOTINGR",   
					    "RR_TOTEGRE",   
		             		"RR_LIQUIDO",
		             		"RR_TIPO",
		             		"RR_PAGADO",
						"CS_CODIGO")  
	  VALUES (    :ep_codigo,   
					  :rr_codigo,   
					  :ad_fecfin,   
					  :tt_horas,
					  :ld_total_ingresos,   
					  :ld_total_egresos,   
					  :ld_total_ingresos + :ld_total_egresos,
					  'R',
					  'N',
					  :ep_centcos)  ; // para rol de pagos

	 FOR  li_rubros=1 to li_tt_rubros

		  // para cada uno proceso el rol
		  ru_codigo  = ad_dw_ru.GetItemString(li_rubros,'ru_codigo')
		  ru_tipcam  = ad_dw_ru.GetItemString(li_rubros,'ru_tipcam')
		  ru_ioe     = ad_dw_ru.GetItemString(li_rubros,'ru_ioe')
		  lq_valor   = 0 
   	      lq_total   = 0
		  lq_numhor  = 0
		  CHOOSE CASE ru_tipcam
		  CASE 'M' // valor fijo mensual
		  CASE 'P' // Prestamo o Anticipo o Multa
		           //MULTAS 25 FALTANTES EN CAJA 26 COMISARIATO 27 EGRESOS OCASIONALES 28 
					  //PRESTAMOS EMPRESA 21 PRESTAMOS  SEGURO SOCIAL 22 ANTICIPO EXTRAS EMPLEADOS 20
					ad_dw.SetFilter("ep_codigo='"+ep_codigo+"' and ru_codigo='"+ru_codigo+"'" )
					ad_dw.Filter()
					ll_num_prestamos=ad_dw.RowCount()
					ld_valor=0
					lq_total=0
					FOR i=1 to ll_num_prestamos
						pp_numero=ad_dw.GetItemString(i,'pp_numero')
						pp_valor=ad_dw.GetItemDecimal(i,'pp_valor')
						pp_saldo=ad_dw.GetItemDecimal(i,'pp_saldo')
						SELECT sum("NO_DETPAG"."DP_VALCUO")  
						INTO   :ld_valor  
						FROM   "NO_DETPAG",   
								 "NO_PRESTAMO"  
						WHERE  ( "NO_PRESTAMO"."EP_CODIGO" = "NO_DETPAG"."EP_CODIGO" ) and  
								 ( "NO_PRESTAMO"."PP_NUMERO" = "NO_DETPAG"."PP_NUMERO" ) and  
								 (( "NO_PRESTAMO"."PP_NUMERO" = :pp_numero) and 
								  ( "NO_PRESTAMO"."EP_CODIGO" = :ep_codigo ) and
								  ( "NO_DETPAG"."DP_FECPAG"  <= last_day(:ad_fecfin) ) AND  
								  ( "NO_DETPAG"."DP_CUOCANC" = 'N' ))  ;
						If isnull(ld_valor) then 
							ld_valor=0
						else
							lq_total=(lq_total+ld_valor)	
							UPDATE "NO_DETPAG"  // Actualiza los pagos
							SET    "DP_CUOCANC" = 'S'  
							WHERE ("NO_DETPAG"."EP_CODIGO" = :ep_codigo ) AND  
									( "NO_DETPAG"."PP_NUMERO" = :pp_numero ) AND  
									( "NO_DETPAG"."DP_CUOCANC" = 'N' ) AND  
									( "NO_DETPAG"."DP_FECPAG" <= last_day(:ad_fecfin));
							IF SQLCA.SQLCODE < 0 THEN
								Rollback;								
								Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los prestamos" +sqlca.sqlerrtext)
								Return -1
							END IF	

							SELECT count(*)
							INTO :li_cuotas
							FROM "NO_DETPAG"  
							WHERE ( "NO_DETPAG"."EP_CODIGO" = :ep_codigo) AND  
							( "NO_DETPAG"."PP_NUMERO" = :pp_numero ) AND
							("NO_DETPAG"."DP_CUOCANC" = 'N'); 
							
							if li_cuotas > 0 then
								UPDATE "NO_PRESTAMO"  //Actualiza cabecera del pr$$HEX1$$e900$$ENDHEX$$stamo
								SET    "PP_SALDO" = "PP_SALDO" - :ld_valor,
										 "PP_ESTADO" = 'P'  // Pendiente de pago
								WHERE ("NO_PRESTAMO"."EP_CODIGO" = :ep_codigo ) AND  
										("NO_PRESTAMO"."PP_NUMERO" = :pp_numero );
								IF SQLCA.SQLCODE < 0 THEN
									Rollback;									
									Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el saldo del prestamo" +sqlca.sqlerrtext)
									Return -1
								END IF
							else
								
								UPDATE "NO_PRESTAMO"  //Actualiza cabecera del pr$$HEX1$$e900$$ENDHEX$$stamo
								SET    "PP_SALDO" = "PP_SALDO" - :ld_valor,
										 "PP_ESTADO" = 'T'  //pagado
								WHERE ("NO_PRESTAMO"."EP_CODIGO" = :ep_codigo ) AND  
										("NO_PRESTAMO"."PP_NUMERO" = :pp_numero );
								IF SQLCA.SQLCODE < 0 THEN
									Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el saldo del prestamo" +sqlca.sqlerrtext)
									Rollback;
									Return -1
								END IF	
							end if
						End if					
	            NEXT
	
        CASE 'C','A' // calculado o calculado con ajuste manual
                //El valor ingresado de porcentaje en el rubro debe estar en formato sin porcentaje    
			 select (rc_porcen/100)
			 into :rc_porcen
			 from no_rubcal
			 where ru_codigo = :ru_codigo;
			
 
         	CHOOSE CASE ru_codigo
				CASE '1' //Sueldo Nominal
				         lq_numhor=tt_horas
						lq_total=ep_sueldo*tt_horas/240
						lq_valor=lq_total/lq_numhor		

				CASE '6' , '7'//HORAS EXTRAORDINARIAS, HORAS SUPLEMENTARIAS
						if isnull(ep_respon) then ep_respon = 0 
						lq_valor= ((rc_porcen*100)*((( ep_sueldo + ep_respon ) * tt_horas) / 240 ))  / tt_horas
						lq_numhor=0
						lq_total=0

				CASE '18' //APORTE PERSONAL AL IESS	Calculo solo a base de sueldo luego al actualizar el rol se recalcula!!!

						select round(SUM(y.lq_total) * :rc_porcen,2)
						into   :lq_total
						from   no_cabrol  x,  no_rolpago y, no_rubro z
						where  x. ep_codigo = y.ep_codigo
						and    x.rr_codigo = y.rr_codigo
						and    z.ru_codigo = y.ru_codigo
						and    to_char(x.rr_fecha,'MM/YYYY') = :ls_fecing
						and    x.ep_codigo = :ep_codigo
						and    z.ru_sigla like 'I%' ;

				CASE '17' //ALIMENTACION Ingreso
						lq_total = 0
						
						select count(as_lunch)
						into :li_numveces
						from no_asistencia 
						where em_codigo = :str_appgeninfo.empresa 
						and ep_codigo = :ep_codigo
						and trunc(as_fecha) between :ld_fecini and :ld_fecfin
						and as_lunch = 'N';

						lq_total = li_numveces * rc_porcen
						
						select count(as_lunch)
						into :li_numveces
						from no_asistencia 
						where em_codigo = :str_appgeninfo.empresa 
						and ep_codigo = :ep_codigo
						and trunc(as_fecha) between :ld_fecini and :ld_fecfin
						and as_lunch = 'F';
						
						lq_total = lq_total + li_numveces * (rc_porcen * 2)
						
				CASE '19' //ANTICIPO PRIMERA QUINCENA

	  				    ld_fecha_calculo = datetime(relativedate(date(ad_fecfin), -day(date(ad_fecfin)) + 1))
							
						 SELECT sum("NO_CABROL"."RR_LIQUIDO")  
						 INTO :ld_valor  
						 FROM "NO_CABROL" ,"NO_ROLPAGO"
						 WHERE ( "NO_CABROL"."EP_CODIGO" = "NO_ROLPAGO"."EP_CODIGO" ) and
						 ( "NO_CABROL"."RR_CODIGO" = "NO_ROLPAGO"."RR_CODIGO" ) and  
						 ( "NO_CABROL"."RR_TIPO" = 'Q' ) AND  
					     ( "NO_CABROL"."EP_CODIGO" = :ep_codigo ) AND  
						 ( trunc("NO_CABROL"."RR_FECHA") between :ld_fecha_calculo and :ad_fecfin) AND
						 ("NO_ROLPAGO"."RU_CODIGO"='24');
						 If isnull(ld_valor) then ld_valor=0
						 lq_total=ld_valor
				CASE '23' //ALIMENTACION EMPLEADOS Egreso

						select count(as_lunch)
						into :li_numveces
						from no_asistencia 
						where em_codigo = :str_appgeninfo.empresa 
						and ep_codigo = :ep_codigo
						and trunc(as_fecha) between :ld_fecini and :ld_fecfin
						and as_lunch = 'S';

						lq_total = li_numveces * rc_porcen
						
						select count(as_lunch)
						into :li_numveces
						from no_asistencia 
						where em_codigo = :str_appgeninfo.empresa 
						and ep_codigo = :ep_codigo
						and trunc(as_fecha) between :ld_fecini and :ld_fecfin
						and as_lunch = 'F';
						
						lq_total = lq_total + li_numveces * rc_porcen
						 
				CASE '29' //RESPONSABILIDAD
					   If isnull(ep_respon) or ep_respon = 0.00 then
						 lq_total = 0
					   else
						 lq_total = ep_respon
					   end if
						 
				CASE '32' //IMPUESTO A LA RENTA
						lq_total = 0
				END CHOOSE				
		END CHOOSE
		
		If ru_ioe='E' then 
			lq_total=lq_total
			ld_total_egresos=ld_total_egresos  + lq_total
		else
			ld_total_ingresos=ld_total_ingresos+ lq_total
		End if
		
	
		INSERT INTO "NO_ROLPAGO"  
				( "EP_CODIGO",   
				  "RU_CODIGO",   
				  "LQ_VALOR",   
				  "LQ_NUMHOR",   
				  "RR_CODIGO",   
				  "LQ_TOTAL" )  
	    VALUES ( :ep_codigo,   
				  :ru_codigo,   
				  :lq_valor,   
				  :lq_numhor,   
				  :rr_codigo,   
				  :lq_total )  ;
	NEXT // para todos los rubros de cada empleado


	UPDATE "NO_CABROL"  
	SET    "RR_TOTINGR" = :ld_total_ingresos,   
			 "RR_TOTEGRE" = :ld_total_egresos,   
			 "RR_LIQUIDO" = :ld_total_ingresos - :ld_total_egresos  
	WHERE  "NO_CABROL"."EP_CODIGO" =:ep_codigo AND
			 "NO_CABROL"."RR_CODIGO" =:rr_codigo AND
			 "NO_CABROL"."RR_TIPO" = 'R';
	ld_total_ingresos=0
	ld_total_egresos=0

NEXT// para cada empleado

COMMIT;
w_marco.SetMicroHelp('Listo.')
RETURN 1
end function

on w_proceso_rol_pagos_edi.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_1=create cb_1
this.dw_5=create dw_5
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_5
this.Control[iCurrent+7]=this.cb_2
end on

on w_proceso_rol_pagos_edi.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.dw_5)
destroy(this.cb_2)
end on

event open;call super::open;date ld_hoy

select trunc(sysdate)
into :ld_hoy
from dual;

dw_response.SetItem(1,'fecha',ld_hoy)

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_4.SetTransObject(sqlca)
dw_5.SetTransObject(sqlca)
end event

type pb_cancel from w_response_basic`pb_cancel within w_proceso_rol_pagos_edi
integer x = 1445
integer y = 128
integer width = 183
integer height = 160
end type

event pb_cancel::clicked;call super::clicked;close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_proceso_rol_pagos_edi
integer x = 1211
integer y = 128
integer width = 183
integer height = 160
end type

event pb_ok::clicked;datetime ld_fec_fin
integer li_valor
string ls_periodo


dw_response.accepttext()
ld_fec_fin = datetime(dw_response.GetItemDate(1,'fecha'))
ls_periodo = string(dw_response.GetItemDate(1,'fecha'),'MM/YYYY')

SELECT count(*)
INTO :li_valor  
FROM "NO_CABROL","NO_ROLPAGO"
WHERE ( "NO_CABROL"."EP_CODIGO" = "NO_ROLPAGO"."EP_CODIGO" ) and
   ( "NO_CABROL"."RR_CODIGO" = "NO_ROLPAGO"."RR_CODIGO" ) and
	( "NO_ROLPAGO"."RU_CODIGO" =  '24') AND  //PRIMERA QUINCENA 
	( "NO_CABROL"."RR_PAGADO" = 'N' ) AND  
	( "NO_CABROL"."RR_TIPO" = 'Q' ) AND
	( "NO_CABROL"."RR_LIQUIDO" > 0 ) AND	
	( to_char("NO_CABROL"."RR_FECHA",'MM/YYYY') = :ls_periodo )   ;
if li_valor > 0 then
messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La Quincena no ha sido cancelada a$$HEX1$$fa00$$ENDHEX$$n...Verifique.')
return
end if
	
SELECT count(*)
INTO :li_valor  
FROM "NO_CABROL"
WHERE ( to_char("NO_CABROL"."RR_FECHA",'MM/YYYY') = :ls_periodo )   
AND   ( "NO_CABROL"."RR_TIPO" = 'R' );
if li_valor > 0 then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','El rol de este per$$HEX1$$ed00$$ENDHEX$$odo ya fue procesado...Verifique.')
	return
end if


SetPointer(Hourglass!)
//dw_2.retrieve(str_appgeninfo.empresa)
//dw_3.retrieve(str_appgeninfo.empresa)
//dw_4.retrieve()
if wf_rol_pagos(ld_fec_fin,dw_1,dw_2,dw_3) < 0 then 
	messageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se proceso el Rol.",Information!)
End if
close(parent)
SetPointer(Arrow!)
end event

type dw_response from w_response_basic`dw_response within w_proceso_rol_pagos_edi
integer x = 174
integer y = 108
integer width = 928
integer height = 224
string dataobject = "d_sel_proceso_rol_edi"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within w_proceso_rol_pagos_edi
boolean visible = false
integer x = 37
integer y = 524
integer width = 224
integer height = 128
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_actualiza_prestamos"
boolean livescroll = true
end type

type dw_2 from datawindow within w_proceso_rol_pagos_edi
boolean visible = false
integer x = 279
integer y = 524
integer width = 192
integer height = 128
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_empleados_proceso_rol"
boolean livescroll = true
end type

type dw_3 from datawindow within w_proceso_rol_pagos_edi
boolean visible = false
integer x = 485
integer y = 520
integer width = 178
integer height = 128
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_rubros_proceso_rol"
boolean livescroll = true
end type

type dw_4 from datawindow within w_proceso_rol_pagos_edi
boolean visible = false
integer x = 681
integer y = 524
integer width = 187
integer height = 128
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_reactualiza_prestamos"
boolean livescroll = true
end type

type cb_1 from commandbutton within w_proceso_rol_pagos_edi
integer x = 1211
integer y = 348
integer width = 402
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reversar"
end type

event clicked;long ll_pagos,ll_i,i,ll_num_prestamos
decimal ld_valor,pp_valor,pp_saldo,lq_total
string ep_codigo,rr_codigo,pp_numero
string ls_mes ,ls_anio 





dw_2.retrieve(str_appgeninfo.empresa)
dw_5.retrieve()
//ld_fec_fin = datetime(dw_response.GetItemDate(1,'fecha'))
ls_mes = string(dw_response.GetItemDate(1,'fecha'),'MM')
ls_anio = string(dw_response.GetItemDate(1,'fecha'),'YYYY')

DECLARE borrador CURSOR FOR 

SELECT "NO_CABROL"."EP_CODIGO", "NO_CABROL"."RR_CODIGO"
FROM "NO_CABROL"
WHERE	( to_char("NO_CABROL"."RR_FECHA",'mm') = :ls_mes ) AND  
		( to_char("NO_CABROL"."RR_FECHA",'yyyy') = :ls_anio ) AND
		( "NO_CABROL"."RR_TIPO"='R' ) AND 
		( "NO_CABROL"."RR_PAGADO"='N');
		
SELECT count(*)
INTO :ll_pagos
FROM "NO_CABROL"
WHERE	( to_char("NO_CABROL"."RR_FECHA",'mm') = :ls_mes ) AND  
		( to_char("NO_CABROL"."RR_FECHA",'yyyy') = :ls_anio ) AND
		( "NO_CABROL"."RR_TIPO"='R' ) AND 
		( "NO_CABROL"."RR_PAGADO"='N');
		
// Rol de pagos
if ll_pagos > 0 then
	if messageBox('Confirmaci$$HEX1$$f300$$ENDHEX$$n','Esta seguro de que desea borrar el rol del periodo '+ls_mes+' - '+ls_anio+' ?',Question!,YesNo!)=2 then
		return -1
	end if
else
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','No puede borrar el rol del periodo '+ls_mes+' - '+ls_anio+' porque esta pagado')
	return -1
end if

w_marco.SetMicroHelp('Borrando el Rol de Pagos del periodo '+ls_mes+' - '+ls_anio+' ...Por favor espere...!')		
setpointer(hourglass!)

OPEN borrador;
do
// para cada uno proceso el rubro
FETCH borrador into :ep_codigo,:rr_codigo;
if sqlca.sqlcode <> 0 then exit
	if dw_2.Find("ep_codigo = '"+ep_codigo+"'",1,dw_2.RowCount()) <> 0 then
		DELETE FROM "NO_ROLPAGO"  
		WHERE ("NO_ROLPAGO"."RR_CODIGO" = :rr_codigo )  AND
		("NO_ROLPAGO"."EP_CODIGO" = :ep_codigo);
		IF SQLCA.SQLCODE < 0 THEN
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al borrar el detalle el Rol "+sqlca.sqlerrtext)
		Rollback;
		Return -1
		END IF

		DELETE FROM "NO_CABROL"  
		WHERE "NO_CABROL"."RR_CODIGO"=:rr_codigo AND
		"NO_CABROL"."EP_CODIGO"=:ep_codigo;
		IF SQLCA.SQLCODE < 0 THEN
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al borrar el Rol "+sqlca.sqlerrtext)
		Rollback;
		Return -1
		END IF		

		// Reverso el pr$$HEX1$$e900$$ENDHEX$$stamo a como estaba antes del $$HEX1$$fa00$$ENDHEX$$ltimo proceso
		dw_5.SetFilter("ep_codigo='"+ep_codigo+"'" )
		dw_5.Filter()
		ll_num_prestamos=dw_5.RowCount()
		ld_valor=0

		for i = 1 to ll_num_prestamos
			pp_numero=dw_5.GetItemString(i,'pp_numero')
			pp_valor=dw_5.GetItemDecimal(i,'pp_valor')
			SELECT sum("NO_DETPAG"."DP_VALCUO")  
			INTO :ld_valor  
			FROM "NO_DETPAG",   
			"NO_PRESTAMO"  
			WHERE ( "NO_PRESTAMO"."EP_CODIGO" = "NO_DETPAG"."EP_CODIGO" ) and  
				( "NO_PRESTAMO"."PP_NUMERO" = "NO_DETPAG"."PP_NUMERO" ) and  
				( "NO_PRESTAMO"."PP_NUMERO" = :pp_numero) and 
				( "NO_PRESTAMO"."EP_CODIGO" = :ep_codigo ) and
				( "NO_DETPAG"."DP_CUOCANC" = 'S' )   ;
			// para prestamos no cancelados o pendientes de cancelacion por rol
			if isnull(ld_valor) then 
				ld_valor=0
			end if

			UPDATE "NO_DETPAG"  // Actualiza los pagos
			SET "DP_CUOCANC" = 'N'  
			WHERE ( "NO_DETPAG"."EP_CODIGO" = :ep_codigo ) AND  
				  ( "NO_DETPAG"."PP_NUMERO" = :pp_numero ) AND  
				  ( "NO_DETPAG"."DP_CUOCANC" = 'S' ) ;
			IF SQLCA.SQLCODE < 0 THEN
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar los pr$$HEX1$$e900$$ENDHEX$$stamos "+sqlca.sqlerrtext)
				Rollback;
				Return -1
			END IF
	  
			UPDATE "NO_PRESTAMO"  //Actualiza cabecera del pr$$HEX1$$e900$$ENDHEX$$stamo Saldo y estado
			SET "PP_SALDO" = "PP_SALDO" + :ld_valor  , "PP_ESTADO" = 'P'
			WHERE ( "NO_PRESTAMO"."EP_CODIGO" = :ep_codigo ) AND  
					("NO_PRESTAMO"."PP_NUMERO" = :pp_numero )   ;
			IF SQLCA.SQLCODE < 0 THEN
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar los pr$$HEX1$$e900$$ENDHEX$$stamos "+sqlca.sqlerrtext)
				Rollback;
				Return -1
			END IF
		Next			  
	end if 
loop while true
close borrador;
commit;
w_marco.SetMicroHelp('Listo se ha reversado el Rol de Pagos del periodo '+ls_mes+' - '+ls_anio+' ...')			
setpointer(arrow!)

end event

type dw_5 from datawindow within w_proceso_rol_pagos_edi
boolean visible = false
integer x = 882
integer y = 524
integer width = 142
integer height = 128
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_reversa_prestamos"
boolean livescroll = true
end type

type cb_2 from commandbutton within w_proceso_rol_pagos_edi
integer x = 1714
integer y = 344
integer width = 343
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;// Reverso el pr$$HEX1$$e900$$ENDHEX$$stamo a como estaba antes del $$HEX1$$fa00$$ENDHEX$$ltimo proceso
String ep_codigo
integer i,ll_num_prestamos
decimal ld_valor,pp_valor
String pp_numero
Setpointer(hourglass!)
dw_2.Retrieve(str_appgeninfo.empresa)
dw_5.retrieve()

for i = 1 to dw_2.rowcount()
	     ep_codigo = dw_2.Object.ep_codigo[i]
		dw_5.SetFilter("ep_codigo='"+ep_codigo+"'" )
		dw_5.Filter()
		ll_num_prestamos=dw_5.RowCount()
		ld_valor=0

		for i = 1 to ll_num_prestamos
			pp_numero=dw_5.GetItemString(i,'pp_numero')
			pp_valor=dw_5.GetItemDecimal(i,'pp_valor')
			SELECT sum("NO_DETPAG"."DP_VALCUO")  
			INTO :ld_valor  
			FROM "NO_DETPAG",   
			"NO_PRESTAMO"  
			WHERE ( "NO_PRESTAMO"."EP_CODIGO" = "NO_DETPAG"."EP_CODIGO" ) and  
				( "NO_PRESTAMO"."PP_NUMERO" = "NO_DETPAG"."PP_NUMERO" ) and  
				( "NO_PRESTAMO"."PP_NUMERO" = :pp_numero) and 
				( "NO_PRESTAMO"."EP_CODIGO" = :ep_codigo ) and
				( "NO_DETPAG"."DP_CUOCANC" = 'S' )   ;
			// para prestamos no cancelados o pendientes de cancelacion por rol
			if isnull(ld_valor) then 
				ld_valor=0
			end if

			UPDATE "NO_DETPAG"  // Actualiza los pagos
			SET "DP_CUOCANC" = 'N'  
			WHERE ( "NO_DETPAG"."EP_CODIGO" = :ep_codigo ) AND  
				  ( "NO_DETPAG"."PP_NUMERO" = :pp_numero ) AND  
				  ( "NO_DETPAG"."DP_CUOCANC" = 'S' ) ;
			IF SQLCA.SQLCODE < 0 THEN
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar los pr$$HEX1$$e900$$ENDHEX$$stamos "+sqlca.sqlerrtext)
				Rollback;
				Return -1
			END IF
	  
			UPDATE "NO_PRESTAMO"  //Actualiza cabecera del pr$$HEX1$$e900$$ENDHEX$$stamo Saldo y estado
			SET "PP_SALDO" = "PP_SALDO" + :ld_valor  , "PP_ESTADO" = 'P'
			WHERE ( "NO_PRESTAMO"."EP_CODIGO" = :ep_codigo ) AND  
					("NO_PRESTAMO"."PP_NUMERO" = :pp_numero )   ;
			IF SQLCA.SQLCODE < 0 THEN
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar los pr$$HEX1$$e900$$ENDHEX$$stamos "+sqlca.sqlerrtext)
				Rollback;
				Return -1
			END IF
         next
Next

COMMIT;
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo")
Setpointer(Arrow!)
end event


HA$PBExportHeader$w_res_asiento_liquidacion_caja.srw
$PBExportComments$Si. Contabiliza Ingresos de caja del dia
forward
global type w_res_asiento_liquidacion_caja from window
end type
type st_2 from statictext within w_res_asiento_liquidacion_caja
end type
type dw_1 from datawindow within w_res_asiento_liquidacion_caja
end type
type st_1 from statictext within w_res_asiento_liquidacion_caja
end type
type pb_2 from picturebutton within w_res_asiento_liquidacion_caja
end type
type pb_1 from picturebutton within w_res_asiento_liquidacion_caja
end type
end forward

global type w_res_asiento_liquidacion_caja from window
integer width = 1600
integer height = 808
boolean titlebar = true
string title = "Asiento Liquidaci$$HEX1$$f300$$ENDHEX$$n de Caja."
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_2 st_2
dw_1 dw_1
st_1 st_1
pb_2 pb_2
pb_1 pb_1
end type
global w_res_asiento_liquidacion_caja w_res_asiento_liquidacion_caja

on w_res_asiento_liquidacion_caja.create
this.st_2=create st_2
this.dw_1=create dw_1
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={this.st_2,&
this.dw_1,&
this.st_1,&
this.pb_2,&
this.pb_1}
end on

on w_res_asiento_liquidacion_caja.destroy
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event open;datawindowchild dwc

dw_1.SetTransObject(SQLCA)
dw_1.GetChild("ep_codigo",dwc)
dwc.SetTransObject(SQLCA)
dwc.Retrieve(str_appgeninfo.empresa)
dw_1.InsertRow(0)


end event

type st_2 from statictext within w_res_asiento_liquidacion_caja
integer x = 73
integer y = 132
integer width = 1445
integer height = 136
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione el empleado que elabor$$HEX2$$f3002000$$ENDHEX$$ingresos de caja y la fecha en la que se realizo"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_res_asiento_liquidacion_caja
integer x = 50
integer y = 272
integer width = 1458
integer height = 228
integer taborder = 10
string title = "none"
string dataobject = "d_sel_tes_empleado_fecha"
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within w_res_asiento_liquidacion_caja
integer x = 78
integer y = 40
integer width = 1394
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Este proceso contabilizar$$HEX2$$e1002000$$ENDHEX$$las Liquidaciones de Caja"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_res_asiento_liquidacion_caja
integer x = 1193
integer y = 520
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Cancel.Gif"
alignment htextalign = left!
end type

event clicked;Close(Parent)
end event

type pb_1 from picturebutton within w_res_asiento_liquidacion_caja
integer x = 242
integer y = 520
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;String          ls_empleado,ls_tipo,ls_obs,ls_cuenta,ls_signo,ls_nulo,ls_colum,&
                   ls_origen,ls_proce
Integer        i
Date            ld_fecha
Long           ll_row,ll_cpnumero,ll_new,ll_nreg,ll_cuentaproce
Decimal {2} lc_efectivo,&
                       lc_cheque,&
				  lc_vdeposito,&
				  lc_vrecaps,&
				  lc_votros,&
				  lc_vdiferidos,&
				  lc_vefectivo,&
				  lc_total
Decimal{2}  lc_valores[] = {0}
DataStore    lds_reporte

SetNull(ls_nulo)
If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de que desea procesar ?",question!,YesNO!,2) = 2 &
Then
Return
End if 

ll_row = dw_1.GetRow()
If ll_row = 0 Then Return 
ls_empleado  = dw_1.GetItemString(ll_row,"ep_codigo")
ld_fecha           = Date(dw_1.GetItemDateTime(ll_Row,"te_fecha"))

/*Validar condiciones para el proceso*/
If isnull(ls_empleado) or ls_empleado =""  or isnull(ld_fecha) or String(ld_fecha) = ""  &
Then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las condiciones para procesar son incorrectas o est$$HEX1$$e100$$ENDHEX$$n incompletas")
Return
End if

w_marco.SetMicrohelp("Procesando el Asiento...!")

/*Recuperar datos para Generar los Asientos*/
lds_reporte = Create DataStore
lds_reporte.DataObject = 'd_rep_asiento_liqui_caja'
lds_reporte.SetTransObject(SQLCA)
ll_nreg = lds_reporte.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_empleado,ld_fecha)

If ll_nreg = 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Datos para Procesar ",Exclamation!)
Return
End if

/*Verificar si el  proceso ya ha sido corrido*/
SELECT   count("TS_INGRESO"."TE_PROCE")  
INTO :ll_cuentaproce
FROM "TS_INGRESO"  
WHERE ( "TS_INGRESO"."EM_CODIGO" = :str_appgeninfo.empresa) AND  
         ( "TS_INGRESO"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
         ( TRUNC("TS_INGRESO"."TE_FECHA") = :ld_fecha  ) AND  
		( "TS_INGRESO"."EP_CODIGO" = :ls_empleado ) AND  
         ( "TS_INGRESO"."TE_PROCE" = 'C' )   ;

/*Si no encuentro registros siga*/		
If  SQLCA.SQLCODE = 0 AND ll_cuentaproce > 0  &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Este asiento ya fue procesado")
Return
End if 


/*Se empieza a crear el asiento*/
For i = 1 to ll_nreg
	 ls_origen         =  lds_reporte.GetItemString(i,"es_codigo")	
	 lc_efectivo       =  lds_reporte.GetItemDecimal(i,"sefectivo")	
	 lc_cheque       =  lds_reporte.GetItemDecimal(i,"scheque")
	 lc_vdeposito   =  lds_reporte.GetItemDecimal(i,"sdepo")
	 lc_vrecaps      =   lds_reporte.GetItemDecimal(i,"srecaps")
	 lc_vdiferidos   =  lds_reporte.GetItemDecimal(i,"sdife")
	 lc_votros         =   lds_reporte.GetItemDecimal(i,"sotros1")

	 lc_vefectivo = lc_efectivo+lc_cheque + lc_votros
     lc_total = lc_vefectivo+lc_vdeposito+lc_vrecaps+lc_vdiferidos

	
	/*El valor de otros no est$$HEX2$$e1002000$$ENDHEX$$definida a donde ir */  
	If ls_origen = '2'  /*P.O.S */ &
	Then
	lc_valores[1]  =  lc_vefectivo
     lc_valores[2]  =  lc_vdiferidos
     lc_valores[3]  =  lc_vrecaps
     lc_valores[4]  =  lc_total
    
	 If  f_asiento_automatico('TESOR_POS',lc_valores,lc_total) < 0 Then Return 
     else                       /* S. I. F */  
	lc_valores[1]  =  lc_vefectivo
     lc_valores[2]  =  lc_vdiferidos
     lc_valores[3]  =  lc_vrecaps
     lc_valores[4]  =  lc_vdeposito
     lc_valores[5]  =  lc_total	
		
     If	f_asiento_automatico('LIQUI_CAJA',lc_valores,lc_total)	 < 0 Then Return
     End  if  
	
	/*2.-Generar el sguiente asiento si lc_vdeposito <> 0 */
	lc_valores[ ] = {0}
	If lc_vdeposito <> 0 &
	Then
	lc_total = 0
	lc_valores[1]  =  (lc_vdeposito*0.8)/100
	lc_valores[2]  =  (lc_vdeposito*0.8)/100
	lc_total            =  (lc_vdeposito*0.8)/100
     If 	f_asiento_automatico('LIQUI_CAJA2',lc_valores,lc_total) < 0 Then Return
	End if
Next	

/*Actualizar el campo procesado de la tabla TS_INGRESO*/
/*Para controlar que no vuelva a ser contabilizado la liquidaci$$HEX1$$f300$$ENDHEX$$n de caja
  para esa fecha y ese empleado*/
  
  
UPDATE  "TS_INGRESO"  
SET         "TS_INGRESO"."TE_PROCE"  = 'C'
WHERE ( "TS_INGRESO"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
         ( "TS_INGRESO"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
         ( TRUNC("TS_INGRESO"."TE_FECHA") = :ld_fecha ) AND  
		( "TS_INGRESO"."EP_CODIGO" = :ls_empleado ) AND  
         ( "TS_INGRESO"."TE_PROCE" <> 'C' )   ;

/*Si no encuentro registros siga*/		
If  SQLCA.SQLCODE < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar el Estado de la Liquidaci$$HEX1$$f300$$ENDHEX$$n")
Rollback;
Return
End if 

COMMIT;
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso completado con $$HEX1$$e900$$ENDHEX$$xito",Exclamation!)
w_marco.SetMicrohelp("Listo...!")








end event


HA$PBExportHeader$w_res_asiento_cancelacion_cartera.srw
$PBExportComments$Si. Contabiliza Ingresos de caja del dia
forward
global type w_res_asiento_cancelacion_cartera from window
end type
type st_3 from statictext within w_res_asiento_cancelacion_cartera
end type
type em_1 from editmask within w_res_asiento_cancelacion_cartera
end type
type st_2 from statictext within w_res_asiento_cancelacion_cartera
end type
type st_1 from statictext within w_res_asiento_cancelacion_cartera
end type
type pb_2 from picturebutton within w_res_asiento_cancelacion_cartera
end type
type pb_1 from picturebutton within w_res_asiento_cancelacion_cartera
end type
end forward

global type w_res_asiento_cancelacion_cartera from window
integer width = 1600
integer height = 808
boolean titlebar = true
string title = "Asiento Liquidaci$$HEX1$$f300$$ENDHEX$$n de Caja."
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_3 st_3
em_1 em_1
st_2 st_2
st_1 st_1
pb_2 pb_2
pb_1 pb_1
end type
global w_res_asiento_cancelacion_cartera w_res_asiento_cancelacion_cartera

on w_res_asiento_cancelacion_cartera.create
this.st_3=create st_3
this.em_1=create em_1
this.st_2=create st_2
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={this.st_3,&
this.em_1,&
this.st_2,&
this.st_1,&
this.pb_2,&
this.pb_1}
end on

on w_res_asiento_cancelacion_cartera.destroy
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
end on

type st_3 from statictext within w_res_asiento_cancelacion_cartera
integer x = 224
integer y = 352
integer width = 512
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha de Cancelaci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_res_asiento_cancelacion_cartera
integer x = 782
integer y = 344
integer width = 352
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_res_asiento_cancelacion_cartera
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
string text = "Ingrese la fecha en que se realiz$$HEX2$$f3002000$$ENDHEX$$la cancelaci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type st_1 from statictext within w_res_asiento_cancelacion_cartera
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
string text = "Este proceso contabilizar$$HEX2$$e1002000$$ENDHEX$$la Cancelaci$$HEX1$$f300$$ENDHEX$$n de Cartera"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_res_asiento_cancelacion_cartera
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

type pb_1 from picturebutton within w_res_asiento_cancelacion_cartera
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

event clicked;String          ls_tipo,ls_obs,&
                     ls_fpcodigo
Integer        i
Date            ld_fecha
Long             ll_nreg
Decimal {2} lc_efectivo,&
                       lc_cheque,&
				  lc_total,& 
				  lc_valor,&
				  lc_ncdev,&
				  lc_letracambio,&
				  lc_deposito,&
				  lc_ncpp,lc_ncls,lc_dadic,lc_anticipo,lc_retf,lc_contribuyente,lc_cartera
Decimal{2}  lc_valores[] = {0}
DataStore    lds_reporte


If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de que desea procesar ?",question!,YesNO!,2) = 2 &
Then
Return
End if 

ld_fecha           = Date(em_1.Text)

/*Validar condiciones para el proceso*/
If  isnull(ld_fecha) or String(ld_fecha) = ""  &
Then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las condiciones para procesar son incorrectas o est$$HEX1$$e100$$ENDHEX$$n incompletas")
Return
End if

w_marco.SetMicrohelp("Procesando el Asiento...!")

/*Recuperar datos para Generar los Asientos*/
lds_reporte = Create DataStore
lds_reporte.DataObject = 'd_rep_asiento_cancelacion_cartera'
lds_reporte.SetTransObject(SQLCA)
ll_nreg = lds_reporte.Retrieve(ld_fecha)

If ll_nreg = 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Datos para Procesar ",Exclamation!)
Return
End if

For i = 1 to ll_nreg
	 ls_fpcodigo    =  lds_reporte.GetItemString(i,"fp_codigo")
	 lc_valor       =  lds_reporte.GetItemDecimal(i,"cc_valor")
	 
	 CHOOSE CASE ls_fpcodigo
		case '0' /*Efectivo*/
			lc_efectivo = lc_valor
		case '1' /*Cheque*/
			lc_cheque = lc_valor
		case '2' /*NC por dev.*/
			lc_ncdev = lc_valor
		case '3' /*Letra de Cambio*/
			lc_letracambio = lc_valor
		case '49' /*  NCLS*/
			lc_ncls = lc_valor
		case'50' /*Deposito*/
			lc_deposito = lc_valor
		case '51' /*ncpp*/
			lc_ncpp = lc_valor
		case '52' /*descto Adicional*/
			lc_dAdic = lc_valor
		case'53' /*Antcipo Clientes*/
			lc_anticipo = lc_valor
		case'6'    /*Retenci$$HEX1$$f300$$ENDHEX$$n en la fuente*/
			lc_retf = lc_valor
		case '7'	 /*Contribuyente especial*/
			lc_contribuyente = lc_valor
	END CHOOSE
Next		

	/*Se empieza a crear el asiento*/
     lc_cartera = lc_efectivo+lc_cheque+lc_letracambio+ lc_ncdev + lc_deposito
     lc_total = lc_cartera + lc_retf + lc_contribuyente + lc_ncpp+ lc_dadic + lc_anticipo + lc_ncls

	lc_valores[1]  =  lc_cartera
     lc_valores[2]  =  lc_retf
     lc_valores[3]  =  lc_contribuyente
     lc_valores[4]  =  lc_ncpp
     lc_valores[5]  =  lc_dadic
     lc_valores[6]  =  lc_anticipo
     lc_valores[7]  =  0
	lc_valores[8]  =  lc_total
	lc_valores[9]  =  lc_ncls	  
	  
	  
If  f_asiento_automatico('CARTERA_PAGO',lc_valores,lc_total) < 0 Then Return 

Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso completado con $$HEX1$$e900$$ENDHEX$$xito",Exclamation!)
Destroy lds_reporte
w_marco.SetMicrohelp("Listo...!")








end event


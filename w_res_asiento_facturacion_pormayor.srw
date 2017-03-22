HA$PBExportHeader$w_res_asiento_facturacion_pormayor.srw
$PBExportComments$Si. Contabiliza Ingresos de caja del dia
forward
global type w_res_asiento_facturacion_pormayor from window
end type
type dw_datos from datawindow within w_res_asiento_facturacion_pormayor
end type
type dw_cabcom from datawindow within w_res_asiento_facturacion_pormayor
end type
type dw_detcom from datawindow within w_res_asiento_facturacion_pormayor
end type
type st_4 from statictext within w_res_asiento_facturacion_pormayor
end type
type em_2 from editmask within w_res_asiento_facturacion_pormayor
end type
type st_3 from statictext within w_res_asiento_facturacion_pormayor
end type
type em_1 from editmask within w_res_asiento_facturacion_pormayor
end type
type st_2 from statictext within w_res_asiento_facturacion_pormayor
end type
type st_1 from statictext within w_res_asiento_facturacion_pormayor
end type
type pb_2 from picturebutton within w_res_asiento_facturacion_pormayor
end type
type pb_1 from picturebutton within w_res_asiento_facturacion_pormayor
end type
end forward

global type w_res_asiento_facturacion_pormayor from window
integer width = 3017
integer height = 1748
boolean titlebar = true
string title = "Asiento Liquidaci$$HEX1$$f300$$ENDHEX$$n de Caja."
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
dw_datos dw_datos
dw_cabcom dw_cabcom
dw_detcom dw_detcom
st_4 st_4
em_2 em_2
st_3 st_3
em_1 em_1
st_2 st_2
st_1 st_1
pb_2 pb_2
pb_1 pb_1
end type
global w_res_asiento_facturacion_pormayor w_res_asiento_facturacion_pormayor

forward prototypes
public function integer wf_ventas_fxm ()
end prototypes

public function integer wf_ventas_fxm ();Long ll_cpnumero,ll_new,i,j,ll_reg,ll_numcomp,ll_newm
String ls_centro,&
          ls_obs = 'Resumen de ventas fxm',&
		ls_sectipo	 
Date ld_fecini,ld_fecfin
DatawindowChild ldwc_tipo



ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)

/**/
ll_reg = dw_datos.retrieve(ld_fecini,ld_fecfin)

/*Generar el sucuencial del Asiento*/
ll_cpnumero = f_secuencial_sucursal(str_appgeninfo.empresa,str_appgeninfo.sucursal,"CONTA_COMP")


/*Generar el secuencial por comprobante*/
ls_sectipo = string(f_secuencial(str_appgeninfo.empresa,'DVE'))


/*Insertar la cabecera*/
ll_newm = dw_cabcom.InsertRow(0)

dw_cabcom.SetItem(ll_newm,"em_codigo",str_appgeninfo.empresa)
dw_cabcom.SetItem(ll_newm,"su_codigo",str_appgeninfo.sucursal)
dw_cabcom.SetItem(ll_newm,"ti_codigo",'5')
dw_cabcom.SetItem(ll_newm,"cp_observ",'Resumen ventas fxm')
dw_cabcom.SetItem(ll_newm,"cp_numero",ll_cpnumero)
dw_cabcom.Setitem(ll_newm,"cp_numcomp",ls_sectipo)
dw_cabcom.SetItem(ll_newm,"cp_fecha",today())
dw_cabcom.SetItem(ll_newm,"cp_saldo",0)
dw_cabcom.SetItem(ll_newm,"cp_debito",0)
dw_cabcom.SetItem(ll_newm,"cp_credito",0)


/*Insertar ahora el detalle del Asiento*/
/*Recorrer la plantilla de Asientos automaticos*/


/* -- inicia el contador*/
          
     
/*       --insertamos los valores de d$$HEX1$$e900$$ENDHEX$$bito*/
String  ls_cuenta[] = { '1310101000', '4110201000', '2320101000','6990101000'},&
           ls_signo[]    = {'D','C','C','C'}
Dec    lc_valor[]
          
FOR i = 1  to ll_reg
  		lc_valor[1] = dw_datos.object.valpag[i]
		lc_valor[2] = dw_datos.object.neto[i]
		lc_valor[3] = dw_datos.object.iva[i]
		lc_valor[4] = dw_datos.object.cargo[i]
		
		for j = 1 to 4	 
		ll_new = dw_detcom.insertrow(0)	 
		dw_detcom.Object.em_codigo[ll_new] = str_appgeninfo.empresa
		dw_detcom.Object.su_codigo[ll_new] = '1'
		dw_detcom.Object.ti_codigo[ll_new] ='5'
		dw_detcom.Object.dt_secue[ll_new] = string(j)
		dw_detcom.Object.cp_numero[ll_new] = ll_cpnumero
		dw_detcom.Object.pl_codigo[ll_new] = ls_cuenta[j]
		dw_detcom.Object.cs_codigo[ll_new] = string(dw_datos.Object.ccosto[i])  
		dw_detcom.Object.dt_signo[ll_new]         = ls_signo[j]
          dw_detcom.Object.dt_valor[ll_new]          = lc_valor[j]		
          dw_detcom.Object.dt_detalle[ll_new]        = ls_obs		
          next
      
Next

/*Actualiza los saldos */
if dw_detcom.rowcount() > 0 and dw_cabcom.rowcount() > 0 then
dw_cabcom.Object.cp_debito[ll_newm]  =  dw_detcom.Object.cc_totdebitos[1]
dw_cabcom.Object.cp_credito[ll_newm] =  dw_detcom.Object.cc_totcreditos[1]
else
Rollback;	
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al realizar el asiento....consulte al departamento de sistemas")
Return -1	
end if

return 1
end function

on w_res_asiento_facturacion_pormayor.create
this.dw_datos=create dw_datos
this.dw_cabcom=create dw_cabcom
this.dw_detcom=create dw_detcom
this.st_4=create st_4
this.em_2=create em_2
this.st_3=create st_3
this.em_1=create em_1
this.st_2=create st_2
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={this.dw_datos,&
this.dw_cabcom,&
this.dw_detcom,&
this.st_4,&
this.em_2,&
this.st_3,&
this.em_1,&
this.st_2,&
this.st_1,&
this.pb_2,&
this.pb_1}
end on

on w_res_asiento_facturacion_pormayor.destroy
destroy(this.dw_datos)
destroy(this.dw_cabcom)
destroy(this.dw_detcom)
destroy(this.st_4)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event open;dw_datos.SetTransObject(sqlca)
dw_cabcom.SetTransObject(sqlca)
dw_detcom.SetTransObject(sqlca)
end event

type dw_datos from datawindow within w_res_asiento_facturacion_pormayor
boolean visible = false
integer x = 2130
integer y = 92
integer width = 539
integer height = 168
string title = "none"
string dataobject = "d_rep_ventas_fxm"
boolean resizable = true
boolean livescroll = true
end type

type dw_cabcom from datawindow within w_res_asiento_facturacion_pormayor
boolean visible = false
integer x = 1650
integer y = 84
integer width = 421
integer height = 192
string title = "none"
string dataobject = "d_aux_comprobante"
boolean resizable = true
boolean livescroll = true
end type

type dw_detcom from datawindow within w_res_asiento_facturacion_pormayor
integer x = 41
integer y = 440
integer width = 2944
integer height = 1208
integer taborder = 40
boolean titlebar = true
string title = "Detalle del asiento"
string dataobject = "d_aux_detallecomprobante"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;Int  rc


Setpointer(Hourglass!)
if dwo.name = "b_1" then
	rc = dw_cabcom.update(true,false)
	if rc = 1 then
	rc = dw_detcom.update(true,false)
	if rc =1 then
		dw_cabcom.resetupdate()
		dw_detcom.resetupdate()
		commit;
		w_marco.Setmicrohelp("Asiento creado con $$HEX1$$e900$$ENDHEX$$xito....!")
		else
		rollback;
		return
		end if
	else
	rollback;
	return
	end if
end if

if dwo.name = 'b_2' then
	dw_cabcom.reset()
	dw_detcom.reset()
	dw_datos.reset()
end if
Setpointer(Arrow!)
end event

type st_4 from statictext within w_res_asiento_facturacion_pormayor
integer x = 494
integer y = 228
integer width = 197
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type em_2 from editmask within w_res_asiento_facturacion_pormayor
integer x = 494
integer y = 288
integer width = 352
integer height = 88
integer taborder = 20
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
boolean autoskip = true
end type

type st_3 from statictext within w_res_asiento_facturacion_pormayor
integer x = 78
integer y = 228
integer width = 187
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_res_asiento_facturacion_pormayor
integer x = 69
integer y = 292
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
boolean autoskip = true
end type

type st_2 from statictext within w_res_asiento_facturacion_pormayor
integer x = 73
integer y = 132
integer width = 1445
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingrese la fecha en que se realiz$$HEX2$$f3002000$$ENDHEX$$la facturaci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type st_1 from statictext within w_res_asiento_facturacion_pormayor
integer x = 78
integer y = 40
integer width = 1504
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Este proceso contabilizar$$HEX2$$e1002000$$ENDHEX$$la Facturaci$$HEX1$$f300$$ENDHEX$$n Diaria al Por Mayor"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_res_asiento_facturacion_pormayor
integer x = 1248
integer y = 252
integer width = 174
integer height = 152
integer taborder = 50
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

type pb_1 from picturebutton within w_res_asiento_facturacion_pormayor
integer x = 983
integer y = 252
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
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;String            ls_tipo,ls_obs
Integer          i
Date              ld_fecha_ini, ld_fecha_fin
Long             ll_row,ll_nreg
Decimal {2} lc_neto,&
                      lc_iva,&
				  lc_total
Decimal{2}  lc_valores[] = {0}
DataStore    lds_reporte


If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de que desea procesar ?",question!,YesNO!,2) = 2 &
Then
Return
End if 

ld_fecha_ini           = Date(em_1.Text)
ld_fecha_fin           = Date(em_2.Text)

/*Validar condiciones para el proceso*/
If  isnull(ld_fecha_ini) or String(ld_fecha_ini) = ""   or isnull(ld_fecha_fin) or String(ld_fecha_fin) = ""&
Then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las condiciones para procesar son incorrectas o est$$HEX1$$e100$$ENDHEX$$n incompletas")
Return
End if

w_marco.SetMicrohelp("Procesando el Asiento...!")
Setpointer(Hourglass!)
///*Recuperar datos para Generar los Asientos*/
//lds_reporte = Create DataStore
//lds_reporte.DataObject = 'd_rep_ventas_fxm'
//lds_reporte.SetTransObject(SQLCA)
//ll_nreg = lds_reporte.Retrieve('1',str_appgeninfo.empresa,ld_fecha_ini,ld_fecha_fin)
//
//If ll_nreg = 0 &
//Then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Datos para Procesar ",Exclamation!)
//Return
//End if


/*Inicia creacion del asiento*/

if wf_ventas_fxm() < 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El asiento no ha sido generado....por favor comuniquese con sistemas")
	Rollback;
	return
end if	
//If  f_asiento_automatico('VENTAS_SIF',lc_valores,lc_total) < 0 Then Return 

//Destroy lds_reporte
Setpointer(Arrow!)
w_marco.SetMicrohelp("Listo...!")








end event


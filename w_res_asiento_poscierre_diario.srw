HA$PBExportHeader$w_res_asiento_poscierre_diario.srw
$PBExportComments$Si. Contabiliza Ingresos de caja del dia
forward
global type w_res_asiento_poscierre_diario from window
end type
type st_3 from statictext within w_res_asiento_poscierre_diario
end type
type em_1 from editmask within w_res_asiento_poscierre_diario
end type
type st_2 from statictext within w_res_asiento_poscierre_diario
end type
type st_1 from statictext within w_res_asiento_poscierre_diario
end type
type pb_2 from picturebutton within w_res_asiento_poscierre_diario
end type
type pb_1 from picturebutton within w_res_asiento_poscierre_diario
end type
end forward

global type w_res_asiento_poscierre_diario from window
integer width = 1445
integer height = 808
boolean titlebar = true
string title = "Asiento Cierre de Caja Diario"
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
global w_res_asiento_poscierre_diario w_res_asiento_poscierre_diario

on w_res_asiento_poscierre_diario.create
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

on w_res_asiento_poscierre_diario.destroy
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
end on

type st_3 from statictext within w_res_asiento_poscierre_diario
integer x = 773
integer y = 300
integer width = 315
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = " [dd/mm/yyyy]"
boolean focusrectangle = false
end type

type em_1 from editmask within w_res_asiento_poscierre_diario
integer x = 773
integer y = 192
integer width = 325
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_res_asiento_poscierre_diario
integer x = 87
integer y = 208
integer width = 677
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 67108864
string text = "Seleccione la fecha del cierre :"
boolean focusrectangle = false
end type

type st_1 from statictext within w_res_asiento_poscierre_diario
integer x = 55
integer y = 52
integer width = 1326
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Este proceso contabilizar$$HEX2$$e1002000$$ENDHEX$$el cierre de Caja Diario"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_res_asiento_poscierre_diario
integer x = 914
integer y = 504
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Cancel.Gif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type pb_1 from picturebutton within w_res_asiento_poscierre_diario
integer x = 247
integer y = 504
integer width = 183
integer height = 160
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

event clicked;long ll_nreg
Datetime ld_fecha
Decimal {2} lc_ventas,&
                      lc_retencion,&
				  lc_autoconsumo,&
				  lc_neto,&
				  lc_iva,&
				  lc_sobra,&
				  lc_falta,&
				  lc_total
Decimal{2}  lc_valores[] = {0}
string ls_caja,ls_cajero
char   lch_contab
DataStore    lds_reporte


If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de que desea procesar ?",question!,YesNO!,2) = 2 &
Then
Return
End if 


ld_fecha = datetime(date(em_1.text))
/*Validar condiciones para el proceso*/
If isnull(em_1.text) or em_1.text ="" Then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las condiciones para procesar son incorrectas o est$$HEX1$$e100$$ENDHEX$$n incompletas")
Return
End if

w_marco.SetMicrohelp("Procesando el Asiento...!")
SetPointer(HourGlass!)

select cj_caja,ep_codigo 
into : ls_caja,:ls_cajero
from fa_venta
where es_codigo = '2'
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and trunc(ve_fecha) = trunc(:ld_fecha)
minus
select cj_caja,ep_codigo
from fa_cierre
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and trunc(ci_fecha) = trunc(:ld_fecha);

If sqlca.sqlcode <> 100 Then
	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','No se han realizado todos los cierres de caja de este dia~r~nPor favor verifique',StopSign!)
	return
End if

SELECT CI_SOBRA,CI_FALTA,CI_CONTAB
INTO :lc_sobra,:lc_falta,:lch_contab
FROM FA_CIERRE
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND      SU_CODIGO  = :str_appgeninfo.sucursal
and       trunc(ci_fecha) = trunc(:ld_fecha);

If lch_contab = 'C' Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El asiento para esta fecha ya fue procesado",Exclamation!)
w_marco.SetMicrohelp("Listo...!")
Return
End if	

/*Recuperar datos para Generar los Asientos*/
lds_reporte = Create DataStore
lds_reporte.DataObject = 'd_asiento_pos_cierre_caja'
lds_reporte.SetTransObject(SQLCA)
ll_nreg = lds_reporte.Retrieve('2',str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fecha)

If ll_nreg = 0 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Datos para Procesar ",Exclamation!)
Return
End if

lc_ventas       =  lds_reporte.GetItemDecimal(lds_reporte.getrow(),"cc_total")	
lc_retencion       =  lds_reporte.GetItemDecimal(lds_reporte.getrow(),"cc_r")
lc_autoconsumo   =  lds_reporte.GetItemDecimal(lds_reporte.getrow(),"cc_a")
lc_neto      =   lds_reporte.GetItemDecimal(lds_reporte.getrow(),"cc_vm")
lc_iva   =  lds_reporte.GetItemDecimal(lds_reporte.getrow(),"iva")

If lc_sobra = 0 Then lc_neto = lc_neto + lc_falta
If lc_falta = 0 Then lc_ventas = lc_ventas - lc_sobra

lc_total = lc_ventas+lc_retencion+lc_autoconsumo + lc_falta

	
lc_valores[1]  =  lc_ventas
lc_valores[2]  =  lc_retencion
lc_valores[3]  =  lc_autoconsumo
lc_valores[4]  =  lc_neto
lc_valores[5]  =  lc_iva
lc_valores[6]  =  lc_sobra
lc_valores[7]  =  lc_falta
    
If  f_asiento_automatico('CIERRE_CAJA',lc_valores,lc_total) < 0 Then Return 

update fa_cierre
set ci_contab = 'C'
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and trunc(ci_fecha) = trunc(:ld_fecha);

Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso completado con $$HEX1$$e900$$ENDHEX$$xito",Exclamation!)
SetPointer(arrow!)
w_marco.SetMicrohelp("Listo...!")

end event


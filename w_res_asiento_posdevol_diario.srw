HA$PBExportHeader$w_res_asiento_posdevol_diario.srw
$PBExportComments$Si. Contabiliza Ingresos de caja del dia
forward
global type w_res_asiento_posdevol_diario from window
end type
type st_3 from statictext within w_res_asiento_posdevol_diario
end type
type em_1 from editmask within w_res_asiento_posdevol_diario
end type
type st_2 from statictext within w_res_asiento_posdevol_diario
end type
type st_1 from statictext within w_res_asiento_posdevol_diario
end type
type pb_2 from picturebutton within w_res_asiento_posdevol_diario
end type
type pb_1 from picturebutton within w_res_asiento_posdevol_diario
end type
end forward

global type w_res_asiento_posdevol_diario from window
integer width = 1568
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
global w_res_asiento_posdevol_diario w_res_asiento_posdevol_diario

on w_res_asiento_posdevol_diario.create
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

on w_res_asiento_posdevol_diario.destroy
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
end on

type st_3 from statictext within w_res_asiento_posdevol_diario
integer x = 850
integer y = 340
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

type em_1 from editmask within w_res_asiento_posdevol_diario
integer x = 850
integer y = 232
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

type st_2 from statictext within w_res_asiento_posdevol_diario
integer x = 165
integer y = 248
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

type st_1 from statictext within w_res_asiento_posdevol_diario
integer x = 23
integer y = 52
integer width = 1486
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Este proceso contabiliza las devoluciones de Caja Diarias"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_res_asiento_posdevol_diario
integer x = 1079
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

type pb_1 from picturebutton within w_res_asiento_posdevol_diario
integer x = 261
integer y = 504
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

event clicked;long ll_nreg
Datetime ld_fecha
Decimal {2} lc_valpag,&
				  lc_iva,&
				  lc_total
Decimal{2}  lc_valores[] = {0}
char   lch_contab


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

SELECT SUM("FA_VENTA"."VE_VALPAG"),
			SUM("FA_VENTA"."VE_IVA")
INTO : lc_valpag, :lc_iva			
FROM  "FA_VENTA"
WHERE ( ( "FA_VENTA"."ES_CODIGO" = '10' ) AND  
         ( "FA_VENTA"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
         ( "FA_VENTA"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
         (trunc("FA_VENTA"."VE_FECHA") = :ld_fecha));
If sqlca.sqlcode = 100 Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Datos para Procesar este d$$HEX1$$ed00$$ENDHEX$$a",Exclamation!)
	return
End if

lc_total = lc_valpag+lc_iva
	
lc_valores[1]  =  lc_valpag - lc_iva
lc_valores[2]  =  lc_iva
lc_valores[3]  =  lc_valpag
    
If  f_asiento_automatico('DEVOL_CAJA',lc_valores,lc_total) < 0 Then Return 

Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso completado con $$HEX1$$e900$$ENDHEX$$xito",Exclamation!)
SetPointer(arrow!)
w_marco.SetMicrohelp("Listo...!")

end event


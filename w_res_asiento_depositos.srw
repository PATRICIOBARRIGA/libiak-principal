HA$PBExportHeader$w_res_asiento_depositos.srw
$PBExportComments$Si. Contabiliza los depositos ingresados en Caja/Bancos.Vale
forward
global type w_res_asiento_depositos from window
end type
type dw_2 from datawindow within w_res_asiento_depositos
end type
type st_4 from statictext within w_res_asiento_depositos
end type
type rb_2 from radiobutton within w_res_asiento_depositos
end type
type rb_1 from radiobutton within w_res_asiento_depositos
end type
type dw_1 from datawindow within w_res_asiento_depositos
end type
type st_3 from statictext within w_res_asiento_depositos
end type
type em_1 from editmask within w_res_asiento_depositos
end type
type st_2 from statictext within w_res_asiento_depositos
end type
type st_1 from statictext within w_res_asiento_depositos
end type
type pb_2 from picturebutton within w_res_asiento_depositos
end type
type pb_1 from picturebutton within w_res_asiento_depositos
end type
end forward

global type w_res_asiento_depositos from window
integer width = 2208
integer height = 1660
boolean titlebar = true
string title = "Dep$$HEX1$$f300$$ENDHEX$$sitos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
dw_2 dw_2
st_4 st_4
rb_2 rb_2
rb_1 rb_1
dw_1 dw_1
st_3 st_3
em_1 em_1
st_2 st_2
st_1 st_1
pb_2 pb_2
pb_1 pb_1
end type
global w_res_asiento_depositos w_res_asiento_depositos

type variables
datastore ids_nros
end variables

on w_res_asiento_depositos.create
this.dw_2=create dw_2
this.st_4=create st_4
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_1=create dw_1
this.st_3=create st_3
this.em_1=create em_1
this.st_2=create st_2
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={this.dw_2,&
this.st_4,&
this.rb_2,&
this.rb_1,&
this.dw_1,&
this.st_3,&
this.em_1,&
this.st_2,&
this.st_1,&
this.pb_2,&
this.pb_1}
end on

on w_res_asiento_depositos.destroy
destroy(this.dw_2)
destroy(this.st_4)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event open;datawindowchild dwc_cencos

dw_1.getchild("cs_codigo",dwc_cencos)
dwc_cencos.SetTransObject(sqlca)
dwc_cencos.Retrieve(str_appgeninfo.empresa)



end event

type dw_2 from datawindow within w_res_asiento_depositos
boolean visible = false
integer x = 37
integer y = 728
integer width = 2107
integer height = 812
integer taborder = 20
boolean titlebar = true
string title = "none"
string dataobject = "d_det_comprobante_automatico"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_res_asiento_depositos
integer x = 27
integer y = 332
integer width = 384
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Asiento Contable"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_res_asiento_depositos
integer x = 398
integer y = 228
integer width = 183
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "N/C"
end type

event clicked;em_1.triggerevent(modified!)
end event

type rb_1 from radiobutton within w_res_asiento_depositos
integer x = 27
integer y = 232
integer width = 325
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Dep$$HEX1$$f300$$ENDHEX$$sitos"
boolean checked = true
end type

event clicked;em_1.triggerevent(modified!)
end event

type dw_1 from datawindow within w_res_asiento_depositos
integer x = 23
integer y = 400
integer width = 2139
integer height = 1128
integer taborder = 10
string title = "Ingresos"
string dataobject = "d_asiento_depositos"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_res_asiento_depositos
integer x = 1175
integer y = 140
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

type em_1 from editmask within w_res_asiento_depositos
integer x = 841
integer y = 128
integer width = 320
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

event modified;/*Modificado para trabajar con sucursales en l$$HEX1$$ed00$$ENDHEX$$nea
  El secuencial de los comprobantes es por empresa
  Se recupera todos los ingresos de bancos de toda la empresa*/

Date ld_fecha
Long ll_nreg
String ls_tipo /*Para distinguir dep$$HEX1$$f300$$ENDHEX$$sitos de N/C... 
                           'N' = dep$$HEX1$$f300$$ENDHEX$$sito
					            'S' = N/C */


ld_fecha = date(em_1.text)
if rb_1.checked then   ls_tipo = 'N'
if rb_2.checked then   ls_tipo = 'S'

dw_1.SetTransObject(SQLCA)
ll_nreg = dw_1.Retrieve(ld_fecha,str_appgeninfo.empresa,ls_tipo)
//ll_nreg = dw_1.Retrieve(ld_fecha,str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo)

If ll_nreg = 0 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones $$HEX2$$f3002000$$ENDHEX$$ya fuer$$HEX1$$f300$$ENDHEX$$n contabilizados")
Return
End if	

/*Recuperar los nros de comprobante por empresa*/
ids_nros = Create DataStore
ids_nros.DataObject = "d_nros_ingresos"
ids_nros.SetTransObject(sqlca)
ids_nros.retrieve(ld_fecha,str_appgeninfo.empresa,ls_tipo)
//ids_nros.retrieve(ld_fecha,str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo)

end event

type st_2 from statictext within w_res_asiento_depositos
integer x = 27
integer y = 144
integer width = 777
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingrese la fecha de los dep$$HEX1$$f300$$ENDHEX$$sitos:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_res_asiento_depositos
integer x = 27
integer y = 44
integer width = 1358
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Este proceso contabilizar$$HEX2$$e1002000$$ENDHEX$$los Dep$$HEX1$$f300$$ENDHEX$$sitos del D$$HEX1$$ed00$$ENDHEX$$a"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_res_asiento_depositos
integer x = 1797
integer y = 28
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

type pb_1 from picturebutton within w_res_asiento_depositos
integer x = 1568
integer y = 32
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;/*Modificado para trabajar con sucursales en l$$HEX1$$ed00$$ENDHEX$$nea*/

long        ll_nreg,i,ll_find
Date        ld_fecha
Decimal {2} lc_sum_creditos
String      ls_signo,ls_nro,ls_tipo
Datawindowchild dwc_cencos
DataStore   lds_reporte



If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de que desea procesar ?",question!,YesNO!,2) = 2 &
Then
Return
End if 


/*Validar condiciones para el proceso*/
If isnull(em_1.text) or em_1.text ="" Then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las condiciones para procesar son incorrectas o est$$HEX1$$e100$$ENDHEX$$n incompletas")
Return
End if
ld_fecha = date(em_1.text)

if rb_1.checked then   ls_tipo = 'N'
if rb_2.checked then   ls_tipo = 'S'

w_marco.SetMicrohelp("Procesando el Asiento...!")
/*Recuperar datos para Generar los Asientos*/
lds_reporte = Create DataStore
lds_reporte.DataObject = 'd_asiento_depositos'
lds_reporte.SetTransObject(SQLCA)

lds_reporte.Getchild("cs_codigo",dwc_cencos)
dwc_cencos.SetTransObject(sqlca)
dwc_cencos.retrieve(str_appgeninfo.empresa)

/*Recupera todos los depositos por empresa*/
ll_nreg = lds_reporte.Retrieve(ld_fecha,str_appgeninfo.empresa,ls_tipo)
//ll_nreg = lds_reporte.Retrieve(ld_fecha,str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo)

If ll_nreg = 0 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Datos para Procesar ",Exclamation!)
Return
End if

If  f_asiento_automatico2(lds_reporte,ld_fecha,'DIN') < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Fall$$HEX2$$f3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del asiento de los dep$$HEX1$$f300$$ENDHEX$$sitos bancarios. ")
return 
end if 

/*Actualizar los comprobantes de ingreso*/
for i = 1 to ids_nros.Rowcount()
	ls_nro = ids_nros.GetItemString(i,"nro")
	update cb_ingreso
	set ig_contab = 'S'
	where ig_numero = :ls_nro
	and em_codigo = :str_appgeninfo.empresa
	and nvl(ig_nc,'N') = :ls_tipo;
	
	If sqlca.sqlcode < 0&
	Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Fall$$HEX2$$f3002000$$ENDHEX$$la contabilizaci$$HEX1$$f300$$ENDHEX$$n de los dep$$HEX1$$f300$$ENDHEX$$sitos bancarios. ")
	Rollback;
     return 
	End if
next

COMMIT;
/**/


Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso completado con $$HEX1$$e900$$ENDHEX$$xito",Exclamation!)
w_marco.SetMicrohelp("Listo...!")

end event


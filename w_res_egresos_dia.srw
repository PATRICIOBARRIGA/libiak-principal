HA$PBExportHeader$w_res_egresos_dia.srw
$PBExportComments$Si. Contabiliza los egresos realizados en Caja/Bancos.Vale
forward
global type w_res_egresos_dia from window
end type
type st_4 from statictext within w_res_egresos_dia
end type
type rb_2 from radiobutton within w_res_egresos_dia
end type
type rb_1 from radiobutton within w_res_egresos_dia
end type
type dw_1 from datawindow within w_res_egresos_dia
end type
type st_3 from statictext within w_res_egresos_dia
end type
type em_1 from editmask within w_res_egresos_dia
end type
type st_2 from statictext within w_res_egresos_dia
end type
type st_1 from statictext within w_res_egresos_dia
end type
type pb_2 from picturebutton within w_res_egresos_dia
end type
type pb_1 from picturebutton within w_res_egresos_dia
end type
end forward

global type w_res_egresos_dia from window
integer width = 2203
integer height = 1516
boolean titlebar = true
string title = "Egresos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
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
global w_res_egresos_dia w_res_egresos_dia

type variables
datastore ids_nros
end variables

on w_res_egresos_dia.create
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
this.Control[]={this.st_4,&
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

on w_res_egresos_dia.destroy
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

dw_1.Getchild("cs_codigo",dwc_cencos)
dwc_cencos.SetTransObject(sqlca)
dwc_cencos.retrieve(str_appgeninfo.empresa)


end event

type st_4 from statictext within w_res_egresos_dia
integer x = 50
integer y = 320
integer width = 393
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Asiento contable"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_res_egresos_dia
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
string text = "N/D"
borderstyle borderstyle = stylelowered!
end type

event clicked;em_1.triggerevent(modified!)
end event

type rb_1 from radiobutton within w_res_egresos_dia
integer x = 50
integer y = 228
integer width = 325
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Egresos"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;em_1.triggerevent(modified!)
end event

type dw_1 from datawindow within w_res_egresos_dia
integer x = 50
integer y = 392
integer width = 2098
integer height = 996
integer taborder = 10
string title = "Egresos"
string dataobject = "d_asiento_egresos"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_res_egresos_dia
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

type em_1 from editmask within w_res_egresos_dia
integer x = 827
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
boolean autoskip = true
end type

event modified;Date ld_fecha
Long ll_nreg
String ls_tipo /*Para distinguir egresos de N/D... 
                 'N' = egresos
					  'S' = N/D */


ld_fecha = date(em_1.text)
if rb_1.checked then   ls_tipo = 'N'
if rb_2.checked then   ls_tipo = 'S'

dw_1.SetTransObject(SQLCA)
ll_nreg = dw_1.Retrieve(ld_fecha,str_appgeninfo.empresa,ls_tipo)

If ll_nreg = 0 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones $$HEX2$$f3002000$$ENDHEX$$ya fuer$$HEX1$$f300$$ENDHEX$$n contabilizados")
Return
End if	


/*Recuperar los nros de comprobante*/
ids_nros = Create DataStore
ids_nros.DataObject = "d_nros_egresos"
ids_nros.SetTransObject(sqlca)
ids_nros.retrieve(ld_fecha,str_appgeninfo.empresa,ls_tipo)

end event

type st_2 from statictext within w_res_egresos_dia
integer x = 50
integer y = 140
integer width = 736
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingrese la fecha de los egresos:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_res_egresos_dia
integer x = 50
integer y = 44
integer width = 1198
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Este proceso contabilizar$$HEX2$$e1002000$$ENDHEX$$los Egresos del d$$HEX1$$ed00$$ENDHEX$$a"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_res_egresos_dia
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

type pb_1 from picturebutton within w_res_egresos_dia
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
DataWindowChild dwc_cencos
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
lds_reporte.DataObject = 'd_asiento_egresos'
lds_reporte.SetTransObject(SQLCA)


lds_reporte.Getchild("cs_codigo",dwc_cencos)
dwc_cencos.SetTransObject(sqlca)
dwc_cencos.retrieve(str_appgeninfo.empresa)


//ll_nreg = lds_reporte.Retrieve(ld_fecha,str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo)
ll_nreg = lds_reporte.Retrieve(ld_fecha,str_appgeninfo.empresa,ls_tipo)
If ll_nreg = 0 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Datos para Procesar ",Exclamation!)
Return
End if


If  f_asiento_automatico2(lds_reporte,ld_fecha,'DEG') < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Fall$$HEX2$$f3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del asiento de egresos bancarios. ")
return 
end if 

/*Actualizar los comprobantes de ingreso*/
for i = 1 to ids_nros.Rowcount()
	ls_nro = ids_nros.GetItemString(i,"nro")
	update cb_egreso
	set eg_contab = 'S'
	where eg_numero = :ls_nro
	and em_codigo = :str_appgeninfo.empresa
	and nvl(eg_nd,'N')= :ls_tipo;
	
	If sqlca.sqlcode < 0&
	Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Fall$$HEX2$$f3002000$$ENDHEX$$la contabilizaci$$HEX1$$f300$$ENDHEX$$n de los egresos bancarios. ")
	Rollback;
   return 
	End if
next

/**/


Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso completado con $$HEX1$$e900$$ENDHEX$$xito",Exclamation!)
w_marco.SetMicrohelp("Listo...!")

end event


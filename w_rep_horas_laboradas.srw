HA$PBExportHeader$w_rep_horas_laboradas.srw
$PBExportComments$Si.
forward
global type w_rep_horas_laboradas from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_horas_laboradas
end type
type em_1 from editmask within w_rep_horas_laboradas
end type
type st_1 from statictext within w_rep_horas_laboradas
end type
type rb_1 from radiobutton within w_rep_horas_laboradas
end type
type rb_2 from radiobutton within w_rep_horas_laboradas
end type
type dw_2 from datawindow within w_rep_horas_laboradas
end type
type st_2 from statictext within w_rep_horas_laboradas
end type
type em_2 from editmask within w_rep_horas_laboradas
end type
type rb_3 from radiobutton within w_rep_horas_laboradas
end type
end forward

global type w_rep_horas_laboradas from w_sheet_1_dw_rep
integer width = 3927
integer height = 1912
string title = "Horas Laboradas"
long backcolor = 81324524
boolean ib_notautoretrieve = true
dw_1 dw_1
em_1 em_1
st_1 st_1
rb_1 rb_1
rb_2 rb_2
dw_2 dw_2
st_2 st_2
em_2 em_2
rb_3 rb_3
end type
global w_rep_horas_laboradas w_rep_horas_laboradas

type variables
date id_fecini,id_fecfin
end variables

on w_rep_horas_laboradas.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.em_1=create em_1
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_2=create dw_2
this.st_2=create st_2
this.em_2=create em_2
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.em_2
this.Control[iCurrent+9]=this.rb_3
end on

on w_rep_horas_laboradas.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.em_2)
destroy(this.rb_3)
end on

event resize;/*Redimensiona los objetos que se encuentran dentro de la ventana 
  cuando la ventana cambia de dimensiones*/
  
int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)

dw_1.resize(dw_1.width,li_height - 400)
dw_datos.resize(li_width - dw_1.width - 30, li_height - 60) 

this.setRedraw(True)
return 1
end event

event open;call super::open;date ld_fecini,ld_fecfin
datetime ldt_hoy

ldt_hoy = f_hoy()
/*Permite la conexion de los datawindows */
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.retrieve(str_appgeninfo.empresa)
f_recupera_empresa(dw_2,"sucursal")
dw_2.insertrow(0)

em_1.text = string(ldt_hoy,'DD/MM/YYYY')
em_2.text = string(ldt_hoy,'DD/MM/YYYY')
ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)
em_1.setfocus()
end event

event ue_retrieve;/*Dependiendo de la opcion seleccionada por el usuario
  se recupera el reporte resumido o detallado
  ,En este caso la opcion RESUMIDO se recupera pulsando la opcion RECUPERAR FILAS
  desde el menu principal*/
date ld_fecini,ld_fecfin  
  
if rb_2.checked then
	dw_datos.dataobject = 'd_rep_horas_trabajadas'
	dw_datos.settransobject(sqlca)
	ld_fecini = date(em_1.text)
	ld_fecfin = date(em_2.text)
	if ld_fecini > ld_fecfin or isnull(ld_fecini) then
			messageBox("Error","Rango de Fechas Incorrecto")
			dw_datos.SetRedraw(True)
			SetPointer(Arrow!)
			return
	end if
	
	dw_datos.retrieve(str_appgeninfo.empresa,ld_fecini,ld_fecfin)
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"'" +&
						"datawindow.print.preview.zoom=100~t" + "datawindow.print.preview=yes")
end if

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_horas_laboradas
integer x = 1403
integer width = 2478
integer height = 1812
integer taborder = 0
string dataobject = "d_rep_horas_trabajadas_x_empleado"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("datawindow.print.preview.zoom=100~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_horas_laboradas
integer y = 16
integer width = 160
integer height = 164
integer taborder = 0
end type

type dw_1 from datawindow within w_rep_horas_laboradas
integer x = 14
integer y = 288
integer width = 1358
integer height = 1508
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_nomina_empleados"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;/*Recuperar la informaci$$HEX1$$f300$$ENDHEX$$n de c/empleado*/
String ls_epcodigo

This.accepttext()
if rb_1.checked then
ls_epcodigo = this.getitemstring(currentrow,"ep_codigo")
dw_datos.retrieve(str_appgeninfo.empresa,ls_epcodigo,id_fecini,id_fecfin)
end if
end event

type em_1 from editmask within w_rep_horas_laboradas
integer x = 206
integer y = 36
integer width = 315
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
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

event modified;id_fecini = date(em_1.text)
id_fecfin = date(em_2.text)


end event

type st_1 from statictext within w_rep_horas_laboradas
integer x = 41
integer y = 40
integer width = 160
integer height = 68
boolean bringtotop = true
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

type rb_1 from radiobutton within w_rep_horas_laboradas
integer x = 1047
integer y = 40
integer width = 302
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detallado"
end type

event clicked;/* Dependiendo de la opcion seleccionada por el usuario
   se recupera el reporte resumido o detallado ,
	En este caso DETALLADO*/
String ls_epcodigo

if rb_1.checked then
	dw_datos.setredraw(false)
	em_2.visible = true
	st_2.visible = true
	dw_datos.dataobject = 'd_rep_horas_trabajadas_x_empleado'
	dw_datos.settransobject(sqlca)
	if dw_1.getrow() < 1 then return
   ls_epcodigo = dw_1.getitemstring(dw_1.getrow(),"ep_codigo")
	if id_fecini > id_fecfin or isnull(id_fecini) then
		messageBox("Error","Rango de Fechas Incorrecto")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
	end if
   dw_datos.retrieve(str_appgeninfo.empresa,ls_epcodigo,id_fecini,id_fecfin)
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"'" +&
						"datawindow.print.preview.zoom=100~t" + "datawindow.print.preview=yes")
	dw_datos.setredraw(true)						
	dw_2.enabled = true
end if
end event

type rb_2 from radiobutton within w_rep_horas_laboradas
integer x = 1047
integer y = 120
integer width = 302
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumido"
boolean checked = true
end type

event clicked;/*Dependiendo de la opcion seleccionada por el usuario
  se recupera el reporte resumido o detallado
  ,En este caso se ha seleccionado RESUMIDO */

if rb_2.checked then
	dw_datos.setredraw(false)
	em_2.visible = true
	st_2.visible = true
	dw_datos.dataobject = 'd_rep_horas_trabajadas'
	dw_datos.settransobject(sqlca)
	if id_fecini > id_fecfin or isnull(id_fecini) then
		messageBox("Error","Rango de Fechas Incorrecto")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
	end if
   dw_datos.retrieve(str_appgeninfo.empresa,id_fecini,id_fecfin)
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"'" +&
						"datawindow.print.preview.zoom=100~t" + "datawindow.print.preview=yes")
	dw_datos.setredraw(true)						
	dw_2.enabled = false
end if
end event

type dw_2 from datawindow within w_rep_horas_laboradas
integer y = 172
integer width = 997
integer height = 100
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_sel_sucursal"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if isnull(data) then
	dw_1.setfilter("")
	dw_1.filter()
else
	dw_1.SetFilter("su_codigo = '"+string(data)+"'")
	dw_1.Filter()
end if
rb_1.triggerevent("clicked")
end event

type st_2 from statictext within w_rep_horas_laboradas
integer x = 544
integer y = 40
integer width = 137
integer height = 68
boolean bringtotop = true
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

type em_2 from editmask within w_rep_horas_laboradas
integer x = 690
integer y = 36
integer width = 325
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
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

event modified;id_fecini = date(em_1.text)
id_fecfin = date(em_2.text)


end event

type rb_3 from radiobutton within w_rep_horas_laboradas
integer x = 1047
integer y = 200
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "H. Almuerzo"
end type

event clicked;/* Se recupera el reporte de hora de almuerzo, es el tiempo que se toma
el empleado para el almuerzo*/

String ls_epcodigo

if rb_3.checked then
	dw_datos.setredraw(false)
	em_2.visible = false
	st_2.visible = false
	dw_datos.dataobject = 'd_rep_hora_almuerzo'
	dw_datos.settransobject(sqlca)
	if dw_1.getrow() < 1 then return
   dw_datos.retrieve(str_appgeninfo.empresa,id_fecini)
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"'" +&
						"datawindow.print.preview.zoom=100~t" + "datawindow.print.preview=yes")
	dw_datos.setredraw(true)						
	
	dw_2.enabled = false
end if
end event


HA$PBExportHeader$w_control_asistencia.srw
$PBExportComments$Si.
forward
global type w_control_asistencia from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_control_asistencia
end type
type em_fecini from editmask within w_control_asistencia
end type
type em_fecfin from editmask within w_control_asistencia
end type
type st_1 from statictext within w_control_asistencia
end type
type st_2 from statictext within w_control_asistencia
end type
type em_feriado from editmask within w_control_asistencia
end type
type st_3 from statictext within w_control_asistencia
end type
type cb_2 from commandbutton within w_control_asistencia
end type
type dw_2 from datawindow within w_control_asistencia
end type
type cb_3 from commandbutton within w_control_asistencia
end type
type cb_1 from commandbutton within w_control_asistencia
end type
end forward

global type w_control_asistencia from w_sheet_1_dw_maint
integer width = 3954
integer height = 1852
string title = "Control de Asistencia"
long backcolor = 81324524
dw_1 dw_1
em_fecini em_fecini
em_fecfin em_fecfin
st_1 st_1
st_2 st_2
em_feriado em_feriado
st_3 st_3
cb_2 cb_2
dw_2 dw_2
cb_3 cb_3
cb_1 cb_1
end type
global w_control_asistencia w_control_asistencia

type variables
string  is_mes,is_epcodigo


end variables

on w_control_asistencia.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.em_fecini=create em_fecini
this.em_fecfin=create em_fecfin
this.st_1=create st_1
this.st_2=create st_2
this.em_feriado=create em_feriado
this.st_3=create st_3
this.cb_2=create cb_2
this.dw_2=create dw_2
this.cb_3=create cb_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.em_fecini
this.Control[iCurrent+3]=this.em_fecfin
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_feriado
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.cb_3
this.Control[iCurrent+11]=this.cb_1
end on

on w_control_asistencia.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.em_fecini)
destroy(this.em_fecfin)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_feriado)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;Time lt_now
date ld_fecini,ld_fecfin
datetime ldt_hoy


ldt_hoy = f_hoy()
em_fecini.text = string(ldt_hoy,'DD/MM/YYYY')
em_fecfin.text = string(ldt_hoy,'DD/MM/YYYY')
em_feriado.text = string(ldt_hoy,'DD/MM/YYYY')
ld_fecini = date(em_fecini.text)
ld_fecfin = date(em_fecfin.text)

dw_datos.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_1.retrieve(str_appgeninfo.empresa)
f_recupera_empresa(dw_2,"sucursal")
dw_2.insertrow(0)

this.ib_notautoretrieve = true
call super::open
end event

event resize;/*Redimensiona los objetos que se encuentran dentro de la ventana 
  cuando la ventana cambia de dimensiones*/
  
int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)

//dw_1.resize(dw_1.width,li_height - 400)
dw_datos.resize(li_width - dw_1.width - 30, li_height - 60) 

this.setRedraw(True)
return 1

end event

event ue_retrieve;string ls_codigo
date ld_fecini,ld_fecfin
ld_fecini = date(em_fecini.text)
ld_fecfin = date(em_fecfin.text)
if dw_1.getrow() < 1 then return
ls_codigo = dw_1.getitemstring(dw_1.getrow(),"ep_codigo")
dw_datos.retrieve(str_appgeninfo.empresa,ls_codigo,ld_fecini,ld_fecfin)
end event

event ue_insert;call super::ue_insert;string ls_codigo,ls_terminal
datetime ldt_hoy
date ld_hoy
int  li_nreg


select sysdate,userenv('TERMINAL')
into :ldt_hoy,:ls_terminal
from dual;

ld_hoy = date(ldt_hoy)

li_nreg = dw_datos.getrow()
ls_codigo = dw_1.getitemstring(dw_1.getrow(),"ep_codigo")
dw_datos.setitem(li_nreg,"em_codigo",str_appgeninfo.empresa)
dw_datos.setitem(li_nreg,"ep_codigo",ls_codigo)
dw_datos.setitem(li_nreg,"as_fecha",ld_hoy)
dw_datos.setitem(li_nreg,"as_terminal",ls_terminal)
dw_datos.setitem(li_nreg,"as_incal",ldt_hoy)
dw_datos.setitem(li_nreg,"as_out1cal",ldt_hoy)
dw_datos.setitem(li_nreg,"as_in1cal",ldt_hoy)
dw_datos.setitem(li_nreg,"as_in1",ldt_hoy)
dw_datos.setitem(li_nreg,"as_outcal",ldt_hoy)

If str_appgeninfo.empresa = '1' and (str_appgeninfo.sucursal = '1' &
	or str_appgeninfo.sucursal = '14' or str_appgeninfo.sucursal = '24') Then
	dw_datos.setitem(li_nreg,"as_lunch",'S')
else
	dw_datos.setitem(li_nreg,"as_lunch",'N')
End if


end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_control_asistencia
integer x = 1129
integer y = 160
integer width = 2779
integer height = 1548
integer taborder = 70
string dataobject = "d_control_asistencia"
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_datos::itemchanged;datetime ldt_in1

accepttext()
if dwo.name = "as_in1cal" then
	ldt_in1 = dw_datos.getitemdatetime(row,"as_in1cal")
	dw_datos.setitem(row,"as_in1",ldt_in1)
end if



end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_control_asistencia
integer x = 9
integer y = 12
integer width = 114
integer height = 60
integer taborder = 0
boolean hscrollbar = false
boolean border = false
end type

type dw_1 from datawindow within w_control_asistencia
event ue_tabout pbm_dwntabout
integer x = 18
integer y = 304
integer width = 1097
integer height = 1404
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_nomina_empleados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;string ls_codigo
long ll_nreg,ll_row
date ld_fecini,ld_fecfin


ll_row = this.Getrow()
ls_codigo = this.getitemstring(ll_row,"ep_codigo")
ld_fecini = date(em_fecini.text)
ld_fecfin = date(em_fecfin.text)
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,ls_codigo,ld_fecini,ld_fecfin)

end event

event itemchanged;string ls_codigo

ls_codigo = this.getitemstring(row,"ep_codigo",primary!,false)
If ls_codigo <> data Then
	this.setitem(row,"ep_codigo",ls_codigo)
	return 1
End if

end event

event itemerror;messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No puede cambiar el c$$HEX1$$f300$$ENDHEX$$digo de empledo")
return 1
end event

type em_fecini from editmask within w_control_asistencia
integer x = 224
integer y = 76
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

type em_fecfin from editmask within w_control_asistencia
integer x = 704
integer y = 76
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

type st_1 from statictext within w_control_asistencia
integer x = 50
integer y = 84
integer width = 155
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

type st_2 from statictext within w_control_asistencia
integer x = 558
integer y = 84
integer width = 146
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

type em_feriado from editmask within w_control_asistencia
integer x = 1445
integer y = 36
integer width = 315
integer height = 80
integer taborder = 30
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

type st_3 from statictext within w_control_asistencia
integer x = 1157
integer y = 44
integer width = 261
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
string text = "D$$HEX1$$ed00$$ENDHEX$$a Feriado:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_control_asistencia
integer x = 1806
integer y = 32
integer width = 357
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar d$$HEX1$$ed00$$ENDHEX$$a"
end type

event clicked;long ll_i
date ld_feriado,ld_hoy
string ls_sucur,ls_epcodigo

//select trunc(sysdate)
//into: ld_hoy
//from dual;

ld_feriado = date(em_feriado.text)
//if ld_feriado < ld_hoy then
//	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha debe ser igual o mayor a la actual")
//	return
//end if

If messagebox("Confirme","Esta seguro que desea hacer este d$$HEX1$$ed00$$ENDHEX$$a feriado",Question!,yesno!,2) = 2 then return
setpointer(hourglass!)
w_marco.setmicrohelp("Procesando...espere")

ls_sucur = dw_2.getitemstring(1,"sucursal")
if isnull(ls_sucur) then
	update no_asistencia
	set as_feriado = 'S'
	where em_codigo = :str_appgeninfo.empresa
	and as_fecha = :ld_feriado;
	if sqlca.sqlcode <> 0 Then
		rollback;
		messagebox("Error","Problemas al actualizar el d$$HEX1$$ed00$$ENDHEX$$a feriado...<comunicar a sistemas>",stopsign!)
		return
	end if
	commit;
else
	for ll_i = 1 to dw_1.rowcount()
		ls_epcodigo = dw_1.getitemstring(ll_i,"ep_codigo")
		update no_asistencia
		set as_feriado = 'S'
		where em_codigo = :str_appgeninfo.empresa
		and ep_codigo  = :ls_epcodigo
		and as_fecha = :ld_feriado;
	
		if sqlca.sqlcode <> 0 Then
			rollback;
			messagebox("Error","Problemas al actualizar el d$$HEX1$$ed00$$ENDHEX$$a feriado...<Favor comunicar a sistemas>",stopsign!)
			return
		end if
	next
	commit;
end if
parent.triggerevent("ue_retrieve")
w_marco.setmicrohelp("Listo")
setpointer(arrow!)
end event

type dw_2 from datawindow within w_control_asistencia
integer y = 184
integer width = 1010
integer height = 104
integer taborder = 50
boolean bringtotop = true
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
parent.triggerevent("ue_retrieve")
end event

type cb_3 from commandbutton within w_control_asistencia
integer x = 2235
integer y = 32
integer width = 357
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Rechazar d$$HEX1$$ed00$$ENDHEX$$a"
end type

event clicked;long ll_i
date ld_feriado,ld_hoy
string ls_sucur,ls_epcodigo

select trunc(sysdate)
into: ld_hoy
from dual;

ld_feriado = date(em_feriado.text)

if ld_feriado < ld_hoy then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha debe ser igual o mayor a la actual")
	return
end if

If messagebox("Confirme","Esta seguro que desea hacer este d$$HEX1$$ed00$$ENDHEX$$a No feriado",Question!,yesno!,2) = 2 then return
setpointer(hourglass!)
w_marco.setmicrohelp("Procesando...espere")

ls_sucur = dw_2.getitemstring(1,"sucursal")
if isnull(ls_sucur) then
	update no_asistencia
	set as_feriado = null
	where em_codigo = :str_appgeninfo.empresa
	and as_fecha = :ld_feriado;
	if sqlca.sqlcode <> 0 Then
		rollback;
		messagebox("Error","Problemas al actualizar el d$$HEX1$$ed00$$ENDHEX$$a feriado...<comunicar a sistemas>",stopsign!)
		return
	end if
	commit;
else
	for ll_i = 1 to dw_1.rowcount()
		ls_epcodigo = dw_1.getitemstring(ll_i,"ep_codigo")
		update no_asistencia
		set as_feriado = null
		where em_codigo = :str_appgeninfo.empresa
		and ep_codigo  = :ls_epcodigo
		and as_fecha = :ld_feriado;
	
		if sqlca.sqlcode <> 0 Then
			rollback;
			messagebox("Error","Problemas al actualizar el d$$HEX1$$ed00$$ENDHEX$$a feriado...<Favor comunicar a sistemas>",stopsign!)
			return
		end if
	next
	commit;
end if
parent.triggerevent("ue_retrieve")
w_marco.setmicrohelp("Listo")
setpointer(arrow!)
end event

type cb_1 from commandbutton within w_control_asistencia
boolean visible = false
integer x = 2679
integer y = 32
integer width = 393
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Hora de salida"
end type

event clicked;string ls_epcodigo
date ld_fecini,ld_fecfin
datetime ld_horsal

setpointer(hourglass!)
w_marco.SetMicroHelp('Precesando...por favor espere')
ld_fecini = date(em_fecini.text)
ld_fecfin = date(em_fecfin.text)

if ld_fecini > ld_fecfin or isnull(ld_fecini) then
		messageBox("Error","Rango de Fechas Incorrecto")
		SetPointer(Arrow!)
		return
end if

declare hora_salida cursor for

select distinct e.ep_codigo,ep_horsal
from no_emple e,no_asistencia a
where e.ep_codigo = a.ep_codigo
and e.em_codigo = a.em_codigo
and a.em_codigo = :str_appgeninfo.empresa
and a.as_fecha between :ld_fecini and :ld_fecfin
and a.as_outcal is null
and e.cr_codigo not in ('2','23','67','74')
order by to_number(e.ep_codigo);

open hora_salida;
do
	fetch hora_salida into :ls_epcodigo,:ld_horsal;
	if sqlca.sqlcode <> 0 then exit

	update no_asistencia
	set as_out1cal = :ld_horsal,
		as_in1cal = :ld_horsal,
		as_outcal = :ld_horsal
	where em_codigo = :str_appgeninfo.empresa	
	and ep_codigo = :ls_epcodigo
	and as_outcal is null
	and as_fecha between :ld_fecini and :ld_fecfin;
	if sqlca.sqlcode < 0 then
		rollback;
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la hora de salida "+sqlca.sqlerrtext)
		return
	end if

	
loop while true
close hora_salida;
commit;
w_marco.SetMicroHelp('Listo, fin del proceso')
setpointer(arrow!)


end event


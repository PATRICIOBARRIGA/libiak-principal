HA$PBExportHeader$w_asistencia.srw
$PBExportComments$Si.
forward
global type w_asistencia from w_sheet_1_dw_maint
end type
type cb_1 from commandbutton within w_asistencia
end type
type cb_2 from commandbutton within w_asistencia
end type
type cb_3 from commandbutton within w_asistencia
end type
type cb_4 from commandbutton within w_asistencia
end type
type st_time from statictext within w_asistencia
end type
type sle_1 from singlelineedit within w_asistencia
end type
type st_empleado from statictext within w_asistencia
end type
type cb_5 from commandbutton within w_asistencia
end type
type st_1 from statictext within w_asistencia
end type
type st_2 from statictext within w_asistencia
end type
type sle_2 from singlelineedit within w_asistencia
end type
type st_3 from statictext within w_asistencia
end type
type cb_6 from commandbutton within w_asistencia
end type
end forward

global type w_asistencia from w_sheet_1_dw_maint
integer width = 2441
integer height = 2044
string title = "Registro de Asistencia"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 81324524
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
st_time st_time
sle_1 sle_1
st_empleado st_empleado
cb_5 cb_5
st_1 st_1
st_2 st_2
sle_2 sle_2
st_3 st_3
cb_6 cb_6
end type
global w_asistencia w_asistencia

type variables
string  is_mes, is_hoy,is_epcodigo,is_nulo


end variables

on w_asistencia.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.st_time=create st_time
this.sle_1=create sle_1
this.st_empleado=create st_empleado
this.cb_5=create cb_5
this.st_1=create st_1
this.st_2=create st_2
this.sle_2=create sle_2
this.st_3=create st_3
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.st_time
this.Control[iCurrent+6]=this.sle_1
this.Control[iCurrent+7]=this.st_empleado
this.Control[iCurrent+8]=this.cb_5
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.sle_2
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.cb_6
end on

on w_asistencia.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.st_time)
destroy(this.sle_1)
destroy(this.st_empleado)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.st_3)
destroy(this.cb_6)
end on

event open;datetime ldt_fecyhora
Time  lt_now
this.move(400,310)

ldt_fecyhora = f_hoy()

lt_now  = time(ldt_fecyhora)
is_hoy = string(ldt_fecyhora,'dd/mm/yyyy')
is_mes  = string(ldt_fecyhora,'MMYYYY')
st_time.text = String(lt_now, "hh:mm:ss")
Timer(1)
this.ib_notautoretrieve = true
dw_datos.enabled = false
setnull(is_nulo)
call super::open
end event

event timer;call super::timer;Time  lt_now

lt_now  = time(f_hoy())
st_time.text = String(lt_now, "hh:mm:ss")
end event

event ue_update;return 1
end event

event resize;return 1

end event

event activate;return 1
end event

event close;return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_asistencia
integer x = 27
integer y = 492
integer width = 2350
integer height = 1444
integer taborder = 0
string dataobject = "d_asistencia"
boolean border = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_datos::rbuttondown;return 1
end event

event dw_datos::itemfocuschanged;return 1
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_asistencia
integer x = 14
integer y = 364
integer width = 178
integer height = 88
integer taborder = 0
end type

type cb_1 from commandbutton within w_asistencia
integer x = 261
integer y = 360
integer width = 370
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean enabled = false
string text = "&Entrada"
end type

event clicked;Long ll_new,li_pos
string ls_sucur
Datetime ldt_entrada,ldt_entcal
String ls_terminal,ls_nulo,ls_hora,ls_fecha





//integer li_FileNum
//string ls_Emp_Input

//Run("C:\huella\entrada1.exe")
//li_FileNum = FileOpen("C:\huella\registra.TXT", TextMode!)
//FileReadEx(li_FileNum, ls_Emp_Input)

//Obtener hora de asistencia
//Messagebox("",ls_Emp_input)

//li_pos  = LastPos(ls_Emp_input,",")
//ls_fecha = Mid(ls_Emp_input,li_pos+2,10 )
//ls_hora  = Mid(ls_Emp_input,li_pos+13,8)
//Messagebox("",ls_hora)

//DateTime ldt_InputDateTime
//date ld_InputDate
//time lt_InputTime
//
//ld_InputDate = Date(ls_fecha)
//lt_InputTime = Time(ls_hora)
//ldt_InputDateTime = DateTime( ld_InputDate, lt_InputTime)


select ep_horent,su_codigo, userenv('TERMINAL')
into:ldt_entcal,:ls_sucur,:ls_terminal
from no_emple
where ep_codigo = :is_epcodigo
and em_codigo = :str_appgeninfo.empresa;


ll_new = dw_datos.insertrow(1)	
dw_datos.setitem(ll_new,"em_codigo",str_appgeninfo.empresa)
dw_datos.setitem(ll_new,"ep_codigo",is_epcodigo)
ldt_entrada = f_hoy()
//ldt_entrada = ldt_InputDateTime

dw_datos.setitem(ll_new,"as_fecha",date(ldt_entrada))
dw_datos.setitem(ll_new,'as_in',ldt_entrada)
dw_datos.setitem(ll_new,'as_incal',ldt_entrada)
dw_datos.setitem(ll_new,'as_terminal',ls_terminal)
If str_appgeninfo.empresa = '1' and (ls_sucur = '1'or ls_sucur = '24') Then
	dw_datos.setitem(ll_new,'as_lunch','S')
else
	dw_datos.setitem(ll_new,'as_lunch','N')
End if

if dw_datos.update() < 0 then
	rollback;
	return
end if
commit;
cb_1.enabled = false
cb_2.enabled = true
dw_datos.setrow(ll_new)
dw_datos.setrowfocusindicator(hand!)
//sle_2.selecttext(1,4)
sle_2.text = is_nulo
sle_1.setfocus()
sle_1.selecttext(1,6)



end event

type cb_2 from commandbutton within w_asistencia
integer x = 786
integer y = 360
integer width = 384
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean enabled = false
string text = "Salida &Lunch"
end type

event clicked;Long ll_find
Datetime ldt_outlunch
String ls_terminal

select userenv('TERMINAL')
into :ls_terminal
from dual;

ll_find = dw_datos.getrow()
ldt_outlunch = f_hoy()
dw_datos.setitem(ll_find,"em_codigo",str_appgeninfo.empresa)
dw_datos.setitem(ll_find,"ep_codigo",is_epcodigo)
dw_datos.setitem(ll_find,'as_out1',ldt_outlunch)
dw_datos.setitem(ll_find,'as_out1cal',ldt_outlunch)		
dw_datos.setitem(ll_find,'as_terminal',ls_terminal)
if dw_datos.update() < 0 then
	rollback;
	return
end if
commit;

cb_2.enabled = false
cb_3.enabled = true
dw_datos.setrow(ll_find)
dw_datos.setrowfocusindicator(hand!)
//sle_2.selecttext(1,4)
sle_2.text = is_nulo
sle_1.setfocus()
sle_1.selecttext(1,6)


end event

type cb_3 from commandbutton within w_asistencia
integer x = 1326
integer y = 360
integer width = 430
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean enabled = false
string text = "Entra&da Lunch"
end type

event clicked;Long ll_find
Datetime ldt_outlunch,ldt_inlunch
time hora
date ld_fecha
String ls_terminal

select userenv('TERMINAL')
into :ls_terminal
from dual;

//ld_fecha =  date(String(Today(),"dd/mm/yyyy"))
//hora = time(String(now(),"hh:mm:ss"))
//ldt_inlunch = datetime(ld_fecha,hora)

ldt_inlunch = f_hoy()
ll_find = dw_datos.getrow()
ldt_outlunch = dw_datos.getitemdatetime(ll_find,'as_out1cal')
ld_fecha = date(ldt_outlunch)
hora = time(ldt_outlunch)
hora = relativetime(hora,3600)
ldt_outlunch = datetime(ld_fecha,hora)
dw_datos.setitem(ll_find,"em_codigo",str_appgeninfo.empresa)
dw_datos.setitem(ll_find,"ep_codigo",is_epcodigo)
dw_datos.setitem(ll_find,'as_in1',ldt_inlunch)
dw_datos.setitem(ll_find,'as_in1cal',ldt_outlunch)		
dw_datos.setitem(ll_find,'as_terminal',ls_terminal)

if dw_datos.update() < 0 then
	rollback;
	return
end if
commit;

cb_3.enabled = false
cb_4.enabled = true
dw_datos.setrow(ll_find)
dw_datos.setrowfocusindicator(hand!)
sle_2.text = is_nulo
sle_1.setfocus()
sle_1.selecttext(1,6)




end event

type cb_4 from commandbutton within w_asistencia
integer x = 1911
integer y = 360
integer width = 370
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean enabled = false
string text = "&Salida"
end type

event clicked;Long ll_find
Datetime ldt_salcal
String ls_terminal


select ep_horsal,userenv('TERMINAL')
into:ldt_salcal,:ls_terminal
from no_emple
where ep_codigo = :is_epcodigo
and em_codigo = :str_appgeninfo.empresa;

ll_find = dw_datos.getrow()
dw_datos.setitem(ll_find,"em_codigo",str_appgeninfo.empresa)
dw_datos.setitem(ll_find,"ep_codigo",is_epcodigo)
dw_datos.setitem(ll_find,'as_out',f_hoy())
dw_datos.setitem(ll_find,'as_outcal',f_hoy())		
dw_datos.setitem(ll_find,'as_terminal',ls_terminal)
if dw_datos.update() < 0 then
	rollback;
	return
end if
commit;

cb_4.enabled = false
dw_datos.setrow(ll_find)
dw_datos.setrowfocusindicator(hand!)
sle_2.text = is_nulo
sle_1.setfocus()
sle_1.selecttext(1,6)

end event

type st_time from statictext within w_asistencia
integer x = 37
integer y = 16
integer width = 663
integer height = 144
boolean bringtotop = true
integer textsize = -28
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_asistencia
integer x = 1312
integer y = 20
integer width = 366
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = false
integer limit = 6
borderstyle borderstyle = stylelowered!
end type

event modified;sle_2.setfocus()
sle_2.text = is_nulo

end event

type st_empleado from statictext within w_asistencia
integer x = 352
integer y = 252
integer width = 1216
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_asistencia
integer x = 1797
integer y = 20
integer width = 448
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
string text = "&Cambiar clave"
end type

event clicked;open(w_cambiar_clave_nomina)
end event

type st_1 from statictext within w_asistencia
integer x = 55
integer y = 252
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Empleado:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_asistencia
integer x = 1079
integer y = 20
integer width = 224
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "C$$HEX1$$f300$$ENDHEX$$digo:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_asistencia
integer x = 1312
integer y = 112
integer width = 366
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

event modified;long ll_nreg,ll_find
String ls_data,ls_empleado
datetime ldt_fecin,ldt_fecout1,ldt_fecin1,ldt_fecout


//dw_datos.settransobject(sqlca)
dw_datos.reset()
ls_data = this.text
is_epcodigo = sle_1.text

select ep_apepat||' '||ep_apemat||' '||ep_nombre
into :ls_empleado
from no_emple
where em_codigo = :str_appgeninfo.empresa
and ep_codigo = :is_epcodigo
and ep_clavnom = :ls_data;
If sqlca.sqlcode =100 Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Clave de empleado no encontrada....intente de nuevo")
	return
End if

st_empleado.text = ls_empleado
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,is_epcodigo,is_mes)
ll_find  = dw_datos.find("string(as_fecha,'dd/mm/yyyy') ='"+is_hoy+"'" ,1,ll_nreg)

If ll_nreg < 1 or ll_find = 0 Then 
	cb_1.enabled  = true
	cb_2.enabled = false
	cb_3.enabled = false		
	cb_4.enabled = false
else
	ldt_fecin = dw_datos.getitemdatetime(ll_find,"as_in")
	ldt_fecout1 = dw_datos.getitemdatetime(ll_find,"as_out1")
	ldt_fecin1 = dw_datos.getitemdatetime(ll_find,"as_in1")
	ldt_fecout = dw_datos.getitemdatetime(ll_find,"as_out")

	IF not isnull(ldt_fecin)  THEN	
		cb_1.enabled = false
		cb_2.enabled = true
		cb_3.enabled = false		
		cb_4.enabled = false		
	End if
	If not isnull(ldt_fecout1)  THEN
		cb_2.enabled = false
		cb_3.enabled = true
	End if
	IF not isnull(ldt_fecin1) THEN
		cb_2.enabled = false
		cb_3.enabled = false		
		cb_4.enabled = true
	End if
	IF not isnull(ldt_fecout) THEN
		cb_4.enabled = false		
	END IF	

End if

end event

type st_3 from statictext within w_asistencia
integer x = 1079
integer y = 112
integer width = 183
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Clave:"
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_asistencia
boolean visible = false
integer x = 1792
integer y = 116
integer width = 466
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "none"
end type

event clicked;//Run("C:\huella\borrar\borrar.exe", Maximized!)
end event


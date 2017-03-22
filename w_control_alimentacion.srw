HA$PBExportHeader$w_control_alimentacion.srw
$PBExportComments$Si.
forward
global type w_control_alimentacion from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_control_alimentacion
end type
type st_2 from statictext within w_control_alimentacion
end type
type st_3 from statictext within w_control_alimentacion
end type
type dw_1 from datawindow within w_control_alimentacion
end type
end forward

global type w_control_alimentacion from w_sheet_1_dw_maint
integer width = 2848
integer height = 2092
string title = "Control de Alimentaci$$HEX1$$f300$$ENDHEX$$n"
long backcolor = 81324524
em_1 em_1
st_2 st_2
st_3 st_3
dw_1 dw_1
end type
global w_control_alimentacion w_control_alimentacion

type variables


end variables

on w_control_alimentacion.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_1
end on

on w_control_alimentacion.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
end on

event open;date ld_hoy

select trunc(sysdate)
into :ld_hoy
from dual;

em_1.text = string(ld_hoy,'DD/MM/YYYY')
dw_1.insertrow(0)
f_recupera_empresa(dw_1,"sucursal")
dw_datos.settransobject(sqlca)
dw_datos.retrieve(str_appgeninfo.empresa,ld_hoy)
ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;date ld_hoy
ld_hoy = date(em_1.text)
dw_datos.retrieve(str_appgeninfo.empresa,ld_hoy)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_control_alimentacion
integer x = 9
integer y = 156
integer width = 2766
integer height = 1816
integer taborder = 30
string dataobject = "d_control_alimentacion"
boolean border = true
boolean hsplitscroll = true
end type

event dw_datos::itemchanged;accepttext()


end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_control_alimentacion
integer x = 2501
integer y = 20
integer width = 146
integer height = 92
integer taborder = 0
boolean hscrollbar = false
boolean border = false
end type

type em_1 from editmask within w_control_alimentacion
integer x = 261
integer y = 28
integer width = 352
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_control_alimentacion
integer x = 78
integer y = 32
integer width = 146
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Fecha:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_control_alimentacion
integer x = 635
integer y = 36
integer width = 297
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "[dd/mm/aaaa]"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_control_alimentacion
integer x = 1115
integer y = 20
integer width = 1024
integer height = 96
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_sucursal"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_filtro

if isnull(data) then
	ls_filtro="(su_codigo like '%')"
else
	ls_filtro="su_codigo='"+data+"'"
end if
dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
end event


HA$PBExportHeader$w_um_retenciones.srw
$PBExportComments$Mantenimiento de retenciones
forward
global type w_um_retenciones from w_sheet_1_dw_maint
end type
type st_1 from statictext within w_um_retenciones
end type
end forward

global type w_um_retenciones from w_sheet_1_dw_maint
integer width = 5102
integer height = 2140
string title = "Mantenimiento de retenciones"
st_1 st_1
end type
global w_um_retenciones w_um_retenciones

on w_um_retenciones.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_um_retenciones.destroy
call super::destroy
destroy(this.st_1)
end on

event open;f_recupera_empresa(dw_datos,'pl_codigo')
f_recupera_empresa(dw_datos,'pl_codigo_1')
f_recupera_empresa(dw_datos,'fp_codigo')
call super::open
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_um_retenciones
integer x = 69
integer y = 116
integer width = 4919
integer height = 1864
string dataobject = "d_retenciones"
boolean border = true
end type

event dw_datos::updatestart;call super::updatestart;this.object.em_codigo[this.getrow()] = str_appgeninfo.empresa
return 0
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_um_retenciones
integer x = 73
integer y = 116
integer width = 4910
integer height = 1864
string dataobject = "d_retenciones"
end type

type st_1 from statictext within w_um_retenciones
integer x = 78
integer y = 28
integer width = 1166
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detalle de pagos y retenci$$HEX1$$f300$$ENDHEX$$n por impuesto a la Renta"
boolean focusrectangle = false
end type


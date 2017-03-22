HA$PBExportHeader$w_cancela_prestamos.srw
$PBExportComments$Si.
forward
global type w_cancela_prestamos from w_sheet_1_dw_maint
end type
type st_1 from statictext within w_cancela_prestamos
end type
end forward

global type w_cancela_prestamos from w_sheet_1_dw_maint
integer width = 2885
integer height = 1596
string title = "Mantenimiento Pr$$HEX1$$e900$$ENDHEX$$stamos"
long backcolor = 67108864
boolean ib_inreportmode = true
st_1 st_1
end type
global w_cancela_prestamos w_cancela_prestamos

on w_cancela_prestamos.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_cancela_prestamos.destroy
call super::destroy
destroy(this.st_1)
end on

event ue_saveas;int li_res

if this.ib_inReportMode then
		li_res = dw_datos.saveas()
end if
this.setRedraw(True)

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_cancela_prestamos
integer x = 9
integer y = 100
integer width = 2816
integer height = 1360
string dataobject = "d_cancela_cuotas"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_cancela_prestamos
integer y = 488
end type

type st_1 from statictext within w_cancela_prestamos
integer x = 50
integer y = 28
integer width = 567
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
string text = "Pr$$HEX1$$e900$$ENDHEX$$stamos por empleado:"
boolean focusrectangle = false
end type


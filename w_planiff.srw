HA$PBExportHeader$w_planiff.srw
forward
global type w_planiff from w_sheet_1_dw_maint
end type
type shl_1 from statichyperlink within w_planiff
end type
end forward

global type w_planiff from w_sheet_1_dw_maint
integer width = 4224
integer height = 1832
shl_1 shl_1
end type
global w_planiff w_planiff

on w_planiff.create
int iCurrent
call super::create
this.shl_1=create shl_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.shl_1
end on

on w_planiff.destroy
call super::destroy
destroy(this.shl_1)
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_planiff
integer x = 23
integer y = 108
integer width = 4073
integer height = 1596
string dataobject = "d_planiff"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_planiff
end type

type shl_1 from statichyperlink within w_planiff
integer x = 219
integer y = 12
integer width = 485
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Importar plan Niff"
boolean focusrectangle = false
end type


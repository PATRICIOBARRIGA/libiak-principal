HA$PBExportHeader$w_reporte_diario_general_fecha.srw
$PBExportComments$Si.
forward
global type w_reporte_diario_general_fecha from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_reporte_diario_general_fecha
end type
type rb_1 from radiobutton within w_reporte_diario_general_fecha
end type
type rb_2 from radiobutton within w_reporte_diario_general_fecha
end type
end forward

global type w_reporte_diario_general_fecha from w_sheet_1_dw_rep
integer x = 78
integer y = 228
integer width = 2798
integer height = 1672
string title = "Diario General por fecha"
long backcolor = 81324524
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
end type
global w_reporte_diario_general_fecha w_reporte_diario_general_fecha

on w_reporte_diario_general_fecha.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
end on

on w_reporte_diario_general_fecha.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event open;DataWindowChild   ldwc_aux

dw_1.InsertRow(0)
dw_1.GetChild("tipo_comp",ldwc_aux)
ldwc_aux.SetTransObject(sqlca)
ldwc_aux.Retrieve(str_appgeninfo.empresa)

ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;string  ls_tipo
date    li_fechaini, li_fechafin
long    ll_row

dw_1.AcceptText()
ll_row = dw_1.Getrow()

ls_tipo = dw_1.GetItemString(ll_row,"tipo_comp")
li_fechaini = dw_1.GetItemDate(ll_row,"fecha_ini")
li_fechafin = dw_1.GetItemDate(ll_row,"fecha_fin")

if rb_1.checked then
dw_datos.dataobject = 'd_reporte_diario_general_fecha'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ls_tipo,li_fechaini,li_fechafin,str_appgeninfo.empresa)
end if

if rb_2.checked then
dw_datos.dataobject = 'd_reporte_diario_general_fecha_x_suc'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ls_tipo,li_fechaini,li_fechafin,str_appgeninfo.empresa,str_appgeninfo.sucursal)
end if

end event

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 300)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_reporte_diario_general_fecha
integer x = 5
integer y = 272
integer width = 2752
integer height = 1264
string dataobject = "d_reporte_diario_general_fecha"
end type

event dw_datos::retrieveend;call super::retrieveend;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_reporte_diario_general_fecha
integer x = 1536
integer y = 796
end type

type dw_1 from datawindow within w_reporte_diario_general_fecha
integer y = 104
integer width = 2757
integer height = 160
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rep_diario_contable_fecha"
boolean border = false
boolean livescroll = true
end type

type rb_1 from radiobutton within w_reporte_diario_general_fecha
integer x = 87
integer y = 32
integer width = 411
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
string text = "Por empresa"
borderstyle borderstyle = stylelowered!
end type

type rb_2 from radiobutton within w_reporte_diario_general_fecha
integer x = 553
integer y = 32
integer width = 416
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
string text = "Por sucursal"
borderstyle borderstyle = stylelowered!
end type


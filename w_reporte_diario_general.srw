HA$PBExportHeader$w_reporte_diario_general.srw
$PBExportComments$Si. (PINTULAC) W para reporte de diario general
forward
global type w_reporte_diario_general from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_reporte_diario_general
end type
type rb_1 from radiobutton within w_reporte_diario_general
end type
type rb_2 from radiobutton within w_reporte_diario_general
end type
end forward

global type w_reporte_diario_general from w_sheet_1_dw_rep
integer width = 2793
integer height = 1600
string title = "Diario General"
long backcolor = 81324524
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
end type
global w_reporte_diario_general w_reporte_diario_general

on w_reporte_diario_general.create
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

on w_reporte_diario_general.destroy
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
long    li_numini, li_numfin,ll_row


dw_1.AcceptText()

ll_row = dw_1.GetRow()
ls_tipo   = dw_1.GetItemString(ll_Row,"tipo_comp")
li_numini = dw_1.GetItemNumber(ll_row,"num_ini")
li_numfin = dw_1.GetItemNumber(ll_row,"num_fin")

/* Por empresa */
if rb_1.checked then
	dw_datos.dataobject = 'd_reporte_diario_general'
	dw_datos.settransobject(sqlca)
   dw_datos.retrieve(ls_tipo,li_numini,li_numfin,str_appgeninfo.empresa)
end if

/* Por sucursal */
if rb_2.checked then
	dw_datos.dataobject = 'd_reporte_diario_general_x_suc'
	dw_datos.settransobject(sqlca)
   dw_datos.retrieve(ls_tipo,li_numini,li_numfin,str_appgeninfo.empresa,str_appgeninfo.sucursal)
end if




end event

event resize;return dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 300)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_reporte_diario_general
integer x = 0
integer y = 288
integer width = 2752
integer height = 1180
string dataobject = "d_reporte_diario_general"
end type

event dw_datos::retrieveend;call super::retrieveend;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_reporte_diario_general
integer x = 1742
integer y = 776
end type

type dw_1 from datawindow within w_reporte_diario_general
integer y = 104
integer width = 2747
integer height = 180
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rep_diario_contable"
boolean border = false
boolean livescroll = true
end type

type rb_1 from radiobutton within w_reporte_diario_general
integer x = 55
integer y = 24
integer width = 384
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

type rb_2 from radiobutton within w_reporte_diario_general
integer x = 489
integer y = 24
integer width = 393
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


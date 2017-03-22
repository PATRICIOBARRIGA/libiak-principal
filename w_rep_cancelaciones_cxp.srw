HA$PBExportHeader$w_rep_cancelaciones_cxp.srw
$PBExportComments$Si.Reporte de cancelaciones cxp .Vale
forward
global type w_rep_cancelaciones_cxp from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_cancelaciones_cxp
end type
type em_2 from editmask within w_rep_cancelaciones_cxp
end type
type st_1 from statictext within w_rep_cancelaciones_cxp
end type
type st_2 from statictext within w_rep_cancelaciones_cxp
end type
type rb_1 from radiobutton within w_rep_cancelaciones_cxp
end type
type rb_2 from radiobutton within w_rep_cancelaciones_cxp
end type
end forward

global type w_rep_cancelaciones_cxp from w_sheet_1_dw_rep
integer width = 2569
integer height = 1484
string title = "Cancelaciones en Cuentas por Pagar"
long backcolor = 79741120
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_cancelaciones_cxp w_rep_cancelaciones_cxp

on w_rep_cancelaciones_cxp.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
end on

on w_rep_cancelaciones_cxp.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;date ld_fecini,ld_fecfin

ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)

If rb_1.checked Then
	dw_datos.dataobject = 'd_rep_cancelaciones_detalle_cxp'
else
dw_datos.dataobject = 'd_rep_cancelaciones_resumido_cxp'
End if
If ld_fecini > ld_fecfin and (not isnull(ld_fecini) or not isnull(ld_fecfin)) Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Verifique que la fecha de inicio sea menor que la final o que no sea nula")
	return
End if
dw_datos.settransobject(sqlca)
//f_recupera_empresa(dw_datos,"fp_codigo")
dw_datos.modify("st_empresa.text='"+gs_empresa+"'" )
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fecini,ld_fecfin)
dw_datos.modify("datawindow.print.preview=yes")

end event

event open;call super::open;em_1.text = string(today())
em_2.text = string(today())
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cancelaciones_cxp
integer x = 0
integer y = 240
integer width = 2523
integer height = 1132
integer taborder = 0
string dataobject = "d_rep_cancelaciones_detalle_cxp"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cancelaciones_cxp
integer x = 14
integer y = 328
integer taborder = 0
end type

type em_1 from editmask within w_rep_cancelaciones_cxp
integer x = 247
integer y = 60
integer width = 343
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
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

type em_2 from editmask within w_rep_cancelaciones_cxp
integer x = 850
integer y = 60
integer width = 343
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
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

type st_1 from statictext within w_rep_cancelaciones_cxp
integer x = 41
integer y = 68
integer width = 206
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_cancelaciones_cxp
integer x = 654
integer y = 68
integer width = 197
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
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_cancelaciones_cxp
integer x = 1440
integer y = 44
integer width = 334
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
boolean checked = true
end type

type rb_2 from radiobutton within w_rep_cancelaciones_cxp
integer x = 1440
integer y = 136
integer width = 315
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
end type


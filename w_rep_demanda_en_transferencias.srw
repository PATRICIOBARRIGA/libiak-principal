HA$PBExportHeader$w_rep_demanda_en_transferencias.srw
$PBExportComments$Si.Demanda e inconsistencias en transferencias
forward
global type w_rep_demanda_en_transferencias from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_demanda_en_transferencias
end type
type em_2 from editmask within w_rep_demanda_en_transferencias
end type
type st_1 from statictext within w_rep_demanda_en_transferencias
end type
type st_2 from statictext within w_rep_demanda_en_transferencias
end type
type rb_1 from radiobutton within w_rep_demanda_en_transferencias
end type
type rb_2 from radiobutton within w_rep_demanda_en_transferencias
end type
end forward

global type w_rep_demanda_en_transferencias from w_sheet_1_dw_rep
integer width = 3118
integer height = 1748
string title = "Demanda insatisfecha e inconsistencias"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_demanda_en_transferencias w_rep_demanda_en_transferencias

on w_rep_demanda_en_transferencias.create
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

on w_rep_demanda_en_transferencias.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if rb_1.checked then
dw_datos.dataobject = 'd_rep_demanda_x_fabricante_transf'
elseif rb_2.checked then
dw_datos.dataobject = 'd_rep_demanda_e_inconsistencias_transf'
end if
dw_datos.settransobject(sqlca)
dw_datos.retrieve(ld_ini,ld_fin)
end event

event resize;dataWindow ldw_aux
ldw_aux = dw_datos
ldw_aux.resize(this.workSpaceWidth(), this.workSpaceHeight() - 50)

end event

event open;call super::open;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_demanda_en_transferencias
integer x = 9
integer y = 240
integer width = 3063
integer height = 1404
string dataobject = "d_rep_demanda_e_inconsistencias_transf"
end type

event dw_datos::retrievestart;call super::retrievestart;this.modify("st_empresa = '"+gs_empresa+"'")
this.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_demanda_en_transferencias
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_demanda_en_transferencias
end type

type em_1 from editmask within w_rep_demanda_en_transferencias
integer x = 251
integer y = 44
integer width = 343
integer height = 76
integer taborder = 30
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

type em_2 from editmask within w_rep_demanda_en_transferencias
integer x = 855
integer y = 44
integer width = 343
integer height = 76
integer taborder = 40
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

type st_1 from statictext within w_rep_demanda_en_transferencias
integer x = 32
integer y = 52
integer width = 210
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

type st_2 from statictext within w_rep_demanda_en_transferencias
integer x = 640
integer y = 52
integer width = 210
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

type rb_1 from radiobutton within w_rep_demanda_en_transferencias
integer x = 1280
integer y = 40
integer width = 649
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
string text = "Por fabricante"
boolean checked = true
end type

type rb_2 from radiobutton within w_rep_demanda_en_transferencias
integer x = 1280
integer y = 124
integer width = 640
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
string text = "Detallado por sucursal"
end type


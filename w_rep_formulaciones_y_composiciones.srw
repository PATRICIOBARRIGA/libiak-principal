HA$PBExportHeader$w_rep_formulaciones_y_composiciones.srw
forward
global type w_rep_formulaciones_y_composiciones from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_rep_formulaciones_y_composiciones
end type
type rb_2 from radiobutton within w_rep_formulaciones_y_composiciones
end type
end forward

global type w_rep_formulaciones_y_composiciones from w_sheet_1_dw_rep
integer width = 3045
integer height = 2144
boolean ib_notautoretrieve = true
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_formulaciones_y_composiciones w_rep_formulaciones_y_composiciones

on w_rep_formulaciones_y_composiciones.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
end on

on w_rep_formulaciones_y_composiciones.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;
if rb_1.checked then
     dw_datos.DataObject = 'd_rep_formulaciones_y_composiciones'
else
	dw_datos.DataObject = 'd_rep_items_x_semielaborado'
end if
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_formulaciones_y_composiciones
integer x = 23
integer y = 192
integer width = 2926
integer height = 1824
string dataobject = "d_rep_formulaciones_y_composiciones"
end type

event dw_datos::retrieveend;call super::retrieveend;this.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" +"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_formulaciones_y_composiciones
integer x = 466
integer y = 900
string dataobject = "d_rep_formulaciones_y_composiciones"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_formulaciones_y_composiciones
integer x = 1806
integer y = 924
end type

type rb_1 from radiobutton within w_rep_formulaciones_y_composiciones
integer x = 233
integer y = 28
integer width = 1083
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
string text = "Composiciones  &  Formulaciones"
boolean checked = true
end type

type rb_2 from radiobutton within w_rep_formulaciones_y_composiciones
integer x = 233
integer y = 104
integer width = 1083
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
string text = "Producto terminado por Componente"
end type


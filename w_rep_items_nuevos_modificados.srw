HA$PBExportHeader$w_rep_items_nuevos_modificados.srw
$PBExportComments$Si.
forward
global type w_rep_items_nuevos_modificados from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_items_nuevos_modificados
end type
type em_1 from editmask within w_rep_items_nuevos_modificados
end type
end forward

global type w_rep_items_nuevos_modificados from w_sheet_1_dw_rep
integer width = 2665
integer height = 1976
string title = "Listado de items nuevos/modificados"
long backcolor = 67108864
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
st_1 st_1
em_1 em_1
end type
global w_rep_items_nuevos_modificados w_rep_items_nuevos_modificados

on w_rep_items_nuevos_modificados.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_1
end on

on w_rep_items_nuevos_modificados.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_1)
end on

event open;call super::open;em_1.text = string(today())
end event

event ue_retrieve;Date ld_ini
ld_ini  = date(em_1.text)
dw_datos.retrieve(ld_ini)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_items_nuevos_modificados
integer x = 23
integer y = 152
integer width = 2587
integer height = 1708
string dataobject = "d_rep_items_nuevos_modificados"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_items_nuevos_modificados
integer x = 41
integer y = 680
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_items_nuevos_modificados
integer x = 1115
integer y = 876
end type

type st_1 from statictext within w_rep_items_nuevos_modificados
integer x = 46
integer y = 48
integer width = 731
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
string text = "Ingrese la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_rep_items_nuevos_modificados
integer x = 782
integer y = 40
integer width = 343
integer height = 72
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


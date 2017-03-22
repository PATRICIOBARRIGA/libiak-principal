HA$PBExportHeader$w_rep_costos_resumen.srw
forward
global type w_rep_costos_resumen from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_costos_resumen
end type
type em_2 from editmask within w_rep_costos_resumen
end type
type st_1 from statictext within w_rep_costos_resumen
end type
type st_2 from statictext within w_rep_costos_resumen
end type
end forward

global type w_rep_costos_resumen from w_sheet_1_dw_rep
integer width = 3671
integer height = 2040
string title = "Resumen de costos"
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_rep_costos_resumen w_rep_costos_resumen

type variables
int ii_index
end variables

event ue_retrieve;
Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
Setpointer(Hourglass!)
dw_datos.retrieve(ld_ini,ld_fin)
Setpointer(arrow!)
end event

on w_rep_costos_resumen.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
end on

on w_rep_costos_resumen.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;ib_notautoretrieve = true

f_recupera_empresa(dw_datos,'su_codigo')
call super::open

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_costos_resumen
integer y = 192
integer width = 3552
integer height = 1696
integer taborder = 80
string dataobject = "d_rep_costos_resumen"
boolean border = true
end type

event dw_datos::retrievestart;call super::retrievestart;this.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_costos_resumen
integer x = 50
integer y = 928
integer taborder = 60
string dataobject = "d_rep_costos_x_sucursal"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_costos_resumen
end type

type em_1 from editmask within w_rep_costos_resumen
integer x = 238
integer y = 60
integer width = 343
integer height = 76
integer taborder = 50
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

type em_2 from editmask within w_rep_costos_resumen
integer x = 791
integer y = 60
integer width = 343
integer height = 76
integer taborder = 70
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

type st_1 from statictext within w_rep_costos_resumen
integer x = 50
integer y = 68
integer width = 174
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
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_costos_resumen
integer x = 635
integer y = 68
integer width = 151
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
boolean focusrectangle = false
end type


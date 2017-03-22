HA$PBExportHeader$w_rep_clientes_2080.srw
forward
global type w_rep_clientes_2080 from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_clientes_2080
end type
type st_2 from statictext within w_rep_clientes_2080
end type
type em_1 from editmask within w_rep_clientes_2080
end type
type em_2 from editmask within w_rep_clientes_2080
end type
type dw_1 from datawindow within w_rep_clientes_2080
end type
type st_3 from statictext within w_rep_clientes_2080
end type
end forward

global type w_rep_clientes_2080 from w_sheet_1_dw_rep
integer width = 2555
integer height = 1636
string title = "Clientes 2080"
long backcolor = 67108864
st_1 st_1
st_2 st_2
em_1 em_1
em_2 em_2
dw_1 dw_1
st_3 st_3
end type
global w_rep_clientes_2080 w_rep_clientes_2080

on w_rep_clientes_2080.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.em_1=create em_1
this.em_2=create em_2
this.dw_1=create dw_1
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_3
end on

on w_rep_clientes_2080.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.dw_1)
destroy(this.st_3)
end on

event ue_retrieve;String ls_epcodigo, ls_asesor
date   ld_ini,ld_fin

setpointer(hourglass!)
dw_datos.reset()
ls_epcodigo = dw_1.Object.ep_codigo[1]

select EP_CODIGO||' '||EP_NOMBRE||' '||EP_APEPAT
into :ls_asesor
from no_emple
where em_codigo = :str_appgeninfo.empresa
and ep_codigo = :ls_epcodigo;

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_asesor.text = '"+ls_asesor+"'")
dw_datos.retrieve(ld_ini,ld_fin,ls_epcodigo)
w_marco.setmicrohelp("Reporte Listo")
setpointer(arrow!)

end event

event open;ib_notautoretrieve = true

dw_1.insertrow(0)
f_recupera_empresa(dw_1,"ep_codigo")
call super::open
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_clientes_2080
integer x = 9
integer y = 220
integer width = 2487
integer height = 1292
integer taborder = 40
string dataobject = "d_rep_ventas_clientes_x_asesor"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_clientes_2080
integer x = 320
integer y = 1252
integer width = 357
integer height = 172
integer taborder = 50
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_clientes_2080
end type

type st_1 from statictext within w_rep_clientes_2080
integer x = 1312
integer y = 112
integer width = 169
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

type st_2 from statictext within w_rep_clientes_2080
integer x = 1902
integer y = 112
integer width = 155
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

type em_1 from editmask within w_rep_clientes_2080
integer x = 1490
integer y = 104
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
boolean autoskip = true
end type

type em_2 from editmask within w_rep_clientes_2080
integer x = 2071
integer y = 104
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

type dw_1 from datawindow within w_rep_clientes_2080
integer x = 64
integer y = 100
integer width = 1193
integer height = 84
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dwc_listaempleados"
boolean border = false
boolean livescroll = true
end type

type st_3 from statictext within w_rep_clientes_2080
integer x = 69
integer y = 36
integer width = 192
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
string text = "Asesor:"
boolean focusrectangle = false
end type


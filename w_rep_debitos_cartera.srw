HA$PBExportHeader$w_rep_debitos_cartera.srw
$PBExportComments$Si.Reporte de D$$HEX1$$e900$$ENDHEX$$bitos por rango fechas ordenado cronologicamente
forward
global type w_rep_debitos_cartera from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_debitos_cartera
end type
type em_2 from editmask within w_rep_debitos_cartera
end type
type dw_1 from datawindow within w_rep_debitos_cartera
end type
type st_1 from statictext within w_rep_debitos_cartera
end type
type st_2 from statictext within w_rep_debitos_cartera
end type
type st_3 from statictext within w_rep_debitos_cartera
end type
type cbx_1 from checkbox within w_rep_debitos_cartera
end type
type cbx_2 from checkbox within w_rep_debitos_cartera
end type
end forward

global type w_rep_debitos_cartera from w_sheet_1_dw_rep
integer width = 3081
integer height = 1776
string title = "D$$HEX1$$e900$$ENDHEX$$bitos por tipo"
long backcolor = 81324524
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
dw_1 dw_1
st_1 st_1
st_2 st_2
st_3 st_3
cbx_1 cbx_1
cbx_2 cbx_2
end type
global w_rep_debitos_cartera w_rep_debitos_cartera

type variables

end variables

on w_rep_debitos_cartera.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.cbx_2
end on

on w_rep_debitos_cartera.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cbx_1)
destroy(this.cbx_2)
end on

event open;call super::open;datawindowchild  ldwc_tipo
dw_1.insertrow(0)
f_recupera_empresa(dw_1,'tt_codigo')

dw_1.getchild('tt_codigo',ldwc_tipo)
ldwc_tipo.settransobject(sqlca)
ldwc_tipo.retrieve(str_appgeninfo.empresa)
ldwc_tipo.setfilter("tt_ioe ='D'")
ldwc_tipo.filter()






end event

event ue_retrieve;string ls_tipo
date ld_ini,ld_fin

ls_tipo = dw_1.getitemstring(1,"tt_codigo")
ld_ini =  date(em_1.text)
ld_fin =  date(em_2.text)
If cbx_1.checked Then
	dw_datos.dataobject = 'd_rep_informe_clientes'
	dw_datos.settransobject(sqlca)
	dw_datos.retrieve(str_appgeninfo.empresa,ld_ini,ld_fin)
Else
	dw_datos.dataobject = 'd_rep_cartera_x_fecha'
	dw_datos.settransobject(sqlca)
	f_recupera_empresa(dw_datos,'su_codigo')
	If cbx_2.checked Then
	    dw_datos.retrieve(str_appgeninfo.empresa,'%',ls_tipo,ld_ini,ld_fin)				
	else 
		dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo,ld_ini,ld_fin)
	end if
End if

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_datos.resize(li_width,li_height)
this.setRedraw(True)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_debitos_cartera
integer x = 0
integer y = 232
integer width = 2985
integer height = 1392
integer taborder = 40
string dataobject = "d_rep_cartera_x_fecha"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_datos::retrievestart;call super::retrievestart;string ls_tipo,ls_descri

ls_tipo = dw_1.getitemstring(dw_1.getrow(),"tt_codigo")

select tt_descri
into: ls_descri
from cc_tipo
where em_codigo = :str_appgeninfo.empresa
and tt_codigo = :ls_tipo
and tt_ioe = 'D';

This.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'"+& 
                  "datawindow.print.preview = 'Yes' st_tipo.text ='"+ls_descri+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_debitos_cartera
integer taborder = 0
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_debitos_cartera
end type

type em_1 from editmask within w_rep_debitos_cartera
integer x = 1925
integer y = 80
integer width = 315
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_rep_debitos_cartera
integer x = 2469
integer y = 84
integer width = 338
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

type dw_1 from datawindow within w_rep_debitos_cartera
integer x = 46
integer y = 84
integer width = 1015
integer height = 92
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_movimientos_cxc"
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within w_rep_debitos_cartera
integer x = 1719
integer y = 92
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

type st_2 from statictext within w_rep_debitos_cartera
integer x = 2286
integer y = 92
integer width = 178
integer height = 48
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

type st_3 from statictext within w_rep_debitos_cartera
integer x = 50
integer y = 24
integer width = 146
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_rep_debitos_cartera
integer x = 1102
integer y = 84
integer width = 539
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
string text = "Res$$HEX1$$fa00$$ENDHEX$$men de Cartera"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;If cbx_1.checked Then
	dw_1.setitem(1,"tt_codigo",'')
	dw_1.enabled = false
	cbx_2.visible = false
else
	cbx_2.visible = true
	dw_1.enabled = true
End if
	
end event

type cbx_2 from checkbox within w_rep_debitos_cartera
integer x = 1298
integer y = 160
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sucursal"
boolean lefttext = true
end type

event clicked;If cbx_2.checked Then  
	cbx_2.text = 'Empresa'
else
	cbx_2.text = 'Sucursal'
end if
end event


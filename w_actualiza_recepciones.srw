HA$PBExportHeader$w_actualiza_recepciones.srw
$PBExportComments$Si.
forward
global type w_actualiza_recepciones from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_actualiza_recepciones
end type
type em_2 from editmask within w_actualiza_recepciones
end type
type st_1 from statictext within w_actualiza_recepciones
end type
type st_2 from statictext within w_actualiza_recepciones
end type
end forward

global type w_actualiza_recepciones from w_sheet_1_dw_maint
integer width = 2990
integer height = 1692
string title = "Recepciones pendientes"
long backcolor = 82899184
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_actualiza_recepciones w_actualiza_recepciones

type variables
datawindowchild  idwc_aux
end variables

on w_actualiza_recepciones.create
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

on w_actualiza_recepciones.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;dw_datos.getchild("in_compra_co_numero",idwc_aux)
idwc_aux.SettransObject(sqlca)
//idwc_aux.insertrow(0)

ib_notautoretrieve = true
dw_datos.sharedata(dw_report)

em_1.text = string(today())
em_2.text = string(today())
call super::open
end event

event ue_retrieve;datawindowchild dwc
long ll_nreg
date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)


dw_datos.getchild("in_compra_co_numero",dwc)
dwc.settransobject(sqlca)
dwc.insertrow(0)
dw_datos.retrieve(str_appgeninfo.empresa,ld_ini,ld_fin)





end event

event close;call super::close;dw_datos.sharedataoff()
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_actualiza_recepciones
event ue_keydown pbm_dwnkey
integer x = 32
integer y = 168
integer width = 2885
integer height = 1408
integer taborder = 40
string dataobject = "d_recepciones_pendientes"
end type

event dw_datos::itemchanged;call super::itemchanged;string ls_pvrazons,ls_rucci

if dwo.name = "in_compra_pv_codigo" then

	select pv_razons,pv_rucci
	into :ls_pvrazons,:ls_rucci
	from in_prove
	where em_codigo = :str_appgeninfo.empresa
   and	pv_codigo = :data;
	
	this.setitem(row,"in_prove_pv_razons",ls_pvrazons)
	this.setitem(row,"in_prove_pv_rucci",ls_rucci)
end if


end event

event dw_datos::clicked;datawindowchild dwc
String ls_sucursal
Long ll_nro


ls_sucursal = dw_datos.Object.in_compra_su_codigo[row]
ll_nro     =  dw_datos.Object.in_compra_co_numero[row]

dw_datos.getchild("in_compra_co_numero",dwc)
dwc.settransobject(sqlca)
dwc.retrieve(str_appgeninfo.empresa,ls_sucursal,ll_nro)
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_actualiza_recepciones
integer x = 32
integer y = 168
integer width = 2894
integer height = 1408
string dataobject = "d_rep_notarecepcion_pendientes"
end type

type em_1 from editmask within w_actualiza_recepciones
integer x = 256
integer y = 28
integer width = 302
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

type em_2 from editmask within w_actualiza_recepciones
integer x = 777
integer y = 28
integer width = 347
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

type st_1 from statictext within w_actualiza_recepciones
integer x = 41
integer y = 36
integer width = 215
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

type st_2 from statictext within w_actualiza_recepciones
integer x = 613
integer y = 36
integer width = 165
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


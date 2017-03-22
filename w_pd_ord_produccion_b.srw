HA$PBExportHeader$w_pd_ord_produccion_b.srw
$PBExportComments$Orden de produccion en base a pedidos
forward
global type w_pd_ord_produccion_b from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_pd_ord_produccion_b
end type
type dw_2 from datawindow within w_pd_ord_produccion_b
end type
type st_1 from statictext within w_pd_ord_produccion_b
end type
type st_2 from statictext within w_pd_ord_produccion_b
end type
type st_3 from statictext within w_pd_ord_produccion_b
end type
type em_1 from editmask within w_pd_ord_produccion_b
end type
type em_2 from editmask within w_pd_ord_produccion_b
end type
type st_4 from statictext within w_pd_ord_produccion_b
end type
type st_5 from statictext within w_pd_ord_produccion_b
end type
type cb_1 from commandbutton within w_pd_ord_produccion_b
end type
type cb_2 from commandbutton within w_pd_ord_produccion_b
end type
end forward

global type w_pd_ord_produccion_b from w_sheet_1_dw_maint
integer width = 5390
integer height = 2524
string title = "Orden de producci$$HEX1$$f300$$ENDHEX$$n"
boolean ib_notautoretrieve = true
dw_1 dw_1
dw_2 dw_2
st_1 st_1
st_2 st_2
st_3 st_3
em_1 em_1
em_2 em_2
st_4 st_4
st_5 st_5
cb_1 cb_1
cb_2 cb_2
end type
global w_pd_ord_produccion_b w_pd_ord_produccion_b

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();long ll_row
String ls_nro

dw_report.settransobject(sqlca)

ll_row  = dw_datos.getrow()
if ll_row = 0 then return -1
ls_nro = dw_datos.Object.or_codigo[ll_row]
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_nro)
return 1
end function

on w_pd_ord_produccion_b.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.em_1=create em_1
this.em_2=create em_2
this.st_4=create st_4
this.st_5=create st_5
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.em_1
this.Control[iCurrent+7]=this.em_2
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.cb_2
end on

on w_pd_ord_produccion_b.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;istr_argInformation.nrArgs =3

istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"

istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = str_appgeninfo.seccion


dw_datos.is_SerialCodeColumn = "or_codigo"
dw_datos.is_SerialCodeType = "PR_ORDPRD"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
//dw_1.retrieve()
//f_recupera_empresa(dw_datos,'pl_codigo')
em_1.text = string(today())
em_2.text = string(today())
call super::open
end event

event resize;
int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	
	dw_datos.resize(li_width/2 - 20, li_height -100)
	dw_1.resize(li_width/2 - 80, dw_1.height)
	dw_2.resize(li_width/2 - 80,  li_height - dw_1.height - 180 )
     dw_datos.move(li_width/2, dw_datos.y)
	st_3.move(li_width/2,st_3.y)

end if	
this.setRedraw(True)

return 1
end event

event ue_retrieve;call super::ue_retrieve;long ll_reg
date ld_ini,ld_fin
string ls_pepa

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

ll_reg     = dw_1.retrieve(ld_ini,ld_fin)

if ll_reg = 0 then return
ls_pepa = dw_1.object.pd_detped_it_codigo[1]
dw_2.reset()
dw_2.retrieve(ls_pepa,ld_ini,ld_fin)


end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_pd_ord_produccion_b
integer x = 3045
integer y = 112
integer width = 2240
integer height = 2240
string dataobject = "d_ord_produccion"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
end type

event dw_datos::itemchanged;call super::itemchanged;String ls_nombre,ls_pepa

if dwo.name = "it_codant" then
	SELECT IT_NOMBRE,IT_CODIGO
	into :ls_nombre,:ls_pepa
	FROM IN_ITEM
	WHERE IT_CODANT = :data;
	
	if sqlca.sqlcode <> 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe c$$HEX1$$f300$$ENDHEX$$digo de producto...")	
	end if
	
	this.Object.it_nombre[row] = ls_nombre
	this.Object.it_codigo[row] = ls_pepa
end if


end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_pd_ord_produccion_b
integer x = 3045
integer y = 92
integer width = 2240
integer height = 2256
integer taborder = 40
string dataobject = "d_prn_ord_produccion"
end type

type dw_1 from datawindow within w_pd_ord_produccion_b
integer x = 50
integer y = 116
integer width = 2962
integer height = 1012
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_pd_items_x_pedido"
boolean livescroll = true
end type

event clicked;Long ll_new
String ls_pepa

if dwo.name = 't_1' then
	
	dw_datos.reset()
	dw_datos.setfocus()
	ll_new = dw_datos.insertrow(0)
	dw_datos.scrolltorow(ll_new)
//	dw_datos.Object.ce_codigo[ll_new]                    =  dw_master.object.ce_codigo[dw_master.getrow()]
	dw_datos.object.it_codigo[ll_new]                      =  this.object.pd_detped_it_codigo[row]
	dw_datos.object.it_codant[ll_new]                      =  this.object.in_item_it_codant[row]
	dw_datos.object.it_nombre[ll_new]                    =  this.object.in_item_it_nombre[row]
	dw_datos.object.pd_ordprd_or_cantid[ll_new]     =  this.object.tot_cantidad[row]
//	dw_datos.object.dp_secue[ll_new]                     =  this.object.dp_secue[this.getrow()]


end if
end event

event rowfocuschanged;//Recuperar el detalle del pedido
String ls_pepa
Date   ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

SetRowFocusIndicator(hand!)
if currentrow = 0 then return
ls_pepa = this.object.pd_detped_it_codigo[currentrow]

dw_2.retrieve(ls_pepa,ld_ini,ld_fin)
end event

type dw_2 from datawindow within w_pd_ord_produccion_b
integer x = 46
integer y = 1208
integer width = 2967
integer height = 1144
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pd_detalle_pedidos"
boolean hsplitscroll = true
end type

type st_1 from statictext within w_pd_ord_produccion_b
integer x = 59
integer y = 32
integer width = 471
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Elementos a producir"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pd_ord_produccion_b
integer x = 59
integer y = 1144
integer width = 416
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Detalle por pedido"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pd_ord_produccion_b
integer x = 3049
integer y = 32
integer width = 475
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Orden de producci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type em_1 from editmask within w_pd_ord_produccion_b
integer x = 841
integer y = 16
integer width = 366
integer height = 84
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
boolean spin = true
end type

type em_2 from editmask within w_pd_ord_produccion_b
integer x = 1737
integer y = 16
integer width = 366
integer height = 84
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
boolean spin = true
end type

type st_4 from statictext within w_pd_ord_produccion_b
integer x = 626
integer y = 32
integer width = 210
integer height = 68
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

type st_5 from statictext within w_pd_ord_produccion_b
integer x = 1536
integer y = 28
integer width = 197
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
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_pd_ord_produccion_b
integer x = 1234
integer y = 20
integer width = 87
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_1.text = em_2.text
end event

type cb_2 from commandbutton within w_pd_ord_produccion_b
integer x = 1467
integer y = 20
integer width = 87
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_2.text  = em_1.text
end event


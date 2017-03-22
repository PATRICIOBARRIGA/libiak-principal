HA$PBExportHeader$w_pd_ord_produccion.srw
forward
global type w_pd_ord_produccion from w_sheet_1_dw_maint
end type
type dw_rta from datawindow within w_pd_ord_produccion
end type
type shl_1 from statichyperlink within w_pd_ord_produccion
end type
type dw_1 from datawindow within w_pd_ord_produccion
end type
type sle_1 from singlelineedit within w_pd_ord_produccion
end type
type st_1 from statictext within w_pd_ord_produccion
end type
end forward

global type w_pd_ord_produccion from w_sheet_1_dw_maint
integer width = 4018
integer height = 2408
string title = "Orden de producci$$HEX1$$f300$$ENDHEX$$n"
boolean resizable = false
dw_rta dw_rta
shl_1 shl_1
dw_1 dw_1
sle_1 sle_1
st_1 st_1
end type
global w_pd_ord_produccion w_pd_ord_produccion

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

on w_pd_ord_produccion.create
int iCurrent
call super::create
this.dw_rta=create dw_rta
this.shl_1=create shl_1
this.dw_1=create dw_1
this.sle_1=create sle_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rta
this.Control[iCurrent+2]=this.shl_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.st_1
end on

on w_pd_ord_produccion.destroy
call super::destroy
destroy(this.dw_rta)
destroy(this.shl_1)
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.st_1)
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


//f_recupera_empresa(dw_datos,'pl_codigo')
dw_rta.SetTransObject(sqlca)
call super::open

dw_datos.Sharedata(dw_1)
end event

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_pd_ord_produccion
integer x = 50
integer y = 808
integer width = 3899
integer height = 1468
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

event dw_datos::rowfocuschanged;call super::rowfocuschanged;SetRowfocusIndicator(Hand!)
dw_1.scrolltorow(currentrow)
dw_1.setrow(currentrow)
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_pd_ord_produccion
integer x = 32
integer y = 16
integer width = 3109
integer height = 2340
string dataobject = "d_prn_ord_produccion"
end type

type dw_rta from datawindow within w_pd_ord_produccion
boolean visible = false
integer x = 443
integer y = 728
integer width = 3657
integer height = 1468
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_materiaprima_x_item"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type shl_1 from statichyperlink within w_pd_ord_produccion
boolean visible = false
integer x = 1614
integer y = 520
integer width = 507
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Ver stock disponible"
boolean focusrectangle = false
end type

event clicked;long row,ll_reg
String ls_pepa

row = dw_datos.getrow()
ls_pepa       = dw_datos.object.it_codigo[row]
dw_rta.visible = true
ll_reg    = dw_rta.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pepa,'C', dw_datos.object.pd_ordprd_or_cantprd[row])
if ll_reg = 0 then dw_rta.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pepa,'F', dw_datos.object.pd_ordprd_or_cantprd[row])
end event

type dw_1 from datawindow within w_pd_ord_produccion
integer x = 55
integer y = 152
integer width = 3890
integer height = 612
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pd_lista_ordenes_c"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;SetRowfocusIndicator(Hand!)
dw_datos.scrolltorow(currentrow)
dw_datos.setrow(currentrow)
end event

type sle_1 from singlelineedit within w_pd_ord_produccion
integer x = 663
integer y = 36
integer width = 283
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
end type

event modified;Long ll_find

ll_find = dw_datos.find("or_codigo = '"+sle_1.text+"'",1, dw_datos.rowcount())

if ll_find  = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones....!")
else
	dw_datos.Setrow(ll_find)
	dw_datos.ScrollToRow(ll_find)
end if
end event

type st_1 from statictext within w_pd_ord_produccion
integer x = 78
integer y = 48
integer width = 562
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
string text = "Buscar por  N$$HEX2$$ba002000$$ENDHEX$$de orden:"
boolean focusrectangle = false
end type


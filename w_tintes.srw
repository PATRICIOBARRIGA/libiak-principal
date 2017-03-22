HA$PBExportHeader$w_tintes.srw
forward
global type w_tintes from w_sheet_master_detail
end type
type sle_1 from singlelineedit within w_tintes
end type
type st_1 from statictext within w_tintes
end type
type st_2 from statictext within w_tintes
end type
type cb_1 from commandbutton within w_tintes
end type
type ddlb_1 from dropdownlistbox within w_tintes
end type
type st_3 from statictext within w_tintes
end type
type sle_3 from singlelineedit within w_tintes
end type
type sle_4 from singlelineedit within w_tintes
end type
type st_4 from statictext within w_tintes
end type
type st_5 from statictext within w_tintes
end type
type dw_tint from datawindow within w_tintes
end type
type shl_1 from statichyperlink within w_tintes
end type
type dw_1 from datawindow within w_tintes
end type
end forward

global type w_tintes from w_sheet_master_detail
integer width = 5582
integer height = 2432
sle_1 sle_1
st_1 st_1
st_2 st_2
cb_1 cb_1
ddlb_1 ddlb_1
st_3 st_3
sle_3 sle_3
sle_4 sle_4
st_4 st_4
st_5 st_5
dw_tint dw_tint
shl_1 shl_1
dw_1 dw_1
end type
global w_tintes w_tintes

type variables
datawindowchild i_dwc
end variables

on w_tintes.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.sle_3=create sle_3
this.sle_4=create sle_4
this.st_4=create st_4
this.st_5=create st_5
this.dw_tint=create dw_tint
this.shl_1=create shl_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.ddlb_1
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_3
this.Control[iCurrent+8]=this.sle_4
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.dw_tint
this.Control[iCurrent+12]=this.shl_1
this.Control[iCurrent+13]=this.dw_1
end on

on w_tintes.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.sle_3)
destroy(this.sle_4)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_tint)
destroy(this.shl_1)
destroy(this.dw_1)
end on

event open;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Llena las estructuras para trabajar maestro detalle
//               y para recuperar autom$$HEX1$$e100$$ENDHEX$$ticamente el secuencial de la
// orden de compra
////////////////////////////////////////////////////////////////////////

//string ls_parametro[]

f_recupera_empresa(dw_master,"fb_codigo") 
//ls_parametro[1] = str_appgeninfo.empresa
//ls_parametro[1] = str_appgeninfo.sucursal
//ls_parametro[2] = '1' // 1 es ORDEN DE COMPRA
//f_recupera_datos(dw_master,"co_numpad", ls_parametro,2)

f_recupera_empresa(dw_tint,"it_codigo")
f_recupera_empresa(dw_tint,"it_codigo_1")
//
f_recupera_empresa(dw_detail,"it_codigo")
f_recupera_empresa(dw_detail,"it_codigo_1")

istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"


istr_argInformation.StringValue[1] = str_appgeninfo.empresa
dw_detail.setrowfocusindicator(hand!)

call super::open
//dw_master.is_SerialCodeColumn = "rt_codigo"
//dw_master.is_SerialCodeType = "NUM_RTA"
//dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//dw_detail.is_serialCodeDetail = "rq_secue"
//dw_detailr.is_SerialCodeType = "NUM_RTA"

// columnas de conecci$$HEX1$$f300$$ENDHEX$$n
dw_master.ii_nrCols = 2
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "fo_codigo"

dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "fo_codigo"

dw_detail.uf_setArgTypes()

//dw_movim.settransobject(sqlca)
//Si quiero que se llene al arrancar el maestro y el detalle
dw_master.uf_retrieve()

//dw_master.uf_insertCurrentRow()
dw_master.setFocus()
dw_tint.SetTransObject(sqlca)
dw_report.SetTransObject(sqlca)
dw_1.insertrow(0)



dw_1.getchild("it_codigo",i_dwc)
i_dwc.settransObject(sqlca)
i_dwc.retrieve()
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	dw_detail.resize(dw_master.width,li_height - (dw_master.height + 350))
end if	
this.setRedraw(True)
end event

type dw_master from w_sheet_master_detail`dw_master within w_tintes
integer y = 184
integer width = 5467
integer height = 964
string dataobject = "d_formulas"
boolean hscrollbar = false
boolean hsplitscroll = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_noautosave = true
end type

event dw_master::rowfocuschanged;call super::rowfocuschanged;SetRowFocusIndicator(Hand!)
end event

event dw_master::ue_postinsert;call super::ue_postinsert;this.Object.em_codigo[this.getrow()] = str_appgeninfo.empresa

end event

type dw_detail from w_sheet_master_detail`dw_detail within w_tintes
integer x = 37
integer y = 1336
integer width = 5467
integer height = 948
string dataobject = "d_tinte_x_formula"
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_detail::updatestart;this.AcceptText()

this.object.fo_secue.primary= this.object.cc_filact.primary


call super::updatestart

return 0
end event

event dw_detail::itemchanged;call super::itemchanged;String ls_pepa,ls_nombre
decimal{4} lc_preciotinte	


If dwo.name = 'it_codant' then
	SELECT IT_CODIGO,IT_NOMBRE,IT_PREFAB
	INTO :ls_pepa,:ls_nombre,:lc_preciotinte
	FROM IN_ITEM
	WHERE IT_CODANT =:data;
	
	if sqlca.sqlcode = 100 then 
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe producto...")
		return
	end if
	this.object.it_codigo[row] = ls_pepa
	this.object.it_nombre[row] = ls_nombre
	this.object.in_item_it_prefab[row] = lc_preciotinte
	
end if
end event

event dw_detail::ue_postinsert;call super::ue_postinsert;if this.getrow() = 0 then return
this.object.em_codigo[this.getrow()] = str_appgeninfo.empresa
this.object.fo_codigo[this.getrow()]= dw_master.object.fo_codigo[dw_master.getrow()]
end event

type dw_report from w_sheet_master_detail`dw_report within w_tintes
end type

type sle_1 from singlelineedit within w_tintes
integer x = 2208
integer y = 1204
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
end type

type st_1 from statictext within w_tintes
integer x = 1943
integer y = 1216
integer width = 261
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
string text = "CANTIDAD"
boolean focusrectangle = false
end type

type st_2 from statictext within w_tintes
integer x = 626
integer y = 1216
integer width = 485
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
string text = "CODIGO DE LA BASE"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_tintes
integer x = 4590
integer y = 1200
integer width = 901
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CLICK AQUI PARA CALCULAR PRECIO"
end type

event clicked;long i
dec{4} lc_preciobase,lc_presentacion
String ls_codbase

//La formulaci$$HEX1$$f300$$ENDHEX$$n de los tintes en IN_FORMULAS esta dado para la presentaci$$HEX1$$f300$$ENDHEX$$n de GALON

 
choose case ddlb_1.text
	case 'CANECA'
		lc_presentacion = 5
	case 'GALON'
		lc_presentacion = 1
	case 'LITRO' 
		lc_presentacion = 1/4
	case 'OCTAVO'
		lc_presentacion = 1/8
end choose



ls_codbase = dw_1.Object.it_codigo[1]

SELECT IT_PREFAB
INTO :lc_preciobase
FROM IN_ITEM
WHERE IT_CODIGO = :ls_codbase;

for i = 1 to dw_detail.rowcount()
	dw_detail.object.cant_preparar[i] = dec(sle_1.text)
	dw_detail.object.precio_base[i] =  lc_preciobase
	dw_detail.object.presentacion[i] = lc_presentacion
next
end event

type ddlb_1 from dropdownlistbox within w_tintes
integer x = 3040
integer y = 1200
integer width = 567
integer height = 440
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"CANECA","GALON","LITRO","OCTAVO"}
end type

type st_3 from statictext within w_tintes
integer x = 2651
integer y = 1220
integer width = 375
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
string text = "PRESENTACION:"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_tintes
integer x = 37
integer y = 72
integer width = 466
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event modified;String ls_data
Long ll_find

sle_4.text = ''

ls_data = this.text+'%'
ll_find = dw_master.find("fo_codigo like '"+ls_data+"'",1,dw_master.Rowcount())

If ll_find <> 0 then 
	dw_master.ScrollToRow(ll_find)
	dw_master.SetRow(ll_find)
end if
end event

type sle_4 from singlelineedit within w_tintes
integer x = 535
integer y = 72
integer width = 1513
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "%"
end type

event modified;String ls_data
Long ll_find

sle_3.text = ''
ls_data = this.text+'%'
ll_find = dw_master.find("fo_nombre like '"+ls_data+"'",1,dw_master.Rowcount())

If ll_find <> 0 then 
	dw_master.ScrollToRow(ll_find)
	dw_master.SetRow(ll_find)
end if
end event

type st_4 from statictext within w_tintes
integer x = 41
integer y = 12
integer width = 343
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
string text = "C$$HEX1$$f300$$ENDHEX$$digo"
boolean focusrectangle = false
end type

type st_5 from statictext within w_tintes
integer x = 535
integer y = 8
integer width = 343
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
string text = "Nombre"
boolean focusrectangle = false
end type

type dw_tint from datawindow within w_tintes
boolean visible = false
integer x = 791
integer y = 200
integer width = 4686
integer height = 1372
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Tintes"
string dataobject = "d_tintes"
boolean controlmenu = true
boolean livescroll = true
end type

event itemchanged;String ls_pepa,ls_nombre

IF dwo.name = "in_item_it_codant" then
	SELECT IT_CODIGO,IT_NOMBRE
	into :ls_pepa,:ls_nombre
	FROM IN_ITEM
	WHERE IT_CODANT = :data;
	
	IF SQLCA.SQLCODE <> 0 THEN
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe producto..."+sqlca.sqlerrtext)
		Rollback;
		Return
	END IF
	
	
	This.Object.it_codigo[row] = ls_pepa
	This.Object.in_item_it_nombre[row] = ls_nombre
end if
end event

type shl_1 from statichyperlink within w_tintes
integer x = 3282
integer y = 84
integer width = 562
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
string text = "Click aqu$$HEX2$$ed002000$$ENDHEX$$para ver tintes"
boolean focusrectangle = false
end type

event clicked;dw_tint.visible = true
dw_tint.bringtotop = true
dw_tint.retrieve()
end event

type dw_1 from datawindow within w_tintes
integer x = 1143
integer y = 1208
integer width = 585
integer height = 76
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_items_base"
boolean border = false
boolean livescroll = true
end type

event getfocus;String ls_criterio

if dw_master.getrow() = 0 then return

ls_criterio = "it_base = '"+dw_master.Object.it_base[dw_master.getrow()]+"'"

i_dwc.Setfilter(ls_criterio)
i_dwc.filter()
end event


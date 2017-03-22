HA$PBExportHeader$w_vh_ingreso.srw
forward
global type w_vh_ingreso from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_vh_ingreso
end type
type st_1 from statictext within w_vh_ingreso
end type
type sle_2 from singlelineedit within w_vh_ingreso
end type
type st_3 from statictext within w_vh_ingreso
end type
end forward

global type w_vh_ingreso from w_sheet_1_dw_maint
integer width = 4430
integer height = 1840
string title = "Ingreso"
dw_1 dw_1
st_1 st_1
sle_2 sle_2
st_3 st_3
end type
global w_vh_ingreso w_vh_ingreso

event open;
f_recupera_empresa(dw_datos,"ca_codigo")
f_recupera_empresa(dw_datos,"mo_codigo")
f_recupera_empresa(dw_datos,"co_codigo")
f_recupera_empresa(dw_datos,"pa_codigo")
f_recupera_empresa(dw_datos,"ma_codigo")
f_recupera_empresa(dw_datos,"it_codigo")
f_recupera_empresa(dw_1,"it_codigo")
dw_datos.Sharedata(dw_1)
call super::OPEN
end event

on w_vh_ingreso.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.sle_2=create sle_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_2
this.Control[iCurrent+4]=this.st_3
end on

on w_vh_ingreso.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.sle_2)
destroy(this.st_3)
end on

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_vh_ingreso
integer x = 55
integer y = 860
integer width = 4274
integer height = 820
string dataobject = "d_ficha_vehiculo"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
end type

event dw_datos::rowfocuschanged;call super::rowfocuschanged;String ls_motor
Long ll_find




ls_motor = this.object.di_ref1[currentrow]
ll_find=dw_1.Find("di_ref1 = '"+ls_motor+"'",1,this.rowcount())

if ll_find <> 0 then
dw_1.SetRow(ll_find)
dw_1.ScrollToRow(ll_find)
end if
end event

event dw_datos::itemchanged;call super::itemchanged;
if dwo.name = 'pa_codigo' then
	this.object.di_ref3[row] = data
end if
end event

event dw_datos::updatestart;dwItemStatus    l_status
integer li_colnbr = 1
long ll_row = 1
string ls_colname, ls_textname,ls_res
int li_res

//Actualizamos el campo de estado del registro actual
ls_res = this.Describe("estado.ColType")
//if ls_res <> "!" then
//  l_status = this.GetItemStatus(this.GetRow(),0,Primary!)
//  if l_status = New! or l_status = NewModified! then
//	  this.SetItem(this.GetRow(),"estado",'N')
//  elseif l_status = DataModified! then
//	  this.SetItem(this.GetRow(),"estado",'A')
//  end if

// Make sure the last entry is accepted
if this.acceptText() = -1 then
	this.SetFocus()
	return(1)
end if

// Find the first empty row and column, if any
if this.findRequired(Primary!, ll_row, li_colnbr,ls_colname,True) < 0 then
	//If the search fails due to an error, then return
	return(1)
end if

// Was any row found?
if ll_row <> 0 then
	// Get the text of that column's label.
	//ls_textname = ls_colname + "_t.Text"
	//ls_colname = this.describe(ls_textname)

	// Make the problem column current.
	this.setColumn(li_colnbr)
	this.scrollToRow(ll_row)
	this.setFocus()

	// Tell the user which column to fill in.
	f_error("Valor Obligatorio Faltante", &
				"Por favor ingrese un valor para '"	+ ls_colname + &
						"', fila " + string(ll_row) + ".", &
				"datawindow", "error", "")
	return(1)
end if




return 0
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_vh_ingreso
end type

type dw_1 from datawindow within w_vh_ingreso
integer x = 46
integer y = 132
integer width = 4270
integer height = 640
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_kardek_vehiculos"
boolean livescroll = true
end type

event rowfocuschanged;String ls_motor
Long ll_find

SetRowfocusIndicator(hand!)


ls_motor = this.object.di_ref1[currentrow]
ll_find=dw_datos.Find("di_ref1 = '"+ls_motor+"'",1,dw_datos.rowcount())

if ll_find <> 0 then
dw_datos.SetRow(ll_find)
dw_datos.ScrollToRow(ll_find)
end if
end event

type st_1 from statictext within w_vh_ingreso
integer x = 59
integer y = 792
integer width = 626
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
string text = "Caracter$$HEX1$$ed00$$ENDHEX$$sticas del Veh$$HEX1$$ed00$$ENDHEX$$culo"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_vh_ingreso
integer x = 3209
integer y = 40
integer width = 617
integer height = 64
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;String ls_cadena
Long ll_find


ls_cadena = sle_2.text+'%'

ll_find=dw_datos.Find("di_ref1 like '"+ls_cadena+"'",1,dw_datos.rowcount())

if ll_find <> 0 then
dw_datos.SetRow(ll_find)
dw_datos.ScrollToRow(ll_find)
end if
end event

type st_3 from statictext within w_vh_ingreso
integer x = 2533
integer y = 44
integer width = 654
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Buscar por n$$HEX1$$fa00$$ENDHEX$$mero de motor:"
boolean focusrectangle = false
end type


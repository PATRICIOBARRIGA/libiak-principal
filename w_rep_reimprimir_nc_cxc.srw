HA$PBExportHeader$w_rep_reimprimir_nc_cxc.srw
$PBExportComments$Si.Estado de cuenta de un cliente en particular
forward
global type w_rep_reimprimir_nc_cxc from w_sheet
end type
type st_1 from statictext within w_rep_reimprimir_nc_cxc
end type
type sle_1 from singlelineedit within w_rep_reimprimir_nc_cxc
end type
type dw_1 from datawindow within w_rep_reimprimir_nc_cxc
end type
type dw_datos from uo_dw_basic within w_rep_reimprimir_nc_cxc
end type
type dw_report from datawindow within w_rep_reimprimir_nc_cxc
end type
end forward

global type w_rep_reimprimir_nc_cxc from w_sheet
integer width = 3991
integer height = 1584
string title = "Reimpresi$$HEX1$$f300$$ENDHEX$$n de (notas de cr$$HEX1$$e900$$ENDHEX$$dito y d$$HEX1$$e900$$ENDHEX$$bito) en cxc"
long backcolor = 81324524
event ue_retrieve pbm_custom01
event ue_firstrow pbm_custom02
event ue_priorrow pbm_custom03
event ue_nextrow pbm_custom04
event ue_lastrow pbm_custom05
event ue_sort pbm_custom06
event ue_print pbm_custom10
event ue_zoomin pbm_custom11
event ue_zoomout pbm_custom12
event ue_printcancel pbm_custom13
event ue_saveas pbm_custom14
event ue_consultar pbm_custom16
st_1 st_1
sle_1 sle_1
dw_1 dw_1
dw_datos dw_datos
dw_report dw_report
end type
global w_rep_reimprimir_nc_cxc w_rep_reimprimir_nc_cxc

type variables
s_argInformation istr_argInformation
boolean ib_notAutoRetrieve,is_band=true
boolean ib_inReportMode
end variables

forward prototypes
public function integer wf_copyargs_basic ()
public function integer wf_postprint ()
public function integer wf_preprint ()
public function integer wf_copyargs ()
end prototypes

event ue_retrieve;date ld_fecini,ld_fecfin
long ll_nreg,ll_row

dw_1.accepttext()
ll_row = dw_1.getrow()
ld_fecini = dw_1.getitemdate(ll_row,"fecini")
ld_fecfin = dw_1.getitemdate(ll_row,"fecfin")
f_recupera_empresa(dw_datos,"fp_codigo")
f_recupera_empresa(dw_datos,"cc_movim_tt_codigo")
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fecini,ld_fecfin)
If ll_nreg = 0 Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Nota de Cr$$HEX1$$e900$$ENDHEX$$dito para este rango de fechas...<verif$$HEX1$$ed00$$ENDHEX$$que>")
	return
End if
end event

event ue_print;long ll_nreg,ll_venumero
string ls_mtcodigo,ls_fp,ls_valletras,ls_nc,ls_tipond
char lch_ioe
dec{2} lc_valor
date ld_hoy

ll_nreg = dw_datos.getrow()
ll_venumero = dw_datos.getitemnumber(ll_nreg,"cc_movim_ve_numero")
ls_mtcodigo = dw_datos.getitemstring(ll_nreg,"cc_movim_mt_codigo")
ls_fp = dw_datos.getitemstring(ll_nreg,"fp_codigo")
ls_nc = dw_datos.getitemstring(ll_nreg,"ch_numero")
lch_ioe = dw_datos.getitemstring(ll_nreg,"cc_movim_tt_ioe")
ls_tipond = dw_datos.getitemstring(ll_nreg,"cc_movim_tt_codigo")
lc_valor = dw_datos.getitemnumber(ll_nreg,"mt_valor")
ls_valletras = f_numero_a_letras (lc_valor)

If lch_ioe = 'C' Then
//    If not isnull(string(ll_venumero)) or string(ll_venumero) <> '' Then	
		//dw_report.dataobject = "d_nc_cxc_preimpresa_redcolor"
		dw_report.dataobject = "d_nc_cxc_preimpresa_motegi"
		dw_report.settransobject(sqlca)
		f_recupera_empresa(dw_report,"fp_codigo")
		dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo,ls_nc,ls_fp,ls_valletras)
//	else
//		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Solo puede reimprimir notas de cr$$HEX1$$e900$$ENDHEX$$dito y d$$HEX1$$e900$$ENDHEX$$bito...verif$$HEX1$$ed00$$ENDHEX$$que")
//		return
//	End if  
else
	
	//dw_report.dataobject = "d_nd_cxc_preimpresa_redcolor"
	dw_report.dataobject = "d_nd_cxc_preimpresa_motegi"
	dw_report.settransobject(sqlca)
	f_recupera_empresa(dw_report,"fp_codigo")
    ll_nreg = dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipond,ls_mtcodigo,ls_valletras)
    If ll_nreg = 0 Then return
End if
//dw_report.modify("st_reimpresion.visible = 1")
dw_report.Modify("DataWindow.Footer.Height=2600")
//dw_report.Modify("DataWindow.Footer.Height=20300")
dw_report.print()
end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

event ue_consultar;//dw_ubica
end event

public function integer wf_copyargs_basic ();//int li_arg

dw_datos.istr_argInformation = this.istr_argInformation

//dw_datos.istr_argInformation.nrArgs = this.istr_argInformation.nrArgs
//for li_arg = 1 to dw_datos.istr_argInformation.nrArgs
//	dw_datos.istr_argInformation.argType[li_arg] = lower(this.istr_argInformation.argType[li_arg])
//	choose case dw_datos.istr_argInformation.argType[li_arg]
//		case "string"
//			dw_datos.istr_argInformation.stringValue[li_arg] = this.istr_argInformation.stringValue[li_arg]
//		case "number"
//			dw_datos.istr_argInformation.numberValue[li_arg] = this.istr_argInformation.numberValue[li_arg]
//		case "date"
//			dw_datos.istr_argInformation.dateValue[li_arg] = this.istr_argInformation.dateValue[li_arg]
//		case "dateTime"
//			dw_datos.istr_argInformation.dateTimeValue[li_arg] = this.istr_argInformation.dateTimeValue[li_arg]
//		case "time"
//			dw_datos.istr_argInformation.timeValue[li_arg] = this.istr_argInformation.timeValue[li_arg]
//		case else
//			messageBox("Error de programaci$$HEX1$$f300$$ENDHEX$$n", "El argumento " + &
//					string(li_arg) + " tiene el tipo '" + &
//					dw_datos.istr_argInformation.argType[li_arg] + &
//					"' que es desconocido o no soportado", StopSign!)
//			return -1
//	end choose
//next

return 1

end function

public function integer wf_postprint ();return 1
end function

public function integer wf_preprint ();if dw_report.dataObject = "" then
	dw_report.dataObject = dw_datos.dataObject
	return dw_datos.shareData(dw_report)
else
	return 1
end if

end function

public function integer wf_copyargs ();// check if the dw needs args
if pos(dw_datos.describe("DataWindow.Table.Select"), ":") > 0 then
	return this.wf_copyargs_basic()
end if

return 1
end function

on w_rep_reimprimir_nc_cxc.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.dw_1=create dw_1
this.dw_datos=create dw_datos
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_datos
this.Control[iCurrent+5]=this.dw_report
end on

on w_rep_reimprimir_nc_cxc.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.dw_datos)
destroy(this.dw_report)
end on

event open;date ld_hoy

this.ib_notautoretrieve = true
dw_datos.settransobject(sqlca)
dw_1.insertrow(0)
ld_hoy = date(f_hoy())
dw_1.setitem(1,"fecini",ld_hoy)
dw_1.setitem(1,"fecfin",ld_hoy)

call super::open

end event

event resize;call super::resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

type st_1 from statictext within w_rep_reimprimir_nc_cxc
integer x = 2290
integer y = 56
integer width = 334
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Movimiento:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rep_reimprimir_nc_cxc
integer x = 2651
integer y = 44
integer width = 343
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;Long ll_find

ll_find = dw_datos.find("cc_movim_mt_codigo = '"+sle_1.text+"'",1,dw_datos.rowcount())
if ll_find = 0 then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con est$$HEX1$$e100$$ENDHEX$$s condiciones...")
return
else
dw_datos.SelectRow(0, FALSE)
dw_datos.SelectRow(ll_find, TRUE)	
dw_datos.SetRow(ll_find)	
dw_datos.ScrollToRow(ll_find)
end if
end event

type dw_1 from datawindow within w_rep_reimprimir_nc_cxc
integer width = 3941
integer height = 216
integer taborder = 10
string dataobject = "d_ext_reimprimir_nc_cxc"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;date ld_fecini,ld_fecfin
long ll_nreg


ld_fecini = dw_1.getitemdate(row,"fecini")
ld_fecfin = dw_1.getitemdate(row,"fecfin")
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fecini,ld_fecfin)
If ll_nreg = 0 Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen Nota de Cr$$HEX1$$e900$$ENDHEX$$dito para este rango de fechas...<verif$$HEX1$$ed00$$ENDHEX$$que>")
	return
End if


//If dwo.name = 'b_1' Then
//ls_mtcodigo = dw_1.getitemstring(row,"numero")
//dw_1.modify("st_fecha.visible = '0' fecha.visible = '0'")
//dw_datos.dataobject = "d_reimp_nc_cxc_preimpresa"
//dw_datos.settransobject(sqlca)
//f_recupera_empresa(dw_datos,"fp_codigo")
//If isnull(ls_mtcodigo) Then
//	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Nota de Cr$$HEX1$$e900$$ENDHEX$$dito")
//	return
//End if
//ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo,'')
//If ll_nreg = 0 Then
//	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe n$$HEX1$$fa00$$ENDHEX$$mero de Nota de Cr$$HEX1$$e900$$ENDHEX$$dito...<verif$$HEX1$$ed00$$ENDHEX$$que>")
//	return
//End if
//lc_valor = dw_datos.getitemnumber(row,"cc_pagar")
//ls_valletras = f_numero_a_letras (lc_valor)
//dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_mtcodigo,ls_valletras)
//dw_datos.modify("datawindow.print.preview='yes'")
//End if
//
//If dwo.name = 'b_2' Then
//	dw_1.modify("st_fecha.visible = '1' fecha.visible = '1'")
//	ld_fecha = dw_1.getitemdate(row,"fecha")
//	setnull(ls_mtcodigo)
//    dw_1.setitem(row,"numero",ls_mtcodigo)	
//	If not isnull(ld_fecha) and is_band = true Then
//	  dw_datos.dataobject = "d_mostrar_nc_cxc_diarias"		
//  	  dw_datos.settransobject(sqlca)
//       f_recupera_empresa(dw_datos,"fp_codigo")		 
//	  dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fecha)
//	  is_band = false
//    End if
//	 dw_1.setcolumn(2)
//End if
//
end event

type dw_datos from uo_dw_basic within w_rep_reimprimir_nc_cxc
integer y = 216
integer width = 3945
integer height = 1244
integer taborder = 10
string dataobject = "d_mostrar_nc_cxc_diarias"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from datawindow within w_rep_reimprimir_nc_cxc
boolean visible = false
integer x = 137
integer y = 704
integer width = 242
integer height = 240
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_nc_cxc_preimpresa_redcolor"
borderstyle borderstyle = styleraised!
end type

event buttonclicked;dw_report.insertrow(0)
end event


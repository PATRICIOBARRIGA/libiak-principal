HA$PBExportHeader$w_rep_vtas_mensuales_detalladas.srw
$PBExportComments$Por Item, Fabricante, Clase
forward
global type w_rep_vtas_mensuales_detalladas from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_vtas_mensuales_detalladas
end type
type st_2 from statictext within w_rep_vtas_mensuales_detalladas
end type
type st_3 from statictext within w_rep_vtas_mensuales_detalladas
end type
type rb_1 from radiobutton within w_rep_vtas_mensuales_detalladas
end type
type rb_2 from radiobutton within w_rep_vtas_mensuales_detalladas
end type
type em_1 from editmask within w_rep_vtas_mensuales_detalladas
end type
type em_2 from editmask within w_rep_vtas_mensuales_detalladas
end type
type ddlb_1 from dropdownlistbox within w_rep_vtas_mensuales_detalladas
end type
end forward

global type w_rep_vtas_mensuales_detalladas from w_sheet_1_dw_rep
integer x = 9
integer y = 248
integer width = 2912
integer height = 1484
string title = "Resumen Mensual Ventas"
long backcolor = 81324524
st_1 st_1
st_2 st_2
st_3 st_3
rb_1 rb_1
rb_2 rb_2
em_1 em_1
em_2 em_2
ddlb_1 ddlb_1
end type
global w_rep_vtas_mensuales_detalladas w_rep_vtas_mensuales_detalladas

type variables
string   is_pepa
integer ii_index 
end variables

forward prototypes
public function integer wf_filtro_reporte (ref datawindow dw, ref string ls_filtro, string ls_reporte)
end prototypes

public function integer wf_filtro_reporte (ref datawindow dw, ref string ls_filtro, string ls_reporte);dw.Object.f.visible=False
dw.Object.nv.visible=False
dw.Object.nvf.visible=False
if ls_reporte='1'then
		dw_datos.Object.f.visible=True
		ls_filtro="estado='"+ls_reporte+"'"
else
		if ls_reporte='2' then
			dw_datos.Object.nv.visible=True
			ls_filtro="estado='"+ls_reporte+"'"
		else	
			dw_datos.Object.nvf.visible=True
			ls_filtro="estado like'%'"
		end if
end if			
return 1
end function

on w_rep_vtas_mensuales_detalladas.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_1=create em_1
this.em_2=create em_2
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.em_1
this.Control[iCurrent+7]=this.em_2
this.Control[iCurrent+8]=this.ddlb_1
end on

on w_rep_vtas_mensuales_detalladas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.ddlb_1)
end on

event open;this.ib_notautoretrieve = true
call super::open


end event

event ue_retrieve;integer li_estado
date fec_ini,fec_fin


if rb_1.checked then li_estado = 2
if rb_2.checked then li_estado = 1

fec_ini=date(em_1.text)
fec_fin=date(em_2.text)

SetPointer(HourGlass!)

choose case ii_index
	case 1
	dw_datos.DataObject='d_rep_cross_ventas_items'
	case 2
	dw_datos.DataObject='d_rep_cross_ventas_items_x_clase'	
	case 3
	dw_datos.DataObject='d_rep_cross_ventas_items_x_fabricante'
end choose
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' datawindow.print.preview.zoom=75~t datawindow.print.preview=yes")
dw_datos.SetTransObject(sqlca)
dw_datos.Retrieve(integer(str_appgeninfo.empresa),li_estado,fec_ini,fec_fin)
dw_datos.SetReDraw(True)
SetPointer(Arrow!)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_vtas_mensuales_detalladas
integer x = 0
integer y = 192
integer width = 2880
integer height = 1184
integer taborder = 70
string dataobject = "d_rep_cross_ventas_items"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_vtas_mensuales_detalladas
integer x = 1966
integer y = 756
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_vtas_mensuales_detalladas
end type

type st_1 from statictext within w_rep_vtas_mensuales_detalladas
integer x = 50
integer y = 56
integer width = 279
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
string text = "Reporte de:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_vtas_mensuales_detalladas
integer x = 1001
integer y = 56
integer width = 187
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

type st_3 from statictext within w_rep_vtas_mensuales_detalladas
integer x = 1582
integer y = 56
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
string text = "Hasta:"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_vtas_mensuales_detalladas
integer x = 2331
integer y = 24
integer width = 434
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "P.O.S"
end type

type rb_2 from radiobutton within w_rep_vtas_mensuales_detalladas
integer x = 2331
integer y = 100
integer width = 443
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Facturaci$$HEX1$$f300$$ENDHEX$$n"
boolean checked = true
end type

type em_1 from editmask within w_rep_vtas_mensuales_detalladas
integer x = 1189
integer y = 44
integer width = 343
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
end type

type em_2 from editmask within w_rep_vtas_mensuales_detalladas
integer x = 1751
integer y = 44
integer width = 352
integer height = 84
integer taborder = 40
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

type ddlb_1 from dropdownlistbox within w_rep_vtas_mensuales_detalladas
integer x = 338
integer y = 44
integer width = 599
integer height = 348
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
string item[] = {"Items","Items por Clase","Items por Fabricante"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_index = index
end event


HA$PBExportHeader$w_rep_facturas_ingresadas.srw
$PBExportComments$Si.Reporte de Facturas Ingresadas en una fecha dada.
forward
global type w_rep_facturas_ingresadas from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_facturas_ingresadas
end type
type st_2 from statictext within w_rep_facturas_ingresadas
end type
type em_desde from editmask within w_rep_facturas_ingresadas
end type
type em_hasta from editmask within w_rep_facturas_ingresadas
end type
end forward

global type w_rep_facturas_ingresadas from w_sheet_1_dw_rep
integer x = 5
integer y = 300
integer width = 2935
integer height = 1800
string title = "Facturas de Compra Ingresadas"
long backcolor = 79741120
st_1 st_1
st_2 st_2
em_desde em_desde
em_hasta em_hasta
end type
global w_rep_facturas_ingresadas w_rep_facturas_ingresadas

on w_rep_facturas_ingresadas.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.em_desde=create em_desde
this.em_hasta=create em_hasta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_desde
this.Control[iCurrent+4]=this.em_hasta
end on

on w_rep_facturas_ingresadas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_desde)
destroy(this.em_hasta)
end on

event open;datawindowchild ldwc_sucursal,ldwc_proveedor

this.ib_notautoretrieve = true

dw_datos.getchild('su_codigo',ldwc_sucursal)
ldwc_sucursal.settransobject(sqlca)
ldwc_sucursal.retrieve('1')

dw_datos.getchild('pv_codigo',ldwc_proveedor)  
ldwc_proveedor.settransobject(sqlca)
ldwc_proveedor.retrieve('1')

//dw_cabecera.settransobject(sqlca)
//dw_cabecera.insertrow(0)
call super::open
end event

event ue_retrieve;long ll_filas
date ld_fecha_ini,ld_fecha_fin
string ls_empresa

ld_fecha_ini = DATE(em_desde.TEXT)
ld_fecha_fin = DATE(em_hasta.TEXT)

if ( em_desde.text = "" or isnull(em_desde.text) ) or &
   ( em_hasta.text = "" or isnull(em_hasta.text) ) then
	messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","Deber registrar los rangos de fechas.")
else
	if ld_fecha_ini > ld_fecha_fin then
		messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","Deber registrar los rangos de fechas en forma correcta.")
	else
		
		dw_datos.object.fecha_ini.text = string(em_desde.TEXT)
		dw_datos.object.fecha_fin.text = string(em_hasta.TEXT)

		SELECT EM_NOMBRE
		INTO:ls_empresa
		FROM PR_EMPRE
		WHERE EM_CODIGO = :str_appgeninfo.empresa;
		If sqlca.sqlcode = 100 Then
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Empresa no encontrada "+sqlca.sqlerrtext)
			return
		End if
		dw_datos.object.st_empresa.text = ls_empresa		
		ll_filas = dw_datos.retrieve(str_appgeninfo.empresa,ld_fecha_ini,ld_fecha_fin)
		if ll_filas < 1 then
			messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","No existe datos que se pueda desplegar.")
		end if
	end if
end if

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_facturas_ingresadas
integer x = 37
integer y = 164
integer width = 2825
integer height = 1504
integer taborder = 40
string dataobject = "dw_facturas_de_compra_por_fecha"
boolean border = true
boolean hsplitscroll = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_facturas_ingresadas
integer x = 142
integer y = 1112
integer width = 763
integer height = 324
integer taborder = 50
end type

type st_1 from statictext within w_rep_facturas_ingresadas
integer x = 64
integer y = 44
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 81324524
boolean enabled = false
string text = "Desde : "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_facturas_ingresadas
integer x = 709
integer y = 44
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 81324524
boolean enabled = false
string text = "Hasta: "
alignment alignment = center!
boolean focusrectangle = false
end type

type em_desde from editmask within w_rep_facturas_ingresadas
integer x = 311
integer y = 44
integer width = 343
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
string displaydata = ""
end type

type em_hasta from editmask within w_rep_facturas_ingresadas
integer x = 965
integer y = 44
integer width = 343
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
string displaydata = ""
end type


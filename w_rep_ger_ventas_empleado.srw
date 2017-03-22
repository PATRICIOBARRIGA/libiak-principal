HA$PBExportHeader$w_rep_ger_ventas_empleado.srw
$PBExportComments$Venta por Vendedor
forward
global type w_rep_ger_ventas_empleado from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_ger_ventas_empleado
end type
end forward

global type w_rep_ger_ventas_empleado from w_sheet_1_dw_rep
integer x = 9
integer y = 248
integer width = 2912
integer height = 1484
string title = "Resumen Mensual Ventas"
long backcolor = 81324524
dw_1 dw_1
end type
global w_rep_ger_ventas_empleado w_rep_ger_ventas_empleado

type variables
string   is_pepa 
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

on w_rep_ger_ventas_empleado.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_ger_ventas_empleado.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;date fec_ini,fec_fin
dw_1.InsertRow(0)
//f_recupera_empresa(dw_1,'cliente')
//f_recupera_empresa(dw_1,'clase')
//f_recupera_empresa(dw_1,'vendedor')
this.ib_notautoretrieve = true
call super::open


end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;string ls_reporte,ls_estado
long ll_fila
date fec_ini,fec_fin

dw_1.AcceptText()
ll_fila = dw_1.getrow()
ls_reporte=dw_1.GetItemString(ll_fila,'reporte')
ls_estado =dw_1.GetItemString(ll_fila,'pos') 
fec_ini=dw_1.GetItemDate(ll_fila,'fec_ini')
fec_fin=dw_1.GetItemDate(ll_fila,'fec_fin')

//dw_datos.SetReDraw(False)
SetPointer(HourGlass!)

choose case ls_reporte
	case 'A' 
	dw_datos.DataObject='d_rep_cross_ventas_empleado'
	case 'C'//CE cliente y empleado
	dw_datos.DataObject='d_rep_cross_ventas_cliente'	
	case 'F'
	dw_datos.DataObject='d_rep_cross_ventas_fabricante'
 
end choose
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' datawindow.print.preview.zoom=75~t datawindow.print.preview=yes")
dw_datos.SetTransObject(sqlca)
dw_datos.Retrieve(integer(str_appgeninfo.empresa),integer(ls_estado),fec_ini,fec_fin)
dw_datos.SetReDraw(True)
SetPointer(Arrow!)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ger_ventas_empleado
integer x = 0
integer y = 192
integer width = 2880
integer height = 1184
string dataobject = "d_rep_cross_ventas_empleado"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ger_ventas_empleado
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_ger_ventas_empleado
end type

type dw_1 from datawindow within w_rep_ger_ventas_empleado
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 2912
integer height = 208
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rep_ger_ventas_empleado"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event losefocus;//date    ld_fecha
//string  ls_fecha
//
//ld_fecha = dw_1.GetItemDate(1,"fecha_corte")
//ls_fecha = string(ld_fecha,"dd/mm/yyyy")
//declare rp_kardex_sucur procedure for
//  rp_kardex_sucur(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:is_pepa,:ls_fecha)
//  using sqlca;
//execute rp_kardex_sucur;
//if sqlca.sqldbcode <> 0 then
//	MessageBox("ERROR","El proceso no se ejecut$$HEX2$$f3002000$$ENDHEX$$o se ejecut$$HEX2$$f3002000$$ENDHEX$$mal.");
//	Return(1);
//end if
//dw_report.retrieve()
//dw_report.SetFocus()
end event

event buttonclicked;parent.triggerevent("ue_retrieve")
end event


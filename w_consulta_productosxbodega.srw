HA$PBExportHeader$w_consulta_productosxbodega.srw
$PBExportComments$Consulta de productos en todas las bodegas de la sucursal.
forward
global type w_consulta_productosxbodega from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_consulta_productosxbodega
end type
end forward

global type w_consulta_productosxbodega from w_sheet_1_dw_maint
integer x = 5
integer y = 300
integer width = 2656
integer height = 1384
string title = "Consulta de Productos por Bodega"
long backcolor = 79741120
dw_1 dw_1
end type
global w_consulta_productosxbodega w_consulta_productosxbodega

on w_consulta_productosxbodega.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_consulta_productosxbodega.destroy
call super::destroy
destroy(this.dw_1)
end on

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event open;this.ib_notautoretrieve = true
dw_1.SetTransObject(sqlca)
dw_1.InsertRow(0)
call super::open

end event

event ue_retrieve;beep(1)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_consulta_productosxbodega
integer y = 300
integer width = 2629
integer height = 980
string dataobject = "d_consulta_productosxbodega"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_consulta_productosxbodega
end type

type dw_1 from datawindow within w_consulta_productosxbodega
integer x = 5
integer width = 2619
integer height = 300
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_stock_productos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;string ls_filtro=' ',ls_cod_producto,ls_producto,ls_cod_clase,ls_1=' ',ls_2=' ',fabricante
string lc_stock,ls_fab,ls_cod1,ls_cod2
dw_1.AcceptText()
dw_datos.SetReDraw(false)
SetPointer(HourGlass!)
ls_cod_producto = GetItemString(row,'codigo_producto')
ls_producto = GetItemString(row,'producto')
ls_cod_clase = GetItemString(row,'codigo_clase')
ls_cod1=GetItemString(row,'cod1')
ls_cod2=GetItemString(row,'cod2')

//if isnull(ls_cod_producto) then
//	ls_filtro="codigo_producto like '%')"
//else
//	ls_filtro="codigo_producto like '"+ls_cod_producto+"')"
//end if
//
//if not isnull(ls_producto) or ls_producto<>'' then
//	ls_filtro=ls_filtro+"and (producto like '"+ls_producto+"')"
//end if
//if not isnull(ls_cod_clase) or ls_cod_clase<>'' then
//	ls_filtro=ls_filtro+"and (codigo_clase like '"+ls_cod_clase+"')"
//end if
Choose Case GetColumnName()
	case 'cod1'
		if (isnull(data) or data='') or isnull(ls_cod2) or ls_cod2='' then
			messageBox('Error','Falta ingresar c$$HEX1$$f300$$ENDHEX$$digo de b$$HEX1$$fa00$$ENDHEX$$squeda')
			dw_datos.SetReDraw(True)
			SetPointer(Arrow!)	
			return
		else
			retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,data,ls_cod2)
		end if
	case 'cod2'
		if (isnull(ls_cod1) or ls_cod1='') or isnull(data) or data='' then
			messageBox('Error','Falta ingresar c$$HEX1$$f300$$ENDHEX$$digo de b$$HEX1$$fa00$$ENDHEX$$squeda')
			dw_datos.SetReDraw(True)
			SetPointer(Arrow!)	
			return
		else
			retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cod1,data)
		end if
		
end choose
dw_datos.ScrollToRow(1)
//dw_datos.SetFilter(ls_filtro)
//dw_datos.Filter()
//dw_datos.GroupCalc()
dw_datos.SetReDraw(True)
SetPointer(Arrow!)
end event


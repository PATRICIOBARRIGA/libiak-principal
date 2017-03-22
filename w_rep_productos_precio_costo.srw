HA$PBExportHeader$w_rep_productos_precio_costo.srw
$PBExportComments$Listado de productos con precio y costo
forward
global type w_rep_productos_precio_costo from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_productos_precio_costo
end type
end forward

global type w_rep_productos_precio_costo from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2935
integer height = 1436
string title = "Costo/Precio Productos"
long backcolor = 1090519039
dw_1 dw_1
end type
global w_rep_productos_precio_costo w_rep_productos_precio_costo

type variables
string   is_pepa 
end variables

on w_rep_productos_precio_costo.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_productos_precio_costo.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_1.InsertRow(0)
this.ib_notautoretrieve = true
call super::open
this.ib_inReportMode = True
SetPointer(HourGlass!)
dw_datos.SetRedraw(False)
dw_report.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
dw_report.SetTransObject(sqlca)
dw_datos.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal)
dw_report.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,str_appgeninfo.seccion)
SetPointer(Arrow!)
dw_datos.SetRedraw(True)
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
dw_report.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_print;int li_rc
if dw_datos.visible=True then
	openwithparm(w_dw_print_options,dw_datos)
	li_rc = message.DoubleParm
//gi_print = 0
	if li_rc = 1 then
   	dw_datos.print()	
	end if
elseif dw_report.visible=True then
	openwithparm(w_dw_print_options,dw_report)
	li_rc = message.DoubleParm
//gi_print = 0
	if li_rc = 1 then
   	dw_report.print()	
	end if
end if
end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_productos_precio_costo
integer x = 0
integer y = 224
integer width = 2903
integer height = 1108
integer taborder = 20
string dataobject = "d_rep_prod_suc_precio_costo"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_productos_precio_costo
integer y = 188
integer width = 2903
integer height = 1160
integer taborder = 30
string dataobject = "d_rep_productos_precio_costo"
end type

type dw_1 from datawindow within w_rep_productos_precio_costo
integer width = 2898
integer height = 224
integer taborder = 10
string dataobject = "d_sel_lista_precios"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;string ls_filtro=' ',ls_cod_producto,ls_producto,ls_cod_clase,ls_1=' ',ls_2=' '
dw_1.AcceptText()
choose case this.getcolumnname()
case 'codigo_producto'
	  	this.SetItem(row,'producto',' ')
		this.SetItem(row,'codigo_clase',' ')
		this.SetItem(row,'stock',' ')
		ls_filtro="codigo_producto like '"+ data +"' "
		dw_datos.SetFilter(ls_filtro)
		dw_report.SetFilter(ls_filtro)
		dw_datos.Filter()
		dw_report.Filter()
		dw_datos.GroupCalc()
		dw_report.GroupCalc()		
case 'stock'
	  	this.SetItem(row,'producto',' ')
	  	this.SetItem(row,'codigo_producto',' ')		  
		this.SetItem(row,'codigo_clase',' ')
		ls_filtro="stock "+ data 
//		cust_qty > 100 and cust_code >30
		dw_datos.SetFilter(ls_filtro)
		dw_report.SetFilter(ls_filtro)
		dw_datos.Filter()
		dw_report.Filter()
		dw_datos.GroupCalc()
		dw_report.GroupCalc()			
case 'producto'
		this.SetItem(row,'codigo_producto',' ')
		this.SetItem(row,'codigo_clase',' ')	
		this.SetItem(row,'stock',' ')
		ls_filtro="producto like '"+ data +"' "
		dw_datos.SetFilter(ls_filtro)
		dw_report.SetFilter(ls_filtro)
		dw_datos.Filter()
		dw_report.Filter()
		dw_datos.GroupCalc()
		dw_report.GroupCalc()
case 'codigo_clase'
		ls_filtro="cl_codigo like '"+ data +"'"
		this.SetItem(row,'codigo_producto',' ')
		this.SetItem(row,'producto',' ')	
		this.SetItem(row,'stock',' ')
		dw_datos.SetFilter(ls_filtro)
		dw_report.SetFilter(ls_filtro)
		dw_datos.Filter()
		dw_report.Filter()
		dw_datos.GroupCalc()
		dw_report.GroupCalc()
case 'tipo'
	if data='BODEGA' then 
		this.SetItem(row,'codigo_producto',' ')
		this.SetItem(row,'producto',' ')	
		this.SetItem(row,'codigo_clase',' ')		
		this.SetItem(row,'stock',' ')		
	   dw_report.visible=True
		dw_datos.visible=False
		ls_filtro="bodega='"+str_appgeninfo.seccion+"'"
		dw_report.SetFilter(ls_filtro)
		dw_report.Filter()
		dw_report.GroupCalc()
	else//Sucursal
		dw_report.visible=False
		dw_datos.visible=True
	end if
	
END CHOOSE

end event

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


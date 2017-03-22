HA$PBExportHeader$w_rep_productos_bodegasxsucursal.srw
forward
global type w_rep_productos_bodegasxsucursal from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_productos_bodegasxsucursal
end type
end forward

global type w_rep_productos_bodegasxsucursal from w_sheet_1_dw_rep
int X=97
int Y=261
int Width=2725
int Height=1465
boolean TitleBar=true
string Title="Productos por Sucursal"
long BackColor=1090519039
dw_1 dw_1
end type
global w_rep_productos_bodegasxsucursal w_rep_productos_bodegasxsucursal

on w_rep_productos_bodegasxsucursal.create
int iCurrent
call w_sheet_1_dw_rep::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_rep_productos_bodegasxsucursal.destroy
call w_sheet_1_dw_rep::destroy
destroy(this.dw_1)
end on

event open;DataWindowChild   ldwc_aux,ldwc_aux1

dw_report.SetTransObject(sqlca)
dw_1.InsertRow(0)
//dw_1.SetItem(1,"sucursal",'1') 
//dw_1.SetText('Matriz') //por default
//dw_1.GetChild("sucursal",ldwc_aux)
//ldwc_aux.setTransObject(sqlca)
//ldwc_aux.Retrieve("1")
dw_1.SetItem(1,"clase",'01') 
dw_1.GetChild("clase",ldwc_aux1)
ldwc_aux1.setTransObject(sqlca)
ldwc_aux1.Retrieve("01")
istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = '1' //empresa
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[2] = '1' //sucursal
call super::open
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_productos_bodegasxsucursal
int X=5
int Y=153
int Width=2684
int Height=1209
string DataObject="d_productosxbodegas"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_productos_bodegasxsucursal
int TabOrder=30
boolean BringToTop=true
end type

type dw_1 from datawindow within w_rep_productos_bodegasxsucursal
int X=5
int Width=2689
int Height=141
int TabOrder=20
boolean BringToTop=true
string DataObject="d_productosxclase"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

event itemchanged;string ls_filtro=' ',ls_cod_producto,ls_producto,ls_cod_clase,ls_1=' ',ls_2=' ',ls_sucursal

dw_1.AcceptText()
choose case this.getcolumnname()
case 'producto'
		this.SetItem(row,'clase',' ')
		ls_filtro="it_codant = '"+ data +"' "
		dw_datos.SetFilter(ls_filtro)
		dw_report.SetFilter(ls_filtro)
		dw_datos.Filter()
		dw_report.Filter()
		dw_datos.GroupCalc()
		dw_report.GroupCalc()		
case 'clase'
		ls_filtro="cl_codigo like '"+ data +"'"
		this.SetItem(row,'producto',' ')	
		dw_datos.SetFilter(ls_filtro)
		dw_report.SetFilter(ls_filtro)
		dw_datos.Filter()
		dw_report.Filter()
		dw_datos.GroupCalc()
		dw_report.GroupCalc()
	
END CHOOSE

//ls_sucursal = this.GetItemString(row,'sucursal')
//istr_argInformation.nrArgs = 2
//istr_argInformation.argType[1] = "string"
//istr_argInformation.StringValue[1] = str_appgeninfo.empresa //empresa 
//istr_argInformation.argType[2] = "string"
//istr_argInformation.StringValue[2] = ls_sucursal //sucursal
end event


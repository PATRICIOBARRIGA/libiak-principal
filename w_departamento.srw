HA$PBExportHeader$w_departamento.srw
$PBExportComments$Si.Departamentos de una sucursal
forward
global type w_departamento from w_sheet_1_dw_maint
end type
end forward

global type w_departamento from w_sheet_1_dw_maint
int Width=1340
int Height=1353
boolean TitleBar=true
string Title="Departamentos de la Empresa"
long BackColor=1090519039
end type
global w_departamento w_departamento

event open;datawindowchild dwc
istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "dt_codigo"
dw_datos.is_SerialCodeType = "COD_DEP"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
dw_datos.SetRowFocusIndicator(hand!)
call super::open
end event

on w_departamento.create
call w_sheet_1_dw_maint::create
end on

on w_departamento.destroy
call w_sheet_1_dw_maint::destroy
end on

event resize;call super::resize;//dataWindow ldw_aux
//
//if this.ib_inReportMode then
//	ldw_aux = dw_report
//	ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight() - 2*ldw_aux.y)
//else
//	ldw_aux = dw_datos
//	ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight())// - 2*ldw_aux.y)
//
//end if
//
//
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_departamento
int Y=1
int Width=1303
int Height=1253
string DataObject="d_departamento"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
CHOOSE CASE this.getcolumnname()
	CASE 'dt_descri'
		this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
END CHOOSE
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_departamento
boolean BringToTop=true
end type


HA$PBExportHeader$w_marca.srw
$PBExportComments$Si.Definicion de marcas de los productos
forward
global type w_marca from w_sheet_1_dw_maint
end type
end forward

global type w_marca from w_sheet_1_dw_maint
int Width=1532
int Height=1321
boolean TitleBar=true
string Title="Marcas de productos"
long BackColor=1090519039
end type
global w_marca w_marca

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "ma_codigo"
dw_datos.is_SerialCodeType = "COD_MAR"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
call super::open
end event

on w_marca.create
call w_sheet_1_dw_maint::create
end on

on w_marca.destroy
call w_sheet_1_dw_maint::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_marca
int Y=1
int Width=1500
int Height=1217
string DataObject="d_marca_items"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_marca
boolean BringToTop=true
end type


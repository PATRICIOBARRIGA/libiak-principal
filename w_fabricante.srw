HA$PBExportHeader$w_fabricante.srw
$PBExportComments$Si.Definic$$HEX1$$f300$$ENDHEX$$n de fabricantes de los items
forward
global type w_fabricante from w_sheet_1_dw_maint
end type
end forward

global type w_fabricante from w_sheet_1_dw_maint
integer width = 1344
integer height = 1352
string title = "Fabricantes de Productos "
long backcolor = 1090519039
end type
global w_fabricante w_fabricante

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
 
dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "fb_codigo"
dw_datos.is_SerialCodeType = "COD_FAB"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
call super::open
end event

on w_fabricante.create
call super::create
end on

on w_fabricante.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_fabricante
integer width = 1303
integer height = 1240
string dataobject = "d_fabricante_items"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_fabricante
end type


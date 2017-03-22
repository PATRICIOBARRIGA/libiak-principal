HA$PBExportHeader$w_color.srw
$PBExportComments$Si.Definic$$HEX1$$f300$$ENDHEX$$n de colores de los items
forward
global type w_color from w_sheet_1_dw_maint
end type
end forward

global type w_color from w_sheet_1_dw_maint
integer width = 1275
integer height = 1080
string title = "Colores de productos"
long backcolor = 67108864
end type
global w_color w_color

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "co_codigo"
dw_datos.is_SerialCodeType = "COD_COL"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

call super::open
end event

on w_color.create
call super::create
end on

on w_color.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_color
integer y = 28
integer width = 1225
integer height = 928
string dataobject = "d_color_items"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_color
integer x = 119
integer y = 584
integer width = 882
end type


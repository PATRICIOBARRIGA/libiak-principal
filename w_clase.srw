HA$PBExportHeader$w_clase.srw
$PBExportComments$Si.Definici$$HEX1$$f300$$ENDHEX$$n de departamentos y subdepartamentos de los productos
forward
global type w_clase from w_sheet_1_dw_maint
end type
end forward

global type w_clase from w_sheet_1_dw_maint
int Width=2766
int Height=1273
boolean TitleBar=true
string Title="Departamentos de productos "
long BackColor=1090519039
end type
global w_clase w_clase

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
f_recupera_empresa(dw_datos,"cl_codpad") 
f_recupera_empresa(dw_datos,"pl_codigo") 
dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if

call super::open
end event

on w_clase.create
call w_sheet_1_dw_maint::create
end on

on w_clase.destroy
call w_sheet_1_dw_maint::destroy
end on

event ue_retrieve;call super::ue_retrieve;f_recupera_empresa(dw_datos,"cl_codpad") 
f_recupera_empresa(dw_datos,"pl_codigo") 
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_clase
int Width=2730
int Height=1165
string DataObject="d_clase_items"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_clase
boolean BringToTop=true
end type


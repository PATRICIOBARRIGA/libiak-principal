HA$PBExportHeader$w_ingreso_labels_hoja_tecnica.srw
$PBExportComments$Si.Ingreso de los labels de la hoja t$$HEX1$$e900$$ENDHEX$$cnica.
forward
global type w_ingreso_labels_hoja_tecnica from w_sheet_1_dw_maint
end type
end forward

global type w_ingreso_labels_hoja_tecnica from w_sheet_1_dw_maint
int Width=1367
int Height=1389
boolean TitleBar=true
string Title="Etiquetas de Hojas T$$HEX1$$e900$$ENDHEX$$cnicas"
long BackColor=1090519039
end type
global w_ingreso_labels_hoja_tecnica w_ingreso_labels_hoja_tecnica

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
dw_datos.SetTransObject(sqlca)
if dw_datos.Retrieve(str_appgeninfo.empresa) < 0 then
	dw_datos.InsertRow(0)
end if
dw_datos.is_SerialCodeColumn = "lh_codigo"
dw_datos.is_SerialCodeType = "COD_LABELS"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa
call super::open
end event

on w_ingreso_labels_hoja_tecnica.create
call w_sheet_1_dw_maint::create
end on

on w_ingreso_labels_hoja_tecnica.destroy
call w_sheet_1_dw_maint::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ingreso_labels_hoja_tecnica
int Width=1331
int Height=1285
string DataObject="d_ingreso_labels_hoja_tecnica"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_ingreso_labels_hoja_tecnica
boolean BringToTop=true
end type


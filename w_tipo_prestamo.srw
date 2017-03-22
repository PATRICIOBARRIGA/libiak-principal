HA$PBExportHeader$w_tipo_prestamo.srw
$PBExportComments$Si.Tipos de prestamos de los empleados
forward
global type w_tipo_prestamo from w_sheet_1_dw_maint
end type
end forward

global type w_tipo_prestamo from w_sheet_1_dw_maint
int Width=2030
int Height=1389
boolean TitleBar=true
string Title="Tipo de Prestamo"
long BackColor=1090519039
end type
global w_tipo_prestamo w_tipo_prestamo

event open;call super::open;dw_datos.is_SerialCodeColumn = "tp_codigo"
dw_datos.is_SerialCodeType = "COD_TIPRES"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa


end event

on w_tipo_prestamo.create
call w_sheet_1_dw_maint::create
end on

on w_tipo_prestamo.destroy
call w_sheet_1_dw_maint::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_tipo_prestamo
int Y=1
int Width=1998
int Height=1285
string DataObject="d_tipo_prestamo"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_tipo_prestamo
boolean BringToTop=true
end type


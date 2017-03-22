HA$PBExportHeader$w_cargo.srw
$PBExportComments$Si.cargos de los empleados
forward
global type w_cargo from w_sheet_1_dw_maint
end type
end forward

global type w_cargo from w_sheet_1_dw_maint
int Width=2739
int Height=1389
boolean TitleBar=true
string Title="Cargos de los empleados"
long BackColor=1090519039
end type
global w_cargo w_cargo

event open;call super::open;dw_datos.is_SerialCodeColumn = "cr_codigo"
dw_datos.is_SerialCodeType = "COD_CARGO"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

end event

on w_cargo.create
call w_sheet_1_dw_maint::create
end on

on w_cargo.destroy
call w_sheet_1_dw_maint::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_cargo
int Y=1
int Width=2707
int Height=1285
string DataObject="d_cargo"
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_cargo
boolean BringToTop=true
end type


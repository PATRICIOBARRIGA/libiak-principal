HA$PBExportHeader$w_parentezco.srw
$PBExportComments$Si.Parentezco de los empleados
forward
global type w_parentezco from w_sheet_1_dw_maint
end type
end forward

global type w_parentezco from w_sheet_1_dw_maint
int Width=1253
int Height=1389
boolean TitleBar=true
string Title="Lista de Parentezcos"
long BackColor=1090519039
end type
global w_parentezco w_parentezco

event open;call super::open;dw_datos.is_SerialCodeColumn = "pf_codigo"
dw_datos.is_SerialCodeType = "COD_PARENT"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa

end event

on w_parentezco.create
call w_sheet_1_dw_maint::create
end on

on w_parentezco.destroy
call w_sheet_1_dw_maint::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_parentezco
int Y=1
int Width=1217
int Height=1285
string DataObject="d_parentezco"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_parentezco
boolean BringToTop=true
end type


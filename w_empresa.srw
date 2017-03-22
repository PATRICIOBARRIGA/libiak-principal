HA$PBExportHeader$w_empresa.srw
forward
global type w_empresa from w_sheet_1_dw_maint
end type
end forward

global type w_empresa from w_sheet_1_dw_maint
integer width = 2153
integer height = 1936
string title = "Empresa"
long backcolor = 1090519039
end type
global w_empresa w_empresa

event open;string ls_parametro[]

ls_parametro[1] = '1' //ecuador por default
f_recupera_datos(dw_datos,"cu_codigo",ls_parametro,1) 
dw_datos.SetTransObject(sqlca)

if dw_datos.Retrieve() < 0 then
	dw_datos.InsertRow(0)
end if

call super::open
dw_datos.is_SerialCodeColumn = "em_codigo"
dw_datos.is_SerialCodeType = "COD_EMPR"
end event

on w_empresa.create
call super::create
end on

on w_empresa.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_empresa
integer y = 0
integer width = 2121
integer height = 1832
string dataobject = "d_empresa"
end type

event dw_datos::itemchanged;call super::itemchanged;long   ll_filact
string ls_pais[], ls_null

CHOOSE CASE this.GetColumnName()
	CASE "pa_codigo"
		ls_pais[1] = this.GetText()
		setnull(ls_null)
		this.SetItem(ll_filact,"cu_codigo",ls_null)
		f_recupera_datos(dw_datos,"cu_codigo",ls_pais,1)
END CHOOSE
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_empresa
integer x = 23
integer y = 284
integer width = 462
end type


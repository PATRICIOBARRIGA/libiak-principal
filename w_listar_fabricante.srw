HA$PBExportHeader$w_listar_fabricante.srw
forward
global type w_listar_fabricante from w_response_basic
end type
end forward

global type w_listar_fabricante from w_response_basic
integer height = 1060
string title = "Lista de Fabricantes"
end type
global w_listar_fabricante w_listar_fabricante

on w_listar_fabricante.create
call super::create
end on

on w_listar_fabricante.destroy
call super::destroy
end on

event open;call super::open;dw_response.settransobject(sqlca)
dw_response.retrieve(str_appgeninfo.empresa)
end event

type pb_cancel from w_response_basic`pb_cancel within w_listar_fabricante
integer x = 1070
integer y = 784
end type

type pb_ok from w_response_basic`pb_ok within w_listar_fabricante
integer x = 261
integer y = 784
end type

type dw_response from w_response_basic`dw_response within w_listar_fabricante
integer x = 32
integer y = 36
integer height = 720
string dataobject = "d_lista_fabricante"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type


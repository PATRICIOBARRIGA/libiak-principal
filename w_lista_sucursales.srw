HA$PBExportHeader$w_lista_sucursales.srw
forward
global type w_lista_sucursales from w_response_basic
end type
end forward

global type w_lista_sucursales from w_response_basic
integer width = 1952
integer height = 1060
string title = "Lista de Fabricantes"
end type
global w_lista_sucursales w_lista_sucursales

on w_lista_sucursales.create
call super::create
end on

on w_lista_sucursales.destroy
call super::destroy
end on

event open;call super::open;dw_response.settransobject(sqlca)
dw_response.retrieve(str_appgeninfo.empresa)
end event

type pb_cancel from w_response_basic`pb_cancel within w_lista_sucursales
integer x = 1504
integer y = 784
end type

type pb_ok from w_response_basic`pb_ok within w_lista_sucursales
integer x = 283
integer y = 776
end type

type dw_response from w_response_basic`dw_response within w_lista_sucursales
integer x = 32
integer y = 36
integer width = 1883
integer height = 720
string dataobject = "d_lista_sucursales"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type


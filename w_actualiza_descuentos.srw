HA$PBExportHeader$w_actualiza_descuentos.srw
$PBExportComments$Si.Actualizar precios, descuentos, y otros campos de los productos
forward
global type w_actualiza_descuentos from w_sheet_1_dw_maint
end type
end forward

global type w_actualiza_descuentos from w_sheet_1_dw_maint
end type
global w_actualiza_descuentos w_actualiza_descuentos

on w_actualiza_descuentos.create
call super::create
end on

on w_actualiza_descuentos.destroy
call super::destroy
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_actualiza_descuentos
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_actualiza_descuentos
end type


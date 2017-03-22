HA$PBExportHeader$w_rubro_calculados.srw
$PBExportComments$Si.Ingreso de la f$$HEX1$$f300$$ENDHEX$$rmula para los rubros calculados.
forward
global type w_rubro_calculados from w_sheet_1_dw_maint
end type
end forward

global type w_rubro_calculados from w_sheet_1_dw_maint
int Width=2679
int Height=661
boolean TitleBar=true
string Title="Rubros Calculados"
long BackColor=12632256
end type
global w_rubro_calculados w_rubro_calculados

event open;datawindowChild ldw
f_recupera_empresa(dw_datos,'ru_codigo')
dw_datos.Getchild('ru_codigo',ldw)
ldw.Setfilter("ru_tipcam='C' or ru_tipcam='A' ") // solo aparecen los rubros
				// calculado o que son calculados con ajuste manual
ldw.Filter()				
call super::open


end event

on w_rubro_calculados.create
call w_sheet_1_dw_maint::create
end on

on w_rubro_calculados.destroy
call w_sheet_1_dw_maint::destroy
end on

event ue_retrieve;datawindowChild ldw
f_recupera_empresa(dw_datos,'ru_codigo')
dw_datos.Getchild('ru_codigo',ldw)
ldw.Setfilter("ru_tipcam='C' or ru_tipcam='A' ") // solo aparecen los rubros
				// calculado o que son calculados con ajuste manual
ldw.Filter()	
call super::open
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_rubro_calculados
int Y=1
int Width=2647
int Height=561
string DataObject="d_rubros_calculados"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
end type

event dw_datos::ue_preinsert;call super::ue_preinsert;datawindowChild ldw
dw_datos.Getchild('ru_codigo',ldw)
ldw.Setfilter("ru_tipcam='C' or ru_tipcam='A' ")
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_rubro_calculados
boolean BringToTop=true
end type


HA$PBExportHeader$w_rep_stocks.srw
$PBExportComments$Si.
forward
global type w_rep_stocks from w_sheet_1_dw_rep
end type
end forward

global type w_rep_stocks from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 3086
integer height = 1964
string title = "Stock de Productos"
boolean resizable = false
end type
global w_rep_stocks w_rep_stocks

type variables
string   is_pepa 
end variables

on w_rep_stocks.create
call super::create
end on

on w_rep_stocks.destroy
call super::destroy
end on

event open;this.ib_notautoretrieve = true
call super::open
end event

event ue_print;int li_rc

openwithparm(w_dw_print_options,dw_datos)
li_rc = message.DoubleParm
if li_rc = 1 then	dw_datos.print()	

end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

event ue_sort;return 1
end event

event activate;call super::activate;m_marco.m_archivo.m_imprimir.visible = true
m_marco.m_archivo.m_imprimir.enabled = true
m_marco.m_archivo.m_imprimir.toolBarItemVisible =true

end event

event ue_retrieve;setpointer(hourglass!)
dw_datos.settransobject(sqlca)


If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para que la informaci$$HEX1$$f300$$ENDHEX$$n solicitada sea correcta se recomienda correr el proceso RECALCULAR ITEMS... Desea hacerlo en este momento...?",Question!,YesNo!,1 ) = 1 then
   	 open(w_diferencia_stocks )
end if


dw_datos.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal, str_appgeninfo.seccion)
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
w_marco.setmicrohelp("Consulta Terminada")
setpointer(arrow!)										

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_stocks
integer x = 0
integer y = 4
integer width = 3049
integer height = 1828
integer taborder = 20
string dataobject = "d_rep_lista_stock"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_stocks
integer y = 276
integer width = 475
integer height = 468
integer taborder = 30
end type

event dw_report::rbuttondown;return 1
end event

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_stocks
end type


HA$PBExportHeader$w_rep_productoxbodega.srw
$PBExportComments$Si.
forward
global type w_rep_productoxbodega from w_sheet_1_dw_rep
end type
end forward

global type w_rep_productoxbodega from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 3136
integer height = 1912
string title = "Stock de Productos"
end type
global w_rep_productoxbodega w_rep_productoxbodega

type variables
string   is_pepa 
end variables

on w_rep_productoxbodega.create
call super::create
end on

on w_rep_productoxbodega.destroy
call super::destroy
end on

event open;this.ib_notautoretrieve = true
call super::open
this.ib_inReportMode = True
dw_report.modify("datawindow.print.preview.zoom=75~t" + &
									"datawindow.print.preview=yes")
dw_datos.SetTransObject(sqlca)

end event

event resize;call super::resize;//int li_width, li_height
//
//li_width = this.workSpaceWidth()
//li_height = this.workSpaceHeight()
//
//this.setRedraw(False)
//dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
//dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
//dw_report.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
//this.setRedraw(True)

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

event ue_retrieve;
If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para que la informaci$$HEX1$$f300$$ENDHEX$$n solicitada sea correcta se recomienda correr el proceso RECALCULAR ITEMS... Desea hacerlo en este momento...?",Question!,YesNo!,1 ) = 1 then
   	 open(w_diferencia_stocks )
end if

dw_datos.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal )
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_productoxbodega
integer x = 0
integer y = 12
integer width = 3090
integer height = 1796
integer taborder = 20
string dataobject = "d_consulta_productosxbodega"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_productoxbodega
integer y = 248
integer width = 2903
integer height = 1160
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_productoxbodega
end type


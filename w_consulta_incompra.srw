HA$PBExportHeader$w_consulta_incompra.srw
$PBExportComments$Si.Consulta Ordenes de compra, notas de recepci$$HEX1$$f300$$ENDHEX$$n, y compras
forward
global type w_consulta_incompra from window
end type
type st_1 from statictext within w_consulta_incompra
end type
type dw_2 from datawindow within w_consulta_incompra
end type
type cb_1 from commandbutton within w_consulta_incompra
end type
type st_dw_mode from statictext within w_consulta_incompra
end type
type cb_action from commandbutton within w_consulta_incompra
end type
type dw_1 from datawindow within w_consulta_incompra
end type
end forward

global type w_consulta_incompra from window
integer width = 3909
integer height = 2780
boolean titlebar = true
string title = "Consulta de Compras"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event ue_print ( )
event ue_zoomin ( )
event ue_zoomout ( )
st_1 st_1
dw_2 dw_2
cb_1 cb_1
st_dw_mode st_dw_mode
cb_action cb_action
dw_1 dw_1
end type
global w_consulta_incompra w_consulta_incompra

type variables
datawindowchild   idwc_tipo
boolean  ib_flag
end variables

forward prototypes
public subroutine wf_dw_query_mode ()
public subroutine wf_dw_retrieve_mode ()
end prototypes

event ue_print;dw_2.print()
end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_2.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_2.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if
end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_2.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_2.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

public subroutine wf_dw_query_mode ();//  (Query Mode)

//Turn on DataWindow Query (Criteria Specification) Mode
dw_1.Object.datawindow.querymode= 'yes'

//Set focus into the DataWindow
dw_1.SetFocus ()

//Change Text of Button to allow Retrieval
cb_action.Text = "Recuperar"

//change datawindow heading to reflect query mode
st_dw_mode.text  = "Modo de Consulta"

end subroutine

public subroutine wf_dw_retrieve_mode ();// Retrieve from Criteria

// Don't redraw until retrieval is finished
dw_1.SetRedraw (FALSE)

//	Turn off DataWindow Query (Criteria-specification) Mode
dw_1.Object.datawindow.querymode = 'no'

//	Retrieve, then redraw
dw_1.Retrieve (str_appgeninfo.empresa)
dw_1.SetRedraw (TRUE)

//Change Text of Button to allow Query Mode Again 
cb_action.Text = "Consultar"

//change datawindow heading to reflect retrieved data
st_dw_mode.text = "Datos recuperados basados en el criterio de b$$HEX1$$fa00$$ENDHEX$$squeda:"
end subroutine

on w_consulta_incompra.create
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.st_dw_mode=create st_dw_mode
this.cb_action=create cb_action
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dw_2,&
this.cb_1,&
this.st_dw_mode,&
this.cb_action,&
this.dw_1}
end on

on w_consulta_incompra.destroy
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.st_dw_mode)
destroy(this.cb_action)
destroy(this.dw_1)
end on

event open;dw_1.setTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)

f_recupera_empresa(dw_1,"su_codigo")
f_recupera_empresa(dw_1,"co_rucsuc")

cb_action.enabled = false
cb_1.triggerevent(clicked!)
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 50,dw_1.height)

dw_2.resize(li_width - 50,li_height - dw_1.height -200)

this.setRedraw(True)

end event

type st_1 from statictext within w_consulta_incompra
integer x = 23
integer y = 1092
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Documento"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_consulta_incompra
integer x = 9
integer y = 1152
integer width = 3840
integer height = 1500
integer taborder = 20
string title = "Detalle"
string dataobject = "d_rep_orden_compra"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rbuttondown;m_click_derecho  lm_menu
lm_menu  = Create m_click_derecho

window lw_parent, lw_frame
lw_frame=parent.parentWindow()

lm_menu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

destroy lm_menu

end event

type cb_1 from commandbutton within w_consulta_incompra
integer x = 2386
integer y = 16
integer width = 553
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preparar para consulta"
end type

event clicked;// This will reset (reload) the datawindow object , in effect reseting it.
ib_flag = true
cb_action.enabled = true
dw_1.dataobject = dw_1.dataobject
dw_1.reset()
f_recupera_empresa(dw_1,"su_codigo")
f_recupera_empresa(dw_1,"co_rucsuc")
dw_1.settransobject (sqlca)

// Reinitalize the datawindow
wf_dw_query_mode ()
end event

type st_dw_mode from statictext within w_consulta_incompra
integer x = 46
integer y = 32
integer width = 1893
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_action from commandbutton within w_consulta_incompra
integer x = 1979
integer y = 16
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
end type

event clicked;If cb_action.Text = "Recuperar" then 
	dw_1.AcceptText()
	wf_dw_retrieve_mode ()
	dw_2.modify("datawindow.print.preview.zoom = 75~t" + &
								  "datawindow.print.preview = yes")
	ib_flag = false
Else
	wf_dw_query_mode ()
End If
end event

type dw_1 from datawindow within w_consulta_incompra
integer x = 9
integer y = 112
integer width = 3840
integer height = 964
integer taborder = 10
string title = "none"
string dataobject = "d_consul_incompra"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event rowfocuschanged;String  ls_sucodigo,ls_eccodigo,ls_pvcodigo
Long    ll_numero

This.SetRowfocusIndicator(hand!)
If ib_flag = true  then return 
ll_numero      = This.GetItemNumber(currentrow,"co_numero")
ls_sucodigo    = This.GetItemString(currentrow,"su_codigo")
ls_eccodigo    = This.GetItemString(currentrow,"ec_codigo")
ls_pvcodigo    = This.GetItemString(currentrow,"pv_codigo")


CHOOSE CASE ls_eccodigo 
	   CASE '1'
      dw_2.dataobject = 'd_rep_orden_compra'
		CASE '2'
      dw_2.dataobject = 'd_rep_nota_recepcion'
      CASE '3'
	   dw_2.dataobject = 'd_rep_compra'
		CASE '4'
      dw_2.dataobject = 'd_rep_compra'
		dw_2.modify("t_1.text = 'Factura de compra (Anulada)'")
      CASE '5'
	   dw_2.dataobject = 'd_nd_preimpresa_devcomp_prn'
		CASE '0'
	   dw_2.dataobject = 'd_rep_nota_recepcion'
		dw_2.modify("t_1.text = 'Nota de Recepci$$HEX1$$f300$$ENDHEX$$n (Anulada)'")
END CHOOSE
dw_2.settransobject(sqlca)		
dw_2.modify("datawindow.print.preview.zoom = 75~t" + &
								  "datawindow.print.preview = yes")
dw_2.Retrieve(str_appgeninfo.empresa,ls_sucodigo,ls_eccodigo,ll_numero,ls_pvcodigo)





end event

event retrieveend;/*Editar el Asiento Elegido por el usuario*/
String  ls_numero,ls_sucodigo,ls_eccodigo,ls_pvcodigo
Long    ll_numero

if rowcount  =  0 then return 

ll_numero      = This.GetItemNumber(1,"co_numero")
ls_sucodigo    = This.GetItemString(1,"su_codigo")
ls_eccodigo    = This.GetItemString(1,"ec_codigo")
ls_pvcodigo    = This.GetItemString(1,"pv_codigo")


CHOOSE CASE ls_eccodigo 
	   CASE '1'
      dw_2.dataobject = 'd_rep_orden_compra'
		CASE '2'
      dw_2.dataobject = 'd_rep_nota_recepcion'
      CASE '3'
	   dw_2.dataobject = 'd_rep_compra'
		CASE '4'
      dw_2.dataobject = 'd_rep_compra'
		dw_2.modify("t_1.text = 'Factura de compra (Anulada)'")
      CASE '5'
	   dw_2.dataobject = 'd_nd_preimpresa_devcomp_prn'
		CASE '0'
	   dw_2.dataobject = 'd_rep_nota_recepcion'
		dw_2.modify("t_1.text = 'Nota de Recepci$$HEX1$$f300$$ENDHEX$$n (Anulada)'")
		
		
		
END CHOOSE
dw_2.settransobject(sqlca)		
dw_2.Retrieve(str_appgeninfo.empresa,ls_sucodigo,ls_eccodigo,ll_numero,ls_pvcodigo)
end event

event rowfocuschanging;dwitemstatus  l_status
l_status = this.getitemstatus(newrow,0,Primary!)
if l_status = new! then return
end event


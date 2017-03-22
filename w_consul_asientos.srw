HA$PBExportHeader$w_consul_asientos.srw
$PBExportComments$Si. Vale
forward
global type w_consul_asientos from window
end type
type dw_2 from datawindow within w_consul_asientos
end type
type cb_1 from commandbutton within w_consul_asientos
end type
type st_dw_mode from statictext within w_consul_asientos
end type
type cb_action from commandbutton within w_consul_asientos
end type
type dw_1 from datawindow within w_consul_asientos
end type
end forward

global type w_consul_asientos from window
integer width = 5070
integer height = 2092
boolean titlebar = true
string title = "Asientos Contables"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event ue_print ( )
event ue_zoomin ( )
event ue_zoomout ( )
dw_2 dw_2
cb_1 cb_1
st_dw_mode st_dw_mode
cb_action cb_action
dw_1 dw_1
end type
global w_consul_asientos w_consul_asientos

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
dw_1.Retrieve (str_appgeninfo.empresa,str_appgeninfo.sucursal)
dw_1.SetRedraw (TRUE)

//Change Text of Button to allow Query Mode Again 
cb_action.Text = "Consultar"

//change datawindow heading to reflect retrieved data
st_dw_mode.text = "Datos recuperados basados en el criterio de b$$HEX1$$fa00$$ENDHEX$$squeda:"
end subroutine

on w_consul_asientos.create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.st_dw_mode=create st_dw_mode
this.cb_action=create cb_action
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.cb_1,&
this.st_dw_mode,&
this.cb_action,&
this.dw_1}
end on

on w_consul_asientos.destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.st_dw_mode)
destroy(this.cb_action)
destroy(this.dw_1)
end on

event open;f_recupera_empresa(dw_2,"cs_codigo")
dw_1.Getchild("ti_codigo",idwc_tipo)
idwc_tipo.SetTransObject(SQLCA)
idwc_tipo.retrieve(str_appgeninfo.empresa)

dw_1.setTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)

//cb_action.triggerevent(Clicked!)
end event

type dw_2 from datawindow within w_consul_asientos
integer x = 1934
integer y = 112
integer width = 3090
integer height = 1868
integer taborder = 20
boolean titlebar = true
string title = "Comprobante Contable"
string dataobject = "d_prn_asiento_contable"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;m_click_derecho  lm_menu
lm_menu  = Create m_click_derecho

window lw_parent, lw_frame
lw_frame=parent.parentWindow()

lm_menu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

destroy lm_menu

end event

type cb_1 from commandbutton within w_consul_asientos
integer x = 3026
integer y = 12
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
dw_1.dataobject = dw_1.dataobject
dw_1.reset()
dw_1.Getchild("ti_codigo",idwc_tipo)
idwc_tipo.SetTransObject(sqlca)
idwc_tipo.retrieve(str_appgeninfo.empresa)
dw_1.settransobject (sqlca)

// Reinitalize the datawindow
wf_dw_query_mode ()
end event

type st_dw_mode from statictext within w_consul_asientos
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

type cb_action from commandbutton within w_consul_asientos
integer x = 2665
integer y = 12
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

type dw_1 from datawindow within w_consul_asientos
integer x = 27
integer y = 112
integer width = 1893
integer height = 1860
integer taborder = 10
string title = "none"
string dataobject = "d_consul_asientos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;/*Editar el Asiento Elegido por el usuario*/
String  ls_ticodigo
Long    ll_cpnumero,ll_nreg

If ib_flag = true  then return 
ll_cpnumero  = This.GetItemNumber(currentrow,"cp_numero")
ls_ticodigo    = This.GetItemString(currentrow,"ti_codigo")
dw_2.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_ticodigo,ll_cpnumero)

end event

event retrieveend;/*Editar el Asiento Elegido por el usuario*/
String  ls_ticodigo
Long    ll_cpnumero,ll_nreg

if rowcount  =  0 then return 
ll_cpnumero  = This.GetItemNumber(1,"cp_numero")
ls_ticodigo    = This.GetItemString(1,"ti_codigo")
dw_2.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_ticodigo,ll_cpnumero)
end event

event rowfocuschanging;dwitemstatus  l_status
l_status = this.getitemstatus(newrow,0,Primary!)
if l_status = new! then return
end event


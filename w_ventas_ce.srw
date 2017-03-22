HA$PBExportHeader$w_ventas_ce.srw
$PBExportComments$Vale
forward
global type w_ventas_ce from window
end type
type cb_2 from commandbutton within w_ventas_ce
end type
type dw_2 from datawindow within w_ventas_ce
end type
type cb_1 from commandbutton within w_ventas_ce
end type
type st_dw_mode from statictext within w_ventas_ce
end type
type cb_action from commandbutton within w_ventas_ce
end type
type dw_1 from datawindow within w_ventas_ce
end type
end forward

global type w_ventas_ce from window
integer width = 4613
integer height = 2744
boolean titlebar = true
string title = "Consulta de Ventas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event ue_print ( )
event ue_zoomin ( )
event ue_zoomout ( )
cb_2 cb_2
dw_2 dw_2
cb_1 cb_1
st_dw_mode st_dw_mode
cb_action cb_action
dw_1 dw_1
end type
global w_ventas_ce w_ventas_ce

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
dw_1.Retrieve(integer(str_appgeninfo.empresa))
dw_1.SetRedraw(TRUE)

//Change Text of Button to allow Query Mode Again 
cb_action.Text = "Consultar"

//change datawindow heading to reflect retrieved data
st_dw_mode.text = "Datos recuperados basados en el criterio de b$$HEX1$$fa00$$ENDHEX$$squeda:"
end subroutine

on w_ventas_ce.create
this.cb_2=create cb_2
this.dw_2=create dw_2
this.cb_1=create cb_1
this.st_dw_mode=create st_dw_mode
this.cb_action=create cb_action
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.dw_2,&
this.cb_1,&
this.st_dw_mode,&
this.cb_action,&
this.dw_1}
end on

on w_ventas_ce.destroy
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.st_dw_mode)
destroy(this.cb_action)
destroy(this.dw_1)
end on

event open;dw_1.setTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)

f_recupera_empresa(dw_1,"su_codigo")
f_recupera_empresa(dw_1,"bo_codigo")

cb_action.enabled = false
cb_1.triggerevent('clicked')
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

//this.setRedraw(False)
//dw_1.resize(dw_1.width,li_height - 100)
//dw_2.resize(li_width - dw_1.width,li_height - 100)
//this.setRedraw(True)

end event

type cb_2 from commandbutton within w_ventas_ce
integer x = 2944
integer y = 16
integer width = 466
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salvar Archivo"
end type

event clicked;dw_2.saveas()
end event

type dw_2 from datawindow within w_ventas_ce
integer x = 27
integer y = 1160
integer width = 4480
integer height = 1432
integer taborder = 20
boolean titlebar = true
string title = "Detalle de Venta"
string dataobject = "d_ce_factura"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

type cb_1 from commandbutton within w_ventas_ce
integer x = 2354
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
cb_action.enabled = true
dw_1.dataobject = dw_1.dataobject
dw_1.reset()

f_recupera_empresa(dw_1,"su_codigo")
f_recupera_empresa(dw_1,"bo_codigo")
dw_1.settransobject (sqlca)

// Reinitalize the datawindow
wf_dw_query_mode ()
end event

type st_dw_mode from statictext within w_ventas_ce
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

type cb_action from commandbutton within w_ventas_ce
integer x = 1979
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
	dw_2.modify("datawindow.print.preview.zoom = 100~t" + &
								  "datawindow.print.preview = yes")
	ib_flag = false
Else
	wf_dw_query_mode ()
End If
end event

type dw_1 from datawindow within w_ventas_ce
integer y = 112
integer width = 4539
integer height = 1032
integer taborder = 10
string dataobject = "d_consulta_fxm_ticket"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;/*Editar el Asiento Elegido por el usuario*/
String     ls_sucodigo,ls_estado,ls_bocodigo,ls_sucursal
long    ll_venumero

If ib_flag  = true  then return 

ls_sucodigo  = This.GetItemString(currentrow,"su_codigo")
ls_bocodigo = This.GetItemString(currentrow,"bo_codigo")
ls_estado  = This.GetItemString(currentrow,"es_codigo")
ll_venumero    = This.GetItemnumber(currentrow,"ve_numero")

select su_nombre
into :ls_sucursal
from pr_sucur
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :ls_sucodigo;

dw_2.setredraw(false)
dw_2.Retrieve(str_appgeninfo.empresa,ls_sucodigo,ls_bocodigo,ls_estado,ll_venumero)
dw_2.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+ls_sucursal+"'"+&
				"datawindow.print.preview.zoom = 100~t datawindow.print.preview = yes")
dw_2.setredraw(true)								  

end event

event retrieveend;/*Editar el Asiento Elegido por el usuario*/
String  ls_sucodigo,ls_estado,ls_bocodigo,ls_sucursal
long ll_venumero

if rowcount  =  0 then return 
ls_sucodigo = This.GetItemString(1,"su_codigo")
ls_bocodigo = This.GetItemString(1,"bo_codigo")
ls_estado = This.GetItemString(1,"es_codigo")
ll_venumero = This.GetItemnumber(1,"ve_numero")

select su_nombre
into :ls_sucursal
from pr_sucur
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :ls_sucodigo;

dw_2.setredraw(false)
//dw_2.Retrieve(str_appgeninfo.empresa,ls_sucodigo,ls_bocodigo,ls_estado,ll_venumero)
dw_2.Retrieve(str_appgeninfo.empresa,ls_sucodigo,ls_estado,ll_venumero)
dw_2.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+ls_sucursal+"'"+&
				"datawindow.print.preview.zoom = 100~t datawindow.print.preview = yes")
dw_2.setredraw(true)								  
end event

event rowfocuschanging;dwitemstatus  l_status
l_status = this.getitemstatus(newrow,0,Primary!)
if l_status = new! then return
end event


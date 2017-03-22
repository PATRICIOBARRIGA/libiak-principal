HA$PBExportHeader$w_consulta_transferencias.srw
$PBExportComments$Si.Vale
forward
global type w_consulta_transferencias from window
end type
type rb_2 from radiobutton within w_consulta_transferencias
end type
type rb_1 from radiobutton within w_consulta_transferencias
end type
type cb_1 from commandbutton within w_consulta_transferencias
end type
type st_dw_mode from statictext within w_consulta_transferencias
end type
type cb_action from commandbutton within w_consulta_transferencias
end type
type dw_1 from datawindow within w_consulta_transferencias
end type
type dw_2 from datawindow within w_consulta_transferencias
end type
type dw_3 from datawindow within w_consulta_transferencias
end type
end forward

global type w_consulta_transferencias from window
integer width = 3918
integer height = 2504
boolean titlebar = true
string title = "Consulta de Transferencias"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event ue_print ( )
event ue_zoomin ( )
event ue_zoomout ( )
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
st_dw_mode st_dw_mode
cb_action cb_action
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global w_consulta_transferencias w_consulta_transferencias

type variables
datawindowchild   idwc_tipo
boolean  ib_flag
end variables

forward prototypes
public subroutine wf_dw_query_mode ()
public subroutine wf_dw_retrieve_mode ()
end prototypes

event ue_print;int li_curZoom
datawindow ldw_aux

if rb_1.checked then
ldw_aux = dw_2
elseif rb_2.checked then
ldw_aux = dw_3
end if
ldw_aux.print()

end event

event ue_zoomin;int li_curZoom
datawindow ldw_aux

if rb_1.checked then
ldw_aux = dw_2
elseif rb_2.checked then
ldw_aux = dw_3
end if

li_curZoom = integer(ldw_aux.describe("datawindow.print.preview.zoom"))
if li_curZoom >= 200 then
	beep(1)
else
	ldw_aux.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom
datawindow ldw_aux

if rb_1.checked then
ldw_aux = dw_2
elseif rb_2.checked then
ldw_aux = dw_3
end if

li_curZoom = integer(ldw_aux.describe("datawindow.print.preview.zoom"))
if li_curZoom >= 200 then
	beep(1)
else
	ldw_aux.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
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
dw_1.Retrieve(str_appgeninfo.empresa)
dw_1.SetRedraw(TRUE)

//Change Text of Button to allow Query Mode Again 
cb_action.Text = "Consultar"

//change datawindow heading to reflect retrieved data
st_dw_mode.text = "Datos recuperados basados en el criterio de b$$HEX1$$fa00$$ENDHEX$$squeda:"
end subroutine

on w_consulta_transferencias.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.st_dw_mode=create st_dw_mode
this.cb_action=create cb_action
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.Control[]={this.rb_2,&
this.rb_1,&
this.cb_1,&
this.st_dw_mode,&
this.cb_action,&
this.dw_1,&
this.dw_2,&
this.dw_3}
end on

on w_consulta_transferencias.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.st_dw_mode)
destroy(this.cb_action)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;dw_1.setTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)


f_recupera_empresa(dw_1,"su_codenv")
f_recupera_empresa(dw_1,"bo_codenv")
f_recupera_empresa(dw_1,"su_codigo")
f_recupera_empresa(dw_1,"bo_codigo")

cb_action.enabled = false
cb_1.triggerevent('clicked')
end event

event resize;int li_width, li_height

return 1

//li_width = this.workSpaceWidth()
//li_height = this.workSpaceHeight()
//
//this.setRedraw(False)
//dw_1.resize(dw_1.width,li_height - 100)
//dw_2.resize(li_width  - dw_1.width,li_height - 100)
//dw_3.resize(li_width  - dw_1.width,li_height - 100)
////end if	
//this.setRedraw(True)
//
end event

event activate;if rb_1.checked then
	dw_2.show()
	dw_3.hide()
end if
if rb_2.checked then
	dw_3.show()
	dw_2.hide()
end if


end event

type rb_2 from radiobutton within w_consulta_transferencias
integer x = 3058
integer y = 24
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver recepci$$HEX1$$f300$$ENDHEX$$n"
end type

event clicked;long ll_row
String ls_aceptada

If ib_flag  = true  then return 
ll_row = dw_1.getrow()
ls_aceptada = dw_1.getitemstring(ll_row,"cc_aceptada")
if ls_aceptada = 'N' then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La transferencia no ha sido recibida...por favor revise!!!")
	rb_1.checked = true
	return
end if 	
dw_2.hide()
dw_3.show()

end event

type rb_1 from radiobutton within w_consulta_transferencias
integer x = 2679
integer y = 24
integer width = 325
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver envio"
boolean checked = true
end type

event clicked;dw_2.show()
dw_3.hide()
end event

type cb_1 from commandbutton within w_consulta_transferencias
integer x = 2094
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
f_recupera_empresa(dw_1,"su_codenv")
f_recupera_empresa(dw_1,"bo_codenv")
f_recupera_empresa(dw_1,"su_codigo")
f_recupera_empresa(dw_1,"bo_codigo")
dw_1.settransobject (sqlca)

// Reinitalize the datawindow
wf_dw_query_mode ()
end event

type st_dw_mode from statictext within w_consulta_transferencias
integer x = 46
integer y = 20
integer width = 1632
integer height = 76
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

type cb_action from commandbutton within w_consulta_transferencias
integer x = 1714
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
  	dw_3.modify("datawindow.print.preview.zoom = 75~t" + &
								  "datawindow.print.preview = yes")
	ib_flag = false
Else
	wf_dw_query_mode ()
End If
end event

type dw_1 from datawindow within w_consulta_transferencias
integer y = 100
integer width = 3840
integer height = 668
integer taborder = 10
string title = "none"
string dataobject = "d_consul_transferencias"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;/*Editar el Asiento Elegido por el usuario*/
String  ls_ticket,ls_sucodenv,ls_bocodenv,ls_sucodigo,ls_bocodigo,ls_aceptada
Long    ll_cpnumero,ll_nreg

SetRowFocusIndicator(Hand!)

If ib_flag  = true  then return 

ls_ticket    = This.GetItemString(currentrow,"tf_ticket")
ls_sucodenv  = This.GetItemString(currentrow,"su_codenv")
ls_bocodenv  = This.GetItemString(currentrow,"bo_codenv")
ls_sucodigo  = This.GetItemString(currentrow,"su_codigo")
ls_bocodigo  = This.GetItemString(currentrow,"bo_codigo")
ls_aceptada  = This.GetItemString(currentrow,"cc_aceptada")

dw_2.Retrieve(str_appgeninfo.empresa,ls_sucodenv,ls_bocodenv,ls_sucodigo,ls_bocodigo,ls_ticket)
dw_3.Retrieve(str_appgeninfo.empresa,ls_sucodenv,ls_bocodenv,ls_sucodigo,ls_bocodigo,ls_ticket)

if ls_aceptada = 'N' then
	dw_3.hide()
	dw_2.show()
	rb_1.checked = true
end if



end event

event retrieveend;/*Editar el Asiento Elegido por el usuario*/
String  ls_ticket,ls_sucodenv,ls_bocodenv,ls_sucodigo,ls_bocodigo

if rowcount  =  0 then return 
ls_ticket    = This.GetItemString(1,"tf_ticket")
ls_sucodenv  = This.GetItemString(1,"su_codenv")
ls_bocodenv  = This.GetItemString(1,"bo_codenv")
ls_sucodigo  = This.GetItemString(1,"su_codigo")
ls_bocodigo  = This.GetItemString(1,"bo_codigo")
dw_2.Retrieve(str_appgeninfo.empresa,ls_sucodenv,ls_bocodenv,ls_sucodigo,ls_bocodigo,ls_ticket)
dw_3.Retrieve(str_appgeninfo.empresa,ls_sucodenv,ls_bocodenv,ls_sucodigo,ls_bocodigo,ls_ticket)
end event

event rowfocuschanging;dwitemstatus  l_status
l_status = this.getitemstatus(newrow,0,Primary!)
if l_status = new! then return
end event

type dw_2 from datawindow within w_consulta_transferencias
integer x = 9
integer y = 776
integer width = 3831
integer height = 1564
integer taborder = 20
string title = "Transferencia (envio)"
string dataobject = "d_rep_cab_transferencia"
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

type dw_3 from datawindow within w_consulta_transferencias
integer x = 9
integer y = 780
integer width = 3653
integer height = 1564
integer taborder = 30
boolean titlebar = true
string title = "Transferencia (recepci$$HEX1$$f300$$ENDHEX$$n)"
string dataobject = "d_rep_consulta_transferencia"
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


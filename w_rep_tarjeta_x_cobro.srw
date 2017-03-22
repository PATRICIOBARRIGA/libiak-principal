HA$PBExportHeader$w_rep_tarjeta_x_cobro.srw
$PBExportComments$Si.
forward
global type w_rep_tarjeta_x_cobro from window
end type
type st_2 from statictext within w_rep_tarjeta_x_cobro
end type
type rb_2 from radiobutton within w_rep_tarjeta_x_cobro
end type
type rb_1 from radiobutton within w_rep_tarjeta_x_cobro
end type
type cb_1 from commandbutton within w_rep_tarjeta_x_cobro
end type
type st_1 from statictext within w_rep_tarjeta_x_cobro
end type
type sle_cobro from singlelineedit within w_rep_tarjeta_x_cobro
end type
type gb_1 from groupbox within w_rep_tarjeta_x_cobro
end type
type dw_1 from datawindow within w_rep_tarjeta_x_cobro
end type
type dw_tarjeta from datawindow within w_rep_tarjeta_x_cobro
end type
type dw_cobro from datawindow within w_rep_tarjeta_x_cobro
end type
type dw_tarjeta2 from datawindow within w_rep_tarjeta_x_cobro
end type
end forward

global type w_rep_tarjeta_x_cobro from window
integer width = 5257
integer height = 2148
boolean titlebar = true
string title = "Reporte Recaps y Cobros  w_rep_tarjeta_x_cobro"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_print ( )
st_2 st_2
rb_2 rb_2
rb_1 rb_1
cb_1 cb_1
st_1 st_1
sle_cobro sle_cobro
gb_1 gb_1
dw_1 dw_1
dw_tarjeta dw_tarjeta
dw_cobro dw_cobro
dw_tarjeta2 dw_tarjeta2
end type
global w_rep_tarjeta_x_cobro w_rep_tarjeta_x_cobro

type variables
string where_clause 
end variables

event ue_print();dw_tarjeta.print()
end event

event open;Datawindowchild dwc
//uno
dw_cobro.SetTransObject(sqlca)
dw_tarjeta.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)

dw_tarjeta2.SetTransObject(sqlca)

f_recupera_empresa(dw_cobro,"cn_codigo")
f_recupera_empresa(dw_tarjeta2,"if_codigo")

dw_tarjeta2.visible = false


dw_cobro.GetChild('bt_codigo',dwc)
dwc.SetTransObject(sqlca)
dwc.retrieve('1','1')

where_clause = ' and ("CB_DETTAR"."CT_CODIGO","CB_DETTAR"."DT_SECUE") in (select ct_codigo, dt_secue from cb_cruce where'





end event

on w_rep_tarjeta_x_cobro.create
this.st_2=create st_2
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_cobro=create sle_cobro
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_tarjeta=create dw_tarjeta
this.dw_cobro=create dw_cobro
this.dw_tarjeta2=create dw_tarjeta2
this.Control[]={this.st_2,&
this.rb_2,&
this.rb_1,&
this.cb_1,&
this.st_1,&
this.sle_cobro,&
this.gb_1,&
this.dw_1,&
this.dw_tarjeta,&
this.dw_cobro,&
this.dw_tarjeta2}
end on

on w_rep_tarjeta_x_cobro.destroy
destroy(this.st_2)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_cobro)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_tarjeta)
destroy(this.dw_cobro)
destroy(this.dw_tarjeta2)
end on

event key;if Key = KeyEnter! then
	cb_1.Triggerevent(Clicked!)
end if

if Key = KeyF1! then
	//llama a la ayuda que necesita para esta ventana
	ShowHelp("Help\HelpSIF.HLP", Keyword!, "Cruce Tarjetas y Cobros") 
end if


end event

event help;messagebox('','simon con F1')
end event

type st_2 from statictext within w_rep_tarjeta_x_cobro
integer x = 512
integer y = 144
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "COBROS"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_rep_tarjeta_x_cobro
integer x = 2501
integer y = 64
integer width = 471
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Recaps a Cobro"
end type

event clicked;dw_cobro.visible = false
dw_tarjeta.visible = false

dw_tarjeta2.visible = true
st_2.text = 'RECAPS'
end event

type rb_1 from radiobutton within w_rep_tarjeta_x_cobro
integer x = 1883
integer y = 68
integer width = 480
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Cobro a  Recaps"
boolean checked = true
end type

event clicked;dw_cobro.visible = true
dw_tarjeta.visible = false
dw_1.visible = true

dw_tarjeta2.visible = false

st_2.text = 'COBROS'
end event

type cb_1 from commandbutton within w_rep_tarjeta_x_cobro
integer x = 923
integer y = 36
integer width = 311
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
end type

event clicked;string ls_btcodigo
Datawindowchild dwc

if rb_1.Checked = TRUE then
		if sle_cobro.text = "" then
				ls_btcodigo = '%'
				dw_cobro.GetChild('bt_codigo',dwc)
				dwc.SetTransObject(sqlca)
				dwc.retrieve('1','1')
		else
			ls_btcodigo = sle_cobro.text
		end if
		dw_cobro.retrieve(ls_btcodigo) 
		dw_cobro.SetSort('bt_codigo')
		dw_cobro.Sort()
else
		if sle_cobro.text = "" then
				ls_btcodigo = '%'
		else
			ls_btcodigo = sle_cobro.text
		end if
		dw_tarjeta2.retrieve(ls_btcodigo) 
		dw_tarjeta2.SetSort('ct_codigo')
     	dw_tarjeta2.Sort()
end if
end event

type st_1 from statictext within w_rep_tarjeta_x_cobro
integer x = 46
integer y = 36
integer width = 576
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Nro. de Comprobante :"
boolean focusrectangle = false
end type

type sle_cobro from singlelineedit within w_rep_tarjeta_x_cobro
integer x = 658
integer y = 32
integer width = 261
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_rep_tarjeta_x_cobro
integer x = 1861
integer y = 4
integer width = 1152
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Tipo de Consulta"
end type

type dw_1 from datawindow within w_rep_tarjeta_x_cobro
integer x = 1609
integer y = 220
integer width = 3621
integer height = 1820
integer taborder = 20
string title = "none"
string dataobject = "d_rep_crucerecaps3"
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

event clicked;long ll_cpnumero
string ls_btcodigo, old_select, where1, new_select

if row > 0 then
		
	if dwo.color = '134217856' and dwo.name =  'cb_cruce_ct_codigo' then 
			ls_btcodigo = dw_1.GetItemString(row,'cb_cruce_ct_codigo')	
			dw_cobro.visible = false
			dw_tarjeta.visible = false
			dw_1.visible = true
 		    dw_tarjeta2.visible = true
			
			dw_1.Object.cb_cruce_bt_codigo.Color = '134217856'
			dw_1.Object.cb_cruce_ct_codigo.Color = RGB(0,0,0)
			dw_1.Object.cb_cruce_bt_codigo.Pointer = 'HyperLink!' 
			dw_1.Object.cb_cruce_ct_codigo.Pointer = 'Arrow!' 
						
			rb_2.Checked = TRUE
			st_2.text = 'RECAPS'
			dw_tarjeta2.retrieve(ls_btcodigo)
			old_select = dw_1.GetSQLSelect()
      		where1 = where_clause
			where1 = where1 +  ' ct_codigo =' +  ls_btcodigo + ')'
			new_select = old_select + where1
			dw_1.SetSQLSelect(new_select)
			dw_1.retrieve()	
			dw_1.SetSQLSelect(old_select)
		elseif dwo.color = '134217856' and dwo.name =  'cb_cruce_bt_codigo' then
			ls_btcodigo = dw_1.GetItemString(row,'cb_cruce_bt_codigo')	
			dw_cobro.visible = true
			dw_tarjeta.visible = false
			dw_1.visible = true
 		    dw_tarjeta2.visible = false
			
			dw_1.Object.cb_cruce_bt_codigo.Color = RGB(0,0,0)
			dw_1.Object.cb_cruce_ct_codigo.Color = '134217856'
			dw_1.Object.cb_cruce_bt_codigo.Pointer = 'Arrow!' 
			dw_1.Object.cb_cruce_ct_codigo.Pointer = 'HyperLink!' 
			
			rb_1.Checked = TRUE
			st_2.text = 'COBROS'
			dw_cobro.retrieve(ls_btcodigo)
			old_select = dw_1.GetSQLSelect()
				where1 = where_clause
			where1 = where1 +  ' bt_codigo =' +  ls_btcodigo + ')'
			new_select = old_select + where1
			dw_1.SetSQLSelect(new_select)
			dw_1.retrieve()	
			dw_1.SetSQLSelect(old_select)
	end if
	

end if


end event

type dw_tarjeta from datawindow within w_rep_tarjeta_x_cobro
boolean visible = false
integer x = 1513
integer y = 1088
integer width = 3506
integer height = 1900
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_rep_recap_tarjetas"
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

type dw_cobro from datawindow within w_rep_tarjeta_x_cobro
integer x = 105
integer y = 224
integer width = 1504
integer height = 1808
integer taborder = 10
string title = "none"
string dataobject = "d_cobros_cab"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string ls_egnumero 
long ll_cpnumero, ll_longitud

if row = 0 then
	ll_longitud = Len(string(dwo.name))
		This.SetSort(string(Mid(dwo.name,1,ll_longitud - 2)) )
	This.Sort()
end if
end event

event clicked;long ll_cpnumero
string ls_btcodigo
Datawindowchild dwc, dwc1
string old_select, new_select, where1

if row > 0 then 
	ls_btcodigo = string(dw_cobro.GetItemNumber(row,'bt_codigo'))
	if dwo.color = '134217856' then 
			dw_cobro.GetChild('bt_codigo',dwc1)
			dwc1.SetTransObject(sqlca)
   		    dwc1.retrieve('1',ls_btcodigo)	
			//retrieve
			old_select = dw_1.GetSQLSelect()
			where1 = where_clause
			where1 = where1 +  ' bt_codigo =' +  ls_btcodigo + ')'
			new_select = old_select + where1
			dw_1.SetSQLSelect(new_select)
			dw_1.retrieve()	
			dw_1.SetSQLSelect(old_select)
			//end retrieve
			dw_1.Object.cb_cruce_ct_codigo.Color = '134217856'
			dw_1.Object.cb_cruce_bt_codigo.Color = RGB(0,0,0)
			dw_1.Object.cb_cruce_ct_codigo.Pointer = 'HyperLink!' 
			dw_1.Object.cb_cruce_bt_codigo.Pointer = 'Arrow!' 
			
			dw_tarjeta.retrieve(ls_btcodigo)
			dw_tarjeta.modify("datawindow.print.preview.zoom = 100~t datawindow.print.preview = yes")
			
			
	end if
end if

end event

type dw_tarjeta2 from datawindow within w_rep_tarjeta_x_cobro
integer x = 18
integer y = 216
integer width = 1591
integer height = 1816
integer taborder = 30
string title = "none"
string dataobject = "d_rep_tarjetas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long ll_cpnumero
string ls_btcodigo, old_select, where1, new_select
Datawindowchild dwc, dwc1

if row > 0 then 
	ls_btcodigo = string(dw_tarjeta2.GetItemNumber(row,'ct_codigo'))
	if dwo.color = '134217856' then 
			
			//retrieve
			old_select = dw_1.GetSQLSelect()
			where1 = where_clause
			where1 = where1 +  ' ct_codigo =' +  ls_btcodigo + ')'
			new_select = old_select + where1
			dw_1.SetSQLSelect(new_select)
			dw_1.retrieve()	
			dw_1.SetSQLSelect(old_select)
			//end retrieve
			dw_1.Object.cb_cruce_ct_codigo.Color = RGB(0,0,0)
			dw_1.Object.cb_cruce_bt_codigo.Color = '134217856'
			dw_1.Object.cb_cruce_bt_codigo.Pointer = 'HyperLink!'
			dw_1.Object.cb_cruce_ct_codigo.Pointer = 'Arrow!'
			

			
	end if
end if
end event

event doubleclicked;string ls_egnumero 
long ll_cpnumero, ll_longitud

if row = 0 then
	ll_longitud = Len(string(dwo.name))
		This.SetSort(string(Mid(dwo.name,1,ll_longitud - 2)) )
	This.Sort()
end if
end event


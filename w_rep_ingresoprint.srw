HA$PBExportHeader$w_rep_ingresoprint.srw
$PBExportComments$Si.
forward
global type w_rep_ingresoprint from window
end type
type dw_prn from datawindow within w_rep_ingresoprint
end type
type cbx_1 from checkbox within w_rep_ingresoprint
end type
type pb_1 from picturebutton within w_rep_ingresoprint
end type
type cb_3 from commandbutton within w_rep_ingresoprint
end type
type dw_1 from datawindow within w_rep_ingresoprint
end type
type dw_2 from datawindow within w_rep_ingresoprint
end type
type dw_3 from datawindow within w_rep_ingresoprint
end type
type em_1 from editmask within w_rep_ingresoprint
end type
type em_2 from editmask within w_rep_ingresoprint
end type
type st_1 from statictext within w_rep_ingresoprint
end type
type sle_numeg from singlelineedit within w_rep_ingresoprint
end type
type cb_2 from commandbutton within w_rep_ingresoprint
end type
type st_3 from statictext within w_rep_ingresoprint
end type
type cb_1 from commandbutton within w_rep_ingresoprint
end type
type dw_replist from uo_dw_basic within w_rep_ingresoprint
end type
end forward

global type w_rep_ingresoprint from window
integer width = 5536
integer height = 3072
boolean titlebar = true
string title = "Reporte Comprobantes de Ingreso  -  w_rep_ingresoprint"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_print ( )
event ue_filter pbm_custom07
dw_prn dw_prn
cbx_1 cbx_1
pb_1 pb_1
cb_3 cb_3
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
em_1 em_1
em_2 em_2
st_1 st_1
sle_numeg sle_numeg
cb_2 cb_2
st_3 st_3
cb_1 cb_1
dw_replist dw_replist
end type
global w_rep_ingresoprint w_rep_ingresoprint

type variables
datawindow idw_activo 
end variables

event ue_print();
String  ls_nros[],ls_flag
Int i,li_rc

li_rc = Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea imprimir en lote?", question!, YesNoCancel!,2)
If li_rc = 1 then 
     for i = 1 to dw_1.rowcount()
		ls_flag = dw_1.object.flag_print[i]
		if ls_flag = 'S' then ls_nros[i] = String(dw_1.Object.ig_numero[i])
	next
	dw_prn.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_nros)
	idw_activo = dw_prn
elseif 	li_rc = 3 then
return
end if
idw_activo.Print() 


end event

event ue_filter;dw_replist.uf_filter()
end event

event open;string ls_fecprimero

gnv_Help.of_Register(This)
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_replist.SetTransObject(sqlca)
dw_prn.SetTransObject(sqlca)

ls_fecprimero = string(today())
em_1.text = Replace(ls_fecprimero, 1, 2, '01')
em_2.text = string(today())

f_recupera_empresa(dw_2,"cs_codigo")
f_recupera_empresa(dw_3,"cs_codigo")
f_recupera_empresa(dw_2,"cb_egreso_if_codigo")
f_recupera_empresa(dw_2,"cb_egreso_cn_codigo")
f_recupera_empresa(dw_1,"if_codigo")
f_recupera_empresa(dw_replist,"if_codigo")
f_recupera_empresa(dw_prn,"cs_codigo")

dw_3.hide() 
end event

on w_rep_ingresoprint.create
this.dw_prn=create dw_prn
this.cbx_1=create cbx_1
this.pb_1=create pb_1
this.cb_3=create cb_3
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.sle_numeg=create sle_numeg
this.cb_2=create cb_2
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_replist=create dw_replist
this.Control[]={this.dw_prn,&
this.cbx_1,&
this.pb_1,&
this.cb_3,&
this.dw_1,&
this.dw_2,&
this.dw_3,&
this.em_1,&
this.em_2,&
this.st_1,&
this.sle_numeg,&
this.cb_2,&
this.st_3,&
this.cb_1,&
this.dw_replist}
end on

on w_rep_ingresoprint.destroy
destroy(this.dw_prn)
destroy(this.cbx_1)
destroy(this.pb_1)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.sle_numeg)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_replist)
end on

event key;if Key = KeyEnter! then
	cb_2.Triggerevent(Clicked!)
end if
end event

type dw_prn from datawindow within w_rep_ingresoprint
boolean visible = false
integer x = 974
integer y = 452
integer width = 1362
integer height = 400
integer taborder = 50
string title = "none"
string dataobject = "d_prn_ingreso_lote"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_rep_ingresoprint
integer x = 1161
integer y = 4
integer width = 384
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nro. Deposito"
end type

event clicked;if cbx_1.checked then
	cbx_1.text = 'Nro. Ingreso:'
else
	cbx_1.text = 'Nro. Deposito:'
end if
end event

type pb_1 from picturebutton within w_rep_ingresoprint
string tag = "BubbleHelp=Cerrar Impresi$$HEX1$$f300$$ENDHEX$$n"
boolean visible = false
integer x = 393
integer y = 2816
integer width = 114
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Close!"
alignment htextalign = left!
end type

event clicked;dw_replist.visible = false
cb_3.text = 'Ver Listado'
pb_1.visible = false
end event

type cb_3 from commandbutton within w_rep_ingresoprint
string tag = "BubbleHelp=Ver e Imprimir Listado de Egresos."
integer x = 9
integer y = 2816
integer width = 379
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ver Listado"
end type

event clicked;date f_1, f_2
string ls_egnum, ls_igdeposit

if dw_replist.visible = false and cb_3.text = 'Ver Listado' then
	
	dw_replist.visible = true
	f_1 = date(em_1.text)
	f_2 = date(em_2.text)
	 
	if sle_numeg.text = '' then
		ls_egnum = '%'
		ls_igdeposit = '%'
		dw_replist.retrieve(ls_egnum,f_1,f_2,str_appgeninfo.empresa, ls_igdeposit)
	elseif cbx_1.checked then //por ingreso
		ls_igdeposit = '%'
		ls_egnum = sle_numeg.text
		dw_replist.retrieve(ls_egnum,date('01/01/2000'),f_2,str_appgeninfo.empresa, ls_igdeposit)
	else //por numero de deposito
		ls_igdeposit = sle_numeg.text
		ls_egnum = '%'
		dw_replist.retrieve(ls_egnum,date('01/01/2000'),f_2,str_appgeninfo.empresa, ls_igdeposit)
    end if
	
	cb_3.text = 'Imprimir Listado'
	pb_1.visible = true
	dw_replist.Modify("DataWindow.Print.preview=Yes") 
elseif dw_replist.visible =true and cb_3.text = 'Imprimir Listado' then
		dw_replist.print(true) 
		dw_replist.visible = false
		cb_3.text = 'Ver Listado'
		pb_1.visible = false
end if




end event

type dw_1 from datawindow within w_rep_ingresoprint
event ue_filter ( unsignedlong w_param,  integer l_param )
integer x = 5
integer y = 80
integer width = 2519
integer height = 2728
integer taborder = 40
string title = "none"
string dataobject = "d_ingresos"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_filter(unsignedlong w_param, integer l_param);//dw_replist.uf_filter()
end event

event clicked;long ll_cpnumero, ll_ignumero,i
string ls_ignumero, ls_sucodigo
dw_3.hide()
idw_activo = this 

if row = 0 and dwo.name = 'flag_print_t' then
	for i = row to this.rowcount()
	this.setitem(i,"flag_print",'N')
	next	
end if



if row > 0 and dwo.name = 'ig_numero' then 
	ll_ignumero = dw_1.GetItemNumber(row,'ig_numero')
	ls_ignumero = string(ll_ignumero)
	ll_cpnumero = dw_1.GetItemNumber(row,'cp_numero')
	ls_sucodigo = dw_1.GetItemString(row,'su_codigo')
	if dwo.color = '134217856' then 
		dw_2.show()
		If dw_1.GetItemString(row,'compute_2') = 'ANULADO' then
			dw_2.Object.t_31.Visible = 1
		else
			dw_2.Object.t_31.Visible = 0
		end if
		//mostrar minimizado el asiento contable
		if ll_cpnumero > 0 then
			//dw_3.show()
			dw_3.retrieve(str_appgeninfo.empresa,ls_sucodigo,'1',ll_cpnumero)
			dw_3.modify("datawindow.print.preview.zoom = 100~t datawindow.print.preview = yes")
		else 
			dw_3.reset()
			dw_3.hide()
		end if 
		//comprobante de egreso
		dw_2.retrieve(str_appgeninfo.empresa,ls_sucodigo,ls_ignumero)
		dw_2.modify("datawindow.print.preview.zoom = 100~t datawindow.print.preview = yes")
	end if
end if


end event

event doubleclicked;string ls_egnumero 
long ll_cpnumero, ll_longitud, ll_egnumero,i

if dwo.name = 'flag_print' then
   		for i = row to this.rowcount()
		this.setitem(i,"flag_print",'S')
		next
end if

if row = 0 then
	ll_longitud = Len(string(dwo.name))
	This.SetSort(string(Mid(dwo.name,1,ll_longitud - 2)) )
	This.Sort()
	
else	
	ll_egnumero = dw_1.GetItemNumber(row,'ig_numero')
	ls_egnumero = string(ll_egnumero)
	dw_2.show()
	If dw_1.GetItemString(row,'compute_2') = 'ANULADO' then
		dw_2.Object.t_31.Visible = 1
	else
		dw_2.Object.t_31.Visible = 0
	end if
	
	//comprobante de egreso
	dw_2.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_egnumero)
	dw_2.modify("datawindow.print.preview.zoom = 100~t datawindow.print.preview = yes")
end if

dw_3.hide()




end event

type dw_2 from datawindow within w_rep_ingresoprint
integer x = 2523
integer y = 32
integer width = 2935
integer height = 2916
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle Ingreso"
string dataobject = "d_reporte_ingreso"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;m_click_derecho  lm_menu
lm_menu  = Create m_click_derecho

idw_activo = this 
window lw_parent, lw_frame
lw_frame=parent.parentWindow()

lm_menu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

destroy lm_menu

end event

event clicked;idw_activo = this 
end event

type dw_3 from datawindow within w_rep_ingresoprint
string accessiblename = "superdata"
string accessibledescription = "superdata"
accessiblerole accessiblerole = windowrole!
integer x = 2533
integer width = 2935
integer height = 2924
integer taborder = 20
boolean titlebar = true
string title = "Asiento Contable"
string dataobject = "d_prn_asiento_contable"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean livescroll = true
end type

event rbuttondown;m_click_derecho  lm_menu
lm_menu  = Create m_click_derecho


idw_activo = this 
window lw_parent, lw_frame
lw_frame=parent.parentWindow()

lm_menu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

destroy lm_menu

end event

event clicked;idw_activo = this 
end event

type em_1 from editmask within w_rep_ingresoprint
integer x = 215
integer y = 8
integer width = 379
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "dd/mm/yyyy"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
boolean spin = true
boolean usecodetable = true
end type

type em_2 from editmask within w_rep_ingresoprint
integer x = 750
integer y = 8
integer width = 370
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "dd/mm/yyyy"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
boolean spin = true
boolean usecodetable = true
end type

type st_1 from statictext within w_rep_ingresoprint
integer x = 27
integer y = 8
integer width = 174
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type sle_numeg from singlelineedit within w_rep_ingresoprint
integer x = 1554
integer y = 8
integer width = 293
integer height = 64
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_rep_ingresoprint
string tag = "Recupera listado de Egresos"
integer x = 1851
integer y = 12
integer width = 242
integer height = 60
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recupera"
end type

event clicked;date f_1, f_2
string ls_egnum, ls_igdeposit

f_1 = date(em_1.text)
f_2 = date(em_2.text)

if sle_numeg.text = '' then
	ls_egnum = '%'
	ls_igdeposit = '%'
	dw_1.retrieve(ls_egnum,f_1,f_2,str_appgeninfo.empresa, ls_igdeposit)
elseif cbx_1.checked then //por ingreso
		ls_igdeposit = '%'
		ls_egnum = sle_numeg.text
		dw_1.retrieve(ls_egnum,date('01/01/2000'),f_2,str_appgeninfo.empresa, ls_igdeposit)
	else //por numero de deposito
		ls_igdeposit = sle_numeg.text
		ls_egnum = '%'
		dw_1.retrieve(ls_egnum,date('01/01/2000'),f_2,str_appgeninfo.empresa, ls_igdeposit)
end if


//esto es para ver el tiempo de respuesta en recuperar los datos un datawindows
//messagebox('Tiempo de Respuesta','Tiempo .:.  '+ string(dw_1.Describe("DataWindow.Storage")))
end event

type st_3 from statictext within w_rep_ingresoprint
integer x = 599
integer y = 8
integer width = 146
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_rep_ingresoprint
integer x = 2126
integer width = 398
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostrar Asiento"
end type

event clicked;dw_3.show()
end event

type dw_replist from uo_dw_basic within w_rep_ingresoprint
event ue_filter pbm_custom07
boolean visible = false
integer x = 32
integer width = 3845
integer height = 2812
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_rep_ingreso_list"
boolean border = true
end type

event ue_filter;dw_replist.uf_filter()
pb_1.visible = false
end event

event doubleclicked;call super::doubleclicked;string ls_egnumero , prueba
long ll_cpnumero, ll_longitud, ll_egnumero

if row = 0 then
	prueba = string(dwo.name)
	ll_longitud = Len(string(dwo.name))
	dw_replist.SetSort(string(Mid(dwo.name,1,ll_longitud - 2)) )
	dw_replist.Sort()
end if

end event


HA$PBExportHeader$w_pd_rep_items_x_producir.srw
forward
global type w_pd_rep_items_x_producir from w_sheet_1_dw_rep
end type
type dw_ordprd from datawindow within w_pd_rep_items_x_producir
end type
type dw_pedidos from datawindow within w_pd_rep_items_x_producir
end type
type st_1 from statictext within w_pd_rep_items_x_producir
end type
type st_2 from statictext within w_pd_rep_items_x_producir
end type
type st_3 from statictext within w_pd_rep_items_x_producir
end type
end forward

global type w_pd_rep_items_x_producir from w_sheet_1_dw_rep
integer width = 6071
integer height = 2168
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n de $$HEX1$$f300$$ENDHEX$$rdenes"
long backcolor = 67108864
dw_ordprd dw_ordprd
dw_pedidos dw_pedidos
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_pd_rep_items_x_producir w_pd_rep_items_x_producir

type variables
long il_sec
end variables

on w_pd_rep_items_x_producir.create
int iCurrent
call super::create
this.dw_ordprd=create dw_ordprd
this.dw_pedidos=create dw_pedidos
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ordprd
this.Control[iCurrent+2]=this.dw_pedidos
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
end on

on w_pd_rep_items_x_producir.destroy
call super::destroy
destroy(this.dw_ordprd)
destroy(this.dw_pedidos)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;ib_inreportmode = false
this.triggerevent("ue_retrieve")
end event

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_pd_rep_items_x_producir
integer x = 32
integer y = 72
integer width = 2889
integer height = 944
string dataobject = "d_pd_item_x_producir"
boolean border = true
end type

event dw_datos::clicked;call super::clicked;Long ll_new

if dwo.name = 't_2' then
	dw_ordprd.visible = true
	dw_ordprd.setfocus()
	ll_new = dw_ordprd.insertrow(0)
//	dw_ordprd.Object.ce_codigo[ll_new]   =  dw_master.object.ce_codigo[dw_master.getrow()]
	dw_ordprd.object.it_codigo[ll_new]     =  this.object.it_codigo[this.getrow()]
	dw_ordprd.object.it_codant[ll_new]     =  this.object.in_item_it_codant[this.getrow()]
	dw_ordprd.object.it_nombre[ll_new]    =  this.object.in_item_it_nombre[this.getrow()]
	dw_ordprd.object.or_cantid[ll_new]     =  this.object.dp_cantid[this.getrow()]
	dw_ordprd.object.pe_codigo[ll_new]    =  this.object.pe_codigo[this.getrow()]
	dw_ordprd.object.dp_secue[ll_new]     =  this.object.dp_secue[this.getrow()]
end if
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_pd_rep_items_x_producir
integer x = 3506
integer y = 344
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_pd_rep_items_x_producir
integer x = 3118
integer y = 88
end type

type dw_ordprd from datawindow within w_pd_rep_items_x_producir
event ue_keycode pbm_dwnkey
integer x = 2944
integer y = 80
integer width = 3040
integer height = 1944
integer taborder = 20
boolean bringtotop = true
string title = "Orden producci$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_ord_produccion_auxiliar"
boolean controlmenu = true
boolean livescroll = true
end type

event ue_keycode;if keyDown(KeyEscape!) then
	this.Visible = false
//       dw_master.SetFocus()
//	dw_master.SetFilter('')
//	dw_master.Filter()
end if
end event

event buttonclicked;if dwo.name = 'b_2' then
  this.reset()
  this.visible = false
end if
end event

event updatestart;Long ll_row


ll_row = this.getrow()
if ll_row  = 0 then return
il_sec = f_secuencial(str_appgeninfo.empresa,"PR_ORDPRD")
this.object.or_codigo[ll_row] = string(il_sec)

return 0
end event

event updateend;String ls_pecodigo,ls_sec
 long  ll_secue


//ls_pecodigo = dw_detail.Object.pe_codigo[dw_detail.getrow()]
//ll_secue      =   dw_detail.Object.dp_secue[dw_detail.getrow()]
//
//ls_sec = String(il_sec)
//
//UPDATE PD_DETPED
//SET OR_CODIGO  = :ls_sec
//WHERE PE_CODIGO = :ls_pecodigo
//AND DP_SECUE = :ll_secue;
//
//
//if sqlca.sqlcode <> 0 then
//Rollback;
//Messagebox("Atencion","Problemas al actualizar el item ..."+sqlca.sqlerrtext) 
//return 1
//end if
//
//dw_detail.Object.or_codigo[dw_detail.getrow()] = String(il_sec)
//
RETURN 0
end event

type dw_pedidos from datawindow within w_pd_rep_items_x_producir
integer x = 41
integer y = 1092
integer width = 2889
integer height = 928
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pd_item_x_producir_detallado_x_pedido"
boolean livescroll = true
end type

type st_1 from statictext within w_pd_rep_items_x_producir
integer x = 41
integer y = 1032
integer width = 402
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Detalle por pedido"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pd_rep_items_x_producir
integer x = 46
integer y = 4
integer width = 471
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Productos a elaborar"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pd_rep_items_x_producir
integer x = 2962
integer y = 24
integer width = 475
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Orden de producci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type


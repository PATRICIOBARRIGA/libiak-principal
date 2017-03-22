HA$PBExportHeader$w_rep_debitos_pendientes_x_cliente.srw
$PBExportComments$Si.
forward
global type w_rep_debitos_pendientes_x_cliente from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_debitos_pendientes_x_cliente
end type
type rb_2 from radiobutton within w_rep_debitos_pendientes_x_cliente
end type
type rb_1 from radiobutton within w_rep_debitos_pendientes_x_cliente
end type
end forward

global type w_rep_debitos_pendientes_x_cliente from w_sheet_1_dw_rep
integer width = 2889
integer height = 1632
string title = "D$$HEX1$$e900$$ENDHEX$$bitos Pendientes"
long backcolor = 67108864
boolean ib_notautoretrieve = true
dw_1 dw_1
rb_2 rb_2
rb_1 rb_1
end type
global w_rep_debitos_pendientes_x_cliente w_rep_debitos_pendientes_x_cliente

on w_rep_debitos_pendientes_x_cliente.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_2=create rb_2
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_1
end on

on w_rep_debitos_pendientes_x_cliente.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_2)
destroy(this.rb_1)
end on

event open;call super::open;dw_1.insertrow(0)
end event

event ue_retrieve;long ll_nreg
string ls_cliente, ls_nombre

dw_1.accepttext()
ls_cliente = dw_1.getitemstring(1,"cliente")
Select ltrim(decode(length(ce_rucic),13,'R.U.C.: '||ce_rucic||' '||ce_razons||' '||ce_nomrep||' '||ce_aperep,ce_nombre||'  '||ce_apelli))
into :ls_nombre
from fa_clien
where em_codigo = :str_appgeninfo.empresa
and ce_codigo = :ls_cliente;
// si no esta registrado mensaje, si esta registrado inserto una fila		
if sqlca.sqlcode <> 0 then
	messageBox('Error','Cliente no registrado')
	dw_1.selecttext(1,len(ls_cliente))
	return
End if
dw_1.modify("st_cliente.text = '"+ls_nombre+"'")
if rb_1.checked then
dw_datos.DataObject =  'd_rep_movimiento_debito_cxc'
elseif rb_2.checked then
dw_datos.DataObject =  'd_cheques_postfechados_x_cliente' 
end if
dw_datos.SetTransObject(sqlca)
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,ls_cliente)
if ll_nreg < 1 then
	beep(1)
	messageBox('Error','No existen movimientos de d$$HEX1$$e900$$ENDHEX$$bito para este cliente')
end if		
dw_datos.modify("datawindow.print.preview = 'yes' datawindow.print.preview.zoom = '75'")

end event

event resize;dw_datos.resize(this.workSpaceWidth(), this.workSpaceHeight() - 300)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_debitos_pendientes_x_cliente
integer x = 14
integer y = 260
integer width = 2821
integer height = 1264
integer taborder = 50
string dataobject = "d_rep_movimiento_debito_cxc"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
if rb_1.checked then
f_recupera_empresa(dw_datos,"tt_codigo") 
f_recupera_empresa(dw_datos,"if_codigo") 
f_recupera_empresa(dw_datos,'su_codigo')
f_recupera_empresa(dw_datos,'fp_codigo')
end if
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_debitos_pendientes_x_cliente
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_debitos_pendientes_x_cliente
end type

type dw_1 from datawindow within w_rep_debitos_pendientes_x_cliente
integer x = 14
integer y = 24
integer width = 2821
integer height = 216
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_cliente"
boolean border = false
boolean livescroll = true
end type

type rb_2 from radiobutton within w_rep_debitos_pendientes_x_cliente
integer x = 462
integer y = 148
integer width = 645
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cheques postfechados"
end type

type rb_1 from radiobutton within w_rep_debitos_pendientes_x_cliente
integer x = 82
integer y = 148
integer width = 343
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "D$$HEX1$$e900$$ENDHEX$$bitos"
end type


HA$PBExportHeader$w_rep_debitosxcreditos_fact.srw
$PBExportComments$Si.Creditos de cxc dado un debito
forward
global type w_rep_debitosxcreditos_fact from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_debitosxcreditos_fact
end type
type dw_1 from datawindow within w_rep_debitosxcreditos_fact
end type
end forward

global type w_rep_debitosxcreditos_fact from w_sheet_1_dw_rep
integer width = 3790
integer height = 2412
string title = "D$$HEX1$$e900$$ENDHEX$$bito vs. Cr$$HEX1$$e900$$ENDHEX$$ditos"
dw_sel_rep dw_sel_rep
dw_1 dw_1
end type
global w_rep_debitosxcreditos_fact w_rep_debitosxcreditos_fact

on w_rep_debitosxcreditos_fact.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
this.Control[iCurrent+2]=this.dw_1
end on

on w_rep_debitosxcreditos_fact.destroy
call super::destroy
destroy(this.dw_sel_rep)
destroy(this.dw_1)
end on

event open;
this.ib_notautoretrieve = true
dw_sel_rep.InsertRow(0)
dw_sel_rep.setcolumn(1)
dw_sel_rep.setfocus()
dw_datos.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
f_recupera_empresa(dw_1,"cc_cheque_fp_codigo")
call super::open
dw_datos.modify("datawindow.print.preview = No")
end event

event resize;//int li_width, li_height
//
//li_width = this.workSpaceWidth()
//li_height = this.workSpaceHeight()
//
//this.setRedraw(False)
//dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
////dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
//this.setRedraw(True)
end event

event ue_retrieve;integer li_i
long ll_factura
string ls_movcar[], ls_factura, ls_debito, ls_cliente
boolean lb_nohay = false
dec{2} lc_debito

SetPointer(HourGlass!)
dw_sel_rep.accepttext()
ls_factura = dw_sel_rep.GetItemString(1,'factura')
ll_factura = long(ls_factura)

declare mov_cartera cursor for
SELECT "CC_MOVIM"."MT_CODIGO"  
FROM "CC_MOVIM"  
WHERE ( "CC_MOVIM"."TT_CODIGO" = '1' ) AND  
( "CC_MOVIM"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
( "CC_MOVIM"."VE_NUMERO" = :ll_factura )   ;
open mov_cartera;
do
fetch mov_cartera into :ls_debito;
	if sqlca.sqlcode <> 0 then 
		if isnull(ls_debito) or ls_debito = '' then lb_nohay = true
		exit
	end if
	li_i++
	ls_movcar[li_i] = ls_debito
loop while true
close mov_cartera;
if lb_nohay = true then
	messageBox('Revise por favor','Factura no existe')
	return
end if
dw_datos.modify("st_empresa.text='"+gs_empresa+"'  st_sucursal.text='"+gs_su_nombre+"' ")
dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_movcar,'1')
ls_cliente = dw_datos.GetItemString(dw_datos.getrow(),'ccliente')
lc_debito = dw_datos.GetItemdecimal(dw_datos.getrow(),'cc_totdeb')
dw_1.modify("st_cliente.text='"+ls_cliente+"'  st_factura.text='"+ls_factura+"' st_debito.text='"+string(lc_debito,'#,##0.00')+"'")
dw_1.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_movcar)			
SetPointer(Arrow!)

end event

event ue_zoomout;return 1
end event

event ue_zoomin;return 1
end event

event ue_print;int li_rc

openwithparm(w_dw_print_options,dw_1)
li_rc = message.DoubleParm

if li_rc = 1 then
   dw_1.print()	
end if

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_debitosxcreditos_fact
integer x = 0
integer y = 192
integer width = 3753
integer height = 660
string dataobject = "d_cab_cxc_creditoxdebito_fact"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::rbuttondown;return 1
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_debitosxcreditos_fact
integer x = 46
integer y = 260
integer width = 430
integer height = 172
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_debitosxcreditos_fact
end type

type dw_sel_rep from datawindow within w_rep_debitosxcreditos_fact
event ue_downkey pbm_dwnkey
integer width = 3753
integer height = 196
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_numero_fact"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_downkey;If keydown(keyenter!) Then
	dw_sel_rep.triggerevent("buttonclicked")
End if
end event

event buttonclicked;integer li_i
long ll_factura
string ls_movcar[], ls_factura, ls_debito, ls_cliente
boolean lb_nohay = false
dec{2} lc_debito

SetPointer(HourGlass!)
this.accepttext()
ls_factura = this.GetItemString(1,'factura')
ll_factura = long(ls_factura)

declare mov_cartera cursor for
SELECT "CC_MOVIM"."MT_CODIGO"  
FROM "CC_MOVIM"  
WHERE ( "CC_MOVIM"."TT_CODIGO" = '1' ) AND  
( "CC_MOVIM"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
( "CC_MOVIM"."VE_NUMERO" = :ll_factura )   ;
open mov_cartera;
do
fetch mov_cartera into :ls_debito;
	if sqlca.sqlcode <> 0 then 
		if isnull(ls_debito) or ls_debito = '' then lb_nohay = true
		exit
	end if
	li_i++
	ls_movcar[li_i] = ls_debito
loop while true
close mov_cartera;
if lb_nohay = true then
	messageBox('Revise por favor','Factura no existe')
	return
end if
dw_datos.modify("st_empresa.text='"+gs_empresa+"'  st_sucursal.text='"+gs_su_nombre+"' ")
dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_movcar,'1')
ls_cliente = dw_datos.GetItemString(dw_datos.getrow(),'ccliente')
lc_debito = dw_datos.GetItemdecimal(dw_datos.getrow(),'cc_totdeb')
dw_1.modify("st_cliente.text='"+ls_cliente+"'  st_factura.text='"+ls_factura+"' st_debito.text='"+string(lc_debito,'#,##0.00')+"'")
dw_1.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_movcar)			
SetPointer(Arrow!)

end event

type dw_1 from datawindow within w_rep_debitosxcreditos_fact
integer y = 844
integer width = 3753
integer height = 1464
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_rep_cxc_debitosxcreditos_fact"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


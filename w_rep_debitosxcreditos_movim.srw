HA$PBExportHeader$w_rep_debitosxcreditos_movim.srw
$PBExportComments$Si.Creditos de cxc dado un debito
forward
global type w_rep_debitosxcreditos_movim from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_debitosxcreditos_movim
end type
end forward

global type w_rep_debitosxcreditos_movim from w_sheet_1_dw_rep
integer width = 2971
integer height = 1768
string title = "D$$HEX1$$e900$$ENDHEX$$bito vs. Cr$$HEX1$$e900$$ENDHEX$$ditos"
dw_sel_rep dw_sel_rep
end type
global w_rep_debitosxcreditos_movim w_rep_debitosxcreditos_movim

on w_rep_debitosxcreditos_movim.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_debitosxcreditos_movim.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;string ls_estado
this.ib_notautoretrieve = true
dw_sel_rep.InsertRow(0)
dw_sel_rep.setfocus()
dw_datos.SetTransObject(sqlca)
dw_report.SetTransObject(sqlca)

call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event ue_retrieve;long ll_factura
string ls_movim

SetPointer(HourGlass!)
dw_sel_rep.accepttext()

ls_movim = dw_sel_rep.object.movim[1]



SELECT MT_CODIGO
INTO    :ls_movim
FROM   CC_MOVIM
WHERE VE_NUMERO = :ls_movim
AND     TT_CODIGO = '8';

dw_datos.modify("st_empresa.text='"+gs_empresa+"'  st_sucursal.text='"+gs_su_nombre+"' ")
dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_movim)
SetPointer(Arrow!)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_debitosxcreditos_movim
integer x = 0
integer y = 220
integer width = 2944
integer height = 1436
integer taborder = 20
string dataobject = "d_cab_movimiento_creditoxdebito"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_debitosxcreditos_movim
integer taborder = 10
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_debitosxcreditos_movim
end type

type dw_sel_rep from datawindow within w_rep_debitosxcreditos_movim
event ue_downkey pbm_dwnkey
integer width = 2944
integer height = 232
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sel_numero"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_downkey;If keydown(keyenter!) Then
	dw_sel_rep.triggerevent("buttonclicked")
End if
end event


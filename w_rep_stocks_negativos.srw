HA$PBExportHeader$w_rep_stocks_negativos.srw
$PBExportComments$Si.
forward
global type w_rep_stocks_negativos from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_stocks_negativos
end type
end forward

global type w_rep_stocks_negativos from w_sheet_1_dw_rep
integer x = 87
integer y = 260
integer width = 2688
integer height = 1508
string title = "Reportes Stocks Negativos"
long backcolor = 67108864
dw_1 dw_1
end type
global w_rep_stocks_negativos w_rep_stocks_negativos

event open;dw_1.InsertRow(0)
f_recupera_empresa(dw_1,"su_codigo")
ib_notautoretrieve = true
call super::open


end event

on w_rep_stocks_negativos.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_stocks_negativos.destroy
call super::destroy
destroy(this.dw_1)
end on

event ue_retrieve;string ls_sucursal

dw_1.AcceptText()
ls_sucursal = dw_1.GetItemString(dw_1.GetRow(),'su_codigo')
dw_datos.retrieve(str_appgeninfo.empresa,ls_sucursal)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_stocks_negativos
integer x = 0
integer y = 148
integer width = 2651
integer height = 1268
string dataobject = "d_rep_stocks_negativos"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_stocks_negativos
end type

type dw_1 from datawindow within w_rep_stocks_negativos
integer width = 2651
integer height = 148
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_external_sucursal"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


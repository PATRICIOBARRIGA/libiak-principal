HA$PBExportHeader$w_rep_mov_debito.srw
$PBExportComments$Si.Movimientos de d$$HEX1$$e900$$ENDHEX$$bito.
forward
global type w_rep_mov_debito from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_mov_debito
end type
end forward

global type w_rep_mov_debito from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2939
integer height = 1436
string title = "Movimientos de D$$HEX1$$e900$$ENDHEX$$bito"
long backcolor = 81324524
dw_1 dw_1
end type
global w_rep_mov_debito w_rep_mov_debito

type variables

end variables

on w_rep_mov_debito.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_mov_debito.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_1.InsertRow(0)
dw_datos.settransobject(sqlca)
this.ib_notautoretrieve = true
call super::open


end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;date ld_fec_ini,ld_fec_fin
integer li_fila


SetPointer(Hourglass!)
dw_1.AcceptText()
li_fila = dw_1.getrow()
ld_fec_ini = dw_1.GetItemDate(li_fila,'fec_ini')
ld_fec_fin = dw_1.GetItemDate(li_fila,'fec_fin')
if ld_fec_ini>ld_fec_fin or isnull(ld_fec_ini) then
		messageBox('Error','Rango de fechas incorrecto.')
		return
end if
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fec_ini,ld_fec_fin)
SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_mov_debito
integer x = 0
integer y = 136
integer width = 2898
integer height = 1168
integer taborder = 20
string dataobject = "d_rep_mov_debito_pintamax"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_mov_debito
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_mov_debito
end type

type dw_1 from datawindow within w_rep_mov_debito
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 2898
integer height = 136
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_rep_mov_debito"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event losefocus;//date    ld_fecha
//string  ls_fecha
//
//ld_fecha = dw_1.GetItemDate(1,"fecha_corte")
//ls_fecha = string(ld_fecha,"dd/mm/yyyy")
//declare rp_kardex_sucur procedure for
//  rp_kardex_sucur(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:is_pepa,:ls_fecha)
//  using sqlca;
//execute rp_kardex_sucur;
//if sqlca.sqldbcode <> 0 then
//	MessageBox("ERROR","El proceso no se ejecut$$HEX2$$f3002000$$ENDHEX$$o se ejecut$$HEX2$$f3002000$$ENDHEX$$mal.");
//	Return(1);
//end if
//dw_report.retrieve()
//dw_report.SetFocus()
end event


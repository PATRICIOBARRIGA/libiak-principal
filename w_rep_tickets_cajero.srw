HA$PBExportHeader$w_rep_tickets_cajero.srw
$PBExportComments$si
forward
global type w_rep_tickets_cajero from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_tickets_cajero
end type
end forward

global type w_rep_tickets_cajero from w_sheet_1_dw_rep
integer width = 2912
integer height = 1552
string title = "Reporte de Tickes por Cajero"
long backcolor = 1090519039
dw_sel_rep dw_sel_rep
end type
global w_rep_tickets_cajero w_rep_tickets_cajero

on w_rep_tickets_cajero.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_tickets_cajero.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;string ls_parametro[]

ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[2] = str_appgeninfo.sucursal
f_recupera_datos(dw_sel_rep,'caja',ls_parametro,2)
f_recupera_datos(dw_sel_rep,'cajero',ls_parametro,2)
dw_sel_rep.InsertRow(0)
this.ib_notautoretrieve = true
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

event ue_retrieve;long ll_filact
string ls_caja, ls_cajero, ls_emple
date fec_ini, fec_fin

dw_sel_rep.accepttext()
ll_filact = dw_sel_rep.GetRow()
SetPointer(HourGlass!)
fec_ini = dw_sel_rep.GetItemDate(ll_filact,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(ll_filact,'fec_fin')
ls_caja = dw_sel_rep.GetItemString(ll_filact,'caja')
ls_cajero = dw_sel_rep.GetItemString(ll_filact,'cajero')

select ep_nombre||' '||ep_apepat
into :ls_emple
from no_emple
where em_codigo = :str_appgeninfo.empresa
and ep_codigo = :ls_cajero;

dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' st_empleado.text = '"+ls_emple+"'")
dw_datos.Retrieve(integer(str_appgeninfo.sucursal), fec_ini, fec_fin,ls_caja,ls_cajero)

SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_tickets_cajero
integer x = 0
integer y = 180
integer width = 2875
integer height = 1264
string dataobject = "d_rep_tickets_fecha_incluye_anulado"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_tickets_cajero
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_tickets_cajero
end type

type dw_sel_rep from datawindow within w_rep_tickets_cajero
integer width = 2875
integer height = 188
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rep_tickets_cajero"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


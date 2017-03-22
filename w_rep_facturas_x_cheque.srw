HA$PBExportHeader$w_rep_facturas_x_cheque.srw
$PBExportComments$Si.Facturas por cheque cxp.Vale
forward
global type w_rep_facturas_x_cheque from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_facturas_x_cheque
end type
end forward

global type w_rep_facturas_x_cheque from w_sheet_1_dw_rep
integer width = 2981
integer height = 1552
string title = "Cancelaci$$HEX1$$f300$$ENDHEX$$n de Facturas ( Proveedores)"
long backcolor = 1090519039
dw_sel_rep dw_sel_rep
end type
global w_rep_facturas_x_cheque w_rep_facturas_x_cheque

on w_rep_facturas_x_cheque.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_facturas_x_cheque.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;datawindowchild ldwc_fp,ldwc_if,ldwc_facturas
string ls_estado

dw_sel_rep.InsertRow(0)
dw_datos.SetTransObject(sqlca)

/*Para el datawindow :  d_rep_facturas_x_cheque*/

//dw_datos.GetChild("cp_cruce_mp_codigo",ldwc_facturas)
//ldwc_facturas.SetTransObject(sqlca)
//ldwc_facturas.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
//
//
//
//dw_datos.getchild("cp_pago_fp_codigo",ldwc_fp)
//ldwc_fp.SetTransObject(sqlca)
//ldwc_fp.retrieve(str_appgeninfo.empresa)
//
//dw_datos.getchild("cp_pago_if_codigo",ldwc_if)
//ldwc_if.SetTransObject(sqlca)
//ldwc_if.retrieve(str_appgeninfo.empresa)
//

/*Para el datawindow: d_detalle_cheques*/
dw_datos.getchild("cn_codigo",ldwc_if)
ldwc_if.SetTransObject(sqlca)
ldwc_if.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)


this.ib_notautoretrieve = true
call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
dw_report.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event ue_retrieve;long ll_factura
string ls_cheque, ls_mpcoddeb

SetPointer(HourGlass!)
dw_sel_rep.acceptText()

ls_cheque = dw_sel_rep.GetItemString(1,'cheque')

if isnull(ls_cheque) or ls_cheque = ' ' then return
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cheque)
SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_facturas_x_cheque
integer x = 0
integer y = 228
integer width = 2944
integer height = 1216
integer taborder = 20
string dataobject = "d_detalle_cheques"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_facturas_x_cheque
integer x = 32
integer y = 836
integer taborder = 30
end type

type dw_sel_rep from datawindow within w_rep_facturas_x_cheque
integer width = 2944
integer height = 228
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_cheque"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


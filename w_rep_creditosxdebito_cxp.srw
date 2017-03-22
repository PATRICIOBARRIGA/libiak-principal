HA$PBExportHeader$w_rep_creditosxdebito_cxp.srw
$PBExportComments$Si.Debitos de cxp dado un credito de  CXP.Vale
forward
global type w_rep_creditosxdebito_cxp from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_creditosxdebito_cxp
end type
end forward

global type w_rep_creditosxdebito_cxp from w_sheet_1_dw_rep
integer width = 2981
integer height = 1608
string title = "D$$HEX1$$e900$$ENDHEX$$bito vs. Cr$$HEX1$$e900$$ENDHEX$$ditos"
long backcolor = 67108864
dw_sel_rep dw_sel_rep
end type
global w_rep_creditosxdebito_cxp w_rep_creditosxdebito_cxp

on w_rep_creditosxdebito_cxp.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
end on

on w_rep_creditosxdebito_cxp.destroy
call super::destroy
destroy(this.dw_sel_rep)
end on

event open;string ls_estado

dw_sel_rep.InsertRow(0)
dw_datos.SetTransObject(sqlca)

f_recupera_empresa(dw_sel_rep,"pv_codigo")

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

event ue_retrieve;string ls_factprov,ls_pvcodigo,ls_tipo,ls_pvnombre

SetPointer(HourGlass!)

dw_sel_rep.AcceptText()
ls_factprov = dw_sel_rep.GetItemString(1,'factura')
ls_pvcodigo = dw_sel_rep.GetitemString(1,"pv_codigo")

SELECT PV_RAZONS
INTO :ls_pvnombre
FROM IN_PROVE
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND PV_CODIGO = :ls_pvcodigo;

ls_tipo =     dw_sel_rep.GetitemString(1,"tipo")

//CHOOSE CASE ls_tipo
//	CASE 'S'
//		dw_datos.dataobject = "d_deb_vs_cre_servicios"
//	CASE 'M'
//   	dw_datos.dataobject = "d_deb_vs_cre"
//END CHOOSE

//f_recupera_empresa(dw_datos,"cp_pago_fp_codigo")
//f_recupera_empresa(dw_datos,"cp_pago_if_codigo")


dw_datos.settransobject(sqlca)
dw_datos.modify("st_prov.text = '"+ls_pvnombre+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
if not isnull(ls_factprov) and ls_factprov <> '' then
dw_datos.Retrieve(ls_pvcodigo,ls_factprov)	
end if
SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_creditosxdebito_cxp
integer x = 0
integer y = 236
integer width = 2944
integer height = 1256
string dataobject = "d_rep_creditos_vs_debitos_cxp"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_creditosxdebito_cxp
integer x = 114
integer y = 764
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_creditosxdebito_cxp
end type

type dw_sel_rep from datawindow within w_rep_creditosxdebito_cxp
integer width = 2944
integer height = 228
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_numero_cxp"
boolean border = false
boolean livescroll = true
end type


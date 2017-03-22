HA$PBExportHeader$w_reimpres_proveedores_nd.srw
$PBExportComments$Si.Debitos de clientes del sistema
forward
global type w_reimpres_proveedores_nd from w_sheet_1_dw_maint
end type
type dw_master from datawindow within w_reimpres_proveedores_nd
end type
end forward

global type w_reimpres_proveedores_nd from w_sheet_1_dw_maint
integer width = 2912
integer height = 1436
string title = "Reimpresi$$HEX1$$f300$$ENDHEX$$n de Notas de D$$HEX1$$e900$$ENDHEX$$bito (Cuentas por Pagar)"
long backcolor = 79741120
dw_master dw_master
end type
global w_reimpres_proveedores_nd w_reimpres_proveedores_nd

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();long ll_filAct
string ls_mpcodigo, ls_tvcodigo, ls_valletras,ls_fp
decimal lc_valor
int li_res

ll_filAct = dw_datos.getRow()
ls_mpcodigo = dw_datos.getItemString(ll_filAct, "mp_codigo")
ls_tvcodigo = dw_datos.getItemString(ll_filAct, "tv_codigo")
lc_valor = dw_datos.getItemNumber(ll_filAct, "mp_valor")
ls_fp = dw_datos.getItemString(ll_filAct, "fp_codigo")
ls_valletras = f_numero_a_letras (lc_valor)
dw_report.setTransObject(sqlca)
f_recupera_empresa(dw_report,"fp_codigo")
dw_report.modify("st_empresa.text ='"+gs_empresa+"'")
dw_report.retrieve(str_appgeninfo.empresa, str_appgeninfo.sucursal,ls_tvcodigo, ls_mpcodigo,ls_valletras,ls_fp)   

return 1

end function

event open;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n :  llena la estructura istr_argInformation, luego le indica 
//                la columna que se va asignar el c$$HEX1$$f300$$ENDHEX$$digo secuencial y el
// nombre de la columna de pr_param de donde se va a tomar el secuencial
//*********************************************************************/

ib_notautoretrieve = true

f_recupera_empresa(dw_datos,"pv_codigo") 
f_recupera_empresa(dw_datos,"tv_codigo") 
f_recupera_empresa(dw_master,'proveedor')


dw_master.InsertRow(0)
dw_master.SetFocus()
dw_master.PostEvent(Clicked!)
dw_datos.SetRowFocusIndicator(hand!)

istr_argInformation.nrArgs = 2
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal

dw_datos.is_SerialCodeColumn = "mp_codigo"
dw_datos.is_SerialCodeType = "DEB_CXP"
dw_datos.is_serialCodeCompany = str_appgeninfo.empresa


call super::open

end event

on w_reimpres_proveedores_nd.create
int iCurrent
call super::create
this.dw_master=create dw_master
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_master
end on

on w_reimpres_proveedores_nd.destroy
call super::destroy
destroy(this.dw_master)
end on

event close;call super::close;
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = false

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)

if this.ib_inReportMode then
   dw_report.resize(this.workSpaceWidth() - 2*dw_report.x, this.workSpaceHeight() - 2*dw_report.y)
	dw_master.visible = false	
else
	dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
	dw_datos.resize(dw_master.width,li_height - dw_master.y - dw_master.height)
	dw_master.visible = true
end if

this.setRedraw(True)
end event

event ue_retrieve;string ls_prov,ls_null
date ld_fecini,ld_fecfin
long ll_row

dw_master.accepttext()
ll_row = dw_master.getrow()
ls_prov = dw_master.getitemstring(ll_row,"proveedor")
ld_fecini = dw_master.getitemdate(ll_row,"fec_ini")
ld_fecfin = dw_master.getitemdate(ll_row,"fec_fin")
If ld_fecini > ld_fecfin Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rango de fechas incorrecto...<verif$$HEX1$$ed00$$ENDHEX$$que>")
	return
End if

select pv_codigo
into    :ls_null
from    in_prove
where  em_codigo = :str_appgeninfo.empresa
and     pv_codigo = :ls_prov;
if sqlca.sqlcode = 100 then
	messageBox('Error','Proveedor no registrado')
	return
end if
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_prov,ld_fecini,ld_fecfin)

end event

event ue_delete;dwitemstatus lstatus
Long     ll_row
ll_row =  dw_datos.GetRow()
lstatus = dw_datos.GetitemStatus(ll_row,0,Primary!)

If lstatus = Newmodified!  or lstatus = New! then
dw_datos.deleterow(0)
return 1
else
return -1
end if	


end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_reimpres_proveedores_nd
integer y = 204
integer width = 2885
integer height = 1128
string dataobject = "d_movimiento_debito_cxp"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_reimpres_proveedores_nd
integer y = 0
string dataobject = "d_nd_cxp_preimpresa"
end type

type dw_master from datawindow within w_reimpres_proveedores_nd
event ue_keydown pbm_dwnkey
integer width = 4965
integer height = 204
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_reimp_proveedor_nd"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;/*********************************************************************/
// Descripci$$HEX1$$f300$$ENDHEX$$n :  Si presiona F2 buscar
//
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : ING HUGO V OROZCO CH 20/01/1998  15:34 
/*********************************************************************/
if (KeyDown(KeyF2!))	 then
	dw_master.Reset()
	dw_datos.Reset()
	dw_master.InsertRow(0)
	dw_master.SetFocus()
end if
end event

event clicked;
//m_marco.m_opcion2.m_clientes.m_buscarcliente2.enabled = true
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_master.GetRow() 
dw_master.SetFocus()
end event


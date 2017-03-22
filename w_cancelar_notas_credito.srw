HA$PBExportHeader$w_cancelar_notas_credito.srw
forward
global type w_cancelar_notas_credito from w_sheet_1_dw
end type
type dw_1 from datawindow within w_cancelar_notas_credito
end type
end forward

global type w_cancelar_notas_credito from w_sheet_1_dw
integer width = 2501
integer height = 1184
string title = "Cruce de Notas de cr$$HEX1$$e900$$ENDHEX$$dito en POS "
long backcolor = 67108864
event ue_update pbm_custom07
event ue_delete pbm_custom08
event ue_insert pbm_custom09
event ue_enterqry pbm_custom20
event ue_execqry pbm_custom21
dw_1 dw_1
end type
global w_cancelar_notas_credito w_cancelar_notas_credito

type variables
dec{2} ic_valor
end variables

event ue_update;int li_sino
long ll_numero
string ls_fp,ls_estado,ls_seccion,ls_cheque,ls_cuenta
datetime hoy
dec{2} lc_valotros

select sysdate
into:hoy
from dual;

li_sino = messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro de dar de baja esta Nota de Cr$$HEX1$$e900$$ENDHEX$$dito",question!,yesno!,2)
if li_sino = 2 then return

dw_1.accepttext()
dw_datos.accepttext()
ll_numero = dw_1.getitemnumber(1,"numero")
ls_fp = dw_1.getitemstring(1,"fp_codigo")
ls_cheque = dw_1.getitemstring(1,"cheque")
ls_cuenta = dw_1.getitemstring(1,"cuenta")
ls_seccion = dw_datos.getitemstring(1,"bo_codigo")
ls_estado = dw_datos.getitemstring(1,"es_codigo")
lc_valotros = dw_datos.getitemdecimal(1,"ve_valotros")
if lc_valotros <> 0 then 
	messagebox('Error ','Antes debe poner cero(0) en el campo saldo. ')	
	return
end if
dw_datos.setitem(1,"ve_hora",hoy)
dw_datos.update()

INSERT INTO "FA_RECPAG"  
         ( "ES_CODIGO",   
           "EM_CODIGO",   
           "SU_CODIGO",   
           "BO_CODIGO",   
           "VE_NUMERO",   
           "RP_NUMERO",   
           "IF_CODIGO",   
           "FP_CODIGO",   
           "RP_NUMDOC",   
           "RP_NUMCTA",   
           "RP_FECHA",   
           "RP_FECVEN",   
           "RP_VALOR",   
           "RP_COMEN",   
           "ESTADO" )  
  VALUES ( :ls_estado,   
           :str_appgeninfo.empresa,   
           :str_appgeninfo.sucursal,   
           :ls_seccion,   
           :ll_numero,   
           1,   
           '0',   
           '2',   
           :ls_cheque,   
           :ls_cuenta,   
           :hoy,   
           :hoy,   
           :ic_valor,   
           null,   
           null );  
If sqlca.sqlcode <> 0 Then
	rollback;
	messagebox('Error Interno','Al insertar la nota de credito. Por favor reporte a sistemas')
	return
End if

commit;

dw_datos.reset()
dw_1.setcolumn(1)
dw_1.setfocus()

end event

event ue_delete;//dw_datos.uf_deleteCurrentRow()
end event

event ue_insert;//dw_datos.uf_InsertCurrentRow()
end event

on w_cancelar_notas_credito.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_cancelar_notas_credito.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;datawindowchild ldwc_seccion

dw_1.insertrow(0)
dw_1.settransobject(sqlca)
dw_datos.settransobject(sqlca)
ib_notautoretrieve = true
call super::open

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width,dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_1.height)
this.setRedraw(True)

end event

event ue_retrieve;return 1
end event

type dw_datos from w_sheet_1_dw`dw_datos within w_cancelar_notas_credito
integer y = 224
integer width = 2464
integer height = 832
integer taborder = 20
string dataobject = "d_cancelar_notas_credito"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event dw_datos::rbuttondown;call super::rbuttondown;//m_click_derecho NewMenu
//window lw_parent, lw_frame
//lw_frame=parent.parentWindow()
//NewMenu = CREATE m_click_derecho
//NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())
//
//Destroy NewMenu
end event

type dw_report from w_sheet_1_dw`dw_report within w_cancelar_notas_credito
integer x = 14
integer y = 104
integer width = 302
integer height = 128
integer taborder = 0
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_1 from datawindow within w_cancelar_notas_credito
integer y = 4
integer width = 2464
integer height = 220
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_cancela_nc_cxc"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;long ll_nreg,ll_numero
string datos[]

ll_numero = long(data)
If dwo.name = "numero" Then
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ll_numero)
If ll_nreg < 1 Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe Nota de Cr$$HEX1$$e900$$ENDHEX$$dito con este numero o ya fue cancelada")
	return
End if
ic_valor = dw_datos.getitemnumber(row,"ve_valotros")
End if
end event


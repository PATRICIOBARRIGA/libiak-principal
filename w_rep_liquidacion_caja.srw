HA$PBExportHeader$w_rep_liquidacion_caja.srw
$PBExportComments$Si.
forward
global type w_rep_liquidacion_caja from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_liquidacion_caja
end type
end forward

global type w_rep_liquidacion_caja from w_sheet_1_dw_rep
integer width = 2245
integer height = 1152
string title = "Liquidaci$$HEX1$$f300$$ENDHEX$$n de Caja"
long backcolor = 81324524
boolean ib_inreportmode = true
dw_1 dw_1
end type
global w_rep_liquidacion_caja w_rep_liquidacion_caja

on w_rep_liquidacion_caja.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_liquidacion_caja.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;ib_notautoretrieve = true
dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'ep_codigo')
this.ib_notautoretrieve = true
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
								"datawindow.print.preview=yes")
call super::open			

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_datos.resize(li_width,li_height - dw_datos.y )
this.setRedraw(True)
end event

event ue_retrieve;Date   ld_fecha,ld_fecha_fin
String ls_login,ep_codigo

dw_1.AcceptText()
ld_fecha = dw_1.GetItemDate(1,"fecha")
ld_fecha_fin = dw_1.GetItemDate(1,"fecha_fin")
ep_codigo = dw_1.GetItemString(1,"ep_codigo")
dw_datos.SetTransObject(SQLCA)
dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fecha ,ep_codigo,ld_fecha_fin)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_liquidacion_caja
integer x = 0
integer y = 208
integer width = 2222
integer height = 816
integer taborder = 60
string dataobject = "d_rep_liquidacion_caja"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_datos::retrieveend;call super::retrieveend;String  ls_empresa,ls_sucursal

SELECT EM_NOMBRE
INTO :ls_empresa
FROM    PR_EMPRE
WHERE  EM_CODIGO = :str_appgeninfo.empresa;

SELECT SU_NOMBRE
INTO :ls_sucursal
FROM    PR_SUCUR
WHERE  EM_CODIGO = :str_appgeninfo.empresa AND
SU_CODIGO = :str_appgeninfo.sucursal;
dw_datos.Modify("st_empresa.text = ' "+ls_empresa+"' st_sucursal.text = ' " +ls_sucursal+"'   ")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_liquidacion_caja
integer x = 1266
integer y = 436
integer taborder = 70
end type

type dw_1 from datawindow within w_rep_liquidacion_caja
event ue_nextfield pbm_dwnprocessenter
integer x = 5
integer y = 4
integer width = 2217
integer height = 204
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_liquidacion"
boolean border = false
boolean livescroll = true
end type

event ue_nextfield;Send(Handle(This),256,9,long(0,0))
Return 1
end event


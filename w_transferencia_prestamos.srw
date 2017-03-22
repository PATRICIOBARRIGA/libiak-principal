HA$PBExportHeader$w_transferencia_prestamos.srw
$PBExportComments$Si.Para generar un archivo de pagos a trav$$HEX1$$e900$$ENDHEX$$s del cual se realizar$$HEX2$$e1002000$$ENDHEX$$la transferencia bancaria
forward
global type w_transferencia_prestamos from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_transferencia_prestamos
end type
type em_2 from editmask within w_transferencia_prestamos
end type
type st_1 from statictext within w_transferencia_prestamos
end type
type st_2 from statictext within w_transferencia_prestamos
end type
type st_3 from statictext within w_transferencia_prestamos
end type
type st_4 from statictext within w_transferencia_prestamos
end type
type st_5 from statictext within w_transferencia_prestamos
end type
type dw_1 from datawindow within w_transferencia_prestamos
end type
end forward

global type w_transferencia_prestamos from w_sheet_1_dw_maint
integer width = 3163
integer height = 1868
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n de Archivo de Pr$$HEX1$$e900$$ENDHEX$$stamos/Descuentos "
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
dw_1 dw_1
end type
global w_transferencia_prestamos w_transferencia_prestamos

type variables
long il_nroguia
Datetime idt_hoy
end variables

on w_transferencia_prestamos.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.dw_1
end on

on w_transferencia_prestamos.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_1)
end on

event ue_retrieve;date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_datos.retrieve(ld_ini,ld_fin)
end event

event ue_saveas;Long ll_nreg

long ll_nroguia,ll_row


if isnull(il_nroguia) or il_nroguia = 0 then
	ll_row = dw_datos.getrow()
	if ll_row <= 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No hay datos para generar el archivo para la transferencia.",Exclamation!)
     return
     else
	ll_nroguia=dw_datos.Object.pp_nroguia[ll_row]	
     end if
else	  
ll_nroguia= il_nroguia
end if


ll_nreg = dw_1.Retrieve(ll_nroguia)
If ll_nreg > 0 Then 
	 If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea salvar la  transferencia?",Question!,YesNo!,2) = 2 Then Return
	  setpointer(hourglass!)
	   dw_1.saveas()
	   Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El archivo ha sido guardado en.... Archivos\TransfPrestamo.txt")
End if	
end event

event open;call super::open;dw_1.settransobject(sqlca)
dw_report.SetTransObject(sqlca)

idt_hoy = f_hoy()
em_1.text = string(idt_hoy,'dd/mm/yyyy')
em_2.text = string(idt_hoy,'dd/mm/yyyy')
setfocus(em_1)
end event

event ue_update;Long ll_reg,i
dwitemstatus  l_status

dw_datos.AcceptText()
il_nroguia = f_secuencial(str_appgeninfo.empresa,'SEC_PAGOS')

ll_reg = dw_datos.rowcount()
for i = 1 to ll_reg
	l_status = dw_datos.getitemstatus(i,0,Primary!)
	If dw_datos.object.pp_pagado[i] = 'S' and (l_status = datamodified! ) then
	   dw_datos.object.pp_nroguia[i] = il_nroguia
	   dw_datos.object.pp_fecenvio[i] = idt_hoy
	end if 
next
 dw_datos.object.pp_nroguia.color ="0~tIf(pp_nroguia="+string(il_nroguia)+",255,0)"
call super::ue_update


end event

event ue_print;long ll_nroguia,ll_row


if isnull(il_nroguia) or il_nroguia = 0 then
	ll_row = dw_datos.getrow()
	if ll_row <= 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No hay datos para imprimir",Exclamation!)
     return
     else
	ll_nroguia=dw_datos.Object.pp_nroguia[ll_row]	
     end if
else	  
ll_nroguia= il_nroguia
end if
dw_report.retrieve(ll_nroguia)	
call super::ue_print
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_transferencia_prestamos
integer x = 46
integer y = 252
integer width = 3017
integer height = 1484
string dataobject = "d_transferencia_prestamos"
boolean hsplitscroll = true
end type

event dw_datos::doubleclicked;call super::doubleclicked;Long i
Char lch_flag

This.AcceptText()
If dwo.name = 'cc_row' &
Then
	lch_flag = This.object.pp_pagado[row]
	for i = row to this.rowcount()
	this.setitem(i,"pp_pagado",lch_flag)
	next	
End if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_transferencia_prestamos
integer x = 32
integer y = 248
integer width = 3031
integer height = 1488
string dataobject = "d_rep_imp_prestamos"
end type

type em_1 from editmask within w_transferencia_prestamos
integer x = 306
integer y = 60
integer width = 320
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_transferencia_prestamos
integer x = 923
integer y = 60
integer width = 343
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_transferencia_prestamos
integer x = 55
integer y = 68
integer width = 247
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_transferencia_prestamos
integer x = 690
integer y = 68
integer width = 233
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_transferencia_prestamos
integer x = 1454
integer y = 56
integer width = 1605
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Marque la casilla para generar el archivo de pr$$HEX1$$e900$$ENDHEX$$stamos y presione F5 para guardar los cambios."
boolean focusrectangle = false
end type

type st_4 from statictext within w_transferencia_prestamos
integer x = 297
integer y = 136
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/yyyy]"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_transferencia_prestamos
integer x = 933
integer y = 136
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/yyyy]"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_transferencia_prestamos
boolean visible = false
integer x = 2354
integer y = 176
integer width = 558
integer height = 64
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_archivo_bco_prestamos"
boolean livescroll = true
end type


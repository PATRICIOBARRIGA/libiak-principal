HA$PBExportHeader$w_transferencia_otros_roles.srw
$PBExportComments$Si.Para generar un archivo de pagos a trav$$HEX1$$e900$$ENDHEX$$s del cual se realizar$$HEX2$$e1002000$$ENDHEX$$la transferencia bancaria
forward
global type w_transferencia_otros_roles from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_transferencia_otros_roles
end type
type em_2 from editmask within w_transferencia_otros_roles
end type
type st_1 from statictext within w_transferencia_otros_roles
end type
type st_2 from statictext within w_transferencia_otros_roles
end type
type dw_1 from datawindow within w_transferencia_otros_roles
end type
type st_4 from statictext within w_transferencia_otros_roles
end type
type st_5 from statictext within w_transferencia_otros_roles
end type
type st_3 from statictext within w_transferencia_otros_roles
end type
type rb_1 from radiobutton within w_transferencia_otros_roles
end type
type rb_2 from radiobutton within w_transferencia_otros_roles
end type
type rb_3 from radiobutton within w_transferencia_otros_roles
end type
type st_6 from statictext within w_transferencia_otros_roles
end type
type rb_4 from radiobutton within w_transferencia_otros_roles
end type
end forward

global type w_transferencia_otros_roles from w_sheet_1_dw_maint
integer width = 3401
integer height = 2020
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n de Archivo Tipos de Roles"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
dw_1 dw_1
st_4 st_4
st_5 st_5
st_3 st_3
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
st_6 st_6
rb_4 rb_4
end type
global w_transferencia_otros_roles w_transferencia_otros_roles

type variables
long il_nroguia
Datetime idt_hoy
end variables

on w_transferencia_otros_roles.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
this.st_4=create st_4
this.st_5=create st_5
this.st_3=create st_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.st_6=create st_6
this.rb_4=create rb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.rb_1
this.Control[iCurrent+10]=this.rb_2
this.Control[iCurrent+11]=this.rb_3
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.rb_4
end on

on w_transferencia_otros_roles.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.st_6)
destroy(this.rb_4)
end on

event ue_retrieve;char lch_tipo
date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

If rb_1.checked then lch_tipo = 'I'
If rb_2.checked then lch_tipo = 'U'
If rb_3.checked then lch_tipo = 'L'
If rb_4.checked then lch_tipo = 'C'
dw_datos.retrieve(lch_tipo,ld_ini,ld_fin)
end event

event ue_saveas;Long ll_nreg

long ll_nroguia,ll_row


if isnull(il_nroguia) or il_nroguia = 0 then
	ll_row = dw_datos.getrow()
	if ll_row <= 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No hay datos para generar el archivo para la transferencia.",Exclamation!)
     return
     else
	ll_nroguia=dw_datos.Object.rr_nroguia[ll_row]	
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
	If dw_datos.object.rr_envio[i] = 'S' and (l_status = datamodified! ) then
	   dw_datos.object.rr_nroguia[i] = il_nroguia
	   dw_datos.object.rr_fecenvio[i] = idt_hoy
	end if 
next
 dw_datos.object.rr_nroguia.color ="0~tIf(rr_nroguia="+string(il_nroguia)+",255,0)"
call super::ue_update


end event

event ue_print;
long ll_nroguia,ll_row


if isnull(il_nroguia) or il_nroguia = 0 then
	ll_row = dw_datos.getrow()
	if ll_row <= 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No hay datos para imprimir",Exclamation!)
     return
     else
	ll_nroguia=dw_datos.Object.rr_nroguia[ll_row]	
     end if
else	  
ll_nroguia= il_nroguia
end if
dw_report.retrieve(ll_nroguia)	
call super::ue_print

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_transferencia_otros_roles
integer x = 23
integer y = 404
integer width = 3319
integer height = 1424
string dataobject = "d_transferencia_otros_roles"
boolean hsplitscroll = true
end type

event dw_datos::doubleclicked;call super::doubleclicked;Long i
Char lch_flag

This.AcceptText()
If dwo.name = 'cc_row' &
Then
	lch_flag = this.object.rr_envio[row]

	for i = row to this.rowcount()
	this.setitem(i,"rr_envio",lch_flag)
	next	
End if


end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_transferencia_otros_roles
integer x = 27
integer y = 408
integer width = 3319
integer height = 1420
string dataobject = "d_rep_imp_otros_roles"
end type

type em_1 from editmask within w_transferencia_otros_roles
integer x = 750
integer y = 72
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

type em_2 from editmask within w_transferencia_otros_roles
integer x = 1275
integer y = 72
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

type st_1 from statictext within w_transferencia_otros_roles
integer x = 549
integer y = 80
integer width = 201
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

type st_2 from statictext within w_transferencia_otros_roles
integer x = 1097
integer y = 80
integer width = 174
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

type dw_1 from datawindow within w_transferencia_otros_roles
boolean visible = false
integer x = 2386
integer y = 156
integer width = 699
integer height = 72
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_archivo_bco_otros_roles"
boolean livescroll = true
end type

type st_4 from statictext within w_transferencia_otros_roles
integer x = 741
integer y = 148
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

type st_5 from statictext within w_transferencia_otros_roles
integer x = 1280
integer y = 148
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

type st_3 from statictext within w_transferencia_otros_roles
integer x = 1664
integer y = 68
integer width = 1746
integer height = 128
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Para generar el archivo de transferencia bancaria marque la casilla  y presione F5 para guardar los cambios."
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_transferencia_otros_roles
integer x = 146
integer y = 68
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Incentivos"
boolean checked = true
end type

type rb_2 from radiobutton within w_transferencia_otros_roles
integer x = 146
integer y = 144
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Utilidades"
end type

type rb_3 from radiobutton within w_transferencia_otros_roles
integer x = 146
integer y = 220
integer width = 530
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Beneficios sociales"
end type

type st_6 from statictext within w_transferencia_otros_roles
integer x = 146
integer y = 4
integer width = 283
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
string text = "Tipos de Rol"
boolean focusrectangle = false
end type

type rb_4 from radiobutton within w_transferencia_otros_roles
integer x = 151
integer y = 296
integer width = 503
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Comisiones"
end type


HA$PBExportHeader$w_rep_facturas_x_pago.srw
$PBExportComments$Si
forward
global type w_rep_facturas_x_pago from w_sheet_1_dw_rep
end type
type sle_1 from singlelineedit within w_rep_facturas_x_pago
end type
type st_1 from statictext within w_rep_facturas_x_pago
end type
type rb_1 from radiobutton within w_rep_facturas_x_pago
end type
type rb_2 from radiobutton within w_rep_facturas_x_pago
end type
type st_2 from statictext within w_rep_facturas_x_pago
end type
type st_3 from statictext within w_rep_facturas_x_pago
end type
type rr_1 from roundrectangle within w_rep_facturas_x_pago
end type
end forward

global type w_rep_facturas_x_pago from w_sheet_1_dw_rep
integer width = 2839
integer height = 1872
string title = "Facturas por pago"
long backcolor = 81324524
boolean ib_notautoretrieve = true
sle_1 sle_1
st_1 st_1
rb_1 rb_1
rb_2 rb_2
st_2 st_2
st_3 st_3
rr_1 rr_1
end type
global w_rep_facturas_x_pago w_rep_facturas_x_pago

on w_rep_facturas_x_pago.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_2=create st_2
this.st_3=create st_3
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.rr_1
end on

on w_rep_facturas_x_pago.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.rr_1)
end on

event ue_retrieve;string ls_mpcoddeb,ls_documento


Setpointer(Hourglass!)

ls_documento = sle_1.text
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
If rb_1.checked then
	
SELECT MP_CODIGO
INTO :ls_mpcoddeb
FROM CP_MOVIM
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND TV_CODIGO = '2'
AND TV_TIPO = 'D'
AND MP_CODIGO like '%'
AND EG_NUMERO = :ls_documento;


If sqlca.sqlcode < 0 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al determinar el Nro de Pago."+sqlca.sqlerrtext)
	return
end if

If sqlca.sqlcode = 100 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Nro de Pago no registrado para este egreso."+sqlca.sqlerrtext)
	return
end if
dw_datos.retrieve(str_Appgeninfo.empresa,str_appgeninfo.sucursal,ls_mpcoddeb,'D','2')
else
dw_datos.dataObject='d_rep_cancelaciones_x_debito'
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ls_documento)
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end if

Setpointer(Arrow!)


end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_facturas_x_pago
integer x = 59
integer y = 264
integer width = 2711
integer height = 1476
integer taborder = 40
string dataobject = "d_rep_fact_x_debito"
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_facturas_x_pago
integer x = 274
integer y = 644
integer taborder = 50
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_facturas_x_pago
integer x = 539
integer y = 1424
integer width = 581
integer height = 260
integer taborder = 60
end type

type sle_1 from singlelineedit within w_rep_facturas_x_pago
integer x = 1449
integer y = 132
integer width = 421
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rep_facturas_x_pago
integer x = 1102
integer y = 140
integer width = 338
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
string text = "Documento N$$HEX1$$ba00$$ENDHEX$$:"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_facturas_x_pago
integer x = 119
integer y = 124
integer width = 343
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
string text = "Egreso"
end type

type rb_2 from radiobutton within w_rep_facturas_x_pago
integer x = 434
integer y = 128
integer width = 535
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
string text = "Otros documentos"
end type

type st_2 from statictext within w_rep_facturas_x_pago
integer x = 73
integer y = 8
integer width = 1015
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
string text = "Seleccione el tipo de documento a consultar"
boolean focusrectangle = false
end type

type st_3 from statictext within w_rep_facturas_x_pago
integer x = 114
integer y = 60
integer width = 105
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Tipo"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_rep_facturas_x_pago
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 67108864
integer x = 59
integer y = 96
integer width = 978
integer height = 140
integer cornerheight = 40
integer cornerwidth = 46
end type


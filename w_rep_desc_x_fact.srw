HA$PBExportHeader$w_rep_desc_x_fact.srw
$PBExportComments$Si Reporte de descuentos por factura
forward
global type w_rep_desc_x_fact from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_desc_x_fact
end type
type em_2 from editmask within w_rep_desc_x_fact
end type
type st_1 from statictext within w_rep_desc_x_fact
end type
type st_2 from statictext within w_rep_desc_x_fact
end type
type rb_1 from radiobutton within w_rep_desc_x_fact
end type
type rb_2 from radiobutton within w_rep_desc_x_fact
end type
type lb_tipo from dropdownlistbox within w_rep_desc_x_fact
end type
type st_3 from statictext within w_rep_desc_x_fact
end type
end forward

global type w_rep_desc_x_fact from w_sheet_1_dw_rep
integer width = 2487
integer height = 1340
string title = "Descuentos por factura"
long backcolor = 81324524
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
rb_1 rb_1
rb_2 rb_2
lb_tipo lb_tipo
st_3 st_3
end type
global w_rep_desc_x_fact w_rep_desc_x_fact

type variables
string is_estado[],is_tipo


end variables

on w_rep_desc_x_fact.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.lb_tipo=create lb_tipo
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.lb_tipo
this.Control[iCurrent+8]=this.st_3
end on

on w_rep_desc_x_fact.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.lb_tipo)
destroy(this.st_3)
end on

event ue_retrieve;/*Toma los argumentos para recuperar los datos de F x M*/
string ls_estado
date ld_fini,ld_ffin
long ll_nreg


ld_fini = date(em_1.text)
ld_ffin = date(em_2.text)


ll_nreg = dw_datos.retrieve(is_estado,str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ld_fini,ld_ffin)
if ll_nreg <= 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas con est$$HEX1$$e100$$ENDHEX$$s condiciones")
end if

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_desc_x_fact
integer x = 0
integer y = 200
integer width = 2446
integer height = 1008
integer taborder = 60
string dataobject = "d_desc_x_fact"
end type

event dw_datos::retrievestart;call super::retrievestart;string ls_ini,ls_fin

ls_ini = em_1.text
ls_fin = em_2.text

this.modify("st_empresa.text = '"+gs_empresa+&
            "'st_sucursal.text ='"+upper(gs_su_nombre)+&
				"'st_seccion.text = '"+upper(gs_bo_nombre)+&
				"'st_ini.text = '"+ls_ini+&
				"'st_fin.text = '"+ls_fin+&
				"'st_tipo.text = '"+is_tipo+"'")


end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_desc_x_fact
integer x = 5
integer y = 876
integer width = 599
integer height = 216
integer taborder = 0
end type

type em_1 from editmask within w_rep_desc_x_fact
integer x = 965
integer y = 56
integer width = 315
integer height = 88
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

type em_2 from editmask within w_rep_desc_x_fact
integer x = 1522
integer y = 56
integer width = 315
integer height = 88
integer taborder = 30
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

type st_1 from statictext within w_rep_desc_x_fact
integer x = 768
integer y = 68
integer width = 183
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
string text = "Desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_desc_x_fact
integer x = 1358
integer y = 68
integer width = 160
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
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_desc_x_fact
integer x = 1934
integer y = 36
integer width = 480
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detallado"
end type

event clicked;dw_datos.setredraw(false)
dw_datos.Modify("DataWindow.Header.1.Height='72'")
dw_datos.Modify("Datawindow.Detail.height = '68'")
//dw_datos.object.ve_numero_1.visible = false
//dw_datos.object.fa_venta_ce_codigo_1.visible = false
//dw_datos.object.fa_clien_ce_razons_1.visible = false
//dw_datos.object.l_1.visible = true
dw_datos.setredraw(true)
return 1
end event

type rb_2 from radiobutton within w_rep_desc_x_fact
integer x = 1934
integer y = 108
integer width = 343
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumido"
end type

event clicked;dw_datos.setredraw(false)
dw_datos.Modify("DataWindow.Header.1.Height='0'")
dw_datos.Modify("Datawindow.Detail.height = '0'")
//dw_datos.object.ve_numero_1.visible = true
//dw_datos.object.fa_venta_ce_codigo_1.visible = true
//dw_datos.object.fa_clien_ce_razons_1.visible = true
//dw_datos.object.l_1.visible = false
dw_datos.setredraw(true)
return 1



end event

type lb_tipo from dropdownlistbox within w_rep_desc_x_fact
integer x = 73
integer y = 64
integer width = 635
integer height = 352
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
string item[] = {"Facturas","Tickets","Tickets y facturas"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index = 1 then
	is_estado[1] = '1'
	is_tipo = 'Descuentos por facturas'
elseif index = 2 then
	is_estado[1] = '2'
	is_tipo = 'Descuentos por tickets'
elseif index = 3 then
	is_estado[1] = '1'
	is_estado[2] = '2'
	is_tipo = 'Descuentos por tickets y facturas'
end if
end event

type st_3 from statictext within w_rep_desc_x_fact
integer x = 82
integer y = 12
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo"
boolean focusrectangle = false
end type


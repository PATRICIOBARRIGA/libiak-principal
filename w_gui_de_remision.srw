HA$PBExportHeader$w_gui_de_remision.srw
$PBExportComments$Si.
forward
global type w_gui_de_remision from w_sheet_1_dw_prueba
end type
type rb_1 from radiobutton within w_gui_de_remision
end type
type rb_2 from radiobutton within w_gui_de_remision
end type
type rb_3 from radiobutton within w_gui_de_remision
end type
type rb_4 from radiobutton within w_gui_de_remision
end type
type rb_8 from radiobutton within w_gui_de_remision
end type
type rb_7 from radiobutton within w_gui_de_remision
end type
type rb_6 from radiobutton within w_gui_de_remision
end type
type rb_5 from radiobutton within w_gui_de_remision
end type
type dw_1 from datawindow within w_gui_de_remision
end type
type gb_1 from groupbox within w_gui_de_remision
end type
end forward

global type w_gui_de_remision from w_sheet_1_dw_prueba
integer width = 2519
integer height = 1712
string title = "Gu$$HEX1$$ed00$$ENDHEX$$a de Remisi$$HEX1$$f300$$ENDHEX$$n "
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_8 rb_8
rb_7 rb_7
rb_6 rb_6
rb_5 rb_5
dw_1 dw_1
gb_1 gb_1
end type
global w_gui_de_remision w_gui_de_remision

event ue_print;call super::ue_print;int li_rc
gb_1.visible = false
dw_1.accepttext()
dw_datos.settransobject(sqlca)
//dw_report.visible = true
//if dw_datos.retrieve(dw_1.getitemnumber(dw_1.getrow(),'numero_factura') ) < 1 then 
//	 messagebox('Informaci$$HEX1$$f300$$ENDHEX$$n..... ','El n$$HEX1$$fa00$$ENDHEX$$mero de la factura ingresada no existe o ha sido anulada')
//	 return
//end if
//
if rb_1.checked then 
    dw_datos.object.t_venta.visible = true
end if 	 
if rb_2.checked then 
    dw_datos.object.t_compra.visible = true
end if 	 
if rb_3.checked then 
    dw_datos.object.t_transformacion.visible = true
end if 	 
if rb_4.checked then 
     dw_datos.object.t_consignacion.visible = true
end if 	 
if rb_5.checked then 
     dw_datos.object.t_traslado.visible = true
end if 	 
if rb_6.checked then 
     dw_datos.object.t_devolucion.visible = true
end if 	 
if rb_8.checked then 
     dw_datos.object.t_otros.visible = true
end if 	 
if rb_7.checked then 
     dw_datos.object.t_importacion.visible = true
end if 	 

openwithparm(w_dw_print_options,dw_datos)
li_rc = message.DoubleParm
//gi_print = 0
if li_rc = 1 then
   dw_datos.print()	
end if

end event

on w_gui_de_remision.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_8=create rb_8
this.rb_7=create rb_7
this.rb_6=create rb_6
this.rb_5=create rb_5
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_3
this.Control[iCurrent+4]=this.rb_4
this.Control[iCurrent+5]=this.rb_8
this.Control[iCurrent+6]=this.rb_7
this.Control[iCurrent+7]=this.rb_6
this.Control[iCurrent+8]=this.rb_5
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.gb_1
end on

on w_gui_de_remision.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_8)
destroy(this.rb_7)
destroy(this.rb_6)
destroy(this.rb_5)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;dw_1.insertrow(0)

end event

event ue_retrieve;//messagebox('infORMACION ',' ESTAN MARCAHANDO BIEN LAS COSAS')

dw_1.reset()
dw_1.visible= TRUE
dw_1.insertrow(0)
gb_1.visible = TRUE
dw_datos.visible = false 
rb_1.visible= TRUE
rb_2.visible= TRUE
rb_3.visible= TRUE
rb_4.visible= TRUE
rb_5.visible= TRUE
rb_6.visible= TRUE
rb_7.visible= TRUE
rb_8.visible= TRUE

end event

event activate;call super::activate;//m_marco.m_archivo.m_imprimir.visible = true
//m_marco.m_archivo.m_imprimir.toolBarItemVisible =true
//
end event

type dw_datos from w_sheet_1_dw_prueba`dw_datos within w_gui_de_remision
boolean visible = false
integer x = 50
integer y = 964
integer width = 2313
integer height = 568
string dataobject = "dw_guia_remision"
end type

type rb_1 from radiobutton within w_gui_de_remision
integer x = 101
integer y = 176
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Venta"
boolean checked = true
end type

type rb_2 from radiobutton within w_gui_de_remision
integer x = 101
integer y = 268
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
string text = "Compra"
end type

type rb_3 from radiobutton within w_gui_de_remision
integer x = 101
integer y = 352
integer width = 503
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
string text = "Transformaci$$HEX1$$f300$$ENDHEX$$n "
end type

type rb_4 from radiobutton within w_gui_de_remision
integer x = 101
integer y = 440
integer width = 457
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
string text = "Consignaci$$HEX1$$f300$$ENDHEX$$n "
end type

type rb_8 from radiobutton within w_gui_de_remision
integer x = 731
integer y = 428
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
string text = "Otros"
end type

type rb_7 from radiobutton within w_gui_de_remision
integer x = 731
integer y = 340
integer width = 407
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
string text = "Importaci$$HEX1$$f300$$ENDHEX$$n "
end type

type rb_6 from radiobutton within w_gui_de_remision
integer x = 731
integer y = 260
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
string text = "Devoluci$$HEX1$$f300$$ENDHEX$$n"
end type

type rb_5 from radiobutton within w_gui_de_remision
integer x = 731
integer y = 176
integer width = 1605
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
string text = "Traslados entre establecimientos de una misma Empresa"
end type

type dw_1 from datawindow within w_gui_de_remision
integer x = 567
integer y = 736
integer width = 1262
integer height = 168
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_cabecera_guia"
boolean border = false
boolean livescroll = true
end type

event itemchanged;gb_1.visible = false
dw_1.accepttext()
dw_1.visible = false 
dw_datos.settransobject(sqlca)
dw_datos.visible = true
dw_datos.retrieve('1',str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,dw_1.getitemnumber(dw_1.getrow(),'numero_factura') )
end event

type gb_1 from groupbox within w_gui_de_remision
integer x = 59
integer y = 56
integer width = 2336
integer height = 648
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 1090519039
string text = "    Motivo del Traslado    "
end type


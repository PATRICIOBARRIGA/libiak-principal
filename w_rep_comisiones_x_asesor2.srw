HA$PBExportHeader$w_rep_comisiones_x_asesor2.srw
$PBExportComments$Si.Con nueva pol$$HEX1$$ed00$$ENDHEX$$tica de comisiones...
forward
global type w_rep_comisiones_x_asesor2 from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_rep_comisiones_x_asesor2
end type
type rb_2 from radiobutton within w_rep_comisiones_x_asesor2
end type
type st_1 from statictext within w_rep_comisiones_x_asesor2
end type
type cbx_1 from checkbox within w_rep_comisiones_x_asesor2
end type
type st_2 from statictext within w_rep_comisiones_x_asesor2
end type
type cbx_2 from checkbox within w_rep_comisiones_x_asesor2
end type
type cbx_3 from checkbox within w_rep_comisiones_x_asesor2
end type
type cbx_4 from checkbox within w_rep_comisiones_x_asesor2
end type
type cbx_5 from checkbox within w_rep_comisiones_x_asesor2
end type
type rb_3 from radiobutton within w_rep_comisiones_x_asesor2
end type
end forward

global type w_rep_comisiones_x_asesor2 from w_sheet_1_dw_rep
integer width = 3419
integer height = 1640
string title = "Comisiones por Asesor"
boolean ib_notautoretrieve = true
rb_1 rb_1
rb_2 rb_2
st_1 st_1
cbx_1 cbx_1
st_2 st_2
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
rb_3 rb_3
end type
global w_rep_comisiones_x_asesor2 w_rep_comisiones_x_asesor2

on w_rep_comisiones_x_asesor2.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_1=create st_1
this.cbx_1=create cbx_1
this.st_2=create st_2
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cbx_2
this.Control[iCurrent+7]=this.cbx_3
this.Control[iCurrent+8]=this.cbx_4
this.Control[iCurrent+9]=this.cbx_5
this.Control[iCurrent+10]=this.rb_3
end on

on w_rep_comisiones_x_asesor2.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_1)
destroy(this.cbx_1)
destroy(this.st_2)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.rb_3)
end on

event ue_retrieve;if cbx_1.checked then /*Vehiculos*/
		if cbx_3.checked then  /*Comisiones*/
			 if rb_1.checked then dw_datos.dataobject = 'd_rep_comision_vehiculos_asesor_contado' 
			 if rb_2.checked then dw_datos.dataobject = 'd_rep_comision_vehiculos_asesor_credito' 
		elseif cbx_4.checked then /*Recuperaci$$HEX1$$f300$$ENDHEX$$n cartera*/
			 if rb_1.checked then dw_datos.dataobject = 'd_rep_np_recp_vehiculos_asesor_contado'
			 if rb_2.checked then dw_datos.dataobject = 'd_rep_np_recp_vehiculos_asesor_credito'
           end if	
elseif cbx_2.checked  then /*Mercader$$HEX1$$ed00$$ENDHEX$$a*/
 	     if cbx_3.checked then  /*Comisiones*/
		      if rb_1.checked then dw_datos.dataobject = 'd_rep_comision_mercaderia_asesor_contado'
	           if rb_2.checked then dw_datos.dataobject = 'd_rep_comision_mercaderia_asesor_credito' 
	     elseif cbx_4.checked then /*Recuperaci$$HEX1$$f300$$ENDHEX$$n cartera*/
		      if rb_1.checked then dw_datos.dataobject = 'd_rep_np_recp_mercaderia_asesor_contado'
	           if rb_2.checked then dw_datos.dataobject = 'd_rep_np_recp_mercaderia_asesor_credito'
			  if rb_3.checked then dw_datos.dataobject = 'd_rep_recurperacion_satexpro'
	     end if	
elseif cbx_5.checked then /*Notas de d$$HEX1$$e900$$ENDHEX$$bito por anticipo*/
dw_datos.dataobject = 'd_rep_comisiones_x_asesor_otrosdebitos'	

end if

dw_datos.SettransObject(sqlca)
dw_datos.retrieve()
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_comisiones_x_asesor2
integer x = 0
integer y = 320
integer width = 3351
integer height = 1208
string dataobject = "d_rep_comisiones_x_asesor_contado"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_comisiones_x_asesor2
integer y = 724
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_comisiones_x_asesor2
integer x = 873
integer y = 720
end type

type rb_1 from radiobutton within w_rep_comisiones_x_asesor2
integer x = 2208
integer y = 40
integer width = 352
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
string text = "Contado"
end type

type rb_2 from radiobutton within w_rep_comisiones_x_asesor2
integer x = 2213
integer y = 112
integer width = 352
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
string text = "Cr$$HEX1$$e900$$ENDHEX$$dito"
end type

type st_1 from statictext within w_rep_comisiones_x_asesor2
integer x = 46
integer y = 32
integer width = 242
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
string text = "Facturas  "
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_rep_comisiones_x_asesor2
integer x = 334
integer y = 36
integer width = 434
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
string text = "Veh$$HEX1$$ed00$$ENDHEX$$culos"
end type

type st_2 from statictext within w_rep_comisiones_x_asesor2
integer x = 1819
integer y = 44
integer width = 352
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
string text = "Forma de pago:"
boolean focusrectangle = false
end type

type cbx_2 from checkbox within w_rep_comisiones_x_asesor2
integer x = 329
integer y = 112
integer width = 439
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
string text = "Mercader$$HEX1$$ed00$$ENDHEX$$a"
end type

type cbx_3 from checkbox within w_rep_comisiones_x_asesor2
integer x = 1051
integer y = 32
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
string text = "Comisiones"
end type

type cbx_4 from checkbox within w_rep_comisiones_x_asesor2
integer x = 1056
integer y = 116
integer width = 626
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
string text = "Recuperaci$$HEX1$$f300$$ENDHEX$$n cartera"
end type

type cbx_5 from checkbox within w_rep_comisiones_x_asesor2
integer x = 329
integer y = 200
integer width = 754
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
string text = "Notas de D$$HEX1$$e900$$ENDHEX$$bito por Anticipo:"
end type

type rb_3 from radiobutton within w_rep_comisiones_x_asesor2
integer x = 2208
integer y = 192
integer width = 695
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
string text = "Facturas y Saldos Iniciales"
end type


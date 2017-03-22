HA$PBExportHeader$w_rep_distribucion_utilidades.srw
$PBExportComments$Si.
forward
global type w_rep_distribucion_utilidades from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_distribucion_utilidades
end type
type em_2 from editmask within w_rep_distribucion_utilidades
end type
type st_1 from statictext within w_rep_distribucion_utilidades
end type
type st_2 from statictext within w_rep_distribucion_utilidades
end type
type st_3 from statictext within w_rep_distribucion_utilidades
end type
type st_4 from statictext within w_rep_distribucion_utilidades
end type
type st_5 from statictext within w_rep_distribucion_utilidades
end type
type em_3 from editmask within w_rep_distribucion_utilidades
end type
type st_6 from statictext within w_rep_distribucion_utilidades
end type
type st_7 from statictext within w_rep_distribucion_utilidades
end type
type st_8 from statictext within w_rep_distribucion_utilidades
end type
type em_4 from editmask within w_rep_distribucion_utilidades
end type
type em_5 from editmask within w_rep_distribucion_utilidades
end type
type rb_1 from radiobutton within w_rep_distribucion_utilidades
end type
type rb_2 from radiobutton within w_rep_distribucion_utilidades
end type
end forward

global type w_rep_distribucion_utilidades from w_sheet_1_dw_rep
integer width = 3493
integer height = 1796
long backcolor = 67108864
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
em_3 em_3
st_6 st_6
st_7 st_7
st_8 st_8
em_4 em_4
em_5 em_5
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_distribucion_utilidades w_rep_distribucion_utilidades

type variables
DataStore	 ids_util
end variables

on w_rep_distribucion_utilidades.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.em_3=create em_3
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.em_4=create em_4
this.em_5=create em_5
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.em_3
this.Control[iCurrent+9]=this.st_6
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.st_8
this.Control[iCurrent+12]=this.em_4
this.Control[iCurrent+13]=this.em_5
this.Control[iCurrent+14]=this.rb_1
this.Control[iCurrent+15]=this.rb_2
end on

on w_rep_distribucion_utilidades.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_3)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.em_4)
destroy(this.em_5)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;Date ld_ini,ld_fin
Decimal lc_valordistribuir,&
            lc_pertje_e,&
		   lc_pertje_c,&		
            lc_valor_empleados,&
		   lc_valor_cargas,&
		   lc_utilidades	
			
			
lc_valordistribuir = dec(em_1.text)
ld_ini =  Date(em_2.text)
ld_fin =  Date(em_3.text)
lc_pertje_e = dec(em_4.text)
lc_pertje_c = dec(em_5.text)


lc_utilidades = (lc_valordistribuir*100)/15

lc_valor_empleados = lc_utilidades*(lc_pertje_e/100)
lc_valor_cargas       = lc_utilidades*(lc_pertje_c/100)



if rb_1.checked then
dw_datos.DataObject = 'd_rep_calculo_utilidades_prn'	
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve()
elseif rb_2.checked then
	dw_datos.DataObject = 'd_rep_calculo_utilidades'	
	dw_datos.SetTransObject(sqlca)
	dw_datos.retrieve(lc_valor_empleados,lc_valor_cargas,ld_ini,ld_fin)
end if


end event

event open;call super::open;ids_util = Create DataStore

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_distribucion_utilidades
integer x = 27
integer y = 288
integer width = 3401
integer height = 1380
integer taborder = 80
string dataobject = "d_rep_calculo_utilidades"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_distribucion_utilidades
integer x = 2638
integer y = 1020
integer width = 713
integer height = 484
string dataobject = "d_rep_calculo_utilidades_prn"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_distribucion_utilidades
integer x = 50
integer y = 1124
integer width = 2130
integer taborder = 70
string dataobject = "d_rep_calculo_utilidades"
end type

type em_1 from editmask within w_rep_distribucion_utilidades
integer x = 462
integer y = 52
integer width = 338
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###.00"
end type

type em_2 from editmask within w_rep_distribucion_utilidades
integer x = 233
integer y = 164
integer width = 343
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
string text = "01/01/2006"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
boolean autoskip = true
end type

type st_1 from statictext within w_rep_distribucion_utilidades
integer x = 32
integer y = 172
integer width = 187
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_distribucion_utilidades
integer x = 667
integer y = 172
integer width = 192
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

type st_3 from statictext within w_rep_distribucion_utilidades
integer x = 32
integer y = 60
integer width = 402
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
string text = "Valor a distribuir:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rep_distribucion_utilidades
integer x = 1970
integer y = 60
integer width = 622
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
string text = "Porcentaje para empleados:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_rep_distribucion_utilidades
integer x = 1806
integer y = 172
integer width = 786
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
string text = "Porcentaje para cargas familiares:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_3 from editmask within w_rep_distribucion_utilidades
integer x = 869
integer y = 164
integer width = 338
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "31/12/2006"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_6 from statictext within w_rep_distribucion_utilidades
integer x = 818
integer y = 60
integer width = 480
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
string text = "15% de las Utilidades"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_rep_distribucion_utilidades
integer x = 2784
integer y = 60
integer width = 59
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
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within w_rep_distribucion_utilidades
integer x = 2789
integer y = 172
integer width = 59
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
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_4 from editmask within w_rep_distribucion_utilidades
integer x = 2610
integer y = 56
integer width = 165
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
string text = "10"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
boolean autoskip = true
end type

type em_5 from editmask within w_rep_distribucion_utilidades
integer x = 2610
integer y = 172
integer width = 165
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "5"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_rep_distribucion_utilidades
integer x = 2921
integer y = 64
integer width = 466
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
string text = "Formato Ministerio"
end type

type rb_2 from radiobutton within w_rep_distribucion_utilidades
integer x = 2921
integer y = 152
integer width = 462
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
string text = "Formato Reporte"
end type


HA$PBExportHeader$w_rep_stock_vehiculos.srw
$PBExportComments$Si.
forward
global type w_rep_stock_vehiculos from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_rep_stock_vehiculos
end type
type rb_2 from radiobutton within w_rep_stock_vehiculos
end type
end forward

global type w_rep_stock_vehiculos from w_sheet_1_dw_rep
integer width = 3026
integer height = 2584
string title = "Stocks de Veh$$HEX1$$ed00$$ENDHEX$$culos"
long backcolor = 67108864
boolean ib_notautoretrieve = true
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_stock_vehiculos w_rep_stock_vehiculos

type variables

end variables

on w_rep_stock_vehiculos.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
end on

on w_rep_stock_vehiculos.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.rb_2)
end on

event ue_retrieve;setpointer(hourglass!)

if rb_1.checked then
	dw_datos.dataobject = "d_stocks_vehiculos_x_empresa"	
	dw_datos.settransobject(sqlca)	
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")	
	dw_datos.Retrieve(str_appgeninfo.empresa)

else
	dw_datos.dataobject = "d_stocks_vehiculos_x_sucursal"
	dw_datos.settransobject(sqlca)	
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'")	
	dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
end if
dw_datos.modify("datawindow.print.preview = yes")
w_marco.setmicrohelp("Reporte Listo")
SetPointer(Arrow!)


end event

event ue_print;int li_rc

if rb_1.checked then
	openwithparm(w_dw_print_options,dw_report)
	li_rc = message.DoubleParm
	if li_rc = 1 then	
		dw_report.print()
	end if
else
	openwithparm(w_dw_print_options,dw_datos)
	li_rc = message.DoubleParm
	if li_rc = 1 then	
		dw_datos.print()
	end if
end if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_stock_vehiculos
integer x = 27
integer y = 224
integer width = 2930
integer height = 2228
integer taborder = 40
string dataobject = "d_stocks_vehiculos_x_sucursal"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_stock_vehiculos
integer x = 37
integer y = 232
integer width = 192
integer height = 172
integer taborder = 0
borderstyle borderstyle = stylelowered!
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_stock_vehiculos
integer x = 887
integer y = 32
integer width = 91
integer height = 84
integer taborder = 0
end type

type rb_1 from radiobutton within w_rep_stock_vehiculos
integer x = 178
integer y = 36
integer width = 293
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
string text = "Empresa"
end type

type rb_2 from radiobutton within w_rep_stock_vehiculos
integer x = 178
integer y = 132
integer width = 311
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
string text = "Sucursal"
boolean checked = true
end type


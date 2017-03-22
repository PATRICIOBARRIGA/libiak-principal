HA$PBExportHeader$w_rep_lista_de_precios.srw
forward
global type w_rep_lista_de_precios from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_lista_de_precios
end type
end forward

global type w_rep_lista_de_precios from w_sheet_1_dw_rep
integer width = 3675
integer height = 1816
string title = "Ventas por fabricante"
long backcolor = 67108864
boolean ib_notautoretrieve = true
st_1 st_1
end type
global w_rep_lista_de_precios w_rep_lista_de_precios

type variables
boolean ib_cancel
end variables

on w_rep_lista_de_precios.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_rep_lista_de_precios.destroy
call super::destroy
destroy(this.st_1)
end on

event ue_retrieve;Integer li_estados[4],index
Date  ld_ini,ld_fin

SetPointer(Hourglass!)

w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n.....por favor espere....!!!!")
dw_datos.retrieve()
w_marco.SetMicrohelp("Listo....!!!!")

SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_lista_de_precios
integer x = 37
integer y = 136
integer width = 3579
integer height = 1548
string dataobject = "d_rep_items_precio_dctoxtipocli"
boolean border = true
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_lista_de_precios
integer x = 1705
integer y = 812
integer taborder = 60
string dataobject = "d_rep_items_precio_dctoxtipocli"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_lista_de_precios
integer x = 681
integer y = 952
integer taborder = 90
end type

type st_1 from statictext within w_rep_lista_de_precios
integer x = 37
integer y = 48
integer width = 896
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "LISTA DE PRECIOS INCLUIDO IVA"
boolean focusrectangle = false
end type


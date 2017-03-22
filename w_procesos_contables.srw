HA$PBExportHeader$w_procesos_contables.srw
$PBExportComments$Si.
forward
global type w_procesos_contables from window
end type
type pb_2 from picturebutton within w_procesos_contables
end type
type pb_1 from picturebutton within w_procesos_contables
end type
type lb_1 from listbox within w_procesos_contables
end type
end forward

global type w_procesos_contables from window
integer width = 1189
integer height = 920
boolean titlebar = true
string title = "Contabilizaci$$HEX1$$f300$$ENDHEX$$n"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
pb_2 pb_2
pb_1 pb_1
lb_1 lb_1
end type
global w_procesos_contables w_procesos_contables

type variables
Int   ii_index
end variables

on w_procesos_contables.create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.lb_1=create lb_1
this.Control[]={this.pb_2,&
this.pb_1,&
this.lb_1}
end on

on w_procesos_contables.destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.lb_1)
end on

type pb_2 from picturebutton within w_procesos_contables
integer x = 910
integer y = 320
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Cancel.Gif"
alignment htextalign = left!
end type

event clicked;Close(Parent)
end event

type pb_1 from picturebutton within w_procesos_contables
integer x = 905
integer y = 76
integer width = 174
integer height = 152
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;CHOOSE CASE ii_index
	CASE 1
		 OpenSheet(w_res_asiento_liquidacion_caja,w_marco,0, Original!)
	CASE 2	
	    OpenSheet(w_res_asiento_cancelacion_cartera,w_marco,0, Original!)
	CASE 3
		 OpenSheet(w_res_asiento_poscierre_diario,w_marco,0,Original!)
	CASE 4
		 OpenSheet(w_res_asiento_facturacion_pormayor,w_marco,0, Original!)
    CASE 5
		 OpenSheet(w_res_asiento_depositos,w_marco,0, Original!)
	CASE 6
		 OpenSheet(w_res_egresos_dia,w_marco,0, Original!)
    CASE 7
		 OpenSheet(w_res_asiento_posdevol_diario,w_marco,0, Original!)
    CASE 8
		 OpenSheet(w_alta_rotacion,w_marco,0, Original!)
	 CASE 9
		 OpenSheet(w_res_asiento_compras,w_marco,0, Original!)	 
   	 
END CHOOSE	  

end event

type lb_1 from listbox within w_procesos_contables
integer x = 59
integer y = 68
integer width = 745
integer height = 696
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
string item[] = {"Liquidaci$$HEX1$$f300$$ENDHEX$$n de Caja","Cancelaci$$HEX1$$f300$$ENDHEX$$n Cartera","Cierre de Caja Diario","Facturaci$$HEX1$$f300$$ENDHEX$$n por Mayor","Ingresos del d$$HEX1$$ed00$$ENDHEX$$a","Egresos del d$$HEX1$$ed00$$ENDHEX$$a","Devoluci$$HEX1$$f300$$ENDHEX$$n de Caja Diario","Alta Rotaci$$HEX1$$f300$$ENDHEX$$n","Resumen de compras"}
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;/*Carga el indice de la ventana*/
ii_index = index
pb_1.Triggerevent(Clicked!)

end event

event selectionchanged;ii_index = index
end event


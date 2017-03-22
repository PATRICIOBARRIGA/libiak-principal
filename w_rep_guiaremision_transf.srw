HA$PBExportHeader$w_rep_guiaremision_transf.srw
$PBExportComments$Si.
forward
global type w_rep_guiaremision_transf from w_sheet_1_dw_rep
end type
type dw_2 from datawindow within w_rep_guiaremision_transf
end type
type sle_ticket from singlelineedit within w_rep_guiaremision_transf
end type
type st_1 from statictext within w_rep_guiaremision_transf
end type
type ddlb_1 from dropdownlistbox within w_rep_guiaremision_transf
end type
type st_2 from statictext within w_rep_guiaremision_transf
end type
type gb_2 from groupbox within w_rep_guiaremision_transf
end type
end forward

global type w_rep_guiaremision_transf from w_sheet_1_dw_rep
integer width = 3209
integer height = 2036
string title = "Gu$$HEX1$$ed00$$ENDHEX$$as de Remisi$$HEX1$$f300$$ENDHEX$$n"
long backcolor = 79741120
dw_2 dw_2
sle_ticket sle_ticket
st_1 st_1
ddlb_1 ddlb_1
st_2 st_2
gb_2 gb_2
end type
global w_rep_guiaremision_transf w_rep_guiaremision_transf

type variables
int ii_index
end variables

on w_rep_guiaremision_transf.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.sle_ticket=create sle_ticket
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.sle_ticket
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.ddlb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.gb_2
end on

on w_rep_guiaremision_transf.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.sle_ticket)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.gb_2)
end on

event open;dw_2.SetTransObject(sqlca)
f_recupera_empresa(dw_2,"sucursal")
f_recupera_empresa(dw_2,"bodega")
dw_2.insertrow(0)
this.ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;string ls_ticket,ls_sucori,ls_bodori,ls_sucdes,ls_boddes
datawindowchild dwc_nombre,dwc_direccion, dwc_ruc   //Para sucursales

ls_ticket =sle_ticket.text
ls_sucdes = dw_2.getitemstring(1,"sucursal")
ls_boddes = dw_2.getitemstring(1,"bodega")

If str_appgeninfo.seccion = ls_boddes Then
	messagebox("Error","Las bodegas no pueden ser las mismas...<Verif$$HEX1$$ed00$$ENDHEX$$que>")
	return
End if

dw_datos.getchild("in_transfer_su_codenv",dwc_direccion)
dwc_direccion.SetTransObject(SQLCA)
dwc_direccion.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

dw_datos.getchild("in_transfer_su_codigo_2",dwc_nombre)
dwc_nombre.SetTransObject(SQLCA)
dwc_nombre.retrieve(str_appgeninfo.empresa,ls_sucdes)

dw_datos.getchild("in_transfer_su_codigo_1",dwc_direccion)
dwc_direccion.SetTransObject(SQLCA)
dwc_direccion.retrieve(str_appgeninfo.empresa,ls_sucdes)

dw_datos.getchild("in_transfer_su_codenv_2",dwc_nombre)
dwc_nombre.SetTransObject(SQLCA)
dwc_nombre.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

dw_datos.getchild("in_transfer_su_codigo",dwc_ruc)
dwc_ruc.SetTransObject(SQLCA)
dwc_ruc.retrieve(str_appgeninfo.empresa,ls_sucdes)


dw_datos.getchild("in_transfer_su_codenv_1",dwc_ruc)
dwc_ruc.SetTransObject(SQLCA)
dwc_ruc.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_sucdes,ls_boddes,ls_ticket,ii_index)



end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_datos.resize(li_width,li_height)
this.setRedraw(True)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_guiaremision_transf
integer x = 18
integer y = 328
integer width = 3122
integer height = 1568
integer taborder = 0
string dataobject = "guia_de_remision_transf"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_guiaremision_transf
integer x = 46
integer y = 432
integer width = 343
integer height = 232
integer taborder = 30
end type

type dw_2 from datawindow within w_rep_guiaremision_transf
integer x = 142
integer y = 56
integer width = 2793
integer height = 132
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_sucur_bod_guia_transf"
boolean border = false
boolean livescroll = true
end type

event itemchanged;datawindowchild dwc_bodega

this.getchild("bodega",dwc_bodega)
dwc_bodega.setfilter("su_codigo = '"+data+"'")
dwc_bodega.filter()


end event

type sle_ticket from singlelineedit within w_rep_guiaremision_transf
integer x = 549
integer y = 188
integer width = 526
integer height = 84
integer taborder = 20
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

type st_1 from statictext within w_rep_guiaremision_transf
integer x = 155
integer y = 204
integer width = 375
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
string text = "N$$HEX1$$fa00$$ENDHEX$$mero de Envio"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_rep_guiaremision_transf
integer x = 1810
integer y = 188
integer width = 1065
integer height = 472
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
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Venta","Compra","Transformaci$$HEX1$$f300$$ENDHEX$$n","Consignaci$$HEX1$$f300$$ENDHEX$$n","Traslado entre establecimientos de una misma empresa","Traslado por emisor itinerante","De comprobantes de venta","Devoluci$$HEX1$$f300$$ENDHEX$$n","Importaci$$HEX1$$f300$$ENDHEX$$n","Exportaci$$HEX1$$f300$$ENDHEX$$n","Otros"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_index = index
end event

type st_2 from statictext within w_rep_guiaremision_transf
integer x = 1641
integer y = 204
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
string text = "Motivo"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_rep_guiaremision_transf
integer x = 14
integer y = 8
integer width = 3122
integer height = 308
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Destino"
end type


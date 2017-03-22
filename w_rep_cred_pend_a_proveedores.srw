HA$PBExportHeader$w_rep_cred_pend_a_proveedores.srw
$PBExportComments$Si.
forward
global type w_rep_cred_pend_a_proveedores from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_cred_pend_a_proveedores
end type
type em_2 from editmask within w_rep_cred_pend_a_proveedores
end type
type st_1 from statictext within w_rep_cred_pend_a_proveedores
end type
type st_2 from statictext within w_rep_cred_pend_a_proveedores
end type
type dw_2 from datawindow within w_rep_cred_pend_a_proveedores
end type
type cbx_1 from checkbox within w_rep_cred_pend_a_proveedores
end type
end forward

global type w_rep_cred_pend_a_proveedores from w_sheet_1_dw_rep
integer width = 3497
integer height = 2280
string title = "Cr$$HEX1$$e900$$ENDHEX$$ditos Pendientes a Proveedores"
long backcolor = 67108864
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
dw_2 dw_2
cbx_1 cbx_1
end type
global w_rep_cred_pend_a_proveedores w_rep_cred_pend_a_proveedores

type variables
datawindowchild  idwc_prov
string is_pvcodigo
end variables

on w_rep_cred_pend_a_proveedores.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_2=create dw_2
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cbx_1
end on

on w_rep_cred_pend_a_proveedores.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.cbx_1)
end on

event ue_retrieve;date ld_ini,ld_fin
string ls_pvcodigo
setpointer(hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if cbx_1.checked then
	is_pvcodigo = '%'
else
	is_pvcodigo = dw_2.GetItemString(dw_2.getrow(),"proveedor")
end if

dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.retrieve(str_appgeninfo.empresa,ld_ini,ld_fin,str_appgeninfo.sucursal,is_pvcodigo)
setpointer(arrow!) 
end event

event open;call super::open;f_recupera_empresa(dw_datos,"tv_codigo")
dw_2.SetTransObject(SQLCA)   //Proveedores
dw_2.GetChild("proveedor",idwc_prov)

idwc_prov.SetTransObject(SQLCA)
idwc_prov.retrieve(str_appgeninfo.empresa)
dw_2.Insertrow(0)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cred_pend_a_proveedores
integer x = 9
integer y = 172
integer width = 3433
integer height = 1996
integer taborder = 50
string dataobject = "d_rep_pago_proveedores"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cred_pend_a_proveedores
integer taborder = 60
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_cred_pend_a_proveedores
integer taborder = 70
end type

type em_1 from editmask within w_rep_cred_pend_a_proveedores
integer x = 265
integer y = 44
integer width = 343
integer height = 76
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

type em_2 from editmask within w_rep_cred_pend_a_proveedores
integer x = 937
integer y = 44
integer width = 343
integer height = 76
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

type st_1 from statictext within w_rep_cred_pend_a_proveedores
integer x = 46
integer y = 52
integer width = 210
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

type st_2 from statictext within w_rep_cred_pend_a_proveedores
integer x = 722
integer y = 52
integer width = 210
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

type dw_2 from datawindow within w_rep_cred_pend_a_proveedores
integer x = 1330
integer y = 28
integer width = 1509
integer height = 108
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_Sel_proveedor"
boolean maxbox = true
boolean border = false
boolean livescroll = true
end type

type cbx_1 from checkbox within w_rep_cred_pend_a_proveedores
integer x = 2853
integer y = 36
integer width = 279
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
string text = "Todos"
end type

event clicked;dw_2.SetItem(dw_2.getrow(),"proveedor","")


end event


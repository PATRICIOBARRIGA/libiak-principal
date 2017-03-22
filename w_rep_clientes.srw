HA$PBExportHeader$w_rep_clientes.srw
$PBExportComments$Listados de clientes agrupados por Vendedor, tipo, clase.
forward
global type w_rep_clientes from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_clientes
end type
type cbx_1 from checkbox within w_rep_clientes
end type
end forward

global type w_rep_clientes from w_sheet_1_dw_rep
integer x = 5
integer y = 240
integer width = 2944
integer height = 1444
string title = "Reporte de Clientes"
long backcolor = 81324524
dw_1 dw_1
cbx_1 cbx_1
end type
global w_rep_clientes w_rep_clientes

type variables

end variables

on w_rep_clientes.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cbx_1
end on

on w_rep_clientes.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cbx_1)
end on

event open;dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'vendedor')
//f_recupera_empresa(dw_1,'ce_codigo')
f_recupera_empresa(dw_1,'ca_codigo')
this.ib_notautoretrieve = true
call super::open
end event

event resize;call super::resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;string ls_tipo



dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.retrieve(str_appgeninfo.empresa)


ls_tipo = dw_1.getitemstring(1,"vendedor	")

if cbx_1.checked = false then
	If isnull(ls_tipo) or ls_tipo = "" Then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Seleccione el asesor")
		return
	end if
	dw_datos.Setfilter("ep_codigo = '"+ls_tipo+"'")
	dw_datos.Filter()
end if


end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_clientes
integer x = 5
integer y = 160
integer width = 2912
integer height = 1176
integer taborder = 20
string dataobject = "d_rep_clientes_x_asesor"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_clientes
integer x = 114
integer y = 620
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_clientes
integer x = 1435
integer y = 792
end type

type dw_1 from datawindow within w_rep_clientes
integer width = 2912
integer height = 164
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_tipo_reporte_clientes"
boolean border = false
boolean livescroll = true
end type

event itemchanged;cbx_1.checked = false
end event

type cbx_1 from checkbox within w_rep_clientes
integer x = 1385
integer y = 36
integer width = 585
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
string text = "Todos los Asesores"
boolean checked = true
borderstyle borderstyle = StyleLowered!
boolean righttoleft = true
end type

event clicked;dw_1.object.vendedor[1] = ''
end event


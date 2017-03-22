HA$PBExportHeader$w_rep_compras_proveedor.srw
$PBExportComments$Si.
forward
global type w_rep_compras_proveedor from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_compras_proveedor
end type
end forward

global type w_rep_compras_proveedor from w_sheet_1_dw_rep
integer x = 18
integer y = 240
integer width = 3195
integer height = 1684
string title = "Compras Proveedor"
long backcolor = 67108864
dw_1 dw_1
end type
global w_rep_compras_proveedor w_rep_compras_proveedor

on w_rep_compras_proveedor.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_compras_proveedor.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_1.InsertRow(0)

this.ib_notautoretrieve = true

call super::open
end event

event ue_retrieve;date ld_fec_ini,ld_fec_fin

dw_1.AcceptText()
ld_fec_ini= dw_1.GetItemDate(1,'fecini')
ld_fec_fin= dw_1.GetItemDate(1,'fecfin')
if ld_fec_fin >= ld_fec_ini then
	SetPointer(HourGlass!)
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
     dw_datos.retrieve(integer(str_appgeninfo.empresa),ld_fec_ini,ld_fec_fin)
	SetPointer(Arrow!)
else
	messagebox("Error","Rango de fechas incorrecto",stopsign!)
	return
end if
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event activate;return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_compras_proveedor
integer x = 0
integer y = 156
integer width = 3150
integer height = 1424
integer taborder = 30
string dataobject = "d_rep_diario_compras_proveedor"
boolean border = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_compras_proveedor
integer taborder = 40
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_compras_proveedor
end type

type dw_1 from datawindow within w_rep_compras_proveedor
integer width = 3150
integer height = 152
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ext_fecha_de_compras"
boolean resizable = true
boolean livescroll = true
end type


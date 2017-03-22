HA$PBExportHeader$w_rep_mov_inv.srw
$PBExportComments$Si.Moviemientos de inventario
forward
global type w_rep_mov_inv from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_mov_inv
end type
end forward

global type w_rep_mov_inv from w_sheet_1_dw_rep
integer width = 2811
integer height = 1660
string title = "Movimientos de Inventario (Ajustes)"
long backcolor = 67108864
dw_1 dw_1
end type
global w_rep_mov_inv w_rep_mov_inv

on w_rep_mov_inv.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_mov_inv.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_datos.SetTransObject(sqlca)
dw_1.insertrow(0)
ib_notautoretrieve = true
call super::open




end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_report.x=dw_datos.x
dw_report.y=dw_datos.y
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
dw_report.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;Date ld_fecini,ld_fecfin
String ls_tipmov,ls_tipomov,ls_mov,ls_seccion,ls_ioe,ls_filtro,ls_sec,ls_tmcodigo[],ls_texto
integer i =1
long ll_nreg

SetPointer(Hourglass!)

dw_1.accepttext()

ll_nreg = dw_datos.rowcount()
ld_fecini  = dw_1.GetItemDate(1,"fecha_ini")
ld_fecfin  = dw_1.GetItemDate(1,"fecha_fin")
ls_texto = 'Desde: '+String(ld_fecini,'dd/mm/yyyy')+' Hasta: '+String(ld_fecfin,'dd/mm/yyyy')
ls_tipomov  = dw_1.GetItemString(1,"tipmov")
choose case ls_tipomov
	case 'A'
		dw_datos.dataobject = "d_rep_movim_inv_ajustes"
	case 'D'
		dw_datos.dataobject = "d_rep_movims_inventario"
		dw_datos.Sharedata(dw_report)
	case 'R'
		dw_datos.dataobject = "d_rep_tipos_movim_inv"	
end choose

dw_datos.settransobject(sqlca)
if ls_tipomov <> 'D' Then
	dw_datos.modify("datawindow.print.preview = yes st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"' st_seccion.text ='"+gs_bo_nombre+"'st_fecha.text = '"+ls_texto+"'")
else
	dw_report.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"' st_seccion.text ='"+gs_bo_nombre+"'st_fecha.text = '"+ls_texto+"'")
end if
dw_datos.Retrieve(str_appgeninfo.sucursal,str_appgeninfo.seccion,ld_fecini,ld_fecfin)	
SetPointer(Arrow!)

end event

event ue_print;int li_rc

if dw_1.getitemString(1,"tipmov") ='D' then
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

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_mov_inv
integer x = 0
integer y = 240
integer width = 2770
integer height = 1324
integer taborder = 20
string dataobject = "d_rep_tipos_movim_inv"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_mov_inv
integer x = 73
integer y = 984
integer width = 635
integer height = 468
integer taborder = 30
string dataobject = "d_prn_movims_inventario"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_mov_inv
end type

type dw_1 from datawindow within w_rep_mov_inv
integer width = 2770
integer height = 240
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_mov_inv"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


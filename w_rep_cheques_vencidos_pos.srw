HA$PBExportHeader$w_rep_cheques_vencidos_pos.srw
$PBExportComments$Si Reporte de cheques vencidos del POS
forward
global type w_rep_cheques_vencidos_pos from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_cheques_vencidos_pos
end type
type rb_empre from radiobutton within w_rep_cheques_vencidos_pos
end type
type rb_sucur from radiobutton within w_rep_cheques_vencidos_pos
end type
end forward

global type w_rep_cheques_vencidos_pos from w_sheet_1_dw_rep
integer width = 2907
integer height = 1936
string title = "Cheques Vencidos (POS)"
long backcolor = 67108864
dw_sel_rep dw_sel_rep
rb_empre rb_empre
rb_sucur rb_sucur
end type
global w_rep_cheques_vencidos_pos w_rep_cheques_vencidos_pos

on w_rep_cheques_vencidos_pos.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
this.rb_empre=create rb_empre
this.rb_sucur=create rb_sucur
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
this.Control[iCurrent+2]=this.rb_empre
this.Control[iCurrent+3]=this.rb_sucur
end on

on w_rep_cheques_vencidos_pos.destroy
call super::destroy
destroy(this.dw_sel_rep)
destroy(this.rb_empre)
destroy(this.rb_sucur)
end on

event open;dw_sel_rep.InsertRow(0)
dw_sel_rep.setfocus()
dw_datos.SetTransObject(sqlca)

this.ib_notautoretrieve = true
call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
dw_report.resize(dw_sel_rep.width,li_height - dw_report.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event ue_retrieve;date fec_ini, fec_fin

dw_sel_rep.accepttext()
SetPointer(HourGlass!)
fec_ini = dw_sel_rep.GetItemDate(1,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(1,'fec_fin')
dw_datos.reset()	
if rb_empre.checked then 
	dw_datos.dataobject = "d_rep_cheques_vencidos_pos_emp"	
	dw_datos.settransobject(sqlca)	
	f_recupera_empresa(dw_datos,"fa_recpag_su_codigo_1")
	f_recupera_empresa(dw_datos,"fa_recpag_if_codigo")
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_fecha.text = 'Desde: "+string(fec_ini,'dd/mm/yyyy')+"      Hasta: "+string(fec_fin,'dd/mm/yyyy')+"'")	
	dw_datos.Retrieve(fec_ini, fec_fin)	
else
	dw_datos.dataobject = "d_rep_cheques_vencidos_pos"
	dw_datos.settransobject(sqlca)	
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' st_fecha.text = 'Desde: "+string(fec_ini,'dd/mm/yyyy')+"      Hasta: "+string(fec_fin,'dd/mm/yyyy')+"'")
	dw_datos.Retrieve(integer(str_appgeninfo.sucursal),fec_ini, fec_fin)
end if
dw_datos.modify("datawindow.print.preview = yes")
SetPointer(Arrow!)
w_marco.setmicrohelp("Reporte Listo")
end event

event ue_print;int li_rc

openwithparm(w_dw_print_options,dw_datos)
li_rc = message.DoubleParm	
if li_rc = 1 then
	dw_datos.print()
end if




end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cheques_vencidos_pos
integer x = 0
integer y = 248
integer width = 2875
integer height = 1584
string dataobject = "d_rep_cheques_vencidos_pos_emp"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cheques_vencidos_pos
integer y = 248
integer width = 393
integer height = 156
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_cheques_vencidos_pos
integer width = 251
integer height = 248
end type

type dw_sel_rep from datawindow within w_rep_cheques_vencidos_pos
integer width = 2875
integer height = 248
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sel_rango_fecha"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type rb_empre from radiobutton within w_rep_cheques_vencidos_pos
integer x = 2126
integer y = 40
integer width = 325
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
string text = "** Empresa"
end type

type rb_sucur from radiobutton within w_rep_cheques_vencidos_pos
integer x = 2126
integer y = 136
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
string text = "Sucursal"
boolean checked = true
end type


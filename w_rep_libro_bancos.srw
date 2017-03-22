HA$PBExportHeader$w_rep_libro_bancos.srw
$PBExportComments$Si.
forward
global type w_rep_libro_bancos from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_libro_bancos
end type
type dw_1 from datawindow within w_rep_libro_bancos
end type
type rb_1 from radiobutton within w_rep_libro_bancos
end type
type rb_2 from radiobutton within w_rep_libro_bancos
end type
end forward

global type w_rep_libro_bancos from w_sheet_1_dw_rep
integer x = 18
integer y = 260
integer width = 3355
integer height = 1552
string title = "Libro Bancos"
long backcolor = 81324524
dw_sel_rep dw_sel_rep
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_libro_bancos w_rep_libro_bancos

type variables

end variables

on w_rep_libro_bancos.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
end on

on w_rep_libro_bancos.destroy
call super::destroy
destroy(this.dw_sel_rep)
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event open;string ls_parametro[]




this.ib_notautoretrieve = true
dw_sel_rep.InsertRow(0)
ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[2] = str_appgeninfo.sucursal
f_recupera_datos(dw_sel_rep,'cn_codigo',ls_parametro,2)
//f_recupera_empresa(dw_sel_rep,'if_codigo')
dw_1.SetTransObject(sqlca)

call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y)
this.setRedraw(True)

end event

event closequery;return
end event

event ue_retrieve;date fec_ini, fec_fin,ld_fec_inicio,ld_fec_final
string ls_filtro,ls_cn_codigo,ls_sucursal,ls_tn_ioe,ls_if_codigo
decimal ld_valor_egreso,ld_valor_ingreso,ld_valor_inicial,lc_salini
long ll_fila,ll_tot_filas

SetPointer(HourGlass!)
dw_datos.SetRedraw(false)
dw_sel_rep.AcceptText()
fec_ini   = dw_sel_rep.GetItemDate(1,'fec_ini')
fec_fin   = dw_sel_rep.GetItemDate(1,'fec_fin')
ls_tn_ioe = dw_sel_rep.GetItemString(1,'tn_ioe')
ls_cn_codigo = dw_sel_rep.GetItemString(1,'cn_codigo')

if fec_ini>fec_fin or isnull(fec_ini) then
	messageBox('Error','Rango de fechas incorrecto.')
	SetPointer(Arrow!)
	dw_datos.SetRedraw(true)
	return
end if
dw_1.reset()
dw_1.retrieve(str_appgeninfo.empresa)
ll_tot_filas=dw_1.RowCount()
ld_fec_final=relativedate(fec_ini,-1)



/* Por empresa*/
if rb_1.checked then
	dw_datos.dataobject = "d_reporte_libro_bancos"
	dw_datos.SetTransObject(sqlca)
    dw_datos.Retrieve(str_appgeninfo.empresa,fec_ini,fec_fin)
  	lc_salini = f_salini_bancos(ls_cn_codigo,fec_ini,fec_fin)
end if 

/*Por sucursal*/
if rb_2.checked then
	dw_datos.dataobject="d_reporte_libro_bancos_x_suc"
	dw_datos.SetTransObject(sqlca)
    dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
	lc_salini = f_salini_bancos_x_suc(ls_cn_codigo,fec_ini,fec_fin)
end if

if not isnull(ls_cn_codigo) then
ls_filtro="(cn_codigo = '"+ls_cn_codigo+"')"
else
ls_filtro="(cn_codigo like '%')"
end if
if ls_tn_ioe<>'T' then
ls_filtro=ls_filtro+" and (tn_ioe = '"+ ls_tn_ioe + "')"
end if
//lc_salini = f_salini_bancos_x_suc(ls_cn_codigo,fec_ini,fec_fin)
dw_datos.Setfilter(ls_filtro)
dw_datos.Filter()
dw_datos.Setitem(1,"cc_saldoinicial",lc_salini)
dw_datos.GroupCalc()
dw_datos.SetRedraw(true)
SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_libro_bancos
integer x = 0
integer y = 288
integer width = 3323
integer height = 1168
string dataobject = "d_reporte_libro_bancos"
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::retrieveend;call super::retrieveend;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_libro_bancos
integer x = 1157
integer y = 396
integer width = 430
integer height = 472
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_libro_bancos
end type

type dw_sel_rep from datawindow within w_rep_libro_bancos
integer y = 96
integer width = 3319
integer height = 188
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sel_rep_libro_bancos"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;date fec_ini, fec_fin,ld_fec_inicio,ld_fec_final
string ls_filtro,ls_cn_codigo,ls_sucursal,ls_tn_ioe,ls_if_codigo
decimal ld_valor_egreso,ld_valor_ingreso,ld_valor_inicial,lc_salini
long ll_fila,ll_tot_filas

SetPointer(HourGlass!)
dw_datos.SetRedraw(false)
this.AcceptText()
fec_ini   = this.GetItemDate(row,'fec_ini')
fec_fin   = this.GetItemDate(row,'fec_fin')
ls_tn_ioe = this.GetItemString(row,'tn_ioe')
ls_cn_codigo = this.GetItemString(row,'cn_codigo')

if fec_ini>fec_fin or isnull(fec_ini) then
	messageBox('Error','Rango de fechas incorrecto.')
	SetPointer(Arrow!)
	dw_datos.SetRedraw(true)
	return
end if
dw_1.reset()
dw_1.retrieve(str_appgeninfo.empresa)
ll_tot_filas=dw_1.RowCount()
ld_fec_final=relativedate(fec_ini,-1)


dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)

if not isnull(ls_cn_codigo) then
	ls_filtro="(cn_codigo = '"+ls_cn_codigo+"')"
else
	ls_filtro="(cn_codigo like '%')"
end if
if ls_tn_ioe<>'T' then
	ls_filtro=ls_filtro+" and (tn_ioe = '"+ ls_tn_ioe + "')"
end if

lc_salini = f_salini_bancos(ls_cn_codigo,fec_ini,fec_fin)
dw_datos.Setfilter(ls_filtro)
dw_datos.Filter()
dw_datos.Setitem(1,"cc_saldoinicial",lc_salini)
dw_datos.GroupCalc()
dw_datos.SetRedraw(true)
SetPointer(Arrow!)
end event

type dw_1 from datawindow within w_rep_libro_bancos
boolean visible = false
integer x = 617
integer y = 396
integer width = 494
integer height = 360
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dddw_todas_cuentas_bancarias"
boolean livescroll = true
end type

type rb_1 from radiobutton within w_rep_libro_bancos
integer x = 82
integer y = 48
integer width = 434
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por empresa"
boolean checked = true
end type

type rb_2 from radiobutton within w_rep_libro_bancos
integer x = 590
integer y = 44
integer width = 402
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
string text = "Por sucursal"
end type


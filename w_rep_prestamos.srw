HA$PBExportHeader$w_rep_prestamos.srw
$PBExportComments$Si.Reporte de los pr$$HEX1$$e900$$ENDHEX$$stamos realizados por los empleados
forward
global type w_rep_prestamos from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_prestamos
end type
type cbx_1 from checkbox within w_rep_prestamos
end type
end forward

global type w_rep_prestamos from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 3305
integer height = 1804
string title = "Descuentos"
long backcolor = 67108864
dw_1 dw_1
cbx_1 cbx_1
end type
global w_rep_prestamos w_rep_prestamos

type variables
string   is_pepa 
end variables

on w_rep_prestamos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cbx_1
end on

on w_rep_prestamos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cbx_1)
end on

event open;dw_1.InsertRow(0)
dw_datos.settransobject(sqlca)
f_recupera_empresa(dw_1,'ep_codigo')
f_recupera_empresa(dw_1,'dt_codigo')
f_recupera_empresa(dw_1,'cr_codigo')
f_recupera_empresa(dw_1,'su_codigo')
f_recupera_empresa(dw_1,'ru_codigo')
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

event ue_retrieve;string ls_rucodigo
date ld_fecini,ld_fecfin

dw_datos.setredraw(false)
dw_1.AcceptText()
lparam = dw_1.getrow()
ld_fecini = dw_1.getitemdate(lparam,"fec_ini")
ld_fecfin = dw_1.getitemdate(lparam,"fec_fin")
if cbx_1.checked then
	ls_rucodigo = dw_1.getitemstring(lparam,"ru_codigo")
	if isnull(ls_rucodigo) or trim(ls_rucodigo) = "" then
		messagebox("Verif$$HEX1$$ed00$$ENDHEX$$que","Antes debe ingresar el tipo de rubro")
		return
	end if
	dw_datos.dataobject = 'd_rep_prestamos_resumido'
	dw_datos.settransobject(sqlca)
	if dw_datos.retrieve(integer(str_appgeninfo.empresa),ld_fecini,ld_fecfin,ls_rucodigo) < 1 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones")
		return
	end if
else
	dw_datos.dataobject = 'd_rep_prestamos'
	dw_datos.settransobject(sqlca)
	if dw_datos.retrieve(integer(str_appgeninfo.empresa),ld_fecini,ld_fecfin) < 1 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones")
		return
	end if		
end if
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' datawindow.print.preview = true")
dw_datos.setredraw(true)
dw_1.triggerevent("itemchanged")

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_prestamos
integer x = 0
integer y = 252
integer width = 3269
integer height = 1452
integer taborder = 20
string dataobject = "d_rep_prestamos"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_prestamos
integer x = 50
integer y = 532
integer width = 352
integer height = 140
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_prestamos
integer x = 91
integer y = 256
integer width = 206
integer height = 240
end type

type dw_1 from datawindow within w_rep_prestamos
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 3269
integer height = 252
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_rep_prestamos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;string ls_filtro='',ls_ep_codigo,ls_dt_codigo,&
		 ls_su_codigo,ls_pp_estado,ls_ru_codigo


//dw_datos.SetFilter("")
//dw_datos.Filter()

dw_1.AcceptText()
ls_ep_codigo=GetItemString(1,'ep_codigo')
ls_dt_codigo=GetItemString(1,'dt_codigo')
ls_pp_estado=GetItemString(1,'pp_estado')
ls_ru_codigo=GetItemString(1,'ru_codigo')
ls_su_codigo=GetItemString(1,'su_codigo')

choose case this.getcolumnname()
case 'ep_codigo'
	   if isnull(ls_ep_codigo) then
			ls_filtro="(ep_codigo like '%') "
		else
			ls_filtro="(ep_codigo = '"+ ls_ep_codigo +"') "
		end if
		if not isnull(ls_dt_codigo) then
			ls_filtro=ls_filtro+" and ( dt_codigo = '"+ls_dt_codigo+"')"
		end if
		if not isnull(ls_ru_codigo) then
			ls_filtro=ls_filtro+" and ( ru_codigo = '"+ls_ru_codigo+"')"
		end if		
		if not isnull(ls_pp_estado) then
			ls_filtro=ls_filtro+" and ( trim(pp_estado) = '"+ls_pp_estado+"')"
		end if
		if not isnull(ls_su_codigo) then
			ls_filtro=ls_filtro+" and ( su_codigo = '"+ls_su_codigo+"')"
		end if		

case 'ru_codigo'
	   if isnull(ls_ru_codigo) then
			ls_filtro="(ru_codigo like '%') "
		else
			ls_filtro="(ru_codigo = '"+ ls_ru_codigo +"') "
		end if
		if not isnull(ls_dt_codigo) then
			ls_filtro=ls_filtro+" and ( dt_codigo = '"+ls_dt_codigo+"')"
		end if
		if not isnull(ls_ep_codigo) then
			ls_filtro=ls_filtro+" and ( ep_codigo = '"+ls_ep_codigo+"')"
		end if		
		if not isnull(ls_pp_estado) then
			ls_filtro=ls_filtro+" and ( trim(pp_estado) = '"+ls_pp_estado+"')"
		end if
		if not isnull(ls_su_codigo) then
			ls_filtro=ls_filtro+" and ( su_codigo = '"+ls_su_codigo+"')"
		end if		

case 'pp_estado'
		if isnull(ls_pp_estado) then
			ls_filtro="(trim(pp_estado) like '%')"
		else
			ls_filtro="(trim(pp_estado) = '"+ ls_pp_estado +"')"
		end if
		if not isnull(ls_ep_codigo) then
			ls_filtro=ls_filtro+" and ( ep_codigo = '"+ls_ep_codigo+"')"
		end if
		if not isnull(ls_dt_codigo) then
			ls_filtro=ls_filtro+" and ( dt_codigo = '"+ls_dt_codigo+"')"
		end if
		if not isnull(ls_ru_codigo) then
			ls_filtro=ls_filtro+" and ( ru_codigo = '"+ls_ru_codigo+"')"
		end if		
		if not isnull(ls_su_codigo) then
			ls_filtro=ls_filtro+" and ( su_codigo = '"+ls_su_codigo+"')"
		end if

case 'dt_codigo'
		if isnull(ls_dt_codigo) then
			ls_filtro="(dt_codigo like '%')"
		else
			ls_filtro="(dt_codigo = '"+ ls_dt_codigo +"')"
		end if		
		if not isnull(ls_ep_codigo) then
			ls_filtro=ls_filtro+" and ( ep_codigo = '"+ls_ep_codigo+"')"
		end if
		if not isnull(ls_pp_estado) then
			ls_filtro=ls_filtro+" and ( trim(pp_estado) = '"+ls_pp_estado+"')"
		end if
		if not isnull(ls_ru_codigo) then
			ls_filtro=ls_filtro+" and ( ru_codigo = '"+ls_ru_codigo+"')"
		end if		
		if not isnull(ls_su_codigo) then
			ls_filtro=ls_filtro+" and ( su_codigo = '"+ls_su_codigo+"')"
		end if
case 'su_codigo'
		if isnull(ls_su_codigo) then
			ls_filtro="(su_codigo like '%')"
		else
			ls_filtro="(su_codigo = '"+ ls_su_codigo +"')"
		end if
		if not isnull(ls_ep_codigo) then
			ls_filtro=ls_filtro+" and ( ep_codigo = '"+ls_ep_codigo+"')"
		end if
		if not isnull(ls_dt_codigo) then
			ls_filtro=ls_filtro+" and ( dt_codigo = '"+ls_dt_codigo+"')"
		end if
		if not isnull(ls_ru_codigo) then
			ls_filtro=ls_filtro+" and ( ru_codigo = '"+ls_ru_codigo+"')"
		end if		
		if not isnull(ls_pp_estado) then
			ls_filtro=ls_filtro+" and ( trim(pp_estado) = '"+ls_pp_estado+"')"
		end if
END CHOOSE

dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()

end event

event losefocus;//date    ld_fecha
//string  ls_fecha
//
//ld_fecha = dw_1.GetItemDate(1,"fecha_corte")
//ls_fecha = string(ld_fecha,"dd/mm/yyyy")
//declare rp_kardex_sucur procedure for
//  rp_kardex_sucur(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:is_pepa,:ls_fecha)
//  using sqlca;
//execute rp_kardex_sucur;
//if sqlca.sqldbcode <> 0 then
//	MessageBox("ERROR","El proceso no se ejecut$$HEX2$$f3002000$$ENDHEX$$o se ejecut$$HEX2$$f3002000$$ENDHEX$$mal.");
//	Return(1);
//end if
//dw_report.retrieve()
//dw_report.SetFocus()
end event

type cbx_1 from checkbox within w_rep_prestamos
integer x = 2725
integer y = 84
integer width = 462
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
string text = "Res$$HEX1$$fa00$$ENDHEX$$men x Tipo"
end type


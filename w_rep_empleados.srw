HA$PBExportHeader$w_rep_empleados.srw
$PBExportComments$Si.
forward
global type w_rep_empleados from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_empleados
end type
end forward

global type w_rep_empleados from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2862
integer height = 1424
string title = "Empleados"
long backcolor = 81324524
dw_1 dw_1
end type
global w_rep_empleados w_rep_empleados

type variables
string   is_pepa 
end variables

on w_rep_empleados.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_empleados.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;datawindowChild ldw_aux
long ll_fila
dw_1.InsertRow(0)
this.ib_notautoretrieve = true

f_recupera_empresa(dw_1,'ep_codigo')
dw_datos.GetChild('ep_codigo',ldw_aux)

f_recupera_empresa(dw_1,'dt_codigo')
dw_datos.GetChild('dt_codigo',ldw_aux)

f_recupera_empresa(dw_1,'cr_codigo')
dw_datos.GetChild('cr_codigo',ldw_aux)

f_recupera_empresa(dw_1,'su_codigo')
dw_datos.GetChild('su_codigo',ldw_aux)

call super::open

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;string ls_filtro,ls_ep_codigo,ls_dt_codigo,ls_su_codigo,ls_cr_codigo
string rr_codigo
boolean fecha
date fec_ini,fec_fin
integer ll_row
character lch_tipo

dw_1.AcceptText()
SetPointer(HourGlass!)
dw_datos.SetRedraw(false)
ll_row = dw_1.getrow()
lch_tipo = dw_1.GetItemString(ll_row,'tipo')
ls_ep_codigo=dw_1.GetItemString(ll_row,'ep_codigo')
ls_dt_codigo=dw_1.GetItemString(ll_row,'dt_codigo')
ls_cr_codigo=dw_1.GetItemString(ll_row,'cr_codigo')
ls_su_codigo=dw_1.GetItemString(ll_row,'su_codigo')
fec_ini=dw_1.GetItemDate(ll_row,'fec_ini')
fec_fin=dw_1.GetItemDate(ll_row,'fec_fin')

if lch_tipo ='H'then //hoja de vida
	dw_datos.DataObject='d_rep_hoja_vida_empleado'
	dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
								"datawindow.print.preview=yes")
	dw_datos.SetTransObject(sqlca)																		
	dw_datos.retrieve(str_appgeninfo.empresa)														
end if
if lch_tipo ='G'or lch_tipo ='L' then //general y general sin sueldo
	dw_datos.DataObject='d_rep_general_empleados'
	dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
						"datawindow.print.preview=yes")
	dw_datos.SetTransObject(sqlca)								
	dw_datos.retrieve(str_appgeninfo.empresa)	
	if lch_tipo ='L' then
		dw_datos.object.st_ep_sueldo.visible=false
		dw_datos.object.ep_sueldo.visible=false
	end if
end if
if lch_tipo ='F' then // faltas y atrasos
	dw_datos.DataObject='d_rep_faltaoatraso'
	dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
								"datawindow.print.preview=yes")
	dw_datos.SetTransObject(sqlca)																		
	dw_datos.retrieve(str_appgeninfo.empresa,fec_ini,fec_fin)														
end if
if lch_tipo ='V' then // faltas y atrasos
	dw_datos.DataObject='d_rep_vacaciones_todos'
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' datawindow.print.preview.zoom=75~t" + &
								"datawindow.print.preview=yes")
	dw_datos.SetTransObject(sqlca)																		
	dw_datos.retrieve(str_appgeninfo.empresa,fec_ini,fec_fin)														
end if		


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
if not isnull(ls_cr_codigo) then
	ls_filtro=ls_filtro+" and ( cr_codigo = '"+ls_cr_codigo+"')"
end if

dw_datos.ScrollTorow(1)
dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()
SetPointer(Arrow!)
dw_datos.SetRedraw(True)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_empleados
integer x = 0
integer y = 272
integer width = 2821
integer height = 1048
integer taborder = 20
string dataobject = "d_rep_hoja_vida_empleado"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_empleados
integer x = 1573
integer y = 388
integer taborder = 30
end type

type dw_1 from datawindow within w_rep_empleados
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 2825
integer height = 276
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_rep_empleados"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

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


HA$PBExportHeader$w_rep_transferencia.srw
$PBExportComments$Si.Reporte de recepcion y envio, transferencias.
forward
global type w_rep_transferencia from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_transferencia
end type
end forward

global type w_rep_transferencia from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2917
integer height = 1436
string title = "Transferencias"
long backcolor = 1090519039
dw_1 dw_1
end type
global w_rep_transferencia w_rep_transferencia

type variables
string   is_pepa 
end variables

on w_rep_transferencia.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_transferencia.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'su_codigo')
f_recupera_empresa(dw_1,'bo_codigo')
this.ib_notautoretrieve = true
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

event ue_retrieve;string ls_tipo,ls_clase,ls_sucur,ls_bode
date ld_fec_ini,ld_fec_fin
integer li_fila
character lch_opcion

dw_datos.SetRedraw(false)
SetPointer(Hourglass!)
dw_1.AcceptText()
li_fila = dw_1.getrow()
ls_tipo = dw_1.GetItemString(li_fila,'tipo')
ld_fec_ini = dw_1.GetItemDate(li_fila,'fec_ini')
ld_fec_fin = dw_1.GetItemDate(li_fila,'fec_fin')
ls_clase =  dw_1.GetItemString(li_fila,'clase')
ls_sucur =  dw_1.GetItemString(li_fila,'su_codigo')
ls_bode =  dw_1.GetItemString(li_fila,'bo_codigo')
lch_opcion =  dw_1.GetItemString(li_fila,'todos')

choose case ls_tipo
	case 'P'
		dw_datos.DataObject='d_rep_recep_envio_transferenciasxprod'
	case 'N'
		dw_datos.DataObject='d_rep_recep_envio_transferencias'
	case 'R'
		dw_datos.DataObject='d_rep_recep_envio_transf_resumen'
	case 'C'
		dw_datos.DataObject = 'd_rep_resumen_transferencias'
end choose

dw_datos.modify("datawindow.print.preview.zoom=100~t" + &
						"datawindow.print.preview=yes")
dw_datos.SetTransObject(sqlca)						
if lch_opcion = 'S' Then
	if isnull(ls_sucur) Then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar la sucursal")
		return
	End if
	if isnull(ls_bode) Then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar la bodega")
		return
	End if
	dw_datos.retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),integer(str_appgeninfo.seccion),ls_sucur,ls_bode,ld_fec_ini,ld_fec_fin,ls_clase)
else
	if ls_tipo = 'C' then
	dw_datos.retrieve(str_appgeninfo.empresa,ld_fec_ini,ld_fec_fin)	
     else
	dw_datos.retrieve(integer(str_appgeninfo.empresa),integer(str_appgeninfo.sucursal),integer(str_appgeninfo.seccion),'%','%',ld_fec_ini,ld_fec_fin,ls_clase)	
     end if
End if



dw_datos.SetRedraw(true)
SetPointer(Arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_transferencia
integer x = 0
integer y = 252
integer width = 2885
integer height = 1096
integer taborder = 20
string dataobject = "d_rep_recep_envio_transferencias"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_transferencia
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_transferencia
end type

type dw_1 from datawindow within w_rep_transferencia
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 2885
integer height = 256
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_envio_recep_transferencia"
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

event buttonclicked;string ls_filtro=' ',ls_codant,ls_it_nombre,ls_cl_codigo,ls_tipo,ls_clase,ls_su_codigo,ls_bo_codigo
date ld_fec_ini,ld_fec_fin
DataWindowChild	ldwc_aux

dw_datos.SetRedraw(false)
SetPointer(Hourglass!)
dw_1.AcceptText()
ls_tipo=GetItemString(row,'tipo')
ls_codant=GetItemString(row,'codigo_producto')
ls_it_nombre=GetItemString(row,'producto')
ls_cl_codigo=GetItemString(row,'codigo_clase')
ld_fec_ini=GetItemDate(row,'fec_ini')
ld_fec_fin=GetItemDate(row,'fec_fin')
ls_clase=GetItemString(row,'clase')
ls_su_codigo=GetItemString(row,'su_codigo')
ls_bo_codigo=GetItemString(row,'bo_codigo')
if isnull(ls_cl_codigo) or ls_cl_codigo='' then
	ls_filtro="(cl_codigo like '%')"+ls_filtro
else
	ls_filtro="(cl_codigo like'"+ls_cl_codigo+"')"+ls_filtro
end if
if not isnull(ls_codant) and ls_codant<>'' then
	ls_filtro=ls_filtro+" and (it_codant like'"+ls_codant+"')"
end if
if not isnull(ls_it_nombre) and ls_it_nombre<>'' then
	ls_filtro=ls_filtro+" and (it_nombre like'"+ls_it_nombre+"')"
end if
if not isnull(ls_su_codigo) then
	ls_filtro=ls_filtro+" and (csu_codigo ='"+ls_su_codigo+"')"
end if
if not isnull(ls_bo_codigo) then
	ls_filtro=ls_filtro+" and (cbo_codigo ='"+ls_bo_codigo+"')"
end if

choose case this.getcolumnname()
 case 'tipo'
	choose case ls_tipo
		case 'P'
			dw_datos.DataObject='d_rep_recep_envio_transferenciasxprod'
		case 'N'
			dw_datos.DataObject='d_rep_recep_envio_transferencias'
		case 'R'
			dw_datos.DataObject='d_rep_recep_envio_transf_resumen'
	end choose
	dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
						"datawindow.print.preview=yes")
	dw_datos.SetTransObject(sqlca)						
	dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ld_fec_ini,ld_fec_fin,ls_clase)
	case "su_codigo"
		GetChild("bo_codigo",ldwc_aux)
		ldwc_aux.SetTransObject(sqlca)
		if not isnull(ls_su_codigo) then
			ldwc_aux.SetFilter("su_codigo = '"+ls_su_codigo+"'")
		else
			ldwc_aux.SetFilter("su_codigo like '%'")
		end if			
			ldwc_aux.Filter()
case	'fec_ini','fec_fin','clase'
	dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ld_fec_ini,ld_fec_fin,ls_clase)
END CHOOSE

dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()
dw_datos.SetRedraw(true)
SetPointer(Arrow!)
end event


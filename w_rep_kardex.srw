HA$PBExportHeader$w_rep_kardex.srw
$PBExportComments$Si.
forward
global type w_rep_kardex from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_kardex
end type
end forward

global type w_rep_kardex from w_sheet_1_dw_rep
integer width = 2926
integer height = 1512
string title = "Reporte de Kardex"
long backcolor = 81324524
dw_1 dw_1
end type
global w_rep_kardex w_rep_kardex

type variables
string   is_pepa 
end variables

on w_rep_kardex.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_kardex.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;this.ib_notautoretrieve = true
dw_1.InsertRow(0)
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

event ue_retrieve;String  ls,ls_nombre,ls_codant, ls_valorado,ls_sucursal,ls_seccion
integer li_tipo
date    ld_fecha

setpointer(hourglass!)
dw_1.AcceptText()
ls_valorado = dw_1.GetItemString(1,'valorado')
li_tipo        = dw_1.getitemnumber(1,"tipo")
ld_fecha     = dw_1.GetItemDate(1,"fecha_corte")
ls              = dw_1.GetitemString(1,'codigo')

 // con este voy a buscar
 //primero por codigo anterior
select it_codigo,it_nombre
into :is_pepa,:ls_nombre
from in_item
where em_codigo = : str_appgeninfo.empresa
and it_codant = :ls;
If sqlca.sqlcode <> 0 then
	MessageBox("ERROR","C$$HEX1$$f300$$ENDHEX$$digo no existe, por favor revise lista")
	return
End if
dw_1.setitem(1,"nombre",ls_nombre)
If li_tipo = 1 then
	dw_datos.DataObject = 'kardex_por_sucursal'
	dw_datos.SetTransObject(sqlca)
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"'")
	dw_datos.retrieve(str_appgeninfo.sucursal,is_pepa,ld_fecha,ls_valorado)
else
	dw_datos.DataObject = 'kardex_por_seccion'
	dw_datos.SetTransObject(sqlca)
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"'  st_sucursal.text ='"+gs_su_nombre+"'  st_seccion.text = '"+gs_bo_nombre+"'")
	dw_datos.retrieve(str_appgeninfo.sucursal,is_pepa,str_appgeninfo.seccion,ld_fecha,ls_valorado)			
end if
dw_datos.Modify("DataWindow.Print.Preview=Yes")
setpointer(arrow!)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_kardex
integer x = 0
integer y = 204
integer width = 2894
integer height = 1208
integer taborder = 20
string dataobject = "kardex_por_sucursal"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_kardex
integer x = 334
integer y = 344
integer width = 1568
integer height = 516
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_kardex
end type

type dw_1 from datawindow within w_rep_kardex
integer width = 2894
integer height = 204
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_item_kardex_bodega"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//string  ls,ls_nombre,ls_codant,ls_fecha, ls_valorado
//integer li_tipo
//
//dw_1.AcceptText()
//choose case this.getcolumnname()
//case 'codigo'
//	ls_valorado = this.GetItemString(this.getrow(),'valorado')
//	li_tipo = this.getitemnumber(this.getrow(),"tipo")
//	ls_fecha = string(this.GetItemDate(this.getrow(),"fecha_corte"),"dd/mm/yyyy")
//	ls = this.gettext()
//	 // con este voy a buscar
//	 //primero por codigo anterior
//	 select it_codigo, it_nombre
//	 into :is_pepa, :ls_nombre
//	 from in_item
//	 where em_codigo = : str_appgeninfo.empresa
//	 and it_codant = :ls;
//      if sqlca.sqlcode <> 0 then
//		MessageBox("ERROR","C$$HEX1$$f300$$ENDHEX$$digo no existe, por favor revise lista")
//		return(1)
//	else
//		this.SetItem(1,"nombre",ls_nombre)
//		if li_tipo = 1 then
//			dw_datos.DataObject = 'd_rep_kardex'
//   	  	     f_kardex_sucur(str_appgeninfo.empresa,str_appgeninfo.sucursal,is_pepa,ls_fecha,w_marco)
//			dw_datos.SetTransObject(sqlca)
//			dw_datos.retrieve(ls_valorado)
//		else
//			dw_datos.DataObject = 'd_rep_kardex_bodega'
//   		     f_kardex_bode(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,is_pepa,ls_fecha,w_marco)
//			dw_datos.SetTransObject(sqlca)
//			dw_datos.retrieve()			
//		end if
//	end if
//case 'tipo'
//	ls_valorado = this.GetItemString(this.getrow(),'valorado')	
//	li_tipo = integer(this.gettext())
//	ls_fecha = string(this.GetItemDate(this.getrow(),"fecha_corte"),"dd/mm/yyyy")
//	if li_tipo = 1 then
//		dw_datos.DataObject = 'd_rep_kardex'
//		f_kardex_sucur(str_appgeninfo.empresa,str_appgeninfo.sucursal,is_pepa,ls_fecha,w_marco)
//		dw_datos.SetTransObject(sqlca)
//		dw_datos.retrieve(ls_valorado)
//	else
//		dw_datos.DataObject = 'd_rep_kardex_bodega'
//		f_kardex_bode(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,is_pepa,ls_fecha,w_marco)
//		dw_datos.SetTransObject(sqlca)
//		dw_datos.retrieve()			
//	end if
//case 'fecha_corte'
//	ls_valorado = this.GetItemString(this.getrow(),'valorado')	
//	li_tipo = this.getitemnumber(this.getrow(),"tipo")
//	ls_fecha = string(this.GetItemDate(this.getrow(),"fecha_corte"),"dd/mm/yyyy")
//	if li_tipo = 1 then
//		dw_datos.DataObject = 'd_rep_kardex'
//		f_kardex_sucur(str_appgeninfo.empresa,str_appgeninfo.sucursal,is_pepa,ls_fecha,w_marco)
//		dw_datos.SetTransObject(sqlca)
//		dw_datos.retrieve(ls_valorado)
//	else
//		dw_datos.DataObject = 'd_rep_kardex_bodega'
//		f_kardex_bode(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,is_pepa,ls_fecha,w_marco)
//		dw_datos.SetTransObject(sqlca)
//		dw_datos.retrieve()			
//	end if
//case 'valorado'
//	ls_valorado = this.GetText()
//	li_tipo = this.getitemnumber(this.getrow(),"tipo")
//	ls_fecha = string(this.GetItemDate(this.getrow(),"fecha_corte"),"dd/mm/yyyy")
//	if li_tipo = 1 then
//		dw_datos.DataObject = 'd_rep_kardex'
//		f_kardex_sucur(str_appgeninfo.empresa,str_appgeninfo.sucursal,is_pepa,ls_fecha,w_marco)
//		dw_datos.SetTransObject(sqlca)
//		dw_datos.retrieve(ls_valorado)
//	else
//		dw_datos.DataObject = 'd_rep_kardex_bodega'
//		f_kardex_bode(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,is_pepa,ls_fecha,w_marco)
//		dw_datos.SetTransObject(sqlca)
//		dw_datos.retrieve()			
//	end if	
//END CHOOSE



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


HA$PBExportHeader$w_rep_compras.srw
$PBExportComments$Si.Reporte de las compras
forward
global type w_rep_compras from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_compras
end type
end forward

global type w_rep_compras from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2903
integer height = 1480
string title = "Compras"
long backcolor = 1090519039
dw_1 dw_1
end type
global w_rep_compras w_rep_compras

type variables
string   is_pepa 
end variables

on w_rep_compras.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_compras.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'su_codigo')
f_recupera_empresa(dw_1,'pv_codigo')
f_recupera_empresa(dw_1,'fp_codigo')

dw_1.object.it_codigo.visible=0
dw_1.object.cl_codigo.visible=0
dw_1.object.it_nombre.visible=0
dw_1.object.st_1.visible=0
dw_1.object.st_2.visible=0
dw_1.object.st_3.visible=0
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

event ue_retrieve;date ld_fec_ini,ld_fec_fin
string ls_filtro,pv_codigo,su_codigo,fp_codigo,cl_codigo,it_nombre,it_codant
string ls_tipo,ls_iva, ls_cxp
integer li_row

SetPointer(HourGlass!)
SetRedraw(false)
dw_1.AcceptText()
li_row = dw_1.getrow()
ls_tipo=dw_1.GetItemString(li_row,'tipo')		
ls_iva=dw_1.GetItemString(li_row,'iva')
ls_cxp = dw_1.GetItemString(li_row,'cxp')
pv_codigo=dw_1.GetItemString(li_row,'pv_codigo')
su_codigo=dw_1.GetItemString(li_row,'su_codigo')
fp_codigo=dw_1.GetItemString(li_row,'fp_codigo')
cl_codigo=dw_1.GetItemString(li_row,'cl_codigo')
it_nombre=dw_1.GetItemString(li_row,'it_nombre')
it_codant=dw_1.GetItemString(li_row,'it_codigo')
ld_fec_fin=dw_1.GetItemDate(li_row,'fec_fin')
ld_fec_ini=dw_1.GetItemDate(li_row,'fec_ini')

if ls_tipo='CP' then
	dw_1.object.it_codigo.visible=1
	dw_1.object.cl_codigo.visible=1
	dw_1.object.it_nombre.visible=1
	dw_1.object.st_1.visible=1
	dw_1.object.st_2.visible=1
	dw_1.object.st_3.visible=1	
else
	dw_1.object.it_codigo.visible=0
	dw_1.object.cl_codigo.visible=0
	dw_1.object.it_nombre.visible=0	
	dw_1.object.st_1.visible=0
	dw_1.object.st_2.visible=0
	dw_1.object.st_3.visible=0	
	Setnull(it_codant)
	Setnull(it_nombre)
	Setnull(cl_codigo)
end if

if isnull(pv_codigo) then
	ls_filtro="(pv_codigo like '%') "
else
	ls_filtro="(pv_codigo ='"+pv_codigo+"') "
end if
if ls_iva='S' then
	ls_filtro=ls_filtro+" and (iva<>0) "
elseif ls_iva='N' then
	ls_filtro=ls_filtro+" and (iva=0) "
end if
if ls_cxp ='S' then
	ls_filtro=ls_filtro+" and (co_encxp='S') "
elseif ls_cxp='N' then
   ls_filtro=ls_filtro+" and ((co_encxp='N') or (isnull(co_encxp))) "
end if
if not isnull(su_codigo) then
	ls_filtro=ls_filtro+"and (su_codigo='"+su_codigo+"') "
end if
if not isnull(fp_codigo) then
	ls_filtro=ls_filtro+"and (fp_codigo='"+fp_codigo+"') "
end if
if not isnull(it_codant) and it_codant<>'' then
	ls_filtro=ls_filtro+"and (it_codant like '"+it_codant+"') "
end if
if not isnull(cl_codigo) and cl_codigo<>'' then
	ls_filtro=ls_filtro+"and (cl_codigo like '"+cl_codigo+"') "
end if
if not isnull(it_nombre) and it_nombre<>'' then
	ls_filtro=ls_filtro+"and (it_nombre like '"+it_nombre+"') "
end if		

choose case dw_1.getcolumnname()
case 'fec_ini','fec_fin','tipo'
		if not isnull(pv_codigo) then
			ls_filtro="(pv_codigo ='"+pv_codigo+"')"
	   else
			ls_filtro="(pv_codigo like '%')"
		end if
		if not isnull(su_codigo) then
			ls_filtro=ls_filtro+" and (su_codigo='"+su_codigo+"')"
		end if
		if not isnull(fp_codigo) then
			ls_filtro=ls_filtro+" and (fp_codigo='"+fp_codigo+"')"
		end if
		choose case ls_tipo
			case	'DC' //detalle de compras
					dw_datos.DataObject='d_rep_compras'
			case	'RC'  //resumen de compras
					dw_datos.DataObject='d_rep_resumen_compras'
			case	'CP'   //compras por producto
					dw_datos.DataObject='d_rep_compras_producto'
					if not isnull(it_codant) then
						ls_filtro=ls_filtro+" and (it_codant like '"+it_codant+"')"
					end if
					if not isnull(cl_codigo) then
						ls_filtro=ls_filtro+" and (cl_codigo like '"+cl_codigo+"')"
					end if
					if not isnull(it_nombre) then
						ls_filtro=ls_filtro+" and (it_nombre like '"+it_nombre+"')"
					end if							
		end choose		
					dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
					dw_datos.SetTransObject(sqlca)						
					if isnull(ld_fec_ini) or ld_fec_ini>ld_fec_fin then
						messageBox('Error','Rango de fechas incorrecto.')
						SetRedraw(True)
						SetPointer(Arrow!)
						return
					else 
						dw_datos.retrieve(str_appgeninfo.empresa,ld_fec_ini,ld_fec_fin)		
					end if
END CHOOSE
dw_datos.ScrollToRow(1)
dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()
SetRedraw(True)
SetPointer(Arrow!)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_compras
integer x = 0
integer y = 344
integer width = 2875
integer height = 1116
integer taborder = 20
string dataobject = "d_rep_compras"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_compras
integer taborder = 30
end type

type dw_1 from datawindow within w_rep_compras
integer x = 5
integer width = 2862
integer height = 344
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_compras"
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


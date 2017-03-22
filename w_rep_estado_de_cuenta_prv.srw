HA$PBExportHeader$w_rep_estado_de_cuenta_prv.srw
$PBExportComments$Si.Estado de cuenta de un proveedor
forward
global type w_rep_estado_de_cuenta_prv from w_sheet_1_dw_rep
end type
type dw_sel_rep from datawindow within w_rep_estado_de_cuenta_prv
end type
type pb_1 from picturebutton within w_rep_estado_de_cuenta_prv
end type
end forward

global type w_rep_estado_de_cuenta_prv from w_sheet_1_dw_rep
integer width = 3227
integer height = 1596
string title = "Estado de Cuenta Proveedor"
long backcolor = 1090519039
dw_sel_rep dw_sel_rep
pb_1 pb_1
end type
global w_rep_estado_de_cuenta_prv w_rep_estado_de_cuenta_prv

type variables
decimal ic_saldoinicial
datawindowChild  idwc_refpagos
boolean  ib_ver = true

end variables

on w_rep_estado_de_cuenta_prv.create
int iCurrent
call super::create
this.dw_sel_rep=create dw_sel_rep
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sel_rep
this.Control[iCurrent+2]=this.pb_1
end on

on w_rep_estado_de_cuenta_prv.destroy
call super::destroy
destroy(this.dw_sel_rep)
destroy(this.pb_1)
end on

event open;

this.ib_notautoretrieve = true



dw_sel_rep.InsertRow(0)
dw_datos.SetTransObject(sqlca)
f_recupera_empresa(dw_sel_rep,'cliente')
call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_sel_rep.resize(li_width - 2*dw_sel_rep.x, dw_sel_rep.height)
dw_datos.resize(dw_sel_rep.width,li_height - dw_datos.y - dw_sel_rep.y)
this.setRedraw(True)
end event

event closequery;return
end event

event ue_retrieve;String ls_pvcodigo,ls_provee,ls_tipo
date fec_ini,fec_fin,&
        ld_inicioperiodo = date('01/01/90')
long ll_nreg,i,ll_conumero,ll_row,ll_reg
decimal{2} lc_salini
DataStore lds_estcta


SetPointer(Hourglass!)
w_marco.SetMicroHelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n..........por favor espere...!!!")


SetPointer(HourGlass!)



lds_estcta = Create DataStore
lds_estcta.dataobject = 'd_rep_estado_cta_proveedor_salini'
lds_estcta.settransobject(sqlca)



dw_sel_rep.Accepttext()
ll_row = dw_sel_rep.getrow()
ls_tipo = dw_sel_rep.getitemstring(ll_row,"tipo")
ls_pvcodigo = dw_sel_rep.GetItemString(ll_row,"cliente")
fec_ini = dw_sel_rep.GetItemDate(ll_row,'fec_ini')
fec_fin = dw_sel_rep.GetItemDate(ll_row,'fec_fin')
if fec_ini > fec_fin  then
	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','La fecha <desde> no puede ser mayor que la fecha <hasta>')
	return 
end if

/**/
If ls_tipo = 'E'&
Then
     ll_reg =  lds_estcta.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pvcodigo,ld_inicioperiodo,relativedate(fec_ini, -1))	
	if ll_reg = 0 then
	lc_salini = 0
	else
	lc_salini = lds_estcta.object.cc_saldo[1]
	end if	
   
	dw_datos.DataObject = 'd_rep_estado_cta_proveedor' 
	dw_datos.SetTransObject(sqlca)

	select pv_razons
	into   :ls_provee
	from   in_prove
	where  pv_codigo = :ls_pvcodigo;
	dw_datos.modify("st_empresa.text = '"+gs_empresa+ &
						 "' st_sucursal.text ='"+gs_su_nombre+&
						  "'st_proveedor.text = '"+ls_provee+"'")
	ll_nreg = dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pvcodigo,fec_ini,fec_fin,lc_salini)
End if

/**/
If ls_tipo = 'P'&
Then
return  /*Inhabilitar decisi$$HEX1$$f300$$ENDHEX$$n: '28/02/2008'*/
dw_datos.DataObject = 'd_rep_informe_proveedores' 
dw_datos.SetTransObject(sqlca)
ll_nreg = dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
End if


/**/
If ls_tipo = 'R'&
Then
dw_datos.DataObject = 'd_rep_estado_cta_resumen' 
dw_datos.SetTransObject(sqlca)
ll_nreg = dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
End if



dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'datawindow.print.preview = yes")
w_marco.SetMicroHelp("Listo.........!!!")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_estado_de_cuenta_prv
integer x = 0
integer y = 292
integer width = 3195
integer height = 1200
integer taborder = 30
string dataobject = "d_rep_estado_cta_proveedor"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::retrieveend;call super::retrieveend;Long i,ll_conumero
String ls_numfacpro

If rowcount = 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones")
Return
End if



This.SetRedraw(True)
end event

event dw_datos::clicked;call super::clicked;string ls_cofacpro 

if dwo.name = 'cp_movim_co_facpro' then
dw_datos.GetChild('cp_movim_co_facpro',idwc_refpagos)
idwc_refpagos.SetTransObject(sqlca)
idwc_refpagos.retrieve(this.Object.cp_movim_mp_codigo[row],dw_sel_rep.object.cliente[1])
//idwc_refpagos.Selectow(0,false)
end if
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_estado_de_cuenta_prv
integer taborder = 10
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_estado_de_cuenta_prv
end type

type dw_sel_rep from datawindow within w_rep_estado_de_cuenta_prv
integer width = 3195
integer height = 292
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sel_proveedor_estado_cta"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;//long ll_filact
//date fec_ini, fec_fin
//string ls_cliente, ls
//
//ll_filact = this.GetRow()
//SetPointer(HourGlass!)
//CHOOSE CASE this.GetColumnName()
//	CASE 'cliente'
//		ls_cliente = this.GetText()
//		fec_ini = this.GetItemDate(ll_filact,'fec_ini')
//		fec_fin = this.GetItemDate(ll_filact,'fec_fin')
//		ls = this.GetItemString(ll_filact,'tipo')
//		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
//			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
//			return 1
//		end if
//		if ls = 'P' then
//			f_genera_estado_cta_prv_pendiente(ls_cliente,fec_ini,fec_fin)
//		else
//			f_genera_estado_cta_prv(ls_cliente,fec_ini,fec_fin)
//		end if
//		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
//	CASE 'fec_ini'
//		ls_cliente = this.GetItemString(ll_filact,'cliente')
//		fec_ini = date(this.GetText())
//		fec_fin = this.GetItemDate(ll_filact,'fec_fin')
//		ls = this.GetItemString(ll_filact,'tipo')		
//		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
//			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
//			return 1
//		end if
//		if ls = 'P' then
//			f_genera_estado_cta_prv_pendiente(ls_cliente,fec_ini,fec_fin)
//		else
//			f_genera_estado_cta_prv(ls_cliente,fec_ini,fec_fin)
//		end if
//
//		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
//	CASE 'fec_fin'
//		ls_cliente = this.GetItemString(ll_filact,'cliente')		
//		fec_fin = date(this.GetText())
//		fec_ini = this.GetItemDate(ll_filact,'fec_ini')
//		ls = this.GetItemString(ll_filact,'tipo')		
//		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
//			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
//			return 1
//		end if
//		if ls = 'P' then
//			f_genera_estado_cta_prv_pendiente(ls_cliente,fec_ini,fec_fin)
//		else
//			f_genera_estado_cta_prv(ls_cliente,fec_ini,fec_fin)
//		end if
//		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
//
//	CASE 'tipo'
//		ls= this.GetText()
//		ls_cliente = this.GetItemString(ll_filact,'cliente')	
//		fec_ini = this.GetItemDate(ll_filact,'fec_ini')
//		fec_fin = this.GetItemDate(ll_filact,'fec_fin')
//		if isnull(ls_cliente) or isnull(fec_ini) or isnull(fec_fin) then
//			messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Revise par$$HEX1$$e100$$ENDHEX$$metros del reporte')
//			return 1
//		end if
//		if ls = 'P' then
//			f_genera_estado_cta_prv_pendiente(ls_cliente,fec_ini,fec_fin)
//		else
//			f_genera_estado_cta_prv(ls_cliente,fec_ini,fec_fin)
//		end if
//		dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,fec_ini,fec_fin)
//
//END CHOOSE
//
//SetPointer(Arrow!)
end event

type pb_1 from picturebutton within w_rep_estado_de_cuenta_prv
integer x = 2642
integer y = 116
integer width = 110
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "EditDataGrid!"
string disabledname = "EditDataFreeform!"
alignment htextalign = left!
vtextalign vtextalign = top!
boolean map3dcolors = true
string powertiptext = "Ver cruces"
end type

event clicked;if ib_ver then
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'datawindow.print.preview = no")
ib_ver = false
else
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'datawindow.print.preview = yes")	
ib_ver= true
end if


end event


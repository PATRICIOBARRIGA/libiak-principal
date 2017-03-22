HA$PBExportHeader$w_rep_mayor_general.srw
$PBExportComments$Si. Vale
forward
global type w_rep_mayor_general from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_mayor_general
end type
type rb_1 from radiobutton within w_rep_mayor_general
end type
type rb_2 from radiobutton within w_rep_mayor_general
end type
end forward

global type w_rep_mayor_general from w_sheet_1_dw_rep
integer x = 46
integer y = 300
integer width = 3703
integer height = 1920
string title = "Mayor General"
long backcolor = 79741120
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
end type
global w_rep_mayor_general w_rep_mayor_general

type variables
DataWindowChild   idwc_aux,idwc_aux1
DataStore ids_subctas,ids_subctas_suc
end variables

event open;datawindowchild   dwc_cuentas,dwc_centro

dw_report.SetTransObject(sqlca)
dw_1.InsertRow(0)
dw_1.SetItem(1,"cuenta_inicial",'1') 
dw_1.SetItem(1,"cuenta_final",'1') 

dw_1.GetChild("cuenta_inicial",idwc_aux)
dw_1.GetChild("cuenta_final",idwc_aux1)

dw_datos.GetChild("co_detcom_pl_codigo",dwc_cuentas)
dwc_cuentas.SetTransObject(SQLCA)
dwc_cuentas.retrieve(str_appgeninfo.empresa)

dw_datos.GetChild("centro_costo",dwc_centro)
dwc_centro.SetTransObject(SQLCA)
dwc_centro.retrieve(str_appgeninfo.empresa)


idwc_aux.setTransObject(sqlca)
idwc_aux.Retrieve(str_appgeninfo.empresa)
idwc_aux1.setTransObject(sqlca)
idwc_aux1.Retrieve(str_appgeninfo.empresa)


ids_subctas = Create Datastore
ids_subctas.DataObject = "d_saldo_inicial_subctas"
ids_subctas.SetTransObject(sqlca)

ids_subctas_suc = Create Datastore
ids_subctas_suc.DataObject = "d_saldo_inicial_subctas_x_suc"
ids_subctas_suc.SetTransObject(sqlca)

this.ib_notautoretrieve = true
call super::open
end event

on w_rep_mayor_general.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
end on

on w_rep_mayor_general.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
end on

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;/*Modificado para trabajar con sucursales en l$$HEX1$$ed00$$ENDHEX$$nea*/
string    ls_cuenta_inicial,ls_cuenta_final,ls_cscodigo
date  ld_fecha_corte,ld_fec_ini
decimal lc_saldo_inicial
long ll_breakrow,ll_tot,ll_find
boolean lb_found = FALSE
datawindowchild  dwc_cuentas,dwc_centro


dw_1.AcceptText()
ls_cuenta_inicial = dw_1.GetItemString(1,'cuenta_inicial')
ls_cuenta_final   = dw_1.GetItemString(1,'cuenta_final')
ld_fec_ini           = dw_1.GetItemDate(1,'fec_ini')
ld_fecha_corte    = dw_1.GetItemDate(1,'fecha_corte')

SetPointer(HourGlass!)
w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n....por favor espere....")


/* 1.-Por empresa*/
if rb_1.checked then
	dw_datos.dataobject= "d_rep_mayor_general"
	dw_datos.SetTransObject(SQLCA)
	
	dw_datos.GetChild("co_detcom_pl_codigo",dwc_cuentas)
	dwc_cuentas.SetTransObject(SQLCA)
	dwc_cuentas.retrieve(str_appgeninfo.empresa)
	
	dw_datos.GetChild("centro_costo",dwc_centro)
	dwc_centro.SetTransObject(SQLCA)
	dwc_centro.retrieve(str_appgeninfo.empresa)
		
	
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' ")
	dw_datos.Retrieve(ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini,ld_fecha_corte)
	dw_datos.GroupCalc()
	SetPointer(Arrow!)
		  
      /*Recuperar saldos iniciales*/
 	 w_marco.SetMicrohelp("Calculando saldos iniciales ...por favor espere....")
     ll_tot = ids_subctas.retrieve(str_appgeninfo.empresa,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini)		

		  
	DO WHILE NOT (lb_found)
			ll_breakrow = dw_datos.FindGroupChange(ll_breakrow, 1)
			// If no breaks are found, exit.
			IF ll_breakrow <= 0 THEN EXIT
			ls_cuenta_inicial = dw_datos.getitemstring(ll_breakrow,"co_detcom_pl_codigo_1")
			ls_cscodigo = dw_datos.getitemstring(ll_breakrow,"centro_costo")
			if isnull(ls_cscodigo) then ls_cscodigo = 'nulo'
//				lc_saldo_inicial = f_saldo_inicial_subctas(str_appgeninfo.empresa,ls_cuenta_inicial,ls_cscodigo,ld_fec_ini)
                  ll_find = ids_subctas.find("co_detcom_pl_codigo = '"+ls_cuenta_inicial+"' and co_detcom_cs_codigo = '"+ls_cscodigo+"'",1,ll_tot) 
				if ll_find > 0 then		
				lc_saldo_inicial = ids_subctas.Object.saldo_ini[ll_find]
  			     else
				lc_saldo_inicial = 0
			     end if
				dw_datos.setitem(ll_breakrow,"cc_saldo_inicial",lc_saldo_inicial)
			// Increment starting row to find next break
			ll_breakrow = ll_breakrow + 1
	LOOP
	dw_datos.GroupCalc()
end if

/*2.-Por sucursal*/
if rb_2.checked then
	dw_datos.dataobject= "d_rep_mayor_general_x_suc"
	dw_datos.SetTransObject(SQLCA)

	dw_datos.GetChild("co_detcom_pl_codigo",dwc_cuentas)
	dwc_cuentas.SetTransObject(SQLCA)
	dwc_cuentas.retrieve(str_appgeninfo.empresa)
	
	dw_datos.GetChild("centro_costo",dwc_centro)
	dwc_centro.SetTransObject(SQLCA)
	dwc_centro.retrieve(str_appgeninfo.empresa)
		
	dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' ")
	dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini,ld_fecha_corte)
	dw_datos.GroupCalc()
	SetPointer(Arrow!)
	
	
	  /*Recuperar saldos iniciales*/
	  w_marco.SetMicrohelp("Calculando saldos iniciales....por favor espere....")
	ll_tot = ids_subctas_suc.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini)	
	
	DO WHILE NOT (lb_found)
			ll_breakrow = dw_datos.FindGroupChange(ll_breakrow, 1)
			// If no breaks are found, exit.
			IF ll_breakrow <= 0 THEN EXIT
			ls_cuenta_inicial = dw_datos.getitemstring(ll_breakrow,"co_detcom_pl_codigo_1")
			ls_cscodigo = dw_datos.getitemstring(ll_breakrow,"centro_costo")
			if isnull(ls_cscodigo) then ls_cscodigo = 'nulo'
//				 lc_saldo_inicial = f_saldo_inicial_subctas_x_suc(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cuenta_inicial,ls_cscodigo,ld_fec_ini)
                  ll_find = ids_subctas_suc.find("co_detcom_pl_codigo = '"+ls_cuenta_inicial+"' and co_detcom_cs_codigo = '"+ls_cscodigo+"'",1,ll_tot) 
				if ll_find > 0 then		
				lc_saldo_inicial = ids_subctas_suc.Object.saldo_ini[ll_find]
  			     else
				lc_saldo_inicial = 0
			     end if
				dw_datos.setitem(ll_breakrow,"cc_saldo_inicial",lc_saldo_inicial)
			// Increment starting row to find next break
			ll_breakrow = ll_breakrow + 1
	LOOP
	dw_datos.GroupCalc()
end if 	
w_marco.SetMicrohelp("Listo...")
Setpointer(Arrow!)

end event

event closequery;
return	
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_mayor_general
integer x = 0
integer y = 264
integer width = 3653
integer height = 1560
string dataobject = "d_rep_mayor_general"
boolean livescroll = false
end type

event dw_datos::retrieveend;call super::retrieveend;dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_mayor_general
integer x = 59
integer y = 780
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_mayor_general
end type

type dw_1 from datawindow within w_rep_mayor_general
integer width = 3648
integer height = 252
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_external_cuentas_sucursal_fecha"
boolean border = false
boolean livescroll = true
end type

event editchanged;/*Modificado para trabajar con sucursales en l$$HEX1$$ed00$$ENDHEX$$nea*/
String ls_data
If dwo.name = "cuenta_inicial" &
Then
ls_data = data+'%'
idwc_aux.SetFilter("pl_codigo like '"+ls_data+"' ")
idwc_aux.Filter()
This.GetChild("pl_codigo",idwc_aux)
End if 


If dwo.name = "cuenta_final" &
Then
ls_data = data+'%'
idwc_aux1.SetFilter("pl_codigo like '"+ls_data+"' ")
idwc_aux1.Filter()
This.GetChild("pl_codigo",idwc_aux1)
End if 

Return 1
end event

event buttonclicked;//string null_str
//
//if dwo.name = 'b_1' then
//parent.triggerevent("ue_retrieve")
//end if
//if dwo.name = 'b_2' then
//	SetNull(null_str)
//	dw_datos.SetFilter(null_str)
//	dw_datos.Filter()	
//	dw_datos.groupcalc()
//end if
end event

event clicked;if dwo.name = 't_5' then
	this.Object.cuenta_inicial[1] = 	this.Object.cuenta_final[1]
end if
if dwo.name = 't_6' then
	this.Object.cuenta_final[1] = 	this.Object.cuenta_inicial[1]
end if

if dwo.name = 't_7' then
	this.Object.fec_ini[1] = 	this.Object.fecha_corte[1]
end if
if dwo.name = 't_8' then
	this.Object.fecha_corte[1] = 	this.Object.fec_ini[1]
end if
end event

type rb_1 from radiobutton within w_rep_mayor_general
integer x = 3118
integer y = 44
integer width = 448
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
string text = "Por empresa"
boolean checked = true
end type

type rb_2 from radiobutton within w_rep_mayor_general
integer x = 3118
integer y = 128
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


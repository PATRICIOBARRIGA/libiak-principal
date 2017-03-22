HA$PBExportHeader$w_rep_balance_comprobacion.srw
$PBExportComments$Vale
forward
global type w_rep_balance_comprobacion from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_balance_comprobacion
end type
type rb_1 from radiobutton within w_rep_balance_comprobacion
end type
type rb_2 from radiobutton within w_rep_balance_comprobacion
end type
type cbx_1 from checkbox within w_rep_balance_comprobacion
end type
type cbx_2 from checkbox within w_rep_balance_comprobacion
end type
type cbx_3 from checkbox within w_rep_balance_comprobacion
end type
type cbx_4 from checkbox within w_rep_balance_comprobacion
end type
type dw_cab from datawindow within w_rep_balance_comprobacion
end type
end forward

global type w_rep_balance_comprobacion from w_sheet_1_dw_rep
boolean visible = false
integer x = 46
integer y = 300
integer width = 4411
integer height = 1836
string title = "Balance de Comprobaci$$HEX1$$f300$$ENDHEX$$n"
long backcolor = 79741120
dw_1 dw_1
rb_1 rb_1
rb_2 rb_2
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
dw_cab dw_cab
end type
global w_rep_balance_comprobacion w_rep_balance_comprobacion

type variables
DataWindowChild   idwc_aux,idwc_aux1
DataStore ids_subctas,ids_subctas_suc
end variables

event open;datawindowchild   dwc_cuentas,dwc_ctaspadre

dw_datos.Settransobject(sqlca)
dw_report.SetTransObject(sqlca)

dw_cab.SetTransObject(sqlca)
dw_asiento.SetTransObject(sqlca)
f_recupera_empresa(dw_asiento,"pl_codigo")
f_recupera_empresa(dw_asiento,"cs_codigo")

dw_1.InsertRow(0)
dw_1.SetItem(1,"cuenta_inicial",'1') 
dw_1.SetItem(1,"cuenta_final",'1') 


dw_1.GetChild("cuenta_inicial",idwc_aux)
dw_1.GetChild("cuenta_final",idwc_aux1)

dw_datos.GetChild("co_detcom_pl_codigo",dwc_cuentas)
dw_datos.GetChild("co_placta_pl_padre",dwc_ctaspadre)

dwc_ctaspadre.SetTransObject(SQLCA)
dwc_ctaspadre.Retrieve(str_appgeninfo.empresa)
dwc_cuentas.SetTransObject(SQLCA)
dwc_cuentas.retrieve(str_appgeninfo.empresa)


/**/
ids_subctas = Create Datastore
ids_subctas.DataObject = "d_saldo_inicial_subctas"
ids_subctas.SetTransObject(sqlca)

ids_subctas_suc = Create Datastore
ids_subctas_suc.DataObject = "d_saldo_inicial_subctas_x_suc"
ids_subctas_suc.SetTransObject(sqlca)


idwc_aux.setTransObject(sqlca)
idwc_aux.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
idwc_aux1.setTransObject(sqlca)
idwc_aux1.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
this.ib_notautoretrieve = true

dw_datos.modify("st_empresa.text ='"+gs_empresa+"' st_sucursal.text='"+gs_su_nombre+"' datawindow.print.preview='yes'")

call super::open
end event

on w_rep_balance_comprobacion.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.dw_cab=create dw_cab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.cbx_2
this.Control[iCurrent+6]=this.cbx_3
this.Control[iCurrent+7]=this.cbx_4
this.Control[iCurrent+8]=this.dw_cab
end on

on w_rep_balance_comprobacion.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.dw_cab)
end on

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y +120)
this.setRedraw(True)
end event

event closequery;return
end event

event ue_retrieve;string    ls_cuenta_inicial,ls_cuenta_final
date  ld_fecha_corte,ld_fec_ini
string  ls_nulo


SetPointer(HourGlass!)

dw_1.AcceptText()

ls_cuenta_inicial = dw_1.GetItemString(1,'cuenta_inicial')
ls_cuenta_final   = dw_1.GetItemString(1,'cuenta_final')
ld_fec_ini        = dw_1.GetItemDate(1,'fec_ini')
ld_fecha_corte    = dw_1.GetItemDate(1,'fecha_corte')


/*Por empresa*/
If rb_1.checked then
   /*Resumido por empresa*/
	If cbx_1.checked = true and cbx_4.checked = False Then
		dw_datos.dataobject = "d_rep_bal_comprob_resumido"
		//ids_subctas.retrieve(str_appgeninfo.empresa,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini)	
	End if
	 /*Resumido Gastos por Centro de Costos */
	If cbx_4.checked = true Then
		dw_datos.dataobject = "d_rep_bal_comprob_gasto_agrup"
		//ids_ccostos.retrieve(str_appgeninfo.empresa,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini)	
	End if
	
	/*Detallado por empresa*/
	If cbx_2.checked = true and  cbx_3.checked = false Then
		dw_datos.dataobject = "d_rep_bal_comprobacion_cc"
		//ids_subctas.retrieve(str_appgeninfo.empresa,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini)	
	End if
	
	If cbx_2.checked = true and  cbx_3.checked = true Then
		dw_datos.dataobject = "d_rep_bal_comprobacion_agrup"
		//ids_subctas.retrieve(str_appgeninfo.empresa,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini)	
	End if
	
	dw_datos.settransobject(sqlca)
	
     f_recupera_empresa(dw_datos,"co_detcom_pl_codigo")
	f_recupera_empresa(dw_datos,"co_placta_pl_padre")
	f_recupera_empresa(dw_datos,"cc_centro")
//	f_recupera_empresa(dw_datos,"cs_codigo")
	 
	/*Saldo inicial*/
	ids_subctas.retrieve(str_appgeninfo.empresa,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini)	
	dw_datos.Retrieve(str_appgeninfo.empresa,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini,ld_fecha_corte)


end if

/*Por sucursal*/
If rb_2.checked then
	If cbx_1.checked = true Then
		dw_datos.dataobject = "d_rep_bal_comprob_resumido_x_suc"
	End if
	/*Detallado por empresa*/
	If cbx_2.checked = true Then
		dw_datos.dataobject = "d_rep_bal_comprobacion_cc_x_suc"
	End if
	dw_datos.settransobject(sqlca)
	
	f_recupera_empresa(dw_datos,"co_detcom_pl_codigo")
	f_recupera_empresa(dw_datos,"co_placta_pl_padre")
	f_recupera_empresa(dw_datos,"cc_centro")
     
	 /*Saldo inicial _x_suc*/
	ids_subctas_suc.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini)	
	dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini,ld_fecha_corte)
	
end if

dw_datos.modify("st_empresa.text ='"+gs_empresa+"' st_sucursal.text='"+gs_su_nombre+"' datawindow.print.preview='yes'")

SetPointer(Arrow!)
end event

event ue_contabilizar;call super::ue_contabilizar;/*Generar asiento de cierre*/
long ll_reg
int i,j
string ls_suc,&
          ls_ctaval,ls_cc,ls_cta,ls_signo,ls_estado,&
		ls_ctadif = '3150101003',&
		ls_tipcom = '13'
		
		
		
Dec{2} lc_valdeb,lc_valcre ,lc_valor,lc_dif,lc_totdeb,lc_totcre
Long   v_cpnumero,v_cpnumdoc,ll_new    
Date   ld_ini,ld_fin
String v_observacion 



ld_fin = date(dw_1.Object.fecha_corte[1])
v_observacion = 'Asiento de cierre.'

dw_cab.reset()
dw_asiento.reset()
dw_asiento.visible = true

w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n...por favor espere...")
Setpointer(Hourglass!)

// Compras
ll_reg = dw_datos.rowcount()


//-Inicia creacion del asiento
dw_asiento.setredraw(false)
for i = 1 to ll_reg
	
                    lc_valcre = 0
				lc_valdeb = 0		 

				ls_cta          =   dw_datos.Object.co_detcom_pl_codigo[i]
				ls_cc            =   string(dw_datos.Object.cc_centro[i])
				
				lc_valcre     =   Dec(dw_datos.Object.s_credito[i])
				lc_valdeb    =   Dec(dw_datos.Object.s_debito[i])	
				
				if isnull(lc_valcre) then lc_valcre = 0
				if isnull(lc_valdeb) then lc_valdeb = 0
				
				lc_valor  = lc_valdeb - lc_valcre
                    if lc_valor <> 0 then				
				ll_new = dw_asiento.insertrow(0)
				dw_asiento.Object.em_codigo[ll_new] = str_appgeninfo.empresa
				dw_asiento.Object.su_codigo[ll_new] = str_appgeninfo.sucursal	
				dw_asiento.Object.ti_codigo[ll_new] = ls_tipcom
				dw_asiento.Object.cp_numero[ll_new] = 9999999	
				dw_asiento.Object.pl_codigo[ll_new] = ls_cta	
				dw_asiento.Object.cs_codigo[ll_new] = ls_cc
				dw_asiento.Object.dt_detalle[ll_new] = v_observacion+string(ld_fin,'mmm-yyyy')
				dw_asiento.Object.dt_secue[ll_new] = '1'
					if lc_valor > 0 then					
					dw_asiento.Object.dt_signo[ll_new] = 'C'
					dw_asiento.Object.dt_valor[ll_new] = Abs(lc_valor)
					lc_totcre = lc_totcre + Abs(lc_valor)
					 elseif lc_valor < 0 then
					dw_asiento.Object.dt_signo[ll_new] = 'D'
					dw_asiento.Object.dt_valor[ll_new] = Abs(lc_valor)
					lc_totdeb = lc_totdeb + Abs(lc_valor)
					end if
 			     end if
next

/*Datos de la diferencia*/
lc_dif = lc_totdeb - lc_totcre
ll_new = dw_asiento.insertrow(0)
dw_asiento.Object.em_codigo[ll_new] = str_appgeninfo.empresa
dw_asiento.Object.su_codigo[ll_new] = str_appgeninfo.sucursal	
dw_asiento.Object.ti_codigo[ll_new] = ls_tipcom
dw_asiento.Object.cp_numero[ll_new] = 9999999	
dw_asiento.Object.pl_codigo[ll_new] = ls_ctadif	
dw_asiento.Object.cs_codigo[ll_new] = '1'
dw_asiento.Object.dt_secue[ll_new] = '1'	
dw_asiento.Object.dt_signo[ll_new] = 'C'
dw_asiento.Object.dt_valor[ll_new] =  Abs(lc_dif)
dw_asiento.Object.dt_detalle[ll_new] = v_observacion+string(ld_fin,'mmm-yyyy')		


dw_asiento.setredraw(true)
Setpointer(Arrow!)     

w_marco.SetMicrohelp("Listo...")
RETURN 1


end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_balance_comprobacion
integer x = 0
integer y = 360
integer width = 3387
integer height = 1336
integer taborder = 50
string dataobject = "d_rep_bal_comprobacion_cc"
boolean hscrollbar = false
boolean livescroll = false
end type

event dw_datos::retrieveend;call super::retrieveend;String ls_plcodigo,ls_cscodigo
Date ld_fini
Decimal lc_saldo_inicial
Long i,ll_find,ll_reg

ld_fini = dw_1.getitemDate(dw_1.getrow(),"fec_ini")


	for i= 1 to dw_datos.rowcount()
			ls_plcodigo = dw_datos.GetItemString(i,"co_detcom_pl_codigo")
			ls_cscodigo = dw_datos.GetitemString(i,"cc_centro")

		if ls_cscodigo = "" or isnull(ls_cscodigo) or ls_cscodigo = '0'then
			ls_cscodigo = 'nulo'
		end if	
		/*Por empresa*/
		if rb_1.checked then
			//lc_saldoini = f_saldo_inicial_subctas(str_appgeninfo.empresa,ls_plcodigo,ls_cscodigo,ld_fini)
			
				  ll_reg = ids_subctas.rowcount()	
				  ll_find = ids_subctas.find("co_detcom_pl_codigo = '"+ls_plcodigo+"' and co_detcom_cs_codigo = '"+ls_cscodigo+"'",1,ids_subctas.rowcount()) 
				if ll_find > 0 then		
					lc_saldo_inicial = ids_subctas.Object.saldo_ini[ll_find]
				else
					lc_saldo_inicial = 0
				 end if
		end if
		/*Por sucursal*/
		if rb_2.checked then
	//	lc_saldoini = f_saldo_inicial_subctas_x_suc(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_plcodigo,ls_cscodigo,ld_fini)
		  ll_find = ids_subctas_suc.find("co_detcom_pl_codigo = '"+ls_plcodigo+"' and co_detcom_cs_codigo = '"+ls_cscodigo+"'",1,ids_subctas_suc.rowcount()) 
		if ll_find > 0 then		
		lc_saldo_inicial = ids_subctas_suc.Object.saldo_ini[ll_find]
		else
		lc_saldo_inicial = 0
		  end if
		  end if	
		dw_datos.setitem(i,"cc_saldo_inicial",lc_saldo_inicial)
	next

end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_balance_comprobacion
integer x = 23
integer y = 548
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_balance_comprobacion
integer x = 402
integer y = 800
integer width = 3945
integer height = 904
boolean titlebar = true
string dataobject = "d_aux_detallecomprobante"
boolean controlmenu = true
boolean resizable = true
end type

event dw_asiento::itemchanged;call super::itemchanged;/*Listo*/
Decimal{2} lc_creditos,lc_debitos
Long ll_cpnumero,ll_sectipo,ll_cont
Integer i,li_rc
String  ls_sectipo,ls_sigla,&
           ls_tipo = '13'
Date ld_ini,ld_fin

//ld_ini = date(em_1.text)
//ld_fin = date(em_2.text)


Setpointer(Hourglass!)
If dwo.name = 'b_1' then

If this.rowcount() <= 0 then return -1

/*Validar que no haya sido contabilizado*/

lc_creditos = this.Object.cc_totcreditos[1]
lc_debitos  = this.Object.cc_totdebitos[1]

IF lc_creditos = 0 and lc_debitos = 0 THEN
return -1
END IF

IF lc_creditos <> lc_debitos THEN
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El asiento no cuadra...<Por favor verifique!!>",Exclamation!)
return -1	
END IF

ll_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
ll_sectipo     = f_secuencial(str_appgeninfo.empresa,'DGR')
ls_sectipo    = String(ll_sectipo)


/**/
If ll_cpnumero < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return -1
End if 

If ll_sectipo < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial por tipo de comprobante...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return -1
End if 

dw_cab.insertrow(0)
dw_cab.SetItem(1,"em_codigo",str_appgeninfo.empresa)
dw_cab.SetItem(1,"cp_numero",ll_cpnumero)
dw_cab.SetItem(1,"su_codigo",str_appgeninfo.sucursal)
dw_cab.SetItem(1,"cp_numcomp",ls_sectipo)
dw_cab.SetItem(1,"ti_codigo",ls_tipo)
dw_cab.SetItem(1,"cp_fecha",ld_ini)


/*Inserta clave del detalle solo si es nuevo*/
for i = 1 to dw_asiento.RowCount()
dw_asiento.SetItem(i,"em_codigo",str_appgeninfo.empresa)
dw_asiento.SetItem(i,"su_codigo",str_appgeninfo.sucursal)
dw_asiento.SetItem(i,"ti_codigo",ls_tipo)
dw_asiento.SetItem(i,"cp_numero",ll_cpnumero)
dw_asiento.SetItem(i,"dt_secue",String(i))
next 	

/**/
li_rc = dw_cab.Update(TRUE, FALSE) 

if li_rc = 1 then
		li_rc = dw_asiento.update(TRUE, FALSE)
		if li_rc = 1 then
		dw_cab.resetupdate()
		dw_asiento.resetupdate()	
		commit;

		w_marco.Setmicrohelp("Asiento contable creado exitosamente....<Por favor verifique asiento N$$HEX1$$ba00$$ENDHEX$$:"+String(ll_cpnumero)+">")
		else
	     Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas  el detalle del comprobante..."+sqlca.sqlerrtext)
		rollback;
		return -1
		end if 	
else
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el comprobante..."+sqlca.sqlerrtext)
rollback;
return -1
End if
End if

If dwo.name = 'b_2' then
this.visible = false
End if
Setpointer(Arrow!)
end event

event dw_asiento::buttonclicked;call super::buttonclicked;/*Listo*/
Decimal{2} lc_creditos,lc_debitos
Long ll_cpnumero,ll_sectipo,ll_cont
Integer i,li_rc
String  ls_sectipo,ls_sigla,&
           ls_tipo = '13'
Date ld_ini,ld_fin

//ld_ini = date(em_1.text)
ld_fin = date(dw_1.Object.fecha_corte[1])


Setpointer(Hourglass!)
If dwo.name = 'b_1' then

If this.rowcount() <= 0 then return -1

/*Validar que no haya sido contabilizado*/

lc_creditos = this.Object.cc_totcreditos[1]
lc_debitos  = this.Object.cc_totdebitos[1]

IF lc_creditos = 0 and lc_debitos = 0 THEN
return -1
END IF

IF lc_creditos <> lc_debitos THEN
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El asiento no cuadra...<Por favor verifique!!>",Exclamation!)
return -1	
END IF

ll_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
ll_sectipo     = f_secuencial(str_appgeninfo.empresa,'DGR')
ls_sectipo    = String(ll_sectipo)


/**/
If ll_cpnumero < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return -1
End if 

If ll_sectipo < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial por tipo de comprobante...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return -1
End if 

dw_cab.insertrow(0)
dw_cab.SetItem(1,"em_codigo",str_appgeninfo.empresa)
dw_cab.SetItem(1,"cp_numero",ll_cpnumero)
dw_cab.SetItem(1,"su_codigo",str_appgeninfo.sucursal)
dw_cab.SetItem(1,"cp_numcomp",ls_sectipo)
dw_cab.SetItem(1,"ti_codigo",ls_tipo)
dw_cab.SetItem(1,"cp_fecha",ld_fin)


/*Inserta clave del detalle solo si es nuevo*/
for i = 1 to dw_asiento.RowCount()
dw_asiento.SetItem(i,"em_codigo",str_appgeninfo.empresa)
dw_asiento.SetItem(i,"su_codigo",str_appgeninfo.sucursal)
dw_asiento.SetItem(i,"ti_codigo",ls_tipo)
dw_asiento.SetItem(i,"cp_numero",ll_cpnumero)
dw_asiento.SetItem(i,"dt_secue",String(i))
next 	

/**/
li_rc = dw_cab.Update(TRUE, FALSE) 

if li_rc = 1 then
		li_rc = dw_asiento.update(TRUE, FALSE)
		if li_rc = 1 then
		dw_cab.resetupdate()
		dw_asiento.resetupdate()	
		commit;

		w_marco.Setmicrohelp("Asiento contable creado exitosamente....<Por favor verifique asiento N$$HEX1$$ba00$$ENDHEX$$:"+String(ll_cpnumero)+">")
		else
	     Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas  el detalle del comprobante..."+sqlca.sqlerrtext)
		rollback;
		return -1
		end if 	
else
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el comprobante..."+sqlca.sqlerrtext)
rollback;
return -1
End if
End if

If dwo.name = 'b_2' then
this.visible = false
End if
Setpointer(Arrow!)
end event

type dw_1 from datawindow within w_rep_balance_comprobacion
integer y = 124
integer width = 3387
integer height = 228
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_external_cuentas_sucursal_fecha"
boolean border = false
boolean livescroll = true
end type

event editchanged;String ls_data
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

event buttonclicked;string    ls_cuenta_inicial,ls_cuenta_final
datetime  ld_fecha_corte,ld_fec_ini
string  ls_nulo



Setnull(ls_nulo)
SetPointer(HourGlass!)

dw_1.AcceptText()
if dwo.name = 'b_1'&
then
ls_cuenta_inicial = dw_1.GetItemString(1,'cuenta_inicial')
ls_cuenta_final   = dw_1.GetItemString(1,'cuenta_final')
ld_fec_ini        = dw_1.GetItemDateTime(1,'fec_ini')
ld_fecha_corte    = dw_1.GetItemDateTime(1,'fecha_corte')
If cbx_1.checked = true Then
	dw_datos.dataobject = "d_rep_bal_comprob_resumido"
End if
If cbx_2.checked = true Then
	dw_datos.dataobject = "d_rep_bal_comprobacion_cc"
End if
dw_datos.settransobject(sqlca)
f_recupera_empresa(dw_datos,"co_detcom_pl_codigo")
f_recupera_empresa(dw_datos,"co_placta_pl_padre")
f_recupera_empresa(dw_datos,"cc_centro")
dw_datos.modify("st_empresa.text ='"+gs_empresa+"' st_sucursal.text='"+gs_su_nombre+"' datawindow.print.preview='yes'")
dw_datos.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_cuenta_inicial,ls_cuenta_final,ld_fec_ini,ld_fecha_corte)
End if

if dwo.name = 'b_2'&
then
dw_datos.Setfilter(ls_nulo)
dw_datos.Filter()
dw_datos.groupcalc()
end if 
SetPointer(Arrow!)


end event

event clicked;if dwo.name = 't_5' then
	this.Object.cuenta_inicial[1] = 	this.Object.cuenta_final[1]
end if
if dwo.name = 't_6' then
	this.Object.cuenta_final[1] = 	this.Object.cuenta_inicial[1]
end if
end event

type rb_1 from radiobutton within w_rep_balance_comprobacion
integer x = 165
integer y = 36
integer width = 357
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

event clicked;if cbx_2.checked then
	cbx_3.visible = true
end if

end event

type rb_2 from radiobutton within w_rep_balance_comprobacion
boolean visible = false
integer x = 599
integer y = 36
integer width = 416
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

event clicked;if cbx_2.checked then
	cbx_3.visible = false
	cbx_3.checked = false
end if


end event

type cbx_1 from checkbox within w_rep_balance_comprobacion
integer x = 3017
integer y = 144
integer width = 338
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
string text = "Resumido"
end type

event clicked;//si esta con visto
if cbx_1.checked and rb_1.checked = true then
	cbx_4.visible = true
else
	cbx_4.visible = false
	cbx_4.checked = false
end if

if cbx_2.checked then
	cbx_2.checked = false
	cbx_3.visible = false
	cbx_3.checked = false
end if


end event

type cbx_2 from checkbox within w_rep_balance_comprobacion
integer x = 3022
integer y = 244
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
string text = "Detallado"
end type

event clicked;
if cbx_1.checked then
	cbx_1.checked = false
	cbx_4.visible = false
	cbx_4.checked = false
end if

//si esta con visto
if cbx_2.checked and rb_1.checked = true then
	cbx_3.visible = true
else
	cbx_3.visible = false
	cbx_3.checked = false
end if



end event

type cbx_3 from checkbox within w_rep_balance_comprobacion
boolean visible = false
integer x = 3090
integer y = 248
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
string text = "Agrupado"
end type

type cbx_4 from checkbox within w_rep_balance_comprobacion
string tag = "BubbleHelp= Reporte Agrupado por Centro de Costos, solo de gastos Cts comiencen con 6"
boolean visible = false
integer x = 3090
integer y = 152
integer width = 315
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
string text = "C Costos"
end type

type dw_cab from datawindow within w_rep_balance_comprobacion
boolean visible = false
integer x = 3579
integer y = 56
integer width = 686
integer height = 400
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_aux_comprobante"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


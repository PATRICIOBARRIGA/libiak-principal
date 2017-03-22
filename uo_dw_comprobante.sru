HA$PBExportHeader$uo_dw_comprobante.sru
forward
global type uo_dw_comprobante from datawindow
end type
end forward

global type uo_dw_comprobante from datawindow
integer width = 4411
integer height = 1336
string title = "none"
string dataobject = "d_aux_detallecomprobante"
boolean vscrollbar = true
boolean livescroll = true
end type
global uo_dw_comprobante uo_dw_comprobante

type variables
integer ii_comp
DataStore ids_cabcom,&
               ids_prn_asiento

end variables

on uo_dw_comprobante.create
end on

on uo_dw_comprobante.destroy
end on

event buttonclicked;
/*Listo*/
Decimal{2} lc_creditos,lc_debitos
Long ll_cpnumero,ll_sectipo,ll_cont,ll_new
Integer i,li_rc
String  ls_sectipo,ls_sigla,&
           ls_tipodoc 
Date    ld_ini,ld_fin


Setpointer(Hourglass!)




//1. Actualizaci$$HEX1$$f300$$ENDHEX$$n del comprobante
If dwo.name = 'b_1' then

		If this.rowcount() <= 0 then 
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Operaci$$HEX1$$f300$$ENDHEX$$n no permitida...no existen datos para procesar...")
			return
		End if
		
		// Tomar el tipo de comprobante
		ls_tipodoc   = this.Object.ti_codigo[1]
		
		
		SELECT TI_SIGLA
		INTO  :ls_sigla
		FROM CO_TIPCOM
		WHERE EM_CODIGO = :str_appgeninfo.empresa
		AND TI_CODIGO = :ls_tipodoc;
	
		
		
		
		/*Validar que no haya sido contabilizado*/
		
		lc_creditos = this.Object.cc_totcreditos[1]
		lc_debitos  = this.Object.cc_totdebitos[1]
		ld_ini         = date(this.object.fecha[1])
		
		IF lc_creditos = 0 and lc_debitos = 0 THEN
		return -1
		END IF
		
		IF lc_creditos <> lc_debitos THEN
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El asiento no cuadra...<Por favor verifique!!>",Exclamation!)
		return -1	
		END IF
		
		ll_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
		ll_sectipo     = f_secuencial(str_appgeninfo.empresa,ls_sigla)
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
		
		ids_cabcom.reset()
		ll_new = ids_cabcom.insertrow(0)
		ids_cabcom.SetItem(ll_new,"em_codigo",str_appgeninfo.empresa)
		ids_cabcom.SetItem(ll_new,"cp_numero",ll_cpnumero)
		ids_cabcom.SetItem(ll_new,"su_codigo",str_appgeninfo.sucursal)
		ids_cabcom.SetItem(ll_new,"cp_numcomp",ls_sectipo)
		ids_cabcom.SetItem(ll_new,"ti_codigo",ls_tipodoc)
		ids_cabcom.SetItem(ll_new,"cp_fecha",ld_ini)
		ids_cabcom.Setitem(ll_new,"cp_debito",lc_debitos)
		ids_cabcom.Setitem(ll_new,"cp_credito",lc_creditos)
		
		
		/*Inserta clave del detalle solo si es nuevo*/
		for i = 1 to this.RowCount()
			this.SetItem(i,"em_codigo",str_appgeninfo.empresa)
			this.SetItem(i,"su_codigo",str_appgeninfo.sucursal)
			this.SetItem(i,"ti_codigo",ls_tipodoc)
			this.SetItem(i,"cp_numero",ll_cpnumero)
			this.SetItem(i,"dt_secue",String(i))
		next 	
		
		/**/
		li_rc = ids_cabcom.Update(TRUE, FALSE) 
		if li_rc = 1 then
				li_rc = this.update(TRUE, FALSE)
				if li_rc = 1 then
					ids_cabcom.resetupdate()
					this.resetupdate()	
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


//2. Boton cerrar
If dwo.name = 'b_2' then
this.visible = false
End if



//3. Boton para impresion
if dwo.name = 'b_3' then
	long ll_reg
	
	
	If this.rowcount() <= 0 then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Operaci$$HEX1$$f300$$ENDHEX$$n no permitida...no existen datos para procesar...")
	return
	End if
	
	
	ii_comp    = this.object.cp_numero[1] 
	ls_tipodoc = this.object.ti_codigo[1]
	if ii_comp = 0 or isnull(ii_comp) or ii_comp =9999999  then 
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El comprobante todav$$HEX1$$ed00$$ENDHEX$$a no ha sido guardado....Por favor verifique...!")
		return 
	end if	

	ll_reg =  ids_prn_asiento.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipodoc,ii_comp) 
	if ll_reg > 0 then
     	if PrintSetup() = 1 then ids_prn_asiento.print()
	end if
end if
Setpointer(Arrow!)
end event

event constructor;//Cabecera del comprobante
ids_cabcom = Create DataStore
ids_cabcom.DataObject = 'd_aux_comprobante'
ids_cabcom.SetTransObject(sqlca)


//Para impresion
ids_prn_asiento   = Create DataStore
ids_prn_asiento.DataObject = "d_prn_asiento_contable"
ids_prn_asiento.settransobject(sqlca)



//Detalle del comprobante
this.SetTransObject(sqlca)

f_recupera_empresa(this,"pl_codigo")
f_recupera_empresa(this,"pl_codigo_1")
f_recupera_empresa(this,"cs_codigo")
f_recupera_empresa(this,"ti_codigo")

end event

event doubleclicked;//
integer i
if dwo.name = 'ti_codigo' then
	for i = 1 to this.rowcount()
		this.object.ti_codigo[i] = this.object.ti_codigo[1]
	next
end if

end event


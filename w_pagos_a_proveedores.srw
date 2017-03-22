HA$PBExportHeader$w_pagos_a_proveedores.srw
$PBExportComments$Si.Actual, tiene la opci$$HEX1$$f300$$ENDHEX$$n de contabilizaci$$HEX1$$f300$$ENDHEX$$n
forward
global type w_pagos_a_proveedores from w_sheet_1_dw_maint
end type
type dw_2 from datawindow within w_pagos_a_proveedores
end type
type em_1 from editmask within w_pagos_a_proveedores
end type
type em_2 from editmask within w_pagos_a_proveedores
end type
type cb_2 from commandbutton within w_pagos_a_proveedores
end type
type dw_cruce from datawindow within w_pagos_a_proveedores
end type
type dw_cpmovim from datawindow within w_pagos_a_proveedores
end type
type dw_egreso from datawindow within w_pagos_a_proveedores
end type
type dw_cabcom from datawindow within w_pagos_a_proveedores
end type
type cb_3 from commandbutton within w_pagos_a_proveedores
end type
type cb_default from commandbutton within w_pagos_a_proveedores
end type
type cb_5 from commandbutton within w_pagos_a_proveedores
end type
type dw_detegre from datawindow within w_pagos_a_proveedores
end type
type dw_detcom from datawindow within w_pagos_a_proveedores
end type
type st_1 from statictext within w_pagos_a_proveedores
end type
type st_2 from statictext within w_pagos_a_proveedores
end type
type st_3 from statictext within w_pagos_a_proveedores
end type
type dw_1 from datawindow within w_pagos_a_proveedores
end type
type st_4 from statictext within w_pagos_a_proveedores
end type
end forward

global type w_pagos_a_proveedores from w_sheet_1_dw_maint
integer width = 5051
integer height = 2620
string title = "Pagos a Proveedores"
long backcolor = 79741120
dw_2 dw_2
em_1 em_1
em_2 em_2
cb_2 cb_2
dw_cruce dw_cruce
dw_cpmovim dw_cpmovim
dw_egreso dw_egreso
dw_cabcom dw_cabcom
cb_3 cb_3
cb_default cb_default
cb_5 cb_5
dw_detegre dw_detegre
dw_detcom dw_detcom
st_1 st_1
st_2 st_2
st_3 st_3
dw_1 dw_1
st_4 st_4
end type
global w_pagos_a_proveedores w_pagos_a_proveedores

type variables
long    il_secue
decimal ic_iva,ic_valpago,ic_totalfact,ic_baseimp,ic_retfte,ic_retiva
date id_fechaegr
String  is_rucci,is_cscodigo,is_numfact,is_nomb_prov, is_plcodigoprov ,is_numcheq /*cuenta contable de proveedores*/
datawindowchild  idwc_prov,  /* Proveedores */ &
                 idwc_fp,  /*forma de pago*/ &
					  idwc_if , /*institucion financiera */&
					  idwc_cb,	 /*cuenta banco*/ &
					  idwc_ctas,  /*plan de ctas*/	&
					  idwc_tipocomp, /*Tipo de comprobantes contables*/ &
					  idwc_mov       /*Movimientos de credito*/
end variables

forward prototypes
public function integer wf_egreso ()
public function integer wf_load_default ()
public function integer wf_contabiliza ()
public function integer wf_actualiza_saldo (ref datawindow adw_cruce)
public function integer wf_preprint ()
end prototypes

public function integer wf_egreso ();
/******************************************************/
/* Funcion que llena los datos para generar egreso    */
/******************************************************/

long    ll_new
integer i,j
string  ls_if,ls_ctacte, &
		  ls_rucci,ls_pvcodigo,ls_valletras,ls_cuenta,&
		  ls_plcodigo,ls_marca,ls_ifcodigo,&
		  ls_cncodigo,ls_ctains,ls_credito
decimal lc_valor,lc_totalfact,lc_val_cheque,lc_totalabono,lc_nd,lc_valpago
date    ld_fecha,ld_fechafact


/*Determinar los datos del proveedor*/
dw_1.AcceptText()

/*Insertar un  egreso por cada cheque*/
//il_secue = f_secuencial_sucursal(str_appgeninfo.empresa,str_appgeninfo.sucursal,"EGRESO")
il_secue = f_secuencial(str_appgeninfo.empresa,"EGRESO")
is_numcheq = dw_datos.getitemstring(1,"pm_numdoc")
ls_if = dw_datos.getitemstring(1,"if_codigo")
ls_ctacte = dw_datos.getitemstring(1,"cn_codigo")	 
ld_fecha = date(dw_datos.getitemdatetime(1,"pm_fecpa"))    //Fecha del cheque
id_fechaegr = 	date(dw_datos.getitemdatetime(1,"pm_fecha"))//Fecha del egreso = fecha de pago


/* El valor del Cheque no necesariamente es el valor que se deber$$HEX1$$ed00$$ENDHEX$$a pagar	es editado por el usuario */
lc_val_cheque = dw_datos.GetitemDecimal(1,"pm_valor")


ll_new = dw_egreso.insertrow(0) 
dw_egreso.setitem(ll_new,"em_codigo",str_appgeninfo.empresa)
dw_egreso.setitem(ll_new,"su_codigo",str_appgeninfo.sucursal)	 
dw_egreso.setitem(ll_new,"eg_numero",string(il_secue))
dw_egreso.setitem(ll_new,"eg_numche",is_numcheq)
dw_egreso.setitem(ll_new,"eg_fecha",datetime(ld_fecha))     //fecha del cheque
dw_egreso.setitem(ll_new,"eg_fecegr",datetime(id_fechaegr)) //fecha del egreso
dw_egreso.setitem(ll_new,"tn_codigo",'2')
dw_egreso.setitem(ll_new,"if_codigo",ls_if) 
dw_egreso.setitem(ll_new,"cn_codigo",ls_ctacte)	 	
dw_egreso.setitem(ll_new,"eg_ordende",is_nomb_prov)	 	 
dw_egreso.setitem(ll_new,"eg_totfac",ic_totalfact)	 	 
dw_egreso.setitem(ll_new,"eg_base",ic_baseimp)	 	 
dw_egreso.setitem(ll_new,"eg_reten",ic_retfte)	 	 
dw_egreso.setitem(ll_new,"eg_dscto",0)	 	 
dw_egreso.setitem(ll_new,"eg_cargo",ic_retiva)	 	 	 
dw_egreso.setitem(ll_new,"eg_valor",lc_val_cheque) 	 	 
ls_valletras = f_numero_a_letras(lc_val_cheque)	 
dw_egreso.setitem(ll_new,"eg_vallet",ls_valletras)	 	 	 
dw_egreso.setitem(ll_new,"eg_observ",is_numfact)	 	 	 
dw_egreso.setitem(ll_new,"eg_rucci",is_rucci)	 	 	 	 
dw_egreso.setitem(ll_new,"eg_debito",lc_val_cheque)	 	 	 	 
dw_egreso.setitem(ll_new,"eg_credito",lc_val_cheque)
dw_egreso.setitem(ll_new,"sa_login",str_appgeninfo.username)
dw_egreso.setitem(ll_new,"eg_nd",'N')

/********************************************************************/
/* Detalle del egreso                                               */	
/********************************************************************/
for j = 1 to dw_detegre.rowcount()
dw_detegre.setitem(j,"em_codigo",str_appgeninfo.empresa)
dw_detegre.setitem(j,"su_codigo",str_appgeninfo.sucursal)
dw_detegre.setitem(j,"eg_numero",string(il_secue))
dw_detegre.setitem(j,"dg_numero", j)
dw_detegre.setitem(j,"eg_nd",'N')
next

return 1
end function

public function integer wf_load_default ();///////////////////////////////////////////////////////////////////////////////////
// Funci$$HEX1$$f300$$ENDHEX$$n:      wf_load_default                                                 //
// Argumentos:   Ninguno                                                         // 
// Retorna:      1 si OK                                                         //
//              -1 si error                                                      //   
// Descripci$$HEX1$$f300$$ENDHEX$$n:  carga los datos por omisi$$HEX1$$f300$$ENDHEX$$n para la contabilizaci$$HEX1$$f300$$ENDHEX$$n del pago    // 
///////////////////////////////////////////////////////////////////////////////////

Long    ll_secue,ll_new,ll_row,ll_conumero
integer i,j
string  ls_if,ls_ctacte, &
		  ls_rucci,ls_pvcodigo,ls_valletras,ls_cuenta,&
		  ls_plcodigo,ls_marca,ls_tvcodigo,ls_ifcodigo,&
		  ls_cncodigo,ls_ctains,ls_credito
decimal lc_valor,lc_totalfact,lc_val_cheque,lc_totalabono,lc_nd,lc_valpago
date    ld_fecha,ld_fechafact



/*Determinar los datos del proveedor*/
dw_1.Accepttext()
dw_2.AcceptText()

ls_pvcodigo = dw_2.getitemstring(1,"proveedor")
SELECT decode("IN_PROVE"."PV_TIPO",'J',NVL("IN_PROVE"."PV_RAZONS",''),
			     NVL("IN_PROVE"."PV_APELLI",'')||'  '||NVL("IN_PROVE"."PV_NOMBRE",'')),
			     "IN_PROVE"."PV_RUCCI"
INTO: is_nomb_prov,:is_rucci
FROM  "IN_PROVE"  
WHERE "IN_PROVE"."EM_CODIGO" = :str_appgeninfo.empresa    
AND   "IN_PROVE"."PV_CODIGO" = :ls_pvcodigo;

If sqlca.sqlcode = 100 then
messagebox("Error","Problemas al consultar nombre del proveedor "+sqlca.sqlerrtext)
return -1
End if

If isnull(is_nomb_prov) or is_nomb_prov = '' or isnumber(is_nomb_prov) then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El nombre del Proveedor no est$$HEX2$$e1002000$$ENDHEX$$bien definido...Por favor verifique..!")
Return -1
End if 

/*Para determinar la cta contable de la instituci$$HEX1$$f200$$ENDHEX$$n financiera*/
ll_row = dw_datos.GetRow()
if ll_row = 0 then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No est$$HEX2$$e1002000$$ENDHEX$$registrado el detalle del pago")
return -1
end if

ls_ifcodigo   = dw_datos.GetItemString(ll_row,"if_codigo")
ls_cncodigo   = dw_datos.GetItemString(ll_row,"cn_codigo")
lc_val_cheque = dw_datos.GetitemDecimal(ll_row,"pm_valor")
is_numcheq    = dw_datos.getitemstring(ll_row,"pm_numdoc")

SELECT "CB_CTAINS"."PL_CODIGO"  
INTO :ls_ctains  
FROM "CB_CTAINS"  
WHERE ( "CB_CTAINS"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
( "CB_CTAINS"."IF_CODIGO" = :ls_ifcodigo ) AND  
( "CB_CTAINS"."CN_CODIGO" = :ls_cncodigo );
//( "CB_CTAINS"."SU_CODIGO" = :str_appgeninfo.sucursal ) AN
/*insertar un  egreso por cada cheque*/


/*Tomar los # de las facturas que van a ser pagadas con el cheque y su valor total */ 
/*El valor total no esta quitada la retencion*/
/*Para detallar a que facturas se le ha realizado la retencion en cada egreso realizado*/
ic_valpago = 0
setnull(ld_fechafact)
setnull(ls_marca) 
is_numfact = 'F:'
ic_totalfact = 0
ic_baseimp = 0 
ic_retfte = 0
ic_retiva = 0

for j = 1 to dw_1.Rowcount()
	lc_nd = 0 
	ld_fechafact = date(dw_1.getitemdatetime(j,"cc_fvence"))
	ls_marca = dw_1.GetItemString(j,"cp_movim_mp_contab")
	ls_credito = dw_1.GetItemString(j,"cp_movim_mp_codigo")
	if  ls_marca = 'A'&
	then
	is_numfact = is_numfact + dw_1.getitemstring(j,"in_compra_co_facpro")+" ; "
     ll_conumero = dw_1.getitemnumber(j,"cp_movim_co_numero")
	ls_tvcodigo = dw_1.getitemstring(j,"tv_codigo")


	SELECT SUM("CP_CRUCE"."CX_VALCRE")
	INTO :lc_nd
	FROM "CP_CRUCE","CP_PAGO"  
	WHERE ( "CP_CRUCE"."TV_CODDEB" = "CP_PAGO"."TV_CODIGO" ) AND  
	( "CP_CRUCE"."TV_TIPODEB" = "CP_PAGO"."TV_TIPO" ) AND  
	( "CP_CRUCE"."MP_CODDEB" = "CP_PAGO"."MP_CODIGO" ) AND
	( "CP_CRUCE"."EM_CODIGO" = "CP_PAGO"."EM_CODIGO" ) AND
	( "CP_CRUCE"."SU_CODIGO" = "CP_PAGO"."SU_CODIGO" ) AND
	( ( "CP_CRUCE"."TV_CODIGO" = :ls_tvcodigo ) AND  
	( "CP_CRUCE"."TV_TIPO" = 'C' ) AND  
	( "CP_CRUCE"."MP_CODIGO" = :ls_credito ) AND
	( "CP_PAGO"."FP_CODIGO"  = '55')) ;

		
	If sqlca.sqlcode < 0 &
	Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al determinar la Nota de D$$HEX1$$e900$$ENDHEX$$bito "+sqlca.sqlerrtext)
	Rollback;
	Return -1
	End If
	
	ic_valpago    = ic_valpago + dw_1.GetItemdecimal(j,"cp_movim_mp_saldo") 		
	ic_totalfact  = ic_totalfact  + (dw_1.GetItemDecimal(j,"cp_movim_mp_valor") - lc_nd)
	ic_baseimp = ic_baseimp + dw_1.GetitemDecimal(j,"cp_movim_mp_baseimp")
	ic_retfte = ic_retfte + dw_1.GetItemDecimal(j,"cp_movim_mp_reten")
	ic_retiva = ic_retiva + dw_1.GetItemDecimal(j,"cp_movim_mp_retiva")
	end if
next
		 	 	 	 
/* Detalle del egreso*/	
/* Realizar distintos tipos de egreso de acuerdo al valor del cheque*/ 
/* CASO A,C */	
/* Capturar el detalle de la contabilizaci$$HEX1$$f300$$ENDHEX$$n*/


is_numfact = left(is_numfact,300)


If ic_valpago >= lc_val_cheque then
		 for j = 1 to 2
		 ll_new = dw_detegre.insertrow(0)
		 If j=1 Then 
		 dw_detegre.setitem(ll_new ,"pl_codigo",is_plcodigoprov)
		 dw_detegre.setitem(ll_new ,"cs_codigo",'1')
		 dw_detegre.setitem(ll_new ,"dg_signo",'D')
		 dw_detegre.setitem(ll_new ,"dg_observ",'Ch No.'+is_numcheq+''+is_nomb_prov+''+' Canc. '+is_numfact )	 	 		
		 Else
		 dw_detegre.setitem(ll_new ,"pl_codigo",ls_ctains)	//'1012102000'	
		 dw_detegre.setitem(ll_new ,"cs_codigo",'1')
		 dw_detegre.setitem(ll_new ,"dg_signo",'C')	 		  
		 dw_detegre.setitem(ll_new ,"dg_observ",'Ch No.'+is_numcheq+''+is_nomb_prov+''+' Canc. '+is_numfact)	  
		 End if
		 dw_detegre.setitem(ll_new ,"dg_valor",lc_val_cheque)	 	
		 next		   
 else /*B ic_valpago < lc_val_cheque*/
		 for j = 1 to 3
		 ll_new = dw_detegre.insertrow(0)
		 If j=1 Then 
		 dw_detegre.setitem(ll_new ,"pl_codigo",is_plcodigoprov) //is_plcodigoprov
		 dw_detegre.setitem(ll_new ,"cs_codigo",'1')     //El centro de costo es el mismo de prov para todas las ctas/
		 dw_detegre.setitem(ll_new ,"dg_signo",'D')
		 dw_detegre.setitem(ll_new ,"dg_observ",'Ch No.'+is_numcheq+''+is_nomb_prov+''+' Canc. '+is_numfact )	
		 dw_detegre.setitem(ll_new ,"dg_valor",ic_valpago)	 	
		 End if
		 if j= 2 then
		 dw_detegre.setitem(ll_new ,"pl_codigo",ls_ctains)	//'1012102000'	ls_ctains
		 dw_detegre.setitem(ll_new ,"cs_codigo",'1')
		 dw_detegre.setitem(ll_new ,"dg_signo",'C')	 		  
		 dw_detegre.setitem(ll_new ,"dg_observ",'Ch No.'+is_numcheq+''+is_nomb_prov+' Canc.'+is_numfact)	  
		 dw_detegre.setitem(ll_new ,"dg_valor",lc_val_cheque)	 					
		 End if
		 if j= 3 then
		 dw_detegre.setitem(ll_new ,"pl_codigo",'6150052020')
		 dw_detegre.setitem(ll_new ,"cs_codigo",'1')
		 dw_detegre.setitem(ll_new ,"dg_signo",'D')
		 dw_detegre.setitem(ll_new ,"dg_observ",+is_nomb_prov+ ' Ajuste gasto flete')	 	 		
		 dw_detegre.setitem(ll_new ,"dg_valor",lc_val_cheque - ic_valpago)	 					
		 end if	
		 next		   
end if
return 1


end function

public function integer wf_contabiliza ();/* Contabiliza cada uno de los egresos */
/* Se genera en contabilidad un asiento contable por cada cheque
   en la empresa en donde se est$$HEX2$$e1002000$$ENDHEX$$realizando el pago */
/* Modificado para trabajar con sucursales en l$$HEX1$$ed00$$ENDHEX$$nea*/  
long      ll_new,ll_sec,j,i,ll_cpnumero,ll_sectipo,ll_newd 
Decimal   lc_valch  
String    ls_ifcodigo,ls_cncodigo,&
          ls_ctains      // Cta en Institucion financiera

  
  
/*Determinar el secuencial de c/asiento y de c/comprobante*/
ll_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
ll_sectipo  = f_secuencial(str_appgeninfo.empresa,'DEG')

//ll_cpnumero = f_secuencial_sucursal(str_appgeninfo.empresa,str_appgeninfo.sucursal,"CONTA_COMP")
//ll_sectipo  = f_secuencial_sucursal(str_appgeninfo.empresa,str_appgeninfo.sucursal,'DEG')



/*Ingresar la cabecera del comprobante*/
ll_new = dw_cabcom.Insertrow(0)
dw_cabcom.SetItem(ll_new,"em_codigo",str_appgeninfo.empresa)
dw_cabcom.SetItem(ll_new,"su_codigo",str_appgeninfo.sucursal)
dw_cabcom.SetItem(ll_new,"sa_login",str_appgeninfo.username)
dw_cabcom.SetItem(ll_new,"ti_codigo",'2') /*DEG*/
dw_cabcom.SetItem(ll_new,"cp_numero",ll_cpnumero)
dw_cabcom.SetItem(ll_new,"cp_numcomp",string(ll_sectipo))
dw_cabcom.SetItem(ll_new,"cp_observ",'Pago a proveedores')
dw_cabcom.Setitem(ll_new,"cp_saldo",0)
dw_cabcom.setitem(ll_new,"cp_fecha",id_fechaegr)

/*Copiar el detalle del egreso al comprobante contable*/
for i= 1 to dw_detegre.rowcount()
ll_newd = dw_detcom.insertrow(0)
dw_detcom.setitem(ll_newd,"pl_codigo",dw_detegre.getitemstring(i,"pl_codigo"))
dw_detcom.setitem(ll_newd,"cs_codigo",dw_detegre.getitemstring(i,"cs_codigo"))
dw_detcom.setitem(ll_newd,"dt_signo",dw_detegre.getitemstring(i,"dg_signo"))
dw_detcom.setitem(ll_newd,"dt_detalle",dw_detegre.getitemstring(i,"dg_observ"))	
dw_detcom.setitem(ll_newd,"dt_valor",dw_detegre.getitemdecimal(i,"dg_valor"))	 	
next

/*Ingresar el detalle del comprobante*/

for j = 1 to  dw_detcom.rowcount() 
dw_detcom.SetItem(j,"em_codigo",str_appgeninfo.empresa)	
dw_detcom.SetItem(j,"su_codigo",str_appgeninfo.sucursal)		
dw_detcom.SetItem(j,"ti_codigo",'2')                    /*DEG*/
dw_detcom.Setitem(j,"cp_numero",ll_cpnumero)
dw_detcom.Setitem(j,"dt_secue", string(j))
next	

lc_valch = dw_detcom.getitemdecimal(dw_detcom.getrow(),"cc_tot_debitos")
dw_cabcom.SetItem(ll_new,"cp_debito",lc_valch)
dw_cabcom.SetItem(ll_new,"cp_credito",lc_valch)


return 1
end function

public function integer wf_actualiza_saldo (ref datawindow adw_cruce);/*Recorrer todas las facturas marcadas para actualizar el saldo*/
long i
Decimal lc_valcre
String ls_mpcodigo,ls_tvcodigo

for i  = 1 to adw_cruce.rowcount()
	ls_mpcodigo = adw_cruce.getitemstring(i,"mp_codigo")
	ls_tvcodigo = adw_cruce.getitemstring(i,"tv_codigo") 
	lc_valcre        =  adw_cruce.getitemdecimal(i,"cx_valcre")
   UPDATE CP_MOVIM
	SET    MP_SALDO = NVL( MP_SALDO,0) - :lc_valcre
	WHERE  TV_CODIGO = :ls_tvcodigo
	AND    TV_TIPO = 'C'
	AND    EM_CODIGO = :str_appgeninfo.empresa
	AND    SU_CODIGO = :str_appgeninfo.sucursal
   AND	 MP_CODIGO = :ls_mpcodigo;
	IF SQLCA.SQLCODE  < 0 &
	THEN
	MESSAGEBOX("ATENCION","Problemas al actualizar el saldo de las facturas "+sqlca.sqlerrtext)
	ROLLBACK;
	RETURN -1
   END IF
next	
return 1
end function

public function integer wf_preprint ();
dw_report.modify("st_empresa.text = '"+gs_empresa+"'")
return 1
end function

on w_pagos_a_proveedores.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.em_1=create em_1
this.em_2=create em_2
this.cb_2=create cb_2
this.dw_cruce=create dw_cruce
this.dw_cpmovim=create dw_cpmovim
this.dw_egreso=create dw_egreso
this.dw_cabcom=create dw_cabcom
this.cb_3=create cb_3
this.cb_default=create cb_default
this.cb_5=create cb_5
this.dw_detegre=create dw_detegre
this.dw_detcom=create dw_detcom
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_cruce
this.Control[iCurrent+6]=this.dw_cpmovim
this.Control[iCurrent+7]=this.dw_egreso
this.Control[iCurrent+8]=this.dw_cabcom
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.cb_default
this.Control[iCurrent+11]=this.cb_5
this.Control[iCurrent+12]=this.dw_detegre
this.Control[iCurrent+13]=this.dw_detcom
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.st_4
end on

on w_pagos_a_proveedores.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.cb_2)
destroy(this.dw_cruce)
destroy(this.dw_cpmovim)
destroy(this.dw_egreso)
destroy(this.dw_cabcom)
destroy(this.cb_3)
destroy(this.cb_default)
destroy(this.cb_5)
destroy(this.dw_detegre)
destroy(this.dw_detcom)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.st_4)
end on

event open;
ib_notautoretrieve = true 

dw_1.SetTransObject(SQLCA)   //Lista de facturas
dw_2.SetTransObject(SQLCA)   //Proveedores

dw_egreso.SetTransObject(SQLCA)
dw_detegre.SetTransObject(SQLCA)
dw_cpmovim.SetTransObject(SQLCA)
dw_cruce.SetTransObject(SQLCA)
dw_cabcom.SetTransObject(SQLCA) //Cabecera del comprobante contable
dw_detcom.SetTransObject(SQLCA)  //Detalle del comprobante contable

//Compartir para impresion 
dw_1.sharedata(dw_report)



dw_1.Getchild("tv_codigo",idwc_mov)
idwc_mov.SetTransobject(SQLCA)
idwc_mov.retrieve(str_appgeninfo.empresa)

dw_report.Getchild("tv_codigo",idwc_mov)
idwc_mov.SetTransobject(SQLCA)
idwc_mov.retrieve(str_appgeninfo.empresa)

dw_report.GetChild("cp_movim_pv_codigo",idwc_prov)
idwc_prov.SetTransObject(SQLCA)
idwc_prov.retrieve(str_appgeninfo.empresa)


dw_2.GetChild("proveedor",idwc_prov)
idwc_prov.SetTransObject(SQLCA)
idwc_prov.retrieve(str_appgeninfo.empresa)
dw_2.Insertrow(0)

dw_datos.Getchild("fp_codigo",idwc_fp)
idwc_fp.SetTransobject(SQLCA)
idwc_fp.retrieve(str_appgeninfo.empresa)

dw_datos.Getchild("if_codigo",idwc_if)
idwc_if.SetTransobject(SQLCA)
idwc_if.retrieve(str_appgeninfo.empresa)

dw_datos.Getchild("cn_codigo",idwc_cb)
idwc_cb.SetTransobject(SQLCA)
idwc_cb.retrieve(str_appgeninfo.empresa)
//idwc_cb.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

dw_cabcom.Getchild("ti_codigo",idwc_tipocomp)
idwc_tipocomp.SetTransObject(SQLCA)
idwc_tipocomp.retrieve(str_appgeninfo.empresa)


dw_detcom.Getchild("pl_codigo",idwc_ctas)
idwc_ctas.SetTransObject(SQLCA)
idwc_ctas.retrieve(str_appgeninfo.empresa)
//idwc_ctas.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

dw_detegre.Getchild("pl_codigo",idwc_ctas)
idwc_ctas.SetTransObject(SQLCA)
idwc_ctas.retrieve(str_appgeninfo.empresa)
//idwc_ctas.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)

f_recupera_empresa(dw_detegre,"cs_codigo")
f_recupera_empresa(dw_detcom,"cs_codigo")
f_recupera_empresa(dw_detegre,"pl_codigo_1")
f_recupera_empresa(dw_detcom,"pl_codigo_1")


//Cuenta para cierre de asiento 
SELECT PL_CODIGO
INTO    :is_plcodigoprov
FROM    PR_GRUPCONT
WHERE  GT_CODIGO = 'PRV_C' ;


call super::open
this.move(1,1)
em_1.text = string(today(),'dd/mm/yyyy')
em_2.text = string(relativedate(today(),90),'dd/mm/yyyy')
ic_iva = f_iva()


end event

event resize;return
end event

event ue_update;/*Actualiza el pago*/
String    ls_mpcoddeb,ls_pvcodigo,&
            ls_eccodigo,ls_mpcodigo,&
		      ls_check,ls_tvcodigo,ls_facpro
decimal     lc_totalpago,lc_abono,lc_saldo,lc_conumero
decimal{2}  lc_totdebito,lc_totcredito
Long        i,ll_new,rc,ll_rc,ll_cpnumero,ll_row
integer     li_contabilizar

Setpointer(Hourglass!)


/**/
//open(w_res_iva)
//ic_iva = message.doubleparm
//if ic_iva <= 0 &
//then
//Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe especificar un valor de IVA")
//return 1
//end if

/*Validar que exista datos para generar el egreso*/
If dw_detegre.rowcount()= 0 then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No est$$HEX2$$e1002000$$ENDHEX$$contabilizado el egreso~r~nPor favor verifique!")
return 1
End if	

lc_totdebito  = dw_detegre.getitemdecimal(dw_detegre.getrow(),"cc_tot_debitos")
lc_totcredito = dw_detegre.getitemdecimal(dw_detegre.getrow(),"cc_tot_creditos")

If lc_totdebito<>lc_totcredito then
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El comprobante no cuadra~r~nPor favor verifique!")
return 1
End if 	
							
							
/*Copiar el detalle del egreso al dw de contabilidad*/
cb_5.triggerevent(clicked!)


ls_pvcodigo    = dw_2.GetitemString(dw_2.Getrow(),"proveedor")
lc_totalpago   = dw_datos.GetItemdecimal(dw_datos.Getrow(),"cc_total_pago")


/*Tomar las facturas a ser canceladas */
/*Para poner en el debito la factura o facturas que van ser abonadas o pagadas
  como referencia para desplegar en el estado de cta del proveedor */

for i  =  1 to dw_1.rowcount()
	ls_check  = dw_1.GetItemString(i,"cp_movim_mp_contab")
   If ls_check = 'A' &
	then
	lc_conumero = dw_1.GetItemNumber(i,"cp_movim_co_numero")
	ls_facpro = dw_1.getitemstring(i,"in_compra_co_facpro")
   End if
next



For i = 1 to dw_datos.rowcount()
	/*Determinar el secuencial del mov. de debito*/
	SELECT PR_VALOR
	INTO: ls_mpcoddeb
	FROM PR_PARAM
	WHERE PR_NOMBRE = 'DEB_CXP'
	FOR UPDATE OF PR_VALOR;
		
	UPDATE PR_PARAM
	SET PR_VALOR = PR_VALOR + 1
	WHERE PR_NOMBRE = 'DEB_CXP';
	
	IF SQLCA.SQLCODE < 0 &	
	THEN
	MESSAGEBOX("ATENCION","Problemas al Actualizar el secuencial" +sqlca.sqlerrtext)
	ROLLBACK;
	RETURN
	END IF
	
		
	/*Entrar limpiando */
	dw_cpmovim.reset()
	dw_cruce.reset()	
	
	/*Se crea el movimiento de debito*/
	ll_new =  dw_cpmovim.insertrow(0)
	dw_cpmovim.SetItem(ll_new,"em_codigo",str_appgeninfo.empresa)
	dw_cpmovim.SetItem(ll_new,"su_codigo",str_appgeninfo.sucursal)
	dw_cpmovim.Setitem(ll_new,"mp_codigo",ls_mpcoddeb)
	dw_cpmovim.Setitem(ll_new,"pv_codigo",ls_pvcodigo)
	dw_cpmovim.Setitem(ll_new,"mp_valor",lc_totalpago)
	dw_cpmovim.SetItem(ll_new,"co_numero",lc_conumero)
	dw_cpmovim.SetItem(ll_new,"co_facpro",ls_facpro)
	dw_cpmovim.setitem(ll_new,"eg_numero",string(il_secue))
	
	/*Insertar los datos de la clave a CP_PAGO*/
	for i = 1 to dw_datos.rowcount()
		dw_datos.SetItem(i,"tv_codigo",'2')
		dw_datos.SetItem(i,"tv_tipo",'D')
		dw_datos.SetItem(i,"em_codigo",str_appgeninfo.empresa)
		dw_datos.SetItem(i,"su_codigo",str_appgeninfo.sucursal)
		dw_datos.SetItem(i,"mp_codigo",ls_mpcoddeb)
		dw_datos.SetItem(i,"pm_secuencia",i)
	next
	
	
	
	/*Cruzar movimiento*/
	lc_saldo  = lc_totalpago
	for i  =  1 to dw_1.rowcount()
		ls_check  = dw_1.GetItemString(i,"cp_movim_mp_contab")
		If ls_check = 'A' &
		then
		ls_mpcodigo   =  dw_1.GetItemString(i,"cp_movim_mp_codigo")
		lc_abono      =  dw_1.GetItemdecimal(i,"abono")
		ls_tvcodigo   =  dw_1.GetItemString(i,"tv_codigo")
		ll_new = dw_cruce.insertrow(0)
		dw_cruce.Setitem(ll_new,"tv_coddeb",'2')
		dw_cruce.Setitem(ll_new,"tv_tipodeb",'D')
		dw_cruce.Setitem(ll_new,"mp_coddeb",ls_mpcoddeb)
		dw_cruce.Setitem(ll_new,"tv_codigo",ls_tvcodigo)
		dw_cruce.Setitem(ll_new,"tv_tipo",'C')
		dw_cruce.Setitem(ll_new,"mp_codigo",ls_mpcodigo)
		dw_cruce.Setitem(ll_new,"em_codigo",str_appgeninfo.empresa)
		dw_cruce.Setitem(ll_new,"su_codigo",str_appgeninfo.sucursal)
		
		if lc_saldo < 0 	then  exit
		if lc_saldo < lc_abono &
		then
		dw_cruce.Setitem(ll_new,"cx_valcre",lc_saldo)
		else
		dw_cruce.Setitem(ll_new,"cx_valcre",lc_abono)	
		end if
		lc_saldo = lc_saldo - lc_abono
		end if
	next	 
	
Next
/**/


rc = dw_cpmovim.Update(TRUE, FALSE)
IF rc = 1 THEN
		rc = dw_datos.Update(TRUE, FALSE)
		IF rc = 1 THEN
				rc = dw_cruce.Update(TRUE,FALSE)
				IF rc = 1 THEN
				dw_cpmovim.ResetUpdate() // Both updates are OK
				dw_datos.ResetUpdate()// Clear update flags
				dw_cruce.ResetUpdate()

				/*Actualizar saldo de facturas*/
	 
	   	 	    If  wf_actualiza_saldo(dw_cruce) < 0 &
				Then
				Rollback;
				Return
     			End if
								 
				/*Actualizar el nro de asiento contable en el egreso.
				Para saber a que asiento corresponde tal egreso  */ 
						/*En el caso de querer decidir sobre la contabilizaci$$HEX1$$f300$$ENDHEX$$n*/				
						//				li_contabilizar = Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea contabilizar el pago....?",Question!,YesNoCancel!,2)
						//				If li_contabilizar = 3 then
						//					MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Transacci$$HEX1$$f300$$ENDHEX$$n cancelada....por favor cierre la ventana e intente de nuevo...",Exclamation!)
						//					rollback;
						//					return
						//				end if
			
					
							/*Pegar el codigo para validacion del egreso*/
			
					
							ll_row = dw_cabcom.rowcount()
							ll_cpnumero = dw_cabcom.GetItemNumber(ll_row,"cp_numero",Primary!,false)
							ll_row = dw_egreso.rowcount()
							dw_egreso.SetItem(ll_row,"cp_numero",ll_cpnumero)
				
							//Inicia la grabaci$$HEX1$$f300$$ENDHEX$$n de la contabilizaci$$HEX1$$f300$$ENDHEX$$n
				
							ll_rc = dw_egreso.Update()
							if ll_rc = 1 Then
										 ll_rc = dw_detegre.update()  
										 if ll_rc > 0 then 
										 dw_egreso.reset()
										 dw_detegre.reset()
										 else
										 rollback;
										 return 1
										 end if
							else
							rollback;
							return 1
							end if
							
							/**/
							ll_rc = dw_cabcom.Update()
							if ll_rc = 1 Then
									ll_rc = dw_detcom.update()  
									if ll_rc > 0 then 
									dw_cabcom.reset()
									dw_detcom.reset()
									else	
									rollback;
									return 1
									end if
							else
							rollback;
							return 1
							end if
			    				
				COMMIT ; 
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso completado con $$HEX1$$e900$$ENDHEX$$xito"+"Por favor verifique el egreso N$$HEX1$$b000$$ENDHEX$$: "+string(il_secue))
			   //cb_1.triggerevent(Clicked!)
				ELSE
				ROLLBACK ; 
				RETURN 1
				END IF
		ELSE
		ROLLBACK ;
		RETURN 1
		END IF	
ELSE
ROLLBACK;
RETURN 1
END IF
dw_datos.reset()
this.triggerevent("ue_retrieve" )
Setpointer(Arrow!)
return 0


end event

event ue_insert;GraphicObject which_control
Datawindow dw_which


which_control = GetFocus()

CHOOSE CASE TypeOf(which_control)
CASE Datawindow!
	  dw_which = which_control
	  dw_which.insertrow(0)
END CHOOSE

end event

event ue_delete;GraphicObject which_control
Datawindow dw_which


which_control = GetFocus()

CHOOSE CASE TypeOf(which_control)
CASE Datawindow!
	  dw_which = which_control
	  dw_which.deleterow(0)
END CHOOSE

end event

event ue_retrieve;date ld_fini,ld_ffin
Long ll_row
String ls_pvcodigo

ld_fini = Date(em_1.text)
ld_ffin = Date(em_2.text)

dw_egreso.reset()
dw_detegre.reset()
dw_cabcom.reset()
dw_detcom.reset()


dw_2.AcceptText()
ll_row = dw_2.getrow()
ls_pvcodigo = dw_2.GetItemString(ll_row,"proveedor")
dw_1.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_pvcodigo,ld_fini,ld_ffin)



end event

event ue_print;string ls_range
int li_res,li_rc
w_frame_basic lw_frame
m_frame_basic lm_frame


if this.wf_prePrint() = 1 then
	this.setRedraw(False)
	dw_report.modify("datawindow.print.preview.zoom=95~t" + &
								"datawindow.print.preview=yes")
	dw_1.enabled = False
	dw_1.visible = False
	dw_report.enabled = True
	dw_report.visible = True
	this.ib_inReportMode = true
	this.triggerEvent(resize!)		// so the report gets the correct size
	lw_frame = this.parentWindow()
	lm_frame = lw_frame.menuid
	lm_frame.mf_into_report_mode()
	this.setRedraw(True)
end if
openwithparm(w_dw_print_options,dw_report)
li_rc = message.DoubleParm
if li_rc = 1 then	
 dw_report.print()
end if




end event

event ue_printcancel;w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then

	if this.wf_postPrint() = 1 then
		this.setRedraw(False)
		dw_report.enabled = False
		dw_report.visible = False
		dw_1.enabled = True
		dw_1.visible = True
		this.ib_inReportMode = False
		this.triggerEvent(resize!)		// so dw_datos get the correct size
		lw_frame = this.parentWindow()
		lm_frame = lw_frame.menuid
		lm_frame.mf_outof_report_mode()
	end if

else
	beep(1)
end if

this.setRedraw(True)
end event

event ue_filter;/*Establecer el datawindow de creditos para filtrar*/
string ls_null
integer li_res

setNull(ls_null)
li_res = dw_1.SetFilter(ls_null)
if li_res = 1 then
	dw_1.Filter()
	return dw_1.groupcalc()
else
	return li_res
end if


end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_pagos_a_proveedores
integer x = 27
integer y = 1396
integer width = 4946
integer height = 396
integer taborder = 80
string dataobject = "d_pago"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
end type

event dw_datos::itemerror;call super::itemerror;return 1
end event

event dw_datos::itemfocuschanged;call super::itemfocuschanged;String ls_ifcodigo

If dwo.name = "cn_codigo" &
Then
ls_ifcodigo = this.GetItemString(row,"if_codigo")
idwc_cb.Setfilter("")
idwc_cb.Filter()
idwc_cb.Setfilter("cb_ctains_if_codigo = '"+ls_ifcodigo+"'")
idwc_cb.Filter()
this.Getchild("cn_codigo",idwc_cb)
End if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_pagos_a_proveedores
integer x = 9
integer y = 156
integer width = 3575
integer height = 1272
integer taborder = 0
string dataobject = "d_prn_autoriza_pago_proveedores"
end type

type dw_2 from datawindow within w_pagos_a_proveedores
integer x = 32
integer y = 24
integer width = 1673
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_Sel_proveedor"
boolean border = false
boolean livescroll = true
end type

type em_1 from editmask within w_pagos_a_proveedores
integer x = 1952
integer y = 40
integer width = 343
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_pagos_a_proveedores
integer x = 2505
integer y = 40
integer width = 343
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type cb_2 from commandbutton within w_pagos_a_proveedores
integer x = 603
integer y = 1304
integer width = 384
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagar"
end type

event clicked;///*Insertar pagos agrupados por fecha */
//
String ls_check
Date   ld_fvence,ld_fant
Long   i,ll_new
Decimal lc_pago,lc_saldo
//
//dw_datos.reset()
//for i  =  1 to dw_1.RowCount()
//	ls_check  = dw_1.GetItemString(i,"cp_movim_mp_contab")
//   	If ls_check = 'A' &
//	then
//		ld_fvence  = date(dw_1.GetItemDateTime(i,"cc_fvence"))
//		if  ld_fvence = ld_fant &
//		then
//		     lc_saldo = dw_1.GetItemdecimal(i,"cp_movim_mp_saldo")
//		     lc_pago =  lc_pago + lc_saldo	
//		else
//		     if lc_pago <> 0 then	
//		   	ll_new = dw_datos.insertrow(0) 
//			dw_datos.setitem(ll_new,"pm_valor",lc_pago)
//			dw_datos.setitem(ll_new,"pm_fecpa",ld_fant)
//			dw_datos.setitem(ll_new,"fp_codigo",'1')
//			dw_datos.setitem(ll_new,"if_codigo",'24')
//			dw_datos.SetItem(ll_new,"cn_codigo",'31')
//		     end if	 
//		     lc_pago = dw_1.GetItemdecimal(i,"cp_movim_mp_saldo")
//		end if
//		ld_fant  = ld_fvence
//     end if 
//	if  i = dw_1.RowCount()&
//	then
//	ll_new = dw_datos.insertrow(0) 
//	dw_datos.setitem(ll_new,"pm_valor",lc_pago)
//	dw_datos.setitem(ll_new,"pm_fecpa",ld_fant)
//	dw_datos.setitem(ll_new,"fp_codigo",'1')
//	dw_datos.setitem(ll_new,"if_codigo",'24')
//	dw_datos.SetItem(ll_new,"cn_codigo",'31')
//	end  if  
//next	


/***********************************/
dw_1.accepttext()
dw_datos.reset()
for i  =  1 to dw_1.RowCount()
    ls_check  = dw_1.GetItemString(i,"cp_movim_mp_contab")
   	If ls_check = 'A' &
	then
	lc_pago =  lc_pago + dw_1.GetItemdecimal(i,"abono")
    end if
next
/*Insertar valores por omision*/
ll_new = dw_datos.insertrow(0) 
dw_datos.setitem(ll_new,"pm_valor",lc_pago)
dw_datos.setitem(ll_new,"pm_fecpa",today())
//dw_datos.setitem(ll_new,"fp_codigo",'1')
//dw_datos.setitem(ll_new,"if_codigo",'24')
//dw_datos.SetItem(ll_new,"cn_codigo",'31')


end event

type dw_cruce from datawindow within w_pagos_a_proveedores
boolean visible = false
integer x = 2907
integer y = 1128
integer width = 146
integer height = 76
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_cpcruce"
borderstyle borderstyle = stylelowered!
end type

type dw_cpmovim from datawindow within w_pagos_a_proveedores
boolean visible = false
integer x = 2757
integer y = 1128
integer width = 137
integer height = 76
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_cpmovim"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_egreso from datawindow within w_pagos_a_proveedores
boolean visible = false
integer x = 2427
integer y = 1128
integer width = 210
integer height = 76
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_egreso_cheque_ds"
borderstyle borderstyle = stylelowered!
end type

type dw_cabcom from datawindow within w_pagos_a_proveedores
boolean visible = false
integer x = 3095
integer y = 1128
integer width = 215
integer height = 76
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_cab_comprobante"
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_pagos_a_proveedores
integer x = 599
integer y = 1812
integer width = 375
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contabilizar"
end type

event clicked;//if dw_detegre.visible = false &
//then
//   dw_detegre.visible = true
	if dw_detegre.rowcount()= 0 then
	/*Subir valores por default*/
	cb_default.triggerevent(clicked!)
	end if
//else
//dw_detegre.visible = false	
//end if
end event

type cb_default from commandbutton within w_pagos_a_proveedores
boolean visible = false
integer x = 942
integer y = 1128
integer width = 416
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;Setpointer(Hourglass!)
dw_egreso.reset()
dw_detegre.reset()
wf_load_default()
end event

type cb_5 from commandbutton within w_pagos_a_proveedores
boolean visible = false
integer x = 1358
integer y = 1128
integer width = 421
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copiar detcom"
end type

event clicked;/*****************************************************/
/* Generar el egreso en bancos y contabilizar el pago*/
/*****************************************************/
wf_egreso()
dw_cabcom.reset()
dw_detcom.reset()
wf_contabiliza()
end event

type dw_detegre from datawindow within w_pagos_a_proveedores
event ue_dwnkey pbm_dwnkey
integer x = 32
integer y = 1904
integer width = 4933
integer height = 552
integer taborder = 130
string title = "Contabilizaci$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_detalle_egreso"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event ue_dwnkey;if keyDown(KeyEscape!) then
	this.Visible = false
end if
end event

event rbuttondown;m_click_derecho NewMenu

window lw_parent, lw_frame
lw_frame=parent.parentWindow()

NewMenu = CREATE m_click_derecho
NewMenu.m_edicion.m_recuperar.visible = false
NewMenu.m_edicion.m_guardar.visible = false
NewMenu.m_edicion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

event editchanged;String ls_data
If dwo.name = "pl_codigo" &
Then
ls_data = data+'%'
idwc_ctas.SetFilter("pl_codigo like '"+ls_data+"' ")
idwc_ctas.Filter()
This.GetChild("pl_codigo",idwc_ctas)
End if 
Return 1
end event

type dw_detcom from datawindow within w_pagos_a_proveedores
boolean visible = false
integer x = 5
integer y = 1008
integer width = 3515
integer height = 448
integer taborder = 120
boolean titlebar = true
string dataobject = "d_det_comprobante"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_pagos_a_proveedores
integer x = 1737
integer y = 52
integer width = 210
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pagos_a_proveedores
integer x = 2322
integer y = 52
integer width = 178
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pagos_a_proveedores
integer x = 41
integer y = 1320
integer width = 448
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "Detalle de Pago"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_pagos_a_proveedores
integer x = 27
integer y = 160
integer width = 4942
integer height = 1132
integer taborder = 50
string dataobject = "d_autoriza_pago_proveedores"
boolean vscrollbar = true
end type

event itemchanged;Decimal lc_pago
If dwo.name = 'cp_movim_mp_contab'&
then
	if data  = 'N' &
	then
	lc_pago = 0
	else
	lc_pago = This.GetItemdecimal(row,"cp_movim_mp_saldo")
	end if
This.SetItem(row,"abono",lc_pago)
end if


end event

type st_4 from statictext within w_pagos_a_proveedores
integer x = 41
integer y = 1824
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "Contabilizaci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type


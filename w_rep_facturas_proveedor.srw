HA$PBExportHeader$w_rep_facturas_proveedor.srw
$PBExportComments$Detalle de facturas de proveedores y notas de debito y retenciones.Vale
forward
global type w_rep_facturas_proveedor from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_facturas_proveedor
end type
type st_2 from statictext within w_rep_facturas_proveedor
end type
type em_1 from editmask within w_rep_facturas_proveedor
end type
type em_2 from editmask within w_rep_facturas_proveedor
end type
type dw_cab from datawindow within w_rep_facturas_proveedor
end type
type cbx_1 from checkbox within w_rep_facturas_proveedor
end type
type cbx_2 from checkbox within w_rep_facturas_proveedor
end type
type st_3 from statictext within w_rep_facturas_proveedor
end type
type cbx_3 from checkbox within w_rep_facturas_proveedor
end type
type dw_cc from uo_dw_comprobante within w_rep_facturas_proveedor
end type
type cbx_4 from checkbox within w_rep_facturas_proveedor
end type
end forward

global type w_rep_facturas_proveedor from w_sheet_1_dw_rep
integer width = 4549
integer height = 1692
string title = "Facturas de Proveedor"
long backcolor = 79741120
st_1 st_1
st_2 st_2
em_1 em_1
em_2 em_2
dw_cab dw_cab
cbx_1 cbx_1
cbx_2 cbx_2
st_3 st_3
cbx_3 cbx_3
dw_cc dw_cc
cbx_4 cbx_4
end type
global w_rep_facturas_proveedor w_rep_facturas_proveedor

type variables
integer ii_index
end variables

forward prototypes
public function integer wf_asiento_resumen ()
end prototypes

public function integer wf_asiento_resumen ();Decimal{2}  v_mpvalor  ,&
v_mpvalret ,&
v_mpneto  ,&
v_mpnetoconiva ,&
v_mpnetosiniva ,&
v_mpnetoimport ,&
v_mpreten ,&     
v_mpretiva ,&
v_valprov ,&     
v_creditos ,&    
v_debitos     

Long   v_cpnumero,v_cpnumdoc,ll_new    
Date   ld_ini,ld_fin
String v_observacion = 'Compras mercader$$HEX1$$ed00$$ENDHEX$$a ';


ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_cab.reset()
dw_asiento.reset()
dw_asiento.visible = true

w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n...por favor espere...")
Setpointer(Hourglass!)
// Compras
 SELECT nvl(sum("CP_MOVIM"."MP_VALOR"),0), 
		  nvl(sum("CP_MOVIM"."MP_VALRET"),0),
		  nvl(sum("CP_MOVIM"."MP_VALOR") - sum("CP_MOVIM"."MP_VALRET"),0), 
		  nvl(sum("CP_MOVIM"."MP_RETEN"),0), 
		  nvl(sum("CP_MOVIM"."MP_RETIVA"),0),
		  nvl(sum("CP_MOVIM"."MP_VALOR") - (sum("CP_MOVIM"."MP_RETEN") + sum("CP_MOVIM"."MP_RETIVA")),0) 
 INTO  :v_mpvalor,:v_mpvalret,:v_mpneto,:v_mpreten,:v_mpretiva,:v_valprov  
 FROM "CP_MOVIM"      
 WHERE (( "CP_MOVIM"."TV_CODIGO" = '1' ) AND  
 ( "CP_MOVIM"."TV_TIPO" = 'C' ) AND  
 ( "CP_MOVIM"."EM_CODIGO" = '1' ) AND  
 ( "CP_MOVIM"."EC_CODIGO" = '3' ) AND 
 ( trunc("CP_MOVIM"."MP_FECHA") between :ld_ini and :ld_fin ));

// Solo compras con IVA
SELECT nvl(sum("CP_MOVIM"."MP_VALOR") - sum("CP_MOVIM"."MP_VALRET"),0)
INTO   :v_mpnetoconiva
FROM   "CP_MOVIM"
WHERE  (( "CP_MOVIM"."TV_CODIGO" = '1' ) AND  
				 ( "CP_MOVIM"."TV_TIPO" = 'C' ) AND  
				( "CP_MOVIM"."EM_CODIGO" = '1' ) AND  
				( "CP_MOVIM"."EC_CODIGO" = '3' ) AND 
				( "CP_MOVIM"."MP_VALRET" <> 0) AND
				( trunc("CP_MOVIM"."MP_FECHA")  between :ld_ini and :ld_fin));


// Solo compras sin IVA menos las importaciones
SELECT nvl(sum(y.mp_valor) - sum(y.mp_valret),0)
INTO :v_mpnetosiniva
FROM in_compra x,cp_movim y
WHERE x.em_codigo = y.em_codigo
AND x.ec_codigo = y.ec_codigo
AND x.co_rucsuc = y.su_codigo
AND x.co_numero = y.co_numero
AND x.pv_codigo = y.pv_codigo
AND ((y.tv_codigo = '1')
AND (y.tv_tipo = 'C')
AND (y.em_codigo = '1')
AND (y.su_codigo = '1')
AND (y.ec_codigo = '3')
AND (y.mp_valret = 0)
AND (x.fp_codigo not in (56,69,70,71))
AND (trunc(y.mp_fecha) between :ld_ini and :ld_fin));

// Solo  importaciones
SELECT nvl(sum(y.mp_valor) - sum(y.mp_valret),0)
INTO :v_mpnetoimport
FROM in_compra x,cp_movim y
WHERE x.em_codigo = y.em_codigo
AND x.ec_codigo = y.ec_codigo
AND x.co_rucsuc = y.su_codigo
AND x.co_numero = y.co_numero
AND x.pv_codigo = y.pv_codigo
AND ((y.tv_codigo = '1')
AND (y.tv_tipo = 'C')
AND (y.em_codigo = '1')
AND (y.su_codigo = '1')
AND (y.ec_codigo = '3')
AND (y.mp_valret = 0)
AND (x.fp_codigo in (56,69,70,71))
AND (trunc(y.mp_fecha)  between :ld_ini and :ld_fin));

//-Inicia creacion del asiento

// Determinar si el asiento est$$HEX2$$e1002000$$ENDHEX$$cuadrado.
v_debitos  =  v_mpnetoconiva + v_mpnetosiniva + v_mpnetoimport + v_mpvalret  
v_creditos =  v_mpreten + v_mpretiva + v_valprov 

  
// se inserta el detalle del asiento 
       IF v_mpnetoconiva <> 0 THEN
		  ll_new= dw_asiento.insertrow(0)	
		   dw_asiento.Object.em_codigo[ll_new] = '1'	
  		   dw_asiento.Object.su_codigo[ll_new] = '1'	
 		   dw_asiento.Object.ti_codigo[ll_new] = '3'	
		   dw_asiento.Object.cp_numero[ll_new] = 99999	
  		   dw_asiento.Object.pl_codigo[ll_new] = '1510501000'	
		   dw_asiento.Object.cs_codigo[ll_new] = '1'
   	        dw_asiento.Object.dt_secue[ll_new] = '1'	
  		   dw_asiento.Object.dt_signo[ll_new] = 'D'	
            dw_asiento.Object.dt_valor[ll_new] = v_mpnetoconiva
  		   dw_asiento.Object.dt_detalle[ll_new] = v_observacion+STRING(ld_ini,'dd-mm-yyyy')
       END IF 

       IF v_mpnetosiniva <> 0 THEN
 		   ll_new = dw_asiento.insertrow(0)	
		   dw_asiento.Object.em_codigo[ll_new] = '1'	
  		   dw_asiento.Object.su_codigo[ll_new] = '1'	
 		   dw_asiento.Object.ti_codigo[ll_new] = '3'	
		   dw_asiento.Object.cp_numero[ll_new] = 99999	
  		   dw_asiento.Object.pl_codigo[ll_new] = '1510501010'	
		   dw_asiento.Object.cs_codigo[ll_new] = '1'
   	        dw_asiento.Object.dt_secue[ll_new] = '1'	
  		   dw_asiento.Object.dt_signo[ll_new] = 'D'	
            dw_asiento.Object.dt_valor[ll_new] = v_mpnetosiniva
  		   dw_asiento.Object.dt_detalle[ll_new] = v_observacion+STRING(ld_ini,'dd-mm-yyyy')		  
        
       END IF 

       IF v_mpnetoimport <> 0 THEN
		   ll_new = dw_asiento.insertrow(0)	
		   dw_asiento.Object.em_codigo[ll_new] = '1'	
  		   dw_asiento.Object.su_codigo[ll_new] = '1'	
 		   dw_asiento.Object.ti_codigo[ll_new] = '3'	
		   dw_asiento.Object.cp_numero[ll_new] = 99999	
  		   dw_asiento.Object.pl_codigo[ll_new] = '1510501020'	
		   dw_asiento.Object.cs_codigo[ll_new] = '1'
   	        dw_asiento.Object.dt_secue[ll_new] = '1'	
  		   dw_asiento.Object.dt_signo[ll_new] = 'D'	
            dw_asiento.Object.dt_valor[ll_new] = v_mpnetoimport
  		   dw_asiento.Object.dt_detalle[ll_new] = v_observacion+STRING(ld_ini,'dd-mm-yyyy')		  
       END IF 

       IF v_mpvalret <> 0 THEN
		   ll_new = dw_asiento.insertrow(0)	
		   dw_asiento.Object.em_codigo[ll_new] = '1'	
  		   dw_asiento.Object.su_codigo[ll_new] = '1'	
 		   dw_asiento.Object.ti_codigo[ll_new] = '3'	
		   dw_asiento.Object.cp_numero[ll_new] = 99999	
  		   dw_asiento.Object.pl_codigo[ll_new] = '1610201012'	
		   dw_asiento.Object.cs_codigo[ll_new] = '1'
   	        dw_asiento.Object.dt_secue[ll_new] = '1'	
  		   dw_asiento.Object.dt_signo[ll_new] = 'D'	
            dw_asiento.Object.dt_valor[ll_new] = v_mpvalret
  		   dw_asiento.Object.dt_detalle[ll_new] = v_observacion+STRING(ld_ini,'dd-mm-yyyy')		 
					
       END IF 

       IF v_mpreten <> 0 THEN
		   ll_new = dw_asiento.insertrow(0)	
		   dw_asiento.Object.em_codigo[ll_new] = '1'	
  		   dw_asiento.Object.su_codigo[ll_new] = '1'	
 		   dw_asiento.Object.ti_codigo[ll_new] = '3'	
		   dw_asiento.Object.cp_numero[ll_new] = 99999	
  		   dw_asiento.Object.pl_codigo[ll_new] = '2310101001'	
		   dw_asiento.Object.cs_codigo[ll_new] = '4'
   	        dw_asiento.Object.dt_secue[ll_new] = '1'	
  		   dw_asiento.Object.dt_signo[ll_new] = 'C'	
            dw_asiento.Object.dt_valor[ll_new] = v_mpreten
  		   dw_asiento.Object.dt_detalle[ll_new] = v_observacion+STRING(ld_ini,'dd-mm-yyyy')	
	  END IF
         
       IF v_mpretiva <> 0 THEN
		  ll_new = dw_asiento.insertrow(0)	
		   dw_asiento.Object.em_codigo[ll_new] = '1'	
  		   dw_asiento.Object.su_codigo[ll_new] = '1'	
 		   dw_asiento.Object.ti_codigo[ll_new] = '3'	
		   dw_asiento.Object.cp_numero[ll_new] = 99999	
  		   dw_asiento.Object.pl_codigo[ll_new] = '2310103012'	
		   dw_asiento.Object.cs_codigo[ll_new] = '4'
   	        dw_asiento.Object.dt_secue[ll_new] = '1'	
  		   dw_asiento.Object.dt_signo[ll_new] = 'C'	
            dw_asiento.Object.dt_valor[ll_new] = v_mpretiva
  		   dw_asiento.Object.dt_detalle[ll_new] = v_observacion+STRING(ld_ini,'dd-mm-yyyy')		
        
       END IF
       
       IF v_mpnetoimport <> 0 THEN
		   ll_new = dw_asiento.insertrow(0)	
		   dw_asiento.Object.em_codigo[ll_new] = '1'	
  		   dw_asiento.Object.su_codigo[ll_new] = '1'	
 		   dw_asiento.Object.ti_codigo[ll_new] = '3'	
		   dw_asiento.Object.cp_numero[ll_new] = 99999	
  		   dw_asiento.Object.pl_codigo[ll_new] = '2200101000'	
		   dw_asiento.Object.cs_codigo[ll_new] = '1'
   	        dw_asiento.Object.dt_secue[ll_new] = '1'	
  		   dw_asiento.Object.dt_signo[ll_new] = 'C'	
            dw_asiento.Object.dt_valor[ll_new] = v_mpnetoimport
  		   dw_asiento.Object.dt_detalle[ll_new] = v_observacion+STRING(ld_ini,'dd-mm-yyyy')		
		           
       END IF
            
       v_valprov = v_valprov - v_mpnetoimport;
       IF  v_valprov <> 0 THEN 
		   ll_new = dw_asiento.insertrow(0)	
		   dw_asiento.Object.em_codigo[ll_new] = '1'	
  		   dw_asiento.Object.su_codigo[ll_new] = '1'	
 		   dw_asiento.Object.ti_codigo[ll_new] = '3'	
		   dw_asiento.Object.cp_numero[ll_new] = 99999	
  		   dw_asiento.Object.pl_codigo[ll_new] = '2210102000'	
		   dw_asiento.Object.cs_codigo[ll_new] = '1'
   	        dw_asiento.Object.dt_secue[ll_new] = '1'	
  		   dw_asiento.Object.dt_signo[ll_new] = 'C'	
            dw_asiento.Object.dt_valor[ll_new] = v_valprov
  		   dw_asiento.Object.dt_detalle[ll_new] = v_observacion+string(ld_ini,'dd-mm-yyyy')		
	   END IF
Setpointer(Arrow!)     
w_marco.SetMicrohelp("Listo...")
RETURN 1


end function

on w_rep_facturas_proveedor.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.em_1=create em_1
this.em_2=create em_2
this.dw_cab=create dw_cab
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.st_3=create st_3
this.cbx_3=create cbx_3
this.dw_cc=create dw_cc
this.cbx_4=create cbx_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.dw_cab
this.Control[iCurrent+6]=this.cbx_1
this.Control[iCurrent+7]=this.cbx_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.cbx_3
this.Control[iCurrent+10]=this.dw_cc
this.Control[iCurrent+11]=this.cbx_4
end on

on w_rep_facturas_proveedor.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.dw_cab)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.st_3)
destroy(this.cbx_3)
destroy(this.dw_cc)
destroy(this.cbx_4)
end on

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_datos.resize(li_width - 80,li_height -300)
this.setRedraw(True)
end event

event open;this.ib_notautoretrieve = True
call super::open
this.ib_inReportMode = True
dw_cab.settransObject(sqlca)
dw_asiento.settransObject(sqlca)
f_recupera_empresa(dw_asiento,"ti_codigo")
f_recupera_empresa(dw_asiento,"pl_codigo")
f_recupera_empresa(dw_asiento,"pl_codigo_1")
f_recupera_empresa(dw_asiento,"cs_codigo")

end event

event closequery;return 
end event

event ue_retrieve;datawindowchild dwc_prov,dwc_sucur
Date ld_fini,ld_ffin
DateTime ldt_ini,ldt_fin
integer li_tipofactura
String  ls_tipo,ls_filtro


ld_fini = Date(em_1.text)
ld_ffin = Date(em_2.text)

ldt_ini = Datetime(ld_fini)
ldt_fin = Datetime(ld_ffin)



Setpointer(hourglass!)

	if cbx_1.checked then
           li_tipofactura = 1
           dw_datos.DataObject = 'd_rep_compras_en_cxp'
    elseif cbx_2.checked then
		 li_tipofactura = 0
		 dw_datos.DataObject = 'd_rep_compras_en_cxp'
     elseif cbx_3.checked then
		dw_datos.DataObject = 'd_ult_compras'
     elseif cbx_4.checked then
		dw_datos.DataObject = 'd_rep_reoc_resumen'
     end if	
	

dw_datos.SetTransObject(sqlca)

dw_datos.GetChild("pv_codigo",dwc_prov)
//dwc_sucur.SetTransObject(sqlca)
//dwc_sucur.retrieve(str_appgeninfo.empresa)
dwc_prov.SetTransObject(sqlca)
dwc_prov.retrieve(str_appgeninfo.empresa)


dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.Retrieve(str_appgeninfo.empresa,li_tipofactura,ldt_ini,ldt_fin)
dw_datos.modify("datawindow.print.preview =yes")

Setpointer(arrow!)

end event

event ue_contabilizar;call super::ue_contabilizar;long ll_reg
int i
string  ls_param
Dec{2}lc_base0,lc_basegrav,lc_basenograv,lc_baseimp, lc_neto,lc_iva,lc_retfte
Date   ld_ini,ld_fin
String v_observacion 


ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n...por favor espere...")
Setpointer(Hourglass!)

// Compras de mercader$$HEX1$$ed00$$ENDHEX$$a
SELECT SUM ("CP_PAGO"."PM_BASE0"),
		   SUM ("CP_PAGO"."PM_BASEGRAV"),
	       SUM ("CP_PAGO"."PM_BASENOGRAV"),
		   SUM ("CP_PAGO"."PM_BASEGRAV"*"CP_PAGO"."PM_CODPCTIVA") IVA,
		   SUM ("CP_PAGO"."PM_BSEIMP") BASEIMP,
		   SUM ("CP_PAGO"."PM_VALOR") VALRET
INTO   :lc_base0,:lc_basegrav,:lc_basenograv,:lc_iva,:lc_baseimp,:lc_retfte
FROM "CP_CRUCE",
		"CP_PAGO" ,
		"CP_MOVIM",
		"IN_PROVE"
WHERE ("CP_MOVIM"."PV_CODIGO" = "IN_PROVE"."PV_CODIGO")and 
		  ( "CP_CRUCE"."TV_TIPO"      = "CP_MOVIM"."TV_TIPO" ) and  
		  ( "CP_CRUCE"."EM_CODIGO" = "CP_MOVIM"."EM_CODIGO" ) and  
		  ( "CP_CRUCE"."SU_CODIGO" = "CP_MOVIM"."SU_CODIGO" ) and  
		  ( "CP_CRUCE"."MP_CODIGO" = "CP_MOVIM"."MP_CODIGO" ) and  
		  ( "CP_PAGO"."TV_CODIGO"   = "CP_CRUCE"."TV_CODDEB" ) and  
		  ( "CP_PAGO"."TV_TIPO"        = "CP_CRUCE"."TV_TIPODEB" ) and  
		  ( "CP_PAGO"."MP_CODIGO"   = "CP_CRUCE"."MP_CODDEB" ) and  
		  ( "CP_PAGO"."EM_CODIGO"   = "CP_CRUCE"."EM_CODIGO" ) and  
		  ( "CP_PAGO"."SU_CODIGO"    = "CP_CRUCE"."SU_CODIGO" ) and  
		  ( ("CP_MOVIM"."EM_CODIGO" = :str_appgeninfo.empresa) and
		  ( "CP_PAGO"."FP_CODIGO" in ('6') ) and 
		  ("CP_MOVIM"."CO_NUMERO" is not null) and
		  ( TRUNC("CP_MOVIM"."MP_FECHA") BETWEEN :ld_ini and :ld_fin)) ;

//Inicia creaci$$HEX1$$f200$$ENDHEX$$n del asiento de compras de mercader$$HEX1$$ec00$$ENDHEX$$a
dw_cc.visible = true
f_load_plantilla('SIS_COMPRA_MER',dw_cc)

dw_cc.object.fecha[1] = ld_ini
dw_cc.object.ti_codigo[1] = '3'

for i = 1 to dw_cc.rowcount()
ls_param = dw_cc.Object.param[i]

choose case ls_param
	case 'M_TOT'
	dw_cc.object.dt_valor[i] = (lc_baseimp + lc_iva) - lc_retfte
    case 'M_IVA'
	dw_cc.object.dt_valor[i] = lc_iva	
	case 'M_NETO'
     //suma de todas las bases
	dw_cc.object.dt_valor[i] = lc_baseimp
    case 'M_RFT'	
	dw_cc.object.dt_valor[i] = lc_retfte	
end choose

next


/**/
//If cbx_2.checked then
//	
//	
//f_load_plantilla('SIS_COMPRA_SERV',dw_cc)
//
//
//	
//DECLARE C1 CURSOR C1 FOR
//
//SELECT PM_CODPCT,CC_RETEN.PL_CODIGO,SUM(PM_BASE0),SUM(PM_BASEGRAV),SUM(PM_BASENOGRAV),SUM(PM_VALOR)
//FROM CP_PAGO , CC_RETEN 
//WHERE CP_PAGO.PM_CODPCT = CC_RETEN.RF_TIPO
//AND TRUNC(PM_FECHA) BETWEEN '01-DEC-2011' AND '31-DEC-2011'
//AND CP_PAGO.FP_CODIGO IN (6,7)
//GROUP BY PM_CODPCT,CC_RETEN.PL_CODIGO
//ORDER BY PM_CODPCT;
//open c1;
//
//do while true
//	
//	fetch  c1 into :ls_cerucic,:ls_fp,:lc_valretenido;
//	if sqlca.sqlcode <> 0 then exit
//    if ls_fp = '6' then 
//		update AN_VENTAS
//		SET valorRetRenta = :lc_valretenido
//		WHERE IDCLIENTE = :ls_cerucic; 
//   else
//		update AN_VENTAS
//		SET valorRetIva = :lc_valretenido
//		WHERE IDCLIENTE = :ls_cerucic;
//   end if
//loop
//close c1;
//
///*Recorer plantilla*/
//for i = 1 to dw_cc.rowcount()
//ls_param = dw_cc.Object.param[i]
//
////choose case ls_param
////	case 'S_TOT'
////	dw_cc.object.dt_valor[i] = (lc_baseimp + lc_iva) - lc_retfte
////    case 'S_IVA'
////	dw_cc.object.dt_valor[i] = lc_iva	
////	case 'S_NETO'
////     //suma de todas las bases
////	dw_cc.object.dt_valor[i] = lc_baseimp
////    case 'S_RFT332'	
////	dw_cc.object.dt_valor[i] = lc_retfte
////    case 'S_RFT312'
////    case 'S_	
////end choose
//
//next
//end if
Setpointer(Arrow!)     
w_marco.SetMicrohelp("Listo...")
RETURN 1

 
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_facturas_proveedor
integer x = 27
integer y = 220
integer width = 4453
integer height = 1336
integer taborder = 100
string dataobject = "d_rep_compras_en_cxp"
boolean hsplitscroll = true
boolean livescroll = false
end type

event dw_datos::retrieveend;///*Modificar los campos de las sumas*/
//String ls_credito
//long i,ll_conumero
//Decimal lc_valor,lc_iva,lc_neto,lc_reten,lc_nulo
//
//dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
//										"datawindow.print.preview=yes")
//
//Setnull(lc_nulo)
//SetPointer(Hourglass!)
//For i = 1 to rowcount
//         ls_credito  =   dw_datos.getItemString(i,"credito")
//         ll_conumero =   dw_datos.getItemnumber(i,"co_numero")
//			
////			select d1.mp_valor,d1.mp_valret
////			into :lc_valor,:lc_iva
////			from cp_movim c,
////				  cp_movim d1,cp_pago p,cp_cruce r
////			where c.em_codigo = r.em_codigo
////			and c.su_codigo = r.su_codigo
////			and c.mp_codigo = r.mp_codigo
////			and c.tv_codigo = r.tv_codigo
////			and c.tv_tipo   = r.tv_tipo
////			
////			and d1.em_codigo = p.em_codigo
////			and d1.su_codigo = p.su_codigo
////			and d1.mp_codigo = p.mp_codigo
////			and d1.tv_codigo = p.tv_codigo
////			and d1.tv_tipo = p.tv_tipo
////			
////			and r.em_codigo  = p.em_codigo
////			and r.su_codigo  = p.su_codigo
////			and r.mp_coddeb  = p.mp_codigo
////			and r.tv_coddeb  = p.tv_codigo
////			and r.tv_tipodeb = p.tv_tipo
////			
////			and c.em_codigo = d1.em_codigo 
////			and c.su_codigo = d1.su_codigo 
////			and c.co_numero = d1.co_numero 
////			and c.co_facpro = d1.co_facpro 
////			
////			and r.em_codigo = :str_appgeninfo.empresa
////			and r.su_codigo = :str_appgeninfo.sucursal
////			and r.tv_tipo = 'C'
////			and r.mp_codigo = :ls_credito
////			
////			and p.em_codigo = '1'
////			and p.su_codigo = '1'
////			and p.tv_tipo = 'D'
////			and p.fp_codigo = '55';
//
//			SELECT "CP_CRUCE"."CX_VALCRE"   
//			INTO :lc_valor
//			FROM "CP_CRUCE","CP_PAGO"  
//			WHERE ( "CP_CRUCE"."TV_CODDEB" = "CP_PAGO"."TV_CODIGO" ) AND  
//			( "CP_CRUCE"."TV_TIPODEB" = "CP_PAGO"."TV_TIPO" ) AND  
//			( "CP_CRUCE"."MP_CODDEB" = "CP_PAGO"."MP_CODIGO" ) AND
//			( "CP_CRUCE"."EM_CODIGO" = "CP_PAGO"."EM_CODIGO" ) AND
//			( "CP_CRUCE"."SU_CODIGO" = "CP_PAGO"."SU_CODIGO" ) AND
//			( ( "CP_CRUCE"."TV_CODIGO" = '1' ) AND  
//			( "CP_CRUCE"."TV_TIPO" = 'C' ) AND  
//			( "CP_CRUCE"."MP_CODIGO" = :ls_credito ) AND
//			( "CP_PAGO"."FP_CODIGO"  = '55')) ;
//
//
//											
//	      If sqlca.sqlcode = 0 &
//		   then
//			dw_datos.setitem(i,"cc_valornd",lc_valor)
//			dw_datos.setitem(i,"cc_ivand",lc_valor*.12)
//			else
//			dw_datos.setitem(i,"cc_valornd",lc_nulo)
//			dw_datos.setitem(i,"cc_ivand",lc_nulo)
//			end if
//
//			SELECT "CP_PAGO"."PM_VALOR"  
//			INTO :lc_reten
//			FROM "CP_CRUCE", "CP_PAGO"  
//			WHERE ( "CP_CRUCE"."TV_CODDEB" = "CP_PAGO"."TV_CODIGO" ) and  
//			( "CP_CRUCE"."TV_TIPODEB" = "CP_PAGO"."TV_TIPO" ) and  
//			( "CP_CRUCE"."MP_CODDEB" = "CP_PAGO"."MP_CODIGO" ) and  
//			( "CP_CRUCE"."EM_CODIGO" = "CP_PAGO"."EM_CODIGO" ) and  
//			( "CP_CRUCE"."SU_CODIGO" = "CP_PAGO"."SU_CODIGO" ) and  
//			( ( "CP_CRUCE"."TV_CODIGO" = '1' ) AND  
//			( "CP_CRUCE"."TV_TIPO" = 'C' ) AND  
//			( "CP_CRUCE"."MP_CODIGO" = :ls_credito ) AND  
//			( "CP_PAGO"."FP_CODIGO" = '6' ) )    ;
//	     If sqlca.sqlcode = 0 &
//		  then
// 		  dw_datos.setitem(i,"cc_reten",lc_reten)
//	     else
//		  dw_datos.setitem(i,"cc_reten",lc_nulo)	
//	     end if
//Next	
//Setpointer(Arrow!)
//
//String ls_title
//
//ls_title = dw_datos.Object.t_16.text
//if cbx_1.checked then
//
//		ls_title = dw_datos.Object.t_16.text
//		ls_title = ls_title +' '+'(Mercader$$HEX1$$ed00$$ENDHEX$$a)'
//		dw_datos.modify("t_16.text = '"+ls_title+"'")
//	elseif cbx_2.checked  then
//         
//		ls_title = ls_title +' '+'(Bienes/Servicios)'
//		dw_datos.modify("t_16.text = '"+ls_title+"'")
//	end if

end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_facturas_proveedor
integer x = 64
integer y = 720
integer taborder = 90
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_facturas_proveedor
integer x = 23
integer y = 8
integer width = 1851
integer height = 704
integer taborder = 40
boolean titlebar = true
string title = "Asiento"
string dataobject = "d_aux_detallecomprobante"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
end type

event dw_asiento::buttonclicked;call super::buttonclicked;/*Listo*/
Decimal{2} lc_creditos,lc_debitos
Long ll_cpnumero,ll_sectipo,ll_cont
Integer i,li_rc
String  ls_sectipo,ls_sigla,&
           ls_tipo = '3'
Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

Setpointer(Hourglass!)
If dwo.name = 'b_1' then

If this.rowcount() <= 0 then return -1

/*Validar que no haya sido contabilizado*/

SELECT count(*)
into :ll_cont
FROM IN_COMPRA
WHERE EC_CODIGO = 3
AND EM_CODIGO = 1
AND CO_CONTAB = 'S'
AND TRUNC(CO_FECHA) between :ld_ini and :ld_fin;

if ll_cont > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las facturas de estas fechas ya han sido contabilizadas...<por favor verifique>")
	return -1
end if	

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
ll_sectipo     = f_secuencial(str_appgeninfo.empresa,'DCO')
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
			
		
		//Marcar las compras como Contabilizadas
		UPDATE IN_COMPRA
		SET CO_CONTAB = 'S', CP_NUMERO =  :ll_cpnumero
		WHERE EC_CODIGO = 3
		AND EM_CODIGO = :str_appgeninfo.empresa
		AND CO_RUCSUC = :str_appgeninfo.sucursal
		AND TRUNC(CO_FECHA) between :ld_ini and :ld_fin;
		
		If sqlca.sqlcode < 0 Then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar la compra"+sqlca.sqlerrtext)
		Rollback;
		return -1
		End if
		
		  
         UPDATE CP_MOVIM
         SET MP_CONTAB = 'S', CP_NUMERO =  :ll_cpnumero
         WHERE TV_CODIGO = 1
         AND TV_TIPO = 'C'
         AND EC_CODIGO = 3
         AND EM_CODIGO = :str_appgeninfo.empresa
         AND SU_CODIGO = :str_appgeninfo.sucursal
         AND TRUNC(MP_FECHA) between :ld_ini and :ld_fin;

		If sqlca.sqlcode < 0 Then	
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los cr$$HEX1$$e900$$ENDHEX$$ditos"+sqlca.sqlerrtext)
		rollback;
		return
		End if 
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

type st_1 from statictext within w_rep_facturas_proveedor
integer x = 55
integer y = 116
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
string text = "desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_facturas_proveedor
integer x = 699
integer y = 120
integer width = 174
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
string text = "hasta:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_rep_facturas_proveedor
integer x = 247
integer y = 104
integer width = 343
integer height = 84
integer taborder = 10
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

type em_2 from editmask within w_rep_facturas_proveedor
integer x = 878
integer y = 104
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

type dw_cab from datawindow within w_rep_facturas_proveedor
boolean visible = false
integer x = 3127
integer y = 28
integer width = 686
integer height = 184
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_aux_comprobante"
boolean border = false
boolean livescroll = true
end type

type cbx_1 from checkbox within w_rep_facturas_proveedor
integer x = 1431
integer y = 44
integer width = 375
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mercader$$HEX1$$ed00$$ENDHEX$$a"
boolean checked = true
end type

event clicked;cbx_2.checked = false
cbx_3.checked = false
end event

type cbx_2 from checkbox within w_rep_facturas_proveedor
integer x = 1431
integer y = 120
integer width = 457
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bienes/Servicios"
end type

event clicked;cbx_1.checked = false
cbx_3.checked = false
end event

type st_3 from statictext within w_rep_facturas_proveedor
integer x = 55
integer y = 36
integer width = 1166
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingrese el per$$HEX1$$ed00$$ENDHEX$$odo de Ingreso de las compras"
boolean focusrectangle = false
end type

type cbx_3 from checkbox within w_rep_facturas_proveedor
integer x = 2158
integer y = 44
integer width = 1344
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
string text = "Detalle de compras agrupadas por  codigo de retenci$$HEX1$$f300$$ENDHEX$$n"
end type

event clicked;cbx_1.checked = false
cbx_2.checked = false
end event

type dw_cc from uo_dw_comprobante within w_rep_facturas_proveedor
boolean visible = false
integer x = 658
integer y = 216
integer width = 4626
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = "Comprobante contable"
boolean controlmenu = true
end type

event updateend;call super::updateend;Long ll_cpnumero
Date   ld_ini,ld_fin



ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

ll_cpnumero = this.object.cp_numero[1]
//Marcar las compras como Contabilizadas
		UPDATE IN_COMPRA
		SET CO_CONTAB = 'S', CP_NUMERO =  :ll_cpnumero
		WHERE EC_CODIGO = 3
		AND EM_CODIGO = :str_appgeninfo.empresa
		AND CO_RUCSUC = :str_appgeninfo.sucursal
		AND TRUNC(CO_FECHA) between :ld_ini and :ld_fin;
		
		If sqlca.sqlcode < 0 Then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar la compra"+sqlca.sqlerrtext)
		Rollback;
		return -1
		End if
		
		  
         UPDATE CP_MOVIM
         SET MP_CONTAB = 'S', CP_NUMERO =  :ll_cpnumero
         WHERE TV_CODIGO = 1
         AND TV_TIPO = 'C'
         AND EC_CODIGO = 3
         AND EM_CODIGO = :str_appgeninfo.empresa
         AND SU_CODIGO = :str_appgeninfo.sucursal
         AND TRUNC(MP_FECHA) between :ld_ini and :ld_fin;

		If sqlca.sqlcode < 0 Then	
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los cr$$HEX1$$e900$$ENDHEX$$ditos"+sqlca.sqlerrtext)
		rollback;
		return
		End if 
		commit;
		w_marco.Setmicrohelp("Asiento contable creado exitosamente....<Por favor verifique asiento N$$HEX1$$ba00$$ENDHEX$$:"+String(ll_cpnumero)+">")
		
end event

type cbx_4 from checkbox within w_rep_facturas_proveedor
integer x = 2158
integer y = 120
integer width = 1326
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
string text = "Resumen Agrupado por Codigo de retenci$$HEX1$$f300$$ENDHEX$$n"
end type


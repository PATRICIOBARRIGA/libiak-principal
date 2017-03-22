HA$PBExportHeader$w_saldos.srw
forward
global type w_saldos from window
end type
type cb_2 from commandbutton within w_saldos
end type
type cb_1 from commandbutton within w_saldos
end type
end forward

global type w_saldos from window
integer width = 3465
integer height = 1924
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
end type
global w_saldos w_saldos

on w_saldos.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.cb_1}
end on

on w_saldos.destroy
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_saldos
integer x = 800
integer y = 404
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CLIENTES"
end type

event clicked;String     ls_nro,ls_ce,ls_sec,ls_nombre,ls_calle1,ls_calle2,ls_ruc,ls_fono,ls_contacto,ls_ep
decimal   lc_val,lc_sal
datetime ld_fec,ld_ven
long        ll_sec,li

DECLARE C1 CURSOR  FOR

//SELECT NOMBRE,CALLE1,CALLE2,CONTACT,substr(FONO,1,9),REPLACE(RUCIC,'-'),DECODE(VENDEDOR,'FRAVEL',6,'JUANCV',8,'ANDRESV',7,'VOFICINA',1,'ANDRES',5,'JUDY',3,'JUANC',2,'GEOVAN',4,1)
//FROM   DINAMIC.TMP_CLINEW
//WHERE REPLACE(RUCIC,'-') IN (SELECT REPLACE(RUCIC,'-')
//										FROM   DINAMIC.TMP_CLINEW
//										MINUS
//										SELECT CE_RUCIC
//										FROM FA_CLIEN);


//CLIENTES SIN RUC
//SELECT NOMBRE,CALLE1,CALLE2,CONTACT,substr(FONO,1,9),REPLACE(RUCIC,'-'),DECODE(VENDEDOR,'FRAVEL',6,'JUANCV',8,'ANDRESV',7,'VOFICINA',1,'ANDRES',5,'JUDY',3,'JUANC',2,'GEOVAN',4,1)
//FROM   DINAMIC.TMP_CLINEW
//WHERE REPLACE(RUCIC,'-') IN (SELECT REPLACE(RUCIC,'-')
//										FROM   DINAMIC.TMP_CLINEW
//										MINUS
//										SELECT CE_RUCIC
//										FROM FA_CLIEN);



//SELECT F.CODEMPRE CLI
//FROM   TMP_FACTURAS F
//WHERE NRO_FACT IN (SELECT NRO_FACT FROM TMP_FACTURAS
//                                  MINUS 
//                                  SELECT MT_PREIMP  FROM CC_MOVIM X WHERE X.TT_CODIGO = '8')
//MINUS 
//SELECT CE_RUCIC
//FROM FA_CLIEN;
//

//SELECT NOMBRE,CALLE1,CALLE2,CONTACT,substr(FONO,1,9),REPLACE(RUCIC,'-'),DECODE(VENDEDOR,'FRAVEL',6,'JUANCV',8,'ANDRESV',7,'VOFICINA',1,'ANDRES',5,'JUDY',3,'JUANC',2,'GEOVAN',4,1)
//FROM   DINAMIC.TMP_CLINEW 
//WHERE CODEMPRE IN (
//								SELECT  F.CODEMPRE CLI
//								FROM   DINAMIC.TMP_FACTURAS F
//								WHERE NRO_FACT IN (SELECT NRO_FACT FROM DINAMIC.TMP_FACTURAS
//															 MINUS 
//															 SELECT MT_PREIMP  FROM CC_MOVIM X WHERE X.TT_CODIGO = '8')
//								MINUS
//								SELECT REPLACE(CE_RUCIC,'-')
//								FROM FA_CLIEN);


SELECT NOMBRE,CALLE1,CALLE2,CONTACT,substr(FONO,1,9),REPLACE(RUCIC,'-'),DECODE(VENDEDOR,'FRAVEL',6,'JUANCV',8,'ANDRESV',7,'VOFICINA',1,'ANDRES',5,'JUDY',3,'JUANC',2,'GEOVAN',4,1)
FROM   DINAMIC.TMP_CLINEW 
WHERE CODEMPRE IN (
SELECT CODEMPRE FROM DINAMIC.TMP_FACTURAS
WHERE NRO_FACT IN(
							 SELECT F.NRO_FACT
							 FROM DINAMIC.TMP_FACTURAS F, DINAMIC.TMP_CLINEW C
							 WHERE C.CODEMPRE = F.CODEMPRE
							 MINUS 
                                SELECT MT_PREIMP  FROM CC_MOVIM X WHERE X.TT_CODIGO = '8')
MINUS
SELECT REPLACE(CE_RUCIC,'-')
FROM FA_CLIEN);

OPEN C1;
ll_sec = 1346

	FETCH C1 INTO :ls_nombre, :ls_calle1,:ls_calle2,:ls_contacto,:ls_fono,:ls_ruc,:ls_ep;
	DO WHILE SQLCA.sqlcode = 0
         
		 SELECT count(*)
		 INTO   :li
		 FROM FA_CLIEN
		 WHERE CE_RUCIC = :ls_ruc;
		        
				  
		 If li =  0 then
				  
			 INSERT INTO FA_CLIEN (CE_CODIGO,CA_CODIGO,PA_CODIGO,CU_CODIGO,EP_CODIGO,EM_CODIGO,CE_RUCIC,CE_CAOFI1,CE_CAOF2,CE_TELOFI,CE_RAZONS,CE_ACTIVO,CE_CAMBVEN,CE_FACTURAR,TC_CODIGO,CE_EXIVA,CE_ESTCRE,CE_ACTIVIDAD,CE_CUPCRE)
			 VALUES(:ll_sec,'1',593,1,:ls_ep,'1',:ls_ruc,:ls_calle1,:ls_calle2,:ls_fono,:ls_nombre,'S','S','S','STD','N','A',2,1000);		
			 IF SQLCA.SQLCODE <> 0 THEN
					Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar ..."+ls_ruc+' '+sqlca.sqlerrtext)
					Rollback;
					Return 
			End IF
  	         ll_sec  = ll_sec +  1
     	
	     End if
	     
		 FETCH C1 INTO  :ls_nombre, :ls_calle1,:ls_calle2,:ls_contacto,:ls_fono,:ls_ruc,:ls_ep;
    LOOP
CLOSE C1;
	

COMMIT;	
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo")

  INSERT INTO "TMP_CLINEW"  
         ( "CODEMPRE",   
           "NOMBRE",   
           "CALLE1",   
           "CALLE2",   
           "CONTACT",   
           "FONO",   
           "RUCIC",   
           "VENDEDOR",   
           "ID" )  
  VALUES ( <not specified>,   
           <not specified>,   
           <not specified>,   
           <not specified>,   
           <not specified>,   
           <not specified>,   
           <not specified>,   
           <not specified>,   
           <not specified> )  ;



end event

type cb_1 from commandbutton within w_saldos
integer x = 800
integer y = 288
integer width = 343
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SALDOS"
end type

event clicked;string     ls_nro,ls_ce,ls_sec,LS_RUC
decimal   lc_val,lc_sal
datetime ld_fec,ld_ven
long        ll_sec



String   ls_tt,ls_ioe,ls_em,ls_su,ls_ep,ls_bo,ls_mt,ls_ve
//Messagebox("","Entro")

DECLARE C1 CURSOR  FOR


//SELECT F.NRO_FACT NRO,
//			F.VALOR_FACTURA VAL,  
//			F.FECHA_EMISION FEC,
//			F.SALDO SAL,
//			F.FECHA_VEN VEN,
//			Z.CE_CODIGO CE
//FROM   DINAMIC.TMP_CLIENTES C, DINAMIC.TMP_FACTURAS F , FA_CLIEN Z
//WHERE  C.CODANTERIOR = F.CODEMPRE
//AND      C.RUC  = Z.CE_RUCIC;

//SELECT  F.NRO_FACT NRO,
//			F.VALOR_FACTURA VAL,  
//			F.FECHA_EMISION FEC,
//			F.SALDO SAL,
//			F.FECHA_VEN VEN,
//			F.CODEMPRE CLI
//FROM   DINAMIC.TMP_FACTURAS F
//WHERE NRO_FACT IN (SELECT NRO_FACT FROM DINAMIC.TMP_FACTURAS
//                                  MINUS 
//                                  SELECT MT_PREIMP  FROM CC_MOVIM X WHERE X.TT_CODIGO = '8')
//ORDER BY F.CODEMPRE ;



SELECT TT_CODIGO,TT_IOE,EM_CODIGO,SU_CODIGO,MT_CODIGO,CE_CODIGO,BO_CODIGO,VE_NUMERO,ESTADO
FROM DINAMIC.TMP_SALDOS
ORDER BY ESTADO;





ll_sec = 3014

OPEN C1;
//	FETCH C1 INTO :ls_nro, :lc_val,:ld_fec,:lc_sal,:ld_ven,:ls_ce;
	FETCH C1 INTO :ls_tt,:ls_ioe,:ls_em,:ls_su,:ls_mt,:ls_ce,:ls_bo,:ls_ve,:ls_ep;
	DO WHILE SQLCA.sqlcode = 0
	    
         ls_sec = string(ll_sec)
			
		UPDATE CC_MOVIM
		SET      MT_CTACLI   = :ls_ep
		WHERE EM_CODIGO  = :ls_em
		AND     SU_CODIGO   = :ls_su
		AND     BO_CODIGO   = :ls_bo
		AND     MT_CODIGO   = :ls_mt
		AND     TT_CODIGO   = :ls_tt
		AND     TT_IOE         = :ls_ioe;

//		FETCH C1 INTO :ls_nro, :lc_val,:ld_fec,:lc_sal,:ld_ven,:ls_ce;
	     FETCH C1 INTO :ls_tt,:ls_ioe,:ls_em,:ls_su,:ls_mt,:ls_ce,:ls_bo,:ls_ve,:ls_ep;
LOOP
CLOSE C1;
	

COMMIT;	
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo")




        //BUSCAR PRIMERO EN LA TABLA DE CLIENTES		
//		SELECT REPLACE(RUCIC,'-')
//		into      :ls_ruc
//		FROM   DINAMIC.TMP_CLINEW 
//		WHERE CODEMPRE = :ls_ce;
//				
//				
//				
//		SELECT CE_CODIGO
//		INTO    :ls_ce
//		FROM   FA_CLIEN
//		WHERE REPLACE(CE_RUCIC,'-')  = :ls_ruc;
//				
//				
//		IF  sqlca.sqlcode <> 100 THEN
//					Messagebox("si existe",ls_ce)
//					INSERT INTO CC_MOVIM (TT_CODIGO,
//													  TT_IOE,
//													  EM_CODIGO,SU_CODIGO,MT_CODIGO,
//													  CE_CODIGO,ES_CODIGO,BO_CODIGO,
//													  VE_NUMERO,MT_VALOR,MT_VALRET,
//													  MT_SALDO,MT_FECHA,MT_FECVEN,MT_PREIMP)
//					VALUES( '8',
//								 'D',
//								 '1','1',:ls_sec,
//								:ls_ce,'1','1',
//								:ls_nro,:lc_val,0,
//								:lc_sal,:ld_fec,:ld_ven,:ls_nro );
//							
//					 IF SQLCA.SQLCODE <> 0 THEN
//							Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertarLOS ..."+ls_ce+'-'+sqlca.sqlerrtext)
//							Rollback;
//							Return 
//					End IF
//				
//					 ll_sec  = ll_sec +  1
//					 
//		END IF
end event


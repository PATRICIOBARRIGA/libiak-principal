HA$PBExportHeader$w_in_iteemp.srw
forward
global type w_in_iteemp from window
end type
type cb_7 from commandbutton within w_in_iteemp
end type
type em_1 from editmask within w_in_iteemp
end type
type st_2 from statictext within w_in_iteemp
end type
type st_1 from statictext within w_in_iteemp
end type
type cb_9 from commandbutton within w_in_iteemp
end type
type cb_8 from commandbutton within w_in_iteemp
end type
type cb_6 from commandbutton within w_in_iteemp
end type
type cb_5 from commandbutton within w_in_iteemp
end type
type cb_4 from commandbutton within w_in_iteemp
end type
type cb_3 from commandbutton within w_in_iteemp
end type
type cb_2 from commandbutton within w_in_iteemp
end type
type cb_1 from commandbutton within w_in_iteemp
end type
type dw_1 from datawindow within w_in_iteemp
end type
end forward

global type w_in_iteemp from window
integer width = 3159
integer height = 1544
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_7 cb_7
em_1 em_1
st_2 st_2
st_1 st_1
cb_9 cb_9
cb_8 cb_8
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_in_iteemp w_in_iteemp

type variables
String is_mes,is_a$$HEX1$$f100$$ENDHEX$$o
end variables

event open;dw_1.settransObject(sqlca)

end event

on w_in_iteemp.create
this.cb_7=create cb_7
this.em_1=create em_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_7,&
this.em_1,&
this.st_2,&
this.st_1,&
this.cb_9,&
this.cb_8,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_in_iteemp.destroy
destroy(this.cb_7)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_7 from commandbutton within w_in_iteemp
integer x = 2473
integer y = 84
integer width = 571
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Load Stock Anual"
end type

event clicked;/*Todos el inventario:  d_in_item*/

Dec    lc_stock
String ls_pepa
Long ll_reg ,i

dw_1.retrieve()
ll_reg = dw_1.rowcount()

for i = 1 to  ll_reg
	ls_pepa = dw_1.Object.it_codigo[i]

//INSERT INTO "IN_ITEEMP"  
//         ( "EM_CODIGO",   
//           "IT_CODIGO",   
//           "IT_FECHA",   
//           "IT_STKINI",   
//           "IT_COSINI",   
//           "ESTADO" )  
//  VALUES ( '1',   
//           :ls_pepa,   
//           '01-jan-07',   
//           null,   
//           null,   
//           null )  ;

//--Para actualizar mensualmente
	SELECT SUM(NVL(DECODE(TM_IOE , 'I', MV_CANTID,MV_CANTID * -1),0))
	INTO :lc_stock
	FROM IN_MOVIM
	WHERE IT_CODIGO = :ls_pepa
	AND MV_FECHA < '01-JAN-07';
	
	IF isnull(lc_stock) then lc_stock = 0
				
	UPDATE IN_ITEEMP
	SET IT_STKINI = :lc_stock
	WHERE TRUNC(IT_FECHA) = '01-JAN-07'
	AND IT_CODIGO = :ls_pepa;
	
	IF SQLCA.SQLCODE <> 0 THEN
	MESSAGEBOX("","eRROR")
	rollback;
	return
	END IF

next 	

commit;
MESSAGEBOX("","Listo")

end event

type em_1 from editmask within w_in_iteemp
integer x = 2085
integer y = 80
integer width = 315
integer height = 76
integer taborder = 40
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
end type

type st_2 from statictext within w_in_iteemp
integer x = 2089
integer y = 156
integer width = 302
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "[dd/mm/yyyy]"
boolean focusrectangle = false
end type

type st_1 from statictext within w_in_iteemp
integer x = 1879
integer y = 88
integer width = 183
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo"
boolean focusrectangle = false
end type

type cb_9 from commandbutton within w_in_iteemp
integer x = 2459
integer y = 392
integer width = 567
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "1.1 Stock Inicial"
end type

event clicked;// Subir el stock inicial con el que inicia el mes que va a ser costeado
// Utiliza el  datawindow: d_items_no_KIT O d_items_para_costeo

String ls_item,ls_periodo,ls_dia,ls_mes,ls_anio
Long ll_nreg,i,ll_stkini,v_dif,ll_stock ,ll_mov,ll_ing,ll_egr
DataStore lds_stockacum

lds_stockacum = Create DataStore
lds_stockacum.DataObject ='d_stockacum' /*Lib: varios*/
lds_stockacum.SetTransObject(sqlca)


ls_periodo = em_1.text
ls_dia  =  mid(ls_periodo,1,2)
if ls_dia <> '01' then 
	Messagebox("Atencion","No es una fecha v$$HEX1$$e100$$ENDHEX$$lida")
	return
end if	
ls_anio = mid(ls_periodo,9,2)
ls_mes = mid(ls_periodo,4,2)


ll_nreg  = dw_1.retrieve(ls_mes+ls_anio)
//ll_nreg  = dw_1.retrieve() /*Para arreglar*/


/**/
for i = 1 to ll_nreg 
	
	ll_stkini = 0
	ll_stock = 0
	v_dif     = 0

     ls_item = dw_1.getitemstring(i,"it_codigo")
	w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' ") 
	
	/*Tomamos el stock inicial a enero del 2008*/
	/*Movimiento del a$$HEX1$$f100$$ENDHEX$$o anterior al mes que se costea*/
	select nvl(it_stkini,0)
	into     :ll_stkini
	from    IN_ITEEMP
	where it_codigo = :ls_item
	and      to_char(it_fecha,'mmyy') = '0106';
	
	if sqlca.sqlcode <> 0 then
     ll_stkini = 0
	end if	
	
	/*Sumamos los movimientos desde enero hasta el mes anterior al que se va a costear */
	 SELECT SUM(DECODE(TM_IOE,'I',MV_CANTID,'E',MV_CANTID * -1)) ING_EGR
      INTO    :v_dif
      FROM   IN_MOVIM
	 WHERE  EM_CODIGO = '1'
	 AND SU_CODIGO BETWEEN '1' AND '37'
	 AND IT_CODIGO = :ls_item
      AND MV_FECHA BETWEEN '01-jan-07' AND '01-dec-07';
//
//
//	if sqlca.sqlcode <> 0 then
//     v_dif  = 0
//	end if	

/*Comentar en el caso de que sea enero*/
//    if lds_stockacum.retrieve(ls_item,date('01-jan-07'),date('01-feb-07')) > 0 then
//	v_dif = lds_stockacum.Object.stockacum[1] 
//    else
//	v_dif  = 0	
//    end if
	 
	ll_stock = ll_stkini + v_dif

	/*Actualizar el stock inicial */
	UPDATE IN_ITEMOV
	SET IT_STKINI = :ll_stock
	WHERE IT_CODIGO =:ls_item
	AND TO_CHAR(IT_FECHA,'MMYY') = '1207';
	
	If sqlca.sqlcode <> 0 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el stock Inicial "+sqlca.sqlerrtext)
     rollback;
	return  
	end if	
    

next
COMMIT;

 w_marco.setmicrohelp(" Stock Inicial........ Listo!!! ") 
end event

type cb_8 from commandbutton within w_in_iteemp
integer x = 2459
integer y = 508
integer width = 567
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "1.- IN_COSTO"
end type

event clicked;/*Utiliza el datawindow :  d_items_no_kit  */
Long      ll_nreg,i
String    ls_item,&
            ls_periodo,ls_dia,ls_mes,ls_anio 
decimal lc_costoprom
Integer  li_stockini

ls_periodo = em_1.text
ls_dia  =  mid(ls_periodo,1,2)
if ls_dia <> '01' then 
	Messagebox("Atencion","No es una fecha v$$HEX1$$e100$$ENDHEX$$lida")
	return
end if	
ls_anio = mid(ls_periodo,9,2)
ls_mes = mid(ls_periodo,4,2)
ll_nreg  = dw_1.retrieve(ls_mes+ls_anio)

for i = 1 to ll_nreg
	 
	w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' ") 
	
	ls_item =  dw_1.getitemstring(i,"it_codigo")

   /*Tomar el costo promedio de las existencias del mes anterior al que se va a costear, no el costo promedio de venta
	cambiar ct_costprom x ct_costpromexist*/
    SELECT NVL(CT_COSTPROMEXIST,0)
    INTO   :lc_costoprom
    FROM DINAMIC.IN_COSTO
    WHERE EM_CODIGO = '1'
    AND SU_CODIGO = '90'
    AND  IT_CODIGO =:ls_item
    AND TO_CHAR(CT_FECHA,'MMYY') = '1107';

    if sqlca.sqlcode = 100 then
    lc_costoprom = 0
    end if		
    
    UPDATE IN_ITEMOV
    SET    IT_COSINI = :lc_costoprom,
		  OBSERVA = 'arrastra costo 1107'	 
	WHERE IT_CODIGO =:ls_item
    AND TO_CHAR(IT_FECHA,'MMYY') = '1207';
 
     if sqlca.sqlcode < 0 then
     messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Error")
	rollback;
	return
    end if		


next

commit;

w_marco.setmicrohelp("Procesando item: ' "+string(i - 1)+ "' de un total de '"+string(ll_nreg)+"' Completo ") 
end event

type cb_6 from commandbutton within w_in_iteemp
integer x = 2459
integer y = 620
integer width = 567
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "2.- doc.compra"
end type

event clicked;/*Utiliza :d_items_no_kit*/
long ll_nreg,i,ll_recepcion
decimal  v_costo
string ls_item,ls_sucursal,ls_seccion,ls_periodo,ls_dia,ls_anio,ls_mes


ls_periodo = em_1.text
ls_dia  =  mid(ls_periodo,1,2)
if ls_dia <> '01' then 
	Messagebox("Atencion","No es una fecha v$$HEX1$$e100$$ENDHEX$$lida")
	return
end if	
ls_anio = mid(ls_periodo,9,2)
ls_mes = mid(ls_periodo,4,2)
ll_nreg  = dw_1.retrieve(ls_mes+ls_anio)

for i = 1 to ll_nreg
	
	ls_item	= dw_1.getitemstring(i,"IT_CODIGO")
	w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' ") 

    /*Datos de  la ultima compra hasta el mes anterior al que se esta costeando*/
		
/*Nueva consulta 04-03-08*/	
SELECT venumero,suc, bod
into :ll_recepcion,:ls_sucursal,:ls_seccion
FROM (SELECT rownum MV_FECHA,mv_fecha fecha, NVL(MV_COSTPROM,0) cost ,VE_NUMERO venumero,SU_CODIGO suc ,BO_CODIGO bod
            FROM IN_MOVIM
		  WHERE EM_CODIGO = :str_appgeninfo.empresa
		  AND IT_CODIGO = :ls_item
		  AND TM_CODIGO = '1'
		  AND TM_IOE = 'I'
		  AND MV_FECHA < '01-jan-08'
		  ORDER BY fecha DESC)
WHERE rownum = 1 ;
	
 
 IF SQLCA.SQLCODE <> 0 THEN
 v_costo = 0	
 END IF		
   
	
	/*Busca costo en el documento*/
	v_costo = f_costocompra(ls_sucursal,ll_recepcion,ls_item)
	
	/*Actualiza en la tabla de inicio de costeo*/
    UPDATE IN_ITEMOV
    SET    IT_COSINI = :v_costo
    WHERE  IT_CODIGO = :ls_item
    AND    TO_CHAR(IT_FECHA,'MMYY') = '1207';
	
next

COMMIT;
 w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' Completo ") 
end event

type cb_5 from commandbutton within w_in_iteemp
integer x = 2459
integer y = 1116
integer width = 567
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "6.- Costo Actual"
end type

event clicked;/*Utiliza el d_items_no_kit*/
long ll_nreg,i
decimal  v_costo
string ls_item,ls_periodo,ls_dia,ls_mes,ls_anio


ls_periodo = em_1.text
ls_dia  =  mid(ls_periodo,1,2)
if ls_dia <> '01' then 
	Messagebox("Atencion","No es una fecha v$$HEX1$$e100$$ENDHEX$$lida")
	return
end if	
ls_anio = mid(ls_periodo,9,2)
ls_mes = mid(ls_periodo,4,2)
ll_nreg  = dw_1.retrieve(ls_mes+ls_anio)

for i = 1 to ll_nreg
	
	ls_item	= dw_1.getitemstring(i,"IT_CODIGO")
	 w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' ") 

	SELECT NVL(IT_COSTO,0)
	INTO :v_costo
	FROM IN_ITEM
	WHERE IT_CODIGO = :ls_item;
	
 
     IF SQLCA.SQLCODE <> 0 THEN
	v_costo = 0	
     END IF		
   
     UPDATE IN_ITEMOV
     SET    IT_COSINI = :v_costo
     WHERE  IT_CODIGO = :ls_item
     AND    TO_CHAR(IT_FECHA,'MMYY') = '1207';
	
next

COMMIT;
 w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' Completo ") 
end event

type cb_4 from commandbutton within w_in_iteemp
integer x = 2459
integer y = 992
integer width = 567
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "5.- Primer mov mes"
end type

event clicked;/*Utiliza :d_items_no_kit*/
/*Se busca el costo en el mes que se quiere costear*/
long ll_nreg,i
decimal  v_costo
string ls_item, ls_periodo,ls_dia,ls_mes,ls_anio

ls_periodo = em_1.text
ls_dia  =  mid(ls_periodo,1,2)
if ls_dia <> '01' then 
	Messagebox("Atencion","No es una fecha v$$HEX1$$e100$$ENDHEX$$lida")
	return
end if	
ls_anio = mid(ls_periodo,9,2)
ls_mes = mid(ls_periodo,4,2)
ll_nreg  = dw_1.retrieve(ls_mes+ls_anio)

for i = 1 to ll_nreg
	
	ls_item	= dw_1.getitemstring(i,"IT_CODIGO")
	 w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' ") 

		
	
	/*Encuentra el primer movimiento del mes*/	 
	SELECT nvl(cost,0)
	into :v_costo
	FROM (SELECT rownum MV_FECHA,mv_fecha fecha, NVL(MV_COSTPROM,0) cost ,VE_NUMERO venumero,SU_CODIGO suc ,BO_CODIGO bod,TM_CODIGO
			 FROM IN_MOVIM
			  WHERE EM_CODIGO = 1
			  AND IT_CODIGO = :ls_item
			  AND MV_FECHA  BETWEEN  '01-dec-07' AND '01-jan-08'
			  ORDER BY fecha ASC)
	WHERE rownum = 1 ;
	
		
 
     IF SQLCA.SQLCODE <> 0 THEN
	v_costo = 0	
     END IF		
   
     UPDATE IN_ITEMOV
     SET    IT_COSINI = :v_costo
     WHERE  IT_CODIGO = :ls_item
     AND    TO_CHAR(IT_FECHA,'MMYY') ='1207';
	
next

COMMIT;
 w_marco.setmicrohelp("Procesando item: ' "+string(i -1)+ "' de un total de '"+string(ll_nreg)+"' Completo ") 
end event

type cb_3 from commandbutton within w_in_iteemp
integer x = 2459
integer y = 732
integer width = 567
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "3.-Ultimo Movimiento"
end type

event clicked;/*Utiliza  d_items_no_kit*/
long ll_nreg,i,ll_reg
decimal  lc_costprom
string ls_item,ls_periodo ,ls_dia,ls_mes,ls_anio
datetime ldt_fecha
datastore lds_ultmov

ls_periodo = em_1.text
ls_dia  =  mid(ls_periodo,1,2)
if ls_dia <> '01' then 
	Messagebox("Atencion","No es una fecha v$$HEX1$$e100$$ENDHEX$$lida")
	return
end if	
ls_anio = mid(ls_periodo,9,2)
ls_mes = mid(ls_periodo,4,2)
//ll_nreg  = dw_1.retrieve(ls_mes+ls_anio)
ll_nreg = dw_1.retrieve('1')

for i = 1 to ll_nreg
	
	ls_item	= dw_1.getitemstring(i,"IT_CODIGO")
	w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' ") 
	lc_costprom = 0
	
	/*Encuentra el ultimo movimiento*/	 
	SELECT nvl(cost,0)
	into :lc_costprom
	FROM (SELECT rownum MV_FECHA,mv_fecha fecha, NVL(MV_COSTPROM,0) cost ,VE_NUMERO venumero,SU_CODIGO suc ,BO_CODIGO bod,TM_CODIGO
					FROM IN_MOVIM
			  WHERE EM_CODIGO = 1
			  AND IT_CODIGO = :ls_item
			  AND MV_FECHA < '01-jan-07'
			  ORDER BY fecha DESC)
	WHERE rownum = 1 ;

     IF isnull(lc_costprom) then lc_costprom = 0

		
//	UPDATE IN_ITEMOV
//	SET    IT_COSINI = :lc_costprom
//	WHERE  IT_CODIGO = :ls_item
//	AND    TO_CHAR(IT_FECHA,'MMYY') = '1207';

UPDATE IN_ITEEMP
SET    IT_COSINI = :lc_costprom
WHERE  IT_CODIGO = :ls_item
AND    TO_CHAR(IT_FECHA,'MMYY') = '0107';


    
next

COMMIT;
 w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' Completo ") 
end event

type cb_2 from commandbutton within w_in_iteemp
integer x = 2459
integer y = 860
integer width = 567
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "4.-Compra en el mes"
end type

event clicked;/*Utiliza el objeto :d_items_no_kit*/
/*Se busca el costo en el mes que se esta queriendo costear*/


long ll_nreg,i,ll_recepcion
decimal  v_costo
string ls_item,ls_sucursal,ls_seccion,ls_periodo,ls_dia,ls_mes,ls_anio 

ls_periodo = em_1.text
ls_dia  =  mid(ls_periodo,1,2)
if ls_dia <> '01' then 
	Messagebox("Atencion","No es una fecha v$$HEX1$$e100$$ENDHEX$$lida")
	return
end if	
ls_anio = mid(ls_periodo,9,2)
ls_mes = mid(ls_periodo,4,2)
ll_nreg  = dw_1.retrieve(ls_mes+ls_anio)

for i = 1 to ll_nreg
	
	ls_item	= dw_1.getitemstring(i,"IT_CODIGO")
	w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' ") 


	/*Datos de  la ultima compra*/
	SELECT venumero,suc, bod
	into :ll_recepcion,:ls_sucursal,:ls_seccion
	FROM (SELECT rownum MV_FECHA,mv_fecha fecha, NVL(MV_COSTPROM,0) cost ,VE_NUMERO venumero,SU_CODIGO suc ,BO_CODIGO bod
					FROM IN_MOVIM
			  WHERE EM_CODIGO = :str_appgeninfo.empresa
			  AND IT_CODIGO = :ls_item
			  AND TM_CODIGO = '1'
			  AND TM_IOE = 'I'
				 AND  MV_FECHA between '01-dec-07' and '01-jan-08'
			  ORDER BY fecha ASC)
	WHERE rownum = 1 ;
	
 
     IF SQLCA.SQLCODE <> 0 THEN
     v_costo = 0	
     END IF		
 
	
/*Busca costo en el documento*/
v_costo = f_costocompra(ls_sucursal,ll_recepcion,ls_item)
	
/*Actualiza en la tabla de inicio de costeo*/
UPDATE IN_ITEMOV
SET    IT_COSINI = :v_costo
WHERE  IT_CODIGO = :ls_item
AND    TO_CHAR(IT_FECHA,'MMYY') = '1207';
	
next

COMMIT;
w_marco.setmicrohelp("Procesando item: ' "+string(i - 1)+ "' de un total de '"+string(ll_nreg)+"' Completo ") 
end event

type cb_1 from commandbutton within w_in_iteemp
integer x = 2459
integer y = 296
integer width = 567
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserta Items con Mov"
end type

event clicked;/*inserta Items con movimientos del mes
uitliza el objeto : d_items_movim*/

String ls_item,ls_fecha,ls_periodo,ls_anio,ls_mes,ls_dia
Long ll_nreg,i

ls_periodo = em_1.text
ls_fecha = string(date(ls_periodo),'dd-mmm-yy')
ls_dia  =  mid(ls_periodo,1,2)
if ls_dia <> '01' then 
	Messagebox("Atencion","No es una fecha v$$HEX1$$e100$$ENDHEX$$lida")
	return
end if	
ls_anio = mid(ls_periodo,9,2)
ls_mes = mid(ls_periodo,4,2)


ll_nreg  = dw_1.retrieve(ls_mes+ls_anio)

/**/
for i = 1 to ll_nreg 
     ls_item = dw_1.getitemstring(i,"it_codigo")
	 w_marco.setmicrohelp("Procesando item: ' "+string(i)+ "' de un total de '"+string(ll_nreg)+"' ") 
	
	INSERT INTO IN_ITEMOV(EM_CODIGO,IT_CODIGO,IT_FECHA,IT_STKINI,IT_COSINI,ESTADO)
	VALUES('1',:ls_item,:ls_fecha,NULL,NULL,NULL);
	
	if sqlca.sqlcode < 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas"+sqlca.sqlerrtext)
		rollback;
		return
	end if	
next

COMMIT;
w_marco.setmicrohelp("Listo :Procesados '"+string(ll_nreg)+"' items ") 

end event

type dw_1 from datawindow within w_in_iteemp
integer x = 32
integer y = 52
integer width = 1742
integer height = 1352
integer taborder = 10
string title = "none"
string dataobject = "d_in_item"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


HA$PBExportHeader$w_costo_promedio.srw
$PBExportComments$Valorado todo el inventario al costo promedio a una determinada fecha.
forward
global type w_costo_promedio from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_costo_promedio
end type
type em_2 from editmask within w_costo_promedio
end type
type st_1 from statictext within w_costo_promedio
end type
type st_2 from statictext within w_costo_promedio
end type
type cb_1 from commandbutton within w_costo_promedio
end type
type dw_1 from datawindow within w_costo_promedio
end type
type st_3 from statictext within w_costo_promedio
end type
type cb_2 from commandbutton within w_costo_promedio
end type
end forward

global type w_costo_promedio from w_sheet_1_dw_maint
integer width = 4023
integer height = 2740
boolean ib_inreportmode = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
cb_1 cb_1
dw_1 dw_1
st_3 st_3
cb_2 cb_2
end type
global w_costo_promedio w_costo_promedio

on w_costo_promedio.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_3=create st_3
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_2
end on

on w_costo_promedio.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.cb_2)
end on

event open;call super::open;dw_datos.Sharedata(dw_report)
dw_1.SetTransObject(sqlca)

em_1.text = '01-jan-06'
end event

event close;call super::close;dw_datos.Sharedataoff()
end event

event ue_retrieve;Date ld_ini,ld_fcorte

ld_fcorte  =  date(em_2.text)
dw_1.retrieve(str_appgeninfo.empresa,ld_fcorte)
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_costo_promedio
integer x = 37
integer y = 128
integer width = 3913
integer height = 256
string dataobject = "d_items_x_valorados_costopromedio"
boolean vscrollbar = false
boolean border = true
boolean hsplitscroll = true
boolean livescroll = false
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_costo_promedio
integer x = 55
integer y = 784
string dataobject = "d_items_x_valorados_costopromedio"
end type

type em_1 from editmask within w_costo_promedio
integer x = 334
integer y = 28
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
end type

type em_2 from editmask within w_costo_promedio
integer x = 1061
integer y = 24
integer width = 343
integer height = 84
integer taborder = 40
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
end type

type st_1 from statictext within w_costo_promedio
integer x = 119
integer y = 40
integer width = 201
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

type st_2 from statictext within w_costo_promedio
integer x = 878
integer y = 40
integer width = 169
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

type cb_1 from commandbutton within w_costo_promedio
boolean visible = false
integer x = 3511
integer width = 343
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;//Recorre todo el listado del inventario
//Determina el ultimo costo promedio de cada item 
//Dentro de un per$$HEX1$$ed00$$ENDHEX$$odo determinado

date ld_ini = DATE('01-JAN-06') ,&
         ld_fcorte
datetime ldt_ultmov
decimal{4} lc_costprom,lc_ucc,lc_stockacum
long ll_reg,i,j,ll_r,ll_recep
string ls_pepa,ls_tipmov,ls_suc


Setpointer(Hourglass!)

ld_ini  = date(em_1.text)
ld_fcorte = date(em_2.text)


if isnull(ld_fcorte) or isnull(ld_fcorte) then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha de finalizaci$$HEX1$$f300$$ENDHEX$$n no puede estar en blanco...")
Return
end if


ll_reg = dw_datos.rowcount()

for  i = 1 to ll_reg
	
		
lc_stockacum = 0	
ls_pepa = dw_datos.Object.it_codigo[i]
		
SELECT SUM(DECODE(TM_IOE,'I',NVL(MV_CANTID,0),'E',NVL(MV_CANTID,0) * -1))
INTO   :lc_stockacum
FROM IN_MOVIM
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND IT_CODIGO = :ls_pepa
AND TRUNC(MV_FECHA) <= :ld_fcorte
GROUP BY IT_CODIGO;
		
	
		
SELECT nvl(cost,0), nvl(fecha,'01-jan-03')
into :lc_costprom, :ldt_ultmov
FROM (
            SELECT rownum MV_FECHA,mv_fecha fecha, NVL(MV_COSTPROM,0) cost 
            FROM IN_MOVIM
		  WHERE EM_CODIGO = :str_appgeninfo.empresa
		  AND IT_CODIGO = :ls_pepa
		  AND TRUNC(MV_FECHA) <= :ld_fcorte
		  ORDER BY FECHA DESC)
WHERE rownum = 1 ;
							
if sqlca.sqlcode = 100 or sqlca.sqlcode < 0 then
lc_costprom = 0
ldt_ultmov = datetime('01-jan-03')
end if

w_marco.SetMicroHelp("Actualizando "+ ' [ ' + string(i)+ ']  de '+ ' [ '+ string(ll_reg)+ ' ] ' + "costo promedio para el item "+ '[ '+ls_pepa+' ]')

//UPDATE IN_ITEM
//SET IT_COSTPROM =  :lc_costprom
//WHERE EM_CODIGO = :str_appgeninfo.empresa
//AND IT_CODIGO =  :ls_pepa;
//
//IF SQLCA.SQLCODE < 0 THEN
//	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el costo promedio para el item"+ '[ '+ls_pepa+' ]')
//	Rollback;
//	Return
//END IF

INSERT INTO "IN_ITEEMP"  
         ( "EM_CODIGO",   
           "IT_CODIGO",   
           "IT_FECHA",   
           "IT_STKINI",   
           "IT_COSINI",   
           "ESTADO" )  
  VALUES ( '1',   
           :ls_pepa,   
           :ld_fcorte,   
           :lc_stockacum,   
           :lc_costprom,   
           null) ;

//Para sacar el listado de items
dw_datos.object.costopromedio[i] =  lc_costprom							
dw_datos.object.ultimomov[i]        =  ldt_ultmov
dw_datos.object.stockacum[i]       =  lc_stockacum
next

COMMIT;

Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso de valoraci$$HEX1$$f300$$ENDHEX$$n terminado....")
Setpointer(Hourglass!)
end event

type dw_1 from datawindow within w_costo_promedio
integer x = 37
integer y = 416
integer width = 3913
integer height = 2080
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_rep_stock_valorado_x_empresa"
boolean livescroll = true
end type

type st_3 from statictext within w_costo_promedio
integer x = 78
integer y = 2532
integer width = 343
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
string text = "Movimientos"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_costo_promedio
boolean visible = false
integer x = 2679
integer y = 24
integer width = 402
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Saldos de mov"
end type

event clicked;//Recorre todo el listado del inventario
//Determina el ultimo costo promedio de cada item 
//Dentro de un per$$HEX1$$ed00$$ENDHEX$$odo determinado

date ld_ini,ld_fcorte
datetime ldt_ultmov

decimal{4} lc_costprom,lc_ucc
long ll_reg,i,j,ll_r,ll_recep,mov

string ls_pepa,ls_tipmov,ls_suc

Setpointer(Hourglass!)



ll_reg = dw_datos.rowcount()

for  i = 1 to ll_reg
	
mov = 0	
ls_pepa = dw_datos.Object.it_codigo[i]
		
SELECT SUM(DECODE(TM_IOE,'I',NVL(MV_CANTID,0),'E',NVL(MV_CANTID,0) * -1))
INTO   :mov  
FROM IN_MOVIM
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND IT_CODIGO = :ls_pepa
AND TRUNC(MV_FECHA) BETWEEN  :ld_ini and :ld_fcorte
GROUP BY IT_CODIGO;

							
if sqlca.sqlcode = 100 or sqlca.sqlcode < 0 then
mov = 0
end if

w_marco.SetMicroHelp("Actualizando "+ ' [ ' + string(i)+ ']  de '+ ' [ '+ string(ll_reg)+ ' ] ' + "saldo de stocks  para el item "+ '[ '+ls_pepa+' ]')

INSERT INTO "IN_ITEEMP"  
         ( "EM_CODIGO",   
           "IT_CODIGO",   
           "IT_FECHA",   
           "IT_STKINI",   
           "IT_COSINI",   
           "ESTADO" )  
  VALUES ( '1',   
           :ls_pepa,   
           :ld_fcorte,   
           :mov,   
           0,   
           null) ;

IF SQLCA.SQLCODE < 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el saldo")
	Rollback;
	Return
END IF

next

Commit;
w_marco.SetMicroHelp("Listo...!")
end event


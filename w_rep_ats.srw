HA$PBExportHeader$w_rep_ats.srw
$PBExportComments$Si.
forward
global type w_rep_ats from w_sheet_1_dw_rep
end type
type st_1 from statictext within w_rep_ats
end type
type dw_2 from datawindow within w_rep_ats
end type
type cb_4 from commandbutton within w_rep_ats
end type
type dw_3 from datawindow within w_rep_ats
end type
type tab_1 from tab within w_rep_ats
end type
type tabpage_1 from userobject within tab_1
end type
type shl_1 from statichyperlink within tabpage_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type dw_ats_compras from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
shl_1 shl_1
cb_5 cb_5
dw_ats_compras dw_ats_compras
end type
type tabpage_2 from userobject within tab_1
end type
type shl_2 from statichyperlink within tabpage_2
end type
type cb_6 from commandbutton within tabpage_2
end type
type dw_ats_vtas from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
shl_2 shl_2
cb_6 cb_6
dw_ats_vtas dw_ats_vtas
end type
type tabpage_3 from userobject within tab_1
end type
type shl_3 from statichyperlink within tabpage_3
end type
type cb_7 from commandbutton within tabpage_3
end type
type dw_ats_anulados from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
shl_3 shl_3
cb_7 cb_7
dw_ats_anulados dw_ats_anulados
end type
type tabpage_4 from userobject within tab_1
end type
type shl_4 from statichyperlink within tabpage_4
end type
type st_2 from statictext within tabpage_4
end type
type dw_reoc from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
shl_4 shl_4
st_2 st_2
dw_reoc dw_reoc
end type
type tabpage_5 from userobject within tab_1
end type
type shl_5 from statichyperlink within tabpage_5
end type
type dw_vista from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
shl_5 shl_5
dw_vista dw_vista
end type
type tabpage_6 from userobject within tab_1
end type
type dw_ats_compras_detalladas from datawindow within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_ats_compras_detalladas dw_ats_compras_detalladas
end type
type tab_1 from tab within w_rep_ats
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type cbx_powerfilter_ats from u_powerfilter_checkbox within w_rep_ats
end type
type cbx_powerfilter_vtas from u_powerfilter_checkbox within w_rep_ats
end type
type cbx_powerfilter_anu from u_powerfilter_checkbox within w_rep_ats
end type
type cbx_powerfilter_reoc from u_powerfilter_checkbox within w_rep_ats
end type
type cbx_vista from u_powerfilter_checkbox within w_rep_ats
end type
type cb_1 from commandbutton within w_rep_ats
end type
type gb_1 from groupbox within w_rep_ats
end type
type dw_1 from datawindow within w_rep_ats
end type
type hpb_1 from hprogressbar within w_rep_ats
end type
type st_3 from statictext within w_rep_ats
end type
type cb_2 from commandbutton within w_rep_ats
end type
type cb_3 from commandbutton within w_rep_ats
end type
type dw_xml from datawindow within w_rep_ats
end type
type cb_8 from commandbutton within w_rep_ats
end type
type cb_9 from commandbutton within w_rep_ats
end type
end forward

global type w_rep_ats from w_sheet_1_dw_rep
integer width = 6286
integer height = 2144
string title = "ATS / REOC"
boolean ib_notautoretrieve = true
st_1 st_1
dw_2 dw_2
cb_4 cb_4
dw_3 dw_3
tab_1 tab_1
cbx_powerfilter_ats cbx_powerfilter_ats
cbx_powerfilter_vtas cbx_powerfilter_vtas
cbx_powerfilter_anu cbx_powerfilter_anu
cbx_powerfilter_reoc cbx_powerfilter_reoc
cbx_vista cbx_vista
cb_1 cb_1
gb_1 gb_1
dw_1 dw_1
hpb_1 hpb_1
st_3 st_3
cb_2 cb_2
cb_3 cb_3
dw_xml dw_xml
cb_8 cb_8
cb_9 cb_9
end type
global w_rep_ats w_rep_ats

type variables
String is_anio,is_mes,is_periodo
end variables

on w_rep_ats.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_4=create cb_4
this.dw_3=create dw_3
this.tab_1=create tab_1
this.cbx_powerfilter_ats=create cbx_powerfilter_ats
this.cbx_powerfilter_vtas=create cbx_powerfilter_vtas
this.cbx_powerfilter_anu=create cbx_powerfilter_anu
this.cbx_powerfilter_reoc=create cbx_powerfilter_reoc
this.cbx_vista=create cbx_vista
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.hpb_1=create hpb_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_xml=create dw_xml
this.cb_8=create cb_8
this.cb_9=create cb_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.cbx_powerfilter_ats
this.Control[iCurrent+7]=this.cbx_powerfilter_vtas
this.Control[iCurrent+8]=this.cbx_powerfilter_anu
this.Control[iCurrent+9]=this.cbx_powerfilter_reoc
this.Control[iCurrent+10]=this.cbx_vista
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.hpb_1
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.cb_2
this.Control[iCurrent+17]=this.cb_3
this.Control[iCurrent+18]=this.dw_xml
this.Control[iCurrent+19]=this.cb_8
this.Control[iCurrent+20]=this.cb_9
end on

on w_rep_ats.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.dw_3)
destroy(this.tab_1)
destroy(this.cbx_powerfilter_ats)
destroy(this.cbx_powerfilter_vtas)
destroy(this.cbx_powerfilter_anu)
destroy(this.cbx_powerfilter_reoc)
destroy(this.cbx_vista)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.hpb_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_xml)
destroy(this.cb_8)
destroy(this.cb_9)
end on

event open;call super::open;
dw_3.SetTransObject(sqlca)
dw_1.insertrow(0)

dw_1.Object.anio[1] = string(year(today()) )
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=no")
end event

event resize;call super::resize;//st_8.move(st_8.x,this.workSpaceHeight() - .90*dw_datos.y)
//
//st_5.move(st_5.x,this.workSpaceHeight() - .65*dw_datos.y)
//st_6.move(st_6.x,this.workSpaceHeight() - .65*dw_datos.y)
//st_7.move(st_7.x,this.workSpaceHeight() - .65*dw_datos.y)
//
//sle_1.move(sle_1.x, this.workSpaceHeight() - .45*dw_datos.y)
//sle_2.move(sle_2.x, this.workSpaceHeight() - .45*dw_datos.y)
//sle_3.move(sle_3.x, this.workSpaceHeight() - .45*dw_datos.y)
//cb_1.move(cb_1.x, this.workSpaceHeight() - .45*dw_datos.y)
//cb_2.move(cb_2.x, this.workSpaceHeight() - .45*dw_datos.y)

return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_ats
boolean visible = false
integer x = 69
integer y = 308
integer width = 4974
integer height = 180
string dataobject = "d_rep_reoc2"
boolean border = true
boolean hsplitscroll = true
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_ats
integer x = 192
integer y = 924
integer taborder = 60
string dataobject = "d_reoc"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_ats
integer x = 1134
integer y = 912
integer width = 722
integer height = 564
integer taborder = 80
end type

type st_1 from statictext within w_rep_ats
integer x = 59
integer y = 32
integer width = 1093
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
string text = "Seleccione el per$$HEX1$$ed00$$ENDHEX$$odo para trabajar con el ATS:"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_rep_ats
boolean visible = false
integer x = 1125
integer y = 656
integer width = 3378
integer height = 660
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Retenciones duplicadas"
string dataobject = "d_reoc_valida"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;dw_2.settransobject(sqlca)
end event

type cb_4 from commandbutton within w_rep_ats
boolean visible = false
integer x = 2551
integer y = 24
integer width = 581
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "none"
end type

event clicked;Long ll_reg,i,li_count
String ls_periodo,ls_anio,ls_mes,ls_rucic,ls_aut,ls_est,ls_pto,ls_sec,ls_pvcodigo

ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio
ll_reg = dw_3.retrieve(ls_periodo)

for i = 1 to ll_reg
	
		ls_rucic = dw_3.object.pv_rucci[i]
		ls_est   = dw_3.object.mp_docnroest[i]
		ls_pto   = dw_3.object.mp_docnropto[i]
		ls_sec   = dw_3.object.mp_docnrosec[i]

   
		SELECT COUNT(1)
		INTO   :li_count
		FROM  PR_EMPRE   E,     CP_PAGO R, CP_CRUCE Z, CP_MOVIM F , IN_PROVE P
		WHERE  E.EM_CODIGO = F.EM_CODIGO
		AND    P.EM_CODIGO  = F.EM_CODIGO
		AND    P.PV_CODIGO  = F.PV_CODIGO
		AND    F.TV_CODIGO  = Z.TV_CODIGO
		AND    F.TV_TIPO       = Z.TV_TIPO
		AND    F.EM_CODIGO  = Z.EM_CODIGO
		AND    F.SU_CODIGO  = Z.SU_CODIGO
		AND    F.MP_CODIGO  = Z.MP_CODIGO
		AND    Z.TV_CODDEB  = R.TV_CODIGO
		AND    Z.TV_TIPODEB = R.TV_TIPO
		AND    Z.MP_CODDEB  = R.MP_CODIGO
		AND    Z.EM_CODIGO  = R.EM_CODIGO
		AND   Z.SU_CODIGO   = R.SU_CODIGO
		AND   R.FP_CODIGO IN (6,7,111)
		AND   R.PM_CODPCT NOT IN ('332','333','334')
		AND   TO_CHAR(F.MP_FECEMISION,'MM/YYYY') = :lS_PERIODO
		AND   F.MP_DOCNROEST = :ls_est
		AND   F.MP_DOCNROPTO = :ls_pto
		AND   F.MP_DOCNROSEC = :ls_sec
		AND   P.PV_RUCCI =  :ls_rucic ;
	
	
	     // No existen mas codigos asociados a la factura
	     IF li_count=0 THEN
			
			SELECT PV_CODIGO INTO :ls_pvcodigo FROM IN_PROVE WHERE PV_RUCCI = :ls_rucic;
						
			UPDATE CP_MOVIM
			SET MP_AUTRET = NULL,
			MP_ESTABRET = NULL,
			MP_PTOEMIRET = NULL,
			MP_SECRET      = NULL,
			MP_FECEMIRET = NULL
			WHERE MP_DOCNROEST = :ls_est
			AND MP_DOCNROPTO  = :ls_pto
			AND MP_DOCNROSEC = :ls_sec
			AND PV_CODIGO = :ls_pvcodigo;
			
		END IF	

	 
next

commit;
end event

type dw_3 from datawindow within w_rep_ats
boolean visible = false
integer x = 1970
integer y = 1424
integer width = 2062
integer height = 260
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_reoc_332"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tab_1 from tab within w_rep_ats
integer x = 32
integer y = 312
integer width = 6194
integer height = 1724
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean fixedwidth = true
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 6158
integer height = 1604
long backcolor = 67108864
string text = "Compras retenciones"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
shl_1 shl_1
cb_5 cb_5
dw_ats_compras dw_ats_compras
end type

on tabpage_1.create
this.shl_1=create shl_1
this.cb_5=create cb_5
this.dw_ats_compras=create dw_ats_compras
this.Control[]={this.shl_1,&
this.cb_5,&
this.dw_ats_compras}
end on

on tabpage_1.destroy
destroy(this.shl_1)
destroy(this.cb_5)
destroy(this.dw_ats_compras)
end on

type shl_1 from statichyperlink within tabpage_1
integer x = 2720
integer y = 24
integer width = 283
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Autofiltro"
boolean focusrectangle = false
end type

event clicked;cbx_Powerfilter_ats.enabled = TRUE 
cbx_Powerfilter_ats.of_setdw(dw_ats_compras)
end event

type cb_5 from commandbutton within tabpage_1
integer x = 18
integer y = 12
integer width = 1705
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Click aqu$$HEX2$$ed002000$$ENDHEX$$para generar ATS de compras"
boolean flatstyle = true
end type

event clicked;Date ld_ini,ld_fin,ld_inicio_periodo
long ll_reg,ll_autret

String   ls_periodo,ls_mes,ls_anio,&
           ls_estabret,ls_ptoemiret
long     ll_secret



SetPointer(Hourglass!)
ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio

SELECT COUNT(1)
INTO    :ll_reg
FROM   AN_RETAIR
WHERE ANIO = :ls_anio
AND     MES   = :ls_mes;

IF ll_reg > 0 then
   If	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existen retenciones ingresadas para este per$$HEX1$$ed00$$ENDHEX$$odo....Desea sobreescribir...?",Question!,YesNO!,2) = 2 then 
         return	
  else
		DELETE FROM AN_RETAIR
		WHERE ANIO = :ls_anio
		AND      MES =  :ls_mes;
		
		IF SQLCA.SQLCODE <> 0 THEN
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al eliminar las retenciones...."+sqlca.sqlerrtext)
			rollback;
			return
		END IF
		
  end if
End if

w_marco.SetMicrohelp("Por favor espere se est$$HEX2$$e1002000$$ENDHEX$$generando las retenciones....")
//cb_4.triggerevent(clicked!)


INSERT INTO AN_RETAIR
SELECT TO_CHAR(F.MP_FECEMISION,'YYYY'),
            TO_CHAR(F.MP_FECEMISION,'MM'),
		   rownum,	
            E.EM_RUC,
            F.MP_TIPIDPRV,
		   P.PV_RUCCI,
		  lpad(F.MP_TIPODOC,2,'0'),
		  F.MP_NAUT,
		  F.mp_docnroest,
		  F.mp_docnropto,
		  F.mp_docnrosec,
           to_char(F.mp_fecemision,'dd/mm/yyyy'),
		  R.PM_CODPCT, // codretair
		  R.PM_PORCTJE, //porcentajeAir
		  NVL(R.PM_BASE0,0), // base 0 ret fte
		  NVL(R.PM_BASEGRAV,0),// base 12
		  NVL(R.PM_BASENOGRAV,0),// base no gravada
		  NVL(R.PM_VALOR,0),    //valretair   RET FTE
		  nvl(F.MP_AUTRET,'000' ),
		 nvl( F.MP_ESTABRET,'000' ),
		 nvl( F.MP_PTOEMIRET,'000' ),
		  nvl(F.MP_SECRET,'1 ' ),
           nvl(to_char(F.MP_FECEMIRET,'dd/mm/yyyy'),to_char(F.MP_FECEMISION,'dd/mm/yyyy')),
		  NVL(R.PM_BSEIMP,0),  //baseimpAir
		  DECODE(F.MP_AUTRET1,0,'000',nvl(F.MP_AUTRET1,'000')),
		  nvl (F.MP_ESTABRET1,'000' ),
           nvl (F.MP_PTOEMIRET1,'000' ),
		  nvl (F.MP_SECRET1,'1' ),
		  nvl(to_char(F.MP_FECEMIRET1,'dd/mm/yyyy'),to_char(F.MP_FECEMISION,'dd/mm/yyyy')),
		  F.MP_CODTRIBU,
		  F.MP_BSEIMPICE, //basenograiva
		  NVL(F.MP_BSEIMPTRF0,0), //baseimponible tarifa 0
		  NVL(F.MP_BASEIMP,0), //baseimpgrav    tarifa 12
		  nvl(F.MP_BASEIMPEXE,0), //baseimpexe  baseexenta
		  NVL(F.MP_MONTOICE,0),
		  NVL(F.MP_VALRET,0),  // montoiva
		  nvl(F.MP_RETIVABIEN10,0), //retiva10
		  nvl(F.MP_RETIVASERV20,0), //retiva20
  		  NVL(F.MP_RETIVABIENES,0), //retiva 30
		  NVL(F.MP_RETIVASERV,0), //retiva70
		  NVL(F.MP_RETIVA100,0), //retiva100
		  nvl(F.MP_MODTIPODOC,'0'),
		  NVL(F.MP_MODNROEST,'000'),
		  NVL(F.MP_MODNROPTO,'000'),
		  NVL(F.MP_MODNROSEC,'0'),
		  NVL(F.MP_MODNAUT,'000'),
		 to_char(F.MP_FECEMISION,'dd/mm/yyyy'),
		 F.MP_CODIGO
FROM    PR_EMPRE   E,     CP_PAGO R, CP_CRUCE Z, CP_MOVIM F , IN_PROVE P
WHERE  E.EM_CODIGO = F.EM_CODIGO
AND    P.EM_CODIGO  = F.EM_CODIGO
AND    P.PV_CODIGO  = F.PV_CODIGO
AND    F.TV_CODIGO  = Z.TV_CODIGO
AND    F.TV_TIPO       = Z.TV_TIPO
AND    F.EM_CODIGO  = Z.EM_CODIGO
AND    F.SU_CODIGO  = Z.SU_CODIGO
AND    F.MP_CODIGO  = Z.MP_CODIGO
AND    Z.TV_CODDEB  = R.TV_CODIGO
AND    Z.TV_TIPODEB = R.TV_TIPO
AND    Z.MP_CODDEB  = R.MP_CODIGO
AND    Z.EM_CODIGO  = R.EM_CODIGO
AND   Z.SU_CODIGO   = R.SU_CODIGO
AND   R.FP_CODIGO IN (6)
AND   TO_CHAR(F.MP_FECEMISION,'MM/YYYY') = :ls_periodo
AND   NVL(F.ESTADO,'S') <> 'S'
ORDER BY  F.MP_FECHA ASC;

IF sqlca.sqlnrows = 0 then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen compras para este per$$HEX1$$ed00$$ENDHEX$$odo..."+sqlca.sqlerrtext)
end if

IF SQLCA.SQLCODE = 100 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen compras para este per$$HEX1$$ed00$$ENDHEX$$odo..."+sqlca.sqlerrtext)
END IF

IF SQLCA.SQLCODE < 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar las compras ..."+sqlca.sqlerrtext)
	rollback;
	return
END IF


/*Ingreso de  NOTAS DE CREDITO*/
/*Las notas de credito no tienen retencion*/
If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea incluir las NOTAS DE CREDITO POR DEVOLUCION Y POR DESCUENTO ADICIONAL....  ",Question!,YesNo!,1) = 1 then
select count(1) into :ll_reg from an_retair where anio = :ls_anio and mes = :ls_mes;

INSERT INTO AN_RETAIR
SELECT TO_CHAR(D.MP_FECEMISION,'YYYY'),
           TO_CHAR(D.MP_FECEMISION,'MM'),
 		  :ll_reg + rownum,	  
           E.EM_RUC,
           DECODE(LENGTH(P.PV_RUCCI),13,'01',10,'02','03') ,
		  P.PV_RUCCI,
		  lpad(D.MP_TIPODOC,2,'0'),
		  D.MP_NAUT,
		  D.mp_docnroest,D.mp_docnropto,D.mp_docnrosec,to_char(D.mp_fecemision,'dd/mm/yyyy'),
		  nvl(R.PM_CODPCT,332),
		  nvl(R.PM_PORCTJE,0),
		  NVL(R.PM_BASE0,0),
		  NVL(R.PM_BASEGRAV,0),
		  NVL(R.PM_BASENOGRAV,0),
		  0,
		  DECODE(D.MP_AUTRET,0,'000',nvl(D.MP_AUTRET,'000')),
		  nvl(D.MP_ESTABRET,'000'),
		  nvl(D.MP_PTOEMIRET,'000'),
		  nvl(D.MP_SECRET,0),
		  to_char(D.MP_FECEMIRET,'dd/mm/yyyy'),
		  NVL(R.PM_VALOR,0),
		  DECODE(D.MP_AUTRET1,0,'000',nvl(D.MP_AUTRET1,'000')),
		  nvl(D.MP_ESTABRET1,'000'),
		  nvl(D.MP_PTOEMIRET1,'000'),
		  nvl(D.MP_SECRET1,0),
		  to_char(D.MP_FECEMIRET1,'dd/mm/yyyy'),
           D.MP_CODTRIBU,
           NVL(D.MP_BSEIMPICE,0),
		  NVL(D.MP_BSEIMPTRF0,0),
		  NVL(D.MP_BASEIMP,0),
		  NVL(D.MP_BASEIMPEXE,0),
		  NVL(D.MP_MONTOICE,0),
		  NVL(D.MP_VALRET,0),
		  nvl(D.MP_RETIVABIEN10,0), //retiva10
		  nvl(D.MP_RETIVASERV20,0), //retiva20
           NVL(D.MP_RETIVABIENES,0),
		  NVL(D.MP_RETIVASERV,0),
		  NVL(D.MP_RETIVA100,0),
		  D.MP_MODTIPODOC,
		  D.MP_MODNROEST,
		  D.MP_MODNROPTO,
		  D.MP_MODNROSEC,
		  D.MP_MODNAUT,
           to_char(D.mp_fecemision,'dd/mm/yyyy'),
		  D.mp_codigo	  
FROM  PR_EMPRE   E,     CP_PAGO R, CP_CRUCE Z, CP_MOVIM D , IN_PROVE P
WHERE  E.EM_CODIGO = D.EM_CODIGO
AND    P.EM_CODIGO  = D.EM_CODIGO
AND    P.PV_CODIGO  = D.PV_CODIGO
AND    D.TV_CODIGO  = Z.TV_CODDEB
AND    D.TV_TIPO       = Z.TV_TIPODEB
AND    D.EM_CODIGO  = Z.EM_CODIGO
AND    D.SU_CODIGO  = Z.SU_CODIGO
AND    D.MP_CODIGO  = Z.MP_CODDEB
AND    Z.TV_CODDEB  = R.TV_CODIGO
AND    Z.TV_TIPODEB = R.TV_TIPO
AND    Z.MP_CODDEB  = R.MP_CODIGO
AND    Z.EM_CODIGO  = R.EM_CODIGO
AND   Z.SU_CODIGO   = R.SU_CODIGO
AND   R.FP_CODIGO IN (2,49,50,60,101)
AND   TO_CHAR(D.MP_FECEMISION,'MM/YYYY') = :ls_periodo
AND NVL(D.ESTADO,'S') = 'S'
ORDER BY  D.MP_FECHA ASC;

IF SQLCA.SQLCODE <> 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar las notas de credito..."+sqlca.sqlerrtext)
	rollback;
	return
END IF

IF sqlca.sqlnrows = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen notas de credito para este per$$HEX1$$ed00$$ENDHEX$$odo..."+sqlca.sqlerrtext)
end if

End if
//3.
//Actualiza valores de retencion de IVA que se han efectuado a las COMPRAS.

String ls_cerucic,ls_fp,ls_mpcodigo,ls_pvrucci,ls_pvcodigo,ls_est,ls_pto,ls_sec
decimal lc_valretenido,lc_codpct,lc_porctje

declare  c1 cursor  FOR 

SELECT Z.MP_CODIGO,P.PV_RUCCI,P.PV_CODIGO,TO_CHAR(CREDITO.MP_FECEMISION,'YYYY') ANIO , TO_CHAR(CREDITO.MP_FECEMISION,'MM') MES, CREDITO.mp_docnroest,
			CREDITO.mp_docnropto,
			CREDITO.mp_docnrosec,
R.PM_CODPCT,R.PM_PORCTJE,R.PM_VALOR
FROM  PR_EMPRE   E,     CP_PAGO R, CP_CRUCE Z, CP_MOVIM D , IN_PROVE P, CP_MOVIM CREDITO
WHERE  E.EM_CODIGO = D.EM_CODIGO
AND    P.EM_CODIGO  = D.EM_CODIGO
AND    P.PV_CODIGO  = D.PV_CODIGO
AND    D.TV_CODIGO  = Z.TV_CODDEB
AND    D.TV_TIPO       = Z.TV_TIPODEB
AND    D.EM_CODIGO  = Z.EM_CODIGO
AND    D.SU_CODIGO  = Z.SU_CODIGO
AND    D.MP_CODIGO  = Z.MP_CODDEB
AND    Z.TV_CODDEB  = R.TV_CODIGO
AND    Z.TV_TIPODEB = R.TV_TIPO
AND    Z.MP_CODDEB  = R.MP_CODIGO
AND    Z.EM_CODIGO  = R.EM_CODIGO
AND   Z.SU_CODIGO   = R.SU_CODIGO

AND    Z.TV_CODIGO = CREDITO.TV_CODIGO
AND    Z.TV_TIPO = CREDITO.TV_TIPO
AND    Z.EM_CODIGO = CREDITO.EM_CODIGO
AND   Z.SU_CODIGO = CREDITO.SU_CODIGO
AND   Z.MP_CODIGO = CREDITO.MP_CODIGO

AND   R.FP_CODIGO IN ('7','111')
AND   TO_CHAR(CREDITO.MP_FECEMISION,'MM/YYYY') = :ls_periodo
ORDER BY Z.MP_CODIGO ASC;

open c1;

do while true
	
	fetch  c1 into :ls_mpcodigo,:ls_pvrucci,:ls_pvcodigo,:ls_anio,:ls_mes,:ls_est,:ls_pto,:ls_sec,:lc_codpct,:lc_porctje,:lc_valretenido;
	if sqlca.sqlcode <> 0 then exit
	
	
	
    if lc_porctje = 70 then 
		
		UPDATE  AN_RETAIR
		SET      VALORRETSERVICIOS= :lc_valretenido
		WHERE idprov = :ls_pvrucci
		AND     ESTAB = :ls_est
		AND     PTOEMI = :ls_pto
		AND     SEC  = :ls_sec
		AND     ANIO = :ls_anio
		AND     MES = :ls_mes;
		
	elseif lc_porctje = 30 then
		
		UPDATE AN_RETAIR
		SET VALORRETBIENES = :lc_valretenido
		WHERE idprov = :ls_pvrucci
		AND     ESTAB =:ls_est
		AND     PTOEMI =:ls_pto
		AND     SEC  = :ls_sec
		AND     ANIO = :ls_anio
		AND     MES = :ls_mes;
		
	else
		
		UPDATE AN_RETAIR
		SET VALORRETSERV100 =:lc_valretenido
	     WHERE idprov = :ls_pvrucci
		AND     ESTAB =:ls_est
		AND     PTOEMI =:ls_pto
		AND     SEC  = :ls_sec
		AND     ANIO = :ls_anio
		AND     MES = :ls_mes;
  
    end if
loop
close c1;

COMMIT;
SetPointer(Arrow!)
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo ...se ha procesado las compras del per$$HEX1$$ed00$$ENDHEX$$odo...'"+ls_periodo+"'")

tab_1.tabpage_1.dw_ats_compras.retrieve(ls_anio,ls_mes)
w_marco.SetMicrohelp("Listo....")
end event

type dw_ats_compras from datawindow within tabpage_1
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 108
integer width = 6153
integer height = 1492
integer taborder = 10
string title = "none"
string dataobject = "d_ats_compras"
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event ue_leftbuttonup;cbx_Powerfilter_ats.event post ue_buttonclicked(dwo.type,dwo.name)
end event

event constructor;this.SetTransObject(sqlca)
end event

event buttonclicked;String ls_anio,ls_mes
OleObject ole_excel 
if dwo.name = 'b_1' then
	
	ls_anio = dw_1.object.anio[1]
     ls_mes = dw_1.object.mes[1]
	this.retrieve(ls_anio,ls_mes)
end if

if dwo.name = 'b_5' then
	String ls_path,ls_ruc,ls_razonsocial,ls_periodo
OLEObject ole1,oleChild
Decimal {2} lc_totalvtas

integer rs,li_fila,i
	
		
ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio

ole1= CREATE OLEObject
rs = ole1.ConnectToNewObject("Excel.Application")
ls_Path = "D:\Plantilla.xlsx"


oleChild = CREATE oleobject

rs = oleChild.SetAutomationPointer(ole1 )

IF ( rs = 0 ) THEN
          oleChild.workbooks.open(ls_Path)
	    //Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a informante de la plantilla
		//inicia en la fila 2
		
		SELECT EM_RUC,EM_NOMBRE
		into :ls_ruc,:ls_razonsocial
		FROM PR_EMPRE;
		
		
		SELECT sum(ve_neto)
		INTO :lc_totalvtas
		FROM FA_VENTA
		WHERE ES_CODIGO IN (1,2)
		AND TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo;
		
		
	     oleChild.worksheets(1).cells(2,1 ).value ='R'
		oleChild.worksheets(1).cells(2,2 ).value = ls_ruc
		oleChild.worksheets(1).cells(2,3 ).value = ls_razonsocial
		oleChild.worksheets(1).cells(2,4 ).value = ls_anio
		oleChild.worksheets(1).cells(2,5 ).value = ls_mes
		oleChild.worksheets(1).cells(2,6 ).value = '001'
          oleChild.worksheets(1).cells(2,7 ).value = lc_totalvtas
        
		//Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a Compras detalladas  
		//Inicia en la fila 3
		
		for i = 1 to this.rowcount( )
			li_fila = i + 2
			oleChild.worksheets(2).cells(li_fila,1 ).value ='R'
			oleChild.worksheets(2).cells(li_fila,2 ).value = ls_ruc
			oleChild.worksheets(2).cells(li_fila,3 ).value = ls_razonsocial
			oleChild.worksheets(2).cells(li_fila,4 ).value = ls_anio
			oleChild.worksheets(2).cells(li_fila,5 ).value = ls_mes
			oleChild.worksheets(2).cells(li_fila,6 ).value = '001'
			oleChild.worksheets(2).cells(li_fila,7 ).value = lc_totalvtas
			oleChild.worksheets(2).cells(li_fila,8 ).value ='R'
			oleChild.worksheets(2).cells(li_fila,9 ).value = ls_ruc
			oleChild.worksheets(2).cells(li_fila,10).value = ls_razonsocial
			oleChild.worksheets(2).cells(li_fila,11 ).value = ls_anio
			oleChild.worksheets(2).cells(li_fila,12).value = ls_mes
			oleChild.worksheets(2).cells(li_fila,13 ).value = '001'
			oleChild.worksheets(2).cells(li_fila,14 ).value = lc_totalvtas	 
		 next   
		  
		oleChild.activeworkbook.saveas("d:\ats.xlsx")
          oleChild.activeworkbook.close()

      oleChild.quit()

END IF

ole1.disconnectobject()
DESTROY oleChild

DESTROY ole1



end if
end event

event resize;cbx_PowerFilter_ats.event ue_positionbuttons()
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 6158
integer height = 1604
long backcolor = 67108864
string text = "Ventas"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
shl_2 shl_2
cb_6 cb_6
dw_ats_vtas dw_ats_vtas
end type

on tabpage_2.create
this.shl_2=create shl_2
this.cb_6=create cb_6
this.dw_ats_vtas=create dw_ats_vtas
this.Control[]={this.shl_2,&
this.cb_6,&
this.dw_ats_vtas}
end on

on tabpage_2.destroy
destroy(this.shl_2)
destroy(this.cb_6)
destroy(this.dw_ats_vtas)
end on

type shl_2 from statichyperlink within tabpage_2
integer x = 2656
integer y = 24
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Autofiltro"
boolean focusrectangle = false
end type

event clicked;cbx_Powerfilter_vtas.ENABLED = true
cbx_Powerfilter_vtas.of_setdw(dw_ats_vtas)
end event

type cb_6 from commandbutton within tabpage_2
integer x = 23
integer y = 12
integer width = 1691
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Click aqu$$HEX2$$ed002000$$ENDHEX$$para generar ATS de ventas"
boolean flatstyle = true
end type

event clicked;Date ld_ini,ld_fin,ld_inicio_periodo
long ll_reg,ll_autret

String   ls_periodo,ls_mes,ls_anio,&
           ls_estabret,ls_ptoemiret
long     ll_secret
Decimal{2} lc_iva


SetPointer(Hourglass!)


ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio


lc_iva = f_iva()

SELECT COUNT(1)
INTO    :ll_reg
FROM   AN_VENTAS
WHERE ANIO = :ls_anio
AND     MES   = :ls_mes;

IF ll_reg > 0 then
   If	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existen retenciones ingresadas para este per$$HEX1$$ed00$$ENDHEX$$odo....Desea sobreescribir...?",Question!,YesNO!,2) = 2 then 
         return	
  else
		DELETE FROM AN_VENTAS
		WHERE ANIO = :ls_anio
		AND      MES =  :ls_mes;
		
		IF SQLCA.SQLCODE <> 0 THEN
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al eliminar las retenciones...."+sqlca.sqlerrtext)
			rollback;
			return
		END IF
		
  end if
End if

w_marco.SetMicrohelp("Por favor espere se est$$HEX2$$e1002000$$ENDHEX$$generando las retenciones....")
//cb_4.triggerevent(clicked!)


/*VENTAS FXM Y POS*/
w_marco.SetMicrohelp("Se est$$HEX2$$e1002000$$ENDHEX$$generado las ventas del...'"+is_periodo+"'....Por favor espere...!!!")
INSERT INTO AN_VENTAS
SELECT  :ls_anio,:ls_mes,1,
DECODE(LENGTH(replace(CE_RUCIC,'-')),10,'05',13,'04','06') tpidCliente , replace(CE_RUCIC,'-') idCliente, '18' tipocomprobante, COUNT(1) numeroComprobantes, 0 basenograiva,  0 baseimponible , SUM(V.VE_NETO) baseimpgrav, SUM(V.VE_IVA) iva , 0 VALRETIVA, 0 VALORRETRENTA 
FROM FA_VENTA V , FA_CLIEN C
WHERE V.CE_CODIGO = C.CE_CODIGO
AND ES_CODIGO IN (1,2)
AND TO_CHAR(V.VE_FECHA,'MM/YYYY') = :ls_periodo
GROUP BY replace(C.CE_RUCIC,'-');

IF SQLCA.SQLCODE <> 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar las ventas..."+sqlca.sqlerrtext)
	rollback;
	return
END IF

/*NOTAS DE DEBITO  DE CARTERA */

select count(1) into :ll_reg from an_ventas where anio = :ls_anio and mes = :ls_mes;

INSERT INTO AN_VENTAS
SELECT  :ls_anio,:ls_mes,:ll_reg,
DECODE(LENGTH(replace(CE_RUCIC,'-')),10,'05',13,'04','06') tpidCliente ,replace(CE_RUCIC,'-') idCliente, '05'  tipocomprobante, COUNT(1) numeroComprobantes, 0 basenograiva,  0 baseimponible , ROUND(SUM(D.MT_VALOR/(1+:lc_iva)),2) baseimpgrav, ROUND(SUM((D.MT_VALOR/(1+:lc_iva))*:lc_iva),2) iva , 0 VALRETIVA, 0 VALORRETRENTA
FROM   CC_MOVIM D, FA_CLIEN C
WHERE D.CE_CODIGO = C.CE_CODIGO
AND TO_CHAR(MT_FECHA,'MM/YYYY') = :ls_periodo
AND TT_IOE = 'D'
AND TT_CODIGO IN (18,19)
GROUP BY :ll_reg,replace(CE_RUCIC,'-');
IF SQLCA.SQLCODE <> 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar las notas de debito de cartera..."+sqlca.sqlerrtext)
	rollback;
	return
END IF

//

/*NOTAS DE CREDITO DE VENTAS*/
w_marco.SetMicrohelp("Se est$$HEX2$$e1002000$$ENDHEX$$generando las notas de cr$$HEX1$$e900$$ENDHEX$$dito de ventas...'"+ls_periodo+"'....Por favor espere...!!!")

/*Tanto las devoluciones de mercaderia en POS como en FXM 
se ingresan en CXC con el tipo de movimiento 5 con FORMA DE PAGO = '2'*/
select count(1) into :ll_reg from an_ventas where anio = :ls_anio and mes = :ls_mes;

INSERT INTO AN_VENTAS
SELECT  :ls_anio,:ls_mes,:ll_reg,  
             DECODE(LENGTH(idCliente),10,'05',13,'04','06') tpidCliente , idCliente, '04'  tipocomprobante, COUNT(1) numeroComprobantes, 0 basenograiva,  0 baseimponible , SUM(baseimpgrav), SUM(iva) , 0 VALRETIVA, 0 VALORRETRENTA
FROM  ( 
             SELECT 
			replace(C.CE_RUCIC,'-') idCliente, '04'  tipocomprobante, 0 basenograiva,  0 baseimponible , NVL(V.VE_NETO,0) baseimpgrav, V.VE_IVA iva , 0 VALRETIVA, 0 VALORRETRENTA
			FROM FA_VENTA V , FA_CLIEN C
			WHERE V.CE_CODIGO = C.CE_CODIGO
			AND ES_CODIGO IN (10)
             	AND TO_CHAR(V.VE_FECHA,'MM/YYYY') = :ls_periodo 
			UNION
			SELECT replace(C.CE_RUCIC,'-') idCliente, '04' tipocomprobante,  0 basenograiva,  0 baseimponible ,ROUND(SUM(CH.CH_VALOR/(1+:lc_iva)),2) baseimpgrav,ROUND((SUM(CH.CH_VALOR/(1+:lc_iva))*:lc_iva),2) iva , 0 VALRETIVA, 0 VALORRETRENTA 
			FROM CC_MOVIM M , CC_CHEQUE CH , FA_CLIEN C
			WHERE C.CE_CODIGO = M.CE_CODIGO  
			AND M.EM_CODIGO = CH.EM_CODIGO
			AND M.SU_CODIGO = CH.SU_CODIGO
			AND M.TT_CODIGO = CH.TT_CODIGO
			AND M.TT_IOE = CH.TT_IOE
			AND M.MT_CODIGO = CH.MT_CODIGO
			AND CH.FP_CODIGO IN (2,50,49)
            	AND TO_CHAR(CH.CH_FECHA,'MM/YYYY') = :ls_periodo
             GROUP BY replace(C.CE_RUCIC,'-'))
GROUP BY :ll_reg,idCliente;

IF SQLCA.SQLCODE <> 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar NC DE CARTERA..."+sqlca.sqlerrtext)
END IF




//Actualiza valores de retencion que se han efectuado a las facturas.
String ls_cerucic,ls_fp
decimal lc_valretenido

declare  c1 cursor  FOR 


SELECT replace(C.CE_RUCIC,'-' ),Y.FP_CODIGO,SUM(Y.CH_VALOR)
FROM CC_MOVIM X, FA_CLIEN C, CC_CHEQUE Y
WHERE C.CE_CODIGO = X.CE_CODIGO
AND X.TT_CODIGO = Y.TT_CODIGO
AND X.TT_IOE = Y.TT_IOE
AND X.EM_CODIGO = Y.EM_CODIGO
AND X.SU_CODIGO = Y.SU_CODIGO
AND X.MT_CODIGO = Y.MT_CODIGO
AND Y.FP_CODIGO IN (6,7 )
AND TO_CHAR(Y.CH_FECHA,'MM/YYYY') = :ls_periodo
GROUP BY replace(C.CE_RUCIC,'-'),Y.FP_CODIGO
UNION /*RENTENCIONES EN POS INGRESADAS POR MOVCAJA*/
SELECT replace( C.CE_RUCIC,'-' ),M.TJ_CODIGO, SUM(M.MC_VALOR)
FROM FA_MOVCAJA M,FA_VENTA V, FA_CLIEN C
WHERE  C.CE_CODIGO = V.CE_CODIGO
AND  TO_NUMBER(M.VE_NUMERO ) = V.VE_NUMERO
AND  M.TJ_CODIGO in (6,7 )
AND  TO_CHAR( M.MC_FECHA,'MM/YYYY'  ) = :ls_periodo
GROUP BY replace(C.CE_RUCIC,'-' ),M.TJ_CODIGO;

//incluir retenciones del POS ingresadas como cancelacion del d$$HEX1$$ed00$$ENDHEX$$a.





open c1;

do while true
	
	fetch  c1 into :ls_cerucic,:ls_fp,:lc_valretenido;
	if sqlca.sqlcode <> 0 then exit
    if ls_fp = '6' then 
		update AN_VENTAS
		SET valorRetRenta = :lc_valretenido
		WHERE IDCLIENTE = :ls_cerucic; 
   else
		update AN_VENTAS
		SET valorRetIva = :lc_valretenido
		WHERE IDCLIENTE = :ls_cerucic;
   end if
loop
close c1;

// Nuevo 2015
// Vtas Netas por establecimiento  (Restadas las NC)



COMMIT;
SetPointer(Arrow!)
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo ...se ha generado el anexo de ventas del per$$HEX1$$ed00$$ENDHEX$$odo...'"+ls_periodo+"'")
tab_1.tabpage_2.dw_ats_vtas.retrieve(ls_anio,ls_mes)
w_marco.SetMicrohelp("Listo....")
end event

type dw_ats_vtas from datawindow within tabpage_2
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 104
integer width = 5559
integer height = 1508
integer taborder = 10
string title = "none"
string dataobject = "d_ats_ventas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event ue_leftbuttonup;cbx_Powerfilter_vtas.event post ue_buttonclicked(dwo.type,dwo.name)
end event

event constructor;this.SetTransObject(sqlca)
end event

event buttonclicked;String ls_anio,ls_mes

if dwo.name = 'b_1' then
	
	 ls_anio = dw_1.object.anio[1]
     ls_mes = dw_1.object.mes[1]
	this.retrieve(ls_anio,ls_mes)
end if
end event

event resize;cbx_PowerFilter_vtas.event ue_positionbuttons()
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 6158
integer height = 1604
long backcolor = 67108864
string text = "Anulados"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
shl_3 shl_3
cb_7 cb_7
dw_ats_anulados dw_ats_anulados
end type

on tabpage_3.create
this.shl_3=create shl_3
this.cb_7=create cb_7
this.dw_ats_anulados=create dw_ats_anulados
this.Control[]={this.shl_3,&
this.cb_7,&
this.dw_ats_anulados}
end on

on tabpage_3.destroy
destroy(this.shl_3)
destroy(this.cb_7)
destroy(this.dw_ats_anulados)
end on

type shl_3 from statichyperlink within tabpage_3
integer x = 2651
integer y = 16
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Autofiltro"
boolean focusrectangle = false
end type

event clicked;cbx_Powerfilter_anu.enabled = TRUE
cbx_PowerFilter_anu.of_setdw(dw_ats_anulados)
end event

type cb_7 from commandbutton within tabpage_3
integer x = 14
integer y = 12
integer width = 1710
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Click aqu$$HEX2$$ed002000$$ENDHEX$$para generar ATS de anulados"
boolean flatstyle = true
end type

event clicked;String ls_mes,ls_anio,ls_tipo,ls_estab,ls_pto,ls_sec,ls_periodo
string   ls_leyenda
long ll_reg



ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]


ls_periodo = ls_mes+'/'+ls_anio


SELECT COUNT(1)
INTO    :ll_reg
FROM   AN_ANULADOS
WHERE ANIO = :ls_anio
AND     MES   = :ls_mes;

IF ll_reg > 0 then
   If	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ya existen comprobantes de venta anulados ingresados para este per$$HEX1$$ed00$$ENDHEX$$odo....Desea sobreescribir...?",Question!,YesNO!,2) = 2 then 
         return	
  else
		DELETE FROM AN_ANULADOS
		WHERE ANIO = :ls_anio
		AND      MES =  :ls_mes;
		
		IF SQLCA.SQLCODE <> 0 THEN
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al eliminar los comprobantes de venta...."+sqlca.sqlerrtext)
			rollback;
			return
		END IF
		
  end if
End if




INSERT INTO AN_ANULADOS
SELECT to_char(ve_fecha,'YYYY') ,to_char(ve_fecha,'MM'),rownum,
'01' tipo, '001' estab, '001', ve_numpre ,ve_numpre,'9999999999'
FROM FA_VENTA
WHERE ES_CODIGO IN (5,6)
AND TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo;

IF SQLCA.SQLCODE <> 0 THEN
	Messagebox("Atencion","Problemas al insertar comprobantes de venta anulados...Por favor verifique...!!!"+sqlca.sqlerrtext)
	Rollback;
	Return
END IF
	


Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo ...se ha generado el anexo de comprobantes anulados del per$$HEX1$$ed00$$ENDHEX$$odo...'"+is_periodo+"'")
tab_1.tabpage_3.dw_ats_anulados.retrieve(ls_anio,ls_mes)
w_marco.SetMicrohelp("Listo....")
COMMIT;
SetPointer(Arrow!)

end event

type dw_ats_anulados from datawindow within tabpage_3
event ue_postinsert pbm_custom31
event ue_ pbm_dwnlbuttonup
event ue_leftbutondnw pbm_dwnlbuttonup
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 108
integer width = 5568
integer height = 1516
integer taborder = 20
string title = "none"
string dataobject = "d_ats_anulados"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event ue_postinsert;//if dwo.name = 'b_2' then}
String ls_anio,ls_mes
ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]

	this.object.anio[this.getrow()] = ls_anio
	this.object.mes[this.getrow()] = ls_mes
//end if
end event

event ue_leftbuttonup;cbx_Powerfilter_anu.event post ue_buttonclicked(dwo.type,dwo.name)
end event

event constructor;this.SetTransObject(sqlca)
end event

event buttonclicked;String ls_anio,ls_mes


ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]

if dwo.name = 'b_1' then
	this.retrieve(ls_anio,ls_mes)
end if



end event

event resize;cbx_PowerFilter_anu.event ue_positionbuttons()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 6158
integer height = 1604
long backcolor = 67108864
string text = "                REOC"
long tabtextcolor = 33554432
long tabbackcolor = 134217731
long picturemaskcolor = 536870912
shl_4 shl_4
st_2 st_2
dw_reoc dw_reoc
end type

on tabpage_4.create
this.shl_4=create shl_4
this.st_2=create st_2
this.dw_reoc=create dw_reoc
this.Control[]={this.shl_4,&
this.st_2,&
this.dw_reoc}
end on

on tabpage_4.destroy
destroy(this.shl_4)
destroy(this.st_2)
destroy(this.dw_reoc)
end on

type shl_4 from statichyperlink within tabpage_4
integer x = 2661
integer y = 20
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Autofiltro"
boolean focusrectangle = false
end type

event clicked;cbx_PowerFilter_reoc.ENABLED  = TRUE
cbx_PowerFilter_reoc.of_setdw(dw_reoc)
end event

type st_2 from statictext within tabpage_4
integer x = 32
integer y = 24
integer width = 1650
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Primero genere el  ATS de compras para recuperar REOC"
boolean focusrectangle = false
end type

type dw_reoc from datawindow within tabpage_4
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 108
integer width = 5527
integer height = 1492
integer taborder = 30
string title = "none"
string dataobject = "d_reoc_compras"
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event ue_leftbuttonup;cbx_Powerfilter_reoc.event post ue_buttonclicked(dwo.type,dwo.name)
end event

event constructor;this.SetTransObject(sqlca)
end event

event buttonclicked;String ls_anio,ls_mes

if dwo.name = 'b_1' then
	
	 ls_anio = dw_1.object.anio[1]
     ls_mes = dw_1.object.mes[1]
	this.retrieve(ls_anio,ls_mes)
end if
end event

event resize;cbx_PowerFilter_anu.event ue_positionbuttons()
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 6158
integer height = 1604
long backcolor = 67108864
string text = "Vista Previa-Compras"
long tabtextcolor = 33554432
long tabbackcolor = 134217731
long picturemaskcolor = 536870912
shl_5 shl_5
dw_vista dw_vista
end type

on tabpage_5.create
this.shl_5=create shl_5
this.dw_vista=create dw_vista
this.Control[]={this.shl_5,&
this.dw_vista}
end on

on tabpage_5.destroy
destroy(this.shl_5)
destroy(this.dw_vista)
end on

type shl_5 from statichyperlink within tabpage_5
integer x = 2661
integer y = 40
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Autofiltro"
boolean focusrectangle = false
end type

event clicked;
cbx_vista.ENABLED  = TRUE
cbx_vista.of_setdw(dw_vista)

cbx_vista.of_SetColumns({'pr_empre_em_ruc','anio','mes','mp_tipidprv',+&
'pv_rucci','mp_tipodoc','mp_naut','mp_docnroest',+&
'mp_docnropto','mp_docnrosec','mp_fecemision','pm_codpct','pm_porctje',+&
'base0','basegrav','basenograv','valor',+&
'autret','estabret','ptoemiret','secret','fecemiret',+&
'bseimp','autret1','estabret1','ptoemiret1','secret1','fecemiret1'+&
'mp_codtribu','mp_bseimpice','bseimptrf0','baseimp',+&
'montoice','valret','retivabienes','retivaserv','retiva100',+&
'modtipodoc','modnroest','docnropto','modnrosec','modnaut','mp_fecemision_1' }) 

end event

type dw_vista from datawindow within tabpage_5
event pbm_dwnlbuttonup ( )
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 6162
integer height = 1484
integer taborder = 40
string title = "none"
string dataobject = "d_ats_compras_preview"
boolean border = false
boolean hsplitscroll = true
end type

event ue_leftbuttonup;cbx_vista.event post ue_buttonclicked(dwo.type,dwo.name)

end event

event buttonclicked;String ls_anio,ls_mes,ls_periodo

if dwo.name = 'b_1' then
	 ls_anio = dw_1.object.anio[1]
      ls_mes = dw_1.object.mes[1]
	ls_periodo = ls_mes+'/'+ls_anio	
	 this.retrieve(ls_periodo)
end if
end event

event constructor;
this.SetTransObject(sqlca)
//cbx_vista.Of_SetDW(this)
end event

event resize;cbx_vista.event ue_positionbuttons()
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 6158
integer height = 1604
long backcolor = 67108864
string text = "Compras detalladas"
long tabtextcolor = 33554432
long tabbackcolor = 134217731
long picturemaskcolor = 536870912
dw_ats_compras_detalladas dw_ats_compras_detalladas
end type

on tabpage_6.create
this.dw_ats_compras_detalladas=create dw_ats_compras_detalladas
this.Control[]={this.dw_ats_compras_detalladas}
end on

on tabpage_6.destroy
destroy(this.dw_ats_compras_detalladas)
end on

type dw_ats_compras_detalladas from datawindow within tabpage_6
integer y = 24
integer width = 6153
integer height = 1580
integer taborder = 20
string title = "none"
string dataobject = "d_ats_compras_detalladas"
boolean border = false
boolean hsplitscroll = true
end type

event buttonclicked;String ls_anio,ls_mes
if dwo.name = 'b_1' then
	ls_anio = dw_1.object.anio[1]
     ls_mes = dw_1.object.mes[1]
	this.retrieve(ls_anio,ls_mes)
end if
end event

event constructor;this.SetTransObject(sqlca)
end event

type cbx_powerfilter_ats from u_powerfilter_checkbox within w_rep_ats
string tag = "MULTILANG Filter"
integer x = 4247
integer y = 44
integer width = 425
boolean bringtotop = true
integer textsize = -8
boolean enabled = false
string text = "&Filtrar compras"
end type

type cbx_powerfilter_vtas from u_powerfilter_checkbox within w_rep_ats
string tag = "Spanish Filter"
integer x = 4247
integer y = 116
integer width = 393
boolean bringtotop = true
integer textsize = -8
boolean enabled = false
string text = "&Filtrar ventas"
boolean bubblestyle = true
boolean keepnewrows = true
end type

type cbx_powerfilter_anu from u_powerfilter_checkbox within w_rep_ats
integer x = 4247
integer y = 184
integer width = 448
boolean bringtotop = true
integer textsize = -8
boolean enabled = false
string text = "&Filtrar Anulados"
end type

type cbx_powerfilter_reoc from u_powerfilter_checkbox within w_rep_ats
integer x = 4731
integer y = 44
integer width = 370
boolean bringtotop = true
integer textsize = -8
boolean enabled = false
string text = "&Filtrar REOC"
boolean lefttext = true
end type

type cbx_vista from u_powerfilter_checkbox within w_rep_ats
integer x = 4731
integer y = 144
integer width = 370
boolean bringtotop = true
integer textsize = -8
boolean enabled = false
string text = "&Filtrar Vista"
boolean lefttext = true
end type

type cb_1 from commandbutton within w_rep_ats
integer x = 1691
integer y = 80
integer width = 773
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GENERAR PLANTILLA"
end type

event clicked;String ls_anio,ls_mes
String ls_nulo 

Integer li_cc,li_filaux

datawindow ldw_compras,ldw_vtas,ldw_anulados,ldw_compras_det

ldw_compras_det = tab_1.tabpage_6.dw_ats_compras_detalladas
ldw_compras  = tab_1.tabpage_1.dw_ats_compras
ldw_vtas        = tab_1.tabpage_2.dw_ats_vtas
ldw_anulados = tab_1.tabpage_3.dw_ats_anulados

SetNull( ls_nulo )

OleObject ole_excel 
//if dwo.name = 'b_1' then
	
	ls_anio = dw_1.object.anio[1]
     ls_mes = dw_1.object.mes[1]
	ldw_compras.retrieve(ls_anio,ls_mes)
//end if

//if dwo.name = 'b_5' then
String ls_path,ls_ruc,ls_razonsocial,ls_periodo
OLEObject ole1,oleChild
Decimal {2} lc_totalvtas

integer rs,li_fila,i
	
		
ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio

ole1= CREATE OLEObject
rs = ole1.ConnectToNewObject("Excel.Application")
ls_Path = "C:\LIBIAK\archivos\Plantilla_ATS_2013.xlsx"


oleChild = CREATE oleobject

rs = oleChild.SetAutomationPointer(ole1 )

IF ( rs = 0 ) THEN
          oleChild.workbooks.open(ls_Path)
	    //Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a informante de la plantilla
		//inicia en la fila 2
		
		SELECT EM_RUC,EM_NOMBRE
		into :ls_ruc,:ls_razonsocial
		FROM PR_EMPRE;
		
		
		SELECT sum(ve_neto)
		INTO :lc_totalvtas
		FROM FA_VENTA
		WHERE ES_CODIGO IN (1,2)
		AND TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo;
		
		
	     oleChild.worksheets(1).cells(2,1 ).value ='R'
		oleChild.worksheets(1).cells(2,2 ).value = ls_ruc
		oleChild.worksheets(1).cells(2,3 ).value = ls_razonsocial
		oleChild.worksheets(1).cells(2,4 ).value = ls_anio
		oleChild.worksheets(1).cells(2,5 ).value = ls_mes
		oleChild.worksheets(1).cells(2,6 ).value = '001'
         oleChild.worksheets(1).cells(2,7 ).value = lc_totalvtas
        
		//1. Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a Compras detalladas  
		//Inicia en la fila 3
	     li_cc =  ldw_compras_det.rowcount( )
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las compras...")
		end if
		  
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando compras...'
				 		  
		for i = 1 to li_cc
			li_fila = i + 2
			oleChild.worksheets(2).cells(li_fila,1 ).value ='compra'+ldw_compras_det.object.mp_codigo[i]
			oleChild.worksheets(2).cells(li_fila,2 ).value = ldw_compras_det.object.codsustento[ i ]
			oleChild.worksheets(2).cells(li_fila,3 ).value = ldw_compras_det.object.tpidprov [ i ]
			oleChild.worksheets(2).cells(li_fila,4 ).value =ldw_compras_det.object.idprov[ i ]
			oleChild.worksheets(2).cells(li_fila,5 ).value =ldw_compras_det.object.tipocomp[ i ]
			oleChild.worksheets(2).cells(li_fila,6 ).value = ls_nulo
			oleChild.worksheets(2).cells(li_fila,7 ).value = ls_nulo
			oleChild.worksheets(2).cells(li_fila,8 ).value = ldw_compras_det.object.fecharegistro[ i ]
			oleChild.worksheets(2).cells(li_fila,9 ).value =ldw_compras_det.object.establecimiento[i ]
			oleChild.worksheets(2).cells(li_fila,10).value = ldw_compras_det.object.puntoemision[i ]
			oleChild.worksheets(2).cells(li_fila,11 ).value =ldw_compras_det.object.secuencial[i ]
			oleChild.worksheets(2).cells(li_fila,12).value = ldw_compras_det.object.fechaemision[ i ]
			oleChild.worksheets(2).cells(li_fila,13 ).value =ldw_compras_det.object.autorizacion[ i ]
			oleChild.worksheets(2).cells(li_fila,14 ).value = ldw_compras_det.object.basenograiva[ i ]
			oleChild.worksheets(2).cells(li_fila,15 ).value = ldw_compras_det.object.baseimponible[ i ]
			oleChild.worksheets(2).cells(li_fila,16 ).value = ldw_compras_det.object.baseimpgrav[ i ]
			oleChild.worksheets(2).cells(li_fila,17 ).value = ldw_compras_det.object.montoice[ i ]
			oleChild.worksheets(2).cells(li_fila,18 ).value = ldw_compras_det.object.montoiva[ i ]
			oleChild.worksheets(2).cells(li_fila,19 ).value = ldw_compras_det.object.valorretbienes[ i ]
			oleChild.worksheets(2).cells(li_fila,20 ).value = ldw_compras_det.object.valorretservicios[ i ]
			oleChild.worksheets(2).cells(li_fila,21 ).value = ldw_compras_det.object.valorret100[ i ]
			
			oleChild.worksheets(2).cells(li_fila,22 ).value = '01'
			oleChild.worksheets(2).cells(li_fila,23 ).value = 'NA'
			oleChild.worksheets(2).cells(li_fila,24 ).value = 'NA'
			oleChild.worksheets(2).cells(li_fila,25 ).value = 'NA'
			oleChild.worksheets(2).cells(li_fila,26 ).value = ldw_compras_det.object.estabret[i ]
			oleChild.worksheets(2).cells(li_fila,27 ).value = ldw_compras_det.object.ptoemiret[ i ]
		     oleChild.worksheets(2).cells(li_fila,28 ).value = ldw_compras_det.object.secret[ i ]
			oleChild.worksheets(2).cells(li_fila,29).value = ldw_compras_det.object.autret[ i ]
			oleChild.worksheets(2).cells(li_fila,30 ).value = ldw_compras_det.object.fechaemiret1[i]
			
			
			oleChild.worksheets(2).cells(li_fila,31 ).value = ldw_compras_det.object.docmodificado[ i ]
			oleChild.worksheets(2).cells(li_fila,32).value = ldw_compras_det.object.estabmodificado[ i ]
			oleChild.worksheets(2).cells(li_fila,33 ).value = ldw_compras_det.object.ptoemimodificado[i ]
			oleChild.worksheets(2).cells(li_fila,34 ).value = ldw_compras_det.object.secmodificado[ i ]
			
			oleChild.worksheets(2).cells(li_fila,35 ).value = ldw_compras_det.object.autmodificado[ i ]
			hpb_1.Stepit()
		next
			
			/*1.1 Compras por formas de pago*/
			/*Inicia el volcado en la fila 3*/
			
		li_cc =  ldw_compras.rowcount( )
		if li_cc = 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las compras...")
		end if
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando compras retenciones...'

		li_filaux = 3
	    for i = 1 to li_cc

			if (ldw_compras.object.basenograiva[ i ]+ldw_compras.object.baseimponible[ i ] + ldw_compras.object.baseimpgrav[ i ] +  ldw_compras.object.montoiva[ i ]+ ldw_compras.object.montoice[ i ]) > 1000 then
				 oleChild.worksheets(3 ).cells(li_filaux,1 ).value = ldw_compras.object.mp_codigo[i ] 
			     oleChild.worksheets(3 ).cells(li_filaux,2 ).value = '02' //Cheque propio
				 li_filaux++ 
			end if	
		     
			  
			 //1.2 Compras Retenciones
			 //Inicia el volcado en la fila 2
			 li_fila =  i + 1
			oleChild.worksheets(4 ).cells(li_fila,1 ).value = 'compra'+ ldw_compras.object.mp_codigo[ i ]
			oleChild.worksheets(4 ).cells(li_fila,2).value = ldw_compras.object.codretair[ i ]
			oleChild.worksheets(4 ).cells(li_fila,3 ).value = ldw_compras.object.baseimpair[i ]
			oleChild.worksheets(4 ).cells(li_fila,4 ).value = ldw_compras.object.porcentaje[ i ]
			oleChild.worksheets(4 ).cells(li_fila,5).value = ldw_compras.object.valretair[ i ]
			
			hpb_1.Stepit()
		 next   
	     
		
		//2.   Inicia volcado de vtas
		//2.1 Vtas  por cliente
		 li_cc =   ldw_vtas.rowcount()
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las ventas...")
	     end if
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando ventas...'
		for i =  1 to li_cc
			li_fila = i + 1
			oleChild.worksheets(6 ).cells(li_fila,1 ).value = ldw_vtas.object.tpidcliente[ i ]
			oleChild.worksheets(6 ).cells(li_fila,2).value = ldw_vtas.object.idcliente[ i ]
			oleChild.worksheets(6 ).cells(li_fila,3 ).value = ldw_vtas.object.tipocomprobante[i ]
			oleChild.worksheets(6 ).cells(li_fila,4 ).value = ldw_vtas.object.numerocomprobantes[ i ]
			oleChild.worksheets(6 ).cells(li_fila,5).value = ldw_vtas.object.basenograiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,6 ).value = ldw_vtas.object.baseimponible[i ]
			oleChild.worksheets(6 ).cells(li_fila,7 ).value = ldw_vtas.object.baseimpgrav[ i ]
			oleChild.worksheets(6 ).cells(li_fila,8).value = ldw_vtas.object.montoiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,9 ).value = ldw_vtas.object.valorretiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,10).value = ldw_vtas.object.valorretrenta[ i ]
			hpb_1.Stepit()
		next

         //2.2 Vtas por establecimiento
		String ls_suc
		Decimal lc_vtaneta
		declare c1 cursor for
          select su_codigo,sum(ve_neto) from fa_venta where TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo and es_codigo in (1,2) group by su_codigo;
		
		open c1;	 
		li_fila = 2
      	do 
				
			FETCH c1 INTO :ls_suc, :lc_vtaneta;
			if sqlca.sqlcode <> 0 then
			exit;
			end if
		
			//Inicia el volcado en vtas por establecimiento
			  oleChild.worksheets(7 ).cells(li_fila,1 ).value = ls_suc//
			  oleChild.worksheets(7 ).cells(li_fila,2).value = lc_vtaneta //
			  li_fila = li_fila + 1
	     loop while TRUE
		close c1;
		
		
		//3.Inicia el volcado de comprobantes anulados
		 li_cc =   ldw_anulados.rowcount()
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere los comprobantes anulados...")
	     end if
		
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando comprobantes anulados...'  
		
		
		
		for i =  1 to ldw_anulados.rowcount()
			li_fila = i + 1
			oleChild.worksheets(13).cells(li_fila,1 ).value = ldw_anulados.object.tipocomprobante[ i ]
			oleChild.worksheets(13 ).cells(li_fila,2).value = ldw_anulados.object.establecimiento[ i ]
			oleChild.worksheets(13 ).cells(li_fila,3 ).value = ldw_anulados.object.puntoemision[i ]
			oleChild.worksheets(13 ).cells(li_fila,4 ).value = ldw_anulados.object.secuencialinicio[ i ]
			oleChild.worksheets(13 ).cells(li_fila,5).value = ldw_anulados.object.secuencialfin[ i ]
			oleChild.worksheets(13 ).cells(li_fila,6 ).value = ldw_anulados.object.autorizacion[i ]
			hpb_1.Stepit()
		next
		
		
		oleChild.activeworkbook.saveas("C:libiak\archivos\ats.xlsx")
          oleChild.activeworkbook.close()

      oleChild.quit()

END IF

ole1.disconnectobject()
DESTROY oleChild

DESTROY ole1
st_3.text = 'Proceso terminado...'
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo archivo generado con $$HEX1$$e900$$ENDHEX$$xito...en la siguiente direcci$$HEX1$$f300$$ENDHEX$$n:   C:\libiak\archivos\ats.xlsx")




end event

type gb_1 from groupbox within w_rep_ats
integer x = 4160
integer width = 1019
integer height = 280
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = " "
end type

type dw_1 from datawindow within w_rep_ats
integer x = 5
integer y = 92
integer width = 1563
integer height = 164
integer taborder = 30
string title = "none"
string dataobject = "d_ext_periodo"
boolean border = false
boolean livescroll = true
end type

event itemchanged;this.acceptText()
cb_2.triggerevent(clicked!)
end event

type hpb_1 from hprogressbar within w_rep_ats
integer x = 1691
integer y = 204
integer width = 773
integer height = 60
boolean bringtotop = true
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type st_3 from statictext within w_rep_ats
integer x = 2656
integer y = 192
integer width = 1111
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

event clicked;String ls_anio,ls_mes
String ls_nulo 

Integer li_cc

datawindow ldw_compras,ldw_vtas,ldw_anulados,ldw_compras_det

ldw_compras_det = tab_1.tabpage_6.dw_ats_compras_detalladas
ldw_compras  = tab_1.tabpage_1.dw_ats_compras
ldw_vtas        = tab_1.tabpage_2.dw_ats_vtas
ldw_anulados = tab_1.tabpage_3.dw_ats_anulados

SetNull( ls_nulo )

OleObject ole_excel 
//if dwo.name = 'b_1' then
	
	ls_anio = dw_1.object.anio[1]
     ls_mes = dw_1.object.mes[1]
	ldw_compras.retrieve(ls_anio,ls_mes)
//end if

//if dwo.name = 'b_5' then
String ls_path,ls_ruc,ls_razonsocial,ls_periodo
OLEObject ole1,oleChild
Decimal {2} lc_totalvtas

integer rs,li_fila,i
	
		
ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio

ole1= CREATE OLEObject
rs = ole1.ConnectToNewObject("Excel.Application")
ls_Path = "C:\LIBIAK\archivos\Plantilla_ATS_2013.xlsx"


oleChild = CREATE oleobject

rs = oleChild.SetAutomationPointer(ole1 )

IF ( rs = 0 ) THEN
          oleChild.workbooks.open(ls_Path)
	    //Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a informante de la plantilla
		//inicia en la fila 2
		
		SELECT EM_RUC,EM_NOMBRE
		into :ls_ruc,:ls_razonsocial
		FROM PR_EMPRE;
		
		
		SELECT sum(ve_neto)
		INTO :lc_totalvtas
		FROM FA_VENTA
		WHERE ES_CODIGO IN (1,2)
		AND TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo;
		
		
	     oleChild.worksheets(1).cells(2,1 ).value ='R'
		oleChild.worksheets(1).cells(2,2 ).value = ls_ruc
		oleChild.worksheets(1).cells(2,3 ).value = ls_razonsocial
		oleChild.worksheets(1).cells(2,4 ).value = ls_anio
		oleChild.worksheets(1).cells(2,5 ).value = ls_mes
		oleChild.worksheets(1).cells(2,6 ).value = '001'
         oleChild.worksheets(1).cells(2,7 ).value = lc_totalvtas
        
		//1. Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a Compras detalladas  
		//Inicia en la fila 3
	     li_cc =  ldw_compras_det.rowcount( )
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las compras...")
		return 
	     end if
		  
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando compras...'
				 		  
		for i = 1 to li_cc
			li_fila = i + 2
			oleChild.worksheets(2).cells(li_fila,1 ).value ='compra'+ldw_compras_det.object.mp_codigo[i]
			oleChild.worksheets(2).cells(li_fila,2 ).value = ldw_compras_det.object.codsustento[ i ]
			oleChild.worksheets(2).cells(li_fila,3 ).value = ldw_compras_det.object.tpidprov [ i ]
			oleChild.worksheets(2).cells(li_fila,4 ).value =ldw_compras_det.object.idprov[ i ]
			oleChild.worksheets(2).cells(li_fila,5 ).value =ldw_compras_det.object.tipocomp[ i ]
			oleChild.worksheets(2).cells(li_fila,6 ).value = ls_nulo
			oleChild.worksheets(2).cells(li_fila,7 ).value = ls_nulo
			oleChild.worksheets(2).cells(li_fila,8 ).value =ldw_compras_det.object.fecharegistro[ i ]
			oleChild.worksheets(2).cells(li_fila,9 ).value =ldw_compras_det.object.establecimiento[i ]
			oleChild.worksheets(2).cells(li_fila,10).value = ldw_compras_det.object.puntoemision[i ]
			oleChild.worksheets(2).cells(li_fila,11 ).value =ldw_compras_det.object.secuencial[i ]
			oleChild.worksheets(2).cells(li_fila,12).value = ldw_compras_det.object.fechaemision[ i ]
			oleChild.worksheets(2).cells(li_fila,13 ).value =ldw_compras_det.object.autorizacion[ i ]
			oleChild.worksheets(2).cells(li_fila,14 ).value = ldw_compras_det.object.basenograiva[ i ]
			oleChild.worksheets(2).cells(li_fila,15 ).value = ldw_compras_det.object.baseimponible[ i ]
			oleChild.worksheets(2).cells(li_fila,16 ).value = ldw_compras_det.object.baseimpgrav[ i ]
			oleChild.worksheets(2).cells(li_fila,17 ).value = ldw_compras_det.object.montoice[ i ]
			oleChild.worksheets(2).cells(li_fila,18 ).value = ldw_compras_det.object.montoiva[ i ]
			oleChild.worksheets(2).cells(li_fila,19 ).value = ldw_compras_det.object.valorretbienes[ i ]
			oleChild.worksheets(2).cells(li_fila,20 ).value = ldw_compras_det.object.valorretservicios[ i ]
			oleChild.worksheets(2).cells(li_fila,21 ).value = ldw_compras_det.object.valorret100[ i ]
			
			oleChild.worksheets(2).cells(li_fila,22 ).value = '01'
			oleChild.worksheets(2).cells(li_fila,23 ).value = 'NA'
			oleChild.worksheets(2).cells(li_fila,24 ).value = 'NA'
			oleChild.worksheets(2).cells(li_fila,25 ).value = 'NA'
			oleChild.worksheets(2).cells(li_fila,26 ).value = ldw_compras_det.object.estabret[i ]
			oleChild.worksheets(2).cells(li_fila,27 ).value = ldw_compras_det.object.ptoemiret[ i ]
		     oleChild.worksheets(2).cells(li_fila,28 ).value = ldw_compras_det.object.secret[ i ]
			oleChild.worksheets(2).cells(li_fila,29).value = ldw_compras_det.object.autret[ i ]
			oleChild.worksheets(2).cells(li_fila,30 ).value = ldw_compras_det.object.fechaemiret1[i ]
			oleChild.worksheets(2).cells(li_fila,31 ).value = ldw_compras_det.object.ptoemiret[ i ]
			
			oleChild.worksheets(2).cells(li_fila,32 ).value = ldw_compras_det.object.docmodificado[ i ]
			oleChild.worksheets(2).cells(li_fila,33).value = ldw_compras_det.object.estabmodificado[ i ]
			oleChild.worksheets(2).cells(li_fila,34 ).value = ldw_compras_det.object.ptoemimodificado[i ]
			oleChild.worksheets(2).cells(li_fila,35 ).value = ldw_compras_det.object.secmodificado[ i ]
			
			oleChild.worksheets(2).cells(li_fila,36 ).value = ldw_compras_det.object.autmodificado[ i ]
			
			hpb_1.Stepit()
		next
			
			/*1.1 Compras por formas de pago*/
			/*Inicia el volcado en la fila 3*/
			
		li_cc =  ldw_compras.rowcount( )
		if li_cc = 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las compras...")
		return 
		end if
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando compras retenciones...'

		
	    for i = 1 to li_cc
			li_fila = i + 2
			if (ldw_compras.object.basenograiva[ i ]+ldw_compras.object.baseimponible[ i ] + ldw_compras.object.baseimpgrav[ i ] +  ldw_compras.object.montoiva[ i ]+ ldw_compras.object.montoice[ i ]) > 1000 then
				oleChild.worksheets(3 ).cells(li_fila,1 ).value = ldw_compras.object.mp_codigo[i ] 
			     oleChild.worksheets(3 ).cells(li_fila,2 ).value = '02' //Cheque propio
			end if	
		     
			  
			 //1.2 Compras Retenciones
			 //Inicia el volcado en la fila 2
			 li_fila =  i + 1
			oleChild.worksheets(4 ).cells(li_fila,1 ).value = 'compra'+ ldw_compras.object.mp_codigo[ i ]
			oleChild.worksheets(4 ).cells(li_fila,2).value = ldw_compras.object.codretair[ i ]
			oleChild.worksheets(4 ).cells(li_fila,3 ).value = ldw_compras.object.baseimpair[i ]
			oleChild.worksheets(4 ).cells(li_fila,4 ).value = ldw_compras.object.porcentaje[ i ]
			oleChild.worksheets(4 ).cells(li_fila,5).value = ldw_compras.object.valretair[ i ]
			
			hpb_1.Stepit()
		 next   
	     
		
		//2.   Inicia volcado de vtas
		//2.1 Vtas  por cliente
		 li_cc =   ldw_vtas.rowcount()
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las ventas...")
		return 
	     end if
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando ventas...'
		for i =  1 to li_cc
			li_fila = i + 1
			oleChild.worksheets(6 ).cells(li_fila,1 ).value = ldw_vtas.object.tpidcliente[ i ]
			oleChild.worksheets(6 ).cells(li_fila,2).value = ldw_vtas.object.idcliente[ i ]
			oleChild.worksheets(6 ).cells(li_fila,3 ).value = ldw_vtas.object.tipocomprobante[i ]
			oleChild.worksheets(6 ).cells(li_fila,4 ).value = ldw_vtas.object.numerocomprobantes[ i ]
			oleChild.worksheets(6 ).cells(li_fila,5).value = ldw_vtas.object.basenograiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,6 ).value = ldw_vtas.object.baseimponible[i ]
			oleChild.worksheets(6 ).cells(li_fila,7 ).value = ldw_vtas.object.baseimpgrav[ i ]
			oleChild.worksheets(6 ).cells(li_fila,8).value = ldw_vtas.object.montoiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,9 ).value = ldw_vtas.object.valorretiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,10).value = ldw_vtas.object.valorretrenta[ i ]
			hpb_1.Stepit()
		next

         //2.2 Vtas por establecimiento
		String ls_suc
		Decimal lc_vtaneta
		declare c1 cursor for
          select su_codigo,sum(ve_neto) from fa_venta where TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo and es_codigo in (1,2) group by su_codigo;
		
		open c1;	 
		li_fila = 2
      	do 
				
			FETCH c1 INTO :ls_suc, :lc_vtaneta;
			if sqlca.sqlcode <> 0 then
			exit;
			end if
		
			//Inicia el volcado en vtas por establecimiento
			  oleChild.worksheets(7 ).cells(li_fila,1 ).value = ls_suc//
			  oleChild.worksheets(7 ).cells(li_fila,2).value = lc_vtaneta //
			  li_fila = li_fila + 1
	     loop while TRUE
		close c1;
		
		
		//3.Inicia el volcado de comprobantes anulados
		 li_cc =   ldw_anulados.rowcount()
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere los comprobantes anulados...")
		return 
	     end if
		
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando comprobantes anulados...'  
		
		
		
		for i =  1 to ldw_anulados.rowcount()
			li_fila = i + 1
			oleChild.worksheets(13).cells(li_fila,1 ).value = ldw_anulados.object.tipocomprobante[ i ]
			oleChild.worksheets(13 ).cells(li_fila,2).value = ldw_anulados.object.establecimiento[ i ]
			oleChild.worksheets(13 ).cells(li_fila,3 ).value = ldw_anulados.object.puntoemision[i ]
			oleChild.worksheets(13 ).cells(li_fila,4 ).value = ldw_anulados.object.secuencialinicio[ i ]
			oleChild.worksheets(13 ).cells(li_fila,5).value = ldw_anulados.object.secuencialfin[ i ]
			oleChild.worksheets(13 ).cells(li_fila,6 ).value = ldw_anulados.object.autorizacion[i ]
			hpb_1.Stepit()
		next
		
		
		oleChild.activeworkbook.saveas("C:libiak\archivos\ats.xlsx")
          oleChild.activeworkbook.close()

      oleChild.quit()

END IF

ole1.disconnectobject()
DESTROY oleChild

DESTROY ole1
st_3.text = 'Proceso terminado...'
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo archivo generado con $$HEX1$$e900$$ENDHEX$$xito...en la siguiente direcci$$HEX1$$f300$$ENDHEX$$n:   C:\libiak\archivos\ats.xlsx")




end event

type cb_2 from commandbutton within w_rep_ats
boolean visible = false
integer x = 1477
integer y = 156
integer width = 681
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar datos"
boolean default = true
end type

event clicked;String ls_anio,ls_mes,ls_periodo


	
ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio	
	  
	  
tab_1.tabpage_1.dw_ats_compras.retrieve(ls_anio,ls_mes)
//tab_1.tabpage_2.dw_ats_vtas.retrieve(ls_anio,ls_mes)
//tab_1.tabpage_3.dw_ats_anulados.retrieve(ls_anio,ls_mes)
//tab_1.tabpage_4.dw_reoc.retrieve(ls_anio,ls_mes)
//tab_1.tabpage_5.dw_vista.retrieve(ls_periodo)
//tab_1.tabpage_6.dw_ats_compras_detalladas.retrieve(ls_anio,ls_mes)
end event

type cb_3 from commandbutton within w_rep_ats
integer x = 2482
integer y = 80
integer width = 773
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GENERAR PLANTILLA 2015"
end type

event clicked;String ls_anio,ls_mes
String ls_nulo 

Integer li_cc,li_filaux

datawindow ldw_compras,ldw_vtas,ldw_anulados,ldw_compras_det

ldw_compras_det = tab_1.tabpage_6.dw_ats_compras_detalladas
ldw_compras  = tab_1.tabpage_1.dw_ats_compras
ldw_vtas        = tab_1.tabpage_2.dw_ats_vtas
ldw_anulados = tab_1.tabpage_3.dw_ats_anulados

SetNull( ls_nulo )

OleObject ole_excel 
//if dwo.name = 'b_1' then
	
	ls_anio = dw_1.object.anio[1]
     ls_mes = dw_1.object.mes[1]
	ldw_compras.retrieve(ls_anio,ls_mes)
//end if

//if dwo.name = 'b_5' then
String ls_path,ls_ruc,ls_razonsocial,ls_periodo
OLEObject ole1,oleChild
Decimal {2} lc_totalvtas
integer rs,li_fila,i
	
Setpointer(Hourglass!)		
w_marco.SetMicrohelp("Por favor espere...se est$$HEX2$$e1002000$$ENDHEX$$generando el archivo...!!!")

ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio

ole1= CREATE OLEObject
rs = ole1.ConnectToNewObject("Excel.Application")
ls_Path = "C:\LIBIAK\archivos\Plantilla_ATS_2015.xlsx"


oleChild = CREATE oleobject

rs = oleChild.SetAutomationPointer(ole1 )

IF ( rs = 0 ) THEN
          oleChild.workbooks.open(ls_Path)
	    //Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a informante de la plantilla
		//inicia en la fila 2
		
		SELECT EM_RUC,EM_NOMBRE
		into :ls_ruc,:ls_razonsocial
		FROM PR_EMPRE;
		
		
		SELECT sum(ve_neto)
		INTO :lc_totalvtas
		FROM FA_VENTA
		WHERE ES_CODIGO IN (1,2)
		AND TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo;
		
		
	     oleChild.worksheets(1).cells(2,1 ).value ='R'
		oleChild.worksheets(1).cells(2,2 ).value = ls_ruc
		oleChild.worksheets(1).cells(2,3 ).value = ls_razonsocial
		oleChild.worksheets(1).cells(2,4 ).value = ls_anio
		oleChild.worksheets(1).cells(2,5 ).value = ls_mes
		oleChild.worksheets(1).cells(2,6 ).value = '001'
         oleChild.worksheets(1).cells(2,7 ).value = lc_totalvtas
        
		//1. Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a Compras detalladas  
		//Inicia en la fila 3
	     li_cc =  ldw_compras_det.rowcount( )
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las compras...")
		end if
		  
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando compras...'
				 		  
		for i = 1 to li_cc
			li_fila = i + 2
			oleChild.worksheets(2).cells(li_fila,1 ).value ='compra'+ldw_compras_det.object.mp_codigo[i]
			oleChild.worksheets(2).cells(li_fila,2 ).value = ldw_compras_det.object.codsustento[ i ]
			oleChild.worksheets(2).cells(li_fila,3 ).value = ldw_compras_det.object.tpidprov [ i ]
			oleChild.worksheets(2).cells(li_fila,4 ).value = ldw_compras_det.object.idprov[ i ]
			oleChild.worksheets(2).cells(li_fila,5 ).value = ldw_compras_det.object.tipocomp[ i ]
			oleChild.worksheets(2).cells(li_fila,6 ).value = ls_nulo  //tipo de proveedor  nuevo 2015
			oleChild.worksheets(2).cells(li_fila,7 ).value = 'NO'    //Parte relacionada ? nuevo 2015
			oleChild.worksheets(2).cells(li_fila,8 ).value =  ldw_compras_det.object.fecharegistro[ i ]
			oleChild.worksheets(2).cells(li_fila,9 ).value =  ldw_compras_det.object.establecimiento[i ]
			oleChild.worksheets(2).cells(li_fila,10).value = ldw_compras_det.object.puntoemision[i ]
			oleChild.worksheets(2).cells(li_fila,11 ).value =ldw_compras_det.object.secuencial[i ]
			oleChild.worksheets(2).cells(li_fila,12).value = ldw_compras_det.object.fechaemision[ i ]
			oleChild.worksheets(2).cells(li_fila,13 ).value =ldw_compras_det.object.autorizacion[ i ]
			
			oleChild.worksheets(2).cells(li_fila,14 ).value = ldw_compras_det.object.basenograiva[ i ]
			oleChild.worksheets(2).cells(li_fila,15 ).value = ldw_compras_det.object.baseimponible[ i ]
			oleChild.worksheets(2).cells(li_fila,16 ).value = ldw_compras_det.object.baseimpgrav[ i ]
			oleChild.worksheets(2).cells(li_fila,17 ).value = ldw_compras_det.object.baseimpexe[ i ] // base exenta nuevo 2015
			
			oleChild.worksheets(2).cells(li_fila,18 ).value = ldw_compras_det.object.montoice[ i ]
			oleChild.worksheets(2).cells(li_fila,19 ).value = ldw_compras_det.object.montoiva[ i ]
			
			//Retencion de Iva
			oleChild.worksheets(2).cells(li_fila,20 ).value = ldw_compras_det.object.valretbien10[ i ] //10 nuevo 2015
			oleChild.worksheets(2).cells(li_fila,21 ).value = ldw_compras_det.object.valretserv20[ i ] // 20 nuevo 2015
			oleChild.worksheets(2).cells(li_fila,22 ).value = ldw_compras_det.object.valorretbienes[ i ] //30
			oleChild.worksheets(2).cells(li_fila,23 ).value = ldw_compras_det.object.valorretservicios[ i ] // 70
			oleChild.worksheets(2).cells(li_fila,24 ).value = ldw_compras_det.object.valorret100[ i ] //100
						
			oleChild.worksheets(2).cells(li_fila,25 ).value = ldw_compras_det.object.valorretbienes[ i ] //total  bases imponibles
			oleChild.worksheets(2).cells(li_fila,26 ).value = '01' // Pago residente o no
			
		
			oleChild.worksheets(2).cells(li_fila,27 ).value = 'NA'
			oleChild.worksheets(2).cells(li_fila,28).value  = 'NA'
			oleChild.worksheets(2).cells(li_fila,29 ).value = 'NA'
			oleChild.worksheets(2).cells(li_fila,30 ).value = 'NO'
   	
			//Datos  de la retencion
			If  ldw_compras_det.object.tipocomp[ i ] = '01' then
				oleChild.worksheets(2).cells(li_fila,31 ).value = ldw_compras_det.object.estabret[i ]
				oleChild.worksheets(2).cells(li_fila,32 ).value = ldw_compras_det.object.ptoemiret[ i ]
				oleChild.worksheets(2).cells(li_fila,33 ).value = ldw_compras_det.object.secret[ i ]
				oleChild.worksheets(2).cells(li_fila,34).value = ldw_compras_det.object.autret[ i ]
				oleChild.worksheets(2).cells(li_fila,35 ).value = ldw_compras_det.object.fechaemiret1[i]
		     end if
		     
			//Documento modificado por la nota de credito
			//No se llena para el caso de FACTURAS de compra
			If  ldw_compras_det.object.tipocomp[ i ] = '04' then
				oleChild.worksheets(2).cells(li_fila,36 ).value = ldw_compras_det.object.docmodificado[ i ]
				oleChild.worksheets(2).cells(li_fila,37).value  = ldw_compras_det.object.estabmodificado[ i ]
				oleChild.worksheets(2).cells(li_fila,38 ).value = ldw_compras_det.object.ptoemimodificado[i ]
				oleChild.worksheets(2).cells(li_fila,39 ).value = ldw_compras_det.object.secmodificado[ i ]
				oleChild.worksheets(2).cells(li_fila,40 ).value = ldw_compras_det.object.autmodificado[ i ]
              end if
			hpb_1.Stepit()
		next
			
		/*1.1 Compras por formas de pago*/
		/*Inicia el volcado en la fila 3*/
			
		li_cc =  ldw_compras.rowcount( )
		if li_cc = 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las compras...")
		end if
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando compras retenciones...'

		li_filaux = 3
	    for i = 1 to li_cc
		   // Compras forma de pago 
			if (ldw_compras.object.basenograiva[ i ]+ldw_compras.object.baseimponible[ i ] + ldw_compras.object.baseimpgrav[ i ] +  ldw_compras.object.montoiva[ i ]+ ldw_compras.object.montoice[ i ]) > 1000 then
				 oleChild.worksheets(3 ).cells(li_filaux,1 ).value = 'compra'+ldw_compras.object.mp_codigo[i ] 
			     oleChild.worksheets(3 ).cells(li_filaux,2 ).value = '02' //Cheque propio
		         li_filaux ++  // Inicia el volcado en la fila 3	
      		end if	
		   
			  
			 //1.2 Compras Retenciones
			 //Inicia el volcado en la fila 2
			 li_fila =  i + 1
			oleChild.worksheets(4 ).cells(li_fila,1 ).value = 'compra'+ ldw_compras.object.mp_codigo[ i ]
			oleChild.worksheets(4 ).cells(li_fila,2).value  = ldw_compras.object.codretair[ i ]
			oleChild.worksheets(4 ).cells(li_fila,3 ).value = ldw_compras.object.baseimpair[i ]
			oleChild.worksheets(4 ).cells(li_fila,4 ).value = ldw_compras.object.porcentaje[ i ]
			oleChild.worksheets(4 ).cells(li_fila,5).value  = ldw_compras.object.valretair[ i ]
			
			hpb_1.Stepit()
		 next   
	     
		
		//2.   Inicia volcado de vtas
		//2.1 Vtas  por cliente
		 li_cc =   ldw_vtas.rowcount()
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las ventas...")
	     end if
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando ventas...'
		for i =  1 to li_cc
			li_fila = i + 1
			oleChild.worksheets(6 ).cells(li_fila,1 ).value = ldw_vtas.object.tpidcliente[ i ]
			oleChild.worksheets(6 ).cells(li_fila,2).value = ldw_vtas.object.idcliente[ i ]
			if  ldw_vtas.object.tpidcliente[ i ] <> '9999999999999' then
				oleChild.worksheets(6 ).cells(li_fila,3).value = 'NO'
		    end if
			oleChild.worksheets(6 ).cells(li_fila,4 ).value = ldw_vtas.object.tipocomprobante[i ]
			oleChild.worksheets(6 ).cells(li_fila,5 ).value = ldw_vtas.object.numerocomprobantes[ i ]
			oleChild.worksheets(6 ).cells(li_fila,6).value =  ldw_vtas.object.basenograiva[ i ]   // no grava iva
			oleChild.worksheets(6 ).cells(li_fila,7 ).value = ldw_vtas.object.baseimponible[i ] // tarifa 0
			oleChild.worksheets(6 ).cells(li_fila,8 ).value = ldw_vtas.object.baseimpgrav[ i ] //tarifa 12
			oleChild.worksheets(6 ).cells(li_fila,9).value =  ldw_vtas.object.montoiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,10).value = 0.00 //monto ice
			oleChild.worksheets(6 ).cells(li_fila,11).value = ldw_vtas.object.valorretiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,12).value = ldw_vtas.object.valorretrenta[ i ]
			hpb_1.Stepit()
		next

         //2.2 Vtas por establecimiento
		String ls_suc
		Decimal lc_vtaneta
		declare c1 cursor for
         select su_codigo,sum(ve_neto) from fa_venta where TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo and es_codigo in (1,2) group by su_codigo;
		
		open c1;	 
		li_fila = 2
      	do 
				
			FETCH c1 INTO :ls_suc, :lc_vtaneta;
			if sqlca.sqlcode <> 0 then
			exit;
			end if
		
			//Inicia el volcado en vtas por establecimiento
			  oleChild.worksheets(7 ).cells(li_fila,1 ).value = ls_suc//
			  oleChild.worksheets(7 ).cells(li_fila,2).value = lc_vtaneta //
			  li_fila = li_fila + 1
	     loop while TRUE
		close c1;
		
		
		//3.Inicia el volcado de comprobantes anulados
		 li_cc =   ldw_anulados.rowcount()
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere los comprobantes anulados...")
	     end if
		
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando comprobantes anulados...'  
		
		
		
		for i =  1 to ldw_anulados.rowcount()
			li_fila = i + 1
			oleChild.worksheets(13).cells(li_fila,1 ).value = ldw_anulados.object.tipocomprobante[ i ]
			oleChild.worksheets(13 ).cells(li_fila,2).value = ldw_anulados.object.establecimiento[ i ]
			oleChild.worksheets(13 ).cells(li_fila,3 ).value = ldw_anulados.object.puntoemision[i ]
			oleChild.worksheets(13 ).cells(li_fila,4 ).value = ldw_anulados.object.secuencialinicio[ i ]
			oleChild.worksheets(13 ).cells(li_fila,5).value = ldw_anulados.object.secuencialfin[ i ]
			oleChild.worksheets(13 ).cells(li_fila,6 ).value = ldw_anulados.object.autorizacion[i ]
			hpb_1.Stepit()
		next
		 
		
		oleChild.activeworkbook.saveas("C:libiak\archivos\ats.xlsx")
          oleChild.activeworkbook.close()

      oleChild.quit()

END IF

ole1.disconnectobject()
DESTROY oleChild

DESTROY ole1
	
Setpointer(Arrow!)
w_marco.SetMicrohelp("Listo archivo generado con $$HEX1$$e900$$ENDHEX$$xito...en la siguiente direcci$$HEX1$$f300$$ENDHEX$$n:   C:\libiak\archivos\ats.xlsx  !!!")
st_3.text = 'Proceso terminado...'
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo archivo generado con $$HEX1$$e900$$ENDHEX$$xito...en la siguiente direcci$$HEX1$$f300$$ENDHEX$$n:   C:\libiak\archivos\ats.xlsx")




end event

type dw_xml from datawindow within w_rep_ats
boolean visible = false
integer x = 5362
integer y = 36
integer width = 686
integer height = 236
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_ats_xml2015"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_8 from commandbutton within w_rep_ats
integer x = 1696
integer width = 658
integer height = 88
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar XML"
end type

event clicked;String ls_anio,ls_mes

ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]

dw_xml.SetTransObject(sqlca)
dw_xml.Retrieve(ls_anio,ls_mes)

dw_xml.SaveAs("",XML!,false)
end event

type cb_9 from commandbutton within w_rep_ats
integer x = 3287
integer y = 80
integer width = 768
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GENERAR PLANTILLA 2016"
end type

event clicked;String ls_anio,ls_mes,ls_nulo,ls_pvrazons,ls_clie_razons,ls_clie_rucic

Integer li_cc,li_filaux

datawindow ldw_compras,ldw_vtas,ldw_anulados,ldw_compras_det

ldw_compras_det = tab_1.tabpage_6.dw_ats_compras_detalladas
ldw_compras  = tab_1.tabpage_1.dw_ats_compras
ldw_vtas        = tab_1.tabpage_2.dw_ats_vtas
ldw_anulados = tab_1.tabpage_3.dw_ats_anulados

SetNull( ls_nulo )

OleObject ole_excel 
//if dwo.name = 'b_1' then
	
	ls_anio = dw_1.object.anio[1]
     ls_mes = dw_1.object.mes[1]
	ldw_compras.retrieve(ls_anio,ls_mes)
//end if

//if dwo.name = 'b_5' then
String ls_path,ls_ruc,ls_razonsocial,ls_periodo
OLEObject ole1,oleChild
Decimal {2} lc_totalvtas
integer rs,li_fila,i
	
Setpointer(Hourglass!)		
w_marco.SetMicrohelp("Por favor espere...se est$$HEX2$$e1002000$$ENDHEX$$generando el archivo...!!!")

ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio

ole1= CREATE OLEObject
rs = ole1.ConnectToNewObject("Excel.Application")
ls_Path = "C:\LIBIAK\archivos\Plantilla_ATS_2016.xlsx"


oleChild = CREATE oleobject

rs = oleChild.SetAutomationPointer(ole1 )

IF ( rs = 0 ) THEN
          oleChild.workbooks.open(ls_Path)
	    //Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a informante de la plantilla
		//inicia en la fila 2
		
		SELECT EM_RUC,EM_NOMBRE
		into :ls_ruc,:ls_razonsocial
		FROM PR_EMPRE;
		
		
		SELECT sum(ve_neto)
		INTO :lc_totalvtas
		FROM FA_VENTA
		WHERE ES_CODIGO IN (1,2)
		AND TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo;
		
		
	    // oleChild.worksheets(1).cells(2,1 ).value ='R'
		oleChild.worksheets(1).cells(2,1 ).value = ls_ruc
		oleChild.worksheets(1).cells(2,2 ).value = ls_razonsocial
		oleChild.worksheets(1).cells(2,3 ).value = ls_anio
		oleChild.worksheets(1).cells(2,4 ).value = ls_mes
		oleChild.worksheets(1).cells(2,5 ).value = '001'
         oleChild.worksheets(1).cells(2,6 ).value = lc_totalvtas
        
		//1. Inicia el llenado de la pesta$$HEX1$$f100$$ENDHEX$$a Compras detalladas  
		//Inicia en la fila 3
	     li_cc =  ldw_compras_det.rowcount( )
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las compras...")
		end if
		  
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando compras...'
				 		  
		for i = 1 to li_cc
			li_fila = i + 2
			oleChild.worksheets(2).cells(li_fila,1 ).value ='compra'+ldw_compras_det.object.mp_codigo[i]
			oleChild.worksheets(2).cells(li_fila,2 ).value = ldw_compras_det.object.codsustento[ i ]
			oleChild.worksheets(2).cells(li_fila,3 ).value = ldw_compras_det.object.tpidprov [ i ]
			oleChild.worksheets(2).cells(li_fila,4 ).value = ldw_compras_det.object.idprov[ i ]
			oleChild.worksheets(2).cells(li_fila,5 ).value = ldw_compras_det.object.tipocomp[ i ]
			oleChild.worksheets(2).cells(li_fila,6 ).value = ls_nulo  //tipo de proveedor  nuevo 2015
			if  ldw_compras_det.object.tpidprov [ i ] = '03' then
                 ls_ruc = ldw_compras_det.object.idprov[i]
				select pv_razons into :ls_pvrazons from in_prove where pv_rucic = :ls_ruc;	
				oleChild.worksheets(2).cells(li_fila,7 ).value = ls_pvrazons
		    else
			oleChild.worksheets(2).cells(li_fila,7 ).value = ls_nulo
		    end if
			
			
			oleChild.worksheets(2).cells(li_fila,8 ).value = 'NO'    //Parte relacionada ? nuevo 2015
			oleChild.worksheets(2).cells(li_fila,9 ).value =  ldw_compras_det.object.fecharegistro[ i ]
			oleChild.worksheets(2).cells(li_fila,10 ).value =  ldw_compras_det.object.establecimiento[i ]
			oleChild.worksheets(2).cells(li_fila,11).value = ldw_compras_det.object.puntoemision[i ]
			oleChild.worksheets(2).cells(li_fila,12 ).value =ldw_compras_det.object.secuencial[i ]
			oleChild.worksheets(2).cells(li_fila,13).value = ldw_compras_det.object.fechaemision[ i ]
			oleChild.worksheets(2).cells(li_fila,14 ).value =ldw_compras_det.object.autorizacion[ i ]
			
			oleChild.worksheets(2).cells(li_fila,15 ).value = ldw_compras_det.object.basenograiva[ i ]
			oleChild.worksheets(2).cells(li_fila,16 ).value = ldw_compras_det.object.baseimponible[ i ]
			oleChild.worksheets(2).cells(li_fila,17 ).value = ldw_compras_det.object.baseimpgrav[ i ]
			oleChild.worksheets(2).cells(li_fila,18 ).value = ldw_compras_det.object.baseimpexe[ i ] // base exenta nuevo 2015
			
			oleChild.worksheets(2).cells(li_fila,19 ).value = ldw_compras_det.object.montoice[ i ]
			oleChild.worksheets(2).cells(li_fila,20 ).value = ldw_compras_det.object.montoiva[ i ]
			
			//Retencion de Iva
			oleChild.worksheets(2).cells(li_fila,21 ).value = ldw_compras_det.object.valretbien10[ i ] //10 nuevo 2015
			oleChild.worksheets(2).cells(li_fila,22 ).value = ldw_compras_det.object.valretserv20[ i ] // 20 nuevo 2015
			oleChild.worksheets(2).cells(li_fila,23 ).value = ldw_compras_det.object.valorretbienes[ i ] //30
			oleChild.worksheets(2).cells(li_fila,24 ).value = 0.00 //50 
			
			oleChild.worksheets(2).cells(li_fila,25 ).value = ldw_compras_det.object.valorretservicios [ i ] //70
			oleChild.worksheets(2).cells(li_fila,26 ).value = ldw_compras_det.object.valorret100[ i ] //100
				
			oleChild.worksheets(2).cells(li_fila,27 ).value = ldw_compras_det.object.valorretbienes[ i ] //total  bases imponibles
			oleChild.worksheets(2).cells(li_fila,28 ).value = '01' // Pago residente o no
			
		     oleChild.worksheets(2).cells(li_fila,29 ).value = ls_nulo
			oleChild.worksheets(2).cells(li_fila,30).value  = ls_nulo 
			oleChild.worksheets(2).cells(li_fila,31 ).value = ls_nulo
			oleChild.worksheets(2).cells(li_fila,32 ).value = ls_nulo
			oleChild.worksheets(2).cells(li_fila,33).value  = ls_nulo
			oleChild.worksheets(2).cells(li_fila,34 ).value = ls_nulo
			oleChild.worksheets(2).cells(li_fila,35 ).value = ls_nulo
   	
			//Datos  de la retencion
			If  ldw_compras_det.object.tipocomp[ i ] = '01' then
				oleChild.worksheets(2).cells(li_fila,36 ).value = ldw_compras_det.object.estabret[i ]
				oleChild.worksheets(2).cells(li_fila,37 ).value = ldw_compras_det.object.ptoemiret[ i ]
				oleChild.worksheets(2).cells(li_fila,38 ).value = ldw_compras_det.object.secret[ i ]
				oleChild.worksheets(2).cells(li_fila,39).value = ldw_compras_det.object.autret[ i ]
				oleChild.worksheets(2).cells(li_fila,40 ).value = ldw_compras_det.object.fechaemiret1[i]
		     end if
		     
			//Documento modificado por la nota de credito
			//No se llena para el caso de FACTURAS de compra
			If  ldw_compras_det.object.tipocomp[ i ] = '04' then
				oleChild.worksheets(2).cells(li_fila,41 ).value = ldw_compras_det.object.docmodificado[ i ]
				oleChild.worksheets(2).cells(li_fila,42).value  = ldw_compras_det.object.estabmodificado[ i ]
				oleChild.worksheets(2).cells(li_fila,43 ).value = ldw_compras_det.object.ptoemimodificado[i ]
				oleChild.worksheets(2).cells(li_fila,44 ).value = ldw_compras_det.object.secmodificado[ i ]
				oleChild.worksheets(2).cells(li_fila,45 ).value = ldw_compras_det.object.autmodificado[ i ]
              end if
			hpb_1.Stepit()
		next
			
		/*1.1 Compras por formas de pago*/
		/*Inicia el volcado en la fila 3*/
			
		li_cc =  ldw_compras.rowcount( )
		if li_cc = 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las compras...")
		end if
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando compras retenciones...'

		li_filaux = 3
	    for i = 1 to li_cc
		   // Compras forma de pago 
			if (ldw_compras.object.basenograiva[ i ]+ldw_compras.object.baseimponible[ i ] + ldw_compras.object.baseimpgrav[ i ] +  ldw_compras.object.montoiva[ i ]+ ldw_compras.object.montoice[ i ]) > 1000 then
				 oleChild.worksheets(3 ).cells(li_filaux,1 ).value = 'compra'+ldw_compras.object.mp_codigo[i ] 
			     oleChild.worksheets(3 ).cells(li_filaux,2 ).value = '02' //Cheque propio
		         li_filaux ++  // Inicia el volcado en la fila 3	
      		end if	
		   
			  
			 //1.2 Compras Retenciones
			 //Inicia el volcado en la fila 2
			 li_fila =  i + 1
			oleChild.worksheets(4 ).cells(li_fila,1 ).value = 'compra'+ ldw_compras.object.mp_codigo[ i ]
			oleChild.worksheets(4 ).cells(li_fila,2).value  = ldw_compras.object.codretair[ i ]
			oleChild.worksheets(4 ).cells(li_fila,3 ).value = ldw_compras.object.baseimpair[i ]
			oleChild.worksheets(4 ).cells(li_fila,4 ).value = ldw_compras.object.porcentaje[ i ]
			oleChild.worksheets(4 ).cells(li_fila,5).value  = ldw_compras.object.valretair[ i ]
			
			hpb_1.Stepit()
		 next   
	     
		
		//2.   Inicia volcado de vtas
		//2.1 Vtas  por cliente
		 li_cc =   ldw_vtas.rowcount()
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere las ventas...")
	     end if
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando ventas...'
		for i =  1 to li_cc
			li_fila = i + 1
			oleChild.worksheets(6).cells(li_fila,1 ).value ='venta'+string(li_fila)
			oleChild.worksheets(6 ).cells(li_fila,2 ).value = ldw_vtas.object.tpidcliente[ i ]
			oleChild.worksheets(6 ).cells(li_fila,3).value = ldw_vtas.object.idcliente[ i ]
			if  ldw_vtas.object.tpidcliente[ i ] <> '9999999999999' then
				oleChild.worksheets(6 ).cells(li_fila,4).value = 'NO'
		    end if
			
			if ldw_vtas.object.tpidcliente[ i ] = '06' then
				
				ls_clie_rucic =  ldw_vtas.object.idcliente[ i ]
				select ce_razons into :ls_clie_razons from fa_clien where ce_rucic = :ls_clie_rucic;
			     oleChild.worksheets(6 ).cells(li_fila,5 ).value = '02'	
				oleChild.worksheets(6 ).cells(li_fila,6 ).value = ls_clie_razons
			else
				oleChild.worksheets(6 ).cells(li_fila,5 ).value = ls_nulo
 			    oleChild.worksheets(6 ).cells(li_fila,6 ).value =ls_nulo
   		     end if
			oleChild.worksheets(6 ).cells(li_fila,7 ).value = ldw_vtas.object.tipocomprobante[i ]
			oleChild.worksheets(6 ).cells(li_fila,8 ).value ='F'
			oleChild.worksheets(6 ).cells(li_fila,9 ).value = ldw_vtas.object.numerocomprobantes[ i ]
			oleChild.worksheets(6 ).cells(li_fila,10).value =  ldw_vtas.object.basenograiva[ i ]   // no grava iva
			oleChild.worksheets(6 ).cells(li_fila,11).value = ldw_vtas.object.baseimponible[i ] // tarifa 0
			oleChild.worksheets(6 ).cells(li_fila,12 ).value = ldw_vtas.object.baseimpgrav[ i ] //tarifa 12
			oleChild.worksheets(6 ).cells(li_fila,13).value =  ldw_vtas.object.montoiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,14).value = 0.00 //monto ice
			oleChild.worksheets(6 ).cells(li_fila,15).value = ldw_vtas.object.valorretiva[ i ]
			oleChild.worksheets(6 ).cells(li_fila,16).value = ldw_vtas.object.valorretrenta[ i ]
			hpb_1.Stepit()
		
       
		 //2. Compensaciones ventas
		 
		    oleChild.worksheets(7).cells(li_fila,1 ).value = 'venta'+string(li_fila)
		   	oleChild.worksheets(7).cells(li_fila,2 ).value = '01'  //Ley compensacion solidaria  01 = zonas afectadas, 02=MediosElectronicos
			oleChild.worksheets(7).cells(li_fila,3 ).value = ldw_vtas.object.baseimpgrav[ i ] 
		 
		  
		 
		 //2.3 Formas de cobro
		   oleChild.worksheets(8).cells(li_fila,1 ).value = 'venta'+string(li_fila)
		   oleChild.worksheets(8).cells(li_fila,2 ).value = '01'  // sin utilizacion del sistema financiero

         next

         //2.2 Vtas por establecimiento
		String ls_suc
		Decimal lc_vtaneta
		declare c1 cursor for
         select su_codigo,sum(ve_neto) from fa_venta where TO_CHAR(VE_FECHA,'MM/YYYY') = :ls_periodo and es_codigo in (1,2) group by su_codigo;
		
		open c1;	 
		li_fila = 2
      	do 
				
			FETCH c1 INTO :ls_suc, :lc_vtaneta;
			if sqlca.sqlcode <> 0 then
			exit;
			end if
		
		      //Inicia el volcado en vtas por establecimiento
			  oleChild.worksheets(9 ).cells(li_fila,1 ).value = ls_suc//
			  oleChild.worksheets(9 ).cells(li_fila,2).value = lc_vtaneta //
			  oleChild.worksheets(9 ).cells(li_fila,3).value = 0.00 //ivacomp
			  
			  li_fila = li_fila + 1
	     loop while TRUE
		close c1;
		
		
		//3.Inicia el volcado de comprobantes anulados
		 li_cc =   ldw_anulados.rowcount()
		  
		if li_cc = 0 then
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para continuar...Primero genere los comprobantes anulados...")
	     end if
		
		
		hpb_1.maxposition = li_cc
		hpb_1.Setstep = 1
		hpb_1.Position = 0 
		st_3.text = 'Generando comprobantes anulados...'  
		
		
		
		for i =  1 to ldw_anulados.rowcount()
			li_fila = i + 1
			oleChild.worksheets(16).cells(li_fila,1 ).value = ldw_anulados.object.tipocomprobante[ i ]
			oleChild.worksheets(16 ).cells(li_fila,2).value = ldw_anulados.object.establecimiento[ i ]
			oleChild.worksheets(16 ).cells(li_fila,3 ).value = ldw_anulados.object.puntoemision[i ]
			oleChild.worksheets(16 ).cells(li_fila,4 ).value = ldw_anulados.object.secuencialinicio[ i ]
			oleChild.worksheets(16 ).cells(li_fila,5).value = ldw_anulados.object.secuencialfin[ i ]
			oleChild.worksheets(16 ).cells(li_fila,6 ).value = ldw_anulados.object.autorizacion[i ]
			hpb_1.Stepit()
		next
		 
		
		oleChild.activeworkbook.saveas("C:libiak\archivos\ats.xlsx")
          oleChild.activeworkbook.close()

      oleChild.quit()

END IF

ole1.disconnectobject()
DESTROY oleChild

DESTROY ole1
	
Setpointer(Arrow!)
w_marco.SetMicrohelp("Listo archivo generado con $$HEX1$$e900$$ENDHEX$$xito...en la siguiente direcci$$HEX1$$f300$$ENDHEX$$n:   C:\libiak\archivos\ats.xlsx  !!!")
st_3.text = 'Proceso terminado...'
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo archivo generado con $$HEX1$$e900$$ENDHEX$$xito...en la siguiente direcci$$HEX1$$f300$$ENDHEX$$n:   C:\libiak\archivos\ats.xlsx")




end event


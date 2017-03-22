HA$PBExportHeader$w_rep_reoc.srw
$PBExportComments$Si.
forward
global type w_rep_reoc from w_sheet_1_dw_rep
end type
type rb_1 from radiobutton within w_rep_reoc
end type
type cb_3 from commandbutton within w_rep_reoc
end type
type dw_1 from datawindow within w_rep_reoc
end type
type st_1 from statictext within w_rep_reoc
end type
type rb_2 from radiobutton within w_rep_reoc
end type
type rb_3 from radiobutton within w_rep_reoc
end type
type rb_4 from radiobutton within w_rep_reoc
end type
type sle_3 from singlelineedit within w_rep_reoc
end type
type st_5 from statictext within w_rep_reoc
end type
type sle_1 from singlelineedit within w_rep_reoc
end type
type st_6 from statictext within w_rep_reoc
end type
type sle_2 from singlelineedit within w_rep_reoc
end type
type st_7 from statictext within w_rep_reoc
end type
type cb_1 from commandbutton within w_rep_reoc
end type
type st_8 from statictext within w_rep_reoc
end type
type dw_2 from datawindow within w_rep_reoc
end type
type cb_2 from commandbutton within w_rep_reoc
end type
type cb_4 from commandbutton within w_rep_reoc
end type
type dw_3 from datawindow within w_rep_reoc
end type
type rb_5 from radiobutton within w_rep_reoc
end type
type rb_6 from radiobutton within w_rep_reoc
end type
end forward

global type w_rep_reoc from w_sheet_1_dw_rep
integer width = 5769
integer height = 2352
string title = "REOC"
boolean ib_notautoretrieve = true
rb_1 rb_1
cb_3 cb_3
dw_1 dw_1
st_1 st_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
sle_3 sle_3
st_5 st_5
sle_1 sle_1
st_6 st_6
sle_2 sle_2
st_7 st_7
cb_1 cb_1
st_8 st_8
dw_2 dw_2
cb_2 cb_2
cb_4 cb_4
dw_3 dw_3
rb_5 rb_5
rb_6 rb_6
end type
global w_rep_reoc w_rep_reoc

on w_rep_reoc.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.cb_3=create cb_3
this.dw_1=create dw_1
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.sle_3=create sle_3
this.st_5=create st_5
this.sle_1=create sle_1
this.st_6=create st_6
this.sle_2=create sle_2
this.st_7=create st_7
this.cb_1=create cb_1
this.st_8=create st_8
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_3=create dw_3
this.rb_5=create rb_5
this.rb_6=create rb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.rb_4
this.Control[iCurrent+8]=this.sle_3
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.sle_1
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.sle_2
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.st_8
this.Control[iCurrent+16]=this.dw_2
this.Control[iCurrent+17]=this.cb_2
this.Control[iCurrent+18]=this.cb_4
this.Control[iCurrent+19]=this.dw_3
this.Control[iCurrent+20]=this.rb_5
this.Control[iCurrent+21]=this.rb_6
end on

on w_rep_reoc.destroy
call super::destroy
destroy(this.rb_1)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.sle_3)
destroy(this.st_5)
destroy(this.sle_1)
destroy(this.st_6)
destroy(this.sle_2)
destroy(this.st_7)
destroy(this.cb_1)
destroy(this.st_8)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_3)
destroy(this.rb_5)
destroy(this.rb_6)
end on

event ue_retrieve;String ls_anio,ls_mes,ls_periodo
String setting



ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio




if rb_1.checked then 
	dw_datos.DataObject = "d_rep_reoc2"
    dw_datos.SetTransObject(sqlca)
	f_recupera_empresa(dw_datos,"z_pl_codigo")
     f_recupera_empresa(dw_datos,"z_pl_codigo1")
	dw_datos.retrieve(ls_periodo)
end if

if rb_5.checked then 
	dw_datos.DataObject = "d_reoc_crosstab"
	dw_datos.SetTransObject(sqlca)
	dw_datos.retrieve(ls_periodo)
end if



if rb_2.checked then 
dw_datos.DataObject  = "d_reoc_retair_xml2"  // con formato de archivo texto
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ls_anio,ls_mes)
end if
	
if rb_3.checked then
dw_datos.DataObject  = "d_reoc_talon" 
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ls_anio,ls_mes)
end if
	
if rb_4.checked then 
dw_datos.DataObject  = "d_reoc_103"
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ls_anio,ls_mes)
end if

if rb_6.checked then 
dw_datos.DataObject  = "d_actretenciones"
dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ls_periodo)
end if


setting = dw_datos.Describe("DataWindow.Zoom")
dw_datos.Modify("DataWindow.Zoom=100")
//dw_datos.modify("datawindow.print.preview.zoom=100~t" + &
//										"datawindow.print.preview=yes")
end event

event open;call super::open;
dw_3.SetTransObject(sqlca)
dw_1.insertrow(0)

dw_1.Object.anio[1] = string(year(today()) )
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=no")
end event

event resize;call super::resize;st_8.move(st_8.x,this.workSpaceHeight() - .90*dw_datos.y)

st_5.move(st_5.x,this.workSpaceHeight() - .65*dw_datos.y)
st_6.move(st_6.x,this.workSpaceHeight() - .65*dw_datos.y)
st_7.move(st_7.x,this.workSpaceHeight() - .65*dw_datos.y)

sle_1.move(sle_1.x, this.workSpaceHeight() - .45*dw_datos.y)
sle_2.move(sle_2.x, this.workSpaceHeight() - .45*dw_datos.y)
sle_3.move(sle_3.x, this.workSpaceHeight() - .45*dw_datos.y)
cb_1.move(cb_1.x, this.workSpaceHeight() - .45*dw_datos.y)
cb_2.move(cb_2.x, this.workSpaceHeight() - .45*dw_datos.y)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_reoc
boolean visible = false
integer x = 23
integer y = 292
integer width = 5682
integer height = 1600
string dataobject = "d_rep_reoc2"
boolean border = true
boolean hsplitscroll = true
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_reoc
integer x = 192
integer y = 924
integer taborder = 60
string dataobject = "d_reoc"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_reoc
integer x = 1134
integer y = 912
integer width = 722
integer height = 564
integer taborder = 80
end type

type rb_1 from radiobutton within w_rep_reoc
integer x = 1563
integer y = 28
integer width = 773
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
string text = "Distribuci$$HEX1$$f300$$ENDHEX$$n por porcentaje"
boolean checked = true
end type

type cb_3 from commandbutton within w_rep_reoc
integer x = 3145
integer y = 168
integer width = 553
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar AIR"
end type

event clicked;Date ld_ini,ld_fin,ld_inicio_periodo
long ll_rc,ll_autret

String   ls_periodo,ls_mes,ls_anio,&
           ls_estabret,ls_ptoemiret
long     ll_secret



SetPointer(Hourglass!)
ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]


ls_periodo = ls_mes+'/'+ls_anio



SELECT COUNT(*)
INTO    :ll_rc
FROM   AN_RETAIR
WHERE ANIO = :ls_anio
AND     MES   = :ls_mes;

IF ll_rc > 0 then
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
cb_4.triggerevent(clicked!)


INSERT INTO AN_RETAIR
SELECT E.EM_RUC,TO_CHAR(F.MP_FECEMISION,'YYYY'),TO_CHAR(F.MP_FECEMISION,'MM'),
           F.MP_TIPIDPRV,P.PV_RUCCI,F.MP_TIPODOC,F.MP_NAUT,F.mp_docnroest,F.mp_docnropto,F.mp_docnrosec,F.mp_fecemision,
		  R.PM_CODPCT,R.PM_PORCTJE,R.PM_BASE0,R.PM_BASEGRAV,R.PM_BASENOGRAV,R.PM_VALOR,
		  F.MP_AUTRET,F.MP_ESTABRET,F.MP_PTOEMIRET,F.MP_SECRET,F.MP_FECEMIRET,R.PM_BSEIMP,
		  F.MP_AUTRET1,F.MP_ESTABRET1,F.MP_PTOEMIRET1,F.MP_SECRET1,F.MP_FECEMIRET1
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
AND   R.FP_CODIGO IN (6)
AND   TO_CHAR(F.MP_FECEMISION,'MM/YYYY') = :ls_periodo
AND NVL(F.ESTADO,'S') = 'N'
ORDER BY  F.MP_FECHA ASC;



IF SQLCA.SQLCODE <> 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar las retenciones...."+sqlca.sqlerrtext)
	rollback;
	return
END IF


COMMIT;
SetPointer(Arrow!)
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Listo ...se han generado las retenciones del per$$HEX1$$ed00$$ENDHEX$$odo...'"+ls_periodo+"'")
w_marco.SetMicrohelp("Listo....")
end event

type dw_1 from datawindow within w_rep_reoc
integer x = 32
integer y = 100
integer width = 1426
integer height = 164
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_ext_periodo"
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within w_rep_reoc
integer x = 78
integer y = 48
integer width = 494
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
string text = "Seleccione el per$$HEX1$$ed00$$ENDHEX$$odo:"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_rep_reoc
integer x = 1563
integer y = 192
integer width = 411
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
string text = "Detalle AIR"
end type

type rb_3 from radiobutton within w_rep_reoc
integer x = 2363
integer y = 108
integer width = 498
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
string text = "Tal$$HEX1$$f300$$ENDHEX$$n Resumen"
end type

type rb_4 from radiobutton within w_rep_reoc
integer x = 2363
integer y = 196
integer width = 411
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
string text = "Formulario 103"
end type

type sle_3 from singlelineedit within w_rep_reoc
integer x = 2299
integer y = 2080
integer width = 361
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "312"
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_rep_reoc
integer x = 2299
integer y = 2016
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Cod  Retenci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rep_reoc
integer x = 55
integer y = 2080
integer width = 951
integer height = 68
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_rep_reoc
integer x = 55
integer y = 2020
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "C$$HEX1$$f300$$ENDHEX$$digo cuenta"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_rep_reoc
integer x = 1019
integer y = 2080
integer width = 1248
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_rep_reoc
integer x = 1019
integer y = 2016
integer width = 955
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Descripci$$HEX1$$f300$$ENDHEX$$n de la cuenta"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_rep_reoc
integer x = 2715
integer y = 2072
integer width = 718
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;String ls_cad,ls_cadena

if rb_1.checked then
	if not isnull(sle_1.text) then 
		ls_cad = sle_1.text 
		ls_cadena = "cuenta like '"+ls_cad+'%'+"'"	
	end if
	if not isnull(sle_2.text) then 
		ls_cad = sle_2.text 
	ls_cadena = "pl_nombre like '"+ls_cad+'%'+"'"	
	end if
	if not isnull(sle_3.text) then 
		ls_cad = sle_3.text 
		 ls_cadena = "codpct like '"+ls_cad+'%'+"'"	
	end if
	
	dw_datos.Setfilter("")
	dw_datos.filter()
	dw_datos.setfilter(ls_cadena)
	dw_datos.filter()
end if
end event

type st_8 from statictext within w_rep_reoc
integer x = 55
integer y = 1940
integer width = 590
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Opciones de b$$HEX1$$fa00$$ENDHEX$$squeda"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_rep_reoc
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

type cb_2 from commandbutton within w_rep_reoc
integer x = 3511
integer y = 2068
integer width = 855
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ver c$$HEX1$$f300$$ENDHEX$$digos de retenci$$HEX1$$f300$$ENDHEX$$n duplicados"
end type

event clicked;String ls_anio,ls_mes,ls_periodo

dw_2.visible = true
ls_anio = dw_1.object.anio[1]
ls_mes = dw_1.object.mes[1]
ls_periodo = ls_mes+'/'+ls_anio

dw_2.retrieve(ls_periodo)
end event

type cb_4 from commandbutton within w_rep_reoc
boolean visible = false
integer x = 3739
integer y = 172
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

   
		SELECT COUNT(*)
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

type dw_3 from datawindow within w_rep_reoc
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

type rb_5 from radiobutton within w_rep_reoc
integer x = 1563
integer y = 112
integer width = 727
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
string text = "Distribuci$$HEX1$$f300$$ENDHEX$$n por c$$HEX1$$f300$$ENDHEX$$digo Ret."
end type

type rb_6 from radiobutton within w_rep_reoc
integer x = 2363
integer y = 28
integer width = 599
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
string text = "Editar retenciones"
end type


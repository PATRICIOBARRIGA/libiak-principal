HA$PBExportHeader$w_pd_hoja_costos.srw
forward
global type w_pd_hoja_costos from w_sheet_1_dw_maint
end type
type dw_mod from datawindow within w_pd_hoja_costos
end type
type dw_cif from datawindow within w_pd_hoja_costos
end type
type dw_lista from datawindow within w_pd_hoja_costos
end type
type st_1 from statictext within w_pd_hoja_costos
end type
type st_2 from statictext within w_pd_hoja_costos
end type
type st_3 from statictext within w_pd_hoja_costos
end type
type st_4 from statictext within w_pd_hoja_costos
end type
type cb_1 from commandbutton within w_pd_hoja_costos
end type
type dw_res from datawindow within w_pd_hoja_costos
end type
end forward

global type w_pd_hoja_costos from w_sheet_1_dw_maint
integer width = 5298
integer height = 3244
boolean ib_notautoretrieve = true
dw_mod dw_mod
dw_cif dw_cif
dw_lista dw_lista
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
cb_1 cb_1
dw_res dw_res
end type
global w_pd_hoja_costos w_pd_hoja_costos

type variables
String is_numord
datawindow idw_activo

end variables

on w_pd_hoja_costos.create
int iCurrent
call super::create
this.dw_mod=create dw_mod
this.dw_cif=create dw_cif
this.dw_lista=create dw_lista
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.cb_1=create cb_1
this.dw_res=create dw_res
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mod
this.Control[iCurrent+2]=this.dw_cif
this.Control[iCurrent+3]=this.dw_lista
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.dw_res
end on

on w_pd_hoja_costos.destroy
call super::destroy
destroy(this.dw_mod)
destroy(this.dw_cif)
destroy(this.dw_lista)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.dw_res)
end on

event resize;return 1
end event

event open;call super::open;dw_mod.SetTransObject(sqlca)
dw_cif.SetTransObject(sqlca)
dw_lista.Settransobject(sqlca)
dw_lista.retrieve()
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_pd_hoja_costos
integer x = 2679
integer y = 108
integer width = 2510
integer height = 704
string dataobject = "d_pd_ord_mpd"
boolean hscrollbar = false
boolean border = true
end type

event dw_datos::getfocus;call super::getfocus;idw_activo = this
end event

event dw_datos::updateend;call super::updateend;//Actualizar datos de la orden de producci$$HEX1$$f300$$ENDHEX$$n actual
Decimal lc_totalmpd

lc_totalmpd = this.object.cc_totalmpd[1]


UPDATE  PD_ORDPRD
SET  OR_VALMPD = :lc_totalmpd
WHERE OR_CODIGO = :is_numord
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND BO_CODIGO = :str_appgeninfo.seccion;


if sqlca.sqlcode <> 0 then
Rollback;
Messagebox("Atencion","Problemas al Actualizar la orden de producci$$HEX1$$f300$$ENDHEX$$n..."+sqlca.sqlerrtext) 
return 1
End if

Return 0
end event

event dw_datos::updatestart;call super::updatestart;//Asignar el numero de orden a MOD
int i
for i = 1 to this.rowcount()
    this.object.dr_secue[i] = i	
    this.object.or_codigo[i] = is_numord
next
return 0
end event

event dw_datos::itemchanged;call super::itemchanged;this.AcceptText()
cb_1.triggerevent(clicked!)
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_pd_hoja_costos
integer x = 96
integer y = 704
integer width = 1102
integer height = 352
end type

type dw_mod from datawindow within w_pd_hoja_costos
integer x = 2679
integer y = 904
integer width = 2510
integer height = 732
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pd_ord_mod"
boolean livescroll = true
end type

event getfocus;idw_activo = this
end event

event updatestart;//Asignar el numero de orden a MOD
int i
for i = 1 to this.rowcount()
    this.object.mo_secue[i] = string(i)
    this.object.or_codigo[i] = is_numord
next
return 0
end event

event updateend;//Actualizar datos de la orden de producci$$HEX1$$f300$$ENDHEX$$n actual
Decimal lc_totalmod

lc_totalmod = this.object.cc_totalmod[1]


UPDATE  PD_ORDPRD
SET  OR_VALMOD = :lc_totalmod
WHERE OR_CODIGO = :is_numord
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND BO_CODIGO = :str_appgeninfo.seccion;


if sqlca.sqlcode <> 0 then
Rollback;
Messagebox("Atencion","Problemas al Actualizar la orden de producci$$HEX1$$f300$$ENDHEX$$n..."+sqlca.sqlerrtext) 
return 1
End if

Return 0
end event

event itemchanged;This.AcceptText()
cb_1.triggerevent(clicked!)
end event

type dw_cif from datawindow within w_pd_hoja_costos
integer x = 2679
integer y = 1724
integer width = 2510
integer height = 656
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pd_ord_cif"
boolean livescroll = true
end type

event getfocus;idw_activo = this
end event

event updatestart;//Asignar el numero de orden a MOD
int i
for i = 1 to this.rowcount()
    this.object.cf_secue[i] = string(i)	
    this.object.or_codigo[i] = is_numord
next
return 0
end event

event updateend;//Actualizar datos de la orden de producci$$HEX1$$f300$$ENDHEX$$n actual
Decimal lc_totalcif

lc_totalcif = this.object.cc_totalcif[1]


UPDATE  PD_ORDPRD
SET  OR_VALCIF = :lc_totalcif
WHERE OR_CODIGO = :is_numord
AND EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND BO_CODIGO = :str_appgeninfo.seccion;


if sqlca.sqlcode <> 0 then
Rollback;
Messagebox("Atencion","Problemas al Actualizar la orden de producci$$HEX1$$f300$$ENDHEX$$n..."+sqlca.sqlerrtext) 
return 1
End if

Return 0
end event

event itemchanged;This.AcceptText()
cb_1.triggerevent(clicked!)
end event

type dw_lista from datawindow within w_pd_hoja_costos
integer x = 9
integer y = 104
integer width = 2633
integer height = 2964
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pd_lista_ordenes"
boolean hsplitscroll = true
end type

event rowfocuschanged;if currentrow = 0 then return
is_numord = this.object.pd_ordprd_or_codigo[currentrow] 

If this.object.or_estado[currentrow] = 'T' then
	dw_datos.enabled = false
	dw_mod.enabled =  false
	dw_cif.enabled    =  false
else
	dw_datos.enabled = true
	dw_mod.enabled =  true
	dw_cif.enabled    =  true
end if

dw_datos.reset()
dw_datos.retrieve(is_numord)
dw_mod.reset()
dw_mod.retrieve(is_numord)
dw_cif.reset()
dw_cif.retrieve(is_numord)

end event

event clicked;//Liquidaci$$HEX1$$f300$$ENDHEX$$n de la orden
// La liquidaci$$HEX1$$f300$$ENDHEX$$n implica inhabilitar para edici$$HEX1$$f300$$ENDHEX$$n la hoja de costos.
// adem$$HEX1$$e100$$ENDHEX$$s marca el producto como terminado listo para subir a inventario.
// OR_ESTADO = 'T' ---- terminado
// OR_ESTADO = 'P' ---- EN PROCESO
// OR_ESTADO = 'L' -----LIQUIDADA

String   ls_itcodigo
Decimal{2}  lc_cantprd
Decimal{4}  lc_costtotal,lc_costunit

if row = 0 then return
this.setrow(row)
this.Scrolltorow(row)
is_numord  = This.Object.pd_ordprd_or_codigo[row]
lc_cantprd  = This.Object.or_cantprd[row]
ls_itcodigo  = This.Object.it_codigo[row]

dw_res.reset()
dw_res.insertrow(0)


If dwo.name = 't_1' then
	If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Va a realizar la liquidaci$$HEX1$$f300$$ENDHEX$$n de la orden...."+&
						"Esto implica que en el futuro no podr$$HEX2$$e1002000$$ENDHEX$$modificar la hoja de costos respectiva...Est$$HEX2$$e1002000$$ENDHEX$$seguro de querer realizar est$$HEX2$$e1002000$$ENDHEX$$operaci$$HEX1$$f300$$ENDHEX$$n....?",Question!,YesNo!,2) = 2 then
	return
	else
		
		//
		SELECT nvl(OR_VALMPD,0) + nvl(OR_VALCIF,0) +nvl(OR_VALMOD,0) +nvl(OR_VALCPD,0) + nvl(OR_VALCDF,0) + nvl(OR_VALGST,0)
		INTO :lc_costtotal
		FROM PD_ORDPRD
		WHERE OR_CODIGO = :is_numord
		AND EM_CODIGO = :str_appgeninfo.empresa
		AND SU_CODIGO = :str_appgeninfo.sucursal
		AND BO_CODIGO = :str_appgeninfo.seccion;
		
		
		//
		UPDATE PD_ORDPRD
		SET OR_ESTADO = 'L',OR_CANTPRD = :lc_cantprd
		WHERE OR_CODIGO = :is_numord
		AND EM_CODIGO = :str_appgeninfo.empresa
		AND SU_CODIGO = :str_appgeninfo.sucursal
		AND BO_CODIGO = :str_appgeninfo.seccion;
		
		IF SQLCA.SQLCODE <> 0 THEN
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la orden de producci$$HEX1$$f300$$ENDHEX$$n..."+sqlca.sqlerrtext)
			Rollback;
			Return
		END IF
			
		
		
		//Modificar la ficha del item
		
		If lc_cantprd <> 0 then
			
		    lc_costunit =  (lc_costtotal / lc_cantprd)
			 
	  		UPDATE IN_ITEM
			SET IT_COSTO = :lc_costunit
			WHERE IT_CODIGO = :ls_itcodigo;
			
			IF SQLCA.SQLCODE <> 0 THEN
				Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el item.."+sqlca.sqlerrtext)
				Rollback;
				Return
			END IF	
		end if
		
		COMMIT;
		dw_lista.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
	end if	
End if
end event

type st_1 from statictext within w_pd_hoja_costos
integer x = 2693
integer y = 24
integer width = 466
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Materia prima directa"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pd_hoja_costos
integer x = 2693
integer y = 832
integer width = 475
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Mano de obra directa"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pd_hoja_costos
integer x = 2702
integer y = 1652
integer width = 722
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Costos indirectos de fabricaci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type st_4 from statictext within w_pd_hoja_costos
integer x = 23
integer y = 24
integer width = 530
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Ordenes de producci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_pd_hoja_costos
integer x = 2734
integer y = 2904
integer width = 832
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;
dw_res.object.mpd[1] = dw_datos.object.cc_totalmpd[1]
dw_res.object.mod[1]= dw_mod.object.cc_totalmod[1]
dw_res.object.cif[1]   = dw_cif.object.cc_totalcif[1]
dw_res.object.cantprd[1] = dw_lista.object.or_cantprd[dw_lista.getrow()]

end event

type dw_res from datawindow within w_pd_hoja_costos
integer x = 2683
integer y = 2468
integer width = 2501
integer height = 596
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_resumen_hojacostos"
boolean livescroll = true
end type


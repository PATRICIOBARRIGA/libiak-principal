HA$PBExportHeader$w_rep_resumen_cancelacion.srw
$PBExportComments$Si.Resumen Cacncelacion cartera
forward
global type w_rep_resumen_cancelacion from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_resumen_cancelacion
end type
type st_1 from statictext within w_rep_resumen_cancelacion
end type
type rb_1 from radiobutton within w_rep_resumen_cancelacion
end type
type rb_2 from radiobutton within w_rep_resumen_cancelacion
end type
type em_2 from editmask within w_rep_resumen_cancelacion
end type
type st_2 from statictext within w_rep_resumen_cancelacion
end type
type rb_3 from radiobutton within w_rep_resumen_cancelacion
end type
type st_3 from statictext within w_rep_resumen_cancelacion
end type
type st_4 from statictext within w_rep_resumen_cancelacion
end type
type cb_1 from commandbutton within w_rep_resumen_cancelacion
end type
type cb_2 from commandbutton within w_rep_resumen_cancelacion
end type
type rb_4 from radiobutton within w_rep_resumen_cancelacion
end type
type dw_cc from uo_dw_comprobante within w_rep_resumen_cancelacion
end type
type dw_cab from datawindow within w_rep_resumen_cancelacion
end type
type rr_1 from roundrectangle within w_rep_resumen_cancelacion
end type
end forward

global type w_rep_resumen_cancelacion from w_sheet_1_dw_rep
integer width = 4699
integer height = 2376
string title = "Resumen de Cancelaci$$HEX1$$f300$$ENDHEX$$n Cartera"
long backcolor = 81324524
em_1 em_1
st_1 st_1
rb_1 rb_1
rb_2 rb_2
em_2 em_2
st_2 st_2
rb_3 rb_3
st_3 st_3
st_4 st_4
cb_1 cb_1
cb_2 cb_2
rb_4 rb_4
dw_cc dw_cc
dw_cab dw_cab
rr_1 rr_1
end type
global w_rep_resumen_cancelacion w_rep_resumen_cancelacion

type variables
DataStore ids_comp
int ii_comp
end variables

on w_rep_resumen_cancelacion.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_2=create em_2
this.st_2=create st_2
this.rb_3=create rb_3
this.st_3=create st_3
this.st_4=create st_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.rb_4=create rb_4
this.dw_cc=create dw_cc
this.dw_cab=create dw_cab
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.em_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.rb_4
this.Control[iCurrent+13]=this.dw_cc
this.Control[iCurrent+14]=this.dw_cab
this.Control[iCurrent+15]=this.rr_1
end on

on w_rep_resumen_cancelacion.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.rb_3)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.rb_4)
destroy(this.dw_cc)
destroy(this.dw_cab)
destroy(this.rr_1)
end on

event open;this.ib_notautoretrieve = true
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
								"datawindow.print.preview=yes")
em_1.text = String(today())
f_recupera_empresa(dw_asiento,"pl_codigo")
f_recupera_empresa(dw_asiento,"pl_codigo_1")
f_recupera_empresa(dw_asiento,"cs_codigo")

dw_cab.SetTransObject(SQLCA)
dw_asiento.SetTransObject(SQLCA)



call super::open			
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_datos.resize(li_width,li_height - dw_datos.y )
this.setRedraw(True)
end event

event ue_retrieve;Date     ld_fecha,ld_fecha_fin
String   ls_empresa,ls_sucursal
long     ll_nreg

ld_fecha      = Date(em_1.Text)
ld_fecha_fin = Date(em_2.Text)

if rb_1.checked then
dw_datos.DataObject = 'd_rep_cancelacion_resumen_x_sucursal'	
dw_datos.SetTransobject(SQLCA)
dw_datos.Retrieve(integer(str_appgeninfo.sucursal),ld_fecha,ld_fecha_fin)
end if 

if rb_2.checked then
dw_datos.DataObject = 'd_rep_cancelacion_detallada'
dw_datos.SetTransObject(SQLCA)

//if  ld_fecha <>  ld_fecha_fin then 
//	 messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rango de fechas incorrecto...")
//	 Setmicrohelp("La fecha de inicio debe ser igual a la fecha de finalizaci$$HEX1$$f300$$ENDHEX$$n para recuperar el detalle por sucursal")
//	 return
//end if

dw_datos.Retrieve(integer(str_appgeninfo.sucursal),ld_fecha,ld_fecha_fin)
end if

if rb_3.checked then
dw_datos.DataObject = 'd_rep_cancelacion_resumen_empresa'
dw_datos.SetTransObject(SQLCA)
dw_datos.Retrieve(str_appgeninfo.empresa,ld_fecha,ld_fecha_fin)
end if


dw_datos.modify("st_empresa.text = '"+gs_empresa+ "' st_sucursal.text = '"+gs_su_nombre+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
								"datawindow.print.preview=yes")

								
//Cada vez que se recupera limpiar el asiento
dw_cc.reset()								
end event

event ue_contabilizar;call super::ue_contabilizar;long ll_reg,ll_i
int i,j
string ls_suc,ls_ctaneto,ls_ctaiva,&
          ls_ctaval,ls_cc,ls_cta,ls_signo,ls_estado,&
		 ls_ctaretiva,ls_ctaretfte,ls_ctaprv,&
		 ls_ctacli,ls_ctachdif
		 
Dec{2} lc_neto,lc_iva,lc_val,lc_retfte,lc_retiva,lc_valor,v_creditos ,v_debitos     
Long   v_cpnumero,v_cpnumdoc,ll_new    
Date   ld_ini,ld_fin
String v_observacion 
DataStore  lds_datos




Setpointer(Hourglass!)     

lds_datos = Create DataStore 
lds_datos.DataObject = 'd_um_asiento_cxc'
v_observacion = 'Cancelaciones CXC.'

lds_datos.SetTransObject(sqlca)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)


//Validaci$$HEX1$$f300$$ENDHEX$$n 
if ld_ini <> ld_fin then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rango de fechas incorrecto ....Recuerde que la contabilizaci$$HEX1$$f300$$ENDHEX$$n  solo se puede realizar de un solo d$$HEX1$$ed00$$ENDHEX$$a.")
	Return -1
end if
	

//dw_cab.reset()
//dw_asiento.reset()
dw_cc.visible = true

w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n...por favor espere...")
Setpointer(Hourglass!)

//Seleccion de las cuentas de cierre

SELECT PL_CODIGO
INTO    :ls_ctacli
FROM    PR_GRUPCONT
WHERE GT_CODIGO  = 'CAN_CTACLI';


SELECT PL_CODIGO
INTO     :ls_ctachdif
FROM    PR_GRUPCONT
WHERE  GT_CODIGO = 'CAN_CHDIF';



ll_reg = lds_datos.retrieve(ld_ini,ls_ctachdif,ls_ctacli)

If ll_reg = 0 then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para contabilizar....")
	return -1
End if

//-Inicia creacion del asiento
dw_cc.reset()

for i = 1 to ll_reg
            ls_cta        =  lds_datos.Object.cuenta[i]
            ls_cc         =   string(lds_datos.Object.ccosto[i])
		   ls_signo    =  lds_datos.Object.signo[i]		
            lc_val        =   lds_datos.Object.valor[i]	
		 
		  ll_i =	dw_cc.insertrow(0)
		  dw_cc.object.pl_codigo[ll_i]  = ls_cta
		  dw_cc.object.cs_codigo[ll_i]  = ls_cc
		  dw_cc.object.dt_signo[ll_i]    = ls_signo
		  dw_cc.object.dt_valor[ll_i]    = lc_val
    	      dw_cc.object.dt_detalle[ll_i]  = v_observacion+' '+string(ld_ini,'dd/mm-yyyy')	
		  dw_cc.object.fecha[ll_i]        = ld_ini
	  
next

return 1
			
			
	


Setpointer(Arrow!)     
w_marco.SetMicrohelp("Listo...")
RETURN 1


end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_resumen_cancelacion
integer x = 69
integer y = 444
integer width = 3835
integer height = 1792
integer taborder = 50
string dataobject = "d_rep_cancelacion_resumen_empresa"
boolean hscrollbar = false
boolean border = true
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_resumen_cancelacion
integer x = 59
integer y = 868
integer taborder = 60
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_resumen_cancelacion
integer x = 23
integer y = 768
integer width = 4128
integer height = 1380
boolean titlebar = true
string title = "Asiento"
string dataobject = "d_aux_detallecomprobante"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
end type

event dw_asiento::buttonclicked;long     ll_reg	,ll_cont,ll_cpnumero,ll_sectipo,i,li_rc
date      ld_ini,ld_fin
decimal lc_creditos, lc_debitos
string    ls_sectipo,ls_tipo,ls_sigla = 'DCA'



ld_ini = date(em_1.text)
ld_fin = date(em_2.text)


if ls_sigla = 'DCA' then ls_tipo = '19'


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
ll_sectipo     = f_secuencial(str_appgeninfo.empresa,"DCA")
ls_sectipo    = String(ll_sectipo)


/**/
If ll_cpnumero < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$grabado")
Rollback;
Return -1
End if 

If ll_sectipo < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial por tipo de comprobante...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$grabado")
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
		
		//Marcar las compras como COntabilizadas

//      UPDATE CC_MOVIM
//	    SET MT_CONTAB = 'S'
//		WHERE TT_CODIGO = '5'
//		AND TT_IOE = 'C'
//		AND TRUNC(MT_FECHA) BETWEEN :ld_ini  and :ld_fin;
//					
//		If sqlca.sqlcode < 0 Then	
//		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los cr$$HEX1$$e900$$ENDHEX$$ditos"+sqlca.sqlerrtext)
//		rollback;
//		return
//		End if 
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



if dwo.name = 'b_2' then
this.visible = false
end if

if dwo.name = 'b_3' then
	DataStore    lds_prn_asiento
	lds_prn_asiento   = Create DataStore
	lds_prn_asiento.DataObject = "d_prn_asiento_contable"
    lds_prn_asiento.settransobject(sqlca)
	 
	 
	ii_comp = this.object.cp_numero[1] 
	if ii_comp = 0 or isnull(ii_comp) or ii_comp =9999999  then 
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El comprobante todav$$HEX1$$ed00$$ENDHEX$$a no ha sido guardado....Por favor verifique...!")
		return 
	end if	
	
	
	ll_reg =  lds_prn_asiento.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_tipo,ii_comp) 
	if ll_reg > 0 then
     	if PrintSetup() = 1 then lds_prn_asiento.print()
	end if
end if
end event

type em_1 from editmask within w_rep_resumen_cancelacion
integer x = 288
integer y = 76
integer width = 379
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_rep_resumen_cancelacion
integer x = 101
integer y = 88
integer width = 160
integer height = 68
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
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_rep_resumen_cancelacion
integer x = 1641
integer y = 164
integer width = 631
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
string text = "Re&sumen por sucursal"
boolean checked = true
end type

event clicked;st_2.visible = true
em_2.visible = true
end event

type rb_2 from radiobutton within w_rep_resumen_cancelacion
integer x = 1641
integer y = 236
integer width = 594
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
string text = "&Detallado por sucursal"
end type

type em_2 from editmask within w_rep_resumen_cancelacion
integer x = 1134
integer y = 76
integer width = 402
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_rep_resumen_cancelacion
integer x = 873
integer y = 88
integer width = 160
integer height = 68
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
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_rep_resumen_cancelacion
integer x = 1641
integer y = 92
integer width = 635
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen por empresa"
end type

type st_3 from statictext within w_rep_resumen_cancelacion
integer x = 320
integer y = 164
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
string text = "[dd/mm/yyyy]"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_rep_resumen_cancelacion
integer x = 1166
integer y = 164
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
string text = "[dd/mm/yyyy]"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_rep_resumen_cancelacion
integer x = 1033
integer y = 80
integer width = 82
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_2.text = em_1.text
end event

type cb_2 from commandbutton within w_rep_resumen_cancelacion
integer x = 695
integer y = 76
integer width = 82
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_1.text = em_2.text
end event

type rb_4 from radiobutton within w_rep_resumen_cancelacion
integer x = 1641
integer y = 312
integer width = 635
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
string text = "Detalle de cancelaciones"
end type

type dw_cc from uo_dw_comprobante within w_rep_resumen_cancelacion
boolean visible = false
integer x = 64
integer y = 452
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Comprobante contable"
end type

event updateend;call super::updateend;Date ld_ini,ld_fin


ld_ini = date(em_1.text)
ld_fin = date(em_2.text)
      
		
		
UPDATE CC_MOVIM
SET MT_CONTAB = 'S'
WHERE TT_CODIGO = '5'
AND TT_IOE = 'C'
AND TRUNC(MT_FECHA) BETWEEN :ld_ini  and :ld_fin;
	
If sqlca.sqlcode < 0 Then	
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los cr$$HEX1$$e900$$ENDHEX$$ditos"+sqlca.sqlerrtext)
rollback;
return 0
End if 
end event

type dw_cab from datawindow within w_rep_resumen_cancelacion
boolean visible = false
integer x = 2766
integer y = 88
integer width = 1129
integer height = 328
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_aux_comprobante"
boolean border = false
boolean livescroll = true
end type

type rr_1 from roundrectangle within w_rep_resumen_cancelacion
long linecolor = 268435456
integer linethickness = 4
long fillcolor = 67108864
integer x = 1582
integer y = 72
integer width = 750
integer height = 348
integer cornerheight = 40
integer cornerwidth = 46
end type


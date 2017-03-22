HA$PBExportHeader$w_rep_vta5.srw
$PBExportComments$Para la contabilizaci$$HEX1$$f300$$ENDHEX$$n de vtas
forward
global type w_rep_vta5 from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_vta5
end type
type em_2 from editmask within w_rep_vta5
end type
type st_2 from statictext within w_rep_vta5
end type
type st_1 from statictext within w_rep_vta5
end type
type dw_cab from datawindow within w_rep_vta5
end type
type st_3 from statictext within w_rep_vta5
end type
type st_4 from statictext within w_rep_vta5
end type
type dw_1 from datawindow within w_rep_vta5
end type
type dw_cc from uo_dw_comprobante within w_rep_vta5
end type
type cb_1 from commandbutton within w_rep_vta5
end type
type cb_2 from commandbutton within w_rep_vta5
end type
end forward

global type w_rep_vta5 from w_sheet_1_dw_rep
integer width = 4567
integer height = 2200
string title = "Ventas"
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_2 st_2
st_1 st_1
dw_cab dw_cab
st_3 st_3
st_4 st_4
dw_1 dw_1
dw_cc dw_cc
cb_1 cb_1
cb_2 cb_2
end type
global w_rep_vta5 w_rep_vta5

type variables
boolean ib_cancel
string     is_tipdoc,is_estado
integer  ii_comp
end variables

on w_rep_vta5.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_1=create st_1
this.dw_cab=create dw_cab
this.st_3=create st_3
this.st_4=create st_4
this.dw_1=create dw_1
this.dw_cc=create dw_cc
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_cab
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.dw_cc
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.cb_2
end on

on w_rep_vta5.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_cab)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_1)
destroy(this.dw_cc)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_retrieve;Integer li_estados[4],index
Date  ld_ini,ld_fin

SetPointer(Hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

//if cbx_1.checked then li_estados[1] = 1	
//if cbx_2.checked then li_estados[2] = 2	
//if cbx_3.checked then li_estados[3] = 9	
//if cbx_4.checked then li_estados[4] = 10	
w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n.....por favor espere....!!!")


index  = message.DoubleParm


dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(ld_ini,ld_fin)
w_marco.SetMicrohelp("Listo....!!!")

SetPointer(Arrow!)
end event

event activate;call super::activate;em_1.Setfocus()
end event

event ue_contabilizar;call super::ue_contabilizar;dw_1.visible = true
dw_1.insertrow(0)
return 1

end event

event open;call super::open;dw_cab.SetTransObject(sqlca)
dw_asiento.SetTransObject(sqlca)
f_recupera_empresa(dw_asiento,"pl_codigo")
f_recupera_empresa(dw_asiento,"pl_codigo_1")
f_recupera_empresa(dw_asiento,"cs_codigo")
dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_vta5
integer x = 37
integer y = 216
integer width = 3872
integer height = 1452
string dataobject = "d_um_ventas_netas_x_empresa"
boolean border = true
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_vta5
integer x = 2912
integer y = 1680
integer taborder = 60
string dataobject = "d_um_ventas_netas_x_empresa"
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_vta5
integer x = 37
integer y = 920
integer width = 3872
integer height = 1164
integer taborder = 90
boolean titlebar = true
string title = "Asiento contable"
string dataobject = "d_aux_detallecomprobante"
boolean resizable = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_asiento::buttonclicked;call super::buttonclicked;/*Listo*/
Decimal{2} lc_creditos,lc_debitos
Long ll_cpnumero,ll_sectipo,ll_cont
Integer i,li_rc
String  ls_sectipo,ls_sigla,&
           ls_tipo 
Date ld_ini,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)


if is_tipdoc = 'DVE' then ls_tipo = '5'
if is_tipdoc = 'DDV' then ls_tipo = '6'

Setpointer(Hourglass!)
If dwo.name = 'b_1' then

If this.rowcount() <= 0 then return -1

/*Validar que no haya sido contabilizado*/

select count(*)
into :ll_cont
from fa_venta
where em_codigo = :str_appgeninfo.empresa
and es_codigo = :is_estado
and nvl(ve_contab,'N') = 'S'
and ve_fecha between :ld_ini and :ld_fin;

if ll_cont > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Existen datos correspondientes a este rango de fechas que ya han sido contabilizadas...<por favor verifique>")
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
ll_sectipo     = f_secuencial(str_appgeninfo.empresa,is_tipdoc)
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
		UPDATE FA_VENTA
		SET VE_CONTAB = 'S'
		where em_codigo = :str_appgeninfo.empresa
		and es_codigo = :is_estado
		and ve_fecha between :ld_ini and :ld_fin;
				
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




if dwo.name = 'b_3' then
	long ll_reg
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
Setpointer(Arrow!)
end event

type em_1 from editmask within w_rep_vta5
integer x = 274
integer y = 52
integer width = 343
integer height = 72
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

type em_2 from editmask within w_rep_vta5
integer x = 1170
integer y = 52
integer width = 343
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
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_2 from statictext within w_rep_vta5
integer x = 55
integer y = 60
integer width = 215
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

type st_1 from statictext within w_rep_vta5
integer x = 983
integer y = 60
integer width = 183
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

type dw_cab from datawindow within w_rep_vta5
boolean visible = false
integer x = 3643
integer y = 32
integer width = 261
integer height = 144
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_aux_comprobante"
boolean border = false
boolean livescroll = true
end type

type st_3 from statictext within w_rep_vta5
integer x = 498
integer y = 136
integer width = 64
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "+"
alignment alignment = center!
boolean border = true
long bordercolor = 134217739
boolean focusrectangle = false
end type

event clicked;if dw_cc.visible then
	dw_cc.visible = false
	this.text = '+'
else
	dw_cc.visible = true
	this.text = '-'
end if
end event

type st_4 from statictext within w_rep_vta5
integer x = 55
integer y = 140
integer width = 434
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
string text = "Asiento contable"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_rep_vta5
boolean visible = false
integer x = 2267
integer y = 252
integer width = 1518
integer height = 628
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Seleccione el tipo de asiento que desea contabilizar"
string dataobject = "d_um_estados"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;long ll_reg
int i,j
string ls_suc,ls_ctaneto,ls_ctaiva,ls_ctaval,ls_cc,ls_cta,ls_signo,ls_estado,ls_tipo
Dec{2} lc_neto,lc_iva,lc_val,lc_valpag,v_creditos ,v_debitos     
Long   v_cpnumero,v_cpnumdoc,ll_new    
Date   ld_ini,ld_fin
String v_observacion 
DataStore  lds_datos


if dwo.name ='b_2' then
this.visible = false
return
end if


is_estado = dw_1.object.estado[1]
lds_datos = Create DataStore 


choose case is_estado
	case '1'	// VENTA FXM
		  ls_tipo = '5'
	      SELECT PL_CODIGO
		 INTO    :ls_ctaneto
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO = :str_appgeninfo.empresa
		 AND      GT_CODIGO = 'V_FXM_NETO';
		 
		 SELECT PL_CODIGO
		 INTO    :ls_ctaiva
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO = :str_appgeninfo.empresa
		 AND     GT_CODIGO = 'V_FXM_IVA';
		 
		 SELECT PL_CODIGO
		 INTO    :ls_ctaval
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO = :str_appgeninfo.empresa
		 AND      GT_CODIGO = 'V_FXM_VAL';

		
		lds_datos.DataObject = 'd_um_asiento_vtafxm'
		is_tipdoc = 'DVE'
		v_observacion = 'Ventas FxM '
	case '2' // VENTA POS
		 ls_tipo = '5'
		
		 SELECT PL_CODIGO
		 INTO    :ls_ctaneto
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO = :str_appgeninfo.empresa
		 AND      GT_CODIGO = 'V_POS_NETO';
		 
		 SELECT PL_CODIGO
		 INTO    :ls_ctaiva
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO = :str_appgeninfo.empresa
		 AND     GT_CODIGO = 'V_POS_IVA';
		 
		 SELECT PL_CODIGO
		 INTO    :ls_ctaval
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO = :str_appgeninfo.empresa
		 AND      GT_CODIGO = 'V_POS_VAL';
		
		
		lds_datos.DataObject = 'd_um_asiento_vtapos'
		is_tipdoc = 'DVE'
		v_observacion = 'Ventas POS '
		
	case '9'  // DEVOLUCION FXM
		ls_tipo = '6'
		 SELECT PL_CODIGO
		 INTO    :ls_ctaneto
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO = :str_appgeninfo.empresa
		 AND      GT_CODIGO = 'D_FXM_NETO';
		 
		 SELECT PL_CODIGO
		 INTO    :ls_ctaiva
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO  = :str_appgeninfo.empresa
		 AND     GT_CODIGO   = 'D_FXM_IVA';
		 
		 SELECT PL_CODIGO
		 INTO    :ls_ctaval
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO  = :str_appgeninfo.empresa
		 AND      GT_CODIGO  = 'D_FXM_VAL';
		
				
		lds_datos.DataObject = 'd_um_asiento_devfxm'
		is_tipdoc = 'DDV'
		v_observacion = 'Devoluciones FxM '
	case '10' //DEVOLUCION POS
		ls_tipo = '6'
		
		
		
		 SELECT PL_CODIGO
		 INTO    :ls_ctaneto
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO = :str_appgeninfo.empresa
		 AND      GT_CODIGO = 'D_POS_NETO';
		 
		 SELECT PL_CODIGO
		 INTO    :ls_ctaiva
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO  = :str_appgeninfo.empresa
		 AND     GT_CODIGO   = 'D_POS_IVA';
		 
		 SELECT PL_CODIGO
		 INTO    :ls_ctaval
		 FROM   PR_GRUPCONT
		 WHERE EM_CODIGO  = :str_appgeninfo.empresa
		 AND      GT_CODIGO  = 'D_POS_VAL';
		 
		lds_datos.DataObject = 'd_um_asiento_devpos'
		is_tipdoc = 'DDV'
		v_observacion = 'Devoluciones POS '
end choose


lds_datos.SetTransObject(sqlca)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

dw_cab.reset()
dw_cc.reset()
dw_cc.visible = true
st_3.text = ' - '

w_marco.SetMicrohelp("Recuperando informaci$$HEX1$$f300$$ENDHEX$$n...por favor espere...")
Setpointer(Hourglass!)

// Compras
ll_reg = lds_datos.retrieve(ld_ini,ld_fin)

//-Inicia creacion del asiento
for i = 1 to ll_reg

            ls_suc        =  lds_datos.Object.su_codigo[i]
            ls_cc         =   string(lds_datos.Object.ccosto[i])
 	  	   lc_neto     =   lds_datos.Object.neto[i]
            lc_iva        =   lds_datos.Object.iva[i]
            lc_valpag  =   lds_datos.Object.valpag[i]		
		 	
		   j=1	 
             do while j<= 3
				ll_new = dw_cc.insertrow(0)	
					
				 choose case  j
				 case 1	
					ls_cta = ls_ctaneto
					if is_tipdoc = 'DVE' then
					ls_signo = 'C'
					else
					ls_signo = 'D'
					end if
					lc_val = lc_neto
				 case 2
					ls_cta = ls_ctaiva
					if is_tipdoc = 'DVE' then
					ls_signo = 'C'
					else
					ls_signo = 'D'
					end if
					lc_val = lc_iva
				 case 3
					ls_cta  = ls_ctaval
					if is_tipdoc = 'DVE' then
					ls_signo = 'D'
					else
					ls_signo = 'C'
					end if
					lc_val = lc_valpag
				end choose
							
				dw_cc.Object.em_codigo[ll_new] = str_appgeninfo.empresa
				dw_cc.Object.su_codigo[ll_new]  = str_appgeninfo.sucursal	
				dw_cc.Object.ti_codigo[ll_new]   = ls_tipo
				dw_cc.Object.cp_numero[ll_new] = 9999999	
				dw_cc.Object.pl_codigo[ll_new] = ls_cta	
				dw_cc.Object.cs_codigo[ll_new] = ls_cc
				dw_cc.Object.dt_secue[ll_new] = string(j)	
				dw_cc.Object.dt_signo[ll_new] = ls_signo
				dw_cc.Object.dt_valor[ll_new] = lc_val
				dw_cc.Object.dt_detalle[ll_new] = v_observacion+string(ld_ini,'mmm-dd-yyyy')		
	              j++ 
	    loop 
  	  
next

Setpointer(Arrow!)     
w_marco.SetMicrohelp("Listo...")
RETURN 1


end event

type dw_cc from uo_dw_comprobante within w_rep_vta5
boolean visible = false
integer x = 41
integer y = 556
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Comprobante contable"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
end type

event updatestart;call super::updatestart;Date ld_ini,ld_fin
Long  ll_cont

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

/*Validar que no haya sido contabilizado*/
select count(*)
into :ll_cont
from fa_venta
where em_codigo = :str_appgeninfo.empresa
and es_codigo = :is_estado
and nvl(ve_contab,'N') = 'S'
and ve_fecha between :ld_ini and :ld_fin;

if ll_cont > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Existen datos correspondientes a este rango de fechas que ya han sido contabilizadas...<por favor verifique>")
	return 1
end if	




//Marcar las compras como Contabilizadas
UPDATE FA_VENTA
SET VE_CONTAB = 'S'
where em_codigo = :str_appgeninfo.empresa
and es_codigo = :is_estado
and ve_fecha between :ld_ini and :ld_fin;
	
If sqlca.sqlcode < 0 Then	
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los cr$$HEX1$$e900$$ENDHEX$$ditos"+sqlca.sqlerrtext)
rollback;
return 1
End if 
return 0
end event

type cb_1 from commandbutton within w_rep_vta5
integer x = 617
integer y = 48
integer width = 91
integer height = 84
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

event clicked;em_1.text  = em_2.text
end event

type cb_2 from commandbutton within w_rep_vta5
integer x = 896
integer y = 48
integer width = 91
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "="
end type

event clicked;em_2.text  = em_1.text
end event


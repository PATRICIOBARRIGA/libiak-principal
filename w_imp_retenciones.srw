HA$PBExportHeader$w_imp_retenciones.srw
$PBExportComments$Si
forward
global type w_imp_retenciones from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_imp_retenciones
end type
type em_1 from editmask within w_imp_retenciones
end type
type em_2 from editmask within w_imp_retenciones
end type
type cbx_1 from checkbox within w_imp_retenciones
end type
type st_1 from statictext within w_imp_retenciones
end type
type st_2 from statictext within w_imp_retenciones
end type
type cbx_all from checkbox within w_imp_retenciones
end type
type st_4 from statictext within w_imp_retenciones
end type
type st_3 from statictext within w_imp_retenciones
end type
type em_3 from editmask within w_imp_retenciones
end type
type em_4 from editmask within w_imp_retenciones
end type
type em_5 from editmask within w_imp_retenciones
end type
type st_5 from statictext within w_imp_retenciones
end type
type em_6 from editmask within w_imp_retenciones
end type
type cb_1 from commandbutton within w_imp_retenciones
end type
type st_6 from statictext within w_imp_retenciones
end type
type ln_1 from line within w_imp_retenciones
end type
end forward

global type w_imp_retenciones from w_sheet_1_dw_rep
integer width = 4969
integer height = 1976
string title = "Imprimir Retenciones"
long backcolor = 79741120
dw_1 dw_1
em_1 em_1
em_2 em_2
cbx_1 cbx_1
st_1 st_1
st_2 st_2
cbx_all cbx_all
st_4 st_4
st_3 st_3
em_3 em_3
em_4 em_4
em_5 em_5
st_5 st_5
em_6 em_6
cb_1 cb_1
st_6 st_6
ln_1 ln_1
end type
global w_imp_retenciones w_imp_retenciones

type variables
datawindowchild idwc_prov
end variables

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();/*Actualizar el preimpreso en las retenciones*/
Long ll_rowcount,i,j,ll_reg
String ls_creditos[],ls_serie,ls_movcre

/*Recuperar retenciones*/
ll_rowcount = dw_datos.rowcount()
for i = 1 to ll_rowcount
	if dw_datos.Object.cc_impiva[i] = 'S' then
     ls_creditos[i] = dw_datos.Object.cp_movim_mp_codigo[i]
//	ls_serie =   dw_datos.Object.serie[i]
     end if
next

ll_reg = dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ls_creditos)
return  ll_reg

end function

on w_imp_retenciones.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.em_1=create em_1
this.em_2=create em_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.st_2=create st_2
this.cbx_all=create cbx_all
this.st_4=create st_4
this.st_3=create st_3
this.em_3=create em_3
this.em_4=create em_4
this.em_5=create em_5
this.st_5=create st_5
this.em_6=create em_6
this.cb_1=create cb_1
this.st_6=create st_6
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cbx_all
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.em_3
this.Control[iCurrent+11]=this.em_4
this.Control[iCurrent+12]=this.em_5
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.em_6
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.ln_1
end on

on w_imp_retenciones.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cbx_all)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.em_3)
destroy(this.em_4)
destroy(this.em_5)
destroy(this.st_5)
destroy(this.em_6)
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.ln_1)
end on

event open;dw_1.SetTransObject(SQLCA)   //Proveedores
dw_1.GetChild("proveedor",idwc_prov)
idwc_prov.SetTransObject(SQLCA)
idwc_prov.retrieve(str_appgeninfo.empresa)



dw_datos.SetTransObject(sqlca)
dw_report.SetTransObject(sqlca)

dw_1.Insertrow(0)
ib_notautoretrieve = true 
call super::open
dw_datos.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=no")
										


em_1.text = string(today())
em_2.text = string(today())
em_3.text = '001'
em_4.text = '001'
em_5.text = '0000000000'

dw_datos.Sharedata(dw_report)
end event

event ue_print;Long i,ll_reg
String ls_suc,ls_mpcodigo,ls_tvcodigo,ls_tvtipo,ls_autret,ls_estabret,ls_ptoemiret,ls_secret


/*Marcado todo*/
dw_datos.Setfilter("")
dw_datos.Filter()

dw_datos.Setfilter("cc_impiva ='S'")
dw_datos.Filter()

ll_reg = dw_datos.rowcount()

for i = 1 to ll_reg
	ls_suc          = dw_datos.object.cp_movim_su_codigo[i]     
	ls_mpcodigo = dw_datos.object.cp_movim_mp_codigo[i]
	ls_tvcodigo   = dw_datos.object.cp_movim_tv_codigo[i]
	ls_tvtipo       = dw_datos.object.cp_movim_tv_tipo[i]


	ls_autret       = dw_datos.Object.cp_pago_pm_naut[i]
	ls_estabret    = dw_datos.Object.cp_pago_pm_nroest[i]
	ls_ptoemiret  = dw_datos.Object.cp_pago_pm_nropto[i]
	ls_secret       = dw_datos.Object.cp_pago_pm_nrosec[i]

	 
	UPDATE CP_MOVIM
	SET MP_AUTRET = :ls_autret,
	MP_ESTABRET = :ls_estabret,
	MP_PTOEMIRET = :ls_ptoemiret,
	MP_SECRET = :ls_secret,
	MP_FECEMIRET = MP_FECEMISION
	WHERE EM_CODIGO = :str_appgeninfo.empresa
	AND  SU_CODIGO = :ls_suc 
	AND TV_CODIGO = :ls_tvcodigo
	AND TV_TIPO = :ls_tvtipo
	AND MP_CODIGO = :ls_mpcodigo;
	
	 IF SQLCA.SQLCODE <> 0 THEN
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar las retenciones en la factura..."+sqlca.sqlerrtext)
		Rollback;
		Return
	End iF
next 

dw_report.modify("st_resolucion.text = '"+str_appgeninfo.rescontesp+"'")
OpenWithParm(w_dw_print_options,dw_report)

if  dw_datos.update() = 1 then
	
    if wf_preprint() > 0 then
		dw_report.print()
	     commit;	
     else
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al imprimir las retenciones "+sqlca.sqlerrtext)
		rollback;
		return
     end if	
else
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar las retenciones "+sqlca.sqlerrtext)
rollback;
return
end if
end event

event resize;call super::resize;//dw_datos.resize(this.workSpaceWidth()-50, this.workSpaceHeight() - 400)
return 1
end event

event closequery;return 0
end event

event ue_retrieve;date ld_fini,ld_ffin
Long ll_row
String ls_pvcodigo

Setpointer(Hourglass!)
ld_fini = Date(em_1.text)
ld_ffin = Date(em_2.text)

dw_1.AcceptText()
ll_row = dw_1.getrow()
If ll_row = 0 then return
ls_pvcodigo = dw_1.GetItemString(ll_row,"proveedor")
dw_datos.Setfilter("")
dw_datos.filter()
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,ld_fini,ld_ffin)	  

if  not isnull(ls_pvcodigo) or ls_pvcodigo <>'' then 
dw_datos.Setfilter("cp_movim_pv_codigo = '"+ls_pvcodigo+"'")
dw_datos.filter()
end if
Setpointer(Arrow!)
return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_imp_retenciones
integer x = 59
integer y = 348
integer width = 4841
integer height = 1480
integer taborder = 100
string dataobject = "d_creditos_y_retenciones2"
boolean hsplitscroll = true
boolean livescroll = false
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_imp_retenciones
integer x = 78
integer y = 616
integer width = 3630
integer height = 1828
integer taborder = 90
string dataobject = "d_prn_retenciones_gsg"
boolean controlmenu = true
boolean resizable = true
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_imp_retenciones
integer x = 3776
integer y = 1352
integer height = 364
integer taborder = 50
end type

type dw_1 from datawindow within w_imp_retenciones
integer x = 55
integer y = 120
integer width = 1545
integer height = 128
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_proveedor"
boolean border = false
boolean livescroll = true
end type

event getfocus;cbx_all.checked = false
end event

type em_1 from editmask within w_imp_retenciones
integer x = 1623
integer y = 120
integer width = 343
integer height = 80
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

type em_2 from editmask within w_imp_retenciones
integer x = 2034
integer y = 120
integer width = 343
integer height = 80
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

type cbx_1 from checkbox within w_imp_retenciones
integer x = 2432
integer y = 224
integer width = 475
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
string text = "Marcar todo"
boolean lefttext = true
end type

event clicked;Long i,ll_nreg

SetPointer(Hourglass!)
ll_nreg = dw_datos.rowcount()
//If  cbx_1.Checked Then
//for i = 1 to ll_nreg
//dw_datos.object.cc_impfte.Primary[i] = 'S'
//next
//else
//for i = 1 to ll_nreg
//dw_datos.object.cc_impfte.Primary[i] = 'N'
//next
//End if	
/**/
If  cbx_1.Checked Then
for i = 1 to ll_nreg
dw_datos.object.cc_impiva.Primary[i] = 'S'
this.text = 'Desmarcar todo'
next
else
for i = 1 to ll_nreg
dw_datos.object.cc_impiva.Primary[i] = 'N'
this.text = 'Marcar todo'
next
End if	
SetPointer(Arrow!)
end event

type st_1 from statictext within w_imp_retenciones
integer x = 1618
integer y = 52
integer width = 187
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

type st_2 from statictext within w_imp_retenciones
integer x = 2016
integer y = 52
integer width = 197
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

type cbx_all from checkbox within w_imp_retenciones
integer x = 87
integer y = 48
integer width = 782
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos los Proveedores"
boolean checked = true
boolean lefttext = true
end type

event getfocus;String ls_nulo

Setnull(ls_nulo)
dw_1.Object.proveedor[1] = ls_nulo
end event

type st_4 from statictext within w_imp_retenciones
integer x = 96
integer y = 240
integer width = 2075
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la factura de la que desea imprimir la retenci$$HEX1$$f300$$ENDHEX$$n marcando la casilla de verificaci$$HEX1$$f300$$ENDHEX$$n."
boolean focusrectangle = false
end type

type st_3 from statictext within w_imp_retenciones
integer x = 2432
integer y = 136
integer width = 741
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
string text = "Inicio de la serie para impresi$$HEX1$$f300$$ENDHEX$$n."
boolean focusrectangle = false
end type

type em_3 from editmask within w_imp_retenciones
integer x = 3278
integer y = 124
integer width = 119
integer height = 80
integer taborder = 60
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
string mask = "000"
boolean autoskip = true
end type

type em_4 from editmask within w_imp_retenciones
integer x = 3401
integer y = 124
integer width = 119
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "000"
boolean autoskip = true
end type

type em_5 from editmask within w_imp_retenciones
integer x = 3525
integer y = 124
integer width = 229
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "0000000"
boolean autoskip = true
end type

type st_5 from statictext within w_imp_retenciones
integer x = 2432
integer y = 52
integer width = 645
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
string text = "Ingrese N$$HEX2$$ba002000$$ENDHEX$$de Autorizaci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type em_6 from editmask within w_imp_retenciones
integer x = 3278
integer y = 36
integer width = 480
integer height = 76
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
borderstyle borderstyle = stylelowered!
string mask = "##########"
boolean autoskip = true
end type

type cb_1 from commandbutton within w_imp_retenciones
integer x = 3781
integer y = 124
integer width = 471
integer height = 88
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar secuencia"
end type

event clicked;long ll_serie,i,ll_rowcount,cont
String ls_serie,ls_nroest,ls_nropto,ls_naut,ls_cofacpro,ls_pvcodigo,ls_pvant,ls_factant



SetPointer(Hourglass!)
ls_nroest = em_3.text
ls_nropto = em_4.text
ls_serie   =  em_5.text
ls_naut    = em_6.text


If isnull(ls_naut) or ls_naut = ''or ls_naut = '0000000000'  then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para generar la secuencia debe ingresar el N$$HEX2$$ba002000$$ENDHEX$$de Autorizaci$$HEX1$$f300$$ENDHEX$$n")
	return
End if	


If isnull(ls_nroest) or ls_nroest = '' or ls_nroest = '000' then 
   Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para generar la secuencia debe ingresar el N$$HEX2$$ba002000$$ENDHEX$$de establecimiento")
  return
end if

If isnull(ls_nropto) or ls_nropto = '' or ls_nropto = '000' then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para generar la secuencia debe ingresar el Punto de emisi$$HEX1$$f300$$ENDHEX$$n")
	return
End if	

If isnull(ls_serie) or ls_serie = '' or ls_serie = '0000000' then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para generar la secuencia debe ingresar el N$$HEX2$$ba002000$$ENDHEX$$de inicio de la serie")
	return
End if	


ll_rowcount = dw_datos.rowcount()
for i = 1 to ll_rowcount
	
     If dw_datos.Object.cc_impiva[i] = 'S' then 
		cont++  
		ls_cofacpro = dw_datos.Object.cp_movim_co_facpro[i]
		ls_pvcodigo = dw_datos.Object.cp_movim_pv_codigo[i]
			
   	    		   		
			If ((ls_factant <> ls_cofacpro) or (ls_pvcodigo <> ls_pvant)) and cont <> 1 then	
			ll_serie = long(ls_serie) 
			ll_serie++
			ls_serie = String(ll_serie,"0000000")
		     else
			ll_serie = long(ls_serie)
			ls_serie = String(ll_serie,"0000000")
			End if
	
		
		dw_datos.Object.cp_pago_pm_naut[i] = ls_naut
		dw_datos.Object.cp_pago_pm_nroest[i] = ls_nroest
		dw_datos.Object.cp_pago_pm_nropto[i] = ls_nropto
		dw_datos.Object.cp_pago_pm_nrosec[i] = ls_serie
		dw_datos.Object.cp_pago_pm_preimp[i] = ls_nroest+ls_nropto+ls_serie				
		
		ls_factant = ls_cofacpro
		ls_pvant   = ls_pvcodigo
		
	end if
next 
SetPointer(Arrow!)
end event

type st_6 from statictext within w_imp_retenciones
integer x = 3282
integer y = 208
integer width = 434
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
string text = "[est -   pto   -  serie]"
boolean focusrectangle = false
end type

type ln_1 from line within w_imp_retenciones
long linecolor = 16777215
integer linethickness = 4
integer beginx = 64
integer beginy = 336
integer endx = 4901
integer endy = 336
end type


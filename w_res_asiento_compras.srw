HA$PBExportHeader$w_res_asiento_compras.srw
$PBExportComments$Si. Contabiliza el resumen de compras
forward
global type w_res_asiento_compras from window
end type
type cb_1 from commandbutton within w_res_asiento_compras
end type
type st_4 from statictext within w_res_asiento_compras
end type
type em_2 from editmask within w_res_asiento_compras
end type
type dw_master from datawindow within w_res_asiento_compras
end type
type dw_1 from datawindow within w_res_asiento_compras
end type
type dw_detail from datawindow within w_res_asiento_compras
end type
type em_1 from editmask within w_res_asiento_compras
end type
type st_2 from statictext within w_res_asiento_compras
end type
type st_1 from statictext within w_res_asiento_compras
end type
type pb_2 from picturebutton within w_res_asiento_compras
end type
type pb_1 from picturebutton within w_res_asiento_compras
end type
end forward

global type w_res_asiento_compras from window
integer width = 3611
integer height = 1456
boolean titlebar = true
string title = "Dep$$HEX1$$f300$$ENDHEX$$sitos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_1 cb_1
st_4 st_4
em_2 em_2
dw_master dw_master
dw_1 dw_1
dw_detail dw_detail
em_1 em_1
st_2 st_2
st_1 st_1
pb_2 pb_2
pb_1 pb_1
end type
global w_res_asiento_compras w_res_asiento_compras

type variables
string is_ticodigo
end variables

forward prototypes
public function integer observa_saldo ()
end prototypes

public function integer observa_saldo ();long ll_filact
decimal ld_debito, ld_credito, ld_saldo

ll_filact = dw_master.GetRow()

ld_debito = dw_master.GetItemNumber (ll_filact, "cp_debito")
ld_credito = dw_master.GetItemNumber (ll_filact, "cp_credito")

ld_saldo = ld_debito - ld_credito

if ld_saldo <> 0 then
messageBox ("Atenci$$HEX1$$f300$$ENDHEX$$n", 'El Comprobante no cuadra')
return 1
end if
return 0
end function

on w_res_asiento_compras.create
this.cb_1=create cb_1
this.st_4=create st_4
this.em_2=create em_2
this.dw_master=create dw_master
this.dw_1=create dw_1
this.dw_detail=create dw_detail
this.em_1=create em_1
this.st_2=create st_2
this.st_1=create st_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.Control[]={this.cb_1,&
this.st_4,&
this.em_2,&
this.dw_master,&
this.dw_1,&
this.dw_detail,&
this.em_1,&
this.st_2,&
this.st_1,&
this.pb_2,&
this.pb_1}
end on

on w_res_asiento_compras.destroy
destroy(this.cb_1)
destroy(this.st_4)
destroy(this.em_2)
destroy(this.dw_master)
destroy(this.dw_1)
destroy(this.dw_detail)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_2)
destroy(this.pb_1)
end on

event open;
dw_1.Settransobject(sqlca)
dw_master.Settransobject(sqlca)
dw_detail.settransobject(sqlca)

f_recupera_empresa(dw_master,"ti_codigo")
f_recupera_empresa(dw_1,"pl_codigo")
f_recupera_empresa(dw_detail,"pl_codigo")
f_recupera_empresa(dw_1,"cs_codigo")
f_recupera_empresa(dw_detail,"cs_codigo")






end event

type cb_1 from commandbutton within w_res_asiento_compras
integer x = 1504
integer y = 76
integer width = 133
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;decimal    p_mpvalor,&
           p_mpvalret,&  
           p_mpneto,&    
           p_mpsaldo,&   
           p_mptransporte,& 
           p_mpnotand,&  
           p_mpivand ,& 
           p_mpreten,&  
           p_mpretiva 

DECLARE dept_proc PROCEDURE FOR 	pruebas.sp_compras(
       :p_mpvalor ,
       :p_mpvalret  ,
       :p_mpneto    ,
       :p_mpsaldo   ,
       :p_mptransporte ,
       :p_mpnotand  ,
       :p_mpivand   ,
       :p_mpreten   ,
       :p_mpretiva );

execute dept_proc;

// Error handling
if SQLCA.SQLCode < 0 then
	MessageBox ("Error " + String (SQLCA.SQLDBCode), SQLCA.SQLErrText)

	// Set Action Code to stop processing the update
	return 1
end if

Messagebox("Atencion", string(p_mpvalor))


close dept_proc;




end event

type st_4 from statictext within w_res_asiento_compras
integer x = 869
integer y = 140
integer width = 174
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_2 from editmask within w_res_asiento_compras
integer x = 1051
integer y = 128
integer width = 343
integer height = 88
integer taborder = 20
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

event modified;/*Modificado para trabajar con sucursales en l$$HEX1$$ed00$$ENDHEX$$nea
  El secuencial de los comprobantes es por empresa
  Se recupera todos los ingresos de bancos de toda la empresa*/

Date ld_fini,ld_ffin
Long ll_reg,i,ll_new,ll_row,ll_rowm,lc_valordeb,lc_valorcre,lc_saldo
String ls_tipo,ls_columna,ls_plcodigo,ls_cscodigo,ls_signo,ls_formula,ls_obs 
decimal v_mpvalor,v_mpvalret,v_mpneto,v_mpsaldo,v_mptransporte,v_mpnotand,v_mpivand,v_mpreten,v_mpretiva



ld_fini = date(em_1.text)
ld_ffin = date(em_2.text)

Setpointer(Hourglass!)

/*Recuperar datos para el asiento*/
/*Resumen de compras*/

Setmicrohelp("Recuperando datos...por favor espere!")

SELECT sum("CP_MOVIM"."MP_VALOR") A,   
sum("CP_MOVIM"."MP_VALRET") B,
sum("CP_MOVIM"."MP_VALOR") - sum("CP_MOVIM"."MP_VALRET") C,
sum("CP_MOVIM"."MP_SALDO") D,   
sum("CP_MOVIM"."MP_TRANSPORTE") E,   
sum("CP_MOVIM"."MP_NOTAND") F,
sum("CP_MOVIM"."MP_IVAND") G,
sum("CP_MOVIM"."MP_RETEN") H,
sum("CP_MOVIM"."MP_RETIVA") I
INTO  :v_mpvalor,:v_mpvalret,:v_mpneto,:v_mpsaldo,:v_mptransporte,:v_mpnotand,:v_mpivand,:v_mpreten,:v_mpretiva
FROM "CP_MOVIM"         
WHERE (( "CP_MOVIM"."TV_CODIGO" = '1' ) AND  
( "CP_MOVIM"."TV_TIPO" = 'C' ) AND  
( "CP_MOVIM"."EM_CODIGO" = '1' ) AND  
( "CP_MOVIM"."EC_CODIGO" = '3' ) AND 
( trunc("CP_MOVIM"."MP_FECHA") between :ld_fini and :ld_ffin)); 

IF SQLCA.SQLCODE = 100 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones")
	return
END IF

/*Pasar el argumento*/
select ti_codigo
into :is_ticodigo
from co_cabaut
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and ct_codigo = '101';



/*Recuperar plantilla de compras*/
ll_reg = dw_1.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,'101')

/*i*/
ll_rowm = dw_master.insertrow(0)


for i = 1 to ll_reg
	 ls_columna  = dw_1.getitemstring(i,"ct_colum")
	 ls_plcodigo = dw_1.getitemstring(i,"pl_codigo")
	 ls_cscodigo = dw_1.getitemstring(i,"cs_codigo")
 	 ls_signo    = dw_1.getitemstring(i,"ct_debcre")
	 ls_formula  = dw_1.getitemstring(i,"dr_etiqueta") 
 	 ls_obs      = dw_1.getitemstring(i,"ct_descri")
	 ll_new = dw_detail.insertrow(0)
 	 dw_detail.setitem(ll_new,"em_codigo",str_appgeninfo.empresa)
	 dw_detail.setitem(ll_new,"su_codigo",str_appgeninfo.sucursal)
	 dw_detail.setitem(ll_new,"ti_codigo",ls_tipo)
	 dw_detail.setitem(ll_new,"dt_secue",ls_columna)
	 dw_detail.setitem(ll_new,"pl_codigo",ls_plcodigo)
	 dw_detail.setitem(ll_new,"cs_codigo",ls_cscodigo)
	 dw_detail.setitem(ll_new,"dt_signo",ls_signo)
	 dw_detail.setitem(ll_new,"dt_detalle",ls_obs)
	 
	 /*Aqui va el dato del reporte*/
	 CHOOSE CASE ls_formula
		CASE 'A'
			dw_detail.setitem(ll_new,"dt_valor",v_mpvalor)
		CASE 'B'
			dw_detail.setitem(ll_new,"dt_valor",v_mpvalret)
		CASE 'C'
			dw_detail.setitem(ll_new,"dt_valor",v_mpneto)
		CASE 'D'
			dw_detail.setitem(ll_new,"dt_valor",v_mpsaldo)
		CASE 'E'
			dw_detail.setitem(ll_new,"dt_valor",v_mptransporte)
		CASE 'F'
			dw_detail.setitem(ll_new,"dt_valor",v_mpnotand)
		CASE 'G'
			dw_detail.setitem(ll_new,"dt_valor",v_mpivand)
		CASE 'H'
			dw_detail.setitem(ll_new,"dt_valor",v_mpreten)
		CASE 'I'
			dw_detail.setitem(ll_new,"dt_valor",v_mpretiva)
	END CHOOSE	
	 
next


/*detalle sin filas retorna*/
If dw_detail.rowcount() = 0 then return 
ll_row = dw_detail.Getrow()
lc_valordeb = dw_detail.GetItemDecimal(ll_row,"cc_tot_debitos")
lc_valorcre  = dw_detail.GetItemDecimal(ll_row,"cc_tot_creditos")

dw_master.SetItem(ll_rowm,"cp_debito",lc_valordeb )
dw_master.SetItem(ll_rowm,"cp_credito",lc_valorcre)
dw_master.SetItem(ll_rowm,"sa_login",str_appgeninfo.username)
dw_master.SetItem(ll_rowm,"ti_codigo",is_ticodigo)

lc_saldo = dw_master.GetItemNumber(ll_rowm,"cc_saldo")
dw_master.SetItem(ll_rowm,"cp_saldo",lc_saldo)


Setmicrohelp("Listo...")
Setpointer(Arrow!)
end event

type dw_master from datawindow within w_res_asiento_compras
integer x = 27
integer y = 264
integer width = 2176
integer height = 216
integer taborder = 20
string title = "none"
string dataobject = "d_cab_comprobante"
boolean border = false
boolean livescroll = true
end type

type dw_1 from datawindow within w_res_asiento_compras
boolean visible = false
integer x = 2249
integer y = 104
integer width = 795
integer height = 340
integer taborder = 30
string title = "none"
string dataobject = "d_comp_automatico"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

type dw_detail from datawindow within w_res_asiento_compras
integer x = 5
integer y = 508
integer width = 3579
integer height = 828
integer taborder = 30
string title = "none"
string dataobject = "d_det_comprobante"
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

type em_1 from editmask within w_res_asiento_compras
integer x = 471
integer y = 132
integer width = 320
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_2 from statictext within w_res_asiento_compras
integer x = 55
integer y = 140
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen desde:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_res_asiento_compras
integer x = 55
integer y = 44
integer width = 1358
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Este proceso contabilizar$$HEX2$$e1002000$$ENDHEX$$el resumen de compras"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_res_asiento_compras
integer x = 1979
integer y = 44
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Cancel.Gif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type pb_1 from picturebutton within w_res_asiento_compras
integer x = 1751
integer y = 48
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;Long     ll_row ,rc,ll_rowm,ll_cpnumero,ll_sectipo
Integer  i
String   ls_tipo,ls_sigla,ls_sectipo
decimal  lc_valordeb,lc_valorcre,lc_saldo
dwitemstatus l_status


/*Grabar asiento*/
/*Verificar que el asiento cuadre*/

Setpointer(Hourglass!)

dw_master.AcceptText()
dw_detail.AcceptText()


ll_rowm = dw_master.GetRow()
If ll_rowm = 0 Then return

l_status = dw_master.getitemStatus(ll_rowm,0,primary!)

/*detalle sin filas retorna*/
If dw_detail.rowcount() = 0 then return 

ll_row = dw_detail.Getrow()
lc_valordeb = dw_detail.GetItemDecimal(ll_row,"cc_tot_debitos")
lc_valorcre  = dw_detail.GetItemDecimal(ll_row,"cc_tot_creditos")
dw_master.SetItem(ll_rowm,"cp_debito",lc_valordeb )
dw_master.SetItem(ll_rowm,"cp_credito",lc_valorcre)
dw_master.SetItem(ll_rowm,"sa_login",str_appgeninfo.username)
dw_master.SetItem(ll_rowm,"ti_codigo",is_ticodigo)

lc_saldo = dw_master.GetItemNumber(ll_rowm,"cc_saldo")

SELECT ti_sigla
INTO   :ls_sigla
FROM   CO_TIPCOM
WHERE  TI_CODIGO = :is_ticodigo;

dw_master.SetItem(ll_rowm,"cp_saldo",lc_saldo)

If observa_saldo() = 1 Then Return 1

if l_status = new! or l_status = newmodified! then
ll_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
ll_sectipo  = f_secuencial(str_appgeninfo.empresa,ls_sigla)
ls_sectipo  = String(ll_sectipo)
else
ll_cpnumero  = dw_master.GetitemNumber(ll_rowm, "cp_numero")	
ls_sectipo   = dw_master.GetitemString(ll_rowm, "cp_numcomp")	
end if

/**/
If ll_cpnumero < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial..Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return 
End if 

If ll_sectipo < 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al otorgar el secuencial por tipo de comprobante...Este comprobante no ser$$HEX2$$e1002000$$ENDHEX$$salvado")
Rollback;
Return 
End if 


dw_master.SetItem(ll_rowm,"em_codigo",str_appgeninfo.empresa)
dw_master.SetItem(ll_rowm,"cp_numero",ll_cpnumero)
dw_master.SetItem(ll_rowm,"su_codigo",str_appgeninfo.sucursal)
dw_master.SetItem(ll_rowm,"cp_numcomp",ls_sectipo)


/*Inserta clave del detalle solo si es nuevo*/
for i = 1 to dw_detail.RowCount()
dw_detail.SetItem(i,"em_codigo",str_appgeninfo.empresa)
dw_detail.SetItem(i,"su_codigo",str_appgeninfo.sucursal)
dw_detail.SetItem(i,"ti_codigo",is_ticodigo)
dw_detail.SetItem(i,"cp_numero",ll_cpnumero)
dw_detail.SetItem(i,"dt_secue",String(i))
next 	

/*Empieza grabaci$$HEX1$$f300$$ENDHEX$$n*/
rc = dw_master.update(true,false)
if rc = 1 then
	rc = dw_detail.update(true,false)
	if rc = 1 then
		dw_master.resetupdate()
		dw_detail.resetupdate()
		commit;
	else
		rollback;
		return
	end if	
else
rollback;
return
end if


Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Proceso completado con $$HEX1$$e900$$ENDHEX$$xito...~n~rVerifique asiento Nro: '"+string(ll_cpnumero)+"'",Exclamation!)
w_marco.SetMicrohelp("Listo...!")

end event


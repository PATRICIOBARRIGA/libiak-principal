HA$PBExportHeader$w_rep_roles_x_tipo.srw
$PBExportComments$Si.Resumen de roles agrupados por tipo de Rol.(Mensual,Provisiones,Incentivos,Utilidades)
forward
global type w_rep_roles_x_tipo from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_roles_x_tipo
end type
type dw_cc from uo_dw_comprobante within w_rep_roles_x_tipo
end type
type st_1 from statictext within w_rep_roles_x_tipo
end type
type dw_roles from datawindow within w_rep_roles_x_tipo
end type
end forward

global type w_rep_roles_x_tipo from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 5682
integer height = 2748
string title = "Rol de Pagos Resumido"
dw_1 dw_1
dw_cc dw_cc
st_1 st_1
dw_roles dw_roles
end type
global w_rep_roles_x_tipo w_rep_roles_x_tipo

type variables
string   is_su_nombre,is_tiporol,is_periodo,is_observa
end variables

on w_rep_roles_x_tipo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_cc=create dw_cc
this.st_1=create st_1
this.dw_roles=create dw_roles
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_cc
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_roles
end on

on w_rep_roles_x_tipo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_cc)
destroy(this.st_1)
destroy(this.dw_roles)
end on

event open;dw_roles.settransobject(sqlca)
dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'pl_codigo')
this.ib_notautoretrieve = true
call super::open

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_retrieve;string ls_periodo,ls_cuenta,ls_ctarol


dw_1.AcceptText()
is_periodo = string(dw_1.GetItemDate(1,"rr_fecha"),'mm/yyyy')
is_tiporol = dw_1.object.rr_tipo[1]
ls_cuenta = dw_1.object.pl_codigo[1]





dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
dw_datos.retrieve(str_appgeninfo.empresa,is_periodo,is_tiporol)



end event

event ue_contabilizar;call super::ue_contabilizar;long ll_reg,i,ll_i
String ls_ctarol,ls_cuenta



dw_cc.visible = true
dw_1.object.pl_codigo.visible = true
dw_1.object.t_2.visible = true

ls_cuenta = dw_1.object.pl_codigo[1]

if isnull(ls_cuenta) or ls_cuenta='' then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe seleccionar la cuenta de rol....Por favor verifique..!")
	return -1
end if


SELECT PL_CODIGO
INTO     :ls_ctarol
FROM    PR_GRUPCONT
WHERE  GT_CODIGO = 'NOM_ROL';

IF SQLCA.SQLCODE <> 0 THEN
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al determinar el grupo contable..."+sqlca.sqlerrtext)
Return -1
End IF



dw_roles.retrieve(is_tiporol,is_periodo,ls_cuenta,ls_ctarol)

ll_reg  = dw_roles.rowcount()



//Cargar asiento
dw_cc.reset()

for i = 1 to ll_reg
  	  
	  ll_i =	dw_cc.insertrow(0)
	  dw_cc.object.pl_codigo[ll_i]  = dw_roles.object.cc_cuenta[i]
	  dw_cc.object.cs_codigo[ll_i]  = dw_roles.object.centro_costo[i]
	  dw_cc.object.dt_signo[ll_i]    = dw_roles.object.signo[i]
	  if dw_roles.object.signo[i]     = 'D' then
	  dw_cc.object.dt_valor[ll_i]    = dw_roles.object.cc_deb[i]
      else
       dw_cc.object.dt_valor[ll_i]    = dw_roles.object.cc_cre[i]
	 end if
	  dw_cc.object.dt_detalle[ll_i]  = 'Rol mensual ' +is_periodo
	  
next

return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_roles_x_tipo
integer x = 0
integer y = 328
integer width = 3173
integer height = 1248
integer taborder = 20
string dataobject = "d_rep_roles_x_empleado"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_roles_x_tipo
integer y = 240
integer width = 265
integer height = 144
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_roles_x_tipo
end type

type dw_1 from datawindow within w_rep_roles_x_tipo
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 3173
integer height = 328
integer taborder = 10
string dataobject = "d_sel_rol_pagos_crosstab"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;/*Cambia de datawindow*/
if dwo.name = 'rr_tipo' then
choose case data
		  case  'R'	
            dw_roles.DataObject = 'd_contabiliza_rolmensual'
   		  is_observa = 'Registro Roles' 		
            case   'I'
            dw_roles.DataObject = 'd_contabiliza_incentivos'
   		  is_observa = 'Registro Incentivos' 		
            case   'P'
            dw_roles.DataObject = 'd_contabiliza_provisiones'
   		  is_observa = 'Roles beneficios sociales' 		
end choose;
end if
dw_roles.settransObject(sqlca)

end event

event losefocus;//date    ld_fecha
//string  ls_fecha
//
//ld_fecha = dw_1.GetItemDate(1,"fecha_corte")
//ls_fecha = string(ld_fecha,"dd/mm/yyyy")
//declare rp_kardex_sucur procedure for
//  rp_kardex_sucur(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:is_pepa,:ls_fecha)
//  using sqlca;
//execute rp_kardex_sucur;
//if sqlca.sqldbcode <> 0 then
//	MessageBox("ERROR","El proceso no se ejecut$$HEX2$$f3002000$$ENDHEX$$o se ejecut$$HEX2$$f3002000$$ENDHEX$$mal.");
//	Return(1);
//end if
//dw_report.retrieve()
//dw_report.SetFocus()
end event

event editchanged;String ls_data
datawindowchild dwc_cuentas

If dwo.name = "pl_codigo" &
Then
ls_data = data+'%'
This.GetChild("pl_codigo",dwc_cuentas)
dwc_cuentas.SetFilter("pl_codigo like '"+ls_data+"' ")
dwc_cuentas.Filter()

End if 

end event

type dw_cc from uo_dw_comprobante within w_rep_roles_x_tipo
boolean visible = false
integer x = 361
integer y = 1052
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Comprobante contable"
end type

event updatestart;call super::updatestart;string    ls_periodo,ls_tiporol,ls_plcodigo,ls_cc,ls_signo,ls_nro
decimal{2} lc_valor,lc_debitos,lc_creditos
long      ll_sectipo,ll_reg,ll_cpnumero,i,ll_count

ll_reg = dw_roles.rowcount()
if ll_reg <= 0 then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para contabilizar")
	return 1
end if	

If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea contabilizar el Rol?",Question!,yesno!) = 2 then return

SELECT COUNT(*)
into  :ll_count
FROM NO_CABROL
WHERE  RR_TIPO = :is_tiporol
AND RR_CONTAB = 'S'
AND TO_CHAR(RR_FECHA,'MM/YYYY') = :is_periodo;

If ll_count > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Este Rol ya ha sido contabilizado....por favor verifique.... !")
	Return 1
end if





/*Actualizar como contabilizados a todo los roles*/
UPDATE NO_CABROL
SET RR_CONTAB = 'S'
WHERE  RR_TIPO = :is_tiporol
AND TO_CHAR(RR_FECHA,'MM/YYYY') = :is_periodo;
If sqlca.sqlcode < 0 then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los roles... "+sqlca.sqlerrtext)
rollback;
return -1
End if

return 0
end event

type st_1 from statictext within w_rep_roles_x_tipo
integer x = 27
integer y = 180
integer width = 1961
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
string text = "Para realizar la contabilizaci$$HEX1$$f300$$ENDHEX$$n seleccione la cuenta a la cual va a asignar el total de rol:"
boolean focusrectangle = false
end type

type dw_roles from datawindow within w_rep_roles_x_tipo
integer x = 3163
integer y = 4
integer width = 2482
integer height = 1036
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Asiento contable"
string dataobject = "d_contabiliza_rolmensual"
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;/* Inicia creaci$$HEX1$$f300$$ENDHEX$$n del asiento*/

/*DEBITOS*/
string    ls_periodo,ls_tiporol,ls_plcodigo,ls_cc,ls_signo,ls_nro
decimal{2} lc_valor,lc_debitos,lc_creditos
long      ll_sectipo,ll_reg,ll_cpnumero,i,ll_count

ll_reg = dw_roles.rowcount()
if ll_reg <= 0 then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para contabilizar")
	return
end if	

If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea contabilizar el Rol?",Question!,yesno!) = 2 then return
SELECT COUNT(1)
into  :ll_count
FROM NO_CABROL
WHERE  RR_TIPO = :is_tiporol
AND RR_CONTAB = 'S'
AND TO_CHAR(RR_FECHA,'MM/YYYY') = :is_periodo;

If ll_count > 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Este Rol ya ha sido contabilizado....por favor verifique.... !")
	Return
end if


Setpointer(Hourglass!)
w_marco.SetMicrohelp("Procesando el asiento.....por favor espere!")
ll_cpnumero = f_secuencial(str_appgeninfo.empresa,"CONTA_COMP")
ll_sectipo  = f_secuencial(str_appgeninfo.empresa,'DNO')

 INSERT INTO "CO_CABCOM"  
         ( "EM_CODIGO",   
           "SU_CODIGO",   
           "TI_CODIGO",   
           "CP_NUMERO",   
           "CP_FECHA",   
           "CP_SALDO",   
           "CP_DEBITO",   
           "CP_CREDITO",   
           "CP_OBSERV",   
           "SA_LOGIN",
		 "CP_MAYOR" 
          )  
  VALUES ( :str_appgeninfo.empresa,   
           :str_appgeninfo.sucursal,   
           '8',   
           :ll_cpnumero,   
           sysdate,   
           0,   
           0,   
           0,   
           :is_observa||' '||:is_periodo,   
           'cvalen' ,
		 'N'	  )  ;
			  
If sqlca.sqlcode < 0 then	
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al crear el asiento  "+sqlca.sqlerrtext)
	rollback;
	return
end if
			  

for i = 1 to ll_reg
	
	 ls_plcodigo = dw_roles.object.cuenta[i]
      ls_cc  = dw_roles.object.centro_costo[i]
      ls_signo  = dw_roles.object.signo[i]		
	 lc_valor = dw_roles.object.valor[i]	
	 
 
	 INSERT INTO "CO_DETCOM"  
         ( "EM_CODIGO",   
           "SU_CODIGO",   
           "TI_CODIGO",   
           "CP_NUMERO",   
           "PL_CODIGO",   
           "CS_CODIGO",   
           "DT_SECUE",   
           "DT_SIGNO",   
           "DT_VALOR",   
           "DT_DETALLE" )  
  VALUES ( :str_appgeninfo.empresa,   
           :str_appgeninfo.sucursal,   
           '8',   
           :ll_cpnumero,   
           :ls_plcodigo,   
           :ls_cc,   
           :i,   
           :ls_signo,   
           :lc_valor,   
           :is_observa||' '||:is_periodo ) ;
	If sqlca.sqlcode < 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al registrar valores..." +sqlca.sqlerrtext)
		rollback;
		return
	End if	
		

next

lc_debitos  = dw_roles.Object.cc_debitos[1]
lc_creditos = dw_roles.Object.cc_creditos[1]

if lc_debitos <> lc_creditos then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Asiento no cuadra por favor verifique")
rollback;
return
end if

update co_cabcom
set cp_debito  = :lc_debitos,
      cp_credito = :lc_creditos
 where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and cp_numero = :ll_cpnumero;

If sqlca.sqlcode < 0 then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el asiento "+sqlca.sqlerrtext)
rollback;
return
End if

/*Actualizar como contabilizados a todo los roles*/
UPDATE NO_CABROL
SET RR_CONTAB = 'S'
WHERE  RR_TIPO = :is_tiporol
AND TO_CHAR(RR_FECHA,'MM/YYYY') = :is_periodo;
If sqlca.sqlcode < 0 then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar los roles... "+sqlca.sqlerrtext)
rollback;
return
End if


Commit;
Setpointer(Arrow!)
dw_roles.visible = false
w_marco.setmicrohelp("Contabilizaci$$HEX1$$f300$$ENDHEX$$n exitosa....! Por favor revise asiento nro : "+string(ll_cpnumero))

end event


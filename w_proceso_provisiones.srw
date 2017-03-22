HA$PBExportHeader$w_proceso_provisiones.srw
$PBExportComments$Si.Proceso de Provisiones.
forward
global type w_proceso_provisiones from w_response_basic
end type
type dw_1 from datawindow within w_proceso_provisiones
end type
type dw_2 from datawindow within w_proceso_provisiones
end type
type dw_3 from datawindow within w_proceso_provisiones
end type
type dw_4 from datawindow within w_proceso_provisiones
end type
type dw_5 from datawindow within w_proceso_provisiones
end type
type cb_1 from commandbutton within w_proceso_provisiones
end type
end forward

global type w_proceso_provisiones from w_response_basic
integer width = 1550
integer height = 796
string title = "Provisiones"
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
cb_1 cb_1
end type
global w_proceso_provisiones w_proceso_provisiones

on w_proceso_provisiones.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.cb_1
end on

on w_proceso_provisiones.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_1)
end on

event open;call super::open;string ls_mmyyyy
date ld_periodo

select to_char(sysdate,'MM/YYYY')
into :ls_mmyyyy
from dual;

ls_mmyyyy = '01/'+ls_mmyyyy
ld_periodo = date(ls_mmyyyy)
dw_response.setitem(1,"fecha",ld_periodo)
f_recupera_empresa(dw_response,'ru_codigo')
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_4.SetTransObject(sqlca)
dw_5.SetTransObject(sqlca)


end event

type pb_cancel from w_response_basic`pb_cancel within w_proceso_provisiones
integer x = 1294
integer y = 404
integer width = 183
integer height = 160
end type

event pb_cancel::clicked;call super::clicked;close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_proceso_provisiones
integer x = 1111
integer y = 404
integer width = 183
integer height = 160
fontcharset fontcharset = ansi!
end type

event pb_ok::clicked;int    rtncode
dec{4} lc_porcen
string ls_ru_codigo,ls_periodo,ls_periodoant,ls_epcodigo,ls_secuen
long   ll_nreg,ll_i,ll_valor
datetime ld_hoy,ldt_fecrol
date ld_periodo
integer li_mes,li_anio,li_mesant,li_anioant


dw_response.AcceptText() 
setpointer(hourglass!)

if messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Esta seguro que desea procesar la Provisi$$HEX1$$f300$$ENDHEX$$n de este mes ',information!,yesno!,2) = 2 then
	return
end if

w_marco.setmicrohelp("Procesando...")
ld_periodo =  dw_response.GetItemDate(1,'fecha')

li_mes = month(ld_periodo)
li_anio = year(ld_periodo)


if li_mes = 1 then 
	li_mesant = 12 
	li_anioant = li_anio  -1
else
	li_mesant = li_mes -1
	li_anioant = li_anio
end if


ls_ru_codigo = dw_response.GetItemString(1,'ru_codigo')
if isnull(ls_ru_codigo) then 
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ingrese el rubro")
	return
end if

ls_periodo       = string(ld_periodo,'MM/YYYY')
ls_periodoant      = string(li_mesant,'00')+'/'+string(li_anioant)

SetPointer(Hourglass!)

SELECT count(1)
INTO :ll_valor
FROM no_cabrol r, no_emple e
WHERE r.ep_codigo = e.ep_codigo
and r.rr_pagado = 'N'
and r.rr_tipo = 'R'
and to_char(r.rr_fecha,'MM/YYYY') = :ls_periodoant;

if ll_valor > 0 then
	messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Rol de Pagos del mes anterior no ha sido cancelado...Verifique.')
	return
end if

SELECT rc_porcen   
INTO :lc_porcen   
FROM  no_rubcal
WHERE ru_codigo = :ls_ru_codigo;

if ls_ru_codigo <> '24' then
	ll_nreg = dw_4.retrieve(str_appgeninfo.empresa,lc_porcen,ls_ru_codigo,ls_periodo)
	if ll_nreg = 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos procesados para esta fecha")
		return
	end if
	ldt_fecrol = dw_4.getitemdatetime(1,"rr_fecha")
	
	select count(1) 
	into :ll_valor
	from no_cabrol c,no_rolpago d
	where c.ep_codigo = d.ep_codigo
	and c.rr_codigo = d.rr_codigo
	and trunc(rr_fecha) = :ldt_fecrol
	and rr_tipo = 'P'
	and ru_codigo = :ls_ru_codigo;
	if ll_valor > 0 then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Esta provisi$$HEX1$$f300$$ENDHEX$$n ya fue ejecutada...Verifique.')
		w_marco.setmicrohelp("Listo")	
		return
	end if
	dw_5.reset()
	for ll_i = 1 to ll_nreg
		ls_epcodigo = dw_4.getitemstring(ll_i,"ep_codigo")
		
		select to_char(max(nvl(to_number(x.rr_codigo),0)) + 1) "rr_codigo"
		into :ls_secuen
		from   no_cabrol x,no_emple e
		where  e.ep_codigo = x.ep_codigo
		and 	 e.em_codigo = :str_appgeninfo.empresa
		and    e.ep_codigo = :ls_epcodigo;
		
		dw_5.insertrow(0)
		dw_5.setitem(ll_i,"ep_codigo",ls_epcodigo)
		dw_5.setitem(ll_i,"rr_codigo",ls_secuen)		
	next

else
	select count(1) 
	into :ll_valor
	from no_cabrol c,no_rolpago d
	where c.ep_codigo = d.ep_codigo
	and c.rr_codigo = d.rr_codigo
	and to_char(c.rr_fecha,'MM/YYYY') = :ls_periodo
	and rr_tipo = 'Q'
	and ru_codigo = :ls_ru_codigo;
	if ll_valor > 0 then
		messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','La quincena ya fue ejecutada...Verifique.')
		w_marco.setmicrohelp("Listo")	
		return
	end if

end if
dw_2.reset()
dw_3.reset()
choose case ls_ru_codigo
	case '24'  //Primera quincena
		dw_1.retrieve(str_appgeninfo.empresa,lc_porcen)
		dw_2.object.ep_codigo.primary = dw_1.object.ep_codigo.primary
		dw_2.object.rr_codigo.primary = dw_1.object.rr_codigo.primary
		dw_2.object.rr_fecha.primary = dw_1.object.rr_fecha.primary
		dw_2.object.rr_horas.primary = dw_1.object.rr_horas.primary
		dw_2.object.rr_totingr.primary = dw_1.object.rr_totingr.primary
		dw_2.object.rr_totegre.primary = dw_1.object.rr_horas.primary
		dw_2.object.rr_liquido.primary = dw_1.object.rr_totingr.primary
		dw_2.object.rr_tipo.primary = dw_1.object.rr_tipo.primary
		dw_2.object.rr_pagado.primary = dw_1.object.rr_pagado.primary
		
		dw_3.object.ep_codigo.primary = dw_1.object.ep_codigo.primary		
		dw_3.object.rr_codigo.primary = dw_1.object.rr_codigo.primary
		dw_3.object.ru_codigo.primary = dw_1.object.quincena.primary
		dw_3.object.lq_valor.primary =  dw_1.object.rr_horas.primary		
		dw_3.object.lq_numhor.primary = dw_1.object.rr_horas.primary
		dw_3.object.lq_total.primary =  dw_1.object.rr_totingr.primary			
	case '15' //Fondo de reserva
	
		//dw_5.retrieve(str_appgeninfo.empresa,ls_periodo)		
		dw_2.object.ep_codigo.primary = 	dw_4.object.ep_codigo.primary
		dw_2.object.rr_codigo.primary = 	dw_5.object.rr_codigo.primary
		dw_2.object.rr_fecha.primary = 	dw_4.object.rr_fecha.primary
		dw_2.object.rr_horas.primary = 	dw_4.object.rr_horas.primary
		dw_2.object.rr_totingr.primary = dw_4.object.cc_fondores.primary
		dw_2.object.rr_totegre.primary = dw_4.object.rr_horas.primary
		dw_2.object.rr_liquido.primary = dw_4.object.cc_fondores.primary
		dw_2.object.rr_tipo.primary = 	dw_4.object.rr_tipo.primary
		dw_2.object.rr_pagado.primary = 	dw_4.object.rr_pagado.primary
		dw_2.object.cs_codigo.primary = 	dw_4.object.cs_codigo.primary		
		
		dw_3.object.ep_codigo.primary = dw_4.object.ep_codigo.primary		
		dw_3.object.rr_codigo.primary = dw_5.object.rr_codigo.primary
		dw_3.object.ru_codigo.primary = dw_4.object.ru_codigo.primary
		dw_3.object.lq_valor.primary =  dw_4.object.rr_horas.primary		
		dw_3.object.lq_numhor.primary = dw_4.object.rr_horas.primary
		dw_3.object.lq_total.primary =  dw_4.object.cc_fondores.primary				

	case '12'	//decimo tercer sueldo

		//dw_5.retrieve(str_appgeninfo.empresa,ls_periodo)		
		dw_2.object.ep_codigo.primary = 	dw_4.object.ep_codigo.primary
		dw_2.object.rr_codigo.primary = 	dw_5.object.rr_codigo.primary
		dw_2.object.rr_fecha.primary = 	dw_4.object.rr_fecha.primary
		dw_2.object.rr_horas.primary = 	dw_4.object.rr_horas.primary
		dw_2.object.rr_totingr.primary = dw_4.object.rr_totingr.primary
		dw_2.object.rr_totegre.primary = dw_4.object.rr_horas.primary
		dw_2.object.rr_liquido.primary = dw_4.object.rr_totingr.primary
		dw_2.object.rr_tipo.primary = 	dw_4.object.rr_tipo.primary
		dw_2.object.rr_pagado.primary = 	dw_4.object.rr_pagado.primary
		dw_2.object.cs_codigo.primary = 	dw_4.object.cs_codigo.primary		
		
		dw_3.object.ep_codigo.primary = dw_4.object.ep_codigo.primary		
		dw_3.object.rr_codigo.primary = dw_5.object.rr_codigo.primary
		dw_3.object.ru_codigo.primary = dw_4.object.ru_codigo.primary
		dw_3.object.lq_valor.primary =  dw_4.object.rr_horas.primary		
		dw_3.object.lq_numhor.primary = dw_4.object.rr_horas.primary
		dw_3.object.lq_total.primary =  dw_4.object.rr_totingr.primary				

		
	case '13'	//decimo cuarto sueldo		
		//dw_5.retrieve(str_appgeninfo.empresa,ls_periodo)		
     	dw_2.object.ep_codigo.primary = 	dw_4.object.ep_codigo.primary
		dw_2.object.rr_codigo.primary = 	dw_5.object.rr_codigo.primary
		dw_2.object.rr_fecha.primary = 	dw_4.object.rr_fecha.primary
		dw_2.object.rr_horas.primary = 	dw_4.object.rr_horas.primary
		dw_2.object.rr_totingr.primary = dw_4.object.cc_catorceavo.primary
		dw_2.object.rr_totegre.primary = dw_4.object.rr_horas.primary
		dw_2.object.rr_liquido.primary = dw_4.object.cc_catorceavo.primary
		dw_2.object.rr_tipo.primary = 	dw_4.object.rr_tipo.primary
		dw_2.object.rr_pagado.primary = 	dw_4.object.rr_pagado.primary
		dw_2.object.cs_codigo.primary = 	dw_4.object.cs_codigo.primary				
		
		dw_3.object.ep_codigo.primary = dw_4.object.ep_codigo.primary		
		dw_3.object.rr_codigo.primary = dw_5.object.rr_codigo.primary
		dw_3.object.ru_codigo.primary = dw_4.object.ru_codigo.primary
		dw_3.object.lq_valor.primary =  dw_4.object.rr_horas.primary		
		dw_3.object.lq_numhor.primary = dw_4.object.rr_horas.primary
		dw_3.object.lq_total.primary =  dw_4.object.cc_catorceavo.primary				

		
	case '16'	//Vacaciones

		//dw_5.retrieve(str_appgeninfo.empresa,ls_periodo)		
		dw_2.object.ep_codigo.primary = 	dw_4.object.ep_codigo.primary
		dw_2.object.rr_codigo.primary = 	dw_5.object.rr_codigo.primary
		dw_2.object.rr_fecha.primary = 	dw_4.object.rr_fecha.primary
		dw_2.object.rr_horas.primary = 	dw_4.object.rr_horas.primary
		dw_2.object.rr_totingr.primary = dw_4.object.cc_vacaciones.primary
		dw_2.object.rr_totegre.primary = dw_4.object.rr_horas.primary
		dw_2.object.rr_liquido.primary = dw_4.object.cc_vacaciones.primary
		dw_2.object.rr_tipo.primary = 	dw_4.object.rr_tipo.primary
		dw_2.object.rr_pagado.primary = 	dw_4.object.rr_pagado.primary
		dw_2.object.cs_codigo.primary = 	dw_4.object.cs_codigo.primary		
		
		dw_3.object.ep_codigo.primary = dw_4.object.ep_codigo.primary		
		dw_3.object.rr_codigo.primary = dw_5.object.rr_codigo.primary
		dw_3.object.ru_codigo.primary = dw_4.object.ru_codigo.primary
		dw_3.object.lq_valor.primary =  dw_4.object.rr_horas.primary		
		dw_3.object.lq_numhor.primary = dw_4.object.rr_horas.primary
		dw_3.object.lq_total.primary =  dw_4.object.cc_vacaciones.primary				
		
	case '39'	//Aporte patronal IESS
		//dw_5.retrieve(str_appgeninfo.empresa,ls_periodo)		
		dw_2.object.ep_codigo.primary = 	dw_4.object.ep_codigo.primary
		dw_2.object.rr_codigo.primary = 	dw_5.object.rr_codigo.primary
		dw_2.object.rr_fecha.primary = 	dw_4.object.rr_fecha.primary
		dw_2.object.rr_horas.primary = 	dw_4.object.rr_horas.primary
		dw_2.object.rr_totingr.primary = dw_4.object.rr_totingr.primary
		dw_2.object.rr_totegre.primary = dw_4.object.rr_horas.primary
		dw_2.object.rr_liquido.primary = dw_4.object.rr_totingr.primary
		dw_2.object.rr_tipo.primary = 	dw_4.object.rr_tipo.primary
		dw_2.object.rr_pagado.primary = 	dw_4.object.rr_pagado.primary
		dw_2.object.cs_codigo.primary = 	dw_4.object.cs_codigo.primary		
		
		dw_3.object.ep_codigo.primary = dw_4.object.ep_codigo.primary		
		dw_3.object.rr_codigo.primary = dw_5.object.rr_codigo.primary
		dw_3.object.ru_codigo.primary = dw_4.object.ru_codigo.primary
		dw_3.object.lq_valor.primary =  dw_4.object.rr_horas.primary		
		dw_3.object.lq_numhor.primary = dw_4.object.rr_horas.primary
		dw_3.object.lq_total.primary =  dw_4.object.rr_totingr.primary				
		
end choose

rtncode = dw_2.Update(TRUE, FALSE)
IF rtncode = 1 THEN
  rtncode = dw_3.Update(TRUE, FALSE)
  IF rtncode = 1 THEN
		dw_2.ResetUpdate() // Both updates are OK
		dw_3.ResetUpdate()// Clear update flags
		COMMIT; 
  ELSE
		ROLLBACK; // 2nd update failed
  END IF
ELSE
	ROLLBACK USING SQLCA; // 2nd update failed
END IF

w_marco.setmicrohelp("F$$HEX1$$ed00$$ENDHEX$$n del proceso")
SetPointer(Arrow!)

end event

type dw_response from w_response_basic`dw_response within w_proceso_provisiones
integer x = 73
integer y = 60
integer width = 1394
integer height = 320
string dataobject = "d_sel_fecha_rubro_proceso"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_1 from datawindow within w_proceso_provisiones
boolean visible = false
integer x = 96
integer y = 408
integer width = 192
integer height = 88
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_src_quincena"
boolean border = false
boolean livescroll = true
end type

type dw_2 from datawindow within w_proceso_provisiones
boolean visible = false
integer x = 366
integer y = 404
integer width = 192
integer height = 88
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_cabrol_provisiones"
boolean border = false
boolean livescroll = true
end type

type dw_3 from datawindow within w_proceso_provisiones
boolean visible = false
integer x = 608
integer y = 404
integer width = 192
integer height = 88
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_rolpago_provisiones"
boolean border = false
boolean livescroll = true
end type

type dw_4 from datawindow within w_proceso_provisiones
boolean visible = false
integer x = 837
integer y = 400
integer width = 224
integer height = 100
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_provisiones"
boolean border = false
end type

type dw_5 from datawindow within w_proceso_provisiones
boolean visible = false
integer x = 841
integer y = 520
integer width = 192
integer height = 88
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_secuencial_provisiones"
boolean border = false
end type

type cb_1 from commandbutton within w_proceso_provisiones
boolean visible = false
integer x = 1157
integer y = 604
integer width = 174
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "borrar"
end type

event clicked;string ep_codigo,rr_codigo
dec{2} lq_total
int li_si

li_si = messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro que desea borrar la~r~n"+& 
					  "Provision de este per$$HEX1$$ed00$$ENDHEX$$odo",question!,yesno!,2)
if li_si = 2 then return

setpointer(hourglass!)
declare b_provision cursor for
select x.ep_codigo,x.rr_codigo 
from   no_cabrol  x
where  to_char(x.rr_fecha,'MM/YYYY') = '06/2006'
and    x.rr_tipo = 'P'
order by to_number(x.ep_codigo);
open b_provision;
do
fetch b_provision into :ep_codigo,:rr_codigo;
if sqlca.sqlcode <> 0 then exit
	delete from no_rolpago
	where ep_codigo = :ep_codigo
	and 	rr_codigo = :rr_codigo;
	
//	delete from no_cabrol
//	where ep_codigo = :ep_codigo
//	and 	rr_codigo = :rr_codigo;

loop while true
close b_provision;
commit;
setpointer(arrow!)
w_marco.setmicrohelp("Proceso Terminado")
//

//string ep_codigo,rr_codigo
//int li_si
//
//li_si = messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro que desea borrar el~r~n"+& 
//					  "Ingreso de n$$HEX1$$f300$$ENDHEX$$mina",question!,yesno!,2)
//if li_si = 2 then return
//setpointer(hourglass!)
//declare b_provision cursor for
//select ep_codigo,rr_codigo 
//from no_cabrol
//where (trunc(rr_fecha) = trunc(sysdate)) and (rr_nroguia = 92 or rr_fecenvio is null) ;
//open b_provision;
//do
//fetch b_provision into :ep_codigo,:rr_codigo;
//if sqlca.sqlcode <> 0 then exit
//	delete from no_rolpago
//	where ep_codigo = :ep_codigo
//	and 	rr_codigo = :rr_codigo
//	and ru_codigo = 10;
//	delete from no_cabrol
//	where ep_codigo = :ep_codigo
//	and 	rr_codigo = :rr_codigo;
//
//loop while true
//close b_provision;
//commit;
//setpointer(arrow!)
//w_marco.setmicrohelp("Proceso Terminado")
//
end event


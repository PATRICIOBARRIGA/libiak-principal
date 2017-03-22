HA$PBExportHeader$w_rep_otros_pagos.srw
$PBExportComments$Si.
forward
global type w_rep_otros_pagos from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_otros_pagos
end type
type cb_1 from commandbutton within w_rep_otros_pagos
end type
type dw_2 from datawindow within w_rep_otros_pagos
end type
end forward

global type w_rep_otros_pagos from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2857
integer height = 1424
string title = "Pagos"
long backcolor = 81324524
dw_1 dw_1
cb_1 cb_1
dw_2 dw_2
end type
global w_rep_otros_pagos w_rep_otros_pagos

type variables
string   is_pepa , is_ruc
end variables

on w_rep_otros_pagos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_2
end on

on w_rep_otros_pagos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_2)
end on

event open;long ll_fila
dw_1.InsertRow(0)
this.ib_notautoretrieve = true
f_recupera_empresa(dw_1,'ru_codigo')
f_recupera_empresa(dw_1,'dt_codigo')
f_recupera_empresa(dw_1,'su_codigo')

select em_ruc
into :is_ruc
from pr_empre
where em_codigo = :str_appgeninfo.empresa;

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

event ue_retrieve;string ls_periodo,ls_ru_codigo,ls_filtro=' ',&
		ls_dt_codigo,ls_su_codigo,rr_codigo,ls_sucursal
long ll_nreg
char lch_pagado,lch_tipo
date ld_hasta,ld_periodo


SetPointer(HourGlass!)
dw_datos.SetRedraw(False)
dw_1.AcceptText()
ll_nreg = dw_1.getrow()
ls_dt_codigo = dw_1.GetItemString(ll_nreg,'dt_codigo')
ls_su_codigo = dw_1.GetItemString(ll_nreg,'su_codigo')
ls_ru_codigo = dw_1.GetItemString(ll_nreg,'ru_codigo')
ld_periodo = dw_1.GetItemdate(ll_nreg,'desde')
ld_hasta = dw_1.GetItemdate(ll_nreg,'hasta')
ls_periodo = string(dw_1.GetItemdate(ll_nreg,'desde'),'mm/yyyy')

if isnull(ld_periodo) or isnull(ld_hasta) then
	messageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Digite el Periodo")
	dw_datos.SetRedraw(True)
	SetPointer(Arrow!)	
	return
end if
if ld_periodo > ld_hasta then
		messageBox("Error","Rango de Fechas Incorrecto")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if

if isnull(ls_ru_codigo) or ls_ru_codigo = '' then
	messageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ingrese el Rubro")
	dw_datos.SetRedraw(True)
	return
end if


if isnull(ls_su_codigo) then
	 ls_filtro="(su_codigo like '%')"
else
	ls_filtro="su_codigo ='"+ls_su_codigo+"'"		
	select su_nombre
	into :ls_sucursal
	from pr_sucur 
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :ls_su_codigo;
end if
if not isnull(ls_dt_codigo) then
	 ls_filtro=ls_filtro+" and dt_codigo='"+ls_dt_codigo+"'"
end if


choose case dw_1.getcolumnname()
case 'rr_pagado'	
	     //Codigo trasladado al boton ok
case 'ru_codigo'
			if ls_ru_codigo = '24' then
				dw_datos.dataobject = "d_rep_quincena"
				dw_datos.settransobject(sqlca)
				if dw_datos.retrieve(str_appgeninfo.empresa,ls_periodo,ls_ru_codigo)>0 then
					if dw_datos.GetItemString(1,'rr_pagado')='S' then
						dw_1.SetItem(ll_nreg,'rr_pagado','S')
					end if
				end if
			end if
END CHOOSE

if ls_ru_codigo <> '24' then
	dw_datos.dataobject = "d_rep_provisiones"
	dw_datos.settransobject(sqlca)
	dw_datos.retrieve(str_appgeninfo.empresa,ls_ru_codigo,ld_periodo,ld_hasta)
end if	
dw_datos.SetRedraw(True)
dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' sucursal.text = '"+ls_sucursal+"' DataWindow.Print.Preview=Yes")
SetPointer(Arrow!)

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_otros_pagos
integer x = 0
integer y = 272
integer width = 2821
integer height = 1040
integer taborder = 30
string dataobject = "d_rep_quincena"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_otros_pagos
integer y = 0
integer taborder = 10
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_otros_pagos
end type

type dw_1 from datawindow within w_rep_otros_pagos
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 2821
integer height = 272
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sel_actualiza_otros_pagos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;Char lch_pagado
long ll_nreg
String ls_ru_codigo,ls_periodo


dw_1.AcceptText()
ll_nreg = dw_1.getrow()
ls_ru_codigo = dw_1.GetItemString(ll_nreg,'ru_codigo')
ls_periodo = string(dw_1.GetItemdate(ll_nreg,'desde'),'mm/yyyy')

if dwo.name  =  "b_1" then
          lch_pagado =  dw_1.getitemstring(ll_nreg,"rr_pagado")
		if lch_pagado ='S' and dw_datos.rowcount() > 0 and ls_ru_codigo = '24' then
			 if messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Desea que la Quincena del per$$HEX1$$ed00$$ENDHEX$$odo '+ls_periodo+' sea pagada?',Question!,YesNo!)=1 then
				update no_cabrol
				set rr_pagado = 'S'
				where rr_pagado = 'N'    
				and to_char(rr_fecha,'mm/yyyy') = :ls_periodo
				and rr_tipo = 'Q';
				if sqlca.sqlcode = 0 then
					commit;
					w_marco.setmicrohelp("La quincena ha sido pagada")
				end if
			 end if
		end if	
		if lch_pagado ='N' and dw_datos.rowcount() > 0 and ls_ru_codigo = '24' then
			 if messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Desea anular el pago de la Quincena del per$$HEX1$$ed00$$ENDHEX$$odo  '+ls_periodo+'?',Question!,YesNo!)=1 then
				update no_cabrol
				set rr_pagado = 'N'
				where rr_pagado = 'S'    
				and to_char(rr_fecha,'mm/yyyy') = :ls_periodo
				and rr_tipo = 'Q';
				if sqlca.sqlcode = 0 then
					commit;
					w_marco.setmicrohelp("La quincena ha sido pagada")
				end if
			 end if
		end if	
		
		
end if		
end event

type cb_1 from commandbutton within w_rep_otros_pagos
integer x = 2171
integer y = 148
integer width = 361
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;/*Exportar el rol de pagos de la quincena a un archivo*/
Long ll_nreg
string ls_periodo,ls_mes,ls_year
datastore lds_prn

lds_prn = Create DataStore
lds_prn.DataObject = 'd_rep_imp_quincena'
lds_prn.SetTransObject(sqlca)

dw_2.SetTransObject(SQLCA)
ls_periodo = string(dw_1.getitemdate(dw_1.getrow(),"desde"),'mm/yyyy')
ls_mes = mid(ls_periodo,1,2)
ls_year = mid(ls_periodo,4,7)
ls_year = ls_mes+ls_year
If ls_periodo ='' Then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el periodo")
	dw_1.setfocus()
	Return
else
	ll_nreg = dw_2.Retrieve(ls_periodo)
    If ll_nreg > 0 &
    Then 
	 If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea salvar el Rol de Quincena como archivo?",Question!,YesNo!,2) =2 Then Return
		 setpointer(hourglass!)
		 dw_2.saveas("Archivos\Pintulac15"+ls_year+".txt",Text!, false)
		 Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El archivo se grabo en Archivos\Pintulac15"+ls_year+".txt")
		 If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea imprimir el archivo?",Question!,YesNo!,1) = 1 &
		 Then
	    lds_prn.Retrieve(ls_periodo)
		 lds_prn.Modify("st_empresa.text = '"+gs_empresa+"' st_ruc.text = '"+is_ruc+"'")
		 lds_prn.print()
		 End if
    End if
End if	



end event

type dw_2 from datawindow within w_rep_otros_pagos
boolean visible = false
integer x = 2322
integer y = 288
integer width = 411
integer height = 432
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_fmt_full_bcopichincha"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


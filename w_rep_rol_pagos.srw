HA$PBExportHeader$w_rep_rol_pagos.srw
$PBExportComments$Si.Reporte de Rol de Pagos de los Empleados.
forward
global type w_rep_rol_pagos from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_rol_pagos
end type
type cb_1 from commandbutton within w_rep_rol_pagos
end type
type dw_2 from datawindow within w_rep_rol_pagos
end type
end forward

global type w_rep_rol_pagos from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2871
integer height = 1424
string title = "Rol de Pagos"
long backcolor = 1090519039
dw_1 dw_1
cb_1 cb_1
dw_2 dw_2
end type
global w_rep_rol_pagos w_rep_rol_pagos

type variables
string   is_pepa,is_ruc
end variables

on w_rep_rol_pagos.create
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

on w_rep_rol_pagos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_2)
end on

event open;datawindowChild ldw_aux
long ll_fila
dw_1.InsertRow(0)
this.ib_notautoretrieve = true

f_recupera_empresa(dw_1,'ep_codigo')
dw_datos.GetChild('ep_codigo',ldw_aux)
ll_fila=ldw_aux.InsertRow(0)

f_recupera_empresa(dw_1,'dt_codigo')
dw_datos.GetChild('dt_codigo',ldw_aux)
ll_fila=ldw_aux.InsertRow(0)

f_recupera_empresa(dw_1,'cr_codigo')
dw_datos.GetChild('cr_codigo',ldw_aux)
ll_fila=ldw_aux.InsertRow(0)

f_recupera_empresa(dw_1,'su_codigo')
dw_datos.GetChild('su_codigo',ldw_aux)
ll_fila=ldw_aux.InsertRow(0)


/*Para pintar el ruc en los reportes*/

select em_ruc
into   :is_ruc
from   pr_empre
where  em_codigo = :str_appgeninfo.empresa;





call super::open
//dw_datos.retrieve(str_appgeninfo.empresa,today())
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_rol_pagos
integer x = 0
integer y = 272
integer width = 2821
integer height = 1048
integer taborder = 20
string dataobject = "d_rep_cab_rol_pagos"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_rol_pagos
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_rol_pagos
end type

type dw_1 from datawindow within w_rep_rol_pagos
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 2834
integer height = 276
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_rol_pagos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;String ls_filtro,ls_ep_codigo,ls_dt_codigo,ls_su_codigo,ls_cr_codigo
String rr_codigo
Boolean fecha
Date ld_periodo
AcceptText()
SetPointer(HourGlass!)
dw_datos.SetRedraw(False)
ls_ep_codigo=GetItemString(row,'ep_codigo')
ls_dt_codigo=GetItemString(row,'dt_codigo')
ls_cr_codigo=GetItemString(row,'cr_codigo')
ls_su_codigo=GetItemString(row,'su_codigo')
ld_periodo=GetItemDate(row,'periodo')

If isnull(ld_periodo) or string(ld_periodo,'mm/yyyy')='00/0000' then
	messageBox('Error','Digite el Periodo del Rol.')
	dw_datos.SetRedraw(true)
	return
End if

if isnull(ls_su_codigo) then
	ls_filtro="(su_codigo like '%')"
else
	ls_filtro="su_codigo ='"+ls_su_codigo+"'"	
end if
if not isnull(ls_ep_codigo) then
	ls_filtro=ls_filtro+" and ep_codigo='"+ls_ep_codigo+"'"
end if
if not isnull(ls_dt_codigo) then
	ls_filtro=ls_filtro+" and dt_codigo='"+ls_dt_codigo+"'"
end if
if not isnull(ls_cr_codigo) then
	ls_filtro=ls_filtro+" and cr_codigo='"+ls_cr_codigo+"'"
end if
fecha=False

CHOOSE CASE this.getcolumnname()
CASE 'rr_pagado'		
		if data='S' and dw_datos.RowCount()>0 then
			if dw_datos.GetItemString(1,'rr_pagado')='S' then
			   this.SetItem(row,'rr_pagado','S')
			   messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','El Rol de Pagos del periodo '+string(ld_periodo,'mm-yyyy')+' ya fue pagado.',Information!)				
			elseif messageBox('Confirmaci$$HEX1$$f300$$ENDHEX$$n','Desea que el Rol de Pagos del periodo '+string(ld_periodo,'mm-yyyy')+' sea pagado?',Question!,YesNo!)=1 then
			   this.object.rr_pagado.protect=True
			   rr_codigo=dw_datos.GetItemString(1,'rr_codigo')
			   UPDATE "NO_CABROL"  
		       SET "RR_PAGADO" = 'S'  
			   WHERE "NO_CABROL"."RR_CODIGO" =:rr_codigo  AND  
         		           "NO_CABROL"."RR_TIPO"='R';
					  
			   UPDATE "NO_CABROL"  
			   SET        "RR_PAGADO" = 'S'  
			   WHERE  "NO_CABROL"."RR_CODIGO" in (  SELECT   "NO_CABROL"."RR_CODIGO"  
																	      FROM     "NO_CABROL",   
																			           "NO_ROLPAGO"  
																	      WHERE ( "NO_ROLPAGO"."EP_CODIGO" = "NO_CABROL"."EP_CODIGO" ) and  
																			          ( "NO_ROLPAGO"."RR_CODIGO" = "NO_CABROL"."RR_CODIGO" ) and  
																			          ( ( "NO_CABROL"."RR_PAGADO" = 'N' ) AND  
																			          ( TO_CHAR("NO_CABROL"."RR_FECHA",'mm') = to_char(:ld_periodo,'mm') ) AND  
																			          ( TO_CHAR("NO_CABROL"."RR_FECHA",'yyyy') = to_char(:ld_periodo,'yyyy') ) AND  
																			          ( "NO_CABROL"."RR_TIPO" = 'R' )  )  )  ;

		      //Confirmo el pago de los prestamos y anticipos
		       UPDATE "NO_DETPAG"  
		       SET "DP_CUOCANC" = 'S'  
			   WHERE "NO_DETPAG"."DP_CUOCANC" = 'P'   ;
		  	   UPDATE "NO_PRESTAMO"  
			   SET "PP_ESTADO" = 'T'  
			   WHERE LTRIM(RTRIM("NO_PRESTAMO"."PP_ESTADO")) = 'E'   ;
			   Commit;
		  End if
	 End if
CASE 'periodo'
		fecha=true
		If dw_datos.retrieve(str_appgeninfo.empresa,date(data))>0 then
			if dw_datos.GetItemString(1,'rr_pagado')='S' then
			   this.SetItem(row,'rr_pagado','S')
			end if
		End if
END CHOOSE

dw_datos.ScrolltoRow(1)
dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()
dw_datos.SetRedraw(True)
SetPointer(Arrow!)

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

type cb_1 from commandbutton within w_rep_rol_pagos
integer x = 2437
integer y = 24
integer width = 361
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;/*Exportar  e imprimir el rol de pagos a un archivo*/
Long ll_nreg
string ls_periodo,ls_mes
datastore  lds_imp_rol 

lds_imp_rol = Create DataStore
lds_imp_rol.DataObject = 'd_rep_imp_rol'
lds_imp_rol.SetTransObject(sqlca)


dw_2.SetTransObject(SQLCA)
ls_periodo = string(dw_1.getitemdate(dw_1.getrow(),"periodo"),'mm/yyyy')
ls_mes = mid(ls_periodo,1,2)
If ls_periodo = '' Then 
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el periodo")
	dw_1.setfocus()
	Return
else
	ll_nreg = dw_2.Retrieve(ls_periodo)
	if ll_nreg = 0 then 
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para exportar...Por favor verifique que  cada empleado tenga "+&
	                               "asignada una cuenta bancaria en la ficha personal")
	return
     end if
	If ll_nreg > 0 &
     then 
		If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea salvar el Rol de Pagos como archivo?",Question!,YesNo!,2) =2 Then Return
		setpointer(hourglass!)
		dw_2.saveas("Archivos\Rol"+ls_mes+".TXT",Text!, false)
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El archivo se grabo en Archivos\Rol"+ls_mes+".TXT")
		If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea imprimir el archivo?",Question!,YesNo!,1) = 1 &
		Then
	     lds_imp_rol.Retrieve(ls_periodo)
		lds_imp_rol.Modify("st_empresa.text = '"+gs_empresa+"' st_ruc.text = '"+is_ruc+"'")
		lds_imp_rol.print()
		End if
   End if
End if	

end event

type dw_2 from datawindow within w_rep_rol_pagos
boolean visible = false
integer x = 2295
integer y = 344
integer width = 411
integer height = 432
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_fmt_full_bcopichincha_roles"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


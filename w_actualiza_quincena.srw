HA$PBExportHeader$w_actualiza_quincena.srw
$PBExportComments$Si.Actualiza otros pagos a los empleados.
forward
global type w_actualiza_quincena from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_actualiza_quincena
end type
end forward

global type w_actualiza_quincena from w_sheet_1_dw_maint
integer x = 5
integer y = 300
integer width = 2368
integer height = 1508
string title = "Actualiza Otros Pagos"
long backcolor = 67108864
dw_1 dw_1
end type
global w_actualiza_quincena w_actualiza_quincena

on w_actualiza_quincena.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_actualiza_quincena.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;ib_notautoretrieve=True
dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'ru_codigo')
f_recupera_empresa(dw_1,'dt_codigo')
f_recupera_empresa(dw_1,'su_codigo')
call super::open
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
if this.ib_inReportMode then
	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
else
	dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
	dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
end if	
this.setRedraw(True)
end event

event ue_update;call super::ue_update;dec lq_ingresos=0, lq_egresos=0,lq_total=0
string ep_codigo,rr_codigo,ru_ioe
long i
for i=1 to dw_datos.RowCount()
		  lq_total=dw_datos.GetItemDecimal(i,'lq_total')
		  ep_codigo=dw_datos.GetItemString(i,'ep_codigo')
		  rr_codigo=dw_datos.GetItemString(i,'rr_codigo')
		  ru_ioe=dw_datos.GetItemString(i,'ru_ioe')
		  if ru_ioe='I' then 
			  lq_ingresos=lq_total
		  else
				lq_egresos=lq_total
				lq_total=-lq_total
 		  end if
		  	  UPDATE "NO_CABROL"  
   	  		SET   "RR_LIQUIDO" = :lq_total,   
	         		"RR_TOTINGR" = :lq_ingresos,   
		         	"RR_TOTEGRE" = :lq_egresos  
			   WHERE ( "NO_CABROL"."EP_CODIGO" = :ep_codigo ) AND  
      			   ( "NO_CABROL"."RR_CODIGO" = :rr_codigo ) AND  
		      	   ( "NO_CABROL"."RR_TIPO" = 'Q' )   ;
next
commit;
		
end event

event ue_retrieve;string ls_filtro,ls_1,ru_codigo,su_codigo,dt_codigo,ls_periodo

dw_1.AcceptText()
dt_codigo = dw_1.GetItemString(1,'dt_codigo')
su_codigo = dw_1.GetItemString(1,'su_codigo')

If isnull(su_codigo) then
ls_filtro="(su_codigo like '%')"
else
ls_filtro="su_codigo ='"+su_codigo+"'"
End if

If not isnull(dt_codigo) then
ls_filtro=ls_filtro+" and dt_codigo='"+dt_codigo+"'"
End if

ru_codigo = dw_1.GetItemString(1,'ru_codigo')
ls_periodo = string(dw_1.GetItemDate (1,'periodo'),'mm/yyyy')

If isnull(ru_codigo) or isnull(ls_periodo) Then Return	
dw_datos.retrieve(str_appgeninfo.empresa,ls_periodo,ru_codigo)			

/*Filtrar los datos por departamento y sucursal*/
dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_actualiza_quincena
integer y = 260
integer width = 2341
integer height = 1112
integer taborder = 20
string title = "Quincena"
string dataobject = "d_actualiza_otros_pagos"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_maint`dw_report within w_actualiza_quincena
integer x = 14
integer y = 272
integer width = 174
integer height = 124
integer taborder = 0
end type

type dw_1 from datawindow within w_actualiza_quincena
integer width = 2341
integer height = 260
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_cab_actualiza_otros_pagos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


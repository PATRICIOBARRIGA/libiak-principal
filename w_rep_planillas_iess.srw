HA$PBExportHeader$w_rep_planillas_iess.srw
$PBExportComments$Si.
forward
global type w_rep_planillas_iess from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_planillas_iess
end type
end forward

global type w_rep_planillas_iess from w_sheet_1_dw_rep
integer width = 2757
integer height = 1872
string title = "Planillas IESS"
long backcolor = 79741120
dw_1 dw_1
end type
global w_rep_planillas_iess w_rep_planillas_iess

on w_rep_planillas_iess.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_planillas_iess.destroy
call super::destroy
destroy(this.dw_1)
end on

event closequery;return

end event

event open;dw_1.insertrow(0)
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

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_planillas_iess
integer x = 0
integer y = 188
integer width = 2725
integer height = 1548
integer taborder = 0
string dataobject = "d_archivo_plano_iess"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_planillas_iess
integer x = 114
integer y = 488
integer taborder = 0
end type

type dw_1 from datawindow within w_rep_planillas_iess
integer width = 2725
integer height = 188
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ext_aportes_iess"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;string ls_cabecera,periodo,ls_total,fechapago,ls_nroemple,ls_comprobante,&
           ls_emple,ls_mes
integer i
long ll_new
datastore lds_iess 

Setpointer(hourglass!)
If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Por favor recuerde actualizar el campo en N$$HEX1$$f300$$ENDHEX$$mina ~r~n"&
+"de los empleados que no aporten en este per$$HEX1$$ed00$$ENDHEX$$odo",Question!,OkCancel!,1) = 2 &
Then
Return
End if 
this.Accepttext()
w_marco.SetMicrohelp(this.tag)
periodo = string(dw_1.getitemdate(1,"periodo"),'yyyymm')
ls_mes = string(dw_1.getitemdate(1,"periodo"),'mm')
fechapago = string(dw_1.getitemdate(1,"fechapago"),'yyyymmdd')
ls_comprobante  = dw_1.getitemstring(1,"comprob")

/*Calcular el total de aportes*/
select LPAD(SUM("NO_ROLPAGO"."LQ_TOTAL"*100),11,0),lpad(count(*)/3,5,0)
into : ls_total,:ls_nroemple
from  "NO_ROLPAGO", "NO_RUBRO", "NO_CABROL","NO_EMPLE" 
where ( "NO_RUBRO"."RU_CODIGO" = "NO_ROLPAGO"."RU_CODIGO" )
and ("NO_CABROL"."EP_CODIGO" = "NO_ROLPAGO"."EP_CODIGO" ) 
and ("NO_CABROL"."RR_CODIGO" = "NO_ROLPAGO"."RR_CODIGO" ) 
and ("NO_EMPLE"."EP_CODIGO" = "NO_CABROL"."EP_CODIGO")
and ("NO_EMPLE"."EP_FECSAL" is null OR to_char("NO_EMPLE"."EP_FECSAL",'yyyymm')=:periodo) 
and ("NO_EMPLE"."EP_NONOM" = 'S')
and ( to_char("NO_CABROL"."RR_FECHA",'yyyymm')=:periodo) 
and ("NO_ROLPAGO"."RU_CODIGO" IN ('1','6','7'));

select 'A'||rpad(em_numpat,11,' ')||rpad(em_nombre,30,' ')||rpad(em_ruc,13,0)||'170605220'||rpad(translate(replace(upper(em_calle1||em_calle2),'#',''),'$$HEX6$$c100c900cd00d300da00d100$$ENDHEX$$','AEIOUN'),27,' ')||rpad(replace(em_telef1,'-',''),6,0)||rpad( TRANSLATE(upper(em_aperep||' '||em_nomrep),'$$HEX6$$c100c900cd00d300da00d100$$ENDHEX$$','AEIOUN'),28,' ')||'A0'||'1001349479'||'1'||'00000000'||'00000000'||lpad(:periodo,6,'0')||lpad(:periodo,6,'0')||lpad(:fechapago,8,'0')||lpad(:ls_comprobante,6,'0')||'00000000000'||'00000000000'||'00000000000'||'121'||'001'||lpad(:ls_nroemple,5,0)||lpad(:ls_total,11,0)||'1'
into :ls_cabecera
from    pr_empre
where em_codigo = :str_appgeninfo.empresa;

lds_iess = Create datastore 
lds_iess.DataObject = 'd_planillas_iess'
lds_iess.SetTransObject(sqlca)
lds_iess.retrieve(periodo)
dw_datos.insertrow(0)
dw_datos.setitem( 1,"planilla",ls_cabecera)

for i = 1 to lds_iess.rowcount()
ll_new = dw_datos.insertrow(0)
ls_emple = lds_iess.getitemstring(i,"planilla")
dw_datos.setitem(ll_new,"planilla",ls_emple)
next

If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea salvar la planilla del IESS como archivo?",Question!,YesNo!,2) =2 Then Return
setpointer(hourglass!)
dw_datos.SaveAs("Archivos\A"+ls_mes+"33501.TXT",Text!, false)
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El archivo se grabo en Archivos\A"+ls_mes+"33501.TXT")
setpointer(arrow!)
w_marco.SetMicrohelp("Proceso Terminado")

end event


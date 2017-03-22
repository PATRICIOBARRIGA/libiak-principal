HA$PBExportHeader$w_rep_max_min_items_trans_rango.srw
$PBExportComments$Si.reporte de m$$HEX1$$e100$$ENDHEX$$ximos y m$$HEX1$$ed00$$ENDHEX$$nimos utilizando las tablas de movimirntos
forward
global type w_rep_max_min_items_trans_rango from w_sheet
end type
type dw_subclases from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_aux from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_kits from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_1 from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_detalle from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_ubica from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_datos from uo_dw_basic within w_rep_max_min_items_trans_rango
end type
type dw_item from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_cabecera from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_2 from datawindow within w_rep_max_min_items_trans_rango
end type
type dw_report from datawindow within w_rep_max_min_items_trans_rango
end type
end forward

shared variables

end variables

global type w_rep_max_min_items_trans_rango from w_sheet
integer width = 5435
integer height = 2608
string title = "Reporte de M$$HEX1$$e100$$ENDHEX$$ximos y M$$HEX1$$ed00$$ENDHEX$$nimos (Por Rangos) utilizando Ventas y Transferencias "
long backcolor = 81324524
event ue_retrieve pbm_custom01
event ue_firstrow pbm_custom02
event ue_priorrow pbm_custom03
event ue_nextrow pbm_custom04
event ue_lastrow pbm_custom05
event ue_sort pbm_custom06
event ue_print pbm_custom10
event ue_zoomin pbm_custom11
event ue_zoomout pbm_custom12
event ue_printcancel pbm_custom13
event ue_saveas pbm_custom14
event ue_consultar pbm_custom16
event ue_update pbm_custom08
event ue_filter pbm_custom07
dw_subclases dw_subclases
dw_aux dw_aux
dw_kits dw_kits
dw_1 dw_1
dw_detalle dw_detalle
dw_ubica dw_ubica
dw_datos dw_datos
dw_item dw_item
dw_cabecera dw_cabecera
dw_2 dw_2
dw_report dw_report
end type
global w_rep_max_min_items_trans_rango w_rep_max_min_items_trans_rango

type variables
s_argInformation istr_argInformation
boolean ib_notAutoRetrieve
boolean ib_inReportMode,ib_flagpedido
String is_sucenvio, is_secenvio


end variables

forward prototypes
public function integer wf_copyargs_basic ()
public function integer wf_preprint ()
public function integer wf_postprint ()
public function integer wf_copyargs ()
public function integer wf_genera_transferencia ()
public function integer wf_determina_atomos ()
end prototypes

event ue_retrieve;integer li_row,li_tipo,li_dantes,li_ddespues,li_dmax,li_cata,&
			li_catb,li_catc,li_catd,li_dmin = 7 
long ll_reg
string ls_codigo,ls_nombre,ls_clase,ls_fabricante
datawindowchild dwc_clase

setpointer(hourglass!)
dw_cabecera.accepttext()
li_row = dw_cabecera.getrow()
li_tipo = dw_cabecera.getitemnumber(li_row,'tipo')
choose case li_tipo 
	case 1 
	dw_cabecera.setitem(li_row,'d_antes',30)
   case 2 
	dw_cabecera.setitem(li_row,'d_antes',60)
   case 3 
	dw_cabecera.setitem(li_row,'d_antes',90)
   case 4 
	dw_cabecera.setitem(li_row,'d_antes',120)
end choose

li_dantes =dw_cabecera.getitemnumber(li_row,'d_antes')
li_ddespues = dw_cabecera.getitemnumber(li_row,'d_despues')
li_dmax = dw_cabecera.getitemnumber(li_row,'d_max')
li_cata = dw_cabecera.getitemnumber(li_row,'cata')
li_catb = dw_cabecera.getitemnumber(li_row,'catb')
li_catc = dw_cabecera.getitemnumber(li_row,'catc')
li_catd = dw_cabecera.getitemnumber(li_row,'catd')	
ls_codigo = dw_cabecera.getitemstring(li_row,'it_codant')
ls_nombre = dw_cabecera.getitemstring(li_row,'it_nombre')
ls_clase = dw_cabecera.getitemstring(li_row,'it_clase')
ls_fabricante = dw_cabecera.getitemstring(li_row,'it_fabricante')


If li_ddespues=0 or li_dmax=0 Then
	messagebox("Error","Falta ingresar parametros de los dias...<Verifique>")
	return
END IF
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' st_seccion.text = '"+gs_bo_nombre+"'")							
dw_datos.Getchild("clase",dwc_clase)
dwc_clase.SettransObject(sqlca)
dwc_clase.Retrieve(str_appgeninfo.empresa)
ll_reg = dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,li_tipo,&
								li_dantes,li_ddespues,li_dmin,li_dmax,li_cata,li_catb,li_catc,li_catd,&
								ls_codigo,ls_nombre,ls_clase,ls_fabricante,24,18,15,12,&
								                                                              2.99,0.99,0.29,0.8,&
																					   8,5,2,0.8)
if ll_reg <> 0 then							
dw_datos.SetRow(1)
dw_datos.setfocus()
end if
setpointer(arrow!)								


end event

event ue_firstrow;call super::ue_firstrow;dw_datos.uf_firstRow()
end event

event ue_priorrow;call super::ue_priorrow;dw_datos.uf_priorRow()
end event

event ue_nextrow;call super::ue_nextrow;dw_datos.uf_nextRow()
end event

event ue_lastrow;call super::ue_lastrow;dw_datos.uf_lastRow()
end event

event ue_sort;call super::ue_sort;dw_datos.uf_sort()
end event

event ue_print;integer li_res
openwithparm(w_dw_print_options,dw_datos)
li_res = message.doubleparm
if li_res <> 1 then
	li_res = 1
else
	li_res = dw_datos.print()
end if

end event

event ue_zoomin;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

end event

event ue_zoomout;int li_curZoom

li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end event

event ue_printcancel;call super::ue_printcancel;w_frame_basic lw_frame
m_frame_basic lm_frame

if this.ib_inReportMode then

	if this.wf_postPrint() = 1 then
		this.setRedraw(False)
		dw_report.enabled = False
		dw_report.visible = False
		dw_datos.enabled = True
		dw_datos.visible = True
		this.ib_inReportMode = False
		this.triggerEvent(resize!)		// so dw_datos get the correct size
		lw_frame = this.parentWindow()
		lm_frame = lw_frame.menuid
		lm_frame.mf_outof_report_mode()
	end if

else
	beep(1)
end if

this.setRedraw(True)

end event

event ue_saveas;
//if this.ib_inReportMode then
//         dw_datos.SaveAs()
//end if
string ls_itcodigo,ls_codant,lch_kit,ls_itnombre,ls_nulo
decimal lc_costo
Long ll_reg,ll_cantidad,ll_new,rc
Int i

dw_1.reset()
ll_reg = dw_datos.rowcount()


rc =  Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para salvar las columnas seleccionadas presione YES,~n~rPara salvar el pedido presione NO",Question!,YesNoCancel!,1)


choose case rc 
case 	1
	     dw_aux.saveas()
		dw_aux.reset()  
case  2
		for i = 1 to ll_reg
		ll_cantidad = dw_datos.getitemnumber(i,"cc_cantpedida")
		if ll_cantidad <> 0 then
		ls_itcodigo = dw_datos.getitemstring(i,"it_codigo")
		ls_codant = dw_datos.getitemstring(i,"codigo")
		lch_kit = dw_datos.getitemstring(i,"it_kit")		
		ls_itnombre = dw_datos.getitemstring(i,"producto")
		lc_costo = dw_datos.getitemdecimal(i,"costo")		
		ll_new = dw_1.insertrow(0)
		dw_1.setitem(ll_new,'su_codenv','24')
		dw_1.setitem(ll_new,'bo_codenv','24')
		dw_1.setitem(ll_new,'su_codigo',str_appgeninfo.sucursal)
		dw_1.setitem(ll_new,'bo_codigo',str_appgeninfo.seccion)
		dw_1.setitem(ll_new,'it_codigo',ls_itcodigo)
		dw_1.setitem(ll_new,'df_cantid',ll_cantidad)
		dw_1.setitem(ll_new,'df_secuen',string(i))
		dw_1.setitem(ll_new,'tf_ticket',0)
		dw_1.setitem(ll_new,'em_codigo',str_appgeninfo.empresa)
		dw_1.setitem(ll_new,'df_costo',lc_costo)
		dw_1.setitem(ll_new,'in_dettrans_df_stock',0)
		dw_1.setitem(ll_new,'in_dettrans_df_stkped',ll_cantidad)
		dw_1.setitem(ll_new,'codant',ls_codant)
		dw_1.setitem(ll_new,"it_nombre",ls_itnombre)
		dw_1.setitem(ll_new,"it_costo",lc_costo)	
		dw_1.setitem(ll_new,"it_kit",lch_kit)		
		dw_1.setitem(ll_new,"estado",ls_nulo)
		dw_1.setitem(ll_new,"cc_pedida",ll_cantidad)
		end if
		next
		
		if dw_1.rowcount() <= 0 then 
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para ser guardados")
		return
		end if	
		dw_1.saveas()
case 3
return	
end choose		

this.setRedraw(True)

end event

event ue_consultar;call super::ue_consultar;dw_cabecera	.postevent(DoubleClicked!)
end event

event ue_update;Setpointer(Hourglass!)

if ib_flagpedido = true then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$activo el proceso de inscripci$$HEX1$$f300$$ENDHEX$$n de pedido.~n~rPor favor termine la inscripci$$HEX1$$f300$$ENDHEX$$n......",Exclamation!)
	Return
end if

if dw_datos.update(true,false) < 1 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar datos "+sqlca.sqlerrtext)
	rollback;
	return
else
	commit;
end if	
Setpointer(Arrow!)

end event

event ue_filter;string ls_null
integer li_res

setNull(ls_null)
li_res = dw_datos.SetFilter(ls_null)
if li_res = 1 then
	dw_datos.Filter()
	return dw_datos.groupcalc()
else
	return li_res
end if

end event

public function integer wf_copyargs_basic ();//int li_arg

dw_datos.istr_argInformation = this.istr_argInformation

//dw_datos.istr_argInformation.nrArgs = this.istr_argInformation.nrArgs
//for li_arg = 1 to dw_datos.istr_argInformation.nrArgs
//	dw_datos.istr_argInformation.argType[li_arg] = lower(this.istr_argInformation.argType[li_arg])
//	choose case dw_datos.istr_argInformation.argType[li_arg]
//		case "string"
//			dw_datos.istr_argInformation.stringValue[li_arg] = this.istr_argInformation.stringValue[li_arg]
//		case "number"
//			dw_datos.istr_argInformation.numberValue[li_arg] = this.istr_argInformation.numberValue[li_arg]
//		case "date"
//			dw_datos.istr_argInformation.dateValue[li_arg] = this.istr_argInformation.dateValue[li_arg]
//		case "dateTime"
//			dw_datos.istr_argInformation.dateTimeValue[li_arg] = this.istr_argInformation.dateTimeValue[li_arg]
//		case "time"
//			dw_datos.istr_argInformation.timeValue[li_arg] = this.istr_argInformation.timeValue[li_arg]
//		case else
//			messageBox("Error de programaci$$HEX1$$f300$$ENDHEX$$n", "El argumento " + &
//					string(li_arg) + " tiene el tipo '" + &
//					dw_datos.istr_argInformation.argType[li_arg] + &
//					"' que es desconocido o no soportado", StopSign!)
//			return -1
//	end choose
//next

return 1

end function

public function integer wf_preprint ();if dw_report.dataObject = "" then
	dw_report.dataObject = dw_datos.dataObject
	return dw_datos.shareData(dw_report)
else
	return 1
end if

end function

public function integer wf_postprint ();return 1
end function

public function integer wf_copyargs ();// check if the dw needs args
if pos(dw_datos.describe("DataWindow.Table.Select"), ":") > 0 then
	return this.wf_copyargs_basic()
end if

return 1
end function

public function integer wf_genera_transferencia ();Long ll_ticket,ll_numero,ll_nreg,i,ll_stock,ll_cantidad,ll_envio
String ls_imp,ls_itcodigo
Decimal lc_costo

Setpointer(Hourglass!)
/*Verificar que existan datos para inscribir pedido*/
dw_datos.Setfilter("cc_pedir = 'S'")
dw_datos.filter()
ll_nreg = dw_datos.rowcount()


If ll_nreg <= 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para inscribir pedido")
	Return -1
end if	

w_marco.SetMicrohelp("Procesando pedido por favor espere.....")

//encuentra secuencial del ticket de envio de transferencia
Select nt_numero
into :ll_ticket
from pr_numtrans
where em_codigo = :str_appgeninfo.empresa
and su_codenv = :is_sucenvio
and bo_codenv = :is_secenvio
and su_codigo = :str_appgeninfo.sucursal
and bo_codigo = :str_appgeninfo.seccion
for update of nt_numero;

if sqlca.sqlcode <> 0 then
rollback;	
messageBox('Error','No se encuentra el siguiente n$$HEX1$$fa00$$ENDHEX$$mero del ticket.')
return -1
end if
	
	
//encuentra secuencial del numero de envio de transferencia
Select bo_transfer
into :ll_numero
from in_bode
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :is_sucenvio
and bo_codigo = :is_secenvio
for update of bo_transfer;
if sqlca.sqlcode <> 0 then
rollback;	
messageBox('Error','No se encuentra el siguiente n$$HEX1$$fa00$$ENDHEX$$mero de la transferencia')
return -1
end if	
	
	
 INSERT INTO "IN_TRANSFER"  
         ( "EM_CODIGO", 
           "SU_CODENV",   
           "BO_CODENV",   
           "SU_CODIGO",   
           "BO_CODIGO",   
           "TF_TICKET",   
           "TF_NUMERO",   
           "TF_FECHA",   
           "TF_HORA",   
           "EP_CODIGO",   
           "TF_ACEPTADA",   
           "TF_NUMENVIO",   
           "ESTADO",   
           "TF_CONTAB",
     	 "TF_FECPEDIDO")  
  VALUES (:str_appgeninfo.empresa,   
           :is_sucenvio,   
           :is_secenvio,   
           :str_appgeninfo.sucursal,   
           :str_appgeninfo.seccion,   
           :ll_ticket,   
           :ll_numero,   
           sysdate,   
           sysdate,   
           null,   
           'E',   
           null,   
           null ,  
           null,
	      sysdate) ;
IF sqlca.sqlcode < 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al inscribir pedido "+sqlca.sqlerrtext)
	Rollback;
	return -1
end if
/*Ingresar el detalle de la transferencia*/
ll_nreg = dw_datos.rowcount()
for  I = 1 to ll_nreg
		
		     ls_itcodigo  = dw_datos.GetItemstring(i,"it_codigo")
					
			select nvl(it_costo,0),nvl(y.it_stock,0)
              	into   :lc_costo,:ll_stock
           	from  in_item x, in_itesucur y
          	where x.it_codigo = y.it_codigo
               and x.em_codigo = y.em_codigo
               and y.em_codigo = 1
               and y.su_codigo =:is_sucenvio
           	and y.it_codigo = :ls_itcodigo;
  
				  
			 ll_cantidad = dw_datos.Getitemnumber(i,"cc_cantpedida")

               if ll_cantidad > ll_stock then
				ll_envio = ll_stock
			else
				ll_envio = ll_cantidad
			end if				


                INSERT INTO "IN_DETTRANS"  
         ( "EM_CODIGO",   
           "SU_CODENV",   
           "BO_CODENV",   
           "SU_CODIGO",   
           "BO_CODIGO",   
           "TF_TICKET",   
           "DF_SECUEN",   
           "IT_CODIGO",   
           "DF_CANTID",   
           "ESTADO",   
           "DF_COSTO",   
           "DF_STOCK",   
           "DF_STKPED" )  
           VALUES ( :str_appgeninfo.empresa,   
          :is_sucenvio,   
          :is_secenvio,   
          :str_appgeninfo.sucursal,   
          :str_appgeninfo.seccion,   
          :ll_ticket,   
          :i,   
          :ls_itcodigo,   
           :ll_envio,   
           null,   
          :lc_costo,   
          :ll_stock,   
          :ll_cantidad )  ;
//	     end if
		 
      	if sqlca.sqlcode < 0 then
		Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al ingresar pedido "+sqlca.sqlerrtext)
		rollback;
		return -1
          end if
		 
		 
Next
			  
	  
			  
/*Incrementa secuenciales*/
Update in_bode
set bo_transfer = bo_transfer + 1
where em_codigo = :str_appgeninfo.empresa
and su_codigo =:is_sucenvio
and bo_codigo = :is_secenvio;
if sqlca.sqlcode <> 0 then
rollback;				
messageBox('Error','Problemas al actualizar el secuencial de la Transferencia')
return -1
end if  

update pr_numtrans
set nt_numero = nt_numero + 1
where em_codigo = :str_appgeninfo.empresa
and su_codenv =:is_sucenvio
and bo_codenv =:is_secenvio
and su_codigo = :str_appgeninfo.sucursal
and bo_codigo = :str_appgeninfo.seccion;	

if sqlca.sqlcode <> 0 then
rollback;				
messageBox('Error','Problemas al actualizar el secuencial del ticket')
return -1
end if
commit;  
Setpointer(Arrow!)
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Transferencia lista...Ticket N$$HEX1$$ba00$$ENDHEX$$..." +string(ll_ticket),Exclamation!)
return 1
end function

public function integer wf_determina_atomos ();Long ll_reg,i
String ls_itcodigo,ls_flagatomo

ll_reg = dw_datos.rowcount()

w_marco.SetMicroHelp("Determinando items que son componentes de Kits....")
/*Identificamos el item como atomo con la letra 'C'*/
for i = 1 to ll_reg
	
     ls_itcodigo = dw_datos.Object.it_codigo[i]
     Setnull(ls_flagatomo)
    	
	SELECT distinct 'S'
	into: ls_flagatomo
	FROM IN_RELITEM
	WHERE IT_CODIGO = :ls_itcodigo;
	
	if ls_flagatomo = 'S' then
	dw_datos.Object.cc_atomo[i] = 'C'
     end if
next	
w_marco.SetMicroHelp("Componentes de Kits identificados....")
return 1
end function

event activate;call super::activate;w_frame_basic lw_frame
m_frame_basic lm_frame

//m_marco.m_edicion.m_consultar1.enabled = TRUE
//m_marco.m_edicion.m_consultar1.visible = TRUE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = TRUE

lw_frame = this.parentWindow()
lm_frame = lw_frame.menuid
lm_frame.mf_into_report_mode()
m_marco.m_edicion.m_guardar.enabled = true
m_marco.m_edicion.m_guardar.visible = true
m_marco.m_edicion.m_guardar.toolbaritemvisible = TRUE


end event

event close;w_frame_basic lw_frame
m_frame_basic lm_frame

dw_datos.shareDataOff()

if this.ib_inReportMode then
	lw_frame = this.parentWindow()
	lm_frame = lw_frame.menuid
	lm_frame.mf_outof_report_mode()
end if

call super::close


end event

on w_rep_max_min_items_trans_rango.create
int iCurrent
call super::create
this.dw_subclases=create dw_subclases
this.dw_aux=create dw_aux
this.dw_kits=create dw_kits
this.dw_1=create dw_1
this.dw_detalle=create dw_detalle
this.dw_ubica=create dw_ubica
this.dw_datos=create dw_datos
this.dw_item=create dw_item
this.dw_cabecera=create dw_cabecera
this.dw_2=create dw_2
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_subclases
this.Control[iCurrent+2]=this.dw_aux
this.Control[iCurrent+3]=this.dw_kits
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_detalle
this.Control[iCurrent+6]=this.dw_ubica
this.Control[iCurrent+7]=this.dw_datos
this.Control[iCurrent+8]=this.dw_item
this.Control[iCurrent+9]=this.dw_cabecera
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.dw_report
end on

on w_rep_max_min_items_trans_rango.destroy
call super::destroy
destroy(this.dw_subclases)
destroy(this.dw_aux)
destroy(this.dw_kits)
destroy(this.dw_1)
destroy(this.dw_detalle)
destroy(this.dw_ubica)
destroy(this.dw_datos)
destroy(this.dw_item)
destroy(this.dw_cabecera)
destroy(this.dw_2)
destroy(this.dw_report)
end on

event open;ib_inReportMode = true
dw_datos.settransobject(sqlca)
//dw_item.settransobject(sqlca)
//dw_1.settransobject(sqlca)
dw_detalle.SettransObject(sqlca)
dw_kits.SetTransObject(sqlca) //para ver la equivalencia del pedido en kits
dw_cabecera.insertrow(0)
this.ib_notautoretrieve = true
call super::open
//dw_datos.modify("datawindow.print.preview.zoom=100~t" + &
//									"datawindow.print.preview=yes")


/*Para inscribir pedido en una sucursal*/
    long ll_newRow
     long ll_aux
	Datawindowchild ldwc_aux	

 
     ll_newRow = dw_2.insertRow(1)
     if ll_newRow < 1 then
	messageBox("Error Fatal", "No se puede insertar una fila en la ventana de datos", StopSign!)
	setNull(ll_aux)
     end if


	dw_2.GetChild("sucursal",ldwc_aux)
	ldwc_aux.SetTransObject(sqlca)
	ldwc_aux.retrieve(str_appgeninfo.empresa)
	
	dw_2.GetChild("bodega",ldwc_aux)
	ldwc_aux.SetTransObject(sqlca)
	ldwc_aux.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
	
	m_marco.m_ventana.m_todo.triggerevent(clicked!)
/**/
f_recupera_empresa(dw_subclases,"cl_codigo")
end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_cabecera.resize(li_width - 2*dw_cabecera.x, li_height - 5)
dw_datos.resize(dw_cabecera.width - 420,li_height - dw_datos.y - dw_cabecera.y)
this.setRedraw(True)



end event

event deactivate;call super::deactivate;
//m_marco.m_edicion.m_consultar1.enabled = FALSE
//m_marco.m_edicion.m_consultar1.visible = FALSE
//m_marco.m_edicion.m_consultar1.toolbaritemvisible = FALSE
//
end event

type dw_subclases from datawindow within w_rep_max_min_items_trans_rango
boolean visible = false
integer x = 1701
integer y = 1556
integer width = 1408
integer height = 360
integer taborder = 70
boolean titlebar = true
string title = "Departamentos"
string dataobject = "d_sel_clases"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;Long i
String ls_clase,ls_itcodigo



if dwo.name = 'b_1' then
if Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de cambiar la ubicaci$$HEX1$$f300$$ENDHEX$$n de los items listados?",Question!,YesNo!, 2) = 2 then return
ls_clase  = this.Object.cl_codigo[1]

for i = 1 to dw_datos.rowcount()

ls_itcodigo = dw_datos.getitemstring(i,"it_codigo")
update in_item
set cl_codigo =:ls_clase
where em_codigo = :str_appgeninfo.empresa
and it_codigo = :ls_itcodigo;
if sqlca.sqlcode < 0 then
rollback;		
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el cambio de departamento del item "+sqlca.sqlerrtext)
return
end if
next

commit;
w_marco.Setmicrohelp("Listo...los items han cambiado de ubicaci$$HEX1$$f300$$ENDHEX$$n")
this.visible = false
end if

if dwo.name = 'b_2' then this.visible = false
end event

type dw_aux from datawindow within w_rep_max_min_items_trans_rango
boolean visible = false
integer x = 869
integer y = 1364
integer width = 2976
integer height = 500
integer taborder = 70
boolean titlebar = true
string title = "none"
string dataobject = "d_lista_columnas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_kits from datawindow within w_rep_max_min_items_trans_rango
boolean visible = false
integer x = 1582
integer y = 564
integer width = 1888
integer height = 576
integer taborder = 50
boolean titlebar = true
string title = "Equivalencia de kits"
string dataobject = "d_equivalencia_kits"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event buttonclicked;Long   ll_row,ll_rowm,ll_cantidad
String ls_codkit,ls_codatomo,ls_nomkit ,ls_kit

///*Retornar con el valor elegido*/
ll_row = dw_datos.getrow()
if ll_row = 0 then return
ll_rowm = this.getrow()

ls_codatomo   =  this.Object.in_item_intatomo[ll_rowm]
ls_codkit         =  this.Object.in_item_intkit[ll_rowm]
ls_kit               =  this.Object.in_item_codkit[ll_rowm]
ls_nomkit        =  this.Object.in_item_nomkit[ll_rowm]


ll_cantidad      =  this.Object.cc_cantidad_x_pedir[ll_rowm]
dw_datos.Object.cc_cantpedida[ll_row] = ll_cantidad
dw_datos.Object.it_codigo[ll_row] = ls_codkit
dw_datos.Object.codigo[ll_row] = ls_kit
dw_datos.Object.producto[ll_row] = ls_nomkit
dw_datos.Object.cc_pedir[ll_row]  = 'S'
dw_datos.Object.codalterno[ll_row]= '*'	


return 1
end event

type dw_1 from datawindow within w_rep_max_min_items_trans_rango
boolean visible = false
integer x = 1344
integer y = 1344
integer width = 2263
integer height = 400
integer taborder = 50
string title = "none"
string dataobject = "d_det_transferencia"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_detalle from datawindow within w_rep_max_min_items_trans_rango
boolean visible = false
integer x = 1243
integer width = 2341
integer height = 2460
integer taborder = 20
boolean titlebar = true
string title = "Sucursales"
string dataobject = "d_rep_max_min_aux_item_rango"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
end type

type dw_ubica from datawindow within w_rep_max_min_items_trans_rango
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 398
integer y = 540
integer width = 2592
integer height = 264
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Ticket"
string dataobject = "d_sel_item"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
    dw_cabecera.SetFocus()
end if
end event

event doubleclicked;dw_detalle.visible = false
dw_ubica.Visible = false
dw_cabecera.SetFocus()

end event

event itemchanged;string ls_criterio, ls_tipo
long ll_found


 ls_tipo = this.GetItemString(1,'tipo')
 If dwo.name = 'producto' Then
 CHOOSE CASE ls_tipo
	CASE '1'
		ls_criterio = "codigo = '" +  data +"'"
		ll_found = dw_datos.Find(ls_criterio,1,dw_datos.RowCount())
		if ll_found > 0 and not isnull(ll_found) then
		  dw_datos.ScrollToRow(ll_found)
		  dw_datos.SetRow(ll_found)
		  dw_datos.SetFocus()		  
		  this.Visible = false
		else
		  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Producto no se encuentra, verifique datos')
		  return
	  end if
END CHOOSE
End if
end event

event editchanged;String ls_criterio,ls_data
Long  ll_find,ll_nreg

		
if this.object.tipo[1] = '2' then
	
	
if not isnull(data )and data<>"" then
ls_data = data+'%'
else 
Setnull(ls_data)
end if	

ll_nreg = dw_datos.rowcount()	
ll_find = dw_datos.find("producto like'"+ls_data+"'",1,ll_nreg)

if ll_find <> 0 then
dw_datos.selectrow(0,false)
dw_datos.scrolltorow(ll_find)
dw_datos.Setrow(ll_find)
else	
dw_datos.selectrow(0,false)
dw_datos.Setrow(0)
end if   
end if
end event

type dw_datos from uo_dw_basic within w_rep_max_min_items_trans_rango
integer x = 407
integer y = 476
integer width = 4969
integer height = 2008
integer taborder = 30
string dataobject = "d_rep_max_min_aux_rango_grid"
boolean hsplitscroll = true
boolean livescroll = false
end type

event rbuttondown;call super::rbuttondown;window lw_aux
m_click_derecho m_aux
m_aux =create m_click_derecho
lw_aux = parent.parentwindow()
m_aux.m_impresion.popmenu(lw_aux.pointerx(),lw_aux.pointery())
destroy m_aux
end event

event itemchanged;call super::itemchanged;This.Accepttext()
If dwo.name = "cc_cantpedida"&
then
if dec(data) <> 0 Then
this.setitem(row,"cc_pedir",'S')
else
this.setitem(row,"cc_pedir",'N')
end if
End if

end event

event retrieveend;If rowcount <= 0 then 
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen para desplegar")
return
else
/*Determinar si los items son at$$HEX1$$f300$$ENDHEX$$mos o no*/
//wf_determina_atomos()
dw_datos.object.cc_pedir.primary = dw_datos.object.cc_marca.primary
end if


	
end event

event doubleclicked;call super::doubleclicked;
integer li_row,li_tipo,li_dantes,li_ddespues,li_dmax,li_cata,&
			li_catb,li_catc,li_catd,li_dmin = 7 
long ll_reg,ll_sugerido
string ls_codigo,ls_nombre,ls_clase,ls_fabricante,ls_pepa,ls_codatomo,ls_codkit,ls_atomo,ls_data,ls_itcodigo
//datawindowchild dwc_clase

//dw_cabecera.accepttext()

li_row = dw_cabecera.getrow()
li_tipo = dw_cabecera.getitemnumber(li_row,'tipo')
//choose case li_tipo 
//	case 1 
//	dw_detalle.setitem(li_row,'d_antes',30)
//   case 2 
//	dw_detalle.setitem(li_row,'d_antes',60)
//   case 3 
//	dw_detalle.setitem(li_row,'d_antes',90)
//   case 4 
//	dw_detalle.setitem(li_row,'d_antes',120)
//end choose

setpointer(hourglass!)
li_dantes =dw_cabecera.getitemnumber(li_row,'d_antes')
li_ddespues = dw_cabecera.getitemnumber(li_row,'d_despues')
li_dmax = dw_cabecera.getitemnumber(li_row,'d_max')
li_cata = dw_cabecera.getitemnumber(li_row,'cata')
li_catb = dw_cabecera.getitemnumber(li_row,'catb')
li_catc = dw_cabecera.getitemnumber(li_row,'catc')
li_catd = dw_cabecera.getitemnumber(li_row,'catd')	
ls_codigo = dw_datos.getitemstring(dw_datos.getrow(),'codigo')
ls_itcodigo = dw_datos.getitemstring(dw_datos.getrow(),'it_codigo')

If li_ddespues=0 or li_dmax=0 Then
	messagebox("Error","Falta ingresar parametros de los dias...<Verifique>")
	return
END IF
//dw_datos.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' st_seccion.text = '"+gs_bo_nombre+"'")							
//dw_datos.Getchild("clase",dwc_clase)
if dwo.name = 'cc_cantpedida' then
   dw_detalle.visible =true
   ll_reg = dw_detalle.retrieve(str_appgeninfo.empresa,li_tipo,&
								li_dantes,li_ddespues,li_dmin,li_dmax,li_cata,li_catb,li_catc,li_catd,&
								ls_itcodigo)
  if ll_reg <> 0 then							
  dw_detalle.SetRow(1)
  end if
end if	
	
/**/	
if dwo.name = 'codigo' then
	this.setrow(row)
	this.scrolltorow(row)
     ls_pepa = this.getitemstring(row,"it_codigo")
	dw_item.visible = true
	if str_appgeninfo.sucursal = '90' then
		dw_item.DataObject='d_comportamiento_ventas_x_item_empresa'
		dw_item.SettransObject(sqlca)
	     dw_item.retrieve(ls_pepa)
   else	
		dw_item.DataObject='d_comportamiento_ventas_x_item'
		dw_item.SettransObject(sqlca)
		dw_item.retrieve(str_appgeninfo.sucursal,ls_pepa)
	end if	

	dw_item.setitem(1,"alta",li_cata)
	dw_item.setitem(1,"mediana",li_catb)
	dw_item.setitem(1,"regular",li_catc)
	dw_item.setitem(1,"baja",li_catd)	
	dw_item.modify("DataWindow.Print.Preview=Yes")
end if

if dwo.name = 'cc_componente' then
dw_kits.visible = true
ls_codatomo = this.object.it_codigo[row]
ll_sugerido = this.Object.sugerido[row]
this.setrow(row)
this.scrolltorow(row)
dw_kits.retrieve(ll_sugerido,ls_codatomo)
end if



if dwo.name = 'in_itebod_ib_stkmax' then	
	
end if



if dwo.name = 'codalterno' then
ls_data =	this.Object.codalterno[row]
if ls_data = '' or isnull(ls_data) then return
ls_codkit = this.object.it_codigo[row]
select  y.it_codigo ,x.it_codant,x.it_nombre
into    :ls_codatomo,:ls_atomo,:ls_nombre
from   in_item x,in_relitem y
where x.it_codigo = y.it_codigo
and y.it_codigo1 = :ls_codkit;

this.Object.it_codigo[row] = ls_codatomo
this.Object.codigo[row] = ls_atomo
this.Object.producto[row] = ls_nombre
this.Object.codalterno[row] = ''

end if
setpointer(arrow!)
end event

event clicked;call super::clicked;
if dwo.name = 't_1' then  dw_aux.Object.codant.primary = dw_datos.Object.codigo.primary
if dwo.name = 't_2' then dw_aux.Object.producto.primary = dw_datos.Object.producto.primary
if dwo.name = 't_24' then  dw_aux.Object.rotacion.primary = dw_datos.Object.rotacion.primary

if dwo.name = 't_3' then dw_aux.Object.unid_vend_60.primary    =     dw_datos.Object.ventas_60_dias.primary
if dwo.name = 't_27' then  dw_aux.Object.unid_vend.primary =  dw_datos.Object.ventas_otros_dias.primary
if dwo.name = 't_4' then dw_aux.Object.promedio.primary     = dw_datos.Object.promedio.primary

if dwo.name = 't_5' then  dw_aux.Object.stock.primary =   dw_datos.Object.stock.primary
if dwo.name = 't_6' then dw_aux.Object.abastecido.primary =    dw_datos.Object.dias.primary

if dwo.name = 't_8' then  dw_aux.Object.sugerido_para_x_dias.primary =   dw_datos.Object.sugerido2.primary
if dwo.name = 't_18' then dw_aux.Object.maximo.primary =  dw_datos.Object.maximo.primary

if dwo.name = 't_9' then  dw_aux.Object.sugerido.primary = dw_datos.Object.sugerido.primary
if dwo.name = 't_20' then dw_aux.Object.pedido.primary = dw_datos.Object.cc_cantpedida.primary
if dwo.name = 't_10' then  dw_aux.Object.sugerido_dias_adic.primary = dw_datos.Object.especial.primary

if dwo.name = 't_12' then dw_aux.Object.costo_maxprimary = dw_datos.Object.costo_maximo.primary
if dwo.name = 't_11' then  dw_aux.Object.costo_especial.primary = dw_datos.Object.costo_especial.primary

if dwo.name = 't_25' then dw_aux.Object.stock_x_recibir.primary  =  dw_datos.Object.in_itebod_ib_stkmax.primary
if dwo.name = 't_26' then  dw_aux.Object.stock_x_entregar.primary =  dw_datos.Object.in_itebod_ib_stkmin.primary

if dwo.name = 'costo_t' then dw_aux.Object.costo.primary  =  dw_datos.Object.costo.primary
if dwo.name = 'precio_t' then  dw_aux.Object.precio.primary =  dw_datos.Object.precio.primary

end event

type dw_item from datawindow within w_rep_max_min_items_trans_rango
boolean visible = false
integer x = 393
integer y = 272
integer width = 3282
integer height = 1764
integer taborder = 20
boolean titlebar = true
string title = "Comportamiento Mensual"
string dataobject = "d_comportamiento_ventas_x_item"
boolean controlmenu = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_cabecera from datawindow within w_rep_max_min_items_trans_rango
integer width = 5399
integer height = 2500
integer taborder = 10
string dataobject = "d_rep_cab_max_min_aux_rango"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;call super::buttonclicked;
integer li_dantes,li_ddespues,li_dmin,li_dmax,li_tipo,li_cata,li_catb,li_catc,li_catd
string ls_stock,ls_filtro,ls_imp,ls_itcodant,ls_itnombre,ls_itcodigo,&
       ls_filename_d,ls_codant,as_codigo,as_nombre,as_clase,as_fabricante,&
		 ls_nulo,ls_criterio
long   ll_reg,i,ll_new,ll_cantidad
dec{2} lc_cantidad
dec{4} lc_costo
character lch_kit
DataWindowChild dwc_clase
w_frame_basic   lw_frame
setnull(ls_nulo)


lw_frame = parent.parentWindow()
/**/
This.AcceptText()
as_codigo = this.getitemstring(1,"it_codant")
as_nombre= this.getitemstring(1,"it_nombre")
as_clase= this.getitemstring(1,"it_clase")
as_fabricante =this.getitemstring(1,"it_fabricante")

/*Para cargar a la orden de compra*/
gds_pedido = create datastore
gds_pedido.dataobject="d_prn_pedido_maxmin"
gds_pedido.settransobject(sqlca)


gds_importacion = create datastore
gds_importacion.dataobject="d_prn_pedido_maxmin"
gds_importacion.settransobject(sqlca)


this.accepttext()
setpointer(hourglass!)
setnull(ls_filtro)
If dwo.name = 'b_1' Then  //establece los valores del stock actual para pedir
	dw_datos.object.cc_cantpedida.primary = dw_datos.object.cc_actual.primary //Stock actual
	dw_datos.object.cc_pedir.primary = dw_datos.object.cc_marca.primary
End if

If dwo.name = 'b_2' Then //establece la cantidad especial en cantidad pedida
	dw_datos.object.cc_cantpedida.primary = dw_datos.object.cc_cantesp.primary
	dw_datos.object.cc_pedir.primary = dw_datos.object.cc_marca.primary
End if

If dwo.name = 'b_3' Then
   If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro que desea imprimir?",question!,yesno!,1)= 2&
	Then
	Return
   End if
	dw_report.Reset()
	for I= 1 to dw_datos.rowcount()
		 ls_imp = dw_datos.GetitemString(i,"cc_pedir")
		 if ls_imp = 'S'Then
			 ls_itcodant = dw_datos.GetItemstring(i,"codigo")
			 ls_itnombre = dw_datos.GetitemString(i,"producto")
			 lc_cantidad = dw_datos.Getitemnumber(i,"cc_cantpedida")
			 lc_costo = dw_datos.Getitemdecimal(i,"costo")
			 ll_new = dw_report.insertrow(0)
			 dw_report.setitem(ll_new,"it_codant",ls_itcodant) 
 		     dw_report.setitem(ll_new,"it_nombre",ls_itnombre) 
   		     dw_report.setitem(ll_new,"it_cantidad",lc_cantidad)
			 dw_report.setitem(ll_new,"it_costo",lc_costo)		
	    end if
	next
	dw_report.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' st_seccion.text = '"+gs_bo_nombre+"'")	
	If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea imprimir con costo?",question!,yesno!,1)=2&
	Then
	dw_report.Object.t_4.visible  = 0
	dw_report.Object.t_5.visible = 0
     dw_report.Object.it_costo.Visible = 0
	dw_report.Object.cc_total.Visible = 0
	dw_report.Object.l_2.visible=0
	dw_report.Object.l_3.visible=0
	dw_report.Object.cc_sumcosto.visible=0
	dw_report.object.cc_sumtotal.visible=0
   else
	dw_report.Object.t_4.visible = 1
	dw_report.Object.t_5.visible = 1
     dw_report.Object.it_costo.Visible = 1
	dw_report.Object.cc_total.Visible = 1
	dw_report.Object.l_2.visible=1
	dw_report.Object.l_3.visible=1
	dw_report.Object.cc_sumcosto.visible=1
	dw_report.object.cc_sumtotal.visible=1
	End if
	dw_report.print()
End if	

If dwo.name = 'b_4'Then //genera la orden de compra directamente
	gds_pedido.reset()
	for i = 1 to dw_datos.rowcount()
		 ls_imp = dw_datos.GetitemString(i,"cc_pedir")
		 if ls_imp = 'S'Then
		 ll_new = gds_pedido.Insertrow(0)	
		 ls_itcodant = dw_datos.GetItemstring(i,"codigo")
		 ll_cantidad = dw_datos.Getitemnumber(i,"cc_cantpedida")
		 gds_pedido.setitem(ll_new,"it_codant",ls_itcodant) 
		 gds_pedido.setitem(ll_new,"it_cantidad",ll_cantidad)
//		 dw_datos.Setitem(i,"cc_cantpedida",0)
//		 dw_datos.Setitem(i,"cc_pedir",'N')
		 end if
   next
   opensheet(w_orden_compra,lw_frame)
End if	
/**/
If dwo.name = 'b_5' then //Genera un archivo para solicitar transferencia desde bodega principal
	dw_1.reset()
	ll_reg = dw_datos.rowcount()
	for i = 1 to ll_reg
	   ll_cantidad = dw_datos.getitemnumber(i,"cc_cantpedida")
		if ll_cantidad <> 0 then
		ls_itcodigo = dw_datos.getitemstring(i,"it_codigo")
		ls_codant = dw_datos.getitemstring(i,"codigo")
		lch_kit = dw_datos.getitemstring(i,"it_kit")		
		ls_itnombre = dw_datos.getitemstring(i,"producto")
		lc_costo = dw_datos.getitemdecimal(i,"costo")		
		ll_new = dw_1.insertrow(0)
		dw_1.setitem(ll_new,'su_codenv','24')
		dw_1.setitem(ll_new,'bo_codenv','24')
		dw_1.setitem(ll_new,'su_codigo',str_appgeninfo.sucursal)
		dw_1.setitem(ll_new,'bo_codigo',str_appgeninfo.seccion)
		dw_1.setitem(ll_new,'it_codigo',ls_itcodigo)
		dw_1.setitem(ll_new,'df_cantid',ll_cantidad)
          dw_1.setitem(ll_new,'df_secuen',string(i))
		dw_1.setitem(ll_new,'tf_ticket',0)
		dw_1.setitem(ll_new,'em_codigo',str_appgeninfo.empresa)
		dw_1.setitem(ll_new,'df_costo',lc_costo)
		dw_1.setitem(ll_new,'in_dettrans_df_stock',0)
		dw_1.setitem(ll_new,'in_dettrans_df_stkped',ll_cantidad)
		dw_1.setitem(ll_new,'codant',ls_codant)
		dw_1.setitem(ll_new,"it_nombre",ls_itnombre)
		dw_1.setitem(ll_new,"it_costo",lc_costo)	
		dw_1.setitem(ll_new,"it_kit",lch_kit)		
		dw_1.setitem(ll_new,"estado",ls_nulo)
		dw_1.setitem(ll_new,"cc_pedida",ll_cantidad)
		end if
   next
	if dw_1.rowcount() <= 0 then 
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos para ser guardados")
		return
	end if	
//	ls_filename_d = 'archivos\d_trf01.txt'
// dw_1.saveas(ls_filename_d,Text!,FALSE)
   dw_1.saveas()
end if

/*Para la columna de pedido tomar la cantidad sugerida por el reporte*/
If dwo.name = 'b_6' then
	dw_datos.object.cc_cantpedida.primary = dw_datos.object.cc_cantsug.primary
	dw_datos.object.cc_pedir.primary = dw_datos.object.cc_marca.primary
end if
/*Para la columna de pedido tomar la cantidad sugerida en CAJAS*/
If dwo.name = 'b_7' then
   dw_datos.object.cc_cantpedida.primary = dw_datos.object.cc_pedidocajas.primary
	dw_datos.object.cc_pedir.primary = dw_datos.object.cc_marca.primary
end if	
/*Encera la columna de pedido*/
If dwo.name = 'b_8' then
	dw_datos.object.cc_cantpedida.primary = dw_datos.object.cc_valini.primary
	dw_datos.object.cc_pedir.primary = dw_datos.object.cc_marca.primary
end if	
/*Encera la columna de recibir*/
If dwo.name = 'b_9' then
	dw_datos.object.in_itebod_ib_stkmax.primary = dw_datos.object.cc_valini.primary
end if	

/*Carga la columna recibir con la cantpedida*/
If dwo.name = 'b_10' then
	dw_datos.object.in_itebod_ib_stkmax.primary = dw_datos.object.cc_cantpedida.primary
end if	
/**/
/*Encera la columna de recibir*/
If dwo.name = 'b_11' then
	dw_datos.object.in_itebod_ib_stkmin.primary = dw_datos.object.cc_valini.primary
end if	
If dwo.name = 'b_12'then  //Envia lo seleccionado por mail
	dw_report.Reset()
	for I= 1 to dw_datos.rowcount()
		 ls_imp = dw_datos.GetitemString(i,"cc_pedir")
		 if ls_imp = 'S'Then
			 ls_itcodant = dw_datos.GetItemstring(i,"codigo")
			 ls_itnombre = dw_datos.GetitemString(i,"producto")
			 lc_cantidad = dw_datos.Getitemnumber(i,"cc_cantpedida")
			 lc_costo = dw_datos.Getitemdecimal(i,"costo")
			 ll_new = dw_report.insertrow(0)
			 dw_report.setitem(ll_new,"it_codant",ls_itcodant) 
 		     dw_report.setitem(ll_new,"it_nombre",ls_itnombre) 
   		     dw_report.setitem(ll_new,"it_cantidad",lc_cantidad)
			dw_report.setitem(ll_new,"it_costo",lc_costo)		
	    end if
	next
	dw_report.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' st_seccion.text = '"+gs_bo_nombre+"'")	
	If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Desea enviar con costo?",question!,yesno!,1)=2&
	Then
	dw_report.Object.t_4.visible  = 0
	dw_report.Object.t_5.visible = 0
    dw_report.Object.it_costo.Visible = 0
	dw_report.Object.cc_total.Visible = 0
	dw_report.Object.l_2.visible=0
	dw_report.Object.l_3.visible=0
	dw_report.Object.cc_sumcosto.visible=0
	dw_report.object.cc_sumtotal.visible=0
   else
	dw_report.Object.t_4.visible = 1
	dw_report.Object.t_5.visible = 1
     dw_report.Object.it_costo.Visible = 1
	dw_report.Object.cc_total.Visible = 1
	dw_report.Object.l_2.visible=1
	dw_report.Object.l_3.visible=1
	dw_report.Object.cc_sumcosto.visible=1
	dw_report.object.cc_sumtotal.visible=1
	End if
   OpenSheetWithParm(w_mail_send,dw_report,w_marco,15,Original!)
end if

If dwo.name = 'b_13' then  //Establece criterio de filtro para stock critico
   ls_criterio = "(rotacion= 'ALTA' and dias <= 12) or (rotacion = 'MEDIA' and dias <= 17) or (rotacion= 'REGULAR' and dias <= 25) or (rotacion = 'BAJA' and dias <= 30)"	
   dw_datos.Setfilter(ls_criterio)
   dw_datos.Filter()
   dw_datos.groupcalc()
end if	

If dwo.name = 'b_14' then //inscribir pedido para solicitar mediante transferencia
    if dw_2.visible = false then
	  dw_2.visible = true
	  ib_flagpedido = true
       else  
       dw_2.visible = false
	  ib_flagpedido = false	 
	end if 
end if	

If dwo.name = 'b_15' then //reasignacion de departamento a los items
	if str_appgeninfo.username <> 'cruiz'  then return
       dw_subclases.visible = true
       dw_subclases.insertrow(0)
end if	
If dwo.name = 'b_16'Then // registra el pedido en el modulo de compras para generar un documento de importacion
   gds_importacion.reset()
	for i = 1 to dw_datos.rowcount()
		 ll_cantidad = dw_datos.GetitemNumber(i,"in_itebod_ib_stkmax")
		 if ll_cantidad <> 0 then
		 ll_new = gds_importacion.Insertrow(0)	
		 ls_itcodant = dw_datos.GetItemstring(i,"codigo")
		 gds_importacion.setitem(ll_new,"it_codant",ls_itcodant) 
		 gds_importacion.setitem(ll_new,"it_cantidad",ll_cantidad)
  	      end if
   next
   opensheet(w_importacion_transito,lw_frame)
End if	

Setpointer(Arrow!)
end event

event doubleclicked;dw_ubica.Reset()
dw_ubica.title = "Buscar producto"
//dw_ubica.object.factura_t.text = "C$$HEX1$$f300$$ENDHEX$$digo:"
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event itemchanged;long ll_row,ll_nreg,i,li_cata,li_catb,li_catc,li_catd
DwObject  dwo_a,dwo_b,dwo_c,dwo_d
integer datos[]

dwo_a = dw_datos.Object.a
dwo_b = dw_datos.Object.b
dwo_c = dw_datos.Object.c
dwo_d = dw_datos.Object.d


ll_row  = dw_datos.Getrow()
ll_nreg = dw_datos.rowcount()

if ll_row = 0 then return
accepttext()
if dwo.name = 'cata' then
	li_cata = getitemnumber(1,'cata')
	dw_item.setitem(1,"alta",li_cata)
	setpointer(hourglass!)	
	for i = 1 to ll_nreg
     datos[i] = integer(data)
   next
	dwo_a.object.primary =  datos
	setpointer(arrow!)	
end if

if dwo.name = 'catb' then
	li_catb = getitemnumber(1,'catb')
	dw_item.setitem(1,"mediana",li_catb)		
	setpointer(hourglass!)	
	for i = 1 to ll_nreg
     datos[i] = integer(data)
   next
	dwo_b.object.primary =  datos
	setpointer(arrow!)	
end if
if dwo.name = 'catc' then
	li_catc = getitemnumber(1,'catc')	
	dw_item.setitem(1,"regular",li_catc)		
	setpointer(hourglass!)	
	for i = 1 to ll_nreg
     datos[i] = integer(data)
   next
	dwo_c.object.primary =  datos
	setpointer(arrow!)
end if
if dwo.name = 'catd' then
	li_catd = getitemnumber(1,'catd')	
	dw_item.setitem(1,"baja",li_catd)	
	setpointer(hourglass!)
	for i = 1 to ll_nreg
     datos[i] = integer(data)
   next
	dwo_d.object.primary =  datos
	setpointer(arrow!)
end if
	
end event

type dw_2 from datawindow within w_rep_max_min_items_trans_rango
boolean visible = false
integer x = 425
integer y = 916
integer width = 1504
integer height = 536
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Selecci$$HEX1$$f300$$ENDHEX$$n de sucursal"
string dataobject = "d_sel_sucursal_bodega"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;is_sucenvio = this.object.sucursal[1]
is_secenvio = this.object.bodega[1]

If is_sucenvio = str_appgeninfo.sucursal then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No puede realizar el pedido  a su misma sucursal!~n~rDebe elegir la sucursal de la que desea recibir la mercader$$HEX1$$ed00$$ENDHEX$$a",Exclamation!)
Return
end if


If dwo.name = 'b_1' then
	if wf_genera_transferencia() < 0 then
      return
	end if	
	dw_2.visible = false
end if	

If dwo.name = 'b_2' then
dw_2.visible = false
end if	
end event

event itemchanged;DataWindowChild	ldwc_aux
string    			ls_colname,ls_sucursal,ls_filtro


choose case dwo.name
	case "sucursal"
		ls_sucursal = data
		this.GetChild("bodega",ldwc_aux)
		ldwc_aux.SetTransObject(sqlca)
		ls_filtro = "su_codigo = "+"'"+ls_sucursal+"'"
		ldwc_aux.SetFilter(ls_filtro)
		ldwc_aux.Filter()
end choose	
end event

type dw_report from datawindow within w_rep_max_min_items_trans_rango
boolean visible = false
integer x = 1102
integer y = 276
integer width = 535
integer height = 168
integer taborder = 60
boolean enabled = false
string dataobject = "d_prn_pedido_maxmin"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type


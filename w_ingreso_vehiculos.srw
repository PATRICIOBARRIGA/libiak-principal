HA$PBExportHeader$w_ingreso_vehiculos.srw
$PBExportComments$Si
forward
global type w_ingreso_vehiculos from w_sheet_1_dw
end type
type cb_1 from commandbutton within w_ingreso_vehiculos
end type
type dw_movim from datawindow within w_ingreso_vehiculos
end type
type sle_1 from singlelineedit within w_ingreso_vehiculos
end type
type st_2 from statictext within w_ingreso_vehiculos
end type
type dw_1 from datawindow within w_ingreso_vehiculos
end type
type st_1 from statictext within w_ingreso_vehiculos
end type
type sle_2 from singlelineedit within w_ingreso_vehiculos
end type
type st_3 from statictext within w_ingreso_vehiculos
end type
type cb_2 from commandbutton within w_ingreso_vehiculos
end type
end forward

global type w_ingreso_vehiculos from w_sheet_1_dw
integer width = 4361
integer height = 2176
string title = "Ingreso de veh$$HEX1$$ed00$$ENDHEX$$culos"
event ue_update pbm_custom10
cb_1 cb_1
dw_movim dw_movim
sle_1 sle_1
st_2 st_2
dw_1 dw_1
st_1 st_1
sle_2 sle_2
st_3 st_3
cb_2 cb_2
end type
global w_ingreso_vehiculos w_ingreso_vehiculos

event ue_update;long     ll_max,ll_numrecep, ll_i, ll_j, ll_num_nota,ll_cantid,ll_num_movim, ll_fila, ll_secuen
string   ls_numrecep, ls_null, ls_kit, ls_itcodigo, ls_itcodigo2, ls_codant, ls_nulo, ls_empresa,ls_codprov,ls_nrofacpro
dec{4}   lc_costo
char     lch_kit, lch_estado
datetime ldt_hoy
int 		li_rc


setpointer(hourglass!)
setnull(ls_nulo)
dw_movim .reset()

select sysdate
into :ldt_hoy
from dual;

//Tomar secuencial de la Recepci$$HEX1$$f300$$ENDHEX$$n
select ps_valor
into :ll_num_nota
from pr_numsuc
where pr_nombre = 'NUM_ORD'
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
for update of ps_valor;
	
update pr_numsuc
set ps_valor = ps_valor + 1
where pr_nombre = 'NUM_ORD'
and em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal;
IF SQLCA.SQLCODE < 0 THEN
Rollback; 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al Actualizar el Secuencial de la recepci$$HEX1$$f300$$ENDHEX$$n" +SQLCA.SQLERRTEXT )
Return
END IF 

	
ls_numrecep = string(ll_num_nota)
ll_max = dw_datos.rowcount()
if ll_max = 0 then
	messageBox('Error','No se puede grabar no hay datos')
	return
end if	

//select em_nombre
//into :ls_empresa
//from pr_empre
//where em_codigo = 1;

if mid(gs_empresa,1,5) = 'TRECX' THEN
	ls_codprov = '2650'
	ls_nrofacpro = sle_1.text
	if isnull(ls_nrofacpro) or trim(ls_nrofacpro) = "" then
		messageBox('Error ', 'Antes de grabar debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de factura del proveedor')
		return
	end if
else
	ls_codprov = '2'
END IF 


//pv_codigo = 2 en unomotors es trecx ; pv_codigo = 2650 en trecx es unnomotors
  INSERT INTO "IN_COMPRA"  ( "EC_CODIGO",   "EM_CODIGO",   "SU_CODIGO","CO_NUMERO",   
										"PV_CODIGO",  "VP_CODIGO",   "CO_FACPRO","CO_FECHA",   
										"CO_FECREP",  "CO_SUBTOT",   "CO_IVA",   "CO_DESCUP",   
										"CO_TOTAL",   "EC_CODPAD",   "CO_NUMPAD","CO_COMPLETA",   
										"FP_CODIGO",  "CO_TRANSPOR", "CO_FECENT","CO_ENVIADA",   
						           	"CO_OBSERV",   "ESTADO",   "CO_RUCSUC" )  
  VALUES ( 2, :str_appgeninfo.empresa, :str_appgeninfo.sucursal, :ls_numrecep,   
           :ls_codprov,   1, :ls_nrofacpro,   sysdate,   
			  null,   0,   0,   0,   
			  0,   null,   null,   null,   
           null,   0,   null,   'N',   
           'Recepci$$HEX1$$f300$$ENDHEX$$n de Vehiculos', null, null )  ;
			  if sqlca.sqlcode < 0 then
				rollback;				
				messageBox('Error Interno','No se puede insertar la recepci$$HEX1$$f300$$ENDHEX$$n del veh$$HEX1$$ed00$$ENDHEX$$culo' + sqlca.sqlerrtext)
				return
			  end if

ll_secuen = 0
for ll_i = 1 to ll_max

	  ls_itcodigo =  dw_datos.getitemstring(ll_i,"it_codigo")
	  lch_estado =  dw_datos.getitemstring(ll_i,"estado")	  
	  dw_datos.setitem(ll_i,"co_recep",ls_numrecep)	  
	  ll_cantid = 0
	  if isnull(lch_estado) or lch_estado = '' then
		  for ll_j = ll_i to ll_max	  
				ls_itcodigo2 =  dw_datos.getitemstring(ll_j,"it_codigo")
				if ls_itcodigo2 = ls_itcodigo then
					ll_cantid++
					dw_datos.setitem(ll_j,"estado",'R')
				end if
			next
			
		  select it_costo,it_codant,it_kit
		  into :lc_costo,:ls_codant,:lch_kit
		  from in_item
		  where em_codigo = :str_appgeninfo.empresa
		  and it_codigo = :ls_itcodigo;
		  if lc_costo = 0 then
			rollback;		
			messageBox('Error ', 'No esta ingresado el costo del item '+ls_itcodigo)
			return
		  end if
		  
		  ll_secuen++
		  INSERT INTO "IN_DETCO"  
				( "EM_CODIGO",   "SU_CODIGO",   "BO_CODIGO",   "IT_CODIGO",   "EC_CODIGO",   
				  "CO_NUMERO",   "DC_SECUE",   "DC_CANTID",   "DC_COSTO",   "DC_DESC1",   
				  "DC_DESC2",   "DC_DESC3",   "DC_SUBTOT",   "DC_TOTAL",   "DC_UTILIDAD",   
				  "DC_PREACT",   "DC_NUEPRE",   "DC_ACTUALIZA",   "DC_SALDO",   "ESTADO")
		  VALUES ( :str_appgeninfo.empresa,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,:ls_itcodigo,'2',
				  :ls_numrecep, :ll_secuen, :ll_cantid, :lc_costo,   0,
				  0,   0,   0,   0,   0,   
				  0,   0,   'N',   null,   null)  ;
			if sqlca.sqlcode < 0 then
				rollback;				
				messageBox('Error Interno','No se puede insertar la recepci$$HEX1$$f300$$ENDHEX$$n del veh$$HEX1$$ed00$$ENDHEX$$culo' + sqlca.sqlerrtext)
				return
			end if
			
	
			If lch_kit = 'V' Then
				
				// carga el stock en sucursal del item
				update in_itesucur
				set it_stock = it_stock + :ll_cantid,
					it_stkreal = it_stkreal + :ll_cantid,
					it_stkdis = it_stkdis + :ll_cantid
				where it_codigo = :ls_itcodigo
				and em_codigo = :str_appgeninfo.empresa
				and su_codigo = :str_appgeninfo.sucursal;
				if sqlca.sqlcode <> 0 then
					rollback using sqlca;			
					MessageBox("ERROR ","No puedo actualizar el stock en sucursal.");
					return
				end if			
		
				// carga el stock en bodega del item
				update in_itebod
				set ib_stock = ib_stock + :ll_cantid
				where it_codigo = :ls_itcodigo
				and em_codigo = :str_appgeninfo.empresa
				and su_codigo = :str_appgeninfo.sucursal
				and bo_codigo = :str_appgeninfo.seccion;
				if sqlca.sqlcode <> 0 then
					rollback using sqlca;			
					MessageBox("ERROR ","No puedo actualizar el stock en bodega.");
					return
				end if
	
				//inserta los movimientos de inventario del item
				//Nota.-  En  tm_codigo=1, tm_ioe='I' es ingreso por compras
				ll_num_movim = f_dame_sig_numero('NUM_MINV')
				if ll_num_movim = -1 then
					rollback;		
					messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
					return
				end if
				ll_fila = dw_movim.insertrow(0)
				dw_movim.setitem(ll_fila,"tm_codigo",'1')
				dw_movim.setitem(ll_fila,"tm_ioe",'I')
				dw_movim.setitem(ll_fila,"it_codigo",ls_itcodigo)
				dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
				dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
				dw_movim.setitem(ll_fila,"mv_numero",string(ll_num_movim))	
				dw_movim.setitem(ll_fila,"mv_cantid",ll_cantid)		
				dw_movim.setitem(ll_fila,"mv_costo",lc_costo)
				dw_movim.setitem(ll_fila,"mv_fecha",ldt_hoy)	
				dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
				dw_movim.setitem(ll_fila,"mv_observ","Recepci$$HEX1$$f300$$ENDHEX$$n de compra No. "+ls_numrecep)		
				dw_movim.setitem(ll_fila,"mv_usado",'N')		
				dw_movim.setitem(ll_fila,"ve_numero",ll_num_nota)
				dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)
			else
					rollback;		
					messagebox('ERROR','Solo de se debe ingresar vehiculos...verifique')	
					return
				
			end if	  		
		end if

next

li_rc = dw_datos.Update(true,false)
if li_rc = 1 then			
	li_rc = dw_movim.update(true,false)	
	if li_rc = 1 then			
	 dw_movim.resetupdate()
	 commit;
	setpointer(arrow!)
	messagebox("Listo ","Proceso realizado con $$HEX1$$e900$$ENDHEX$$xito ") 
	else
	 rollback;
	 messagebox("Error","Problemas al actualizar el inventario "+sqlca.sqlerrtext) 
	 return
	end if
else
 rollback;
 messagebox("Error","Problemas al actualizar tabla in_itedet "+sqlca.sqlerrtext) 
 return
end if
	

end event

on w_ingreso_vehiculos.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_movim=create dw_movim
this.sle_1=create sle_1
this.st_2=create st_2
this.dw_1=create dw_1
this.st_1=create st_1
this.sle_2=create sle_2
this.st_3=create st_3
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_movim
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.sle_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.cb_2
end on

on w_ingreso_vehiculos.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_movim)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.sle_2)
destroy(this.st_3)
destroy(this.cb_2)
end on

event open;dw_datos.settransobject(sqlca)

f_recupera_empresa(dw_1,"ca_codigo")
f_recupera_empresa(dw_1,"mo_codigo")
f_recupera_empresa(dw_1,"co_codigo")
f_recupera_empresa(dw_1,"pa_codigo")
f_recupera_empresa(dw_1,"ma_codigo")

dw_1.sharedata(dw_datos)
dw_1.insertrow(0)
dw_movim.settransobject(sqlca)
if mid(gs_empresa,1,5) = 'TRECX' then
	sle_1.visible = true
	sle_1.setfocus()	
	st_2.visible = true
end if
ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
end event

event closequery;return 0
end event

event resize;return 1
end event

type dw_datos from w_sheet_1_dw`dw_datos within w_ingreso_vehiculos
integer x = 32
integer y = 140
integer width = 4233
integer height = 880
integer taborder = 0
string dataobject = "d_kardek_vehiculos"
end type

event dw_datos::updatestart;return 0
end event

type dw_report from w_sheet_1_dw`dw_report within w_ingreso_vehiculos
integer x = 27
integer y = 24
integer width = 206
integer height = 48
integer taborder = 0
end type

type cb_1 from commandbutton within w_ingreso_vehiculos
integer x = 2784
integer y = 1052
integer width = 471
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Importar"
end type

event clicked;string ls_codant, ls_codigo,null_str
long ll_i,li_rc
datetime ldt_hoy


Setnull(null_str)

select sysdate
into :ldt_hoy
from dual;

w_marco.SetMicroHelp("Procesando ingreso de vehiculos...")
//dw_datos.ImportFile('Archivos\vehiculos.TXT')
dw_datos.ImportFile(null_str)
for ll_i = 1 to dw_datos.rowcount()
	dw_datos.setitem(ll_i,"em_codigo",str_appgeninfo.empresa)
	dw_datos.setitem(ll_i,"su_codigo",str_appgeninfo.sucursal)	
	dw_datos.setitem(ll_i,"di_secuen",ll_i)		
	ls_codant = dw_datos.getitemstring(ll_i,"it_codant")

	select it_codigo
	into :ls_codigo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	if sqlca.sqlcode <> 0 then
		messagebox("Error...verifique","No existe c$$HEX1$$f300$$ENDHEX$$digo de veh$$HEX1$$ed00$$ENDHEX$$culo: "+ls_codant,stopsign!)
		return
	end if
	
	dw_datos.setitem(ll_i,"it_codigo",ls_codigo)
	dw_datos.setitem(ll_i,"di_fecha",ldt_hoy)	
next
w_marco.SetMicroHelp("Ingreso con $$HEX1$$e900$$ENDHEX$$xito")	

end event

type dw_movim from datawindow within w_ingreso_vehiculos
boolean visible = false
integer x = 261
integer y = 24
integer width = 155
integer height = 68
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_ingreso_vehiculos
boolean visible = false
integer x = 1198
integer y = 40
integer width = 526
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 13
borderstyle borderstyle = stylelowered!
end type

event modified;if (Match(this.text,"^[0-9]+$") and len(this.text) = 13) = false then
	messageBox('Error ', 'Solo debe ingresar n$$HEX1$$fa00$$ENDHEX$$meros')
	this.text = ""
	setfocus()
	return
end if
end event

type st_2 from statictext within w_ingreso_vehiculos
boolean visible = false
integer x = 613
integer y = 52
integer width = 558
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Nro. Factura Proveedor:"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_ingreso_vehiculos
integer x = 23
integer y = 1160
integer width = 4229
integer height = 860
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_ficha_vehiculo"
boolean livescroll = true
end type

event updatestart;this.object.em_codigo[this.getrow()] = str_appgeninfo.empresa
this.object.su_codigo[this.getrow()] = str_appgeninfo.sucursal
return 0
end event

type st_1 from statictext within w_ingreso_vehiculos
integer x = 37
integer y = 1068
integer width = 626
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Caracter$$HEX1$$ed00$$ENDHEX$$sticas del Veh$$HEX1$$ed00$$ENDHEX$$culo"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_ingreso_vehiculos
integer x = 2770
integer y = 40
integer width = 617
integer height = 64
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_ingreso_vehiculos
integer x = 2094
integer y = 44
integer width = 654
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Buscar por n$$HEX1$$fa00$$ENDHEX$$mero de motor:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_ingreso_vehiculos
integer x = 3296
integer y = 1052
integer width = 471
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta avanzada"
end type


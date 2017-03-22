HA$PBExportHeader$w_ajustes_x_preventa.srw
$PBExportComments$Si
forward
global type w_ajustes_x_preventa from w_sheet_1_dw_maint
end type
type dw_movim from datawindow within w_ajustes_x_preventa
end type
type em_1 from editmask within w_ajustes_x_preventa
end type
type em_2 from editmask within w_ajustes_x_preventa
end type
type st_1 from statictext within w_ajustes_x_preventa
end type
type st_2 from statictext within w_ajustes_x_preventa
end type
end forward

global type w_ajustes_x_preventa from w_sheet_1_dw_maint
integer width = 4827
integer height = 2140
string title = "Reversi$$HEX1$$f300$$ENDHEX$$n de ajuste por preventa"
long backcolor = 67108864
dw_movim dw_movim
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
end type
global w_ajustes_x_preventa w_ajustes_x_preventa

type variables
string is_codemple,is_codant
end variables

forward prototypes
public function boolean wf_mov_inventario (string as_numero, string as_nombod, string as_item, decimal ad_cantidad, datetime ad_fecha, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo)
end prototypes

public function boolean wf_mov_inventario (string as_numero, string as_nombod, string as_item, decimal ad_cantidad, datetime ad_fecha, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo);////////////////////////////////////////////////////////////////////////
// Decripci$$HEX1$$f300$$ENDHEX$$n : inserta los movimientos de inventario del item, si es
//               kit tambi$$HEX1$$e900$$ENDHEX$$n de sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
// Retorna verdadero si todo sali$$HEX2$$f3002000$$ENDHEX$$bien.
// Fecha de Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 19-10-2004
///////////////////////////////////////////////////////////////////////

long ll_num_movim,ll_fila
string ls_num_movim,ls_nulo,ls_observa,ls_obs_kit
boolean lb_exito = TRUE


setnull(ls_nulo)
ls_observa = "Ajuste de E. No. "+as_numero+" de "+as_nombod
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Ajuste de E. del kit "+is_codant+" No. "+as_numero+" de "+as_nombod
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'4')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_atomo)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad * ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo_atomo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_obs_kit)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numero))
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		

	// inserta el movimiento del kit (grande)
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		rollback;
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	// ingresa el Kit
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'4')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numero))
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		

else
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		rollback;		
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'4')
	dw_movim.setitem(ll_fila,"tm_ioe",'E')
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",long(as_numero))	
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return(TRUE)


end function

on w_ajustes_x_preventa.create
int iCurrent
call super::create
this.dw_movim=create dw_movim
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_movim
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
end on

on w_ajustes_x_preventa.destroy
call super::destroy
destroy(this.dw_movim)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;date ld_fecini,ld_fecfin
datetime ldt_hoy

ldt_hoy = f_hoy()

dw_movim.SetTransObject(sqlca)
/*Permite la conexion de los datawindows */
dw_datos.settransobject(sqlca)
em_1.text = string(ldt_hoy,'DD/MM/YYYY')
em_2.text = string(ldt_hoy,'DD/MM/YYYY')
ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)


select ep_codigo
into :is_codemple
from no_emple
where em_codigo = :str_appgeninfo.empresa
and  sa_login = :str_appgeninfo.username;

ib_notautoretrieve = true

call super::open
end event

event ue_retrieve;date ld_fecini,ld_fecfin

ld_fecini = date(em_1.text)
ld_fecfin = date(em_2.text)
if ld_fecfin < ld_fecini then
	messagebox("Error","Rango de fechas incorrecto",stopsign!)
	return
end if
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,+&
						ld_fecini,ld_fecfin)

end event

event closequery;return
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_ajustes_x_preventa
integer y = 180
integer width = 4782
integer height = 1852
integer taborder = 30
string dataobject = "d_ajuste_x_preventa"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_datos::itemchanged;string ls_numero,ls_itcodigo,ls_secuen,ls_atomo,ls_nombodega,ls_numajus
dec{2} lc_cantid,lc_stock,lc_costo_atomo,lc_cantatomo
dec{4} lc_costo
char lch_kit,lch_valstk,lch_estado
datetime ld_fecha
boolean 	lb_graba = true
integer li_rc,li_sino
long il_numero 
date 	ld_fecini,ld_fecfin

if dwo.name = "aj_estado" then

		li_sino = messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de que quiere realizar el ajuste de egreso por preventa",question!,yesno!,2)
		if li_sino = 1 then
			setpointer(hourglass!)
			w_marco.setmicrohelp("Procesando...espere por favor")
			
			ls_numero = getitemstring(row,"numero")			
			
			SELECT count(*)
			INTO :li_sino
			FROM "IN_CABAJUS"
			WHERE (( "IN_CABAJUS"."AJ_NUMERO" = :ls_numero ) AND    
			( "IN_CABAJUS"."TM_CODIGO" = '3' ) AND 
			( "IN_CABAJUS"."TM_IOE" = 'I' ) AND
			( "IN_CABAJUS"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
			( "IN_CABAJUS"."EM_CODIGO" = :str_appgeninfo.empresa) AND			
			( "IN_CABAJUS"."BO_CODIGO" = :str_appgeninfo.seccion) AND
			( "IN_CABAJUS"."AJ_ESTADO" = 'N'));
			
		  	if li_sino = 0 then
				messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Este ajuste de egreso ya fue procesado...<verifique> ')
				return
			end if

			
			dw_movim.reset()
			ld_fecini = date(em_1.text)
			ld_fecfin = date(em_2.text)
			if ld_fecfin < ld_fecini then
				messagebox("Error","Rango de fechas incorrecto",stopsign!)
				return
			end if
			//Encuentra el nombre de la bodega
			select bo_nombre
			into :ls_nombodega
			from in_bode
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and bo_codigo = :str_appgeninfo.seccion;
		
			il_numero = f_dame_sig_numero('NUM_AJUS')
			ls_numajus = string(il_numero)

			
		 	INSERT INTO "IN_CABAJUS"  
					( "SU_CODIGO",   
					  "BO_CODIGO",   
					  "AJ_NUMERO",   
					  "TM_CODIGO",   
					  "TM_IOE",   
					  "EP_CODIGO",   
					  "AJ_FECHA",   
					  "EM_CODIGO",   
					  "AJ_OBSERV",   
					  "ESTADO",   
					  "AJ_CONTAB",   
					  "AJ_ESTADO" )  
			VALUES ( :str_appgeninfo.sucursal,   
					  :str_appgeninfo.seccion,   
					  :ls_numajus,   
					  '4',   
					  'E',   
					  :is_codemple,   
					  sysdate,   
					  :str_appgeninfo.empresa,   
					  'Para justificar ajuste de ingreso por preventa '||:ls_numero,   
					  null,   
					  null,   
					  'S' )  ;
				  	if sqlca.sqlcode < 0 then
						messageBox('Error Interno','No se puede generar el ajuste de egreso...<comunique a sistemas> ' + sqlca.sqlerrtext)
						rollback;
						return
					end if

		
			declare ajus_preventa cursor for
			SELECT "IN_AJUSTE"."IT_CODIGO",
					"IN_AJUSTE"."DA_CANTIDAD",
					"IN_AJUSTE"."DA_SECUEN"			
			 FROM "IN_AJUSTE"
			WHERE (( "IN_AJUSTE"."AJ_NUMERO" = :ls_numero ) AND    
					( "IN_AJUSTE"."TM_CODIGO" = '3' ) AND 
					( "IN_AJUSTE"."TM_IOE" = 'I' ) AND
					( "IN_AJUSTE"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
					( "IN_AJUSTE"."EM_CODIGO" = :str_appgeninfo.empresa) AND			
					( "IN_AJUSTE"."BO_CODIGO" = :str_appgeninfo.seccion ));
			open ajus_preventa;
			do
			fetch ajus_preventa into :ls_itcodigo,:lc_cantid,:ls_secuen;	
			if sqlca.sqlcode <> 0 then exit
			
			select it_kit,it_valstk,it_codant,it_costo
			into :lch_kit,:lch_valstk,:is_codant,:lc_costo
			from in_item
			where em_codigo = :str_appgeninfo.empresa
			and it_codigo = :ls_itcodigo;
			
			if lch_valstk = 'S' then
				  If f_dame_stock_sucursal_new(ls_itcodigo,lc_cantid,lc_stock,lch_kit) = false then
						messagebox("Error","El stock en sucursal del producto ["+is_codant+"] = "+string(lc_stock)+"~r~n"+&
									"es menor a la cantidad que se quiere egresar...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>",stopsign!)
						lb_graba = false
						exit							
				  end if
				
				  If f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_itcodigo,lch_kit,lc_cantid) = false then
						messagebox("Error","El stock en bodega del producto ["+is_codant+"] = "+string(lc_cantid)+"~r~n"+&
										"es menor a la cantidad que se quiere egresar...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>",stopsign!)
						lb_graba = false								
						exit
				  End if
			End if
		
			update in_ajuste
			set da_estado = 'S'
			where aj_numero = :ls_numero
			and em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and bo_codigo = :str_appgeninfo.seccion
			and tm_codigo = 3
			and tm_ioe = 'I'
			and it_codigo = :ls_itcodigo
			and da_estado = 'N';
		
			If lch_kit = 'S' Then
				SELECT "IN_ITEM"."IT_COSTO", "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
				INTO :lc_costo_atomo,:ls_atomo, :lc_cantatomo
				FROM "IN_ITEM"  , "IN_RELITEM"
				WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
				("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
				("IN_RELITEM"."TR_CODIGO" = '1' ) and
				( "IN_RELITEM"."IT_CODIGO1" = :ls_itcodigo ) and
				( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
			End if
			
			if f_descarga_stock_rt_sucursal(ls_itcodigo,lc_cantid,lch_kit,ls_atomo,lc_cantatomo) = False Then
				rollback;
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+is_codant)
				lb_graba = false
				exit
			end if
			if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_itcodigo,lc_cantid,lch_kit,ls_atomo,lc_cantatomo) = false Then
				rollback;
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+is_codant)
				lb_graba = false
				exit
			End if	
			ld_fecha = f_hoy()
			if wf_mov_inventario(ls_numajus,ls_nombodega,ls_itcodigo,lc_cantid,ld_fecha,+&
										lch_kit,ls_atomo,lc_cantatomo,lc_costo_atomo,lc_costo) = false then
				rollback;								
				Messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario()")
				dw_movim.reset()
				lb_graba = false
				exit
			end if	
			  INSERT INTO "IN_AJUSTE"  
						( "AJ_NUMERO",   
						  "TM_CODIGO",   
						  "TM_IOE",   
						  "IT_CODIGO",   
						  "DA_CANTIDAD",   
						  "DA_SECUEN",   
						  "SU_CODIGO",   
						  "EM_CODIGO",   
						  "BO_CODIGO",   
						  "ESTADO" )  
			  VALUES ( :ls_numajus,   
						  '4',   
						  'E',   
						  :ls_itcodigo,   
						  :lc_cantid,   
						  :ls_secuen,   
						  :str_appgeninfo.sucursal,   
						  :str_appgeninfo.empresa,   
						  :str_appgeninfo.seccion,   
						  null )  ;
					  	if sqlca.sqlcode < 0 then
							messageBox('Error Interno','No se puede generar el ajuste de egreso  ' + sqlca.sqlerrtext)
							rollback;
							return
						end if
	
			loop while true
			close ajus_preventa;
			
			if	lb_graba = false then
				rollback;
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar el ajuste de egreso por preventa" +sqlca.sqlerrtext)
				return
			else
				UPDATE "IN_CABAJUS"
				SET "IN_CABAJUS"."AJ_ESTADO" = 'S'
				WHERE (( "IN_CABAJUS"."AJ_NUMERO" = :ls_numero ) AND    
				( "IN_CABAJUS"."TM_CODIGO" = '3' ) AND 
				( "IN_CABAJUS"."TM_IOE" = 'I' ) AND
				( "IN_CABAJUS"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
				( "IN_CABAJUS"."EM_CODIGO" = :str_appgeninfo.empresa) AND			
				( "IN_CABAJUS"."BO_CODIGO" = :str_appgeninfo.seccion ));
				
				li_rc =  dw_movim.update(true,false)
				if li_rc = 1 then		
					dw_movim.resetupdate()			
				end if
				commit;
			end if
			dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,+&
								ld_fecini,ld_fecfin)
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El numero de ajuste de egreso por preventa es "+ls_numajus)			
			setpointer(arrow!)
			w_marco.setmicrohelp("Listo")
								
		end if								

end if
end event

event dw_datos::clicked;if dwo.name = "aj_estado" then
	if getitemstring(row,"aj_estado") = 'N' then
		setitem(row,"aj_estado",'S')
	else
		setitem(row,"aj_estado",'N')
	end if
end if
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_ajustes_x_preventa
integer x = 2318
integer y = 12
integer width = 274
integer height = 144
integer taborder = 0
end type

type dw_movim from datawindow within w_ajustes_x_preventa
boolean visible = false
integer x = 2633
integer y = 40
integer width = 165
integer height = 96
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_1 from editmask within w_ajustes_x_preventa
integer x = 265
integer y = 40
integer width = 343
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_ajustes_x_preventa
integer x = 859
integer y = 40
integer width = 343
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_ajustes_x_preventa
integer x = 82
integer y = 56
integer width = 165
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
boolean focusrectangle = false
end type

type st_2 from statictext within w_ajustes_x_preventa
integer x = 677
integer y = 56
integer width = 165
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
boolean focusrectangle = false
end type


HA$PBExportHeader$w_enviar_transferencia.srw
$PBExportComments$Pendiente.Si.Enviar transferencias a otras bodegas
forward
global type w_enviar_transferencia from w_sheet_master_detail
end type
type dw_ubica from datawindow within w_enviar_transferencia
end type
type cb_1 from commandbutton within w_enviar_transferencia
end type
type dw_1 from datawindow within w_enviar_transferencia
end type
type dw_movim from datawindow within w_enviar_transferencia
end type
type st_1 from statictext within w_enviar_transferencia
end type
type st_time from statictext within w_enviar_transferencia
end type
type st_3 from statictext within w_enviar_transferencia
end type
type st_leyenda1 from statictext within w_enviar_transferencia
end type
type st_leyenda2 from statictext within w_enviar_transferencia
end type
type st_leyenda3 from statictext within w_enviar_transferencia
end type
type st_2 from statictext within w_enviar_transferencia
end type
type st_4 from statictext within w_enviar_transferencia
end type
type st_5 from statictext within w_enviar_transferencia
end type
type sle_1 from singlelineedit within w_enviar_transferencia
end type
type st_6 from statictext within w_enviar_transferencia
end type
type cb_2 from commandbutton within w_enviar_transferencia
end type
type cb_3 from commandbutton within w_enviar_transferencia
end type
type em_1 from editmask within w_enviar_transferencia
end type
type dw_3 from uo_dw_basic within w_enviar_transferencia
end type
type st_7 from statictext within w_enviar_transferencia
end type
type dw_2 from datawindow within w_enviar_transferencia
end type
type st_8 from statictext within w_enviar_transferencia
end type
type st_9 from statictext within w_enviar_transferencia
end type
type gb_1 from groupbox within w_enviar_transferencia
end type
end forward

global type w_enviar_transferencia from w_sheet_master_detail
integer width = 4151
integer height = 2092
string title = "Envio de Transferencia"
long backcolor = 81324524
event ue_transferir pbm_custom15
event ue_consultar pbm_custom16
event ue_saveas pbm_custom01
dw_ubica dw_ubica
cb_1 cb_1
dw_1 dw_1
dw_movim dw_movim
st_1 st_1
st_time st_time
st_3 st_3
st_leyenda1 st_leyenda1
st_leyenda2 st_leyenda2
st_leyenda3 st_leyenda3
st_2 st_2
st_4 st_4
st_5 st_5
sle_1 sle_1
st_6 st_6
cb_2 cb_2
cb_3 cb_3
em_1 em_1
dw_3 dw_3
st_7 st_7
dw_2 dw_2
st_8 st_8
st_9 st_9
gb_1 gb_1
end type
global w_enviar_transferencia w_enviar_transferencia

type variables
string is_codant1,is_empleado,is_mensaje
boolean ib_mismas_bodegas = FALSE,ib_descargo = FALSE

end variables

forward prototypes
public function integer wf_preprint ()
public function boolean wf_mov_inventario_ingreso (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_numero, string as_sucursal_destino, string as_bodega_destino, string as_nombodega)
public function integer wf_controla_stock_bodega (integer num_filas)
public function boolean wf_carga_stock (string as_item, decimal ad_cantidad, string as_sucursal, string as_bodega)
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_numero, string as_sucursal_destino, string as_bodega_destino, string as_nombodega, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, string as_codant, decimal ac_costo)
public subroutine wf_dame_bodega_stock_disponible (string as_bodega, string as_item, character ach_kit, ref decimal ad_cantidad)
end prototypes

event ue_transferir;//string  ls_filename_c,ls_filename_d,ls_sucursal_origen,ls_bodega_origen
//string  ls_bodega_destino,ls_ticket,ls_sucursal_destino, ls_numero
//integer li_res
//datetime    ld_fecha
//long    ll_filact
//
//ll_filact = dw_master.GetRow()
//ls_sucursal_origen = dw_master.GetItemString(ll_filact,"su_codenv")
//ls_bodega_origen = dw_master.GetItemString(ll_filact,"bo_codenv")
//ls_sucursal_destino = dw_master.GetItemString(ll_filact,"su_codigo")
//ls_bodega_destino = dw_master.GetItemString(ll_filact,"bo_codigo")
//ls_ticket = dw_master.GetItemString(ll_filact,"tf_ticket")
//ls_numero = dw_master.GetItemString(ll_filact,"tf_numero")
//ld_fecha = dw_master.GetItemDateTime(ll_filact,"tf_fecha")
//
//select pr_descri
//into :ls_filename_c
//from pr_param
//where em_codigo = :str_appgeninfo.empresa
//and pr_nombre = 'TRANSFER';
//
//if sqlca.sqlcode <> 0 then
//	MessageBox("ERROR DE TRANSFERENCIA","No puedo tomar la direcci$$HEX1$$f300$$ENDHEX$$n del archivo destino "+sqlca.sqlerrtext)
//end if
//ls_filename_c = ls_filename_c + 'CT' + ls_sucursal_origen + ls_bodega_origen  + ls_numero + '.txt'
//select pr_descri
//into :ls_filename_d
//from pr_param
//where em_codigo = :str_appgeninfo.empresa
//and pr_nombre = 'DETTRANS';
//
//if sqlca.sqlcode <> 0 then
//	MessageBox("ERROR DE TRANSFERENCIA","No puedo tomar el nombre del archivo destino "+sqlca.sqlerrtext)
//end if
//ls_filename_d = ls_filename_d + 'DT' + ls_sucursal_origen + ls_bodega_origen  + ls_numero + '.txt'
//
//li_res = MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","El archivo cabecera se generar$$HEX2$$e1002000$$ENDHEX$$en: "+&
//                    ls_filename_c +"~n" + " El archivo detalle se generar$$HEX2$$e1002000$$ENDHEX$$en: "+&
//						  ls_filename_d,Exclamation!,OKCancel!)
//
//if li_res = 1 then
//	dw_plano_cab.SetTransObject(sqlca)
//	dw_plano_det.SetTransObject(sqlca)
//  	dw_plano_cab.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,&
//                         ls_sucursal_destino,ls_bodega_destino,ls_ticket)
//  	dw_plano_det.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,&
//                         ls_sucursal_destino,ls_bodega_destino,ls_ticket)
//  	dw_plano_cab.saveas(ls_filename_c,Text!,FALSE)
//   dw_plano_det.saveas(ls_filename_d,Text!,FALSE)
//end if
end event

event ue_consultar;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
//dw_master.postevent(DoubleClicked!)
end event

event ue_saveas;int li_res
if dw_detail.rowcount() <=0 then return
li_res = dw_detail.saveas()
this.setRedraw(True)
end event

public function integer wf_preprint ();dataWindowChild ldwc_aux
long   ll_filActMaestro
string ls_em_codigo,ls_su_codenv,ls_bo_codenv,ls_su_codigo,ls_bo_codigo,ls_ticket,ls_flag

ll_filActMaestro = dw_master.getRow()

ls_em_codigo = dw_master.getItemString(ll_filActMaestro, "em_codigo")
ls_su_codenv = dw_master.getItemString(ll_filActMaestro, "su_codenv")
ls_bo_codenv = dw_master.getItemString(ll_filActMaestro, "bo_codenv")
ls_su_codigo = dw_master.getItemString(ll_filActMaestro, "su_codigo")
ls_bo_codigo = dw_master.getItemstring(ll_filActMaestro, "bo_codigo")
ls_ticket    = dw_master.getItemString(ll_filActMaestro, "tf_ticket")
ls_flag      = dw_master.getItemString(ll_filActMaestro, "tf_aceptada")


if ls_flag = 'E' then
dw_report.DataObject = 'd_rep_cab_pedido'
else
dw_report.DataObject = 'd_rep_cab_transferencia'
end if
dw_report.setTransObject(sqlca)
dw_report.retrieve(ls_em_codigo,ls_su_codenv,ls_bo_codenv,ls_su_codigo,ls_bo_codigo,ls_ticket)

dw_report.visible = true

 
return 1
end function

public function boolean wf_mov_inventario_ingreso (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_numero, string as_sucursal_destino, string as_bodega_destino, string as_nombodega);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
// sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=2, tm_ioe='E' es egreso por ventas
long    ll_num_movim,ll_contador = 0,ll_max,li_i
decimal ld_costo,ld_cantidad,ld_costo_kit
string  ls_num_movim, ls_factura,ls_es_kit,ls_componente,ls_observa,ls_codant
boolean lb_exito = TRUE
s_kit   lstr_kit[]

ls_observa = "Transferencia desde "+as_nombodega+" No. "+as_numero

// busca los componentes de un kit
declare kit_cursor cursor for
   select it_codigo,ri_cantid
	  from in_relitem
	 where em_codigo = :str_appgeninfo.empresa
	   and it_codigo1 = :as_item
		and tr_codigo = '1';   

// inserto el movimiento del item
ll_num_movim = f_dame_sig_numero('NUM_MINV')
ls_num_movim = string(ll_num_movim) 

 SELECT "IN_ITEM"."IT_COSTO"  
   INTO :ld_costo
   FROM "IN_ITEM"  
  WHERE ( "IN_ITEM"."EM_CODIGO" = :str_appgeninfo.empresa ) and  
        ( "IN_ITEM"."IT_CODIGO" = :as_item );

insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                     mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
	     				   mv_observ,mv_usado,ve_numero,es_codigo)
values ('8','I',:as_item,:as_sucursal_destino,:as_bodega_destino,
        :ls_num_movim,:ad_cantidad,:ld_costo,:ad_fecha,:str_appgeninfo.empresa,
	     :ls_observa,'N',:as_numero,null);
if sqlca.sqlcode <> 0 and sqlca.sqldbcode = 1 then
	do
		ll_num_movim = f_dame_sig_numero('NUM_MINV')
		ls_num_movim = string(ll_num_movim) 
		insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                     		mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
	     				   		mv_observ,mv_usado,ve_numero,es_codigo)
		values ('8','I',:as_item,:as_sucursal_destino,:as_bodega_destino,
        	  	  :ls_num_movim,:ad_cantidad,:ld_costo,:ad_fecha,:str_appgeninfo.empresa,
	     	  	  :ls_observa,'N',:as_numero,null);
	loop while sqlca.sqlcode <> 0 and sqlca.sqldbcode = 1
end if
if sqlca.sqlcode <> 0 and sqlca.sqldbcode <> 1 then
	lb_exito = FALSE
	rollback;
End if

if lb_exito then
// busca si el item es kit o no 
select it_kit,it_codant
  into :ls_es_kit,:ls_codant
  from in_item
 where em_codigo = :str_appgeninfo.empresa
   and it_codigo = :as_item;
if ls_es_kit = 'S' then	// es un kit
 	select count(*)
	  into :ll_max
	  from in_relitem
	 where em_codigo = :str_appgeninfo.empresa
	   and it_codigo1 = :as_item
		and tr_codigo = '1';
	open kit_cursor;
	li_i = 1
	do
		// se inserta los componentes del item tipo kit
		fetch kit_cursor into :lstr_kit[li_i].codigo,:lstr_kit[li_i].cantidad;
		if sqlca.sqlcode <> 0 then exit;
		li_i ++
	loop while TRUE;
	close kit_cursor;		
	for li_i = 1 to ll_max
		ll_num_movim = f_dame_sig_numero('NUM_MINV')
		ls_num_movim = string(ll_num_movim)
		 SELECT "IN_ITEM"."IT_COSTO"  
         INTO :ld_costo_kit
         FROM "IN_ITEM"  
        WHERE ( "IN_ITEM"."EM_CODIGO" = :str_appgeninfo.empresa ) and  
              ( "IN_ITEM"."IT_CODIGO" = :lstr_kit[li_i].codigo);

		insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                       		mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
		  					  		mv_observ,mv_usado,ve_numero,es_codigo)
  		values ('8','I',:lstr_kit[li_i].codigo,:as_sucursal_destino,:as_bodega_destino,
          	  :ls_num_movim,:ad_cantidad*:lstr_kit[li_i].cantidad,:ld_costo_kit,:ad_fecha,:str_appgeninfo.empresa,
		    	  'Transferencia del Kit '||:ls_codant||' desde '||:as_nombodega||' No. '||:as_numero,'N',:as_numero,null);
		if sqlca.sqlcode <> 0 and sqlca.sqldbcode = 1 then
			do
				ll_num_movim = f_dame_sig_numero('NUM_MINV')
				ls_num_movim = string(ll_num_movim)
				insert into in_movim(tm_codigo,tm_ioe,it_codigo,su_codigo,bo_codigo,
                       				mv_numero,mv_cantid,mv_costo,mv_fecha,em_codigo,
		  					  				mv_observ,mv_usado,ve_numero,es_codigo)
  				values ('8','I',:lstr_kit[li_i].codigo,:as_sucursal_destino,:as_bodega_destino,
          	  	  	  :ls_num_movim,:ad_cantidad*:lstr_kit[li_i].cantidad,:ld_costo_kit,:ad_fecha,:str_appgeninfo.empresa,
		    	  		  'Transferencia del Kit '||:ls_codant||' desde '||:as_nombodega||' No. '||:as_numero,'N',:as_numero,null);
			loop while sqlca.sqlcode <> 0 and sqlca.sqldbcode = 1
		end if
		if sqlca.sqlcode <> 0 then 
			lb_exito = FALSE
			rollback;
		End if
	next
end if // de si es kit
end if // de si lb_exito
if lb_exito then
//	commit;
	return (TRUE)
else
	return(FALSE)
end if
end function

public function integer wf_controla_stock_bodega (integer num_filas);//Descripcion: Funcion que controla el stock maximo de un producto para que sea facturado
//fecha de creaci$$HEX1$$f300$$ENDHEX$$n : 10/05/2001
//Ultima revision:27/09/2001

integer i,j
string ls_item,ls,ls_codant,ls_kit,ls_valstk,ls_codigo_atomo
decimal lc_stock,lc_candes,lc_candes_aux,lc_cantidad
dec{2} lc_stock_disponible

for i =1 to num_filas
ls_item = dw_detail.getitemstring(i,"it_codigo")
lc_cantidad = dw_detail.getitemdecimal(i,"df_cantid")	
lc_candes = 0
 If not isnull(ls_item) or ls_item <> '' then 
		select it_codant,it_kit,it_valstk
		into: ls_codant,:ls_kit,:ls_valstk
		from in_item
		 where em_codigo = :str_appgeninfo.empresa
		and it_codigo = :ls_item;
			if sqlca.sqlcode = 100 then
			MessageBox("Error","No se pudo obtener el codant del item ",StopSign!)
			return -1
		end if
   If ls_valstk = 'S' Then
			If ls_kit = 'S' then
				SELECT "IN_RELITEM"."IT_CODIGO","IN_RELITEM"."RI_CANTID"  
				INTO:ls_codigo_atomo,:lc_stock_disponible
				FROM "IN_RELITEM"  
				 WHERE ( "IN_RELITEM"."TR_CODIGO" = '1' ) AND  
						( "IN_RELITEM"."IT_CODIGO1" = :ls_item ) AND  
						( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa )   ;
			
				SELECT FLOOR("IN_ITEBOD"."IB_STOCK"  / :lc_stock_disponible)
				INTO:lc_stock
				 FROM "IN_ITEBOD"  
				WHERE ( "IN_ITEBOD"."IT_CODIGO" = :ls_codigo_atomo ) AND  
						( "IN_ITEBOD"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
						( "IN_ITEBOD"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND   
						( "IN_ITEBOD"."BO_CODIGO" = :str_appgeninfo.seccion )   						
				FOR UPDATE OF "IN_ITEBOD"."IB_STOCK";	//Es kit
				   
			else // no es kit
				select ib_stock
				into: lc_stock
				from in_itebod
				 where em_codigo = :str_appgeninfo.empresa
				and su_codigo = :str_appgeninfo.sucursal
				and bo_codigo = :str_appgeninfo.seccion
				and it_codigo = :ls_item
				for update of ib_stock;
			End If

			if sqlca.sqlcode <> 0 then
				MessageBox("Error","No se pudo obtener el stock del item ",StopSign!)
				return -1
			end if	
			If lc_stock < lc_cantidad then
				is_codant1 = ls_codant
				return -1
			End if
			//Para encontrar y sumar el stock de los items que se repiten en la factura		
			for j = i to num_filas
				ls = dw_detail.getitemstring(j,"it_codigo")
				lc_candes_aux = dw_detail.getitemdecimal(j,"df_cantid")
				If lc_stock >= lc_candes_aux and ls = ls_item then
						lc_candes = lc_candes + lc_candes_aux
						If lc_stock >= lc_candes then 
							continue
						Else
							is_codant1 = ls_codant							
							return -1
						End if
				  End if
			  next
		End if
    End if
next
return 1 
end function

public function boolean wf_carga_stock (string as_item, decimal ad_cantidad, string as_sucursal, string as_bodega);string  ls_componente,ls_es_kit
decimal ld_cantidad

declare kit_cursor cursor for
   select it_codigo,ri_cantid
	  from in_relitem
	 where em_codigo = :str_appgeninfo.empresa
	   and it_codigo1 = :as_item
		and tr_codigo = '1';   // TR_CODIGO = '1' --> ES KIT

select it_kit
  into :ls_es_kit
  from in_item
 where em_codigo = :str_appgeninfo.empresa
   and it_codigo = :as_item;
	
if ls_es_kit = 'S' then
	open kit_cursor;
	do
		fetch kit_cursor into :ls_componente,:ld_cantidad;
		if sqlca.sqlcode <> 0 then
			exit;
		end if
		update in_itesucur
		   set it_stock = it_stock + (:ld_cantidad * :ad_cantidad),
	    		 it_stkdis = it_stkdis + (:ld_cantidad * :ad_cantidad),
		 		 it_stkreal = it_stkreal + (:ld_cantidad * :ad_cantidad)
		 where em_codigo = :str_appgeninfo.empresa
		   and su_codigo = :as_sucursal
			and it_codigo = :ls_componente;
		if sqlca.sqlcode <> 0 then
			messageBox("ERROR","No se pudo descargar el stock de sucursal");
			close kit_cursor;
			return(FALSE)
		end if
		update in_itebod
		   set ib_stock = ib_stock + (:ld_cantidad * :ad_cantidad)
		 where em_codigo = :str_appgeninfo.empresa
		   and su_codigo = :as_sucursal
			and bo_codigo = :as_bodega
			and it_codigo = :ls_componente;
		if sqlca.sqlcode <> 0 then
			messageBox("ERROR","No se pudo descargar el stock de bodega");
			close kit_cursor;
			return(FALSE)
		end if
	loop while TRUE;
end if;

update in_itesucur
   set it_stock = it_stock + :ad_cantidad,
	    it_stkdis = it_stkdis + :ad_cantidad,
		 it_stkreal = it_stkreal + :ad_cantidad
 where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :as_sucursal
	and it_codigo = :as_item;
	
	if sqlca.sqlcode <> 0 then
		messageBox("ERROR","No se pudo descargar el stock ");
		return(FALSE)
	else
		return(TRUE)
	end if
	
update in_itebod
   set ib_stock = ib_stock + :ad_cantidad
 where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :as_sucursal
	and bo_codigo = :as_bodega
	and it_codigo = :as_item;	
	
if sqlca.sqlcode <> 0 then
	messageBox("ERROR","No se pudo descargar el stock ");
	return(FALSE)
else
	return(TRUE)
end if
end function

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, long al_numero, string as_sucursal_destino, string as_bodega_destino, string as_nombodega, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, string as_codant, decimal ac_costo);//Funcion	inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de sus componentes 
//Modifica	28/09/2004    por:Edivas
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=7, tm_ioe='E' es egreso por envio de transferencia

long ll_num_movim,ll_fila
string ls_num_movim,ls_nulo,ls_observa,ls_obs_kit
boolean lb_exito = TRUE


setnull(ls_nulo)

/*Para insertar el ultimo costo que tiene el item*/
//SELECT it_costo
//INTO :lc_costo
//FROM in_item  
//WHERE em_codigo = :str_appgeninfo.empresa 
//and  it_codigo = :as_item;


ls_observa = "Transf. a "+as_nombodega+" No. "+string(al_numero)
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Transf. kit "+as_codant+" a "+as_nombodega+" No. "+string(al_numero)
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",'7')
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
	dw_movim.setitem(ll_fila,"ve_numero",al_numero)
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
	dw_movim.setitem(ll_fila,"tm_codigo",'7')
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
	dw_movim.setitem(ll_fila,"ve_numero",al_numero)
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
	dw_movim.setitem(ll_fila,"tm_codigo",'7')
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
	dw_movim.setitem(ll_fila,"ve_numero",al_numero)
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return(TRUE)


end function

public subroutine wf_dame_bodega_stock_disponible (string as_bodega, string as_item, character ach_kit, ref decimal ad_cantidad);///////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Funci$$HEX1$$f300$$ENDHEX$$n booleana para saber si hay o no stock en bodega
//               adem$$HEX1$$e100$$ENDHEX$$s devuelve en al_cantidad lo que existe .
// Encuentra ib_stock de la tabla in_itebod
// Retorna Falso si la cantidad ingresada es mayor al stock.
// Fecha de Ultima Revisi$$HEX1$$f300$$ENDHEX$$n : 28-09-2004   11:22 Por: Edivas
///////////////////////////////////////////////////////////////////////

dec{2} ld_stock_disponible 
// si es un kit encuentra el stock del kit,de acuerdo al stock de cada 
// componete y del factor que interviene en el componente.

if ach_kit = 'S' then
	select TRUNC(min(ib_stock / ri_cantid))
	into :ld_stock_disponible
	from in_itebod x, in_relitem y
	where x.em_codigo = y.em_codigo
	and x.it_codigo = y.it_codigo
	and x.em_codigo = :str_appgeninfo.empresa
	and x.su_codigo = :str_appgeninfo.sucursal
	and x.bo_codigo = :as_bodega
	and y.it_codigo1 = :as_item
	and y.tr_codigo = '1'; //Es kit
else // no es kit
	select ib_stock
	into :ld_stock_disponible
	from in_itebod
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :as_bodega
	and it_codigo = :as_item;
end if

if ld_stock_disponible > 0 Then
	if ad_cantidad > ld_stock_disponible  then
		ad_cantidad = ld_stock_disponible
	end if
else
		ad_cantidad = 0
end if
end subroutine

on w_enviar_transferencia.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_movim=create dw_movim
this.st_1=create st_1
this.st_time=create st_time
this.st_3=create st_3
this.st_leyenda1=create st_leyenda1
this.st_leyenda2=create st_leyenda2
this.st_leyenda3=create st_leyenda3
this.st_2=create st_2
this.st_4=create st_4
this.st_5=create st_5
this.sle_1=create sle_1
this.st_6=create st_6
this.cb_2=create cb_2
this.cb_3=create cb_3
this.em_1=create em_1
this.dw_3=create dw_3
this.st_7=create st_7
this.dw_2=create dw_2
this.st_8=create st_8
this.st_9=create st_9
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_movim
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_time
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_leyenda1
this.Control[iCurrent+9]=this.st_leyenda2
this.Control[iCurrent+10]=this.st_leyenda3
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.sle_1
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.cb_2
this.Control[iCurrent+17]=this.cb_3
this.Control[iCurrent+18]=this.em_1
this.Control[iCurrent+19]=this.dw_3
this.Control[iCurrent+20]=this.st_7
this.Control[iCurrent+21]=this.dw_2
this.Control[iCurrent+22]=this.st_8
this.Control[iCurrent+23]=this.st_9
this.Control[iCurrent+24]=this.gb_1
end on

on w_enviar_transferencia.destroy
call super::destroy
destroy(this.dw_ubica)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_movim)
destroy(this.st_1)
destroy(this.st_time)
destroy(this.st_3)
destroy(this.st_leyenda1)
destroy(this.st_leyenda2)
destroy(this.st_leyenda3)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_1)
destroy(this.st_6)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.em_1)
destroy(this.dw_3)
destroy(this.st_7)
destroy(this.dw_2)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.gb_1)
end on

event open;Date ld_fecha
Long ll_reg, ll_row,ll_count
String ls_sucdestino,ls_secdestino,ls_ticket

gnv_help.of_register(This)
f_recupera_empresa(dw_master,"su_codigo")
f_recupera_empresa(dw_master,"bo_codigo")

f_recupera_empresa(dw_2,"su_codigo")
f_recupera_empresa(dw_2,"bo_codigo")

select ep_codigo
into :is_empleado
from no_emple
where em_codigo = :str_appgeninfo.empresa
and sa_login = :str_appgeninfo.username;

istr_argInformation.nrArgs = 3
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = str_appgeninfo.seccion

dw_master.SetTransObject(sqlca)
dw_movim.settransobject(sqlca)
dw_report.settransobject(sqlca)
//dw_master.is_SerialCodeColumn = "tf_ticket"
//dw_master.is_SerialCodeType = "NUM_TRNSF"
//dw_master.is_serialCodeCompany = str_appgeninfo.empresa

call super::open

dw_detail.is_SerialCodeDetail = "df_secuen"

dw_master.ii_nrCols = 6
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "su_codenv"
dw_master.is_connectionCols[3] = "bo_codenv"
dw_master.is_connectionCols[4] = "su_codigo"
dw_master.is_connectionCols[5] = "bo_codigo"
dw_master.is_connectionCols[6] = "tf_ticket"
dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "su_codenv"
dw_detail.is_connectionCols[3] = "bo_codenv"
dw_detail.is_connectionCols[4] = "su_codigo"
dw_detail.is_connectionCols[5] = "bo_codigo"
dw_detail.is_connectionCols[6] = "tf_ticket"
dw_detail.uf_setArgTypes()

//dw_master.uf_insertCurrentRow()
//dw_master.setFocus()
dw_master.uf_insertCurrentRow()
//dw_detail.SetRowFocusIndicator(Hand!)
dw_master.setFocus()

//dw_master.uf_retrieve()
st_leyenda1.backcolor =  rgb(255,128,64)
st_leyenda2.backcolor =  rgb(255,255,128)
st_leyenda3.backcolor =  rgb(232,233,234) 

dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)

//dw_master.sharedata(dw_2)
//ll_reg = dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
//if ll_reg = 0 then return
//ll_row = dw_master.Getrow()
//ls_sucdestino = dw_master.Object.su_codigo[ll_row]
//ls_secdestino = dw_master.Object.bo_codigo[ll_row]
//ls_ticket          = dw_master.Object.tf_ticket[ll_row]
//dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_sucdestino,ls_secdestino,ls_ticket)
//dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_sucdestino,ls_secdestino,ls_ticket)



SELECT count(*)
INTO :ll_count
FROM "IN_TRANSFER"  
WHERE ( "IN_TRANSFER"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
( "IN_TRANSFER"."SU_CODENV" = :str_appgeninfo.sucursal ) AND  
( "IN_TRANSFER"."BO_CODENV" = :str_appgeninfo.seccion ) AND
( "IN_TRANSFER"."TF_ACEPTADA" = 'E');

sle_1.text = string(ll_count)
/*Definimos el ciclo para que se ejecute el timer*/
Timer(10)
end event

event ue_insert;Long ll_row
string ls_estado // 'E' Pedido, 'X' = Por registrar movimientos,'N'= Por recibir, 'S' = Aceptada




dw_master.enabled = true
dw_detail.enabled = true

str_prodparam.fila = dw_detail.GetRow()
ll_row =  dw_master.getrow()
if ll_row = 0 then return
ls_estado = dw_master.Object.tf_aceptada[ll_row]

if ls_estado = 'E' or ls_estado = 'S ' or ls_estado  = 'X' then
return 1
else
	if (dw_detail.modifiedcount() > 0 or dw_detail.deletedcount() > 0) and (ls_estado = 'N') then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Ha realizado cambios en un documento ya grabado ...por favor cierre la ventana.")
	return
end if 	

call super::ue_insert
end if
end event

event ue_update;/* El envio de transferencia involucra 2 instancias

1.- Se envia lo registrado como pedido por las sucursales  , 
     los pedidos  se los identifica por que tienen en el campo tf_aceptada = 'E',
	Una vez enviada la transferencia el estado pasa a  tf_aceptada = 'N'  ,
     tf_aceptada = 'S'  quiere decir que la transferencia ha sido receptada
	en la sucursal destino
2.- Se utiliza para envio de productos sin orden de pedido	
*/
	
	
integer rc,li_i,i,li_pasa,li_filact,li_sihay,li_paso
long ll_fila,ll_cantidad,ll_filblanco,ll_numero,ll_ticket,ll_start,ll_used,ll_find,ll_existencia,ll_cantorig
dec{2} lc_cantidad,lc_stock
dec{4} ld_cantatomo,ld_costo_atomo,lc_costo
string ls_motor,ls_ticket,ls,ls_sucursal_destino,ls_bodega_destino,&
		ls_nombodega,ls_codigo,ls_codant,ls_atomo,l_status_transferencia,&
		ls_codaux //Para determinar la existencia del item
datetime ld_fecha		
character lch_kit
boolean lb_actualizar
dwitemstatus l_status 


Setpointer(Hourglass!)

w_marco.SetMicrohelp("Procesando transferencia....por favor espere...")
ll_start = Cpu()

dw_master.AcceptText()
dw_detail.AcceptText()

li_filact = dw_master.GetRow()
if li_filact = 0 then return
ll_fila = dw_detail.RowCount()

If ll_fila <= 0  Then
messagebox("Error","Debe ingresar el detalle para actualizar el envio de transferencia")
return
End if



/*No permitir grabar si la transferencia ya ha sido enviada*/
l_status_transferencia = dw_master.getitemstring(li_filact,"tf_aceptada")
l_status = dw_master.getitemstatus(li_filact,0,Primary!)
if (l_status = notmodified! or l_status = datamodified!) and l_status_transferencia = 'N'&
then
messagebox("Error","Esta transferencia ya ha sido enviada....por favor verifique..  !")
return
end if

ls_sucursal_destino = dw_master.GetItemString(li_filact,"su_codigo")
ls_bodega_destino = dw_master.GetItemString(li_filact,"bo_codigo")

if  (l_status = newmodified! or l_status = new!) then 
	//Determinar el secuencial solo si la transferencia es nueva, en caso contrario tomar el secuencial
	//del pedido
	
	Select nt_numero
	into :ll_ticket
	from pr_numtrans
	where em_codigo = :str_appgeninfo.empresa
	and su_codenv = :str_appgeninfo.sucursal
	and bo_codenv = :str_appgeninfo.seccion
	and su_codigo = :ls_sucursal_destino
	and bo_codigo = :ls_bodega_destino
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
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion
	for update of bo_transfer;
	if sqlca.sqlcode <> 0 then
	rollback;	
	messageBox('Error','No se encuentra el siguiente n$$HEX1$$fa00$$ENDHEX$$mero de la transferencia')
	return -1
	end if
    
	 /*Incrementan los secuenciales*/
	update in_bode
	set bo_transfer = bo_transfer + 1
	where em_codigo = :str_appgeninfo.empresa
	and su_codigo = :str_appgeninfo.sucursal
	and bo_codigo = :str_appgeninfo.seccion;
	if sqlca.sqlcode <> 0 then
	rollback;				
	messageBox('Error','Problemas al actualizar el secuencial de la Transferencia')
	return -1
	end if  
	
	update pr_numtrans
	set nt_numero = nt_numero + 1
	where em_codigo = :str_appgeninfo.empresa
	and su_codenv = :str_appgeninfo.sucursal
	and bo_codenv = :str_appgeninfo.seccion
	and su_codigo = :ls_sucursal_destino
	and bo_codigo = :ls_bodega_destino;	
	if sqlca.sqlcode <> 0 then
	rollback;				
	messageBox('Error','Problemas al actualizar el secuencial del ticket')
	return -1
	end if
	  

		
end if
		
/*Borrar filas en blanco*/
for li_i = 1 to ll_fila
  ls = dw_detail.GetItemString(li_i - i,'codant')
  if isnull(ls) or ls = '' then
	  dw_detail.DeleteRow(li_i - i )
	  i=i+1	  
  end if
next

ll_fila = dw_detail.RowCount()
If ll_fila <= 0  Then
	rollback;
	messagebox("Error","Debe ingresar el detalle para actualizar el envio de transferencia")
	return
End if


if  l_status = new! or l_status = newmodified! then
dw_master.SetItem(li_filact,"em_codigo",str_appgeninfo.empresa)
dw_master.SetItem(li_filact,"su_codenv",str_appgeninfo.sucursal)
dw_master.SetItem(li_filact,"bo_codenv",str_appgeninfo.seccion)
dw_master.SetItem(li_filact, 'tf_ticket', string(ll_ticket))
dw_master.SetItem(li_filact, 'tf_numero', string(ll_numero))

end if

dw_master.Setitem(li_filact,'ep_codigo',is_empleado)
ld_fecha = f_hoy()
dw_master.Setitem(li_filact,"tf_fecha",ld_fecha)
dw_master.Setitem(li_filact,"tf_hora",ld_fecha)

//datos de la cabecera
ls_ticket = dw_master.GetItemString(li_filact,"tf_ticket")
ld_fecha = dw_master.GetItemDatetime(li_filact,"tf_fecha")

select substr(bo_nombre,1,30)
into :ls_nombodega
from in_bode
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :ls_sucursal_destino
and bo_codigo = :ls_bodega_destino;

//Inicia proceso de transferencia
dw_movim.reset()
for i = 1 to ll_fila


	dw_detail.SetItem(i,"em_codigo",str_appgeninfo.empresa)
	dw_detail.SetItem(i,"su_codenv",str_appgeninfo.sucursal) 
	dw_detail.SetItem(i,"bo_codenv",str_appgeninfo.seccion) 	  
	dw_detail.SetItem(i,"su_codigo",ls_sucursal_destino) 	  
	dw_detail.SetItem(i,"bo_codigo",ls_bodega_destino) 
	dw_detail.SetItem(i,"tf_ticket",ls_ticket) 
	dw_detail.SetItem(i,"df_secuen",string(i))
	ll_cantidad =  dw_detail.getitemnumber(i,'df_cantid')	                         /*Cantidad despachada*/
	ll_cantorig  =  dw_detail.getitemnumber(i,'df_cantid',Primary!,True)	/*Cantidad despachada*/
	ls_codigo = dw_detail.getitemstring(i,'it_codigo')			
	ls_codant = dw_detail.getitemstring(i,'codant')	
	lc_stock = dec(ll_cantidad)	
	lch_kit = dw_detail.getitemstring(i,'it_kit')	
	lc_costo = dw_detail.getitemdecimal(i,'it_costo')	
	dw_detail.setitem(i,'df_costo',lc_costo)						

	/*Determinar existencias en la bodega origen para calcular demanda insatisfecha e insconsistencias*/
	ls_codaux = ls_codigo
	If lch_kit = 'S' Then
		SELECT nvl("IN_ITEM"."IT_COSTO",0), "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
		INTO :ld_costo_atomo,:ls_atomo, :ld_cantatomo
		FROM "IN_ITEM"  , "IN_RELITEM"
		WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
		("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
		("IN_RELITEM"."TR_CODIGO" = '1' ) and
		( "IN_RELITEM"."IT_CODIGO1" = :ls_codigo ) and
		( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
		ls_codaux = ls_atomo
	End if
	     
  	 /*Determinar la existencia del atomo y dividir por  la equivalencia en el caso de que sea KIT*/
      select nvl(it_costo,0),nvl(y.it_stock,0)
	   into   :lc_costo,:ll_existencia
		from  in_item x, in_itesucur y
		where x.it_codigo = y.it_codigo
		and x.em_codigo = y.em_codigo
		and y.em_codigo = :str_appgeninfo.empresa
		and y.su_codigo =:str_appgeninfo.sucursal
		and y.it_codigo = :ls_codaux;
	
		If lch_kit = 'S' then
		ll_existencia = ll_existencia/ld_cantatomo
		end if 
	    
	
	
	    /*Verificamos si existe el stock suficiente para transferir*/ 
	    /*Si hay disponible lo que se transfiere esto para transferencias manuales*/
		if isnull(l_status_transferencia) or l_status_transferencia = '' then
			if f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lch_kit,lc_stock) = false then
				rollback;
				messagebox("Error","El stock en bodega del producto ["+ls_codant+"] = "+string(lc_stock)+"~r~n"+&
					"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>",stopsign!)
				return
			end if
			If str_appgeninfo.sucursal = ls_sucursal_destino Then
					if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = false Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+ls_codant)
						return
					End if			
			Else
					if f_descarga_stock_rt_sucursal(ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = False Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+ls_codant)
						return
					end if
					if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = false Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+ls_codant)
						return
					End if
			End if				
			 dw_detail.setitem(i,"in_dettrans_df_stock",ll_existencia)
		end if
	 	
		If l_status_transferencia = 'E' then
			f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lch_kit,lc_stock)
			dw_detail.setitem(i,"df_cantid",lc_stock)				
			
			
			If str_appgeninfo.sucursal = ls_sucursal_destino Then
					if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = false Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+ls_codant)
						return
					End if			
			Else
					if f_descarga_stock_rt_sucursal(ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = False Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+ls_codant)
						return
					end if
					if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = false Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+ls_codant)
						return
					End if
			End if	
			/*Registrar stock en el momento de la reserva para pedidos o en el momento de la descarga para las transferencias normales*/	 
			 dw_detail.setitem(i,"in_dettrans_df_stock",ll_existencia)
  	    End if

          /*Descargar con las nuevas modificaciones si hubo alguna novedad*/
		If l_status_transferencia = 'X' then 
			lc_stock = ll_cantidad - ll_cantorig
			If str_appgeninfo.sucursal = ls_sucursal_destino Then
					if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = false Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+ls_codant)
						return
					End if			
			Else
					if f_descarga_stock_rt_sucursal(ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = False Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+ls_codant)
						return
					end if
					if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_stock,lch_kit,ls_atomo,ld_cantatomo) = false Then
						rollback;
						messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+ls_codant)
						return
					End if
			End if	
	   End if


		/*Insertar movimiento del Item en el Kardex*/
		lc_stock =  ll_cantidad
		if isnull(l_status_transferencia) or l_status_transferencia ='' or l_status_transferencia = 'X' then
			 if lch_kit = 'S' then
					if lc_stock > 0 and ld_cantatomo > 0 then
							if wf_mov_inventario(ls_codigo,lc_stock,f_hoy(),long(ls_ticket),ls_sucursal_destino,&
															ls_bodega_destino,ls_nombodega,lch_kit,ls_atomo,&
															ld_cantatomo,ld_costo_atomo,ls_codant,lc_costo) = false Then
									rollback;
									dw_movim.reset()
									Messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario")
									Return
									end if 
					end if
		     else
					if lc_stock > 0 then
							if wf_mov_inventario(ls_codigo,lc_stock,f_hoy(),long(ls_ticket),ls_sucursal_destino,&
															ls_bodega_destino,ls_nombodega,lch_kit,ls_atomo,&
															ld_cantatomo,ld_costo_atomo,ls_codant,lc_costo) = false Then
									rollback;
									dw_movim.reset()
									Messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario")
									Return
							end if		
					end if
			 end if
		end if 

	if lch_kit = 'V' then	
	  ls_motor = dw_detail.GetItemString(i,'df_motor')
	  if not isnull(ls_motor) or trim(ls_motor) <> '' then
			update in_itedet
			set tf_numero = :ll_numero,
				estado = 'T'
			where em_codigo = :str_appgeninfo.empresa
			and su_codigo = :str_appgeninfo.sucursal
			and di_ref1 = :ls_motor;
			if sqlca.sqlcode <> 0 then
				rollback;				
				messageBox('Error','Problemas al actualizar la transferencia del veh$$HEX1$$ed00$$ENDHEX$$culo')
				return -1
			end if
	  end if		  
	end if		
Next

/*Marcar como aceptada solo si la transferencia ha registrado los movimientos en el Kardex*/	 
If l_status_transferencia = 'E' then
dw_master.SetItem(li_filact, 'tf_aceptada','X')
else
dw_master.SetItem(li_filact, 'tf_aceptada','N')
end if	


//5.- Actualizo los datos de la factura
rc =  dw_master.update(true,false) 
if rc = 1 then
	 rc = dw_detail.update(true,false)
	 if rc = 1 then
	  rc =  dw_movim.update(true,false)
	     if rc = 1 then		
			dw_master.resetupdate()
			dw_detail.resetupdate()
			dw_movim.resetupdate()			
		      /*Todo est$$HEX2$$e1002000$$ENDHEX$$ok*/
			 commit;  
           else
		 rollback;
		 return
 	      end if				
    else
    rollback;
    return
    end if	
else
rollback;
return
end if

dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_sucursal_destino,ls_bodega_destino,ls_ticket)
dw_report.print()

ll_used = Cpu() - ll_start
st_time.text = String(ll_used/1000)
w_marco.SetMicrohelp("Transferencia Procesada....")
/*Refrescar con los nuevos datos*/
//cb_2.triggerevent(clicked!)
setpointer(arrow!)

end event

event closequery;//int li_res,li_i,i
//long ll_i, ll_maxrows,ll_filact,ll_fila
//string ls_item,ls_sucursal_envio,ls_sucursal_destino,ls_pepa,ls
//decimal ld_cantidad
//
//ll_filact = dw_master.GetRow()
//ll_fila = dw_detail.RowCount()
//for li_i = 1 to ll_fila
//    ls = dw_detail.GetItemString(li_i - i,'codant')
//	 if isnull(ls) or ls = '' then
//       dw_detail.DeleteRow(li_i - i )
//		 i=i+1	  
//	 end if
// next
//
//if dw_detail.acceptText() = -1 or dw_master.acceptText() = -1 then
//	message.returnValue = 1
//	return
//end if
//
//if dw_master.modifiedCount() > 0 or dw_master.deletedCount() > 0 or &
//	dw_detail.modifiedCount() > 0 or dw_detail.deletedCount() > 0 then
//	li_res = messageBox(this.title, &
//						"Hay cambios que no se han guardado~n" + &
//						"$$HEX1$$bf00$$ENDHEX$$Desea guardarlos?", Question!, YesNoCancel!)
//	choose case li_res
//		case 1
//			if dw_master.uf_updateCommit(dw_master.getRow(), False) = -1 then
//				message.returnValue = 1
//			end if
//			return
//		case 2
//			message.returnValue = 0
//			return
//		case 3
//			message.returnValue = 1
//			return
//	end choose
//end if
//

return 0
end event

event ue_retrieve;return 1

end event

event key;if keydown(keyescape!) Then
	dw_1.visible = false
End if

end event

event resize;//int li_width, li_height
//
//li_width = this.workSpaceWidth()
//li_height = this.workSpaceHeight()
//
//this.setRedraw(False)
//if this.ib_inReportMode then
//	dw_report.resize(li_width - dw_2.width, li_height - 50)
//else
//	dw_master.resize(li_width - dw_2.width, dw_master.height)
//	dw_detail.resize(li_width - (dw_2.width+20),li_height - (dw_master.height + 50) )
//	dw_2.resize(dw_2.width,li_height -  100)
//end if	
//this.setRedraw(True)
return 1
end event

event ue_delete;Long ll_row
string ls_estado // 'E' Pedido, 'X' = Por registrar movimientos,'N'= Por recibir, 'S' = Aceptada


ll_row =  dw_master.getrow()
if ll_row = 0 then return
ls_estado = dw_master.Object.tf_aceptada[ll_row]

if ls_estado = 'E' or ls_estado = 'N' or ls_estado = 'S ' or ls_estado  = 'X' then
return 1
else
call super::ue_delete
end if
	
end event

event timer;call super::timer;Long  ll_count

SELECT count(*)
INTO :ll_count
FROM "IN_TRANSFER"  
WHERE ( "IN_TRANSFER"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
( "IN_TRANSFER"."SU_CODENV" = :str_appgeninfo.sucursal ) AND  
( "IN_TRANSFER"."BO_CODENV" = :str_appgeninfo.seccion ) AND
( "IN_TRANSFER"."TF_ACEPTADA" = 'E');

sle_1.text = string(ll_count)

end event

event ue_printcancel;call super::ue_printcancel;	dw_master.enabled = false
	dw_detail.enabled = false

end event

event close;call super::close;gnv_help.of_unregister(This)
end event

event activate;call super::activate;m_marco.m_archivo.m_salvarcomo.visible = True
m_marco.m_archivo.m_salvarcomo.enabled = True

end event

type dw_master from w_sheet_master_detail`dw_master within w_enviar_transferencia
integer x = 27
integer y = 132
integer width = 2779
integer height = 496
integer taborder = 10
string dataobject = "d_cab_transferencia"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;call super::itemchanged;DataWindowChild  ldwc_aux
string   ls_su_codenv, ls_su_codigo, ls_bo_codenv, ls_bo_codigo, ls_columna, ls_null, ls
long     ll_filact

SetNull(ls_null)
ls = is_empleado
ll_filact = dw_master.getRow()
ls_columna = dw_master.GetColumnName()
if isnull(is_empleado) then
	messageBox('Error','Usted no tiene autorizaci$$HEX1$$f300$$ENDHEX$$n para hacer transferencias. Comuniquese con el departamento de Sistemas.')
	return
end if
//ls_sucodigo = dw_master.getitemstring(ll_filact,"su_codigo")
//ls_bocodigo = dw_master.getitemstring(ll_filact,"bo_codigo")
accepttext()
choose case ls_columna
	case "su_codigo"
		this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)
		this.SetItem(ll_filact,"su_codenv",str_appgeninfo.sucursal)
		this.SetItem(ll_filact,"bo_codenv",str_appgeninfo.seccion)
		this.SetItem(ll_filact,"ep_codigo",is_empleado)
   	     ls_su_codigo = this.Gettext()
		ls = "su_codigo = " + "'" + ls_su_codigo + "'" + ' and bo_codigo <> ' + "'" + str_appgeninfo.seccion + "'" 
		dw_master.getChild("bo_codigo", ldwc_aux)
		ldwc_aux.SetFilter(ls)
		ldwc_aux.Filter()		

	case "bo_codigo"
		SetColumn('tf_observa')	
	case "tf_observa"
		dw_detail.SetFocus()
		dw_detail.InsertRow(0)
		dw_detail.SetColumn('codant')
		dw_detail.PostEvent(Clicked!)
end choose
end event

event dw_master::itemerror;call super::itemerror;if ib_mismas_bodegas then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede hacer transferencia entre la misma bodega",StopSign!)
	ib_mismas_bodegas = FALSE
end if
return 1
end event

event dw_master::rowfocuschanged;call super::rowfocuschanged;string ls_su_codigo, ls
long ll
datawindowchild ldwc_aux

dw_master.enabled = TRUE
dw_detail.enabled = TRUE



ll = this.GetRow()
if ll>0 and not isnull(ll) then
   ls_su_codigo = this.GetItemString(ll,'su_codigo')
   if isnull(ls_su_codigo) or ls_su_codigo = '' then
	   ls = ''
   else
      ls = "su_codigo = " + "'" + ls_su_codigo + "'" + ' and bo_codigo <> ' + "'" + str_appgeninfo.seccion + "'" 
   end if
   dw_master.getChild("bo_codigo", ldwc_aux)
   ldwc_aux.SetFilter(ls)
   ldwc_aux.Filter()		


end if
end event

event dw_master::ue_preinsert;call super::ue_preinsert;datawindowchild ldwc_aux
dw_master.getChild("bo_codigo", ldwc_aux)
ldwc_aux.SetFilter('')
ldwc_aux.Filter()		
end event

event dw_master::ue_postinsert;call super::ue_postinsert;long ll_row

ll_row = this.getrow()
if ll_row = 0 then return
this.setitem(ll_row,"tf_fecha",f_hoy())
this.setitem(ll_row,"tf_hora",f_hoy())
end event

event dw_master::losefocus;call super::losefocus;
CHOOSE CASE this.getColumnName()
	CASE "tf_observa"
		dw_detail.SetFocus()
		dw_detail.PostEvent('clicked')
END CHOOSE
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_enviar_transferencia
event ue_nextfield pbm_dwnprocessenter
integer x = 27
integer y = 716
integer width = 4037
integer height = 1224
integer taborder = 50
string dataobject = "d_det_transferencia"
boolean hscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_detail::ue_nextfield;Send(Handle(this), 256, 9, 0)
return 1
end event

event dw_detail::itemchanged;string          ls_nombre, ls_sucursal_envio,ls_sucursal_destino,ls_null
long            ll_filact,ll_nreg,ll_find,ll_max,ll_find2
string          ls_pepa, ls_codant,ls_valstk,ls_sucursal, ls_bodega,ls_codaux
character       lch_kit,lch_status_transf
decimal{2}      lc_cantid,lc_costo,lc_precio, lc_valor, lc_stock, lc_pedido, lc_prefab, ld_old_cantid,ld_null,lc_pedido_dis,lc_recargo = 0
boolean         si_hay,si_hay1, bandera= FALSE 
s_stock_bodegas bodegas


ll_filact = dw_master.GetRow()
ls_sucursal = str_appgeninfo.sucursal 
ls_bodega = str_appgeninfo.seccion    
ls_sucursal_envio = dw_master.GetItemString(ll_filact,"su_codenv")
ls_sucursal_destino = dw_master.GetItemString(ll_filact,"su_codigo")
lch_status_transf = dw_master.getitemstring(ll_filact,"tf_aceptada")		
ll_max = this.RowCount()

if this.getrow() < 1 then return

CHOOSE CASE This.GetColumnName()
case 'codant' 
	ls_codaux = Message.stringParm	
	If not isnull(ls_codaux) and trim(ls_codaux) <> '' Then
		row = this.getrow()
		data = ls_codaux
		setnull(Message.stringParm)
	End if

	ll_nreg = dw_detail.rowcount()
	ll_find =  dw_detail.find("codant = '"+data+"'",1, ll_nreg - 1)
	if ll_find <> 0 and ll_nreg <> 1 then
//		deleterow(row)
		is_mensaje = "Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el codigo: "+data+" ...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(ll_find)
//		return 1
	end if
	
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo,it_codant,it_nombre,it_prefab,it_valstk,it_kit,nvl(it_costo,0)
	into :ls_pepa,:ls_codant,:ls_nombre,:lc_prefab,:ls_valstk,:lch_kit,:lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :data;
	if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
		select it_codigo,it_codant,it_nombre,it_prefab,it_valstk,it_kit,nvl(it_costo,0)
		into :ls_pepa,:ls_codant,:ls_nombre,:lc_prefab,:ls_valstk,:lch_kit,:lc_costo
		from in_item
		where em_codigo = :str_appgeninfo.empresa
		and it_codbar = :data;
		if sqlca.sqlcode <> 0 then
			setnull(ls_null)
			this.SetItem(row,"codant",ls_null)
			beep(1)
			is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
			return 1
			this.SetItem(row,"it_codigo",ls_null)
			this.SetItem(row,'it_nombre',ls_null)
			setnull (ld_null)
			this.SetItem(row,'df_cantid',ld_null)
			return(1)
		else
			this.SetItem(row,"it_codigo",ls_pepa)
			this.setitem(row,'it_nombre',ls_nombre)
			this.setitem(row,'it_kit',lch_kit)			
			this.setitem(row,'it_costo',lc_costo)
			this.setitem(row,'df_costo',lc_costo)					
			this.SetColumn("df_cantid")
		end if
	else
		if ls_valstk = 'S' then
			lc_pedido = 1.0
			If f_dame_stock_bodega_new(ls_bodega,ls_pepa,lch_kit,lc_pedido) = false then
				rollback;
				deleterow(row)
				is_mensaje = "No hay stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)
				return 1
			End if
			if ls_sucursal_envio <> ls_sucursal_destino then
				If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit ) = false then
					rollback;
					deleterow(row)
					is_mensaje = "No hay stock en sucursal del producto ["+ls_codant+"] = "+string(lc_stock)
					return 1						
				end if
			end if
		end if
		if lch_kit = 'V' then
			openwithparm(w_venta_vehiculo,ls_codant)
			if Message.StringParm = 'V' then
				setnull(Message.stringParm)
				ll_find2 =  dw_detail.find("df_motor = '"+str_prodparam.motor+"'",1, ll_nreg - 1)
				if ll_find2 <> 0 and ll_nreg <> 1 then
					deleterow(row)									
					is_mensaje = "Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el veh$$HEX1$$ed00$$ENDHEX$$culo con motor: "+str_prodparam.motor+" ...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(ll_find2)
					return 1
				end if
				this.setitem(row,'df_motor',str_prodparam.motor)	
			else
				setnull(Message.stringParm)				
				deleterow(row)
				return
			end if
		end if
		this.setitem(row, 'df_cantid', 1)
		this.setitem(row, 'it_nombre',ls_nombre)
		this.setitem(row, 'it_codigo',ls_pepa)
		this.setitem(row,'it_kit',lch_kit)
		this.setitem(row,'it_costo',lc_costo)		
		this.setitem(row,'df_costo',lc_costo)		
		
	end if 


case 'df_cantid' 
	lc_pedido = dec(this.gettext()) 
	lch_kit = getitemstring(row,"it_kit")

	if lc_pedido < 0 then
		this.SetItem(row,'df_cantid',this.GetItemNumber(row,'df_cantid'))
		is_mensaje = 'La cantidad debe ser mayor o igual a cero'
		return 1
	end if
	
	if lch_kit = 'V' and lc_pedido > 1 then
		this.SetItem(row,'df_cantid',this.GetItemNumber(row,'df_cantid'))
		is_mensaje = 'La cantidad debe ser igual a uno para este item'
		return 1
	end if

	if lch_status_transf = 'X' then  //Transferencia con stock reservado
		lc_cantid = this.getitemdecimal(row,'df_cantid',primary!,true)	
		if lc_pedido > lc_cantid then
			this.SetItem(row,'df_cantid',lc_cantid)
			is_mensaje = 'La cantidad debe ser igual o menor al pedido'
			return 1
		end if
	end if

	ls_codant = this.getitemstring(row,'codant')
	
	select it_codigo, it_nombre, it_prefab, it_valstk,it_kit,nvl(it_costo,0)
	into :ls_pepa, :ls_nombre, :lc_prefab, :ls_valstk,:lch_kit,:lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;	
	if ls_valstk = 'S' then
		if lch_status_transf <> 'X' or isnull(lch_status_transf) then  //Transferencia con stock reservado
			if ls_sucursal_envio <> ls_sucursal_destino then
				If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit) = false then
					rollback;
					is_mensaje = "El stock en sucursal del producto ["+ls_codant+"] = "+string(lc_stock)+"~r~n"+&
								"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>"
					SetItem(row,'df_cantid',lc_stock)
					return 1		
				end if
			end if
				
			If f_dame_stock_bodega_new(ls_bodega,ls_pepa,lch_kit,lc_pedido) = false then
				rollback;
				is_mensaje = "El stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)+"~r~n"+&
								"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>"
				SetItem(row,'df_cantid',lc_pedido)							
				return 1
			end if
		end if
	End if
end choose
end event

event dw_detail::itemerror;messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n",is_mensaje,stopsign!)
return 1
end event

event dw_detail::clicked;call super::clicked;str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 
str_prodparam.campo = "df_cantid"
cantidad_producto_ubica = TRUE
end event

event dw_detail::losefocus;call super::losefocus;long     ll_new,ll_row
decimal  lc_cantidad
string ls_estado
window   lw_aux

this.AcceptText()
ll_row = dw_master.getrow()
If ll_row  = 0 then return
ls_estado = dw_master.Object.tf_aceptada[ll_row]
if ls_estado = 'E' or ls_estado = 'N' or ls_estado = 'S ' or ls_estado  = 'X' then
	return 1
end if
CHOOSE CASE this.getcolumnName()
	CASE "df_cantid"
		lc_cantidad = this.GetItemNumber(this.GetRow(),"df_cantid")
		if lc_cantidad = 0 or isnull(lc_cantidad) then
			dw_detail.SetFocus()
			dw_detail.SetColumn('df_cantid')
	   End if			
		lw_aux = parent.GetActiveSheet()
		dw_detail.SetFocus()
		if isValid(lw_aux) then
			ll_new = this.InsertRow(0)
			this.ScrolltoRow(ll_new)			
			this.SetRow(ll_new)
			this.SetColumn('codant')
		end if
END CHOOSE
end event

event dw_detail::doubleclicked;//int li_fila, li
//dec{2} ld_stock_disponible
//string ls_item,ls_codigo_atomo,ls_kit,ls_codant
//
//li_fila = this.getrow()
//ls_item = dw_detail.GetItemString(li_fila,'it_codigo')
//ls_codant = dw_detail.GetItemString(li_fila,'codant')
//ls_kit = dw_detail.GetItemString(li_fila,'it_kit')
//If ls_kit = 'S' Then
//	SELECT "IN_RELITEM"."IT_CODIGO","IN_RELITEM"."RI_CANTID"  
//	INTO:ls_codigo_atomo,:ld_stock_disponible
//	FROM "IN_RELITEM"  
//	WHERE ( "IN_RELITEM"."TR_CODIGO" = '1' ) AND  
//	( "IN_RELITEM"."IT_CODIGO1" = :ls_item ) AND  
//	( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
//else
//	ls_codigo_atomo = ls_item
//	ld_stock_disponible = 1
//End if
//
//if not isnull(ls_item) and ls_item <> '' then
//	dw_1.SetTransObject(sqlca)
//	dw_1.Retrieve(ld_stock_disponible,str_appgeninfo.empresa,ls_codigo_atomo,ls_codant)
//  end if	
//dw_1.visible = true 
//this.setcolumn("codant")
//this.setfocus()
//
end event

type dw_report from w_sheet_master_detail`dw_report within w_enviar_transferencia
integer x = 1669
integer y = 8
integer width = 2697
integer height = 2176
integer taborder = 0
string dataobject = "d_rep_cab_transferencia"
end type

event dw_report::rbuttondown;call super::rbuttondown;m_click_derecho NewMenu
window lw_parent, lw_frame
lw_frame=parent.parentWindow()
NewMenu = CREATE m_click_derecho
NewMenu.m_impresion.PopMenu(lw_frame.PointerX(), lw_frame.PointerY())

Destroy NewMenu
end event

type dw_ubica from datawindow within w_enviar_transferencia
event doubleclicked pbm_dwnlbuttondblclk
event itemchanged pbm_dwnitemchange
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 1513
integer y = 888
integer width = 2318
integer height = 292
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Transferencia"
string dataobject = "d_sel_factura_transfer"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
if keyDown(KeyEnter!) then
	triggerevent("buttonclicked")
End if
end event

event buttonclicked;//string ls_tipo, ls_factura, ls_ticket, ls_criterio
//long ll_found
//
//         this.accepttext()
//		ls_tipo = this.GetItemString(1,"tipo")
//		ls_factura = this.Getitemstring(1,"factura")
//		ls_ticket = this.Getitemstring(1,"ticket")		
//		If isnull(ls_factura) or isnull(ls_ticket) Then
//			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el n$$HEX1$$fa00$$ENDHEX$$mero de Factura o Ticket")
//			return
//		End if
//		CHOOSE CASE ls_tipo
//			CASE 'B'
//				ls_criterio = "tf_numero = " + "'" +ls_factura+ "'" + " and tf_ticket =" + "'"+ls_ticket+"'"
//				ll_found = dw_master.Find(ls_criterio,1,dw_master.RowCount())
//				if ll_found > 0 and not isnull(ll_found) then
//				  dw_master.SetFocus()
//				  dw_master.ScrollToRow(ll_found)
//				  dw_master.SetRow(ll_found)
//				  this.Visible = false
//	  			else
//				  messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Transferencia no se encuentra, verifique datos')
//				  return
//			  end if
//		   CASE 'F'
//				ls_criterio = "tf_numero = " + "'" +ls_factura+ "'" + " and tf_ticket = " + "'"+ls_ticket+"'"
//				dw_master.SetFilter(ls_criterio)
//				If dw_master.Filter() <> 1 Then 
//					messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n','Transferencia no encontrada, verifique datos')
//					return
//				End if
//				dw_master.SetFocus()
//				this.Visible = false	
//				dw_master.ScrollToRow(dw_master.GetRow())
//				dw_master.SetRow(dw_master.GetRow())				
//		END CHOOSE



/*Version para recuperar una a una EL envio de transferencia*/


Long ll_numero,ll_nreg,ll_recep
String ls_ticket,ls_numero,ls_sucdestino,ls_bodestino

this.accepttext()
ls_ticket = this.GetitemString(1,"ticket")		
ls_numero = this.GetitemString(1,"factura")

If isnull(ls_numero) and isnull(ls_ticket) Then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe ingresar el Ticket y n$$HEX1$$fa00$$ENDHEX$$mero")
	return
End if

ll_nreg = dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_ticket,ls_numero)
if ll_nreg <= 0 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones <Por favor verifique>")
		dw_detail.reset()
		return
end if
if ll_nreg = 1 then
ls_sucdestino =  dw_master.getitemstring(1,"su_codigo")
ls_bodestino =   dw_master.getitemstring(1,"bo_codigo")
dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_sucdestino,ls_bodestino,ls_ticket)
end if	






end event

type cb_1 from commandbutton within w_enviar_transferencia
boolean visible = false
integer x = 3941
integer y = 756
integer width = 293
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Importar"
end type

event clicked;string  ls_nulo,ls_codant,ls_pepa,ls_valstk,ls_sucursal_envio,&
        ls_sucursal_destino
decimal lc_pedido,lc_stock,lc_recargo = 0
long    li_fila,ll_filact,ll_reg
character lch_kit



ll_filact = dw_master.getrow()
ls_sucursal_envio = dw_master.GetItemString(ll_filact,"su_codenv")
ls_sucursal_destino = dw_master.GetItemString(ll_filact,"su_codigo")

if isnull(ls_sucursal_destino) or ls_sucursal_destino = "" then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe elegir la sucursal de destino",Exclamation!)
	return 
end if	

setnull(ls_nulo)
if dw_detail.importfile(ls_nulo)< 0 &
then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al importar el Archivo de transferencias",Exclamation!)
Return
end if

w_marco.SetMicrohelp("Importando Archivo....Por favor espere!!!")
ll_reg = dw_detail.Rowcount()


SetPointer(Hourglass!)
FOR li_fila = 1 to ll_reg
		
	 ls_pepa   = dw_detail.getitemstring(li_fila,'it_codigo')	
	 ls_codant = dw_detail.getitemstring(li_fila,'codant')
	 lc_pedido = dw_detail.GetItemNumber(li_fila,'cc_pedida')/*solicitado*/
	 lch_kit   = dw_detail.GetItemstring(li_fila,'it_kit')	 
 	 
	/*Todos los Items que se transfieren validan el stock*/
	
	 If ls_sucursal_envio <> ls_sucursal_destino then
			/*Verificar si existe en la sucursal*/	
			
			If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit) = false then
				/*Verifico en la bodega*/		 
				if f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_pepa,lch_kit,lc_pedido) = false then
				dw_detail.Object.df_cantid[li_fila]=lc_pedido
				else
				dw_detail.Object.df_cantid[li_fila]=lc_pedido
				end if
			else /*No existe en la sucursal*/
			dw_detail.Object.df_cantid[li_fila]=lc_stock	
			end if
	 else/*Verificar si existe stock en la bodega*/		
			if f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_pepa,lch_kit,lc_pedido) = false then
			 dw_detail.Object.df_cantid[li_fila]=lc_pedido
			else
			 dw_detail.Object.df_cantid[li_fila]=lc_pedido
			end if
	 end if		

NEXT
w_marco.SetMicrohelp("Listo....Archivo importado!!!")
SetPointer(Arrow!)
end event

type dw_1 from datawindow within w_enviar_transferencia
boolean visible = false
integer x = 2062
integer y = 112
integer width = 1541
integer height = 1788
string dataobject = "dw_consulta_stk_sucursales"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_movim from datawindow within w_enviar_transferencia
boolean visible = false
integer x = 4119
integer y = 360
integer width = 165
integer height = 68
boolean bringtotop = true
string dataobject = "d_mov_inv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_enviar_transferencia
integer x = 2875
integer y = 372
integer width = 430
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
string text = "Tiempo de proceso"
boolean focusrectangle = false
end type

type st_time from statictext within w_enviar_transferencia
integer x = 3310
integer y = 372
integer width = 169
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
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_enviar_transferencia
integer x = 3483
integer y = 372
integer width = 59
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
string text = "s"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_leyenda1 from statictext within w_enviar_transferencia
integer x = 3666
integer y = 160
integer width = 101
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33554431
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_leyenda2 from statictext within w_enviar_transferencia
integer x = 3666
integer y = 220
integer width = 101
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33554431
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_leyenda3 from statictext within w_enviar_transferencia
integer x = 3666
integer y = 280
integer width = 101
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33554431
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_enviar_transferencia
integer x = 3310
integer y = 156
integer width = 265
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
string text = "Sin stock"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_enviar_transferencia
integer x = 2971
integer y = 216
integer width = 608
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
string text = "Stock < a lo solicitado"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_enviar_transferencia
integer x = 2981
integer y = 268
integer width = 594
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
string text = "Stock = a lo solicitado"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_enviar_transferencia
integer x = 3447
integer y = 28
integer width = 183
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_enviar_transferencia
integer x = 2565
integer y = 32
integer width = 878
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
string text = "N$$HEX2$$ba002000$$ENDHEX$$de pedidos pendientes actualmente:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_enviar_transferencia
integer x = 3657
integer y = 24
integer width = 398
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ver pendientes"
end type

event clicked;
/*Recupera pedidos pendientes*/
dw_2.visible = true
 dw_2.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
end event

type cb_3 from commandbutton within w_enviar_transferencia
integer x = 3662
integer y = 472
integer width = 370
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
string text = "Ver demanda"
end type

event clicked;String ls_sudestino,ls_bodestino
Long ll_row
Date ld_ini


ll_row = dw_master.getrow()

ld_ini = date(em_1.text)
ls_sudestino = dw_master.Object.su_codigo[ll_row]
ls_bodestino = dw_master.Object.bo_codigo[ll_row]

if isnull(ls_sudestino) or ls_sudestino = "" then return
if isnull(ls_bodestino) or ls_bodestino = "" then return
if isnull(ld_ini) then return


dw_3.visible = true
SetPointer(Hourglass!)
if dw_3.rowcount() = 0 then
dw_3.retrieve(ld_ini,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_sudestino,ls_bodestino)
//elseif 
//      if dw_detail.Object.su_codenv[1]	= ls_sudestino then
//	 end if		
end if
SetPointer(Arrow!)
end event

type em_1 from editmask within w_enviar_transferencia
integer x = 3282
integer y = 476
integer width = 320
integer height = 72
integer taborder = 30
boolean bringtotop = true
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
end type

type dw_3 from uo_dw_basic within w_enviar_transferencia
boolean visible = false
integer x = 562
integer y = 652
integer width = 3351
integer height = 1164
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Demanda insatisfecha"
string dataobject = "d_rep_demanda_e_inconsistencias_transf_b"
boolean controlmenu = true
boolean hscrollbar = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;/*Subir la demanda insatisfecha para transferir*/
Long ll_reg,ll_new
Int i
String ls_nulo

Setnull(ls_nulo)
if dwo.name = 'b_1' then
	ll_reg = this.rowcount()
	dw_detail.reset()
	for i = 1 to ll_reg
		ll_new = dw_detail.insertrow(0)
		dw_detail.Object.it_codigo[ll_new]   = this.object.in_dettrans_it_codigo[i]
		dw_detail.Object.codant[ll_new]      = this.object.in_item_it_codant[i]
		dw_detail.Object.it_nombre[ll_new] = this.object.in_item_it_nombre[i]
		dw_detail.Object.df_cantid[ll_new]   = this.object.insatisfecha[i]
	next
	this.visible = false
end if

if dwo.name = 'b_2' then
this.visible = false	
end if
em_1.text = ls_nulo

end event

type st_7 from statictext within w_enviar_transferencia
integer x = 2875
integer y = 476
integer width = 393
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Demanda desde:"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_enviar_transferencia
boolean visible = false
integer x = 1056
integer y = 564
integer width = 1819
integer height = 836
boolean bringtotop = true
boolean titlebar = true
string title = "Lista de Pedidos"
string dataobject = "d_lista_de_transferencias"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;Long ll_reg,ll_row
String ls_sucdestino,ls_bodestino,ls_ticket,ls_numero,l_status_transferencia
Decimal lc_recargo = 0

ll_reg = this.rowcount()
if ll_reg = 0 then return
if row <= 0 then return
ls_sucdestino  = dw_2.Object.su_codigo[row]
ls_bodestino    = dw_2.Object.bo_codigo[row]
ls_ticket           = dw_2.Object.tf_ticket[row]
l_status_transferencia = dw_2.Object.tf_aceptada[row]


dw_master.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_sucdestino,ls_bodestino,ls_ticket)
dw_detail.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_sucdestino,ls_bodestino,ls_ticket)



if l_status_transferencia = 'X' then return
	

/*Recalcular la cantidad a despachasarse*/
w_marco.SetMicrohelp("Verificando stock....por favor espere!!!")
ll_reg = dw_detail.Rowcount()


string  ls_codant,ls_pepa,ls_valstk,ls_sucursal_envio,&
           ls_sucursal_destino
decimal lc_pedido,lc_stock
long    li_fila,ll_filact
character lch_kit




SetPointer(Hourglass!)
ll_filact = dw_master.getrow()
ls_sucursal_envio = dw_master.GetItemString(ll_filact,"su_codenv")
ls_sucursal_destino = dw_master.GetItemString(ll_filact,"su_codigo")

FOR li_fila = 1 to ll_reg
		
	 ls_pepa   = dw_detail.getitemstring(li_fila,'it_codigo')	
	 ls_codant = dw_detail.getitemstring(li_fila,'codant')
	 lc_pedido = dw_detail.GetItemNumber(li_fila,'in_dettrans_df_stkped')/*solicitado*/
	 lch_kit   = dw_detail.GetItemstring(li_fila,'it_kit')	 
 	 
	/*Todos los Items que se transfieren validan el stock*/
	
	 If ls_sucursal_envio <> ls_sucursal_destino then
			/*Verificar si existe en la sucursal*/		
			If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit ) = true then
				/*Verifico en la bodega*/		 
				if f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_pepa,lch_kit,lc_pedido) = false then
				dw_detail.Object.df_cantid[li_fila]=lc_pedido
				else
				dw_detail.Object.df_cantid[li_fila]=lc_pedido
				end if
			else /*No existe en la sucursal*/
				
				If lc_stock > 0 then	
					dw_detail.Object.df_cantid[li_fila]= lc_stock	
				else
					dw_detail.Object.df_cantid[li_fila]= 0	
				end if
			end if
	 else/*Verificar si existe stock en la bodega*/		
			if f_dame_stock_bodega_new(str_appgeninfo.seccion,ls_pepa,lch_kit,lc_pedido) = false then
			 dw_detail.Object.df_cantid[li_fila]=lc_pedido
			else
			 dw_detail.Object.df_cantid[li_fila]=lc_pedido
			end if
	 end if		

NEXT

SetPointer(Arrow!)
w_marco.SetMicrohelp("Listo....Stock verificado....!!!")



end event

type st_8 from statictext within w_enviar_transferencia
integer x = 41
integer y = 36
integer width = 498
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
string text = "Transferencia"
boolean focusrectangle = false
end type

type st_9 from statictext within w_enviar_transferencia
integer x = 37
integer y = 648
integer width = 343
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
string text = "Detalle "
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_enviar_transferencia
integer x = 2830
integer y = 104
integer width = 1234
integer height = 532
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Leyenda"
borderstyle borderstyle = stylebox!
end type


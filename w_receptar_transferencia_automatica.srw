HA$PBExportHeader$w_receptar_transferencia_automatica.srw
$PBExportComments$Si.Recepci$$HEX1$$f300$$ENDHEX$$n  de transferencias automaticas
forward
global type w_receptar_transferencia_automatica from w_sheet_1_dw_maint
end type
type cb_1 from commandbutton within w_receptar_transferencia_automatica
end type
type dw_1 from datawindow within w_receptar_transferencia_automatica
end type
type dw_2 from datawindow within w_receptar_transferencia_automatica
end type
type dw_det from datawindow within w_receptar_transferencia_automatica
end type
type cb_3 from commandbutton within w_receptar_transferencia_automatica
end type
end forward

global type w_receptar_transferencia_automatica from w_sheet_1_dw_maint
integer width = 2898
integer height = 1396
string title = "Transferencia Autom$$HEX1$$e100$$ENDHEX$$tica"
long backcolor = 79741120
boolean ib_notautoretrieve = true
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
dw_det dw_det
cb_3 cb_3
end type
global w_receptar_transferencia_automatica w_receptar_transferencia_automatica

forward prototypes
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_numero, string as_sucursal_destino, string as_bodega_destino, string as_nombodega)
end prototypes

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_numero, string as_sucursal_destino, string as_bodega_destino, string as_nombodega);// inserta los movimientos de inventario del item, si es kit tambi$$HEX1$$e900$$ENDHEX$$n de 
// sus componentes 
// Nota.- En in_relitem, tr_codigo=1 para kit
//			 En in_timov, tm_codigo=2, tm_ioe='E' es egreso por ventas
long    ll_num_movim,ll_contador = 0,ll_max,li_i
decimal ld_costo,ld_cantidad,ld_costo_kit
string  ls_num_movim, ls_factura,ls_es_kit,ls_componente,ls_observa,ls_codant
boolean lb_exito = TRUE
s_kit   lstr_kit[]

ls_observa = "Trf. desde "+as_nombodega+" No. "+as_numero

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
if sqlca.sqlcode <> 0 and sqlca.sqldbcode <> 1 then lb_exito = FALSE
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
		if sqlca.sqlcode <> 0 then lb_exito = FALSE
	next
end if // de si es kit
end if // de si lb_exito
if lb_exito then
	commit;
	return (TRUE)
else
	return(FALSE)
end if
end function

on w_receptar_transferencia_automatica.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_det=create dw_det
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_det
this.Control[iCurrent+5]=this.cb_3
end on

on w_receptar_transferencia_automatica.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_det)
destroy(this.cb_3)
end on

event open;string vecdatos[] = {'1','1','1','1','1','0'}

f_recupera_empresa(dw_datos,"su_codenv")
f_recupera_empresa(dw_datos,"bo_codenv")
f_recupera_empresa(dw_datos,"su_codigo")
f_recupera_empresa(dw_datos,"bo_codigo")
f_recupera_datos(dw_datos,"tf_ticket",vecdatos,6)
dw_det.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

call super::open
end event

event closequery;return
end event

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_receptar_transferencia_automatica
integer x = 23
integer y = 48
integer width = 2405
integer height = 1224
integer taborder = 40
string dataobject = "d_transferencia_automatica_r"
boolean hscrollbar = false
boolean livescroll = false
end type

event dw_datos::doubleclicked;call super::doubleclicked;string ls_sucursal_origen,ls_bodega_origen,&
           ls_sucursal_destino,ls_bodega_destino,&
		 ls_ticket,ls_numero

ls_sucursal_origen = dw_datos.GetItemString(row,"su_codenv")
ls_bodega_origen = dw_datos.GetItemString(row,"bo_codenv")
ls_sucursal_destino = dw_datos.GetItemString(row,"su_codigo")
ls_bodega_destino = dw_datos.GetItemString(row,"bo_codigo")
ls_ticket = dw_datos.GetItemString(row,"tf_ticket")
ls_numero = dw_datos.GetItemString(row,"tf_numero")

/*Recuperar el detalle */
dw_det.visible = true
dw_det.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,ls_sucursal_destino,ls_bodega_destino,ls_ticket)

end event

event dw_datos::clicked;call super::clicked;datawindowchild  ldwc_ticket
string ls_sucursal_origen,ls_bodega_origen,&
           ls_sucursal_destino,ls_bodega_destino,&
		 ls_ticket,ls_numero

dw_datos.getchild("tf_ticket",ldwc_ticket)
ldwc_ticket.settransobject(sqlca)
If dwo.name = "tf_ticket" Then
ls_sucursal_origen = dw_datos.GetItemString(row,"su_codenv")
ls_bodega_origen = dw_datos.GetItemString(row,"bo_codenv")
ls_sucursal_destino = dw_datos.GetItemString(row,"su_codigo")
ls_bodega_destino = dw_datos.GetItemString(row,"bo_codigo")
ls_ticket = dw_datos.GetItemString(row,"tf_ticket")
ldwc_ticket.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,ls_sucursal_destino,ls_bodega_destino,ls_ticket)
End if

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_receptar_transferencia_automatica
integer x = 2491
integer y = 1116
integer width = 165
integer height = 100
integer taborder = 90
boolean hsplitscroll = true
end type

type cb_1 from commandbutton within w_receptar_transferencia_automatica
integer x = 2496
integer y = 208
integer width = 343
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;Long   ll_nreg,i,ll_max,j
string ls_enviar,ls_sucursal_origen,ls_bodega_origen,&
           ls_sucursal_destino,ls_bodega_destino,&
		 ls_ticket,ls_numero,ls_filename_c,ls_filename_d,&
		 ls_item,ls_nombodega,ls_filtro
decimal ld_cantidad
datetime   ld_fecha		 

Setpointer(Hourglass!)

if  Messagebox ("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de recibir la transferencia autom$$HEX1$$e100$$ENDHEX$$tica.?",question!,YesNo!,1) = 2 &
then
return
end if 

ll_nreg = dw_datos.rowcount()
dw_1.reset()
dw_2.reset()

for i = 1 to ll_nreg
	ls_enviar = dw_datos.getitemstring(i,"tf_numenvio")	
	if ls_enviar = 'S' then
	     /*argumentos para recuperar el detalle de la transferencia*/	
		 ls_sucursal_origen = dw_datos.GetItemString(i,"su_codenv")
		 ls_bodega_origen = dw_datos.GetItemString(i,"bo_codenv")
		 ls_sucursal_destino = dw_datos.GetItemString(i,"su_codigo")
		 ls_bodega_destino = dw_datos.GetItemString(i,"bo_codigo")
		 ls_ticket = dw_datos.GetItemString(i,"tf_ticket")
		 ls_numero = dw_datos.GetItemString(i,"tf_numero")
		 ld_fecha = dw_datos.GetItemDateTime(i,"tf_fecha")	
	    
		select substr(bo_nombre,1,30)
		into :ls_nombodega
		from in_bode
		where em_codigo = :str_appgeninfo.empresa
		and su_codigo = :ls_sucursal_origen
		and bo_codigo = :ls_bodega_origen;
		 
		 /**/
	     dw_datos.rowscopy(i,i,Primary!,dw_1,ll_nreg,Primary!)
		 
	      /*Recuperar el detalle */
		 ls_filtro =  "em_codigo = '"+str_appgeninfo.empresa+&
		                     "' and su_codenv = '"+ls_sucursal_origen+&
						 "' and bo_codenv = '"+ls_bodega_origen+&
						 "' and su_codigo = '"+ls_sucursal_destino+&
						 "' and bo_codigo = '"+ls_bodega_destino+&
						 "' and tf_ticket = '"+ls_ticket+"'"
  	      dw_det.setfilter(ls_filtro)
		 dw_det.filter()
		 ll_max = dw_det.rowcount()
		 dw_det.rowscopy(1,ll_max,Primary!,dw_2,dw_2.rowcount()+1,Primary!)

           /*procesar*/
		 for j = 1 to ll_max
			ls_item = dw_det.GetItemString(j,"it_codigo")
			ld_cantidad = dw_det.GetItemNumber(j,"df_cantid")
			f_carga_stock_tdr_sucursal(ls_item,ld_cantidad)
			f_carga_stock_bodega(str_appgeninfo.seccion,ls_item,ld_cantidad)
			
			wf_mov_inventario(ls_item,ld_cantidad,ld_fecha,ls_ticket,ls_sucursal_destino,ls_bodega_destino,ls_nombodega)
 	 next
	end if	
next

/*Actualiza los datos de las transferencias recibidas a la base*/
if dw_1.update() = 1 then
      if  dw_2.update() = 1 then
	dw_1.resetupdate()
	dw_2.resetupdate()
	else
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar el detalle de transferencias." +sqlca.sqlerrtext)
	rollback;
	return
	end if
else
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al actualizar la transferencia" +sqlca.sqlerrtext)
	rollback;
	return
end if

commit;
w_marco.setmicrohelp("Listo...")
Setpointer(Arrow!)




end event

type dw_1 from datawindow within w_receptar_transferencia_automatica
boolean visible = false
integer x = 2491
integer y = 784
integer width = 169
integer height = 84
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_transferencia_automatica_r"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_receptar_transferencia_automatica
boolean visible = false
integer x = 1499
integer y = 644
integer width = 1339
integer height = 588
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_archivo_plano_det_transferencia"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_det from datawindow within w_receptar_transferencia_automatica
boolean visible = false
integer x = 32
integer y = 636
integer width = 1454
integer height = 596
integer taborder = 80
boolean bringtotop = true
string title = "Detalle Transferencia"
string dataobject = "d_archivo_plano_det_transferencia"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_receptar_transferencia_automatica
integer x = 2491
integer y = 96
integer width = 343
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importar"
end type

event clicked;/*Importa los archivos de transferencias enviadas */
string ls_filename_c,ls_filename_d


ls_filename_c = "C:\LIBIAK\archivos\c_trf_"+str_appgeninfo.sucursal+".txt"
ls_filename_d = "C:\LIBIAK\archivos\d_trf_"+str_appgeninfo.sucursal+".txt"
if dw_datos.importfile(ls_filename_c) <= 0 &
then 
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al importar las cabeceras de las transferencias.")
return
end if

if dw_det.importfile(ls_filename_d) <= 0 &
then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al importar el detalle de la transferencias.")
return
end if


end event


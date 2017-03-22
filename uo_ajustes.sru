HA$PBExportHeader$uo_ajustes.sru
$PBExportComments$Para egresos de produccion
forward
global type uo_ajustes from userobject
end type
type st_1 from statictext within uo_ajustes
end type
type dw_movim from datawindow within uo_ajustes
end type
type dw_detail from datawindow within uo_ajustes
end type
type dw_master from datawindow within uo_ajustes
end type
end forward

global type uo_ajustes from userobject
integer width = 3355
integer height = 1752
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_update pbm_custom01
st_1 st_1
dw_movim dw_movim
dw_detail dw_detail
dw_master dw_master
end type
global uo_ajustes uo_ajustes

type variables
string is_codant1
long il_numero,il_rc
string is_nombodega,is_numord
boolean   ib_genera_ordprd = false

end variables

forward prototypes
public function integer wf_controla_stock_bodega (integer num_filas)
public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_tipomov, string as_signomov, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo, decimal ac_costprom)
public function integer wf_carga_formulacion (string as_itcodigo, decimal ac_cantidad_x_formula)
public function integer wf_genera_ordmpd ()
end prototypes

event ue_update;integer rc,li_i,i,li_filact,li_numfilas
string ls_numajuste,ls_tipo_mov,ls_signo_mov,ls_codigo,ls_numero,ls_atomo
datetime ld_fecha
dec{2} lc_cantidad
dec{4} lc_costo_atomo,lc_cantatomo,lc_costo,lc_costprom
integer li_pasa
character lch_kit,lch_estado
dwitemstatus l_status 

li_filact = dw_master.getrow()
if li_filact = 0 then 
	il_rc = -1
	return il_rc
end if
li_numfilas = dw_detail.RowCount()
dw_movim.reset()
If li_numfilas <= 0  Then
messagebox("Error","Debe ingresar el detalle para actualizar el ajuste de inventarios")
	il_rc = -1
	return il_rc
End if

/*No permitir grabar si el registro ya existe*/
l_status = dw_master.getitemstatus(li_filact,0,Primary!)
if l_status = notmodified! or l_status = datamodified!&
then
messagebox("Error","Este registro ya fue grabado")
rollback;
	il_rc = -1
	return il_rc
end if

// borra las filas en blanco
for li_i = 1 to li_numfilas
	is_codant1 = dw_detail.GetItemString(li_i - i,'codant')
	if isnull(is_codant1) or is_codant1 = '' then
   	dw_detail.DeleteRow(li_i - i )
		i=i+1	  
	end if
next

li_numfilas = dw_detail.RowCount()

il_numero = f_dame_sig_numero('NUM_AJUS')

if il_numero <= 0 then
	messagebox("Atenc$$HEX1$$ed00$$ENDHEX$$on","Problemas al obtener el secuencial del ajuste")
	rollback;
	il_rc = -1
	return il_rc
end if 

ls_numero = string(il_numero)
dw_master.setitem(li_filact,"aj_numero",ls_numero)

ld_fecha = dw_master.GetItemDateTime(li_filact,"aj_fecha")
ls_tipo_mov = dw_master.GetItemString(li_filact,"tm_codigo")
ls_signo_mov = dw_master.GetItemString(li_filact,"tm_ioe")
if ls_signo_mov = 'I' and ls_tipo_mov = '3' then
	dw_master.setitem(li_filact,"aj_estado",'N')
end if	
//Encuentra el nombre de la bodega
select bo_nombre
into :is_nombodega
from in_bode
where em_codigo = :str_appgeninfo.empresa
and su_codigo = :str_appgeninfo.sucursal
and bo_codigo = :str_appgeninfo.seccion;

dw_detail.accepttext()
//funcion que controla el stock m$$HEX1$$e100$$ENDHEX$$ximo a venderse de un producto
If ls_signo_mov = 'E' Then
	li_pasa = wf_controla_stock_bodega(li_numfilas)  //Recorre todas las filas
	If li_pasa = -1 Then
	
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se ha podido grabar este Ajuste~r~n"+&
								"Debido a que el stock disponible del producto ["+is_codant1+"]~r~n"+&
								"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>")
			rollback;	
			il_rc = -1
			return il_rc
	End if
End if

for i =1 to li_numfilas
	lc_cantidad   = dw_detail.getitemnumber(i,'da_cantidad')	
	ls_codigo      = dw_detail.getitemstring(i,'it_codigo')	
	is_codant1    = dw_detail.getitemstring(i,'codant')		
	lch_kit          = dw_detail.getitemstring(i,'it_kit')	
	lc_costo        = dw_detail.getitemdecimal(i,'da_costo')		

	
	dw_detail.setitem(i,"aj_numero",ls_numero)
	dw_detail.setitem(i,"em_codigo",str_appgeninfo.empresa)		 	 
	dw_detail.setitem(i,"su_codigo",str_appgeninfo.sucursal)		 	 	 
	dw_detail.setitem(i,"bo_codigo",str_appgeninfo.seccion)		 	 	 
	dw_detail.setitem(i,"tm_codigo",ls_tipo_mov)		 
	dw_detail.setitem(i,"tm_ioe",ls_signo_mov) 	 
	dw_detail.setitem(i,"da_secuen",string(i))
	
	If lch_kit = 'S' Then
		SELECT "IN_ITEM"."IT_COSTO", "IN_RELITEM"."IT_CODIGO", "IN_RELITEM"."RI_CANTID"
		INTO :lc_costo_atomo,:ls_atomo, :lc_cantatomo
		FROM "IN_ITEM"  , "IN_RELITEM"
		WHERE ("IN_RELITEM"."EM_CODIGO" = "IN_ITEM"."EM_CODIGO") and
		("IN_RELITEM"."IT_CODIGO" = "IN_ITEM"."IT_CODIGO") and
		("IN_RELITEM"."TR_CODIGO" = '1' ) and
		( "IN_RELITEM"."IT_CODIGO1" = :ls_codigo ) and
		( "IN_RELITEM"."EM_CODIGO" = :str_appgeninfo.empresa );
	End if
	
	// si es egreso
	if ls_signo_mov = 'E' then
		if f_descarga_stock_rt_sucursal(ls_codigo,lc_cantidad,lch_kit,ls_atomo,lc_cantatomo) = False Then
			rollback;
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la sucursal del producto: '"+is_codant1)
			il_rc = -1
  	         return il_rc
		end if
		
		if f_descarga_stock_bodega(str_appgeninfo.seccion,ls_codigo,lc_cantidad,lch_kit,ls_atomo,lc_cantatomo) = false Then
			rollback;
			messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al descargar el stock en la seccion del producto: '"+is_codant1)
			il_rc = -1
			return il_rc
		End if					
	elseif ls_signo_mov = 'I' then
		// carga el stock te$$HEX1$$f300$$ENDHEX$$rico,real,disponible
		if f_carga_stock_tdr_sucursal_new(ls_codigo,lc_cantidad,lch_kit,ls_atomo,lc_cantatomo) = false Then
		    il_rc = -1
 	        return il_rc
		End if			
		// carga el stock en bodega		
		if f_carga_stock_bodega_new(str_appgeninfo.seccion,ls_codigo,lc_cantidad,lch_kit,ls_atomo,lc_cantatomo) = false Then
			il_rc = -1
 	        return il_rc
		End if			
	end if	
	
	//Determinar el costo promedio
	select NVL(it_costprom,0)
	into   :lc_costprom
	from in_item
	where it_codigo = :ls_codigo;
	
	if sqlca.sqlcode <> 0 then
	lc_costprom = 0	
	end if
		
    //El costo de la transacci$$HEX1$$f300$$ENDHEX$$n en este caso es el costo promedio  
	lc_costprom =  f_costprom(ls_codigo,ls_signo_mov,lc_cantidad,lc_costprom)
		
	// inserta los movimientos de Inventarios
	if wf_mov_inventario(ls_codigo,lc_cantidad,ld_fecha,ls_tipo_mov,ls_signo_mov,+&
								lch_kit,ls_atomo,lc_cantatomo,lc_costo_atomo,lc_costo,lc_costprom) = false then
		rollback;								
		Messagebox("Error","Problemas al actualizar el inventario...wf_mov_inventario()")
		dw_movim.reset()
		il_rc = -1
 	     return il_rc
   end if
next 

//5.- Actualizo los datos de la factura
rc =  dw_master.update(true,false) 
if rc = 1 then
	 rc = dw_detail.update(true,false)
	 if rc = 1 then
		  rc =  dw_movim.update(true,false)
	      if rc = 1 then	
			     //Actualizar la orden de producci$$HEX1$$f300$$ENDHEX$$n con el total del costo
				  
				if ib_genera_ordprd = true then
					rc = wf_genera_ordmpd() 
				end if
				if rc = 1 then		
					dw_master.resetupdate()
					dw_detail.resetupdate()
					dw_movim.resetupdate()			
					commit;  
                       il_rc = 1
				else
				rollback;
				messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar los movimientos del ajuste" +sqlca.sqlerrtext)					 
				il_rc = -1
				return il_rc	
				end if	
		 else
		 rollback;
		 messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar los movimientos del ajuste" +sqlca.sqlerrtext)					 
		 il_rc = -1
 	     return il_rc
 	     end if						
    else
	rollback;
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar el detalle del ajuste" +sqlca.sqlerrtext)				
	il_rc = -1
 	return il_rc
    end if	
else
rollback;
messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se pudo grabar la cabecera del ajuste" +sqlca.sqlerrtext)	
il_rc = -1
return il_rc
end if

//dw_detail.reset()
//dw_master.reset()
setpointer(arrow!)
il_rc = 1
return il_rc
end event

public function integer wf_controla_stock_bodega (integer num_filas);//Descripcion: Funcion que controla el stock maximo disponible de un producto para que sea facturado
//fecha de creaci$$HEX1$$f300$$ENDHEX$$n : 10/05/2001
//Ultima revision:27/09/2001

integer i,j
string ls_item,ls,ls_codant,ls_kit,ls_valstk,ls_codigo_atomo
dec{2} lc_stock,lc_candes,lc_candes_aux,lc_cantidad,lc_stock_disponible

for i =1 to num_filas
ls_item = dw_detail.getitemstring(i,"it_codigo")
lc_cantidad = dw_detail.getitemdecimal(i,"da_cantidad")	
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
				lc_candes_aux = dw_detail.getitemdecimal(j,"da_cantidad")
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

public function boolean wf_mov_inventario (string as_item, decimal ad_cantidad, datetime ad_fecha, string as_tipomov, string as_signomov, character ach_kit, string as_atomo, decimal ac_cantatomo, decimal ac_costo_atomo, decimal ac_costo, decimal ac_costprom);////////////////////////////////////////////////////////////////////////
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
ls_observa = "Ajuste de "+as_signomov+". No. "+string(il_numero)+" de "+is_nombodega + " Ord.Prd: "+is_numord
// busca si el item es kit o no 
if ach_kit = 'S' then
	// es un kit
	ls_obs_kit = "Ajuste de "+as_signomov+". del kit "+is_codant1+" No. "+string(il_numero)+" de "+is_nombodega + " Ord.Prd: "+is_numord
	// inserto el movimiento del item
	ll_num_movim = f_dame_sig_numero('NUM_MINV')
	if ll_num_movim = -1 then
		messagebox('ERROR$$HEX1$$a100$$ENDHEX$$','No se puede grabar movimiento de inventario')	
		return FALSE
	end if
	ls_num_movim = string(ll_num_movim)
	//ingresa el atomo (peque$$HEX1$$f100$$ENDHEX$$o)
	ll_fila = dw_movim.insertrow(0)
	dw_movim.setitem(ll_fila,"tm_codigo",as_tipomov)
	dw_movim.setitem(ll_fila,"tm_ioe",as_signomov)
	dw_movim.setitem(ll_fila,"it_codigo",as_atomo)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad * ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo_atomo)
     dw_movim.setitem(ll_fila,"mv_costtrans",ac_costprom/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom/ac_cantatomo)
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_obs_kit)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",il_numero)		
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
	dw_movim.setitem(ll_fila,"tm_codigo",as_tipomov)
	dw_movim.setitem(ll_fila,"tm_ioe",as_signomov)
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",il_numero)		
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
	dw_movim.setitem(ll_fila,"tm_codigo",as_tipomov)
	dw_movim.setitem(ll_fila,"tm_ioe",as_signomov)
	dw_movim.setitem(ll_fila,"it_codigo",as_item)
	dw_movim.setitem(ll_fila,"su_codigo",str_appgeninfo.sucursal)	
	dw_movim.setitem(ll_fila,"bo_codigo",str_appgeninfo.seccion)	
	dw_movim.setitem(ll_fila,"mv_numero",ls_num_movim)	
	dw_movim.setitem(ll_fila,"mv_cantid",ad_cantidad)		
	dw_movim.setitem(ll_fila,"mv_costo",ac_costo)	
	dw_movim.setitem(ll_fila,"mv_costtrans",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_costprom",ac_costprom)	
	dw_movim.setitem(ll_fila,"mv_fecha",ad_fecha)	
	dw_movim.setitem(ll_fila,"em_codigo",str_appgeninfo.empresa)	
	dw_movim.setitem(ll_fila,"mv_observ",ls_observa)		
	dw_movim.setitem(ll_fila,"mv_usado",'N')		
	dw_movim.setitem(ll_fila,"ve_numero",il_numero)		
	dw_movim.setitem(ll_fila,"es_codigo",ls_nulo)		
end if
return(TRUE)

end function

public function integer wf_carga_formulacion (string as_itcodigo, decimal ac_cantidad_x_formula);//long ll_new,i
//String ls_pepa,ls_codant,ls_nombre
//Decimal lc_cantid,lc_cantidad_a_producir
//
//lc_cantidad_a_producir = dw_ord.object.or_cantid[dw_ord.getrow()]
//dw_formula.retrieve(as_itcodigo,'F')
//
//for i = 1 to dw_formula.rowcount()
//         ll_new = dw_detail.insertrow(0)
//         dw_detail.Object.it_codigo[ll_new]                = dw_formula.object.it_codigo1[i]
//	    dw_detail.Object.in_item_it_codant[ll_new]    = dw_formula.object.it_codant[i]
//	    dw_detail.Object.in_item_it_nombre[ll_new]   = dw_formula.object.it_nombre[i]
//	    dw_detail.Object.re_cantid[ll_new]                = dw_formula.object.rq_cantid[i]*ac_cantidad_x_formula*lc_cantidad_a_producir
//next
//
return 1
end function

public function integer wf_genera_ordmpd ();String ls_orcodigo,ls_numajuste
Date  ld_fecajuste
Long ll_row
Decimal ldc_costtotal
Int    li_sec


ll_row = dw_master.Getrow()
if ll_row = 0 then return -1

ls_orcodigo    = dw_master.Object.or_codigo[ll_row] 
ls_numajuste = dw_master.Object.aj_numero[ll_row] 
ld_fecajuste   = Date(dw_master.Object.aj_fecha[ll_row])
ldc_costtotal  =  dw_detail.Object.cc_costototal[1]

SELECT MAX(DR_SECUE) + 1
INTO  :li_sec
FROM PD_ORDMPD
WHERE OR_CODIGO = :ls_orcodigo;

if isnull(li_sec) or li_sec = 0 then li_sec = 1

INSERT INTO "PD_ORDMPD"  
         ( "OR_CODIGO",   
           "DR_SECUE",   
           "DR_NRODOC",   
           "DR_VALOR",   
           "ESTADO",   
           "DR_FECHA" )  
  VALUES ( :ls_orcodigo,   
           :li_sec,   
           :ls_numajuste,   
           :ldc_costtotal,   
           null,   
           :ld_fecajuste )  ;
			  
 IF SQLCA.SQLCODE <> 0 THEN
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al insertar el documento..."+sqlca.sqlerrtext)
	Rollback;
	Return -1
 End if
 
 Return 1

end function

on uo_ajustes.create
this.st_1=create st_1
this.dw_movim=create dw_movim
this.dw_detail=create dw_detail
this.dw_master=create dw_master
this.Control[]={this.st_1,&
this.dw_movim,&
this.dw_detail,&
this.dw_master}
end on

on uo_ajustes.destroy
destroy(this.st_1)
destroy(this.dw_movim)
destroy(this.dw_detail)
destroy(this.dw_master)
end on

event constructor;dw_master.SetTransObject(sqlca)
dw_detail.SetTransObject(sqlca)
dw_movim.SetTransObject(sqlca)
f_recupera_empresa(dw_master,"tm_codigo")
end event

type st_1 from statictext within uo_ajustes
integer x = 37
integer y = 460
integer width = 402
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "DETALLE"
boolean focusrectangle = false
end type

type dw_movim from datawindow within uo_ajustes
boolean visible = false
integer x = 2688
integer y = 76
integer width = 329
integer height = 296
integer taborder = 20
string title = "none"
string dataobject = "d_mov_inv"
boolean livescroll = true
end type

type dw_detail from datawindow within uo_ajustes
integer x = 27
integer y = 520
integer width = 3278
integer height = 1188
integer taborder = 20
string title = "none"
string dataobject = "d_detalle_ajuste_produccion"
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;string ls_null,ls_sucursal,ls_bodega,ls_codant,ls_nombre,ls_pepa,ls_codmov
character lch_kit,lch_signo_mov,lch_valstk
integer li_filact,li_max,li_find
dec{2} lc_prefab,lc_costo,ld_null,lc_pedido,lc_stock


dw_master.AcceptText()
li_filact = dw_master.GetRow()
ls_sucursal = dw_master.GetItemString(li_filact,"su_codigo")
ls_bodega = dw_master.GetItemString(li_filact,"bo_codigo")
lch_signo_mov = dw_master.GetItemString(li_filact,"tm_ioe") 
ls_codmov = dw_master.GetItemString(li_filact,"tm_codigo") 

str_prodparam.fila = row
li_max = this.RowCount()
if row < 1 then return


if dwo.name = 'codant' Then
	ls_codant = this.gettext()
	li_find =  dw_detail.find("codant = '"+ls_codant+"'",1, li_max - 1)
	if li_find <> 0 and li_max <> 1 then
		deleterow(row)
//		is_mensaje = "Ya est$$HEX2$$e1002000$$ENDHEX$$ingresado el codigo: "+ls_codant+" ...Por favor revise, la l$$HEX1$$ed00$$ENDHEX$$nea "+string(li_find)
		return 1
	end if
	
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo,it_nombre,it_prefab,it_valstk,it_kit,it_costo
	into :ls_pepa,:ls_nombre,:lc_prefab,:lch_valstk,:lch_kit,:lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;
	if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
		select it_codigo,it_codant,it_nombre,it_prefab,it_valstk,it_kit,it_costo
		into :ls_pepa,:ls_codant,:ls_nombre,:lc_prefab,:lch_valstk,:lch_kit,:lc_costo
		from in_item
		where em_codigo = :str_appgeninfo.empresa
		and it_codbar = :ls_codant;
		if sqlca.sqlcode <> 0 then
			setnull(ls_null)
			this.SetItem(row,"codant",ls_null)
			beep(1)
//			is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
			return 1
			this.SetItem(row,"it_codigo",ls_null)
			this.SetItem(row,'it_nombre',ls_null)
			setnull (ld_null)
			this.SetItem(row,'da_cantidad',ld_null)
			return(1)
		else
			this.SetItem(row,"it_codigo",ls_pepa)
			this.setitem(row,'it_nombre',ls_nombre)
			this.setitem(row,'it_kit',lch_kit)			
			this.setitem(row,'it_costo',lc_costo)
			this.setitem(row,'da_costo',lc_costo)
			if ls_codmov = '3' then
			this.setitem(row,'da_estado','S')				
			end if
			this.SetColumn("da_cantidad")
		end if
    else
 	 // si es un Egreso
	  if lch_signo_mov = 'E' then
		if lch_valstk = 'S' then
			lc_pedido = 1.0
			If f_dame_stock_bodega_new(ls_bodega,ls_pepa,lch_kit,lc_pedido) = false then
				rollback;
				deleterow(row)
//				is_mensaje = "No hay stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)
				return 1
			End if
			If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit) = false then
					rollback;
					deleterow(row)
//					is_mensaje = "No hay stock en sucursal del producto ["+ls_codant+"] = "+string(lc_stock)
					return 1						
			end if
		end if
	  end if
		this.setitem(row, 'da_cantidad', 1)
		this.setitem(row, 'it_nombre',ls_nombre)
		this.setitem(row, 'it_codigo',ls_pepa)
		this.setitem(row,'it_kit',lch_kit)			
		this.setitem(row,'it_costo',lc_costo)
		this.setitem(row,'da_costo',lc_costo)
		if ls_codmov = '3' then
			this.setitem(row,'da_estado','S')				
		end if
	end if 
end if


If dwo.name = 'da_cantidad' Then
	lc_pedido = dec(this.gettext()) 
	if lc_pedido <= 0 then
		this.SetItem(row,'da_cantidad',this.GetItemNumber(row,'da_cantidad'))
//		is_mensaje = 'La cantidad debe ser mayor a cero'
		return 1
	end if
	ls_codant = this.getitemstring(row,'codant')
	select it_codigo, it_nombre, it_prefab, it_valstk,it_kit,it_costo
	into :ls_pepa, :ls_nombre, :lc_prefab, :lch_valstk,:lch_kit,:lc_costo
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls_codant;	
	if lch_signo_mov = 'E' then 
	  if lch_valstk = 'S' then
			If f_dame_stock_sucursal_new(ls_pepa,lc_pedido,lc_stock,lch_kit) = false then
				rollback;
//		      is_mensaje = "El stock en sucursal del producto ["+ls_codant+"] = "+string(lc_stock)+"~r~n"+&
//							"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>"
		      SetItem(row,'da_cantidad',lc_stock)
				return 1		
			end if
		   If f_dame_stock_bodega_new(ls_bodega,ls_pepa,lch_kit,lc_pedido) = false then
				rollback;
//				is_mensaje = "El stock en bodega del producto ["+ls_codant+"] = "+string(lc_pedido)+"~r~n"+&
//								"es menor que la cantidad ingresada...<Verif$$HEX1$$ed00$$ENDHEX$$que su stock>"
				SetItem(row,'da_cantidad',lc_pedido)							
				return 1
		   End if
	   End if
	End if
End if
end event

type dw_master from datawindow within uo_ajustes
integer x = 27
integer y = 36
integer width = 3278
integer height = 396
integer taborder = 10
string title = "none"
string dataobject = "d_pd_entregamateriales"
boolean vscrollbar = true
boolean livescroll = true
end type


HA$PBExportHeader$w_actualiza_items.srw
$PBExportComments$Si.
forward
global type w_actualiza_items from w_response_basic
end type
type st_1 from statictext within w_actualiza_items
end type
type p_1 from picture within w_actualiza_items
end type
type dw_1 from datawindow within w_actualiza_items
end type
type dw_2 from datawindow within w_actualiza_items
end type
type dw_3 from datawindow within w_actualiza_items
end type
type cb_1 from commandbutton within w_actualiza_items
end type
type dw_4 from datawindow within w_actualiza_items
end type
end forward

global type w_actualiza_items from w_response_basic
integer width = 1778
integer height = 612
string title = "Proceso de actualizaci$$HEX1$$f300$$ENDHEX$$n de items"
st_1 st_1
p_1 p_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_1 cb_1
dw_4 dw_4
end type
global w_actualiza_items w_actualiza_items

on w_actualiza_items.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_1=create p_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_1=create cb_1
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_4
end on

on w_actualiza_items.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.dw_4)
end on

type pb_cancel from w_response_basic`pb_cancel within w_actualiza_items
integer x = 1280
integer y = 328
integer width = 398
integer height = 100
integer taborder = 70
string text = "&Salir"
boolean default = true
string picturename = ""
end type

event pb_cancel::clicked;close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_actualiza_items
integer x = 274
integer y = 196
integer width = 832
integer height = 100
integer taborder = 50
fontcharset fontcharset = ansi!
string text = "&Actualizar Precios"
boolean default = false
string picturename = ""
end type

event pb_ok::clicked;call super::clicked;long ll_i,ll_filas
string ls_item,ls_codigo
decimal  ld_recargo

setpointer(hourglass!)

dw_response.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_4.SetTransObject(sqlca)

w_marco.SetMicroHelp("Paso 1 de 8.  Borrando tablas...")

w_marco.SetMicroHelp("Borrando tabla de Kits...")
Execute Immediate "TRUNCATE TABLE DINAMIC.IN_RELITEM";
If SQLCA.SQLCODE < 0 Then
	Rollback;
  	messagebox("Error","Problemas al borrar tabla in_relitem "+sqlca.sqlerrtext)
	return -1
Else
w_marco.SetMicroHelp("Tabla de Borrada.")
End if
w_marco.SetMicroHelp("Borrando tabla de Descuentos...")
Execute Immediate "TRUNCATE TABLE DINAMIC.IN_DESCITEM";
If SQLCA.SQLCODE < 0 Then
	Rollback;
  	messagebox("Error","Problemas al borrar tabla in_descitem "+sqlca.sqlerrtext)
	return -1
Else
w_marco.SetMicroHelp("Tabla de Borrada.")
End if
w_marco.SetMicroHelp("Borrando tabla de Tipos de Descuentos...")
Execute Immediate "ALTER TABLE DINAMIC.IN_DESCITEM DISABLE CONSTRAINT FK_DESCUENTO_POR_ITEM_1";
Execute Immediate "TRUNCATE TABLE DINAMIC.IN_TIPPRE";
If SQLCA.SQLCODE < 0 Then
	Rollback;
  	messagebox("Error","Problemas al borrar tabla in_tippre "+sqlca.sqlerrtext)
	return -1
Else
w_marco.SetMicroHelp("Tabla de descuentos Borrada.")
End if

w_marco.SetMicroHelp("Borrando tabla de Fabricantes...")
Execute Immediate "ALTER TABLE DINAMIC.IN_ITEM DISABLE CONSTRAINT FK_FABRICANTE_ITEM";
Execute Immediate "TRUNCATE TABLE DINAMIC.IN_FABRICANTE";
If SQLCA.SQLCODE < 0 Then
	Rollback;
  	messagebox("Error","Problemas al borrar tabla in_fabricante "+sqlca.sqlerrtext)
	return -1
Else
w_marco.SetMicroHelp("Tabla de fabricantes Borrada.")
End if

w_marco.SetMicroHelp("Borrando tabla de Items...")

Execute Immediate "ALTER TABLE DINAMIC.FA_DETVE DISABLE CONSTRAINT FK_ITEM_FACTURA";
Execute Immediate "ALTER TABLE DINAMIC.IN_DESCITEM DISABLE CONSTRAINT FK_DESCUENTO_POR_ITEM_2";
Execute Immediate "ALTER TABLE DINAMIC.IN_DETTRANS DISABLE CONSTRAINT FK_ITEM_TRANSFERENCIA";
Execute Immediate "ALTER TABLE DINAMIC.IN_HOJTEC DISABLE CONSTRAINT FK_ITEM_HOJA_TECNICA";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITEDET DISABLE CONSTRAINT FK_IN_ITEDET_IN_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITEEMP DISABLE CONSTRAINT FK_IN_ITEEMP_IN_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITEPRO DISABLE CONSTRAINT FK_ITEM_PROVEEDOR";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITESUCUR DISABLE CONSTRAINT FK_ITEM_SUCURSAL_1";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITETAR DISABLE CONSTRAINT FK_ITETAR_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_MOVIM DISABLE CONSTRAINT FP_IN_MOVIM_IN_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_PREPARADO DISABLE CONSTRAINT FK_ITEM_PREPARADO";
Execute Immediate "ALTER TABLE DINAMIC.IN_PREPARADO DISABLE CONSTRAINT FK_PREPARACION_ITEMS";
Execute Immediate "ALTER TABLE DINAMIC.IN_RELITEM DISABLE CONSTRAINT FK_ITEM_RELACION_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_RELITEM DISABLE CONSTRAINT FK_ITEM_RELACION_ITEM_1";


//Execute Immediate "ALTER TABLE DINAMIC.IN_RECARGO DISABLE CONSTRAINT FK_ITEM_RECARGO";

Execute Immediate "TRUNCATE TABLE DINAMIC.IN_ITEM";
w_marco.SetMicroHelp("Borrando tabla de Items")
If SQLCA.SQLCODE < 0 Then
	Rollback;
  	messagebox("Error","Problemas al borrar tabla in_item "+sqlca.sqlerrtext)
	return -1
Else
   w_marco.SetMicroHelp("Tabla de Items Borrada.")
End if

w_marco.SetMicroHelp("Paso 2 de 8.  Actualizando tabla de Fabricantes...")
dw_4.ImportFile('c:\libiak\Archivos\Fabricante.TXT')
dw_4.Update()
If SQLCA.SQLCODE < 0 Then
	Rollback;
  	messagebox("Error","Problemas al actualizar tabla in_fabricante "+sqlca.sqlerrtext)
	return -1
Else
w_marco.SetMicroHelp("Tabla de Fabricantes Actualizada.")
End if

Execute Immediate "ALTER TABLE DINAMIC.IN_ITEM ENABLE CONSTRAINT FK_FABRICANTE_ITEM";


w_marco.SetMicroHelp("Paso 3 de 8.  Actualizando tabla de Items")
dw_response.ImportFile('c:\libiak\Archivos\Items.TXT')
dw_response.Update()
If SQLCA.SQLCODE < 0 Then
	Rollback;
  	messagebox("Error","Problemas al actualizar tabla in_item "+sqlca.sqlerrtext)
	return -1
Else
w_marco.SetMicroHelp("Poniendo claves en Tabla de Items...")

Execute Immediate "ALTER TABLE DINAMIC.FA_DETVE ENABLE CONSTRAINT FK_ITEM_FACTURA";
Execute Immediate "ALTER TABLE DINAMIC.IN_DESCITEM ENABLE CONSTRAINT FK_DESCUENTO_POR_ITEM_2";
Execute Immediate "ALTER TABLE DINAMIC.IN_DETTRANS ENABLE CONSTRAINT FK_ITEM_TRANSFERENCIA";
Execute Immediate "ALTER TABLE DINAMIC.IN_HOJTEC ENABLE CONSTRAINT FK_ITEM_HOJA_TECNICA";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITEDET ENABLE CONSTRAINT FK_IN_ITEDET_IN_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITEEMP ENABLE CONSTRAINT FK_IN_ITEEMP_IN_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITEPRO ENABLE CONSTRAINT FK_ITEM_PROVEEDOR";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITESUCUR ENABLE CONSTRAINT FK_ITEM_SUCURSAL_1";
Execute Immediate "ALTER TABLE DINAMIC.IN_ITETAR ENABLE CONSTRAINT FK_ITETAR_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_MOVIM ENABLE CONSTRAINT FP_IN_MOVIM_IN_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_PREPARADO ENABLE CONSTRAINT FK_ITEM_PREPARADO";
Execute Immediate "ALTER TABLE DINAMIC.IN_PREPARADO ENABLE CONSTRAINT FK_PREPARACION_ITEMS";
Execute Immediate "ALTER TABLE DINAMIC.IN_RELITEM DISABLE CONSTRAINT FK_ITEM_RELACION_ITEM";
Execute Immediate "ALTER TABLE DINAMIC.IN_RELITEM DISABLE CONSTRAINT FK_ITEM_RELACION_ITEM_1";


commit;
w_marco.SetMicroHelp("Tabla de Items Actualizada.")
End if

w_marco.SetMicroHelp("Paso 4 de 8.  Actualizando tabla de Kits...")
dw_3.ImportFile('c:\libiak\Archivos\Relitem.TXT')
dw_3.Update()
If SQLCA.SQLCODE < 0 Then
	Rollback;	
  	messagebox("Error","Problemas al actualizar tabla in_relitem "+sqlca.sqlerrtext)
	return -1
Else
w_marco.SetMicroHelp("Tabla de Kits Actualizada.")
End if

select it_codigo
into:ls_codigo
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_kit = 'S'
minus
select it_codigo1
from in_relitem
where em_codigo = :str_appgeninfo.empresa
and tr_codigo = '1';

if sqlca.sqlcode <> 100 Then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las tablas in_item e in_relitem no concuerdan en cantidad...<Favor comunicar a sistemas>")
End if

select it_codigo1
into:ls_codigo
from in_relitem
where em_codigo = :str_appgeninfo.empresa
and tr_codigo = '1'
minus
select it_codigo
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_kit = 'S';

if sqlca.sqlcode <> 100 Then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las tablas in_relitem e in_Item no concuerdan en cantidad...<Favor comunicar a sistemas>")
End if


w_marco.SetMicroHelp("Paso 5 de 8.  Actualizando tabla de Tipos de Descuentos...")
dw_1.ImportFile('c:\libiak\Archivos\Tippre.TXT')
dw_1.Update()
If SQLCA.SQLCODE < 0 Then
  	messagebox("Error","Problemas al actualizar tabla in_tippre "+sqlca.sqlerrtext)
	Rollback;
	return -1
Else
Execute Immediate "ALTER TABLE DINAMIC.IN_DESCITEM ENABLE CONSTRAINT FK_DESCUENTO_POR_ITEM_1";
w_marco.SetMicroHelp("Tabla de Tipos de Descuentos Actualizada.")
End if


w_marco.SetMicroHelp("Paso 6 de 8.  Actualizando tabla Descuentos por Item...")
dw_2.ImportFile('c:\libiak\Archivos\Descitem.TXT')
dw_2.Update()
If SQLCA.SQLCODE < 0 Then
  	messagebox("Error","Problemas al actualizar tabla in_descitem "+sqlca.sqlerrtext)
	Rollback;
	return -1
Else
commit;
w_marco.SetMicroHelp("Tabla de Descuentos por Item Actualizada.")
End if

w_marco.SetMicroHelp("Paso 7 de 8.  Insertando nuevos items en Sucursal...")  
insert into in_itesucur (it_codigo,em_codigo,su_codigo,it_stkini,it_stkreal,it_stock,it_stkdis,it_cosult,it_recargo)
select it_codigo,em_codigo,:str_appgeninfo.sucursal,0,0,0,0,0,0
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codigo in (select it_codigo
					  from in_item
					  where em_codigo = :str_appgeninfo.empresa
					  minus
					  select it_codigo
					  from in_itesucur
					  where em_codigo = :str_appgeninfo.empresa
					  and su_codigo = :str_appgeninfo.sucursal);
If SQLCA.SQLCODE < 0 Then
  	messagebox("Error","Problemas al actualizar tabla in_itesucur "+sqlca.sqlerrtext)
	Rollback;
	return -1
Else
w_marco.SetMicroHelp("Tabla de Items en Sucursal Actualizada.")
End if

w_marco.SetMicroHelp("Paso 8 de 8.  Insertando nuevos items en Secciones...")  
insert into in_itebod(it_codigo,em_codigo,su_codigo,bo_codigo,ib_stock,ib_stkini,ib_fecini,ib_fecusa,ib_fecuig,ib_ubica,
						  ib_reorden,ib_stkmax,ib_stkmin)
select it_codigo,em_codigo,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,0,0,sysdate,null,null,null,0,0,0
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codigo in ( select it_codigo
					   from in_item
				       where em_codigo = :str_appgeninfo.empresa
				       minus
				       select it_codigo
				       from in_itebod
			           where em_codigo = :str_appgeninfo.empresa
			           and su_codigo = :str_appgeninfo.sucursal
			           and bo_codigo = :str_appgeninfo.seccion);
If SQLCA.SQLCODE < 0 Then
  	messagebox("Error","Problemas al actualizar tabla in_itebod "+sqlca.sqlerrtext)
	Rollback;
	return -1
Else
w_marco.SetMicroHelp("Tabla de Items en Secci$$HEX1$$f300$$ENDHEX$$n Actualizada.")
End if

//w_marco.SetMicroHelp("Paso 8 de 8.  Poniendo recargos de sucursal")  
//  DECLARE RECARGO CURSOR FOR  
//  SELECT "IN_ITESUCUR"."IT_CODIGO",   
//               "IN_ITESUCUR"."IT_RECARGO"  
//    FROM "IN_ITESUCUR"  
//   WHERE ( "IN_ITESUCUR"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
//         ( "IN_ITESUCUR"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
//         ( "IN_ITESUCUR"."IT_RECARGO" > 0 );
//
//	Open RECARGO;
//	Fetch RECARGO into:ls_item,:ld_recargo;
//	Do While sqlca.sqlcode  = 0
//		Update "IN_ITEM"
//		Set      "IN_ITEM"."IT_PRECIO" = "IN_ITEM"."IT_PRECIO" +:ld_recargo,
//		            "IN_ITEM"."IT_PREFAB" = "IN_ITEM"."IT_PREFAB" +:ld_recargo
//		where   "IN_ITEM"."IT_CODIGO" = :ls_item
//		and       "IN_ITEM"."EM_CODIGO" = :str_appgeninfo.empresa;
//		
//		
//		If SQLCA.SQLCODE < 0 &
//		Then
//		Rollback;
//		Exit
//		End if
//		Fetch RECARGO into  :ls_item,:ld_recargo;
//	Loop	
//Close RECARGO;	
//w_marco.SetMicroHelp("Tabla de Recargos en Sucursal Actualizada.")
//
commit;
Close(parent)
w_marco.SetMicroHelp("Proceso Terminado")

end event

type dw_response from w_response_basic`dw_response within w_actualiza_items
boolean visible = false
integer x = 142
integer y = 536
integer width = 242
integer height = 72
boolean enabled = false
string dataobject = "d_in_item"
end type

type st_1 from statictext within w_actualiza_items
integer x = 261
integer y = 64
integer width = 1445
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 81324524
boolean enabled = false
string text = "Cu$$HEX1$$e100$$ENDHEX$$l proceso de actualizaci$$HEX1$$f300$$ENDHEX$$n desea ejecutar?"
boolean focusrectangle = false
end type

type p_1 from picture within w_actualiza_items
integer x = 59
integer y = 48
integer width = 169
integer height = 144
boolean bringtotop = true
string picturename = "Imagenes\Question.Gif"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_actualiza_items
boolean visible = false
integer x = 421
integer y = 536
integer width = 242
integer height = 72
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_in_tippre"
boolean border = false
boolean livescroll = true
end type

type dw_2 from datawindow within w_actualiza_items
boolean visible = false
integer x = 699
integer y = 536
integer width = 242
integer height = 72
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_in_descitem"
boolean border = false
boolean livescroll = true
end type

type dw_3 from datawindow within w_actualiza_items
boolean visible = false
integer x = 987
integer y = 536
integer width = 242
integer height = 72
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_in_relitem"
boolean border = false
end type

type cb_1 from commandbutton within w_actualiza_items
integer x = 274
integer y = 316
integer width = 832
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&A$$HEX1$$f100$$ENDHEX$$adir nuevos Items"
end type

event clicked;long ll_i,ll_filas
string ls_item
decimal  ld_recargo

setpointer(hourglass!)


w_marco.SetMicroHelp("Paso 1 de 3. Insertando nuevos items en Sucursal...")  
insert into in_itesucur (it_codigo,em_codigo,su_codigo,it_stkini,it_stkreal,it_stock,it_stkdis,it_cosult,it_recargo)
select it_codigo,em_codigo,:str_appgeninfo.sucursal,0,0,0,0,0,0
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codigo in (select it_codigo
					  from in_item
					  where em_codigo = :str_appgeninfo.empresa
					  minus
					  select it_codigo
					  from in_itesucur
					  where em_codigo = :str_appgeninfo.empresa
					  and su_codigo = :str_appgeninfo.sucursal);
If SQLCA.SQLCODE < 0 Then
  	messagebox("Error","Problemas al actualizar tabla in_itesucur "+sqlca.sqlerrtext)
	Rollback;
	return -1
Else
w_marco.SetMicroHelp("Tabla de Items en Sucursal Actualizada.")
End if

w_marco.SetMicroHelp("Paso 2 de 3. Insertando nuevos items en Secciones...")  
insert into in_itebod(it_codigo,em_codigo,su_codigo,bo_codigo,ib_stock,ib_stkini,ib_fecini,ib_fecusa,ib_fecuig,ib_ubica,
						  ib_reorden,ib_stkmax,ib_stkmin)
select it_codigo,em_codigo,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,0,0,sysdate,null,null,null,0,0,0
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_codigo in ( select it_codigo
					   from in_item
				       where em_codigo = :str_appgeninfo.empresa
				       minus
				       select it_codigo
				       from in_itebod
			           where em_codigo = :str_appgeninfo.empresa
			           and su_codigo = :str_appgeninfo.sucursal
			           and bo_codigo = :str_appgeninfo.seccion);
If SQLCA.SQLCODE < 0 Then
  	messagebox("Error","Problemas al actualizar tabla in_itebod "+sqlca.sqlerrtext)
	Rollback;
	return -1
Else
w_marco.SetMicroHelp("Tabla de Items en Secci$$HEX1$$f300$$ENDHEX$$n Actualizada.")
End if

w_marco.SetMicroHelp("Paso 3 de 3. Poniendo recargos de sucursal")  
  DECLARE RECARGO CURSOR FOR  
  SELECT "IN_ITESUCUR"."IT_CODIGO",   
               "IN_ITESUCUR"."IT_RECARGO"  
    FROM "IN_ITESUCUR"  
   WHERE ( "IN_ITESUCUR"."EM_CODIGO" = :str_appgeninfo.empresa ) AND  
         ( "IN_ITESUCUR"."SU_CODIGO" = :str_appgeninfo.sucursal ) AND  
         ( "IN_ITESUCUR"."IT_RECARGO" > 0 );

	Open RECARGO;
	Fetch RECARGO into:ls_item,:ld_recargo;
	Do While sqlca.sqlcode  = 0
		Update "IN_ITEM"
		Set      "IN_ITEM"."IT_PRECIO" = "IN_ITEM"."IT_PRECIO" +:ld_recargo,
		            "IN_ITEM"."IT_PREFAB" = "IN_ITEM"."IT_PREFAB" +:ld_recargo
		where   "IN_ITEM"."IT_CODIGO" = :ls_item
		and       "IN_ITEM"."EM_CODIGO" = :str_appgeninfo.empresa;
		
		
		If SQLCA.SQLCODE < 0 &
		Then
		Rollback;
		Exit
		End if
		Fetch RECARGO into  :ls_item,:ld_recargo;
	Loop	
Close RECARGO;	
w_marco.SetMicroHelp("Tabla de Recargos en Sucursal Actualizada.")

commit;
Close(parent)
w_marco.SetMicroHelp("Proceso Terminado")

end event

type dw_4 from datawindow within w_actualiza_items
boolean visible = false
integer x = 1307
integer y = 536
integer width = 242
integer height = 72
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_in_fabricante"
boolean border = false
boolean livescroll = true
end type


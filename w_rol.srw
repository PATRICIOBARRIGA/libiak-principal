HA$PBExportHeader$w_rol.srw
forward
global type w_rol from w_sheet_1_dw_maint
end type
end forward

global type w_rol from w_sheet_1_dw_maint
int Width=1157
int Height=929
boolean TitleBar=true
string Title="Roles del Sistema"
long BackColor=1090519039
end type
global w_rol w_rol

on w_rol.create
call w_sheet_1_dw_maint::create
end on

on w_rol.destroy
call w_sheet_1_dw_maint::destroy
end on

event ue_update;dwItemStatus  ls_status
string  ls_rol,ls_codigo_menu,ls_codrol
integer  li_i,i=0, li_i1
boolean lb_bandera = false 
codigos roles[]


declare detalle cursor for
  select mn_codigo
    from sg_menu;

declare detalle1 cursor for
select rs_nombre
from sg_rol;

open detalle1;
 	if sqlca.sqlcode <> 0 then
		MessageBox("ERROR","No se grabo el ajuste. Por favor avise a sistemas")
   else
     i=0
     do
       fetch detalle1 into :ls_codrol;
       if sqlca.sqlcode <> 0 then exit
       i= i+1
       roles[i].codigo = ls_codrol    
       loop while TRUE;
     end if
close detalle1;

call super::ue_update
setpointer(hourglass!)
for li_i = 1 to dw_datos.RowCount()
	ls_status = dw_datos.GetItemStatus(li_i,"rs_nombre",Primary!)
	ls_rol = dw_datos.GetItemString(li_i,"rs_nombre")      
	lb_bandera = true
	for li_i1 = 1 to i
		if roles[li_i1].codigo = ls_rol  then
			lb_bandera = false
		end if
	next
	if lb_bandera then
/*	if ls_status = New! then*/
open detalle; 
if sqlca.sqlcode <> 0 then
		MessageBox("ERROR","Por favor avise a sistemas")
   else
		do
	     fetch detalle into :ls_codigo_menu;
	       if sqlca.sqlcode <> 0 then exit
          INSERT INTO "SG_ROLMENU"  
                    ( "MN_CODIGO",   
                      "RS_NOMBRE",   
                      "RM_HABILITADO" )  
          VALUES ( :ls_codigo_menu,   
                   :ls_rol,   
                   'S' );
          loop while TRUE;
		end if
      close detalle;
		
/* insert into sg_rolmenu(mn_codigo,rs_nombre,rm_habilitado)
		select mn_codigo,:ls_rol,'S'
		  from sg_menu;*/
	end if
next
if sqlca.sqlcode <> 0 then 
  MessageBox("ERROR", "no se actualizo  men$$HEX1$$fa00$$ENDHEX$$")
  rollback;
else
  commit;
end if

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_rol
int Y=1
int Width=1121
string DataObject="d_rol"
end type

event dw_datos::ue_predelete;decimal lc_pedido, ld_total
int     li_fila,net
string  ls_nombre


li_fila = this.getrow()

ls_nombre = this.getitemstring(li_fila,'rs_nombre')

long Distance = 3.457

 SELECT count(*)  
  INTO :ld_total
   FROM "SG_ACCESO"  
  WHERE ( "SG_ACCESO"."RS_NOMBRE" = :ls_nombre)   ;

if ld_total > 0 then
	MessageBox("Error ","No se puede borrar esisten usuarios asociados al rol ")
   return
end if	

Net = MessageBox("Leame ","Esta seguro que desea borrar el rol",Exclamation!, OKCancel!, 2)
IF Net = 1 THEN 
   DELETE FROM "SG_ROLMENU"  
         WHERE "SG_ROLMENU"."RS_NOMBRE" = :ls_nombre   ;
   commit;
   call super:: ue_predelete
 // Process OK.
END IF



	 

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_rol
boolean BringToTop=true
end type


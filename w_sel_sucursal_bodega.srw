HA$PBExportHeader$w_sel_sucursal_bodega.srw
forward
global type w_sel_sucursal_bodega from window
end type
type dw_1 from datawindow within w_sel_sucursal_bodega
end type
end forward

global type w_sel_sucursal_bodega from window
integer width = 1637
integer height = 728
boolean titlebar = true
string title = "Sucursales y Bodegas de la empresa"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_sel_sucursal_bodega w_sel_sucursal_bodega

event open;Datawindowchild ldwc_aux	
long ll_newRow
long ll_aux

ll_newRow = dw_1.insertRow(1)
if ll_newRow < 1 then
	messageBox("Error Fatal", "No se puede insertar una fila en la ventana de datos", StopSign!)
	setNull(ll_aux)
	closeWithReturn(this, ll_aux)
end if


dw_1.GetChild("sucursal",ldwc_aux)
ldwc_aux.SetTransObject(sqlca)
ldwc_aux.retrieve(str_appgeninfo.empresa)

dw_1.GetChild("bodega",ldwc_aux)
ldwc_aux.SetTransObject(sqlca)
ldwc_aux.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
end event

on w_sel_sucursal_bodega.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_sel_sucursal_bodega.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_sel_sucursal_bodega
integer x = 27
integer y = 96
integer width = 1550
integer height = 476
integer taborder = 10
string title = "none"
string dataobject = "d_sel_sucursal_bodega"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;string ls_sucursal,ls_bodega
long ll_row
String    ls_Object



 

 ls_Object = String(dwo.name)

if ls_Object = 'b_1' then
ll_row = dw_1.getrow()
ls_sucursal = dw_1.GetItemString(ll_row,"sucursal")
ls_bodega = dw_1.GetItemString(ll_row,"bodega")

str_appgeninfo.sucursal = ls_sucursal
str_appgeninfo.seccion = ls_bodega

select em_nombre
into:gs_empresa
from pr_empre
where em_codigo = :str_appgeninfo.empresa;

 select su_nombre
  into :gs_su_nombre
  from pr_sucur
 where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :str_appgeninfo.sucursal;
	
select bo_nombre
  into :gs_bo_nombre
  from in_bode
 where em_codigo = :str_appgeninfo.empresa
   and su_codigo = :str_appgeninfo.sucursal
   and bo_codigo = :str_appgeninfo.seccion;


w_marco.title = gs_titulo_marco + "         " +gs_empresa+"/"+ gs_su_nombre + "/" + gs_bo_nombre+"/"+&
					str_appgeninfo.caja+" "+str_appgeninfo.departamento+"   "+gs_empleado

close(parent)
end if

if ls_Object = 'b_2' then
close(parent)
end if
end event

event itemchanged;DataWindowChild	ldwc_aux
string    			ls_colname,ls_sucursal,ls_filtro

ls_colname = dw_1.GetColumnName()
choose case ls_colname
	case "sucursal"
		ls_sucursal = dw_1.GetText()
		dw_1.GetChild("bodega",ldwc_aux)
		ldwc_aux.SetTransObject(sqlca)
		ls_filtro = "su_codigo = "+"'"+ls_sucursal+"'"
		ldwc_aux.SetFilter(ls_filtro)
		ldwc_aux.Filter()
//		ldwc_aux.Retrieve(str_appgeninfo.empresa,ls_sucursal)
end choose	
end event


HA$PBExportHeader$w_hoja_tecnica.srw
$PBExportComments$Si.Ingreso de la hoja t$$HEX1$$e900$$ENDHEX$$cnica.
forward
global type w_hoja_tecnica from w_sheet_master_detail
end type
end forward

global type w_hoja_tecnica from w_sheet_master_detail
integer width = 3154
integer height = 1504
string title = "Hoja T$$HEX1$$e900$$ENDHEX$$cnica"
long backcolor = 1090519039
end type
global w_hoja_tecnica w_hoja_tecnica

type variables
string is_empresa, is_mensaje
end variables

on w_hoja_tecnica.create
call super::create
end on

on w_hoja_tecnica.destroy
call super::destroy
end on

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
// recupera dddw
f_recupera_empresa(dw_master,"ma_codigo")
f_recupera_empresa(dw_detail,"lh_codigo")

call super::open
dw_master.is_SerialCodeColumn = "ht_codhoja"
dw_master.is_SerialCodeType = "HOJA_TEC"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa

//dw_detail.is_serialCodeDetail = "hi_codigo"

dw_master.ii_nrCols = 2
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "ht_codhoja"
dw_detail.is_connectionCols[1] = "em_codigo"
dw_detail.is_connectionCols[2] = "ht_codhoja"
dw_detail.uf_setArgTypes()


//Si quiero que se llene al arrancar el maestro y el detalle
//dw_master.uf_retrieve()

dw_master.uf_insertCurrentRow()
dw_master.setFocus()
end event

event close;call super::close;//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = false
end event

event ue_insert;call super::ue_insert;str_prodparam.fila = dw_detail.GetRow()
end event

type dw_master from w_sheet_master_detail`dw_master within w_hoja_tecnica
integer x = 0
integer y = 0
integer width = 3118
integer height = 136
string dataobject = "d_ingreso_cab_hoja_tecnica"
end type

event dw_master::itemchanged;call super::itemchanged;long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
string ls, ls_pepa, ls_nombre, ls_null, ls_codant, ls_codigo

ll_filact = this.getRow()
str_prodparam.fila = ll_filact
choose case this.getcolumnname()
CASE 'codant'
	ls = this.gettext()

	// con este voy a buscar
	//primero por codigo anterior
	 select it_codigo, it_nombre
		into :ls_pepa, :ls_nombre
		from in_item
	  where em_codigo = :str_appgeninfo.empresa
	    and it_codant = :ls;
   if sqlca.sqlcode <> 0 then
	 //luego por codigo de barras
	 select it_codigo, it_codant, it_nombre
		into :ls_pepa, :ls_codant, :ls_nombre
		from in_item
	  where em_codigo = :str_appgeninfo.empresa
	    and it_codbar = :ls;
     if sqlca.sqlcode <> 0 then
		setnull(ls_null)
		this.SetItem(ll_filact,"codant",ls_null)
		beep(1)
		is_mensaje = "No existe c$$HEX1$$f300$$ENDHEX$$digo de producto"
		return 1
	  else
		this.SetItem(ll_filact,"codant",ls_codant)
	end if	 
 end if 
this.setitem(ll_filact, 'nombre',ls_nombre)
this.setitem(ll_filact, 'it_codigo', ls_pepa)
END CHOOSE
this.setitem(ll_filact, 'em_codigo', str_appgeninfo.empresa)
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_hoja_tecnica
integer x = 0
integer y = 136
integer width = 3118
integer height = 1268
string dataobject = "d_ingreso_items_hoja_tecnica"
end type

event dw_detail::clicked;call super::clicked;
//m_marco.m_opcion1.m_producto.m_buscarproducto2.enabled = true
str_prodparam.ventana = parent
str_prodparam.datawindow = this
str_prodparam.fila = dw_detail.GetRow() 

end event

type dw_report from w_sheet_master_detail`dw_report within w_hoja_tecnica
boolean bringtotop = true
end type


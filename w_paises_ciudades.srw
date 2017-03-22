HA$PBExportHeader$w_paises_ciudades.srw
forward
global type w_paises_ciudades from w_sheet_master_detail
end type
end forward

global type w_paises_ciudades from w_sheet_master_detail
integer width = 1856
integer height = 1728
string title = "Paises y Ciudades"
long backcolor = 1090519039
end type
global w_paises_ciudades w_paises_ciudades

on w_paises_ciudades.create
call super::create
end on

on w_paises_ciudades.destroy
call super::destroy
end on

event open;call super::open;dw_master.is_SerialCodeCompany = str_appgeninfo.empresa
dw_master.is_SerialCodeColumn = "pa_codigo"
dw_master.is_SerialCodeType = "COD_PAIS"
dw_detail.is_serialCodeDetail = "cu_codigo"


dw_master.ii_nrCols = 1
dw_master.is_connectionCols[1] = "pa_codigo"
dw_detail.is_connectionCols[1] = "pa_codigo"
dw_detail.uf_setArgTypes()


//Si quiero que se llene al arrancar el maestro y el detalle
dw_master.uf_retrieve()

//dw_master.uf_insertCurrentRow()
dw_master.setFocus()
end event

type dw_master from w_sheet_master_detail`dw_master within w_paises_ciudades
integer x = 0
integer y = 0
integer width = 1819
integer height = 640
string title = "Pais"
string dataobject = "d_pais"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_master::rowfocuschanged;call super::rowfocuschanged;this.SetRowFocusIndicator(hand!)
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_paises_ciudades
integer x = 0
integer y = 644
integer width = 1829
integer height = 980
string title = "Ciudad"
string dataobject = "d_ciudad"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_report from w_sheet_master_detail`dw_report within w_paises_ciudades
integer x = 41
integer y = 792
integer height = 216
boolean bringtotop = true
end type


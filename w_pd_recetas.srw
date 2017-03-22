HA$PBExportHeader$w_pd_recetas.srw
forward
global type w_pd_recetas from w_sheet_master_detail
end type
type st_1 from statictext within w_pd_recetas
end type
type st_2 from statictext within w_pd_recetas
end type
type st_3 from statictext within w_pd_recetas
end type
type shl_1 from statichyperlink within w_pd_recetas
end type
end forward

global type w_pd_recetas from w_sheet_master_detail
integer width = 4416
integer height = 2608
string title = "FORMULACIONES"
st_1 st_1
st_2 st_2
st_3 st_3
shl_1 shl_1
end type
global w_pd_recetas w_pd_recetas

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();
String ls_pepa
ls_pepa = dw_master.Object.it_codigo[dw_master.getrow()]
dw_report.retrieve(ls_pepa,'F')
return 1
end function

on w_pd_recetas.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.shl_1=create shl_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.shl_1
end on

on w_pd_recetas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.shl_1)
end on

event open;call super::open;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : Llena las estructuras para trabajar maestro detalle
//               y para recuperar autom$$HEX1$$e100$$ENDHEX$$ticamente el secuencial de la
// orden de compra
////////////////////////////////////////////////////////////////////////

//string ls_parametro[]

//f_recupera_empresa(dw_master,"pv_codigo") 
//ls_parametro[1] = str_appgeninfo.empresa
//ls_parametro[1] = str_appgeninfo.sucursal
//ls_parametro[2] = '1' // 1 es ORDEN DE COMPRA
//f_recupera_datos(dw_master,"co_numpad", ls_parametro,2)


f_recupera_empresa(dw_master,"it_codant")
f_recupera_empresa(dw_master,"it_codant_1")

f_recupera_empresa(dw_detail,"it_codant")
f_recupera_empresa(dw_detail,"it_codant_1")


istr_argInformation.nrArgs = 4
istr_argInformation.argType[1] = "string"
istr_argInformation.argType[2] = "string"
istr_argInformation.argType[3] = "string"
istr_argInformation.argType[4] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa
istr_argInformation.StringValue[2] = str_appgeninfo.sucursal
istr_argInformation.StringValue[3] = str_appgeninfo.seccion
istr_argInformation.StringValue[4] = 'F'
dw_detail.setrowfocusindicator(hand!)









call super::open
dw_master.is_SerialCodeColumn = "rt_codigo"
dw_master.is_SerialCodeType = "NUM_RTA"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa
//dw_detail.is_serialCodeDetail = "rq_secue"
//dw_detailr.is_SerialCodeType = "NUM_RTA"

// columnas de conecci$$HEX1$$f300$$ENDHEX$$n
dw_master.ii_nrCols = 1
dw_master.is_connectionCols[1] = "rt_codigo"
//dw_master.is_connectionCols[2] = "su_codigo"
//dw_master.is_connectionCols[3] = "ec_codigo"
//dw_master.is_connectionCols[4] = "co_numero"
dw_detail.is_connectionCols[1] = "rt_codigo"
//dw_detail.is_connectionCols[2] = "su_codigo"
//dw_detail.is_connectionCols[3] = "ec_codigo"
//dw_detail.is_connectionCols[4] = "co_numero"
dw_detail.uf_setArgTypes()

//dw_movim.settransobject(sqlca)
//Si quiero que se llene al arrancar el maestro y el detalle
dw_master.uf_retrieve()

//dw_master.uf_insertCurrentRow()
dw_master.setFocus()
dw_master.object.t_4.visible = false
dw_report.SetTransObject(sqlca)

end event

event resize;return 1
end event

type dw_master from w_sheet_master_detail`dw_master within w_pd_recetas
integer y = 96
integer width = 4306
integer height = 804
string dataobject = "d_cab_receta"
boolean hscrollbar = false
borderstyle borderstyle = stylebox!
end type

event dw_master::itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : En el detalle al ingresar el c$$HEX1$$f300$$ENDHEX$$digo del item recupera
//               datos relacionados y los inserta en el detalle, controla
// que la cantidad no se anegativa
////////////////////////////////////////////////////////////////////////

long ll_filact,ll_itemact,ll_fila,ll_filActMaster,ll_totFilas
long ll_unidad,ll_clase,ll_cta,ll_cod
decimal ll_valortot,ll_valor,ll_valorsum,ld_area, ll_ivavalor
decimal ll_subtot,ll_reten,ll_suma, ld_canti,ll_suma1,ld_null
char lch_kit
decimal ld_area_pedida ,lc_costo_item, lc_costo,lc_desc1,lc_desc2,lc_desc3
string ls, ls_pepa, ls_nombre, ls_null, ls_codant, ls_codigo,ls_prove

ll_filact = this.getRow()
str_prodparam.fila = ll_filact
ll_filActMaster = dw_master.getRow()

//ls_prove = dw_master.GetitemString(ll_filActMaster,"pv_codigo")

CHOOSE CASE This.GetColumnName()
case 'it_codant' 
	ls = this.gettext()
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo, it_nombre,it_kit,it_costo
	into :ls_pepa, :ls_nombre,:lch_kit,:lc_costo_item
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls;
   
	if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
	 	select it_codigo, it_codant, it_nombre,it_kit,nvl(it_costo,0)
		into :ls_pepa, :ls_codant, :ls_nombre,:lch_kit, :lc_costo_item
		from in_item
	  	where em_codigo = :str_appgeninfo.empresa
	     and it_codbar = :ls;
     	
		if sqlca.sqlcode <> 0 then
			setnull(ls_null)
			setnull(ld_null)
			this.SetItem(ll_filact,"it_codant",ls_null)
			this.setitem(ll_filact, "rt_cantid",ld_null)
			this.setitem(ll_filact, "it_nombre",ls_null)
			this.setitem(ll_filact, "it_codigo",ls_null)
			beep(1)
			return 1
		else
			this.SetItem(ll_filact,"it_codant",ls_codant)
		end if	 
 	end if
			
	
	this.setitem(ll_filact, 'it_nombre',ls_nombre)
	this.setitem(ll_filact, 'it_codigo',ls_pepa)


End choose
end event

event dw_master::updatestart;call super::updatestart;// ESTADO = 'C'  COMPONENTE
 //ESTADO = 'F' FORMULACION     


this.object.em_codigo[this.getrow()] = str_appgeninfo.empresa
this.object.su_codigo[this.getrow()]= str_appgeninfo.sucursal
this.object.bo_codigo[this.getrow()] = str_appgeninfo.seccion
this.object.estado[this.getrow()] = 'F'
return 0

end event

event dw_master::rowfocuschanged;call super::rowfocuschanged;SetRowfocusIndicator(hand!)
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_pd_recetas
integer x = 41
integer y = 984
integer width = 4306
integer height = 1484
string dataobject = "d_pd_detreceta"
borderstyle borderstyle = stylebox!
end type

event dw_detail::itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : En el detalle al ingresar el c$$HEX1$$f300$$ENDHEX$$digo del item recupera
//               datos relacionados y los inserta en el detalle, controla
// que la cantidad no se anegativa
////////////////////////////////////////////////////////////////////////


decimal lc_costo_item,ld_null
char lch_kit
string ls, ls_pepa, ls_nombre, ls_null, ls_codant



//ls_prove = dw_master.GetitemString(rowMaster,"pv_codigo")

CHOOSE CASE This.GetColumnName()
case 'it_codant' 
	ls = this.gettext()
	// con este voy a buscar
	//primero por codigo anterior
	select it_codigo, it_nombre,it_kit,it_costo
	into :ls_pepa, :ls_nombre,:lch_kit,:lc_costo_item
	from in_item
	where em_codigo = :str_appgeninfo.empresa
	and it_codant = :ls;
   
	if sqlca.sqlcode <> 0 then
		//luego por codigo de barras
	 	select it_codigo, it_codant, it_nombre,it_kit,nvl(it_costo,0)
		into :ls_pepa, :ls_codant, :ls_nombre,:lch_kit, :lc_costo_item
		from in_item
	  	where em_codigo = :str_appgeninfo.empresa
	       and it_codbar = :ls;
     	
		if sqlca.sqlcode <> 0 then
			setnull(ls_null)
			setnull(ld_null)
			this.SetItem(row,"it_codant",ls_null)
			this.setitem(row, 'rq_cantid',ld_null)
			this.setitem(row, 'it_nombre',ls_null)
			this.setitem(row, 'it_codigo1',ls_null)
			beep(1)
			return 1
		else
			this.SetItem(row,"it_codant",ls_codant)
		end if	 
 	end if
			
	// inserta datos en el detalle, dw_detail
	
//	select  nvl(ip_plista,0),nvl(ip_desc1,0),nvl(ip_desc2,0),nvl(ip_desc3,0)
//	into  :lc_costo,:lc_desc1,:lc_desc2,:lc_desc3
//	from    in_itepro
//	where em_codigo = :str_appgeninfo.empresa
//     and      it_codigo = :ls_pepa
//	and      pv_codigo = :ls_prove; 
//	
//	if sqlca.sqlcode <> 0 then
//		lc_costo = lc_costo_item
//		lc_desc1 = 0
//		lc_desc2 = 0
//		lc_desc3 = 0
//	end if
//	
	this.setitem(row, 'it_nombre',ls_nombre)
	this.setitem(row, 'it_codigo1',ls_pepa)


End choose
end event

event dw_detail::updatestart;int i

for i = 1 to this.rowcount()
this.object.rt_codigo[i] = dw_master.Object.rt_codigo[dw_master.getrow()]
this.object.rq_secue[i] = i
next

return 0
end event

type dw_report from w_sheet_master_detail`dw_report within w_pd_recetas
integer x = 37
integer y = 88
string dataobject = "d_prn_formulacion"
end type

type st_1 from statictext within w_pd_recetas
integer x = 41
integer y = 916
integer width = 302
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
string text = "Ingredientes"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pd_recetas
integer x = 41
integer y = 24
integer width = 539
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
string text = "Productos con f$$HEX1$$f300$$ENDHEX$$rmula"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pd_recetas
integer x = 3058
integer y = 912
integer width = 658
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
string text = "Calcular formulaci$$HEX1$$f300$$ENDHEX$$n m$$HEX1$$ed00$$ENDHEX$$nima."
boolean focusrectangle = false
end type

event clicked;//C$$HEX1$$e100$$ENDHEX$$lculo de la producci$$HEX1$$f300$$ENDHEX$$n m$$HEX1$$ed00$$ENDHEX$$nima para el producto seleccionado
Decimal{4} lc_cantidad_a_producir
Long ll_row,i


ll_row= dw_master.getrow()
if ll_row = 0  then return

lc_cantidad_a_producir = dw_master.Object.rt_cantid[ll_row]


if lc_cantidad_a_producir = 0 then return

for i = 1 to dw_detail.Rowcount()
	dw_detail.Object.cantmin[i] = dw_detail.Object.rq_cantid[i] / lc_cantidad_a_producir
next
end event

type shl_1 from statichyperlink within w_pd_recetas
integer x = 2437
integer y = 916
integer width = 512
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Copiar cantidad m$$HEX1$$ed00$$ENDHEX$$nima"
boolean focusrectangle = false
end type

event clicked;dw_detail.object.rq_cantid2.primary = dw_detail.object.cantmin.primary
end event


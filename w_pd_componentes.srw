HA$PBExportHeader$w_pd_componentes.srw
$PBExportComments$Componentes que utilizan para el terminado
forward
global type w_pd_componentes from w_sheet_master_detail
end type
type st_1 from statictext within w_pd_componentes
end type
type st_2 from statictext within w_pd_componentes
end type
type dw_1 from datawindow within w_pd_componentes
end type
end forward

global type w_pd_componentes from w_sheet_master_detail
integer width = 3959
integer height = 2420
string title = "COMPOSICIONES"
st_1 st_1
st_2 st_2
dw_1 dw_1
end type
global w_pd_componentes w_pd_componentes

type variables
String is_tiporeceta
end variables

forward prototypes
public function integer wf_preprint ()
end prototypes

public function integer wf_preprint ();String ls_pepa
ls_pepa = dw_master.Object.it_codigo[dw_master.getrow()]
dw_report.retrieve(ls_pepa,'C')
dw_report.modify("t_4.text = 'COMPOSICION PARA: '")
return 1
end function

on w_pd_componentes.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_1
end on

on w_pd_componentes.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_1)
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
istr_argInformation.StringValue[4] = 'C' //COMPONENTES
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
dw_1.SetTransObject(sqlca)
dw_report.SetTransObject(sqlca)
end event

event resize;
int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

//this.setRedraw(False)
//if this.ib_inReportMode then
//	dw_report.resize(li_width - 2*dw_report.x, li_height - 2*dw_report.y)
//else
//	
//	dw_master.resize(li_width/2 - 50, li_height -100)
//	dw_detail.resize(li_width/2 -50, li_height - 100)
//    dw_detail.move(li_width/2, dw_detail.y)
//	st_1.move(li_width/2,st_1.y)
//
//end if	
//this.setRedraw(True)

return 1
end event

type dw_master from w_sheet_master_detail`dw_master within w_pd_componentes
integer y = 116
integer width = 3813
integer height = 1060
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
			this.setitem(ll_filact, 'rq_cantid',ld_null)
			this.setitem(ll_filact, 'it_nombre',ls_null)
			this.setitem(ll_filact, 'it_codigo',ls_null)
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
this.object.estado[this.getrow()] = 'C'
return 0
end event

event dw_master::rowfocuschanged;call super::rowfocuschanged;SetRowfocusIndicator(hand!)
end event

event dw_master::clicked;call super::clicked;String ls_kit
if dwo.name = 't_4' then
	ls_kit = this.object.it_codigo[row]
	dw_1.retrieve(ls_kit)
	dw_1.visible = true
end if
end event

type dw_detail from w_sheet_master_detail`dw_detail within w_pd_componentes
integer x = 37
integer y = 1260
integer width = 3799
integer height = 996
string dataobject = "d_pd_componentes"
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

type dw_report from w_sheet_master_detail`dw_report within w_pd_componentes
integer x = 37
integer y = 88
string dataobject = "d_prn_formulacion"
end type

type st_1 from statictext within w_pd_componentes
integer x = 46
integer y = 1192
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
string text = "Componentes"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pd_componentes
integer x = 46
integer y = 40
integer width = 293
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
string text = "Productos"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_pd_componentes
boolean visible = false
integer x = 357
integer y = 548
integer width = 3973
integer height = 628
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Composici$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_in_relitem"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean livescroll = true
end type

event buttonclicked;//
Long ll_new

ll_new = dw_detail.insertrow(0)
dw_detail.Object.it_codigo1[ll_new] = this.Object.in_relitem_it_codigo1[row]
dw_detail.Object.it_codant[ll_new] = this.Object.in_item_it_codant[row]
dw_detail.Object.it_nombre[ll_new] = this.Object.in_item_it_nombre[row]
dw_detail.Object.rq_cantid[ll_new] = this.Object.ri_cantid[row]
end event


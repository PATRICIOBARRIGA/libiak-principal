HA$PBExportHeader$w_item.srw
$PBExportComments$Si.Mantenimiento del maestro de inventarios
forward
global type w_item from w_sheet_master_tabpage_detail
end type
type dw_ubica from datawindow within w_item
end type
end forward

global type w_item from w_sheet_master_tabpage_detail
integer width = 4101
integer height = 2156
string title = "Productos - Trigger"
dw_ubica dw_ubica
end type
global w_item w_item

type variables

end variables

forward prototypes
public function integer wf_genera_codigo_barras (string tipo)
end prototypes

public function integer wf_genera_codigo_barras (string tipo);long ll_sumimpar, ll_sumpar, ll_sumtot, ll_digit, ll_secue,ll_decena
string ls_codigo, ls,ls_codbarra,ls_pepa

//voy a formar el c$$HEX1$$f300$$ENDHEX$$digo de barras del producto usando EAN-13 O EAN-8


ls_pepa = dw_master.GetitemString(dw_master.GetRow(),"it_codigo")


CHOOSE CASE tipo
	CASE '13'
		//13 DIGITOS: 2 primeros codigo del pais, 10 siguientes datos y 1 digito verificador
		ls_codigo = '0780001' //Ecuador es 78
		//para los datos, utilizo la tabla de par$$HEX1$$e100$$ENDHEX$$metros para saber el codigo interno del producto
CASE '8'
		//13 DIGITOS: 2 primeros codigo del pais, 10 siguientes datos y 1 digito verificador
		ls_codigo = '78' //Ecuador es 78
		//para los datos, utilizo la tabla de par$$HEX1$$e100$$ENDHEX$$metros para saber el codigo interno del producto
END CHOOSE



ls = Fill("0", 5 - len(ls_pepa)) + ls_pepa
ls_codigo += ls

/*Pone el d$$HEX1$$ed00$$ENDHEX$$gito verificador*/
ls_codbarra = ls_codigo
DO WHILE ls_codigo<> "" and not isnull(ls_codigo) 
    ll_sumtot += long(right(ls_codigo,1))*3
	 ls_codigo = mid(ls_codigo,1,len(ls_codigo) - 1)
	 ll_sumtot   += long(right(ls_codigo,1))
 	 ls_codigo = mid(ls_codigo,1,len(ls_codigo) - 1)
LOOP


ll_decena = ceiling(ll_sumtot/10) * 10
ll_digit  =  ll_decena - ll_sumtot
ls_codbarra += string(ll_digit)

dw_master.SetItem(dw_master.GetRow(),'it_codbar',ls_codbarra)

return 1
end function

on w_item.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
end on

on w_item.destroy
call super::destroy
destroy(this.dw_ubica)
end on

event open;dataWindowChild ldwc_aux
string ls_descri

f_recupera_empresa(dw_master,"cl_codigo") 
f_recupera_empresa(dw_master,"co_codigo")
f_recupera_empresa(dw_master,"fb_codigo")
f_recupera_empresa(dw_master,"ma_codigo")
f_recupera_empresa(dw_master,"td_codigo")
f_recupera_empresa(dw_master,"gt_codigo")
f_recupera_empresa(tab_detail.tabpage_detail1.dw_detail1,"su_codigo")
f_recupera_empresa(tab_detail.tabpage_detail2.dw_detail2,"su_codigo")
f_recupera_empresa(tab_detail.tabpage_detail2.dw_detail2,"bo_codigo")
f_recupera_empresa(tab_detail.tabpage_detail3.dw_detail3,"pv_codigo")
f_recupera_empresa(tab_detail.tabpage_detail4.dw_detail4,"td_codigo")

istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

call super::open

dw_master.is_SerialCodeColumn = "it_codigo"
dw_master.is_SerialCodeType = "COD_ITEM"
dw_master.is_serialCodeCompany = str_appgeninfo.empresa

dw_master.ii_nrCols = 2
dw_master.is_connectionCols[1] = "em_codigo"
dw_master.is_connectionCols[2] = "it_codigo"

tab_detail.tabpage_detail1.dw_detail1.is_connectionCols[1] = "em_codigo"
tab_detail.tabpage_detail1.dw_detail1.is_connectionCols[2] = "it_codigo"
tab_detail.tabpage_detail1.dw_detail1.uf_setArgTypes()
tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[1] = "em_codigo"
tab_detail.tabpage_detail2.dw_detail2.is_connectionCols[2] = "it_codigo"
tab_detail.tabpage_detail2.dw_detail2.uf_setArgTypes()
tab_detail.tabpage_detail3.dw_detail3.is_connectionCols[1] = "em_codigo"
tab_detail.tabpage_detail3.dw_detail3.is_connectionCols[2] = "it_codigo"
tab_detail.tabpage_detail3.dw_detail3.uf_setArgTypes()
tab_detail.tabpage_detail4.dw_detail4.is_connectionCols[1] = "em_codigo"
tab_detail.tabpage_detail4.dw_detail4.is_connectionCols[2] = "it_codigo"
tab_detail.tabpage_detail4.dw_detail4.uf_setArgTypes()


//tab_detail.tabpage_detail5.dw_detail5.is_connectionCols[1] = "em_codigo"
//tab_detail.tabpage_detail5.dw_detail5.is_connectionCols[2] = "it_codigo"
//tab_detail.tabpage_detail5.dw_detail5.uf_setArgTypes()


dw_report.SetTransObject(sqlca)
//dw_master.uf_retrieve(istr_argInformation)
//dw_master.uf_insertCurrentRow()
//dw_master.setFocus()

end event

event ue_retrieve;call super::ue_retrieve;/*string ls_parametro[]
f_recupera_empresa(dw_master,"cl_codigo") 
f_recupera_empresa(dw_master,"co_codigo")
f_recupera_empresa(dw_master,"fb_codigo")
f_recupera_empresa(dw_master,"ma_codigo")
f_recupera_empresa(dw_master,"td_codigo")
f_recupera_empresa(tab_detail.tabpage_detail1.dw_detail1,"su_codigo")
f_recupera_empresa(tab_detail.tabpage_detail2.dw_detail2,"su_codigo")
f_recupera_empresa(tab_detail.tabpage_detail3.dw_detail3,"pv_codigo")
ls_parametro[1] = str_appgeninfo.empresa
ls_parametro[2] = str_appgeninfo.sucursal //ecuador por default
f_recupera_datos(tab_detail.tabpage_detail1.dw_detail1,"bo_codigo",ls_parametro,2) */

return 1
end event

event ue_update;call super::ue_update;string ls_cod,ls_codigo,ls_bodega,ls_sucursal,ls_ean,ls_dctocli
int    li_tot, li_nfila
long ll_filmaster
datetime ldt_hoy

setpointer(hourglass!)
ll_filmaster = dw_master.GetRow()
if ll_filmaster < 1 then 
	setpointer(arrow!)
	return
end if


//tab_detail.tabpage_detail1.dw_detail1.retrieve(str_appgeninfo.empresa,ls_codigo)
//tab_detail.tabpage_detail2.dw_detail2.retrieve(str_appgeninfo.empresa,ls_codigo)
//tab_detail.tabpage_detail4.dw_detail4.retrieve(str_appgeninfo.empresa,ls_codigo)		
//	li_nfila = tab_detail.tabpage_detail3.dw_detail3.insertrow(0)
//	tab_detail.tabpage_detail3.dw_detail3.setitem(li_nfila,"it_codigo",ls_codigo)
//	tab_detail.tabpage_detail3.dw_detail3.setitem(li_nfila,"em_codigo",str_appgeninfo.empresa)		
tab_detail.selecttab(1)

w_marco.setmicrohelp("Item guardado con $$HEX1$$e900$$ENDHEX$$xito...")
setpointer(arrow!)


end event

event resize;int li_width, li_height
uo_dw_detail ldw_detail

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_master.resize(li_width - 2*dw_master.x, dw_master.height)
this.setRedraw(True)

end event

event ue_print;long   ll_row
String ls_codant

ll_row = dw_master.getrow()
If ll_row <= 0 then return
ls_codant = dw_master.Object.it_codant[ll_row]
dw_report.retrieve(ls_codant)
call super::ue_print



end event

event ue_insert;Long ll_new

if dw_master.rowcount() >= 0 then
//		dw_master.reset()
		ll_new =  dw_master.insertrow(0)
		dw_master.ScrolltoRow(ll_new)
		dw_master.SetRow(ll_new)
		tab_detail.tabpage_detail1.dw_detail1.reset()
		tab_detail.tabpage_detail2.dw_detail2.reset()
		tab_detail.tabpage_detail3.dw_detail3.reset()
		tab_detail.tabpage_detail4.dw_detail4.reset()
end if	

end event

type dw_master from w_sheet_master_tabpage_detail`dw_master within w_item
event ue_keydown pbm_dwnkey
integer x = 14
integer y = 8
integer width = 4018
integer height = 1112
integer taborder = 10
string dataobject = "d_item"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event dw_master::ue_keydown;call super::ue_keydown;if (KeyDown(KeyF2!)) then
	dw_master.SetFilter('')
	dw_master.Filter()	
	dw_ubica.Reset()
	dw_ubica.InsertRow(0)
	dw_ubica.SetFocus()
	dw_ubica.Visible = true
end if
end event

event dw_master::itemchanged;call super::itemchanged;long ll_filact
ll_filact = this.GetRow()

if ll_filact = 0 then return

this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)

//Recupera datos del modelo


end event

event dw_master::doubleclicked;call super::doubleclicked;dw_master.SetFilter('')
dw_master.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event dw_master::updateend;call super::updateend;// Este evento es reemplazado x el trigger. 14.11.2015
//
////Reubicar este codigo
////String ls_cod,ls_ean
////Long ll_filmaster
//
////ll_filmaster = dw_master.Getrow()
//
////return 0
//
//string ls_cod,ls_codigo,ls_bodega,ls_sucursal,ls_ean,ls_dctocli
//int    li_tot, li_nfila
//long ll_filmaster
//datetime ldt_hoy
//dwitemstatus l_status
//
//setpointer(hourglass!)
//
//ll_filmaster = dw_master.GetRow()
//if ll_filmaster < 1 then 
//	setpointer(arrow!)
//	return
//end if
//
//select sysdate
//into :ldt_hoy
//from dual;
//
//
//ls_cod     = dw_master.GetItemString(ll_filmaster,'it_codbar')
//l_status = dw_master.getitemstatus(ll_filmaster,0,Primary!)
//If l_status = datamodified! then
//	dw_master.setitem(ll_filmaster,"it_feccam",ldt_hoy)
//end if
//
//
//If l_status = new! or l_status = newmodified! then
//	ls_codigo = dw_master.GetItemString(ll_filmaster,'it_codigo')	
//	
//	SELECT COUNT(1)
//	INTO :li_tot
//	FROM IN_DESCITEM
//	WHERE EM_CODIGO = :str_appgeninfo.empresa
//	AND IT_CODIGO = :ls_codigo;
//
//
//	if li_tot = 0 then
//	declare dctocli cursor for
//	select dc_codigo
//	from fa_dctocli;
//	open dctocli;
//	do
//	fetch dctocli into :ls_dctocli;	
//	if sqlca.sqlcode <> 0 then exit
//		INSERT INTO "IN_DESCITEM" ( "TD_CODIGO","EM_CODIGO","IT_CODIGO","ES_CODIGO","DI_VIGENTE")  
//			VALUES ( '0',:str_appgeninfo.empresa,:ls_codigo,:ls_dctocli,'S');
//		  if sqlca.sqlcode <> 0 then
//				rollback;
//				messageBox('Error','No se puede grabar el descuento')
//				return
//		  end if
//	loop while true
//	close dctocli;
//	end if
//	
//	SELECT COUNT(1)
//	INTO :li_tot
//	FROM IN_ITESUCUR
//	WHERE EM_CODIGO = :str_appgeninfo.empresa
//	AND IT_CODIGO = :ls_codigo;
//	
//	if li_tot = 0 then
//		declare sucursal cursor for
//			SELECT su_codigo
//			FROM pr_sucur
//			WHERE em_codigo = :str_appgeninfo.empresa
//			order by to_number(su_codigo);
//			open sucursal;
//			do 
//				fetch sucursal into :ls_sucursal;
//					if sqlca.sqlcode <> 0 then exit
//					  INSERT INTO "IN_ITESUCUR"  ( "IT_CODIGO", "EM_CODIGO","SU_CODIGO", "IT_STKINI", "IT_STKREAL",   
//																	"IT_STOCK", "IT_STKDIS","IT_COSULT","IT_RECARGO","ESTADO" )  
//					  VALUES ( :ls_codigo,:str_appgeninfo.empresa,:ls_sucursal,0,0,0,0,0,0,'N')  ;
//						if sqlca.sqlcode <> 0 then
//							rollback;
//							messageBox('Error','No se puede grabar el nuevo item para las sucursales')
//							return
//						end if			
//			loop while TRUE;
//		close sucursal;
//	end if
//
//
//SELECT COUNT(*)
//INTO :li_tot
//FROM IN_ITEBOD
//WHERE EM_CODIGO = :str_appgeninfo.empresa
//AND IT_CODIGO = :ls_codigo;
//
//if li_tot = 0 then
//
//	DECLARE c1 CURSOR FOR  
//	SELECT su_codigo,bo_codigo  
//	FROM in_bode  
//	WHERE em_codigo = :str_appgeninfo.empresa
//	order by to_number(su_codigo);
//	open c1;
//		do
//			fetch c1 into :ls_sucursal,:ls_bodega;
//				if sqlca.sqlcode <> 0 then exit
//				  INSERT INTO  "IN_ITEBOD" ( "IT_CODIGO","EM_CODIGO","SU_CODIGO","BO_CODIGO","IB_STOCK",   
//															"IB_STKINI","IB_FECINI","IB_FECUSA","IB_FECUIG","IB_UBICA","IB_REORDEN",   
//														"IB_STKMAX","IB_STKMIN","ESTADO" )  
//					  VALUES ( :ls_codigo,:str_appgeninfo.empresa,:ls_sucursal,:ls_bodega,0,
//								0,sysdate,sysdate,sysdate,null,0, 0, 0,'N')  ;
//				if sqlca.sqlcode <> 0 then
//					rollback;
//					messageBox('Error','No se puede grabar el nuevo item para las secciones')
//					return
//				end if			
//		loop while TRUE;
//	close c1;
//
//
//	end if
//end if
//Setpointer(arrow!)
//return 0
end event

event dw_master::updatestart;call super::updatestart;String ls_cod,ls_codigo,ls_ean
Long ll_filmaster

SetPointer(Hourglass!)
ll_filmaster = dw_master.getrow()

if ll_filmaster = 0 then return 1
ls_cod     = dw_master.GetItemString(ll_filmaster,'it_codbar')
ls_codigo = dw_master.GetItemString(ll_filmaster,'it_codigo')
ls_ean     = dw_master.GetItemString(ll_filmaster,'ean')

if isnull(ls_cod) or ls_cod = '' then
		wf_genera_codigo_barras(ls_ean)
end if
SetPointer(Arrow!)
return 0
end event

event dw_master::retrieveend;call super::retrieveend;if rowcount = 0 then
	return
end if
end event

type dw_report from w_sheet_master_tabpage_detail`dw_report within w_item
integer x = 14
integer y = 32
integer width = 3026
integer height = 1524
integer taborder = 30
string dataobject = "d_rep_cod_bar"
end type

type tab_detail from w_sheet_master_tabpage_detail`tab_detail within w_item
integer x = 0
integer y = 1120
integer width = 4027
integer height = 892
integer taborder = 20
end type

type tabpage_detail1 from w_sheet_master_tabpage_detail`tabpage_detail1 within tab_detail
integer y = 112
integer width = 3991
integer height = 764
string text = "Sucursal"
string picturename = "Imagenes\Sucursal.Gif"
string powertiptext = ""
end type

type dw_detail1 from w_sheet_master_tabpage_detail`dw_detail1 within tabpage_detail1
integer x = 0
integer y = 12
integer width = 3214
integer height = 692
string dataobject = "d_item_sucursal"
end type

type tabpage_detail2 from w_sheet_master_tabpage_detail`tabpage_detail2 within tab_detail
integer y = 112
integer width = 3991
integer height = 764
string text = "Bodega"
string picturename = "Imagenes\Seccion.Gif"
long picturemaskcolor = 553648127
end type

type dw_detail2 from w_sheet_master_tabpage_detail`dw_detail2 within tabpage_detail2
integer x = 0
integer y = 12
integer width = 3826
integer height = 700
string dataobject = "d_item_bodega"
end type

event dw_detail2::scrollvertical;call super::scrollvertical;long ll_filact
string ls_parametro[]
ll_filact = this.GetRow()
if ll_filact > 0 then
		ls_parametro[1] = str_appgeninfo.empresa
		ls_parametro[2] = this.GetItemString(ll_filact,"bo_codigo")
		f_recupera_datos(tab_detail.tabpage_detail2.dw_detail2,"bo_codigo",ls_parametro,2) 
end if
end event

event dw_detail2::rowfocuschanged;call super::rowfocuschanged;long ll_filact
string ls_sucur, ls_filtro
ll_filact = this.GetRow()
if ll_filact > 0 then
	  ls_sucur = this.GetItemString(ll_filact,'su_codigo')
  	  ls_filtro = "su_codigo = " +"'"+ ls_sucur + "'"
	  datawindowchild ldwc_aux
	  this.getChild("bo_codigo", ldwc_aux)
	  if isnull(ls_filtro) then ls_filtro = ''
	  ldwc_aux.SetFilter(ls_filtro)
	  ldwc_aux.Filter()
end if
end event

event dw_detail2::itemchanged;call super::itemchanged;string ls_sucur, LS_FILTRO
long ll_filact
string ls_null
ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",str_appgeninfo.empresa)

CHOOSE CASE this.GetColumnName()
	CASE "su_codigo"
	  ls_sucur = this.GetText()
  	  ls_filtro = "su_codigo = " +"'"+ ls_sucur + "'"
	  datawindowchild ldwc_aux
	  this.getChild("bo_codigo", ldwc_aux)
	  ldwc_aux.SetFilter(ls_filtro)
	  ldwc_aux.Filter()
END CHOOSE
end event

type tabpage_detail3 from w_sheet_master_tabpage_detail`tabpage_detail3 within tab_detail
integer y = 112
integer width = 3991
integer height = 764
string text = "Proveedores"
string picturename = "Imagenes\Proveedor.Gif"
long picturemaskcolor = 553648127
end type

type dw_detail3 from w_sheet_master_tabpage_detail`dw_detail3 within tabpage_detail3
integer x = 0
integer y = 12
integer width = 2551
integer height = 680
string dataobject = "d_itemxproveedor"
end type

event dw_detail3::doubleclicked;string ls_itcodigo
int li_nfila

ls_itcodigo = dw_master.getitemstring(dw_master.getrow(),"it_codigo")
li_nfila = tab_detail.tabpage_detail3.dw_detail3.insertrow(0)
tab_detail.tabpage_detail3.dw_detail3.setitem(li_nfila,"it_codigo",ls_itcodigo)
tab_detail.tabpage_detail3.dw_detail3.setitem(li_nfila,"em_codigo",str_appgeninfo.empresa)
end event

type tabpage_detail4 from w_sheet_master_tabpage_detail`tabpage_detail4 within tab_detail
integer y = 112
integer width = 3991
integer height = 764
string text = "Descuentos"
string picturename = "Imagenes\Descuento.Gif"
long picturemaskcolor = 553648127
end type

type dw_detail4 from w_sheet_master_tabpage_detail`dw_detail4 within tabpage_detail4
integer x = 5
integer y = 32
integer width = 2359
integer height = 692
string dataobject = "d_dcto_x_tipo_cliente"
end type

type dw_ubica from datawindow within w_item
event ue_downkey pbm_dwnkey
boolean visible = false
integer x = 626
integer y = 268
integer width = 1861
integer height = 340
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Buscar Producto"
string dataobject = "d_recupera_producto"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_downkey;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
    dw_master.SetFocus()
	dw_master.SetFilter('')
	dw_master.Filter()
end if
end event

event itemchanged;string ls_codant,ls_codigo 

ls_codant = this.getText()

If dw_master.retrieve(str_appgeninfo.empresa,ls_codant) < 1 Then
//dw_master.reset()
tab_detail.tabpage_detail1.dw_detail1.reset()
tab_detail.tabpage_detail2.dw_detail2.reset()
tab_detail.tabpage_detail3.dw_detail3.reset()
tab_detail.tabpage_detail4.dw_detail4.reset()

End if
ls_codigo = dw_master.getitemstring(dw_master.getrow(),"it_codigo")
tab_detail.tabpage_detail1.dw_detail1.retrieve(str_appgeninfo.empresa,ls_codigo)
tab_detail.tabpage_detail2.dw_detail2.retrieve(str_appgeninfo.empresa,ls_codigo)
tab_detail.tabpage_detail3.dw_detail3.retrieve(str_appgeninfo.empresa,ls_codigo)
tab_detail.tabpage_detail4.dw_detail4.retrieve(str_appgeninfo.empresa,ls_codigo)

end event

event doubleclicked;dw_ubica.Visible = false
dw_master.SetFocus()
dw_master.SetFilter('')
dw_master.Filter()
end event


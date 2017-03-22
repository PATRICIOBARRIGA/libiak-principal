HA$PBExportHeader$w_rep_precios.srw
$PBExportComments$Si.Listado de los precios.
forward
global type w_rep_precios from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_precios
end type
end forward

global type w_rep_precios from w_sheet_1_dw_rep
integer x = 5
integer y = 268
integer width = 2939
integer height = 1568
string title = "Lista de Precios"
long backcolor = 1090519039
dw_1 dw_1
end type
global w_rep_precios w_rep_precios

type variables
string   is_pepa 
end variables

on w_rep_precios.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_precios.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;long row,tmp
long ll_row,ll_i,num_filas,num_indice,no
string cl_codpad,page

dw_1.InsertRow(0)

this.ib_notautoretrieve = true
dw_report.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")

call super::open
dw_report.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
f_recupera_empresa(dw_1,"fb_codigo")
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
dw_report.retrieve(str_appgeninfo.empresa,1)

num_filas=dw_datos.RowCount()
num_indice=dw_report.RowCount()
 For ll_i=1 to num_indice
		cl_codpad=dw_report.GetItemString(ll_i,'cl_codpad')
	   ll_row=dw_datos.find("codigo_clase ='"+cl_codpad+"'", 1,num_filas)
		dw_datos.ScrollToRow(ll_row)
		page = dw_datos.describe("evaluate('page()',"+string(ll_row)+")")
		if page='1' and ll_row<>1 then page='0'
		dw_report.SetItem(ll_i,'cc_pag',long(page))
 next
dw_datos.ScrollToRow(1)
dw_report.SetFilter("cc_pag <> 0")
dw_report.Filter()
dw_report.GroupCalc()


end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_report.x=dw_datos.x
dw_report.y=dw_datos.y
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
dw_report.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)
end event

event ue_print;call super::ue_print;int li_rc
if dw_datos.visible then 
	openwithparm(w_dw_print_options,dw_datos)
	li_rc = message.DoubleParm
	if li_rc = 1 then
	   dw_datos.print()
	end if
else
	openwithparm(w_dw_print_options,dw_datos)
	li_rc = message.DoubleParm
	if li_rc = 1 then
	   dw_report.print()
	end if
end if

end event

event ue_zoomin;call super::ue_zoomin;//int li_curZoom
//if dw_datos.visible then
//li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))
//
//if li_curZoom >= 200 then
//	beep(1)
//else
//	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
//end if
//
//else
//	li_curZoom = integer(dw_report.describe("datawindow.print.preview.zoom"))
//
//if li_curZoom >= 200 then
//	beep(1)
//else
//	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
//end if
//end if
end event

event ue_zoomout;call super::ue_zoomout;//int li_curZoom
//if dw_datos.visible then
//li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))
//
//if li_curZoom <= 200 then
//	beep(1)
//else
//	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
//end if
//
//else
//	li_curZoom = integer(dw_report.describe("datawindow.print.preview.zoom"))
//
//if li_curZoom <= 25 then
//	beep(1)
//else
//	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
//end if
//end if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_precios
integer x = 0
integer y = 216
integer width = 2898
integer height = 1312
string dataobject = "d_rep_lista_precios_draft"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_precios
integer y = 216
integer height = 908
string dataobject = "d_rep_indice_lista_precios"
end type

type dw_1 from datawindow within w_rep_precios
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
integer width = 2903
integer height = 216
integer taborder = 30
string dataobject = "d_sel_prod_indice_toma_fisica"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;string ls_filtro=' ',ls_cod_producto,ls_producto,ls_fabricante,ls_cod_clase,ls_1=' ',ls_2=' '
dw_1.AcceptText()
ls_cod_clase=GetItemString(row,'codigo_clase')
ls_cod_producto=GetItemString(row,'codigo_producto')
ls_producto=GetItemString(row,'producto')
ls_fabricante =GetItemString(row,'fb_codigo')
if isnull(ls_cod_clase) or ls_cod_clase='' then
	ls_filtro="(cl_codigo like '%' )"
else
	ls_filtro="(cl_codigo like '"+ls_cod_clase+"') "
end if
if not isnull(ls_cod_producto) and ls_cod_producto<>'' then
	ls_filtro=ls_filtro+" and (codigo_producto like '"+ls_cod_producto+"')"
end if
if not isnull(ls_producto) and ls_producto<>'' then
	ls_filtro=ls_filtro+" and (producto like '"+ls_producto+"')"
end if
if not isnull(ls_fabricante) and ls_fabricante <>'' then
	ls_filtro=ls_filtro+" and (fb_codigo = '"+ls_fabricante+"')"
end if

choose case this.getcolumnname()
case 'indice'
		if data='S' then
			dw_datos.visible=false
			dw_report.visible=True
		else
			dw_datos.visible=true
			dw_report.visible=false
		end if
END CHOOSE
dw_datos.ScrollToRow(1)
dw_datos.SetFilter(ls_filtro)
dw_datos.Filter()
dw_datos.GroupCalc()

end event


HA$PBExportHeader$w_rep_toma_fisica.srw
$PBExportComments$Si.Listado de productos para la toma f$$HEX1$$ec00$$ENDHEX$$sica de productos.
forward
global type w_rep_toma_fisica from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_toma_fisica
end type
end forward

global type w_rep_toma_fisica from w_sheet_1_dw_rep
int X=5
int Y=269
int Width=2940
int Height=1569
boolean TitleBar=true
string Title="Toma F$$HEX1$$ed00$$ENDHEX$$sica"
long BackColor=1090519039
dw_1 dw_1
end type
global w_rep_toma_fisica w_rep_toma_fisica

type variables
string   is_pepa 
end variables

on w_rep_toma_fisica.create
int iCurrent
call w_sheet_1_dw_rep::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_rep_toma_fisica.destroy
call w_sheet_1_dw_rep::destroy
destroy(this.dw_1)
end on

event open;long row,tmp
dw_1.InsertRow(0)

this.ib_notautoretrieve = true
dw_report.modify("datawindow.print.preview.zoom=75~t" + &
										"datawindow.print.preview=yes")

call super::open
dw_report.SetTransObject(sqlca)
dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
dw_report.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,1)

long ll_row,ll_i,num_filas,num_indice,no
string cl_codpad,page
ll_row=2
num_filas=dw_datos.RowCount()
num_indice=dw_report.RowCount()
 For ll_i=1 to num_indice
		cl_codpad=dw_report.GetItemString(ll_i,'cl_codpad')
	   ll_row=dw_datos.find("codigo_clase ='"+cl_codpad+"'",ll_row - 1,num_filas)
		dw_datos.ScrollToRow(ll_row)
		page = dw_datos.describe("evaluate('page()',"+string(ll_row)+")")
		dw_report.SetItem(ll_i,'cc_pag',long(page))
 next
dw_datos.ScrollToRow(1)
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

event ue_zoomin;int li_curZoom
if dw_datos.visible then
li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if

else
	li_curZoom = integer(dw_report.describe("datawindow.print.preview.zoom"))

if li_curZoom >= 200 then
	beep(1)
else
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom + 25))
end if
end if
end event

event ue_zoomout;int li_curZoom
if dw_datos.visible then
li_curZoom = integer(dw_datos.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 200 then
	beep(1)
else
	dw_datos.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if

else
	li_curZoom = integer(dw_report.describe("datawindow.print.preview.zoom"))

if li_curZoom <= 25 then
	beep(1)
else
	dw_report.modify("datawindow.print.preview.zoom=" + string(li_curZoom - 25))
end if
end if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_toma_fisica
int X=1
int Y=189
int Width=2899
int Height=1341
string DataObject="d_rep_productos_toma_fisica_draft"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_toma_fisica
int Y=217
int Height=909
boolean BringToTop=true
string DataObject="d_rep_indice_toma_fisica"
end type

type dw_1 from datawindow within w_rep_toma_fisica
event itemchanged pbm_dwnitemchange
event losefocus pbm_dwnkillfocus
int Width=2903
int Height=193
int TabOrder=30
string DataObject="d_sel_prod_indice_toma_fisica"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

event itemchanged;string ls_filtro=' ',ls_cod_producto,ls_producto,ls_cod_clase,ls_1=' ',ls_2=' '
dw_1.AcceptText()
ls_cod_clase=GetItemString(row,'codigo_clase')
ls_cod_producto=GetItemString(row,'codigo_producto')
ls_producto=GetItemString(row,'producto')
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


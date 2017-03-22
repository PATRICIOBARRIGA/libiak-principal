HA$PBExportHeader$w_subrubros.srw
$PBExportComments$Si.Definir Subrubros.
forward
global type w_subrubros from w_sheet_1_dw_maint
end type
type dw_1 from datawindow within w_subrubros
end type
end forward

global type w_subrubros from w_sheet_1_dw_maint
int X=234
int Y=261
int Width=1797
int Height=1133
boolean TitleBar=true
string Title="Subrubros"
long BackColor=1090519039
dw_1 dw_1
end type
global w_subrubros w_subrubros

event open;datawindowChild ldw
dw_1.InsertRow(0)
f_recupera_empresa(dw_1,'cod_rubro')
dw_1.Getchild('cod_rubro',ldw)
ldw.Setfilter(" ru_tipcam ='A' or  ru_tipcam ='C'")
ldw.Filter()

ib_notautoretrieve=True
f_recupera_empresa(dw_datos,"ru_codigo")
dw_datos.SetTransObject(sqlca)
dw_datos.SetRowFocusIndicator(Hand!)

call super::open
end event

on w_subrubros.create
int iCurrent
call w_sheet_1_dw_maint::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_subrubros.destroy
call w_sheet_1_dw_maint::destroy
destroy(this.dw_1)
end on

event resize;call super::resize;dataWindow ldw_aux
int li_width, li_height
li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

if this.ib_inReportMode then
	ldw_aux = dw_report
	ldw_aux.resize(this.workSpaceWidth() - 2*ldw_aux.x, this.workSpaceHeight() - 2*ldw_aux.y)
else
	this.setRedraw(False)
	dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
	dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
	this.setRedraw(True)
end if
end event

event ue_retrieve;f_recupera_empresa(dw_datos,"ru_codigo")
datawindowChild ldw
f_recupera_empresa(dw_1,'cod_rubro')
dw_1.Getchild('cod_rubro',ldw)
ldw.Setfilter(" ru_tipcam ='A' or  ru_tipcam ='C'")
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_subrubros
int Y=141
int Width=1761
int Height=889
string DataObject="d_detalle_rubros"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
end type

event dw_datos::itemchanged;call super::itemchanged;string ls_codpad
choose case this.GetColumnName()
	case 'ru_codigo'
		ls_codpad=dw_1.GetItemString(dw_1.GetRow(),'cod_rubro')
		this.SetItem(row,'ru_codpad',ls_codpad)
end choose
		
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_subrubros
boolean BringToTop=true
end type

type dw_1 from datawindow within w_subrubros
int Width=1761
int Height=141
int TabOrder=21
boolean BringToTop=true
string DataObject="d_cabecera_rubros"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

event itemchanged;CHOOSE CASE this.GetColumnName()
	CASE 'cod_rubro'
		if dw_datos.Retrieve(data) < 0 then
			dw_datos.InsertRow(0)
		end if
END CHOOSE
end event


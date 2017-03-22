HA$PBExportHeader$w_graph_ventas_mensuales.srw
forward
global type w_graph_ventas_mensuales from w_sheet_1_dw_rep
end type
type lb_value from listbox within w_graph_ventas_mensuales
end type
type em_1 from editmask within w_graph_ventas_mensuales
end type
type em_2 from editmask within w_graph_ventas_mensuales
end type
type st_1 from statictext within w_graph_ventas_mensuales
end type
type st_2 from statictext within w_graph_ventas_mensuales
end type
type st_3 from statictext within w_graph_ventas_mensuales
end type
type dw_1 from datawindow within w_graph_ventas_mensuales
end type
type gr_1 from graph within w_graph_ventas_mensuales
end type
type cb_1 from commandbutton within w_graph_ventas_mensuales
end type
type rb_emp from radiobutton within w_graph_ventas_mensuales
end type
type rb_suc from radiobutton within w_graph_ventas_mensuales
end type
type dw_2 from datawindow within w_graph_ventas_mensuales
end type
end forward

global type w_graph_ventas_mensuales from w_sheet_1_dw_rep
integer width = 3671
integer height = 2052
string title = "Ventas Mensuales"
long backcolor = 81324524
boolean ib_notautoretrieve = true
lb_value lb_value
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
dw_1 dw_1
gr_1 gr_1
cb_1 cb_1
rb_emp rb_emp
rb_suc rb_suc
dw_2 dw_2
end type
global w_graph_ventas_mensuales w_graph_ventas_mensuales

forward prototypes
public subroutine wf_set_a_series (string as_title, string as_value, string as_category)
end prototypes

public subroutine wf_set_a_series (string as_title, string as_value, string as_category);long ll_row, ll_index
int 	 li_series_num

li_series_num = gr_1.addseries (as_title )
if li_series_num < 1 Then Return
ll_row = RowCount (dw_datos)
For ll_index = 1 to ll_row
	gr_1.adddata (li_series_num, dw_datos.GetItemNumber(ll_index,as_value),&
				     dw_datos.GetItemString (ll_index, as_category))
Next
end subroutine

on w_graph_ventas_mensuales.create
int iCurrent
call super::create
this.lb_value=create lb_value
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.dw_1=create dw_1
this.gr_1=create gr_1
this.cb_1=create cb_1
this.rb_emp=create rb_emp
this.rb_suc=create rb_suc
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_value
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.gr_1
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.rb_emp
this.Control[iCurrent+11]=this.rb_suc
this.Control[iCurrent+12]=this.dw_2
end on

on w_graph_ventas_mensuales.destroy
call super::destroy
destroy(this.lb_value)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.gr_1)
destroy(this.cb_1)
destroy(this.rb_emp)
destroy(this.rb_suc)
destroy(this.dw_2)
end on

event ue_retrieve;int li_row,li_index
date ld_ini,ld_fin


setpointer(hourglass!)
ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

if isnull(ld_ini) or isnull(ld_fin) then
		messageBox("Error","Ingrese la fecha")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if


if ld_ini > ld_fin then
		messageBox("Error","Rango de Fechas Incorrecto")
		dw_datos.SetRedraw(True)
		SetPointer(Arrow!)
		return
end if


if rb_emp.checked then

	dw_datos.dataobject = 'd_graph_ventas_x_mes_empresa'
	dw_datos.settransobject(sqlca)
	dw_datos.sharedata(dw_2)	
	dw_2.visible = true
	dw_1.visible = false	
	dw_2.modify("st_empresa.text = '"+gs_empresa+"'")	
	dw_datos.Retrieve(ld_ini,ld_fin)
else
	dw_datos.dataobject = 'd_graph_ventas_x_mes'
	dw_datos.settransobject(sqlca)
	dw_datos.sharedata(dw_1)
	dw_1.visible = true	
	dw_2.visible = false	
	dw_1.modify("st_empresa.text = '"+gs_empresa+"'st_sucursal.text = '"+gs_su_nombre+"'")	
	dw_datos.Retrieve(str_appgeninfo.sucursal,ld_ini,ld_fin)
end if

gr_1.SetRedraw(FALSE)

// Loop through the rows of the DataWindow adding data points to graph.
li_row = RowCount (dw_datos)
for li_index = 1 to li_row
	gr_1.adddata(1,dw_datos.getitemstring(li_index,2),&
	               GetItemnumber(dw_datos,li_index,1))
next

gr_1.SetRedraw(TRUE)
setpointer(arrow!)
end event

event ue_print;long Job

Job = PrintOpen( )
gr_1.Print(Job, 1000,PrintY(Job)+500,6000,4500)
PrintPage(Job)
PrintClose(Job)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_graph_ventas_mensuales
integer x = 1559
integer y = 1468
integer width = 1266
integer height = 424
integer taborder = 0
string dataobject = "d_graph_ventas_x_mes"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_graph_ventas_mensuales
integer x = 370
integer y = 1408
integer width = 206
integer height = 132
integer taborder = 0
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_graph_ventas_mensuales
integer x = 41
integer y = 1420
integer width = 270
integer height = 132
end type

type lb_value from listbox within w_graph_ventas_mensuales
integer x = 233
integer y = 308
integer width = 471
integer height = 200
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean sorted = false
boolean multiselect = true
string item[] = {"Facturaci$$HEX1$$f300$$ENDHEX$$n","POS","Facturaci$$HEX1$$f300$$ENDHEX$$n y POS"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;int itemcount,i,r
string ls_colname

setpointer(hourglass!)
gr_1.SetRedraw (False)

// Clear out all categories, series and data from the graph
gr_1.reset ( all! )

// Loop through all selected values and create as many series as the
// user specified.
for i = 1 to lb_value.totalitems ( )
	if lb_value.state (i) = 1 then
		ls_colname = lb_value.text (i)
	choose case ls_colname 
		case 'Facturaci$$HEX1$$f300$$ENDHEX$$n'
			ls_colname = 'fxm'
		case 'POS'
			ls_colname = 'pos'
		case 'Facturaci$$HEX1$$f300$$ENDHEX$$n y POS'
			ls_colname = 'total'
	end choose
		wf_set_a_series (ls_colname, ls_colname,'cc_mes')
	end if
next

gr_1.SetRedraw (True)
setpointer(arrow!)
end event

type em_1 from editmask within w_graph_ventas_mensuales
integer x = 233
integer y = 164
integer width = 306
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_graph_ventas_mensuales
integer x = 768
integer y = 164
integer width = 306
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_graph_ventas_mensuales
integer x = 50
integer y = 168
integer width = 169
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_graph_ventas_mensuales
integer x = 603
integer y = 168
integer width = 151
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_graph_ventas_mensuales
integer x = 50
integer y = 300
integer width = 169
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ventas"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_graph_ventas_mensuales
boolean visible = false
integer x = 37
integer y = 556
integer width = 1285
integer height = 1328
integer taborder = 40
boolean bringtotop = true
string title = "Ventas mensuales"
string dataobject = "d_graph_ventas_x_mes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gr_1 from graph within w_graph_ventas_mensuales
integer x = 1353
integer y = 68
integer width = 2249
integer height = 1348
boolean border = true
grgraphtype graphtype = col3dobjgraph!
long textcolor = 33554432
long backcolor = 16777215
integer spacing = 100
string title = "Ventas mensuales"
integer depth = 100
grlegendtype legend = atbottom!
boolean focusrectangle = false
grsorttype seriessort = ascending!
grsorttype categorysort = ascending!
end type

on gr_1.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="Arial"
TitleDispAttr.FontCharSet=DefaultCharSet!
TitleDispAttr.FontFamily=Swiss!
TitleDispAttr.FontPitch=Variable!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=536870912
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
TitleDispAttr.AutoSize=true
Category.Label="Mes"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="Arial"
Category.DispAttr.FontCharSet=DefaultCharSet!
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=536870912
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="Arial"
Category.LabelDispAttr.FontCharSet=DefaultCharSet!
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=536870912
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="Ventas"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="Arial"
Values.DispAttr.FontCharSet=DefaultCharSet!
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="Arial"
Values.LabelDispAttr.FontCharSet=DefaultCharSet!
Values.LabelDispAttr.FontFamily=Swiss!
Values.LabelDispAttr.FontPitch=Variable!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=536870912
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.Label="(None)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="Arial"
Series.DispAttr.FontCharSet=DefaultCharSet!
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="Arial"
Series.LabelDispAttr.FontCharSet=DefaultCharSet!
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=536870912
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="Arial"
LegendDispAttr.FontCharSet=DefaultCharSet!
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=536870912
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression="series"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="Arial"
PieDispAttr.FontCharSet=DefaultCharSet!
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=536870912
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on gr_1.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

type cb_1 from commandbutton within w_graph_ventas_mensuales
integer x = 768
integer y = 308
integer width = 407
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Tipo de &gr$$HEX1$$e100$$ENDHEX$$fico"
end type

event clicked;SetPointer(HourGlass!)
// Open the response window to set the graph type. Pass it the graph
// object and it will do the rest.
OpenWithParm (w_graph_type, gr_1)
end event

type rb_emp from radiobutton within w_graph_ventas_mensuales
integer x = 233
integer y = 64
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Empresa"
boolean checked = true
end type

type rb_suc from radiobutton within w_graph_ventas_mensuales
integer x = 768
integer y = 64
integer width = 297
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Sucursal"
end type

type dw_2 from datawindow within w_graph_ventas_mensuales
integer x = 37
integer y = 556
integer width = 1285
integer height = 1328
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_graph_ventas_x_mes_empresa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type


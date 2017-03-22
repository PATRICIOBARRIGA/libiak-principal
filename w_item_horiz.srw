HA$PBExportHeader$w_item_horiz.srw
$PBExportComments$Si.Listado de items horizontal para mantenimiento
forward
global type w_item_horiz from w_sheet_1_dw_maint
end type
type dw_ubica from datawindow within w_item_horiz
end type
end forward

global type w_item_horiz from w_sheet_1_dw_maint
integer x = 27
integer y = 40
integer width = 2853
integer height = 1432
string title = "Hoja de Productos "
windowstate windowstate = maximized!
long backcolor = 67108864
event ue_consultar pbm_custom20
dw_ubica dw_ubica
end type
global w_item_horiz w_item_horiz

event ue_consultar;dw_datos.SetFilter('')
dw_datos.Filter()
dw_ubica.Reset()
dw_ubica.InsertRow(0)
dw_ubica.SetFocus()
dw_ubica.Visible = true
end event

event open;istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

f_recupera_empresa(dw_datos,"cl_codigo")
f_recupera_empresa(dw_datos,"cl_codigo_1")
f_recupera_empresa(dw_datos,"co_codigo")
f_recupera_empresa(dw_datos,"fb_codigo")
f_recupera_empresa(dw_datos,"ma_codigo")
f_recupera_empresa(dw_datos,"td_codigo")

call super::open
m_marco.m_ventana.m_todo.triggerevent(clicked!) 

end event

on w_item_horiz.create
int iCurrent
call super::create
this.dw_ubica=create dw_ubica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ubica
end on

on w_item_horiz.destroy
call super::destroy
destroy(this.dw_ubica)
end on

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_item_horiz
integer y = 0
integer width = 2811
integer height = 1332
string dataobject = "d_item_horiz"
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::doubleclicked;call super::doubleclicked;/**/ 
int i
if dwo.name = 'cl_codigo' then
for i = row to this.rowcount()
	this.object.cl_codigo[i] = this.object.cl_codigo[row]
next
end if


if dwo.name = 'fb_codigo' then
for i = row to this.rowcount()
	this.object.fb_codigo[i] = this.object.fb_codigo[row]
next
end if

if dwo.name = 'pa_codigo' then
for i = row to this.rowcount()
	this.object.pa_codigo[i] = this.object.pa_codigo[row]
next
end if

if dwo.name = 'ma_codigo' then
for i = row to this.rowcount()
	this.object.ma_codigo[i] = this.object.ma_codigo[row]
next
end if

if dwo.name = 'co_codigo' then
for i = row to this.rowcount()
	this.object.co_codigo[i] = this.object.co_codigo[row]
next
end if

if dwo.name = 'ub_codigo' then
for i = row to this.rowcount()
	this.object.ub_codigo[i] = this.object.ub_codigo[row]
next
end if

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_item_horiz
integer x = 174
integer y = 756
end type

type dw_ubica from datawindow within w_item_horiz
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 782
integer y = 304
integer width = 1810
integer height = 324
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Ubica item"
string dataobject = "d_recupera_producto"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_keydown;if keyDown(KeyEscape!) then
	dw_ubica.Visible = false
   dw_datos.SetFocus()
	dw_datos.SetFilter('')
	dw_datos.Filter()
end if
end event

event itemchanged;String ls_item,ls_nombre,ls_tipofound
Long ll_found


This.AcceptText()
ls_tipofound = this.object.tipo[1]
ls_item      = this.object.codant[1]
ls_nombre    = this.object.nombre[1]


If ls_tipofound = 'B' then
ll_found = dw_datos.find("it_codant = '"+ls_item+"'",1,dw_datos.rowcount())
if ll_found <= 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","C$$HEX1$$f300$$ENDHEX$$digo de producto no existe",Exclamation!)
	return
end if 
dw_datos.ScrollToRow(ll_found)
dw_datos.SetRow(ll_found)
elseif ls_tipofound = 'F' then
	if not isnull(ls_item) then 
	dw_datos.Setfilter("it_codant like '"+ls_item+"'")
   dw_datos.Filter()
   else
	dw_datos.Setfilter("it_nombre like '"+ls_nombre+"'")
   dw_datos.Filter()
   end if
End if

dw_datos.Setfocus()





end event

event doubleclicked;dw_ubica.Visible = false
dw_datos.SetFocus()
end event


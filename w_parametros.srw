HA$PBExportHeader$w_parametros.srw
forward
global type w_parametros from w_sheet_1_dw_maint
end type
type dw_ps from datawindow within w_parametros
end type
end forward

global type w_parametros from w_sheet_1_dw_maint
string tag = "Mantenimiento de Par$$HEX1$$e100$$ENDHEX$$metros Generales del Sistema"
integer width = 5074
integer height = 1592
string title = "Mantenimiento de Par$$HEX1$$e100$$ENDHEX$$metros Generales del Sistema"
long backcolor = 1090519039
dw_ps dw_ps
end type
global w_parametros w_parametros

on w_parametros.create
int iCurrent
call super::create
this.dw_ps=create dw_ps
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_ps
end on

on w_parametros.destroy
call super::destroy
destroy(this.dw_ps)
end on

event open;


istr_argInformation.nrArgs = 1
istr_argInformation.argType[1] = "string"
istr_argInformation.StringValue[1] = str_appgeninfo.empresa

f_recupera_empresa(dw_ps,"su_codigo")
dw_ps.SettransObject(sqlca)
dw_ps.Retrieve(str_appgeninfo.empresa)


call super::open

end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_parametros
integer y = 0
integer width = 5019
integer height = 1484
string dataobject = "d_parametros"
end type

event dw_datos::itemchanged;call super::itemchanged;long ll_filact

ll_filact = this.GetRow()
this.SetItem(ll_filact,"em_codigo",istr_argInformation.StringValue[1])
end event

event dw_datos::buttonclicked;call super::buttonclicked;String ls_filtro,ls_data

dw_ps.visible = true

if dwo.name = 'b_1' then
this.selectrow(0,false)
this.selectrow(row,true)
ls_data = this.Object.pr_nombre[row]
ls_filtro = "pr_nombre = '"+ls_data+"'"
if isnull(ls_filtro) then ls_filtro = '@'
dw_ps.SetFilter(ls_filtro)
dw_ps.Filter()
end if

if dwo.name = 'b_2' then
//	ls_filtro = '@'
    if isnull(ls_filtro) then ls_filtro = '@'
	dw_ps.SetFilter(ls_filtro)
	dw_ps.Filter()
end if
end event

event dw_datos::clicked;call super::clicked;this.selectrow(0,false)

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_parametros
end type

type dw_ps from datawindow within w_parametros
boolean visible = false
integer x = 800
integer y = 332
integer width = 2624
integer height = 1060
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Par$$HEX1$$e100$$ENDHEX$$metros por sucursal"
string dataobject = "d_parametros_x_sucursal"
boolean controlmenu = true
boolean livescroll = true
end type

event updatestart;int i
for i = 1 to this.rowcount()
this.object.em_codigo[i] = str_appgeninfo.empresa
next
return 0
end event


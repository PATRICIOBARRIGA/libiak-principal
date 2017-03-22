HA$PBExportHeader$w_doclegales_empresa.srw
forward
global type w_doclegales_empresa from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_doclegales_empresa
end type
type st_1 from statictext within w_doclegales_empresa
end type
type shl_1 from statichyperlink within w_doclegales_empresa
end type
end forward

global type w_doclegales_empresa from w_sheet_1_dw_maint
integer width = 4919
integer height = 1876
string title = "Documentos legales Empresa"
em_1 em_1
st_1 st_1
shl_1 shl_1
end type
global w_doclegales_empresa w_doclegales_empresa

on w_doclegales_empresa.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.shl_1=create shl_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.shl_1
end on

on w_doclegales_empresa.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.shl_1)
end on

event ue_delete;//No permitir borrar
return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_doclegales_empresa
integer x = 14
integer y = 176
integer width = 4855
integer height = 1560
string dataobject = "d_doclegales"
end type

event dw_datos::ue_postinsert;call super::ue_postinsert;Long  ll_row
ll_row = this.getrow()
this.Object.em_codigo[ll_row] = str_appgeninfo.empresa
this.Object.su_codigo[ll_row] = str_appgeninfo.sucursal
this.Object.bo_codigo[ll_row] = str_appgeninfo.seccion
return 1
end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_doclegales_empresa
end type

type em_1 from editmask within w_doclegales_empresa
integer x = 731
integer y = 56
integer width = 407
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
string mask = "0000000000000"
boolean autoskip = true
end type

type st_1 from statictext within w_doclegales_empresa
integer x = 50
integer y = 68
integer width = 622
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingrese el N$$HEX2$$ba002000$$ENDHEX$$de Documento"
boolean focusrectangle = false
end type

type shl_1 from statichyperlink within w_doclegales_empresa
integer x = 1202
integer y = 64
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Buscar"
boolean focusrectangle = false
end type

event clicked;Long ll_find
ll_find = dw_datos.find("de_preimp = '"+em_1.text+"'",1,dw_datos.Rowcount())

if ll_find = 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones...!")
	Rollback;
	Return
end if

dw_datos.SetRow(ll_find)
dw_datos.ScrollToRow(ll_find)
end event


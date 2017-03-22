HA$PBExportHeader$w_rep_cajachica.srw
forward
global type w_rep_cajachica from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_cajachica
end type
type em_2 from editmask within w_rep_cajachica
end type
type st_1 from statictext within w_rep_cajachica
end type
type st_2 from statictext within w_rep_cajachica
end type
type st_3 from statictext within w_rep_cajachica
end type
type sle_1 from singlelineedit within w_rep_cajachica
end type
type st_4 from statictext within w_rep_cajachica
end type
end forward

global type w_rep_cajachica from w_sheet_1_dw_rep
integer width = 3584
integer height = 1768
string title = "Caja chica"
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
st_3 st_3
sle_1 sle_1
st_4 st_4
end type
global w_rep_cajachica w_rep_cajachica

on w_rep_cajachica.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.sle_1=create sle_1
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.sle_1
this.Control[iCurrent+7]=this.st_4
end on

on w_rep_cajachica.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.st_4)
end on

event ue_retrieve;dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_cajachica
integer x = 18
integer y = 200
integer width = 3511
integer height = 1448
integer taborder = 60
string dataobject = "d_rep_caja_chica"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_datos::sqlpreview;call super::sqlpreview;String  sql,ls_repos
Date  ld_ini ,ld_fin

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

ls_repos = sle_1.text

if not isnull(ld_ini) and not isnull(ld_fin) and string(ld_ini) <> '01/01/1900' and string(ld_fin) <> '01/01/1900' then
sql = sqlsyntax + " AND (TRUNC(CP_MOVIM.MP_FECHA) BETWEEN '"+string(ld_ini,'dd-mmm-yyyy') +"' and '"+string(ld_fin,'dd-mmm-yyyy')+"')"
else
sql = sqlsyntax + " AND (CP_MOVIM.MP_NROREPOS = "+ls_repos+")"
end if
dw_datos.SetSqlPreview(sql)



end event

event dw_datos::retrieveend;call super::retrieveend;this.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_cajachica
integer taborder = 10
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_cajachica
integer taborder = 20
end type

type em_1 from editmask within w_rep_cajachica
integer x = 1957
integer y = 92
integer width = 343
integer height = 72
integer taborder = 40
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

event getfocus;String ls_nulo

Setnull(ls_nulo)
sle_1.text = ls_nulo
end event

type em_2 from editmask within w_rep_cajachica
integer x = 2363
integer y = 92
integer width = 343
integer height = 72
integer taborder = 50
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

event getfocus;String ls_nulo

Setnull(ls_nulo)
sle_1.text = ls_nulo
end event

type st_1 from statictext within w_rep_cajachica
integer x = 1938
integer y = 28
integer width = 210
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
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_cajachica
integer x = 2345
integer y = 24
integer width = 187
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
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_rep_cajachica
integer x = 69
integer y = 28
integer width = 1435
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
string text = "Ingrese el N$$HEX2$$ba002000$$ENDHEX$$de Reposici$$HEX1$$f300$$ENDHEX$$n $$HEX2$$f3002000$$ENDHEX$$el Rango de fechas para consultar"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rep_cajachica
integer x = 1531
integer y = 92
integer width = 343
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event getfocus;String ls_nulo

setnull(ls_nulo)
em_1.text = ls_nulo
em_2.text = ls_nulo
end event

type st_4 from statictext within w_rep_cajachica
integer x = 1184
integer y = 96
integer width = 334
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
string text = "Reposici$$HEX1$$f300$$ENDHEX$$n N$$HEX1$$ba00$$ENDHEX$$:"
alignment alignment = center!
boolean focusrectangle = false
end type


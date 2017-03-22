HA$PBExportHeader$w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n.srw
$PBExportComments$Si.
forward
global type w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
end type
type st_1 from statictext within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
end type
type st_2 from statictext within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
end type
type em_3 from editmask within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
end type
type dw_1 from datawindow within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
end type
type st_3 from statictext within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
end type
type em_2 from editmask within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
end type
type st_4 from statictext within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
end type
end forward

global type w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n from w_sheet_1_dw_rep
integer width = 2377
integer height = 1508
string title = "Conciliaci$$HEX1$$f300$$ENDHEX$$n Bancaria"
long backcolor = 79741120
boolean ib_notautoretrieve = true
em_1 em_1
st_1 st_1
st_2 st_2
em_3 em_3
dw_1 dw_1
st_3 st_3
em_2 em_2
st_4 st_4
end type
global w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n

on w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n.create
int iCurrent
call super::create
this.em_1=create em_1
this.st_1=create st_1
this.st_2=create st_2
this.em_3=create em_3
this.dw_1=create dw_1
this.st_3=create st_3
this.em_2=create em_2
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.em_2
this.Control[iCurrent+8]=this.st_4
end on

on w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n.destroy
call super::destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_3)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.em_2)
destroy(this.st_4)
end on

event open;datawindowchild dwc_cta

ib_notautoretrieve = true
dw_1.getchild("cn_codigo",dwc_cta)
dwc_cta.SetTransObject(sqlca)
dwc_cta.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
dw_1.SetTransObject(sqlca)
dw_1.retrieve()
call super:: open
end event

event ue_retrieve;Date ld_fini,ld_ffin
Decimal ld_saldo
String ls_cuenta
Long  ll_nreg 

ld_fini = date(em_1.text)
ld_ffin = date(em_2.text)
ld_saldo  = dec(em_3.text)

if ld_fini < date('01/01/2002') &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La fecha de inicio no debe ser anterior al 01/01/2002 ")
Return
End if 

ls_cuenta = dw_1.GetItemString(dw_1.getrow(),"cn_codigo")
ll_nreg = dw_datos.retrieve(str_appgeninfo.empresa,ls_cuenta,ld_fini,ld_ffin,ld_saldo)

If ll_nreg = 0 &
Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existen datos con estas condiciones $$HEX2$$f3002000$$ENDHEX$$ya fuer$$HEX1$$f300$$ENDHEX$$n conciliados a esta fecha")
Return
End if
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 5
integer y = 248
integer width = 2336
integer height = 1184
integer taborder = 0
string dataobject = "d_rep_conciliacion"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_datos::retrieveend;call super::retrieveend;string ls_cncodigo,ls_nrocta,ls_if
long ll_row

ll_row = dw_1.getrow()
if ll_row = 0 then return
ls_cncodigo = dw_1.GetItemString(ll_row,"cn_codigo")

select cn_numero,if_nombre
into :ls_nrocta,:ls_if
from cb_ctains c  ,pr_instfin p
where c.em_codigo = p.em_codigo
and c.if_codigo = p.if_codigo
and c. em_codigo = :str_appgeninfo.empresa
and c.su_codigo = :str_appgeninfo.sucursal
and c.cn_codigo = :ls_cncodigo;

if sqlca.sqlcode < 0 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe la cuenta o la Instituci$$HEX1$$f300$$ENDHEX$$n Financiera  "+sqlca.sqlerrtext)
	return
end if
dw_datos.modify("st_banco.text = '"+ls_if+"' st_cuenta.text = '"+ls_nrocta+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 1088
integer y = 512
integer height = 244
integer taborder = 60
end type

type em_1 from editmask within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 507
integer y = 136
integer width = 343
integer height = 72
integer taborder = 20
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

type st_1 from statictext within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 55
integer y = 144
integer width = 453
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
string text = "Conciliaci$$HEX1$$f300$$ENDHEX$$n  Desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 1568
integer y = 140
integer width = 393
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
string text = "Saldo en Bancos:"
boolean focusrectangle = false
end type

type em_3 from editmask within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 1975
integer y = 132
integer width = 343
integer height = 76
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
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0.00"
boolean autoskip = true
end type

type dw_1 from datawindow within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 503
integer y = 24
integer width = 1074
integer height = 88
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dwc_cuenta_banco"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 55
integer y = 48
integer width = 169
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
string text = "Cuenta:"
boolean focusrectangle = false
end type

type em_2 from editmask within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 1097
integer y = 132
integer width = 343
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_4 from statictext within w_rep_conciliaci$$HEX1$$f300$$ENDHEX$$n
integer x = 914
integer y = 140
integer width = 160
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
string text = "Hasta:"
boolean focusrectangle = false
end type


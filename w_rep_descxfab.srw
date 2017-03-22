HA$PBExportHeader$w_rep_descxfab.srw
$PBExportComments$Si.Reporte de descuentos por item
forward
global type w_rep_descxfab from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_descxfab
end type
type st_1 from statictext within w_rep_descxfab
end type
end forward

global type w_rep_descxfab from w_sheet_1_dw_rep
integer width = 4037
integer height = 1820
string title = "Descuentos por Item"
long backcolor = 81324524
boolean ib_notautoretrieve = true
dw_1 dw_1
st_1 st_1
end type
global w_rep_descxfab w_rep_descxfab

on w_rep_descxfab.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
end on

on w_rep_descxfab.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event ue_retrieve;String ls_fab[]
Long ll_nreg,i
Boolean lb_selected


ll_nreg = dw_1.rowcount()

if ll_nreg = 0 then return

for i = 1 to ll_nreg
   lb_selected = dw_1.IsSelected(i)
	if lb_selected then
   ls_fab[i] = dw_1.getitemstring(i,"fb_codigo")
else
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Debe seleccionar uno o mas fabricantes....!!!")
	return
   end if
next	

dw_datos.retrieve(str_appgeninfo.empresa,ls_fab)

end event

event open;dw_1.SetTransObject(sqlca)
dw_datos.settransobject(sqlca)
dw_1.retrieve(str_appgeninfo.empresa)
ib_notautoretrieve = true
call super::open
dw_datos.modify("datawindow.print.preview=no")
end event

event resize;Long ll_height,ll_width

ll_height = this.workSpaceHeight()
ll_width  = this.workSpaceWidth() 
dw_1.resize (dw_1.width,ll_height - 100)
dw_datos.resize(ll_width - (dw_1.width + 20),ll_height - 100)
return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_descxfab
integer x = 1559
integer y = 88
integer width = 2427
integer height = 1608
integer taborder = 20
string title = "Descuentos"
string dataobject = "d_descxfab"
boolean hsplitscroll = true
end type

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_descxfab
integer x = 87
integer y = 404
integer taborder = 30
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_descxfab
end type

type dw_1 from datawindow within w_rep_descxfab
event ue_keydown pbm_dwnkey
integer x = 14
integer y = 88
integer width = 1536
integer height = 1604
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_lista_fabricante"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;Long ll_row


if key = keyspacebar! then
	ll_row = this.getrow()
	if this.isSelected(ll_row) then
		this.selectrow(ll_row,false)
	else
		this.selectrow(ll_row,true)
   end if
	
end if
end event

event clicked;long ll_CurRow
boolean lb_result

//ll_CurRow = This.GetRow()
lb_result = This.IsSelected(Row)

IF lb_result THEN
	This.SelectRow(Row, FALSE)
ELSE
	This.SelectRow(Row, TRUE)
END IF


end event

type st_1 from statictext within w_rep_descxfab
integer x = 37
integer y = 20
integer width = 562
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
string text = "Seleccione el Fabricante:"
boolean focusrectangle = false
end type


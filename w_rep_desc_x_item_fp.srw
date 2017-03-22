HA$PBExportHeader$w_rep_desc_x_item_fp.srw
forward
global type w_rep_desc_x_item_fp from w_sheet_1_dw_rep
end type
type sle_1 from singlelineedit within w_rep_desc_x_item_fp
end type
type st_1 from statictext within w_rep_desc_x_item_fp
end type
type st_2 from statictext within w_rep_desc_x_item_fp
end type
type sle_2 from singlelineedit within w_rep_desc_x_item_fp
end type
type st_3 from statictext within w_rep_desc_x_item_fp
end type
end forward

global type w_rep_desc_x_item_fp from w_sheet_1_dw_rep
integer width = 3767
integer height = 1580
string title = "Descuentos por forma de pago"
long backcolor = 67108864
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
sle_1 sle_1
st_1 st_1
st_2 st_2
sle_2 sle_2
st_3 st_3
end type
global w_rep_desc_x_item_fp w_rep_desc_x_item_fp

type variables
String is_pepa
end variables

on w_rep_desc_x_item_fp.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
this.sle_2=create sle_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.sle_2
this.Control[iCurrent+5]=this.st_3
end on

on w_rep_desc_x_item_fp.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.st_3)
end on

event ue_retrieve;

if not isnull(sle_2.text) and sle_2.text <>'' then
is_pepa = sle_2.text	
dw_datos.dataobject = 'd_descxitem_fp_all'
else
dw_datos.dataobject = 'd_descxitem_fp'
end if

dw_datos.SetTransObject(sqlca)
dw_datos.retrieve(is_pepa)

end event

event resize;dw_datos.resize(this.workSpaceWidth() - 2*dw_datos.x, this.workSpaceHeight() - 1.3*dw_datos.y)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_desc_x_item_fp
integer x = 37
integer y = 216
integer width = 3662
integer height = 1220
string dataobject = "d_descxitem_fp"
end type

event dw_datos::retrieveend;call super::retrieveend;this.modify("datawindow.PrintPreview.yes =75%")
end event

event dw_datos::retrievestart;call super::retrievestart;dw_datos.modify("st_empresa.text = '"+gs_empresa+"'")
//dw_datos.modify("datawindow.print.preview.zoom=150~t" + &
//										"datawindow.print.preview=yes")
end event

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_desc_x_item_fp
integer x = 2578
integer y = 636
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_desc_x_item_fp
integer x = 1755
integer y = 768
end type

type sle_1 from singlelineedit within w_rep_desc_x_item_fp
integer x = 1175
integer y = 24
integer width = 471
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
borderstyle borderstyle = stylelowered!
end type

event modified;
sle_2.text = ''

SELECT IT_CODIGO
INTO :is_pepa
FROM IN_ITEM 
WHERE IT_CODANT = :sle_1.text;


IF sqlca.sqlcode <> 0 then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","No existe este c$$HEX1$$f300$$ENDHEX$$digo ...<Por favor verifique!!!> "+ sqlca.sqlerrtext)
	Return
end if

parent.triggerevent("ue_retrieve")

end event

type st_1 from statictext within w_rep_desc_x_item_fp
integer x = 850
integer y = 40
integer width = 265
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
string text = "C$$HEX1$$f300$$ENDHEX$$digo:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_desc_x_item_fp
integer x = 850
integer y = 120
integer width = 288
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
string text = "Descripci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_rep_desc_x_item_fp
integer x = 1179
integer y = 116
integer width = 1303
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
string text = "%"
borderstyle borderstyle = stylelowered!
end type

event modified;sle_1.text = ''
parent.triggerevent("ue_retrieve")
end event

type st_3 from statictext within w_rep_desc_x_item_fp
integer x = 82
integer y = 36
integer width = 704
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ingrese el criterio de b$$HEX1$$fa00$$ENDHEX$$squeda:"
boolean focusrectangle = false
end type


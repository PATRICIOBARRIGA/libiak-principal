HA$PBExportHeader$w_rep_recaps.srw
$PBExportComments$Si.
forward
global type w_rep_recaps from w_sheet_1_dw_rep
end type
type em_1 from editmask within w_rep_recaps
end type
type em_2 from editmask within w_rep_recaps
end type
type st_1 from statictext within w_rep_recaps
end type
type st_2 from statictext within w_rep_recaps
end type
type cbx_1 from checkbox within w_rep_recaps
end type
end forward

global type w_rep_recaps from w_sheet_1_dw_rep
integer width = 2843
integer height = 1672
string title = "Recaps"
long backcolor = 81324524
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
cbx_1 cbx_1
end type
global w_rep_recaps w_rep_recaps

on w_rep_recaps.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cbx_1
end on

on w_rep_recaps.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cbx_1)
end on

event ue_retrieve;date ld_ini , ld_fin
string old_select, new_select, where_clause

ld_ini = date(em_1.text)
ld_fin = date(em_2.text)

//Todo 
if cbx_1.Checked = true then 
			old_select = dw_datos.GetSQLSelect()
			old_select = mid(old_select,1,1761)
			where_clause = "'" + string(ld_ini,'dd-mmm-yyyy')  + "' and '" +  string(ld_fin,'dd-mmm-yyyy') + "'))"
			old_select = old_select  + where_clause
			dw_datos.Modify("DataWindow.Table.Select = ''")
			dw_datos.SetSQLSelect(old_select)
			dw_datos.retrieve(ld_ini,ld_fin)
end if
 
//SIN CUOTA FACIL
if cbx_1.Checked = False then
			old_select = dw_datos.GetSQLSelect()
			old_select = mid(old_select,1,1761)
			where_clause = "'" + string(ld_ini,'dd-mmm-yyyy')  + "' and '" +  string(ld_fin,'dd-mmm-yyyy') + "')) and CB_DETTAR.FP_CODIGO not in ('81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98')"
			old_select = old_select  + where_clause
			dw_datos.Modify("DataWindow.Table.Select = ''")
			dw_datos.SetSQLSelect(old_select)
			dw_datos.retrieve(ld_ini,ld_fin)
end if

////SOLO CUOTA FACIL
if cbx_1.ThirdState = true then
			old_select = dw_datos.GetSQLSelect()
			old_select = mid(old_select,1,1761)
			where_clause = "'" + string(ld_ini,'dd-mmm-yyyy')  + "' and '" +  string(ld_fin,'dd-mmm-yyyy') + "')) and CB_DETTAR.FP_CODIGO in ('81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98')"
			old_select = old_select  + where_clause
			dw_datos.Modify("DataWindow.Table.Select = ''")
			dw_datos.SetSQLSelect(old_select)
			dw_datos.retrieve(ld_ini,ld_fin)
end if

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_recaps
integer x = 0
integer y = 156
integer width = 2793
integer height = 1380
integer taborder = 30
string dataobject = "d_rep_recaps"
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_recaps
integer taborder = 40
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_recaps
end type

type em_1 from editmask within w_rep_recaps
integer x = 219
integer y = 36
integer width = 343
integer height = 76
integer taborder = 10
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

type em_2 from editmask within w_rep_recaps
integer x = 754
integer y = 36
integer width = 343
integer height = 76
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

type st_1 from statictext within w_rep_recaps
integer x = 59
integer y = 44
integer width = 155
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
boolean focusrectangle = false
end type

type st_2 from statictext within w_rep_recaps
integer x = 608
integer y = 44
integer width = 146
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
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_rep_recaps
integer x = 1166
integer y = 44
integer width = 539
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todo"
boolean checked = true
boolean threestate = true
end type

event clicked;
if cbx_1.Checked = TRUE then cbx_1.Text = "Todo"

if cbx_1.Checked = FALSE then cbx_1.Text = "Sin Cuota Facil"

if cbx_1.ThirdState = TRUE then cbx_1.Text = "Solo Cuota Facil"


end event


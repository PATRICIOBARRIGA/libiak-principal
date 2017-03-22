HA$PBExportHeader$w_calendar.srw
$PBExportComments$Window to demonstrate the user object drop down calendar
forward
global type w_calendar from w_center
end type
type cb_close from commandbutton within w_calendar
end type
type st_2 from statictext within w_calendar
end type
type st_1 from statictext within w_calendar
end type
type ddlb_date from dropdownlistbox within w_calendar
end type
type uo_1 from u_ddcal within w_calendar
end type
type gb_1 from groupbox within w_calendar
end type
end forward

global type w_calendar from w_center
integer x = 503
integer y = 360
integer width = 1879
integer height = 1288
string title = "Drop Down Calendar"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
cb_close cb_close
st_2 st_2
st_1 st_1
ddlb_date ddlb_date
uo_1 uo_1
gb_1 gb_1
end type
global w_calendar w_calendar

event close;//w_main.Show()
end event

on open;//Initialize the userobject by calling its local function Init_cal and passing it a start date
uo_1.init_cal(today())
uo_1.set_date_format ( ddlb_date.text )
end on

on w_calendar.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_date=create ddlb_date
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.ddlb_date
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.gb_1
end on

on w_calendar.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_date)
destroy(this.uo_1)
destroy(this.gb_1)
end on

type cb_close from commandbutton within w_calendar
integer x = 1381
integer y = 960
integer width = 325
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

on clicked;close(parent)
end on

type st_2 from statictext within w_calendar
integer x = 78
integer y = 140
integer width = 864
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = " Calendario"
boolean focusrectangle = false
end type

type st_1 from statictext within w_calendar
integer x = 69
integer y = 16
integer width = 1088
integer height = 108
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Click sobre el boton para desplegar el calendario."
boolean focusrectangle = false
end type

type ddlb_date from dropdownlistbox within w_calendar
integer x = 1061
integer y = 220
integer width = 645
integer height = 536
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
string text = "dd-mmm-yy"
boolean vscrollbar = true
string item[] = {"dd-mmm-yy","[LongDate]","[ShortDate]","mmm-yy","dddd, mmm d, yyyy","mm/dd/yyyy","mm/dd/yy"}
borderstyle borderstyle = stylelowered!
end type

on modified;//register w/user object that the format has changed
uo_1.set_date_format ( ddlb_date.text )
end on

type uo_1 from u_ddcal within w_calendar
integer x = 46
integer y = 184
integer width = 955
long backcolor = 74481808
end type

on uo_1.destroy
call u_ddcal::destroy
end on

type gb_1 from groupbox within w_calendar
integer x = 1019
integer y = 140
integer width = 736
integer height = 212
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Formato de fecha "
end type


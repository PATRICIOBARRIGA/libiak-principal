HA$PBExportHeader$w_sheet.srw
forward
global type w_sheet from window
end type
end forward

global type w_sheet from window
integer x = 672
integer y = 264
integer width = 1582
integer height = 992
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
end type
global w_sheet w_sheet

on w_sheet.create
end on

on w_sheet.destroy
end on

event close;w_frame_basic lw_frame
m_frame_basic lm_frame

lw_frame = this.parentWindow()
lw_frame.ii_sheetCount --
if lw_frame.ii_sheetCount < 1 then
	lm_frame = lw_frame.menuid
	lm_frame.mf_close_last_sheet()
end if
end event

event open;w_frame_basic lw_frame
m_frame_basic lm_frame
window lw_other
long ll_this_x
long ll_this_y

lw_frame = this.parentWindow()
lw_frame.ii_sheetCount ++
if lw_frame.ii_sheetCount = 1 then
	lm_frame = lw_frame.menuid
	lm_frame.mf_open_first_sheet()
end if

lw_other = lw_frame.getFirstSheet()
if lw_other = this then
	lw_other = lw_frame.getNextSheet(this)
end if

if isValid(lw_other) then
	// calculate default cascaded x and y
	ll_this_x = lw_other.x + 101
	ll_this_y = lw_other.y + 90

	if ll_this_x + this.width - 1 > lw_frame.workSpaceWidth() or &
		ll_this_y + this.height - 1 > lw_frame.workSpaceHeight() then
		ll_this_x = 1
		ll_this_y = 1
	end if
else
	ll_this_x = 1
	ll_this_y = 1
end if

this.move(ll_this_x, ll_this_y)
//this.title = this.title +" "+this.classname()
end event

event activate;w_marco.setmicrohelp(ClassName(w_marco.GetActiveSheet()))















































	


end event


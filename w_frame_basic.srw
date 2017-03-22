HA$PBExportHeader$w_frame_basic.srw
forward
global type w_frame_basic from window
end type
type mdi_1 from mdiclient within w_frame_basic
end type
end forward

global type w_frame_basic from window
integer width = 3657
integer height = 2400
boolean titlebar = true
string menuname = "m_frame_basic"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 67108864
mdi_1 mdi_1
end type
global w_frame_basic w_frame_basic

type variables
integer ii_sheetCount // # de hojas abiertas
integer ii_window_menu_position
end variables

forward prototypes
public function integer wf_opensheet (ref window aw_sheetrefvar, string as_windowtype, arrangeopen aao_arrangeopen)
public function integer wf_opensheetwithparm (ref window aw_sheetrefvar, ref s_arginformation aa_parm, string as_windowtype, arrangeopen aao_arrangeopen)
end prototypes

public function integer wf_opensheet (ref window aw_sheetrefvar, string as_windowtype, arrangeopen aao_arrangeopen);return openSheet(aw_sheetRefVar, as_windowType, this, &
							this.ii_window_menu_position, aao_arrangeopen)

end function

public function integer wf_opensheetwithparm (ref window aw_sheetrefvar, ref s_arginformation aa_parm, string as_windowtype, arrangeopen aao_arrangeopen);powerObject lpo_aux

lpo_aux = aa_parm
return (openSheetWithParm(aw_sheetRefVar, lpo_aux, as_windowType, this, &
							this.ii_window_menu_position, aao_arrangeopen))

end function

event open;menu lm_frameMenu
integer li_position, li_itemcount

// Encontrar la opci$$HEX1$$f300$$ENDHEX$$n Window sobre el men$$HEX1$$fa00$$ENDHEX$$

lm_frameMenu = this.menuid
li_itemcount = upperBound(lm_frameMenu.item)
for li_position = 1 to li_itemcount
	if lm_framemenu.item[li_position].className() = "m_window" then exit
next

this.ii_window_menu_position = li_position
end event

on w_frame_basic.create
if this.MenuName = "m_frame_basic" then this.MenuID = create m_frame_basic
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_frame_basic.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_frame_basic
long BackColor=268435456
end type


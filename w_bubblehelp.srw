HA$PBExportHeader$w_bubblehelp.srw
$PBExportComments$Pop-up Bubble Help (used by nvo_bubblehelp)
forward
global type w_bubblehelp from window
end type
type st_help from statictext within w_bubblehelp
end type
type os_size from structure within w_bubblehelp
end type
end forward

type os_size from structure
	long		l_cx
	long		l_cy
end type

global type w_bubblehelp from window
boolean visible = false
integer x = 823
integer y = 360
integer width = 2135
integer height = 1188
boolean enabled = false
boolean border = false
windowtype windowtype = popup!
long backcolor = 15793151
st_help st_help
end type
global w_bubblehelp w_bubblehelp

type prototypes
// Get text size
Function ulong GetDC(ulong hWnd) Library "USER32.DLL"
Function long ReleaseDC(ulong hWnd, ulong hdcr) Library "USER32.DLL"
Function boolean GetTextExtentPoint32A(ulong hdcr, string lpString, long nCount, ref os_size size) Library "GDI32.DLL" alias for "GetTextExtentPoint32A;Ansi"
Function ulong SelectObject(ulong hdc, ulong hWnd) Library "GDI32.DLL"

end prototypes

type variables

end variables

event open;// See nvo_bubblehelp.Constructor! for details

end event

on w_bubblehelp.create
this.st_help=create st_help
this.Control[]={this.st_help}
end on

on w_bubblehelp.destroy
destroy(this.st_help)
end on

type st_help from statictext within w_bubblehelp
integer width = 2039
integer height = 1080
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15793151
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type


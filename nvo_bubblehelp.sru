HA$PBExportHeader$nvo_bubblehelp.sru
$PBExportComments$Timer NVO that controls Bubble Help
forward
global type nvo_bubblehelp from timing
end type
type str_registered_windows from structure within nvo_bubblehelp
end type
type str_size from structure within nvo_bubblehelp
end type
end forward

type str_registered_windows from structure
	window		w_parentwindow
	dragobject		do_controls[]
	integer		i_tabpage[]
	userobject		do_tabpage[50, 2]
	long		l_controlx[]
	long		l_controly[]
end type

type str_size from structure
	long		l_cx
	long		l_cy
end type

global type nvo_bubblehelp from timing
event ue_postopen ( )
end type
global nvo_bubblehelp nvo_bubblehelp

type prototypes
Function ulong GetActiveWindow() Library "USER32.DLL"
Function ulong SetFocus(ulong hWnd) Library "USER32.DLL"

// Get text size
Function ulong GetDC(ulong hWnd) Library "USER32.DLL"
Function long ReleaseDC(ulong hWnd, ulong hdcr) Library "USER32.DLL"
Function boolean GetTextExtentPoint32A(ulong hdcr, string lpString, long nCount, ref str_size size) Library "GDI32.DLL" alias for "GetTextExtentPoint32A;Ansi"
Function ulong SelectObject(ulong hdc, ulong hWnd) Library "GDI32.DLL"

end prototypes

type variables
// This MDI frame, if applicable - MUST BE SET BY MDI WINDOW
Window iw_MDIWindow

// Set to true to get MessageBoxs when an error occurs
Boolean ib_DebugMessage = False

// If False, then the timer slows way down and help is not displayed
Boolean ib_ShowHelp = True

// 0.4 seems just about right for me
Decimal idec_TimeInterval = 1

// The next two aren't private so you can force
// bubble help to re-display

// Last control that used bubblehelp - SetNull(ido_LastUsed) to clear
DragObject ido_LastUsed

// Last DW column using bubblehelp - is_LastDWCol = "" to clear
String is_LastDWCol

// Are you using PFC 6.0 Security or another use of the Tag property
Constant Boolean ib_UseTagKey = True
Constant String  is_TagKey = 'BubbleHelp'
Constant String is_TagDelimiter = ';' // Semi-colon is used by PFC

Private:

w_bubblehelp iw_Help // The bubblehelp window

// The registered windows (window structure)
Integer il_NumWindows
str_registered_windows ist_RegisteredWindows[]

// Maximum of 50 controls and two levels of tabs 
// (tab within a tab) - used as reference in of_Register(),
// Timer! and str_registered_windows
CONSTANT Integer li_MaxControlsOnTabs = 50
CONSTANT Integer li_MaxTabPages = 2

end variables

forward prototypes
public subroutine of_stop ()
public subroutine of_start ()
public subroutine of_register (window pw_parentwindow)
public subroutine of_register (window pw_parentwindow, dragobject pdo_controls[])
public subroutine of_unregister (window pw_parentwindow)
private function integer of_showhelp (dragobject pdo_object, long pl_positionx, long pl_positiony, string ps_help, window pw_parentwindow)
private function integer of_gettextsize (ref long pl_height, ref long pl_width)
private function string of_gethelptext (dragobject pdo_object)
end prototypes

public subroutine of_stop ();This.Stop()
ib_ShowHelp = False
IF (IsValid(iw_Help)) THEN
	iw_Help.Visible = False
END IF

end subroutine

public subroutine of_start ();// Start bubblehelp
ib_ShowHelp = True
IF (IsValid(iw_Help)) THEN This.Start(idec_TimeInterval)

end subroutine

public subroutine of_register (window pw_parentwindow);// Register a window - build array of controls from window
Integer li_ControlOn, li_Controls, li_Counter
WindowObject lwo_ObjectStack[]
DragObject ldo_HelpControls[]
Tab ltab_Tab
UserObject luo_UO

// Stop the timer and close the help window before getting list of controls
Stop()
IF (IsValid(iw_Help)) THEN iw_Help.Visible = False

li_Controls = UpperBound(pw_ParentWindow.Control)
IF (li_Controls < 1) THEN Return // No controls on the window

// Process objects backwards to preserve Z (front-to-back) order
FOR li_ControlOn = UpperBound(pw_ParentWindow.Control) TO 1 STEP -1
	lwo_ObjectStack[li_ControlOn] = pw_ParentWindow.Control[li_ControlOn]
NEXT

li_ControlOn = 1
DO 
	//	lwo_ObjectStack[li_ControlOn].TypeOf() = GroupBox! - Adding a groupbox would cause radio buttons to not function properly
	// See if valid control - controls ordered by Hierarchy then Name
	IF lwo_ObjectStack[li_ControlOn].TypeOf() = CheckBox! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = CommandButton! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = PictureButton! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = DataWindow! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = DropDownListBox! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = Graph! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = ListBox! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = PictureListBox! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = ListView! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = MultiLineEdit! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = EditMask! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = Picture! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = RadioButton! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = RichTextEdit! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = SingleLineEdit! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = StaticText! OR &
	lwo_ObjectStack[li_ControlOn].TypeOf() = TreeView! THEN
		ldo_HelpControls[UpperBound(ldo_HelpControls) + 1] = lwo_ObjectStack[li_ControlOn]
	ELSEIF lwo_ObjectStack[li_ControlOn].TypeOf() = Tab! THEN
		ltab_Tab  = lwo_ObjectStack[li_ControlOn]
		// Add all the tabpages to the "stack"
		FOR li_Counter = 1 TO UpperBound(ltab_Tab.Control)
			li_Controls ++
			lwo_ObjectStack[li_Controls] = ltab_Tab.Control[li_Counter]
		NEXT
	ELSEIF lwo_ObjectStack[li_ControlOn].TypeOf() = UserObject! THEN
		// Add on top of the "stack"
		luo_UO  = lwo_ObjectStack[li_ControlOn]
		// Add all the controls on the user object to the "stack"
		FOR li_Counter = 1 TO UpperBound(luo_UO.Control)
			li_Controls ++
			lwo_ObjectStack[li_Controls] = luo_UO.Control[li_Counter]
		NEXT
	END IF
	li_ControlOn ++ // Next control
LOOP UNTIL (li_ControlOn > li_Controls)

IF (UpperBound(ldo_HelpControls) = 0) THEN Return // Now valid controls in window

of_Register(pw_ParentWindow, ldo_HelpControls)

end subroutine

public subroutine of_register (window pw_parentwindow, dragobject pdo_controls[]);// Register a window using the array of passed controls
Integer li_ControlOn, li_NumControls, li_WindowOn
GraphicObject lgo_Parent // Just use the lowest type
DragObject ldo_Parent, ldo_TabPage
Boolean lb_Found
Integer li_NextAvailTab, li_NextAvailTabPage
str_registered_windows lst_EmptyWinStr

Stop()

IF (IsValid(iw_Help)) THEN iw_Help.Visible = False

IF (NOT IsValid(pw_ParentWindow)) OR (IsNull(pw_ParentWindow)) THEN 
	IF (ib_DebugMessage) THEN MessageBox("BubbleHelp Error", "Calling window is not a valid object")
	Return
END IF

// See if this the calling window is re-registering itself
FOR li_WindowOn = 1 TO il_NumWindows
	IF (ist_RegisteredWindows[li_WindowOn].w_ParentWindow = pw_ParentWindow) THEN
		ist_RegisteredWindows[li_WindowOn] = lst_EmptyWinStr // Blank it out
		ist_RegisteredWindows[li_WindowOn].w_ParentWindow = pw_ParentWindow
		lb_Found = True
		Exit
	END IF
NEXT

IF (NOT lb_Found) THEN
	IF (il_NumWindows > 0) THEN
		// Find next available slot, if there is one available
		FOR li_WindowOn = 1 TO il_NumWindows
			IF (ist_RegisteredWindows[li_WindowOn] = lst_EmptyWinStr) THEN
				Exit // Here's a empty slot from a unregistered window
			END IF
		NEXT
		IF (li_WindowOn > il_NumWindows) THEN 
			// No available slots
			il_NumWindows ++
		END IF
	ELSE
		// First window registered
		il_NumWindows ++
		li_WindowOn = il_NumWindows
	END IF
	ist_RegisteredWindows[li_WindowOn].w_ParentWindow = pw_ParentWindow
END IF

IF (UpperBound(pdo_Controls) < 1) THEN Return // A little error checking

// Get the X and Y coordinates of the controls relative to the window.
// Doing this here instead of the Timer! event will speed things up
// Controls inside UserObjects and Tabs force us get the X and Y coordinates for the parent object
// The following takes care of any depth of userobjects and tab controls
li_NumControls = UpperBound(pdo_Controls)
FOR li_ControlOn = 1 TO li_NumControls
	ist_RegisteredWindows[li_WindowOn].l_ControlY[li_ControlOn] = pdo_Controls[li_ControlOn].Y
	ist_RegisteredWindows[li_WindowOn].l_ControlX[li_ControlOn] = pdo_Controls[li_ControlOn].X
	
	// Get the X and Ys of all the valid parent objects
	// Use a variable of type PowerObject since PB GPFs if's a window - drag object is a descendent of window
	// Tip:  A page of a tab is considered a userobject
	// This means that a radio button will have a parent of type userobject (the tabpage), then tab
	lgo_Parent = pdo_Controls[li_ControlOn].GetParent()
	ist_RegisteredWindows[li_WindowOn].i_TabPage[li_ControlOn] = 0
	DO WHILE (lgo_Parent.TypeOf() = UserObject!) OR (lgo_Parent.TypeOf() = Tab!)
		ldo_Parent = lgo_Parent // Reassign it to a DragObject

			ist_RegisteredWindows[li_WindowOn].l_ControlY[li_ControlOn] = ist_RegisteredWindows[li_WindowOn].l_ControlY[li_ControlOn] + ldo_Parent.Y
			ist_RegisteredWindows[li_WindowOn].l_ControlX[li_ControlOn] = ist_RegisteredWindows[li_WindowOn].l_ControlX[li_ControlOn] + ldo_Parent.X
		IF (lgo_Parent.TypeOf() = UserObject!) THEN
			// Add a little for a miscalculation or missing constant somewhere
			ist_RegisteredWindows[li_WindowOn].l_ControlX[li_ControlOn] = ist_RegisteredWindows[li_WindowOn].l_ControlX[li_ControlOn] + 8
			ist_RegisteredWindows[li_WindowOn].l_ControlY[li_ControlOn] = ist_RegisteredWindows[li_WindowOn].l_ControlY[li_ControlOn] + 8
		END IF
		// See if it's a special situation (control on a tab) that needs to be dealt with in the Timer! event
		// The Timer! event will make sure the proper tabpage(s) is selected
		IF (lgo_Parent.TypeOf() = Tab!) THEN
			// Subtract some to offset a hidden error in the calculations elsewhere - funny how it's +8 for UOs and -8 for tabs...
			ist_RegisteredWindows[li_WindowOn].l_ControlY[li_ControlOn] = ist_RegisteredWindows[li_WindowOn].l_ControlY[li_ControlOn] - 8
			ist_RegisteredWindows[li_WindowOn].l_ControlX[li_ControlOn] = ist_RegisteredWindows[li_WindowOn].l_ControlX[li_ControlOn] - 8
			IF (ist_RegisteredWindows[li_WindowOn].i_TabPage[li_ControlOn] = 0) THEN // Is this the first time we've encounted a tab control for this control?
				// Yep - assign it a position in the array of controls on a tab
				li_NextAvailTab ++
				// A little error checking
				IF (li_MaxControlsOnTabs < li_NextAvailTabPage) THEN
					IF (ib_DebugMessage) THEN MessageBox("BubbleHelp Error", "The number of controls on tabs in the window " + ist_RegisteredWindows[li_WindowOn].w_ParentWindow.ClassName() + " exceeds the limit (" + String(li_MaxControlsOnTabs) + ")")
					Return
				END IF
				
				ist_RegisteredWindows[li_WindowOn].i_TabPage[li_ControlOn] = li_NextAvailTab
				// Null out the array of userobjects (tabpages)
				FOR li_NextAvailTabPage = 1 TO li_MaxTabPages
					SetNull(ist_RegisteredWindows[li_WindowOn].do_TabPage[li_NextAvailTab, li_NextAvailTabPage])
				NEXT
				li_NextAvailTabPage = 1
			END IF
			// A little error checking
			IF (li_MaxTabPages < li_NextAvailTabPage) THEN
				IF (ib_DebugMessage) THEN MessageBox("BubbleHelp Error", "The number of tabs within tabs on the window " + ist_RegisteredWindows[li_WindowOn].w_ParentWindow.ClassName() + " exceeds the limit (" + String(li_MaxTabPages) + ")")
				Return
			END IF
			ist_RegisteredWindows[li_WindowOn].do_TabPage[li_NextAvailTab, li_NextAvailTabPage] = ldo_TabPage // The last UserObject we processed in this loop
			li_NextAvailTabPage ++
		END IF
		ldo_TabPage = lgo_Parent // Save for next loop
		lgo_Parent = ldo_Parent.GetParent() // Get next parent to evaluate
	LOOP
NEXT

ist_RegisteredWindows[li_WindowOn].do_Controls = pdo_Controls

IF (ib_ShowHelp) THEN Start(idec_TimeInterval)

end subroutine

public subroutine of_unregister (window pw_parentwindow);Boolean lb_Found
Integer li_Counter, li_CurrentWindow
str_registered_windows lst_EmptyWin
Long ll_ActiveWindow

Stop() // Don't want an end-less loop here

// A little error checking
IF (il_NumWindows < 1) THEN
	IF (ib_DebugMessage) THEN MessageBox("BubbleHelp Error", "of_register called win no windows registered: " + pw_ParentWindow.ClassName())
	Start(idec_TimeInterval)
	Return
END IF

// Find the active window and set to "nothing"
FOR li_CurrentWindow = 1 TO il_NumWindows
	IF (ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow = pw_ParentWindow) THEN
		ist_RegisteredWindows[li_CurrentWindow] = lst_EmptyWin
		
		// Get the currently active window for the application via Win32 API
		ll_ActiveWindow = GetActiveWindow()
		IF (ll_ActiveWindow = Handle(iw_MDIWindow)) THEN
			// It's the MDI Frame window - get active sheet
			IF (Handle(iw_MDIWindow.GetActiveSheet()) > 0) THEN ll_ActiveWindow = Handle(iw_MDIWindow.GetActiveSheet())
		END IF

		IF (li_CurrentWindow = il_NumWindows) THEN il_NumWindows -- // Shorten the "stack"

		IF (IsValid(iw_Help)) THEN Close(iw_Help)

		// Post setting focus to the current windows parent
		// I think that the w_bubblehelp window, when the current window closes,
		// is causing the focus to get messed up
		// Note:  This is the Win32 API SetFocus, not the PB version.  
		// The API version uses a handle as the parameter
		Post SetFocus(Handle(pw_ParentWindow.ParentWindow()))
		Start(idec_TimeInterval)
		Return
	END IF
NEXT

// An unregistered window set il_ActiveWindow
IF (ib_DebugMessage) THEN MessageBox("BubbleHelp Error", "of_register called by an unregistered window: " + pw_ParentWindow.ClassName())

Start(idec_TimeInterval)

end subroutine

private function integer of_showhelp (dragobject pdo_object, long pl_positionx, long pl_positiony, string ps_help, window pw_parentwindow);Integer li_Ret
Long ll_Width, ll_Height, ll_X, ll_Y
Boolean lb_IsSheet // Is the window a sheet
ToolbarAlignment ltba_Align // Current toolbar alignment
// Personal modifications to the popup window X and Y values. 
Long li_XMod = 5
Long li_YMod = 5


IF (NOT IsValid(iw_Help)) THEN Return -4

iw_Help.Visible = False

IF (pw_ParentWindow.Titlebar) THEN li_YMod = li_YMod + 28

// Are we dealing with a sheet?
IF (IsValid(iw_MDIWindow)) THEN
	IF (pw_ParentWindow = iw_MDIWindow.GetActiveSheet()) THEN lb_IsSheet = True
END IF

IF (lb_IsSheet) THEN
	// Have to account for the fact that workspaceheight/width() returns values for the MDI frame
	// Get position of MDI frame - sheet is relative to iw_Help
	ll_Y = 50 // Start with the menu - it'll always have one.  For MDIs 50 seem to be about right
	ll_X = (iw_MDIWindow.X - ((iw_MDIWindow.WorkSpaceWidth() - iw_MDIWindow.Width) / 2)) + li_XMod
	ll_Y = ll_Y + (iw_MDIWindow.Y - ((iw_MDIWindow.WorkSpaceHeight() - iw_MDIWindow.Height) / 2)) +  li_YMod
	// Account for the sheet, position within the window, and titlebar
	ll_X = ll_X + pw_ParentWindow.X + pl_PositionX + li_XMod
	ll_Y = ll_Y + pw_ParentWindow.Y + pl_PositionY +  li_YMod
	// Account for toolbar(s)  - the only way to determine there are any items on the toolbar
	// is to check the height while it's floating.  The Visible attribute isn't enough.  This also tells us the offset to add
	IF (iw_MDIWindow.ToolbarVisible) AND (iw_MDIWindow.ToolbarAlignment <> Floating!) THEN
		ltba_Align = iw_MDIWindow.ToolbarAlignment
		iw_MDIWindow.ToolbarAlignment = Floating!
		iw_MDIWindow.ToolBarWidth = 1000 // Make it only one level deep
		IF (ltba_Align = AlignAtTop!) THEN ll_Y = ll_Y + iw_MDIWindow.ToolbarHeight / 2
		IF (ltba_Align = AlignAtLeft!) THEN ll_X = ll_X + (iw_MDIWindow.ToolbarHeight / 2) + 15
		iw_MDIWindow.ToolbarAlignment = ltba_Align
	END IF
	IF (pw_ParentWindow.ToolbarVisible) AND (pw_ParentWindow.ToolbarAlignment <> Floating!) THEN
		ltba_Align = pw_ParentWindow.ToolbarAlignment
		pw_ParentWindow.ToolbarAlignment = Floating!
		pw_ParentWindow.ToolBarWidth = 1000 // Make it only one level
		IF (ltba_Align = AlignAtTop!) THEN ll_Y = ll_Y + pw_ParentWindow.ToolbarHeight / 2
		IF (ltba_Align = AlignAtLeft!) THEN ll_X = ll_X + (pw_ParentWindow.ToolbarHeight / 2) + 15
		pw_ParentWindow.ToolbarAlignment = ltba_Align
	END IF
	// Add a fudge factor specifically for a sheet
	ll_X = ll_X + 20
	ll_Y = ll_Y + 55
ELSE
	// Get "true" width and height of window, including borders, title bar, and menu
	IF (pw_ParentWindow.MenuName <> "") THEN
		IF (pw_ParentWindow.WindowType = Main!) THEN
			ll_Y = ll_Y + 40 // Main type window (shorter than MDI)
		ELSE
			ll_Y = ll_Y + 35 // Popup seem to be shorter still
		END IF
	END IF
	ll_X = ll_X + (pw_ParentWindow.X - ((pw_ParentWindow.WorkSpaceWidth() - pw_ParentWindow.Width) / 2)) + pl_PositionX + li_XMod
	ll_Y = ll_Y + (pw_ParentWindow.Y - ((pw_ParentWindow.WorkSpaceHeight() - pw_ParentWindow.Height) / 2)) + pl_PositionY +  li_YMod
END IF

// Move it
iw_Help.X = ll_X 
iw_Help.Y = ll_Y - 180 //cambia la altura del popup.

IF (iw_Help.st_Help.Text <> ps_Help) THEN 
	// Size will change
	iw_Help.st_Help.Text = ps_Help
	
	// Get the size of the static text in pixels
	li_Ret = of_GetTextSize(ll_Height, ll_Width)
	IF (li_Ret > -1) THEN
		iw_Help.st_help.Width = PixelsToUnits(ll_Width, XPixelsToUnits!) + 22 // Add a little for show
		iw_Help.st_help.Height = PixelsToUnits(ll_Height, YPixelsToUnits!) + 10
		iw_Help.Width = iw_Help.st_help.Width
		iw_Help.Height = iw_Help.st_help.Height
	ELSE
		Return li_Ret
	END IF
END IF

iw_Help.Visible = True


//iw_Help.Visible = False
pw_ParentWindow.SetFocus() // Set the focus back to the parent window

Return 1

end function

private function integer of_gettextsize (ref long pl_height, ref long pl_width);// Dermines the height of the text in pixels
// The API calls come from PFC n_cst_platformWin32.of_GetTextSize()
Integer li_Len, li_Counter
Long ll_Handle, ll_HDC, ll_hFont
Integer li_WM_GETFONT = 49 //  hex 0x0031
str_size lstr_Size
String ls_HelpLines[]

// Separate each line of text into the array
// Add a space in front of each line to "pretty" it up
DO
	// Check for CR and LF
	li_Len = Pos(iw_Help.st_help.Text, "~r~n")
	IF (li_Len > 0) THEN
		ls_HelpLines[UpperBound(ls_HelpLines) + 1] = " " + Left(iw_Help.st_help.Text, li_Len - 1)
		iw_Help.st_help.Text = Mid(iw_Help.st_help.Text, li_Len + 2)
		Continue // We don't want to process the next IF/THEN
	END IF
	
	li_Len = Pos(iw_Help.st_help.Text, "~n")
	IF (li_Len > 0) THEN
		ls_HelpLines[UpperBound(ls_HelpLines) + 1] = " " + Left(iw_Help.st_help.Text, li_Len - 1)
		iw_Help.st_help.Text = Mid(iw_Help.st_help.Text, li_Len + 1)
	END IF
	
	// Check for ~~r~~n
	li_Len = Pos(iw_Help.st_help.Text, "~~r~~n")
	IF (li_Len > 0) THEN
		ls_HelpLines[UpperBound(ls_HelpLines) + 1] = " " + Left(iw_Help.st_help.Text, li_Len - 1)
		iw_Help.st_help.Text = Mid(iw_Help.st_help.Text, li_Len + 4)
		Continue // We don't want to process the next IF/THEN
	END IF
	
	li_Len = Pos(iw_Help.st_help.Text, "~~n")
	IF (li_Len > 0) THEN
		ls_HelpLines[UpperBound(ls_HelpLines) + 1] = " " + Left(iw_Help.st_help.Text, li_Len - 1)
		iw_Help.st_help.Text = Mid(iw_Help.st_help.Text, li_Len + 2)
	END IF
LOOP UNTIL li_Len = 0

ls_HelpLines[UpperBound(ls_HelpLines) + 1] = " " + iw_Help.st_help.Text // Add last portion of text

pl_Height = 0
pl_Width = 0
FOR li_Counter = 1 TO UpperBound(ls_HelpLines)
	// Determine the width of each one
	iw_Help.st_help.Text = ls_HelpLines[li_Counter]
	li_Len = Len(iw_Help.st_help.Text)
	
	// Get the handle of the StaticText Object and create a Device Context
	ll_Handle = Handle(iw_Help.st_help)
	ll_HDC = GetDC(ll_Handle)
	
	// Get the font in use on the Static Text
	ll_hFont = Send(ll_Handle, li_WM_GETFONT, 0, 0)
	
	// Select it into the device context
	SelectObject(ll_HDC, ll_hFont)
	
	// Get the size of the text.
	If Not GetTextExtentpoint32A(ll_HDC, iw_Help.st_help.Text, li_Len, lstr_Size ) Then Return -1


	pl_Height = pl_Height + lstr_Size.l_cy
	IF (pl_Width < lstr_Size.l_cx) THEN pl_Width = lstr_Size.l_cx // Keep greatest length
NEXT

// Rebuild the string with the CRs
iw_Help.st_help.Text = ""
FOR li_Counter = 1 TO UpperBound(ls_HelpLines)
	iw_Help.st_help.Text = iw_Help.st_help.Text + ls_HelpLines[li_Counter] + "~n"
NEXT

Return ReleaseDC(ll_Handle, ll_HDC)


end function

private function string of_gethelptext (dragobject pdo_object);String ls_Help
Integer li_PosStart, li_PosEnd

// Get tag of object that mouse if over and use that for help
IF (pdo_Object.TypeOf() = DataWindow!) THEN
	DataWindow ldw_DW
	String ls_DWObject
	
	ldw_DW = pdo_Object
	ldw_DW.Tag = ""
	ls_DWObject = ldw_DW.GetObjectAtPointer()
	
	IF (ls_DWObject <> "") AND (NOT IsNull(ls_DWObject)) THEN
		ls_DWObject = Left(ls_DWObject, Pos(ls_DWObject, "~t") - 1)
		ls_Help = ldw_DW.Describe(ls_DWObject + ".Tag") // Assign help to the DW tag
	END IF
ELSE
	ls_Help = pdo_Object.Tag
END IF

IF (ls_Help = "") OR (ls_Help = "?") THEN // Blank tag in a DW = ?
	Return "" // Just get out of here
ELSE
	// Prevent a "feature" in 6.0 that automatically surrounds whatever you assign the Tag value you set in DataWindows.
	// For example dw_1.Object.column.Tag = 'Wow'
	// MessageBox("", dw_1.Object.column.Tag) - you can't really do this directly
	// MessageBox displays "Wow"
	IF (Left(ls_Help, 1) = '"') AND (Right(ls_Help, 1) = '"') THEN ls_Help = Mid(ls_Help, 2, Len(ls_Help) - 2)

	// 1.02 - Start of changes
	// If the Tag has a key (as opposed to the entire Tag being the help text)
	// then search the Tag string for is_TagKey= (default is BubbleHelp).
	// Note that this only checks for no space and one space between is_TagKey
	// and the equals sign.
	IF (ib_UseTagKey) THEN
		li_PosStart = Pos(Upper(ls_Help), Upper(is_TagKey) + "=")
		IF (li_PosStart < 1) THEN li_PosStart = Pos(Upper(ls_Help), Upper(is_TagKey) + " =") // Try space then =
		IF (li_PosStart > 0) THEN
			// Look for delimitor starting after the where is_TagKey was found
			li_PosEnd = Pos(Upper(ls_Help), Upper(is_TagDelimiter), li_PosStart)
			IF (li_PosEnd < li_PosStart) THEN // Not found
				// Return rest of Tag
				ls_Help = Trim(Mid(ls_Help, li_PosStart + Len(is_TagKey) + 1)) // Skip
			ELSE // Found
				// Return to semi-colon
				li_PosEnd = li_PosEnd - (li_PosStart + Len(is_TagKey) + 1) // Get length of text to return
				ls_Help = Trim(Mid(ls_Help, li_PosStart + Len(is_TagKey) + 1, li_PosEnd))
			END IF
		ELSE
			ls_Help = "" // Key not found
		END IF
	END IF
	// 1.02 - End of changes

	Return ls_Help
END IF

end function

event constructor;This.Event Post ue_PostOpen()

end event

on nvo_bubblehelp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_bubblehelp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;IF IsValid(iw_Help) THEN Close(iw_Help)

end event

event timer;//
// Description: Checks to see if any registered control in the active window has the mouse pointer over it
//		If so, then it displays balloon help (if any).
//

Integer li_ControlOn, li_NumControls, li_CurrentWindow, li_Counter
GraphicObject lgo_Parent
Boolean lb_Found, lb_TabSelected, lb_IsSheet
Tab ltab_Tab // Used if the control is on a tab
DataWindow ldw_DW // Used if control is a DW
str_registered_windows lst_EmptyWin
Long ll_ActiveWindow, ll_FinalX, ll_FinalY
String ls_HelpText

Stop() // Don't want an end-less loop here

IF (NOT ib_ShowHelp) THEN
	// Shouldn't ever get to this point
	Return
END IF

// A little error checking
IF (il_NumWindows < 1) THEN //  The number of windows registered
	Start(idec_TimeInterval)
	Return
END IF

// Get the currently active window for the application via Win32 API
ll_ActiveWindow = GetActiveWindow()
IF (ll_ActiveWindow < 1) THEN
	Start(idec_TimeInterval)
	Return
END IF

IF (ll_ActiveWindow = Handle(iw_MDIWindow)) THEN // iw_MDIWindow should be set in the Open() event of your MDI frame
	// It's the MDI Frame window - get active sheet
	IF (Handle(iw_MDIWindow.GetActiveSheet()) > 0) THEN ll_ActiveWindow = Handle(iw_MDIWindow.GetActiveSheet())
END IF

// Match the handle of the active window with those registered
FOR li_CurrentWindow = 1 TO il_NumWindows
	IF (ist_RegisteredWindows[li_CurrentWindow] = lst_EmptyWin) THEN Continue // Empty slot in array
	IF NOT (IsValid(ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow)) THEN // See if it's still a valid window
		// The window did not call of_unregister when it closed - go ahead and free the record
		ist_RegisteredWindows[li_CurrentWindow] = lst_EmptyWin
		IF (li_CurrentWindow = il_NumWindows) THEN il_NumWindows --
		IF (ib_DebugMessage) THEN MessageBox("BubbleHelp Warning", "A window was found that did not unregister itself")
	END IF
	IF (Handle(ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow) = ll_ActiveWindow) THEN
		lb_Found = True
		Exit
	END IF
NEXT

// An unregistered window set iw_ActiveWindow - not a big deal
IF (NOT lb_Found) THEN
	IF (IsValid(iw_Help)) THEN iw_Help.Visible = False
	is_LastDWCol = ""; SetNull(ido_LastUsed)
	Start(idec_TimeInterval)
	Return
END IF

li_NumControls = UpperBound(ist_RegisteredWindows[li_CurrentWindow].do_Controls)

IF (li_NumControls < 1) THEN
	// No controls for window - should have been deleted
	IF (IsValid(iw_Help)) THEN iw_Help.Visible = False
	is_LastDWCol = ""; SetNull(ido_LastUsed)
	Start(idec_TimeInterval)
	Return
END IF

IF (NOT ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.Enabled) OR &
(NOT ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.Visible) OR &
(ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.WindowState = Minimized!) THEN
	IF (IsValid(iw_Help)) THEN iw_Help.Visible = False
	is_LastDWCol = ""; SetNull(ido_LastUsed)
	Start(idec_TimeInterval)
	Return
END IF

lb_Found = False
FOR li_ControlOn = 1 TO li_NumControls
	IF (NOT IsValid(ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn])) THEN 
		IF (IsValid(iw_Help)) THEN iw_Help.Visible = False
		is_LastDWCol = ""; SetNull(ido_LastUsed)
		Start(idec_TimeInterval)
		IF (ib_DebugMessage) THEN MessageBox("BubbleHelp Error", "An invalid control was found on the window " + ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.ClassName())
		Return
	END IF
	// See if mouse is over one of the controls in our list
	IF (ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].Visible) THEN // Drag object does not have a Enabled property
		IF (ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.PointerY() >= ist_RegisteredWindows[li_CurrentWindow].l_ControlY[li_ControlOn]) AND &
		(ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.PointerY() <= ist_RegisteredWindows[li_CurrentWindow].l_ControlY[li_ControlOn] + ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].Height) AND &
		(ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.PointerX() >= ist_RegisteredWindows[li_CurrentWindow].l_ControlX[li_ControlOn]) AND &
		(ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.PointerX() <= ist_RegisteredWindows[li_CurrentWindow].l_ControlX[li_ControlOn] + ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].Width) THEN
			// If the control is on a tab, then make sure the tabpage it's on is selected
			lb_TabSelected = True
			IF (ist_RegisteredWindows[li_CurrentWindow].i_TabPage[li_ControlOn] > 0) THEN
				FOR li_Counter = 1 TO li_MaxTabPages
					IF (NOT IsNull(ist_RegisteredWindows[li_CurrentWindow].do_TabPage[ist_RegisteredWindows[li_CurrentWindow].i_TabPage[li_ControlOn], li_Counter])) THEN
						// Make sure it's really a tab - this error should never occur.  Put into GraphicObject since it's the lowest level of anscestor
						lgo_Parent = ist_RegisteredWindows[li_CurrentWindow].do_TabPage[ist_RegisteredWindows[li_CurrentWindow].i_TabPage[li_ControlOn], li_Counter].GetParent()
						IF (lgo_Parent.TypeOf() <> Tab!) THEN
							// This has never happened to me (that falls into the good catagory)
							IF (IsValid(iw_Help)) THEN iw_Help.Visible = False
							IF (ib_DebugMessage) THEN
								MessageBox("BubbleHelp Error", "Internal Error - Non-tab object (" + lgo_Parent.ClassName() + ") returned for the UserObject " + &
									ist_RegisteredWindows[li_CurrentWindow].do_TabPage[ist_RegisteredWindows[li_CurrentWindow].i_TabPage[li_ControlOn], li_Counter].ClassName() + " registered as a TabPage for the control " + &
									ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].ClassName())
							END IF
							is_LastDWCol = ""; SetNull(ido_LastUsed)
							Start(idec_TimeInterval)
							Return
						END IF
						ltab_Tab = lgo_Parent // Typecast it so we can use the tab properties
						// See if the tab is selected - if not then loop to the next control
						IF (ltab_Tab.Control[ltab_Tab.SelectedTab] <> ist_RegisteredWindows[li_CurrentWindow].do_TabPage[ist_RegisteredWindows[li_CurrentWindow].i_TabPage[li_ControlOn], li_Counter]) OR &
						(ltab_Tab.Visible = False) OR (ist_RegisteredWindows[li_CurrentWindow].do_TabPage[ist_RegisteredWindows[li_CurrentWindow].i_TabPage[li_ControlOn], li_Counter].Visible = False) THEN
							lb_TabSelected = False
							Exit // Exit out of the inner FOR / NEXT loop since tab is not selected 
						END IF
					END IF
				NEXT
			END IF

			// lb_TabSelected is true if the control is on a tabpage that is currently
			// visible or if the control is not on a tab
			IF (lb_TabSelected) THEN
				// If it's the same control, then just get out here (except for DWs)
				IF (ido_LastUsed = ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn]) THEN
					// If it's a DW, then also check to see if it's the same object / row and a valid
					IF (ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].TypeOf() = DataWindow!) THEN
						// See if same row/ object as last time
						ldw_DW = ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn]
						IF (ldw_DW.GetObjectAtPointer() = is_LastDWCol) THEN
							Start(idec_TimeInterval)
							Return // Same object and row as last time (although it might be blank)
						ELSEIF (ldw_DW.GetObjectAtPointer() = "") THEN
							IF (IsValid(iw_Help)) THEN iw_Help.Visible = False
							is_LastDWCol = ""
							Start(idec_TimeInterval)
							Return // Not a object
						END IF
						is_LastDWCol = ldw_DW.GetObjectAtPointer() // Preserve for next time
					ELSE
						// Same non-DW control - just get out of here
						is_LastDWCol = ""
						Start(idec_TimeInterval)
						Return
					END IF
				END IF

				// New control - display bubblehelp if any (don't count DWs when examining tag
				IF (ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].TypeOf() <> DataWindow!) THEN
					IF (ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].Tag = "") THEN
						Continue // Loop to the next control - this one doesn't have balloon help
					END IF
				END IF
				ido_LastUsed = ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn]
				lb_Found = True
				Exit
			END IF
		END IF
	END IF
NEXT

IF (lb_Found) THEN
	ls_HelpText = of_GetHelpText(ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn])
	IF (ls_HelpText = "") THEN // Nothing to show
		IF (IsValid(iw_Help)) THEN iw_Help.Visible = False
		Start(idec_TimeInterval)
		Return
	END IF

	// Don't SetRedraw() on sheets, MDI frame, or main since it makes it the flicker even worse
	IF (IsValid(iw_MDIWindow)) THEN
		IF (ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow = iw_MDIWindow.GetActiveSheet()) THEN lb_IsSheet = True
	END IF
	// 1.03 - Start of changes
	// Prevent flickering of window when bubble help is moved
	IF (NOT lb_IsSheet) THEN
		ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.SetRedraw(False)
	ELSE
		ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.SetRedraw(False)
		iw_MDIWindow.SetRedraw(False)
	END IF
	// 1.03 - End of changes

	// For this to work, the bubblehelp window must have the active window as it's parent
	IF (NOT IsValid(iw_Help)) THEN
		Open(iw_Help, ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow)
	ELSEIF (iw_Help.ParentWindow() <> ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow) THEN
		IF (IsValid(iw_MDIWindow)) THEN
			// MDI Frame might be the "real" parent window for w_balloonhelp
			IF (ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow <> iw_MDIWindow.GetActiveSheet()) THEN
				Close(iw_Help)
				Open(iw_Help, ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow)
			END IF
		END IF
	END IF

	// Modify the final placement of the bubble help relative to the window
	IF (ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].TypeOf() = DataWindow!) THEN
		// DataWindows get special treatment - put right below pointer
		ll_FinalX = ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.PointerX() + 80
		ll_FinalY = ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.PointerY() + 85
	ELSEIF (ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].TypeOf() = DropDownListBox!) OR &
	(ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].TypeOf() = DropDownPictureListBox!) THEN
		// Drop-down listboxes get special treatment - height includes drop-down list, so put just below the usual height
		ll_FinalX = ist_RegisteredWindows[li_CurrentWindow].l_ControlX[li_ControlOn]
		ll_FinalY = ist_RegisteredWindows[li_CurrentWindow].l_ControlY[li_ControlOn] + 90
	ELSE
		// Put it under the control and a little beyond
		ll_FinalX = ist_RegisteredWindows[li_CurrentWindow].l_ControlX[li_ControlOn]
		ll_FinalY = ist_RegisteredWindows[li_CurrentWindow].l_ControlY[li_ControlOn] + ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn].Height + 10
	END IF
	// Finally - show the bubblehelp
	of_ShowHelp(ist_RegisteredWindows[li_CurrentWindow].do_Controls[li_ControlOn], ll_FinalX, ll_FinalY, ls_HelpText, ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow)
	ist_RegisteredWindows[li_CurrentWindow].w_ParentWindow.SetRedraw(True)
	IF (lb_IsSheet) THEN iw_MDIWindow.SetRedraw(True) // 1.03 - Start and end of change
ELSE
	// Pointer is not over a registered control
	SetNull(ido_LastUsed)
	IF (IsValid(iw_Help)) THEN iw_Help.Visible = False
END IF

Start(idec_TimeInterval) // Over and over and over...

end event


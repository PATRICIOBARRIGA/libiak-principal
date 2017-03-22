HA$PBExportHeader$w_psr_viewer.srw
forward
global type w_psr_viewer from w_sheet_1_dw_rep
end type
type cb_1 from commandbutton within w_psr_viewer
end type
type st_file from statictext within w_psr_viewer
end type
end forward

global type w_psr_viewer from w_sheet_1_dw_rep
integer width = 2784
integer height = 1732
string title = "Archivo PSR"
long backcolor = 67108864
boolean ib_notautoretrieve = true
boolean ib_inreportmode = true
cb_1 cb_1
st_file st_file
end type
global w_psr_viewer w_psr_viewer

type variables
integer ii_minwidth,ii_minheight
end variables

forward prototypes
public subroutine of_change_dw (string as_filename)
end prototypes

public subroutine of_change_dw (string as_filename);//This function will assign the PSR to the DataWindow and size it and the window to the best size for 
//the contents. This is done by searching the columns of the datawindow to find the right most
//width.  The height is determined by the size of the detail band and summary.

Integer			li_column_count, li_counter, li_column_x, li_column_y, 	li_column_width, li_column_height, &
					li_new_width, li_new_height, li_screenwidth, li_screenheight, li_controls, li_index, &
					li_winheight, 	li_winwidth, li_dwheight, li_dwwidth, &
					li_max_x = 0, li_max_y = 0, li_vscroll_width = 78, li_hscroll_height = 69
String			ls_detail_height, ls_header_height, ls_footer_height, ls_summary_height
DragObject	ldo_temp
Environment	le_Environment

//turn redraw off to help avoid flicker
dw_datos.setredraw(false)

//store filename on screen
st_file.text = as_filename


//assign the filename (.psr) to the datawindow dataobject.
dw_datos.dataobject = as_filename

//size window to the new datawindow
//fill sort column list box with column name as defined in the datawindow
li_column_count = Integer(dw_datos.Object.DataWindow.Column.Count)

//loop through all of the columns in the datawindow
For li_counter =  1 To li_column_count
//	Find max x	
	li_column_x = Integer(dw_datos.Describe("#"+string(li_counter)+".X"))
	li_column_width = Integer(dw_datos.Describe("#"+string(li_counter)+".Width"))
	If li_column_x + li_column_width > li_max_x Then
		li_max_x = li_column_x + li_column_width
	End If
Next 

//	Find max y -- get height of detail and summary band
ls_summary_height = dw_datos.Object.Datawindow.Summary.Height
ls_detail_height = dw_datos.Object.Datawindow.Detail.Height
ls_header_height = dw_datos.Object.Datawindow.Header.Height
ls_footer_height = dw_datos.Object.Datawindow.Footer.Height
li_max_y =  Integer(ls_summary_height) + &
				(Integer(ls_detail_height) * 5) + &
				Integer(ls_header_height) +  &
				Integer(ls_footer_height)

//calculate new height and width for datawindow	
li_new_width = dw_datos.X + li_max_x + li_vscroll_width + 25
li_new_height = dw_datos.Y + li_max_y + li_hscroll_height + 25

//min size of datawindow (contraints of the controls on the screen)
If li_new_width < ii_minwidth Then li_new_width = ii_minwidth
If li_new_height < ii_minheight Then li_new_height = ii_minheight

/* get screen measurements */
GetEnvironment(le_Environment)

li_screenheight = PixelsToUnits(le_Environment.screenheight, YPixelsToUnits!)
li_screenwidth = PixelsToUnits(le_Environment.screenwidth, XPixelsToUnits!)

//max size of datawindow (contraints of screen width)
If li_new_width >= li_screenwidth Then
	dw_datos.hscrollbar = true
	li_dwwidth = li_screenwidth - 75
	li_winwidth = li_screenwidth
Else
	dw_datos.hscrollbar = false
	li_dwwidth = li_new_width 
	li_winwidth = li_new_width + dw_datos.X + 75
End If

//max size for vertical (contraint of screen)
If li_new_height >= li_screenheight Then
	li_dwheight = li_screenheight - 350
	li_winheight = li_screenheight
Else
	li_dwheight = li_new_height
	li_winheight = li_new_height + dw_datos.Y + 350
End If

//shift buttons and text to match new window size
//li_controls = upperbound( control[])
//For li_index = 1 to li_controls
//	If Typeof(this.control[li_index]) = CommandButton! Then
//			ldo_temp = this.control[li_index]
//			ldo_temp.Y = li_winheight - (125 + ldo_temp.height)
//	ElseIf  Typeof(this.control[li_index]) = StaticText! Then
//			ldo_temp = this.control[li_index]
//			ldo_temp.Y = li_winheight - (225 +ldo_temp.height)
//	End If
//Next

dw_datos.modify("datawindow.print.preview.zoom=75~t" + "datawindow.print.preview=yes")

//resize window to best fit
this.resize(li_winwidth,li_winheight)		
//move window to be centered based on new size
this.Move((li_ScreenWidth - li_winwidth) / 2, (li_ScreenHeight - li_winheight) / 2)

//resize datawindow to best fit
//dw_datos.resize(li_dwwidth,li_dwheight)

//set redraw back on
dw_datos.setredraw(true)
end subroutine

on w_psr_viewer.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_file=create st_file
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_file
end on

on w_psr_viewer.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_file)
end on

event open;ib_notautoretrieve = true
move(50,50)
//call super::open

end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_psr_viewer
integer x = 64
integer y = 244
integer width = 2619
integer height = 1336
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_psr_viewer
integer x = 2181
integer y = 28
integer width = 521
integer height = 92
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_1 from commandbutton within w_psr_viewer
integer x = 78
integer y = 36
integer width = 690
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleccione archivo *.PSR"
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for cb_select
///////////////////////////////////////////////////////////////////////////////////////////////////////

int li_rc
string ls_path, ls_file
//
//This will open the standard file open dialog box with PSR extensions
li_rc = GetFileOpenName("Select Saved Report File", &
	ls_path,ls_file,"psr","Report File (*.PSR),*.PSR")

If li_rc = 0 Then
	Return
End If

//change the datawindow
of_change_dw(ls_path)

end event

type st_file from statictext within w_psr_viewer
integer x = 123
integer y = 148
integer width = 1984
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type


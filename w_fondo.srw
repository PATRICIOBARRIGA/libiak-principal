HA$PBExportHeader$w_fondo.srw
forward
global type w_fondo from w_sheet
end type
type st_2 from statictext within w_fondo
end type
type st_1 from statictext within w_fondo
end type
type p_1 from picture within w_fondo
end type
type ln_1 from line within w_fondo
end type
type ln_2 from line within w_fondo
end type
type ln_3 from line within w_fondo
end type
end forward

global type w_fondo from w_sheet
integer y = 500
integer width = 4123
integer height = 2816
boolean enabled = false
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 134217729
st_2 st_2
st_1 st_1
p_1 p_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
end type
global w_fondo w_fondo

on w_fondo.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.p_1=create p_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.ln_1
this.Control[iCurrent+5]=this.ln_2
this.Control[iCurrent+6]=this.ln_3
end on

on w_fondo.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

event open;call super::open;w_marco.SetMicrohelp("Libiak ERP. Enterprise Resource Planing.")
end event

type st_2 from statictext within w_fondo
integer x = 96
integer y = 2360
integer width = 1257
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16832471
long backcolor = 0
string text = "Enterprise Resource Planning."
long bordercolor = 134217729
boolean focusrectangle = false
end type

type st_1 from statictext within w_fondo
integer x = 96
integer y = 2088
integer width = 1458
integer height = 212
integer textsize = -36
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16832471
long backcolor = 0
string text = "LIBIAK. ERP."
long bordercolor = 134217729
boolean focusrectangle = false
end type

type p_1 from picture within w_fondo
boolean visible = false
integer x = 2030
integer y = 2380
integer width = 1445
integer height = 140
boolean originalsize = true
string picturename = "Imagenes\Background.jpg"
boolean focusrectangle = false
end type

type ln_1 from line within w_fondo
long linecolor = 16832471
integer linethickness = 4
integer beginx = 91
integer beginy = 2476
integer endx = 1527
integer endy = 2476
end type

type ln_2 from line within w_fondo
long linecolor = 16832471
integer linethickness = 4
integer beginx = 91
integer beginy = 2496
integer endx = 1527
integer endy = 2496
end type

type ln_3 from line within w_fondo
long linecolor = 16832471
integer linethickness = 4
integer beginx = 101
integer beginy = 2516
integer endx = 1527
integer endy = 2516
end type


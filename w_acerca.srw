HA$PBExportHeader$w_acerca.srw
forward
global type w_acerca from window
end type
type st_5 from statictext within w_acerca
end type
type st_1 from statictext within w_acerca
end type
type st_2 from statictext within w_acerca
end type
type st_4 from statictext within w_acerca
end type
type st_3 from statictext within w_acerca
end type
type st_version from statictext within w_acerca
end type
type st_titulo from statictext within w_acerca
end type
type pb_1 from picturebutton within w_acerca
end type
end forward

global type w_acerca from window
integer x = 832
integer y = 356
integer width = 1445
integer height = 800
windowtype windowtype = response!
long backcolor = 81324524
string icon = "Imagenes\Pos.Ico"
st_5 st_5
st_1 st_1
st_2 st_2
st_4 st_4
st_3 st_3
st_version st_version
st_titulo st_titulo
pb_1 pb_1
end type
global w_acerca w_acerca

event open;//st_titulo.TEXT = aplicacion.aplicacion
//st_version.TEXT = 'Versi$$HEX1$$f300$$ENDHEX$$n ' + gs_version
end event

on w_acerca.create
this.st_5=create st_5
this.st_1=create st_1
this.st_2=create st_2
this.st_4=create st_4
this.st_3=create st_3
this.st_version=create st_version
this.st_titulo=create st_titulo
this.pb_1=create pb_1
this.Control[]={this.st_5,&
this.st_1,&
this.st_2,&
this.st_4,&
this.st_3,&
this.st_version,&
this.st_titulo,&
this.pb_1}
end on

on w_acerca.destroy
destroy(this.st_5)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_version)
destroy(this.st_titulo)
destroy(this.pb_1)
end on

type st_5 from statictext within w_acerca
integer x = 562
integer y = 704
integer width = 603
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
string text = "patricio.barriga@gmail.com"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_acerca
integer x = 169
integer y = 644
integer width = 969
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
string text = "Contactos email: edi_vasquez@yahoo.es"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_acerca
integer x = 151
integer y = 580
integer width = 997
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
string text = "Copyright $$HEX2$$ae002000$$ENDHEX$$Libiak E.V.- P.B. 2007"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_acerca
integer x = 411
integer y = 28
integer width = 475
integer height = 120
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "LIBIAK"
alignment alignment = center!
long bordercolor = 81324524
boolean focusrectangle = false
end type

type st_3 from statictext within w_acerca
integer x = 425
integer y = 504
integer width = 398
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Quito - Ecuador"
boolean focusrectangle = false
end type

type st_version from statictext within w_acerca
integer x = 174
integer y = 268
integer width = 1019
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Versi$$HEX1$$f300$$ENDHEX$$n 10G_VR Build 021007 DXC"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_titulo from statictext within w_acerca
integer x = 224
integer y = 160
integer width = 1161
integer height = 96
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 81324524
boolean enabled = false
string text = "Enlace&Software Cia. Ltda."
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_acerca
integer x = 535
integer y = 340
integer width = 178
integer height = 152
integer taborder = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
boolean default = true
string picturename = "Imagenes\About.Gif"
end type

on clicked;close(parent)
end on


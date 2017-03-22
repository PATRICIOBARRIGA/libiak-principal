HA$PBExportHeader$w_login.srw
forward
global type w_login from w_response_basic
end type
type cbx_opt_info from checkbox within w_login
end type
type p_logo from picture within w_login
end type
type st_1 from statictext within w_login
end type
type st_2 from statictext within w_login
end type
type r_1 from rectangle within w_login
end type
type p_1 from picture within w_login
end type
end forward

global type w_login from w_response_basic
integer x = 901
integer y = 500
integer width = 2633
integer height = 1764
string title = "Conexi$$HEX1$$f300$$ENDHEX$$n al Sistema"
long backcolor = 67108864
cbx_opt_info cbx_opt_info
p_logo p_logo
st_1 st_1
st_2 st_2
r_1 r_1
p_1 p_1
end type
global w_login w_login

type variables
int ii_intentos = 0
end variables

on w_login.create
int iCurrent
call super::create
this.cbx_opt_info=create cbx_opt_info
this.p_logo=create p_logo
this.st_1=create st_1
this.st_2=create st_2
this.r_1=create r_1
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_opt_info
this.Control[iCurrent+2]=this.p_logo
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.r_1
this.Control[iCurrent+6]=this.p_1
end on

on w_login.destroy
call super::destroy
destroy(this.cbx_opt_info)
destroy(this.p_logo)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.r_1)
destroy(this.p_1)
end on

event open;call super::open;string ls_username

st_1.textcolor = rgb(255,217,128)
st_2.textcolor = rgb(255,217,128)
//r_1.FillColor = rgb(0,85,229)
//r_1.LineColor = rgb(61,149,255)
ls_username = profileString(str_appgeninfo.ini_file, "database", "userid", "")
if ls_username <> "" then
	dw_response.setItem(1, "username", ls_username)
	dw_response.setColumn("password")
end if
dw_response.setItem(1,"caja",ProfileString(str_appgeninfo.ini_file,"Opciones","caja",""))
dw_response.setItem(1,"empresa",ProfileString(str_appgeninfo.ini_file,"Opciones","empresa",""))
dw_response.setItem(1,"sucursal",ProfileString(str_appgeninfo.ini_file,"Opciones","sucursal",""))
dw_response.setItem(1, "dbms", profileString(str_appgeninfo.ini_file, "database", "dbms", ""))
dw_response.setItem(1, "servername",profileString(str_appgeninfo.ini_file, "database", "server", ""))
dw_response.setItem(1, "databasename",profileString(str_appgeninfo.ini_file, "database", "database", ""))

end event

type pb_cancel from w_response_basic`pb_cancel within w_login
integer x = 1952
integer y = 936
integer width = 183
integer height = 160
end type

event pb_cancel::clicked;str_appgeninfo.username = ""
close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_login
integer x = 1710
integer y = 940
boolean originalsize = false
end type

event pb_ok::clicked;long ll_curRow

if ii_intentos > 2 then 
	MESSAGEBOX('Acceso negado a SIF','Ha excedido el n$$HEX1$$fa00$$ENDHEX$$mero m$$HEX1$$e100$$ENDHEX$$ximo de intentos. Adi$$HEX1$$f300$$ENDHEX$$s.',Exclamation!)
	halt close
end if 


if dw_response.acceptText() = -1 then
	dw_response.setFocus()
	return
end if

ll_curRow = dw_response.getRow()
if ll_curRow < 1 then
	messageBox("Error Fatal", &
			"No se puede hallar la fila actual de la ventana de conexi$$HEX1$$f300$$ENDHEX$$n", StopSign!)
	halt
end if

str_appgeninfo.caja = dw_response.getItemString(ll_curRow, "caja")
str_appgeninfo.empresa = dw_response.getItemString(ll_curRow, "empresa")
str_appgeninfo.sucursal = dw_response.getItemString(ll_curRow, "sucursal")
str_appgeninfo.username = dw_response.getItemString(ll_curRow, "username")
str_appgeninfo.password = dw_response.getItemString(ll_curRow, "password")
str_appgeninfo.dbms = dw_response.getItemString(ll_curRow, "dbms")
str_appgeninfo.servername = dw_response.getItemString(ll_curRow, "servername")
str_appgeninfo.databasename = dw_response.getItemString(ll_curRow, "databasename")

If f_get_user_codecompany() = 1 then
	gs_titulo_marco = st_1.text 
	close(parent)
else
	ii_intentos++
	dw_response.setFocus()
	dw_response.selecttext(1,len(dw_response.getitemstring(1,"password")))
end if

end event

type dw_response from w_response_basic`dw_response within w_login
integer x = 1243
integer y = 384
integer width = 1070
integer height = 248
string dataobject = "d_login"
end type

type cbx_opt_info from checkbox within w_login
integer x = 1714
integer y = 1104
integer width = 407
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
long backcolor = 80269524
string text = "&Info opcional"
end type

event clicked;int li_databasename_y
int li_password_y
int li_height_diff

li_password_y = integer(dw_response.describe("password.y"))
li_databasename_y = integer(dw_response.describe("databasename.y"))

if this.checked then
	li_height_diff = li_databasename_y - li_password_y
	dw_response.setTabOrder("dbms", 30)
	dw_response.setTabOrder("servername", 40)
	dw_response.setTabOrder("databasename", 50)
else
	li_height_diff = li_password_y - li_databasename_y
	dw_response.setTabOrder("dbms", 0)
	dw_response.setTabOrder("servername", 0)
	dw_response.setTabOrder("databasename", 0)
end if

//parent.height += li_height_diff
//parent.setRedraw(False)
dw_response.height += li_height_diff
//pb_ok.y += li_height_diff
//pb_cancel.y += li_height_diff
//this.y += li_height_diff
//parent.setRedraw(True)

end event

type p_logo from picture within w_login
boolean visible = false
integer x = 114
integer y = 1024
integer width = 731
integer height = 480
boolean bringtotop = true
string picturename = "Imagenes\Empresa.gif"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_login
boolean visible = false
integer x = 82
integer y = 792
integer width = 855
integer height = 136
boolean bringtotop = true
integer textsize = -20
integer weight = 700
fontcharset fontcharset = oem!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Roman"
boolean italic = true
long textcolor = 32896
long backcolor = 0
string text = "LIBIAK ERP."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_login
boolean visible = false
integer x = 82
integer y = 932
integer width = 827
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 32896
long backcolor = 0
string text = "Enterprise Resource Planning"
alignment alignment = center!
boolean focusrectangle = false
end type

type r_1 from rectangle within w_login
boolean visible = false
integer linethickness = 1
integer x = 37
integer y = 780
integer width = 910
integer height = 828
end type

type p_1 from picture within w_login
integer width = 2629
integer height = 1680
string picturename = "imagenes\logo.jpg"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type


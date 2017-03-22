HA$PBExportHeader$w_res_cliente_generico.srw
forward
global type w_res_cliente_generico from window
end type
type pb_2 from picturebutton within w_res_cliente_generico
end type
type pb_1 from picturebutton within w_res_cliente_generico
end type
type dw_1 from datawindow within w_res_cliente_generico
end type
end forward

global type w_res_cliente_generico from window
integer width = 1737
integer height = 676
boolean titlebar = true
string title = "Ingreso de Cliente Gen$$HEX1$$e900$$ENDHEX$$rico"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
pb_2 pb_2
pb_1 pb_1
dw_1 dw_1
end type
global w_res_cliente_generico w_res_cliente_generico

on w_res_cliente_generico.create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_1=create dw_1
this.Control[]={this.pb_2,&
this.pb_1,&
this.dw_1}
end on

on w_res_cliente_generico.destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_1)
end on

event open;string ls_fecha, ls_codcli
this.move(1000,300)
dw_1.settransobject(sqlca)

if mid(gs_empresa,1,5) = 'TRECX' THEN
	ls_codcli = '7839'
else
	ls_codcli = '2'
END IF 
dw_1.retrieve(str_appgeninfo.empresa,ls_codcli)


end event

type pb_2 from picturebutton within w_res_cliente_generico
integer x = 489
integer y = 388
integer width = 174
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;string ls_cliente,ls_codigo

dw_1.accepttext()
ls_cliente = dw_1.getitemstring(1,"ce_nombre")
ls_cliente = ls_cliente +' '+dw_1.getitemstring(1,"ce_apelli")
ls_codigo = dw_1.getitemstring(1,"ce_codigo")
dw_1.setitem(1,"ce_razons",upper(ls_cliente))
dw_1.update()
close(parent)
//closewithreturn(parent,ls_codigo)


end event

type pb_1 from picturebutton within w_res_cliente_generico
integer x = 1134
integer y = 388
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\Cancel.Gif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_res_cliente_generico
integer x = 23
integer y = 52
integer width = 1682
integer height = 300
integer taborder = 10
string dataobject = "d_cliente_generico"
boolean border = false
boolean livescroll = true
end type


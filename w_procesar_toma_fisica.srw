HA$PBExportHeader$w_procesar_toma_fisica.srw
$PBExportComments$Si.
forward
global type w_procesar_toma_fisica from window
end type
type st_2 from statictext within w_procesar_toma_fisica
end type
type sle_1 from singlelineedit within w_procesar_toma_fisica
end type
type st_1 from statictext within w_procesar_toma_fisica
end type
type dw_i from datawindow within w_procesar_toma_fisica
end type
type cb_1 from commandbutton within w_procesar_toma_fisica
end type
type pb_2 from picturebutton within w_procesar_toma_fisica
end type
type pb_1 from picturebutton within w_procesar_toma_fisica
end type
type dw_1 from datawindow within w_procesar_toma_fisica
end type
type dw_cantpos_mal from datawindow within w_procesar_toma_fisica
end type
type dw_cant_mal from datawindow within w_procesar_toma_fisica
end type
end forward

global type w_procesar_toma_fisica from window
string tag = "Procesando toma f$$HEX1$$ed00$$ENDHEX$$sica"
integer y = 264
integer width = 5399
integer height = 1780
boolean titlebar = true
string title = "Procesar toma f$$HEX1$$ed00$$ENDHEX$$sica 04012014"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_2 st_2
sle_1 sle_1
st_1 st_1
dw_i dw_i
cb_1 cb_1
pb_2 pb_2
pb_1 pb_1
dw_1 dw_1
dw_cantpos_mal dw_cantpos_mal
dw_cant_mal dw_cant_mal
end type
global w_procesar_toma_fisica w_procesar_toma_fisica

event open;dw_cant_mal.SetTransObject(sqlca)
dw_cantpos_mal.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
dw_i.SetTransObject(sqlca)
dw_1.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
end event

on w_procesar_toma_fisica.create
this.st_2=create st_2
this.sle_1=create sle_1
this.st_1=create st_1
this.dw_i=create dw_i
this.cb_1=create cb_1
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_1=create dw_1
this.dw_cantpos_mal=create dw_cantpos_mal
this.dw_cant_mal=create dw_cant_mal
this.Control[]={this.st_2,&
this.sle_1,&
this.st_1,&
this.dw_i,&
this.cb_1,&
this.pb_2,&
this.pb_1,&
this.dw_1,&
this.dw_cantpos_mal,&
this.dw_cant_mal}
end on

on w_procesar_toma_fisica.destroy
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.dw_i)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.dw_cantpos_mal)
destroy(this.dw_cant_mal)
end on

type st_2 from statictext within w_procesar_toma_fisica
integer x = 4000
integer y = 40
integer width = 361
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ubicar producto"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_procesar_toma_fisica
integer x = 4407
integer y = 32
integer width = 745
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;long ll_find


ll_find = dw_i.Find("it_codant = '"+this.text+"'",1,dw_i.rowcount())


dw_i.SelectRow(0, false)
If ll_find <> 0 then 
dw_i.ScrollToRow(ll_find)
dw_i.SelectRow(ll_find, true)
dw_i.SetRow(ll_find)
End if
Return 0
end event

type st_1 from statictext within w_procesar_toma_fisica
integer x = 1687
integer y = 52
integer width = 448
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inconsistencias"
boolean focusrectangle = false
end type

type dw_i from datawindow within w_procesar_toma_fisica
integer x = 1669
integer y = 128
integer width = 3680
integer height = 1544
integer taborder = 20
string title = "none"
string dataobject = "d_rep_inconsistencias"
boolean hsplitscroll = true
boolean livescroll = true
end type

event retrieveend;this.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"' st_seccion = '"+gs_bo_nombre+"'")
end event

type cb_1 from commandbutton within w_procesar_toma_fisica
integer x = 850
integer y = 1556
integer width = 754
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ver inconsistencias"
end type

event clicked;String ls_marca,ls_numtot[]
Integer i

for i = 1 to dw_1.RowCount()
	 ls_marca = dw_1.GetItemString(i,"marca")
	 If ls_marca = 'S' Then
     ls_numtot[i]  =  dw_1.GetItemString(i,"ts_numero")
	 End if	
next 	
dw_i.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_numtot)
end event

type pb_2 from picturebutton within w_procesar_toma_fisica
integer x = 389
integer y = 1496
integer width = 183
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\Cancel.Gif"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

type pb_1 from picturebutton within w_procesar_toma_fisica
integer x = 91
integer y = 1500
integer width = 183
integer height = 160
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean flatstyle = true
boolean originalsize = true
string picturename = "Imagenes\Ok.Gif"
alignment htextalign = left!
end type

event clicked;String   ls_marca,ls_numero,ls_numtot[ ],&
            ls_usuario,ls_clave,ls_epcodigo,ls_tomas
Long     ll_nreg
int         i,li_sino


dw_1.AcceptText( )
dw_cant_mal.visible = true
dw_cantpos_mal.visible = true
dw_1.visible = true

for i = 1 to dw_1.RowCount()
	 ls_marca = dw_1.GetItemString(i,"marca")
	 If ls_marca = 'S' Then
      ls_numtot[ i ]  =  dw_1.GetItemString(i,"ts_numero")
	 ls_tomas = ls_tomas + dw_1.GetItemString(i,"ts_numero")+','
	 End if	
next 	


ll_nreg = dw_cant_mal.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_numtot)
if ll_nreg > 0 Then
	dw_1.visible = false
	dw_cant_mal.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'"+&
							 "st_seccion.text = '"+gs_bo_nombre+"'")
	dw_cant_mal.visible = true
	Messagebox("Error","La cantidad de este(os) producto(s) en la toma f$$HEX1$$ed00$$ENDHEX$$sica.~r~n"+&
                      "esta(n) mal ingresado(s)...verifique") 
	return									 
end if

ll_nreg = dw_cantpos_mal.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,ls_numtot)
if ll_nreg > 0 Then
	dw_1.visible = false	
	dw_cantpos_mal.modify("st_empresa.text = '"+gs_empresa+"' st_sucursal.text = '"+gs_su_nombre+"'"+&
							 "st_seccion.text = '"+gs_bo_nombre+"'")
	dw_cantpos_mal.visible = true
	if Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","La cantidad de este(os) producto(s) en la toma f$$HEX1$$ed00$$ENDHEX$$sica.~r~n"+&
                "puede que este(n) mal ingresado(s)...Desea continuar",Question!,yesno!,2) = 2 Then
		return									 
	end if
end if

dw_cantpos_mal.visible = false
dw_1.visible = true

if Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Este proceso cargar$$HEX2$$e1002000$$ENDHEX$$al inventario lo registrado en la toma f$$HEX1$$ed00$$ENDHEX$$sica.~r~n"+&
                            "Est$$HEX2$$e1002000$$ENDHEX$$seguro de realizar el proceso",Question!,yesno!,2)= 2 &
then
return
end if 


select ep_codigo
into  :ls_epcodigo
from  no_emple
where em_codigo = :str_appgeninfo.empresa
and sa_login = :str_appgeninfo.username
and ep_nonom = 'S';

If sqlca.sqlcode < 0 Then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Problemas al validar el Empleado." +sqlca.sqlerrtext)
Return
End if 	

f_toma_fisica(ls_numtot,ls_epcodigo)

// En la aplicacion creamos:
//ls_tomas = ls_tomas+'99999'
//DECLARE sp_tomfis PROCEDURE FOR sp_inv_tomafisica(:str_appgeninfo.empresa,:str_appgeninfo.sucursal,:str_appgeninfo.seccion,:ls_tomas,:ls_epcodigo);
//EXECUTE sp_tomfis;
//if sqlca.sqlcode = -1 then
// rollback;	
// messagebox("Error","No se pudo ejecutar el procedimiento SP_INV_TOMAFISICA~n"+sqlca.sqlerrtext)
//else
// messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Procesado ejecutado exitosamente...~n"+sqlca.sqlerrtext)
// commit;
//end if




end event

type dw_1 from datawindow within w_procesar_toma_fisica
integer x = 64
integer y = 60
integer width = 1541
integer height = 1416
integer taborder = 10
string title = "none"
string dataobject = "d_sel_tickets_toma_fisica"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_cantpos_mal from datawindow within w_procesar_toma_fisica
boolean visible = false
integer x = 480
integer y = 1212
integer width = 882
integer height = 260
integer taborder = 70
string title = "none"
string dataobject = "d_tf_cant_posible_mal"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_cant_mal from datawindow within w_procesar_toma_fisica
boolean visible = false
integer x = 101
integer y = 1196
integer width = 329
integer height = 272
integer taborder = 60
string title = "none"
string dataobject = "d_tf_cant_mal"
boolean vscrollbar = true
boolean livescroll = true
end type


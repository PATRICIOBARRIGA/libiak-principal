HA$PBExportHeader$w_exportar_items.srw
$PBExportComments$Si.
forward
global type w_exportar_items from w_response_basic
end type
type st_1 from statictext within w_exportar_items
end type
type p_1 from picture within w_exportar_items
end type
type dw_1 from datawindow within w_exportar_items
end type
type dw_2 from datawindow within w_exportar_items
end type
type dw_3 from datawindow within w_exportar_items
end type
type dw_4 from datawindow within w_exportar_items
end type
end forward

global type w_exportar_items from w_response_basic
integer width = 1650
integer height = 544
string title = "Generar archivo de items"
st_1 st_1
p_1 p_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
end type
global w_exportar_items w_exportar_items

on w_exportar_items.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_1=create p_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_4
end on

on w_exportar_items.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
end on

type pb_cancel from w_response_basic`pb_cancel within w_exportar_items
integer x = 946
integer y = 236
integer width = 352
integer height = 92
integer taborder = 50
string text = "&No"
string picturename = ""
end type

event pb_cancel::clicked;close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_exportar_items
integer x = 411
integer y = 236
integer width = 352
integer height = 92
integer taborder = 40
string text = "&Si"
string picturename = ""
end type

event pb_ok::clicked;call super::clicked;/* Proceso de Actualizacion de Precios
Modificado: 05/12/2202*/
string ls_codigo

SetPointer(HourGlass!)

select it_codigo
into:ls_codigo
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_kit = 'S'
minus
select it_codigo1
from in_relitem
where em_codigo = :str_appgeninfo.empresa
and tr_codigo = '1';

if sqlca.sqlcode <> 100 Then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las tablas in_item e in_relitem no concuerdan en cantidad")
	return
End if

select it_codigo1
into:ls_codigo
from in_relitem
where em_codigo = :str_appgeninfo.empresa
and tr_codigo = '1'
minus
select it_codigo
from in_item
where em_codigo = :str_appgeninfo.empresa
and it_kit = 'S';

if sqlca.sqlcode <> 100 Then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Las tablas in_relitem e in_Item no concuerdan en cantidad" +sqlca.sqlerrtext)
	return
End if

dw_2.SetTransObject(sqlca)
dw_2.Retrieve(str_appgeninfo.empresa)

dw_3.SetTransObject(sqlca)
dw_3.Retrieve(str_appgeninfo.empresa)

dw_1.SetTransObject(sqlca)
dw_1.Retrieve(str_appgeninfo.empresa)

dw_4.SetTransObject(sqlca)
dw_4.Retrieve(str_appgeninfo.empresa)

dw_response.SetTransObject(sqlca)
dw_response.Retrieve(str_appgeninfo.empresa)

dw_1.SaveAs('c:\libiak\ARCHIVOS\Tippre.TXT',Text!,FALSE)
dw_3.SaveAs('c:\libiak\ARCHIVOS\Relitem.TXT',Text!,FALSE)
dw_2.SaveAs('c:\libiak\ARCHIVOS\Descitem.TXT',Text!,FALSE)
dw_response.SaveAs('c:\libiak\ARCHIVOS\Items.TXT',Text!,FALSE)
dw_4.SaveAs('c:\libiak\ARCHIVOS\Fabricante.TXT',Text!,FALSE)

MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Los archivos:~n"+&
           "Items.TXT~nFabricante.TXT~nTippre.TXT~nDescitem.TXT~nRelitem.TXT~nest$$HEX1$$e100$$ENDHEX$$n en la carpeta C:\libiak\ARCHIVOS")
close(parent)
w_marco.setmicrohelp("Proceso terminado")
end event

type dw_response from w_response_basic`dw_response within w_exportar_items
boolean visible = false
integer x = 146
integer y = 460
integer width = 206
integer height = 52
boolean enabled = false
string dataobject = "d_in_item"
end type

type st_1 from statictext within w_exportar_items
integer x = 224
integer y = 72
integer width = 1367
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Desea generar el archivo de exportaci$$HEX1$$f300$$ENDHEX$$n de items"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_exportar_items
integer x = 46
integer y = 44
integer width = 174
integer height = 152
boolean bringtotop = true
string picturename = "Imagenes\Question.Gif"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_exportar_items
boolean visible = false
integer x = 370
integer y = 460
integer width = 206
integer height = 52
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_in_tippre"
boolean border = false
boolean livescroll = true
end type

type dw_2 from datawindow within w_exportar_items
boolean visible = false
integer x = 599
integer y = 460
integer width = 206
integer height = 52
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_in_descitem"
boolean border = false
boolean livescroll = true
end type

type dw_3 from datawindow within w_exportar_items
boolean visible = false
integer x = 832
integer y = 460
integer width = 206
integer height = 52
integer taborder = 13
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_in_relitem"
boolean border = false
end type

type dw_4 from datawindow within w_exportar_items
boolean visible = false
integer x = 1065
integer y = 460
integer width = 206
integer height = 52
integer taborder = 23
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_in_fabricante"
boolean border = false
boolean livescroll = true
end type


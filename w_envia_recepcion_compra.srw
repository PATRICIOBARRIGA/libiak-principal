HA$PBExportHeader$w_envia_recepcion_compra.srw
$PBExportComments$Si.
forward
global type w_envia_recepcion_compra from w_response_basic
end type
type st_1 from statictext within w_envia_recepcion_compra
end type
type p_1 from picture within w_envia_recepcion_compra
end type
type dw_1 from datawindow within w_envia_recepcion_compra
end type
type dw_2 from datawindow within w_envia_recepcion_compra
end type
end forward

global type w_envia_recepcion_compra from w_response_basic
integer width = 1746
integer height = 520
string title = "Proceso de actualizaci$$HEX1$$f300$$ENDHEX$$n de items"
st_1 st_1
p_1 p_1
dw_1 dw_1
dw_2 dw_2
end type
global w_envia_recepcion_compra w_envia_recepcion_compra

on w_envia_recepcion_compra.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_1=create p_1
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
end on

on w_envia_recepcion_compra.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type pb_cancel from w_response_basic`pb_cancel within w_envia_recepcion_compra
integer x = 910
integer y = 260
integer width = 398
integer height = 100
integer taborder = 40
string text = "&No"
string picturename = ""
end type

event pb_cancel::clicked;close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_envia_recepcion_compra
integer x = 453
integer y = 260
integer width = 398
integer height = 96
integer taborder = 30
string text = "&Si"
string picturename = ""
end type

event pb_ok::clicked;call super::clicked;/////////////////////////////////////////////////////////////////////////////////////
// Descripci$$HEX1$$f300$$ENDHEX$$n : copia las cabeceras y detalle de las notas de recepci$$HEX1$$f300$$ENDHEX$$n
//
// Fecha de revisi$$HEX1$$f300$$ENDHEX$$n : 06/04/1999  19:27
/////////////////////////////////////////////////////////////////////////////////////

string   ls_nombre_archivo,ls_empresa,ls_sucursal,ls_bodega
long     ll_total_reg,ll_i,ll_numero,ll_numreg,ll_posicion

SetPointer(HourGlass!)

// recupera todas las cabeceras de las compras

dw_response.SetTransObject(sqlca)
ll_total_reg = dw_response.Retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
ls_nombre_archivo = 'Archivos\Cab_nrc'+str_appgeninfo.sucursal+'.TXT'

// graba la cabecera a un archivo
dw_response.SaveAs(ls_nombre_archivo,Text!,FALSE)

dw_2.SetTransObject(sqlca)
ll_posicion = 1

// por cada fila de la cabecera recupero el detalle y lo almaceno en dw_1 
// todas las filas del detalle

for ll_i = 1 to ll_total_reg
	ls_empresa  = dw_response.GetItemString(ll_i,"em_codigo")
	ls_sucursal = dw_response.GetItemString(ll_i,"su_codigo")
	ls_bodega   = str_appgeninfo.seccion
	ll_numero   = dw_response.GetItemNumber(ll_i,"co_numero")
	ll_numreg = dw_2.Retrieve(ls_empresa,ls_sucursal,ls_bodega,ll_numero)
	dw_2.RowsCopy(1,ll_numreg,Primary!,dw_1,ll_posicion,Primary!)
	ll_posicion = ll_posicion + ll_numreg + 1
next

//dw_1.SetTransObject(sqlca)
//dw_1.Retrieve(str_appgeninfo.empresa)

// Guardo el detalle de todas las notas de recepci$$HEX1$$f300$$ENDHEX$$n en el archivo
ls_nombre_archivo = 'Archivos\Det_nrc'+str_appgeninfo.sucursal+'.TXT'
dw_1.SaveAs(ls_nombre_archivo,Text!,FALSE)

// en la cabecera de las compras actualizo co_enviada a 'S'
for ll_i = 1 to ll_total_reg
	dw_response.SetItem(ll_i,"co_enviada",'S')
next

// actualizo las cabeceras 
dw_response.Update()
commit;

SetPointer(Arrow!)

close(parent)
end event

type dw_response from w_response_basic`dw_response within w_envia_recepcion_compra
boolean visible = false
integer x = 59
integer y = 420
integer width = 338
integer height = 72
boolean enabled = false
string dataobject = "d_archivo_plano_cab_compra"
end type

type st_1 from statictext within w_envia_recepcion_compra
integer x = 261
integer y = 64
integer width = 1431
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 81324524
boolean enabled = false
string text = "Desea generar el archivo de envio de recepciones de compra"
boolean focusrectangle = false
end type

type p_1 from picture within w_envia_recepcion_compra
integer x = 59
integer y = 56
integer width = 169
integer height = 148
boolean bringtotop = true
string picturename = "Imagenes\Question.Gif"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_envia_recepcion_compra
boolean visible = false
integer x = 448
integer y = 420
integer width = 338
integer height = 72
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_archivo_plano_det_compra"
boolean border = false
end type

type dw_2 from datawindow within w_envia_recepcion_compra
boolean visible = false
integer x = 837
integer y = 420
integer width = 338
integer height = 72
integer taborder = 12
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_detalle_nota_recepcion_compra"
boolean border = false
end type


HA$PBExportHeader$w_rep_resumen_de_ventas.srw
$PBExportComments$Reporte Resumido de Ventas por Vendedor y Agrupado por meses
forward
global type w_rep_resumen_de_ventas from w_sheet_1_dw_rep
end type
type rb_2 from radiobutton within w_rep_resumen_de_ventas
end type
type rb_1 from radiobutton within w_rep_resumen_de_ventas
end type
type dw_cabecera from datawindow within w_rep_resumen_de_ventas
end type
end forward

global type w_rep_resumen_de_ventas from w_sheet_1_dw_rep
integer x = 5
integer y = 228
integer width = 2971
integer height = 1908
string title = "Res$$HEX1$$fa00$$ENDHEX$$men de Ventas Por Vendedor"
long backcolor = 79741120
rb_2 rb_2
rb_1 rb_1
dw_cabecera dw_cabecera
end type
global w_rep_resumen_de_ventas w_rep_resumen_de_ventas

type variables

end variables

on w_rep_resumen_de_ventas.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_cabecera=create dw_cabecera
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.dw_cabecera
end on

on w_rep_resumen_de_ventas.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_cabecera)
end on

event open;datawindowchild ldwc_aux,ldwc_aux1,ldwc_aux2,ldwc_aux3

dw_cabecera.settransobject(sqlca)
dw_datos.settransobject(sqlca)
//f_recupera_empresa(dw_cabecera,'sucursal')
//f_recupera_empresa(dw_cabecera,'fabricante')

//dw_cabecera.getChild('sucursal', ldwc_aux)
//ldwc_aux.setTransObject(sqlca)
//if ldwc_aux.retrieve(str_appgeninfo.empresa) < 0 then 
//else 
//	ldwc_aux.InsertRow(0)
//end if

dw_cabecera.getChild('cliente', ldwc_aux3)
ldwc_aux3.setTransObject(sqlca)
if ldwc_aux3.retrieve(str_appgeninfo.empresa) < 0 then 
else 
	ldwc_aux3.InsertRow(0)
end if

dw_cabecera.insertrow(0)
this.ib_notautoretrieve = true
call super::open
end event

event ue_retrieve;string   ls_empresa,ls_sucursal,ls_cliente,ls_fecha_inicio,ls_fecha_fin
char lch_todos
double   ld_filas_recuperadas
integer  li_anio,li_estado
date     ld_fecha_inicio,ld_fecha_fin

setpointer(hourglass!)
dw_cabecera.accepttext()
if dw_cabecera.Rowcount() <=0 then
	messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","Olvid$$HEX2$$f3002000$$ENDHEX$$ingresar las condiciones de b$$HEX1$$fa00$$ENDHEX$$squeda.")
	return
end if
ld_fecha_inicio = dw_cabecera.GetitemDate(1,"fecha_ini")
ls_fecha_inicio = string(ld_fecha_inicio,'dd/mm/yyyy')
if isnull(ls_fecha_inicio) or ls_fecha_inicio = "" then
	messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","Debe Ingresar la Fecha Inicial.")
	return
end if
ld_fecha_fin = dw_cabecera.GetitemDate(1,"Fecha_fin")
ls_fecha_fin = string(ld_fecha_fin,'dd/mm/yyyy')
if isnull(ls_fecha_fin) or ls_fecha_fin = "" then
	messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","Debe Ingresar la Fecha Final.")
	return
end if
If rb_1.checked = true Then
	li_estado = 2
End if
If rb_2.checked = true Then
	li_estado = 1
End if

w_marco.SetMicroHelp('Espere por Favor... Se esta recuperando la informaci$$HEX1$$f300$$ENDHEX$$n solicitada.........')
dw_datos.reset()
dw_datos.setredraw(false)
lch_todos = dw_cabecera.GetitemString(1,"todos")
If isnull(lch_todos) or lch_todos = '0' then
	ls_cliente = dw_cabecera.GetitemString(1,"cliente")
	if ls_cliente = "" or isnull(ls_cliente) then
		messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","Debe Seleccionar un Cliente.")
		return
	end if
    dw_datos.dataobject = "d_rep_unid_vendidas_asesorxcliente"
    dw_datos.settransobject(sqlca)		
    ld_filas_recuperadas = dw_datos.retrieve(li_estado,ld_fecha_inicio,ld_fecha_fin,ls_cliente)	
else
   dw_datos.dataobject = "d_rep_unid_vendidas_mes_asesorxclientes"
   dw_datos.settransobject(sqlca)
   ld_filas_recuperadas = dw_datos.retrieve(integer(str_appgeninfo.empresa),li_estado,ld_fecha_inicio,ld_fecha_fin)
End if

if ld_filas_recuperadas <=0 then
	messagebox("Informaci$$HEX1$$f300$$ENDHEX$$n...","No existen datos con las condiciones Ingresadas.")	
	dw_datos.setredraw(true)
	return
end if
dw_datos.modify("st_empresa.text = '"+gs_empresa+"' datawindow.print.preview='yes'")
dw_datos.setredraw(true)
w_marco.SetMicroHelp('Listo.')
setpointer(arrow!)

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_cabecera.resize(li_width - 2*dw_cabecera.x, dw_cabecera.height)
dw_datos.resize(dw_cabecera.width,li_height - dw_datos.y - dw_cabecera.y)
this.setRedraw(True)
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_resumen_de_ventas
integer x = 0
integer y = 276
integer width = 2862
integer height = 1524
integer taborder = 40
string dataobject = "d_rep_unid_vendidas_asesorxcliente"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_resumen_de_ventas
integer x = 41
integer y = 612
integer width = 251
integer height = 220
integer taborder = 0
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_resumen_de_ventas
integer x = 41
integer y = 264
integer width = 297
integer height = 240
end type

type rb_2 from radiobutton within w_rep_resumen_de_ventas
integer x = 2144
integer y = 164
integer width = 343
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Facturaci$$HEX1$$f300$$ENDHEX$$n"
end type

type rb_1 from radiobutton within w_rep_resumen_de_ventas
integer x = 2144
integer y = 80
integer width = 215
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "POS"
end type

type dw_cabecera from datawindow within w_rep_resumen_de_ventas
integer width = 2862
integer height = 276
integer taborder = 30
string dataobject = "d_rep_cab_resumen_de_ventas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;string ls_sucursal, ls_filtro,ls_nomcli
char lch_todos
datawindowchild ldwc_bodega

if dwo.name = "cliente" then
   select ltrim(decode(ce_razons,null,ce_nombre||'  '||ce_apelli,ce_razons||' '||ce_nomrep||' '||ce_aperep))
	into :ls_nomcli
	from fa_clien
	where em_codigo = :str_appgeninfo.empresa
	and ce_codigo = :data;
	
	If sqlca.sqlcode = 100 then
		messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Cliente no registrado")
   	return 1
	End if  
	this.modify(" st_cliente.text ='"+ls_nomcli+"'")
end if




If dwo.name = "todos" Then
	lch_todos = data
     If lch_todos = '1' Then
		this.setitem(1,"cliente",'')
		this.settaborder("cliente",0)
	else
		this.settaborder("cliente",30)		
	End if
End if
end event


HA$PBExportHeader$w_rep_inventario_inicial.srw
$PBExportComments$Si.
forward
global type w_rep_inventario_inicial from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_inventario_inicial
end type
end forward

global type w_rep_inventario_inicial from w_sheet_1_dw_rep
integer width = 2816
integer height = 2188
string title = "Inventario Valorado a la Fecha"
dw_1 dw_1
end type
global w_rep_inventario_inicial w_rep_inventario_inicial

on w_rep_inventario_inicial.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_inventario_inicial.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_1.insertRow(0)
this.ib_notautoretrieve = true
call super::open

end event

event resize;int li_width, li_height

li_width = this.workSpaceWidth()
li_height = this.workSpaceHeight()

this.setRedraw(False)
dw_1.resize(li_width - 2*dw_1.x, dw_1.height)
dw_datos.resize(dw_1.width,li_height - dw_datos.y - dw_1.y)
this.setRedraw(True)

end event

event ue_retrieve;String  ls_sucursal,ls_seccion,ls_tipo
integer li_tipo,li_resdet

dw_1.AcceptText()
li_tipo        = dw_1.getitemnumber(1,"tipo")
li_resdet   = dw_1.getitemnumber(1,"nombre")

If Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Para que la informaci$$HEX1$$f300$$ENDHEX$$n solicitada sea correcta se recomienda correr el proceso RECALCULAR ITEMS... Desea hacerlo en este momento...?",Question!,YesNo!,1 ) = 1 then
   	 open(w_diferencia_stocks )
end if



dw_datos.setredraw(false)		
If li_tipo = 1 Then

	Select sa_tipo
	into :ls_tipo
	from sg_acceso
	where em_codigo = :str_appgeninfo.empresa
	and sa_login = :str_appgeninfo.username;
	
	If ls_tipo <> 'A' Then
			messageBox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'No tiene permiso para ver este reporte')
			return
	end if
	
	
	dw_datos.DataObject = 'd_inventario_inicial_empresa'
	dw_datos.SetTransObject(sqlca)
     If li_resdet = 1 then
		dw_datos.Modify("st_codigo.visible = 0 st_producto.visible = 0 st_depto.visible = 1"+&
							"st_titulo.text = 'Inventario Valorado Resumido' "+&
							"DataWindow.Header.1.Height='423'" +&
							"DataWindow.Header.2.Height='0' Datawindow.Detail.height = '0'"+&
							"DataWindow.Trailer.2.Height='0'")
       End if
	If li_resdet = 2 Then	 
		dw_datos.Modify("st_codigo.visible = 1 st_producto.visible = 1 st_depto.visible = 0"+&
							"st_titulo.text = 'Inventario Valorado Detallado'"+& 
							"DataWindow.Header.1.Height='0'" +&
		                       "DataWindow.Header.2.Height='476' Datawindow.Detail.height = '423'"+&
							"DataWindow.Trailer.2.Height='476'")
	End if
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"'")
	dw_datos.retrieve(str_appgeninfo.empresa)
	dw_datos.setredraw(true)	
End if

If li_tipo = 2 Then
	dw_datos.DataObject = 'inventario_inicial_sucursal'
	dw_datos.SetTransObject(sqlca)
     If li_resdet = 1 then
		dw_datos.Modify("st_codigo.visible = 0 st_producto.visible = 0 st_depto.visible = 1"+&
							"st_titulo.text = 'Inventario Valorado Resumido' "+&
							"DataWindow.Header.1.Height='423'" +&
							"DataWindow.Header.2.Height='423' Datawindow.Detail.height = '0'"+&
							"DataWindow.Trailer.2.Height='0'")
       End if
	If li_resdet = 2 Then	 
		dw_datos.Modify("st_codigo.visible = 1 st_producto.visible = 1 st_depto.visible = 0"+&
							"st_titulo.text = 'Inventario Valorado Detallado'"+& 
							"DataWindow.Header.1.Height='476'" +&
		                       "DataWindow.Header.2.Height='476' Datawindow.Detail.height = '423'"+&
							"DataWindow.Trailer.2.Height='476'")
	End if
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"' st_sucursal.text ='"+gs_su_nombre+"'")
	dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal)
	dw_datos.setredraw(true)	
End if

If li_tipo = 3 Then
	dw_datos.DataObject = 'inventario_inicial_seccion'
	dw_datos.SetTransObject(sqlca)
     If li_resdet = 1 then
		dw_datos.Modify("st_codigo.visible = 0 st_producto.visible = 0 st_depto.visible = 1"+&
							"st_titulo.text = 'Inventario Valorado Resumido'"+&
							"DataWindow.Header.1.Height='423'" +&
							"DataWindow.Header.2.Height='423' Datawindow.Detail.height = '0'"+&
							"DataWindow.Trailer.2.Height='0'")
     End if
	If li_resdet = 2 then
		dw_datos.Modify("st_codigo.visible = 1 st_producto.visible = 1 st_depto.visible = 0"+&
							"st_titulo.text = 'Inventario Valorado Detallado'"+& 
							"DataWindow.Header.1.Height='476'" +&
		                       "DataWindow.Header.2.Height='476' Datawindow.Detail.height = '423'"+&
							"DataWindow.Trailer.2.Height='476'")

	End if
	dw_datos.modify("st_empresa.text ='"+gs_empresa+"' st_sucursal.text ='"+gs_su_nombre+"' st_seccion.text = '"+gs_bo_nombre+"'")	
     dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion)
	dw_datos.setredraw(true)	
End if
dw_datos.Modify("DataWindow.Print.Preview=Yes")	
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_inventario_inicial
integer x = 0
integer y = 252
integer width = 2779
integer height = 1832
string dataobject = "inventario_inicial_sucursal"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_inventario_inicial
integer x = 14
integer y = 244
integer width = 709
integer height = 368
end type

type dw_asiento from w_sheet_1_dw_rep`dw_asiento within w_rep_inventario_inicial
end type

type dw_1 from datawindow within w_rep_inventario_inicial
integer width = 2779
integer height = 252
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_sucur_bode"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type


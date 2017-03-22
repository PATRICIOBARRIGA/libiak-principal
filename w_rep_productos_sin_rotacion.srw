HA$PBExportHeader$w_rep_productos_sin_rotacion.srw
forward
global type w_rep_productos_sin_rotacion from w_sheet_1_dw_rep
end type
type dw_1 from datawindow within w_rep_productos_sin_rotacion
end type
end forward

global type w_rep_productos_sin_rotacion from w_sheet_1_dw_rep
integer width = 2386
integer height = 1860
string title = "Inventario Inicial"
dw_1 dw_1
end type
global w_rep_productos_sin_rotacion w_rep_productos_sin_rotacion

on w_rep_productos_sin_rotacion.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rep_productos_sin_rotacion.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;dw_1.insertRow(0)


end event

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_rep`dw_datos within w_rep_productos_sin_rotacion
integer x = 0
integer y = 144
integer width = 2350
integer height = 1608
string dataobject = "productos_sin_rotacion_por_seccion"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type dw_report from w_sheet_1_dw_rep`dw_report within w_rep_productos_sin_rotacion
integer x = 5
integer y = 148
string dataobject = "productos_sin_rotacion_por_seccion"
end type

type dw_1 from datawindow within w_rep_productos_sin_rotacion
integer width = 2345
integer height = 144
integer taborder = 10
boolean bringtotop = true
string title = "Productos S$$HEX1$$ed00$$ENDHEX$$n Rotaci$$HEX1$$f300$$ENDHEX$$n"
string dataobject = "d_sel_productos_sin_rotacion"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;String  ls_sucursal,ls_seccion,ls_empresa
integer li_tipo,li_dias
dw_1.AcceptText()

li_tipo    = dw_1.getitemnumber(row,"tipo")
li_dias =  dw_1.GetItemNumber(row,"dias")

SELECT EM_NOMBRE
INTO :ls_empresa
FROM PR_EMPRE
WHERE EM_CODIGO = :str_appgeninfo.empresa;

SELECT SU_NOMBRE
INTO :ls_sucursal
FROM PR_SUCUR
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal;

SELECT BO_NOMBRE
INTO :ls_seccion
FROM IN_BODE
WHERE EM_CODIGO = :str_appgeninfo.empresa
AND SU_CODIGO = :str_appgeninfo.sucursal
AND BO_CODIGO = :str_appgeninfo.seccion;

If li_tipo = 1 then
	dw_datos.DataObject = 'productos_sin_rotacion_por_sucursal'
	dw_datos.SetTransObject(sqlca)
	dw_datos.modify("st_empresa.text ='"+ls_empresa+"'")
	dw_datos.modify("st_sucursal.text ='"+ls_sucursal+"'")
	dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,li_dias)
	dw_datos.Modify("DataWindow.Print.Preview=Yes")
else
	dw_datos.DataObject = 'productos_sin_rotacion_por_seccion'
	dw_datos.SetTransObject(sqlca)
     dw_datos.retrieve(str_appgeninfo.empresa,str_appgeninfo.sucursal,str_appgeninfo.seccion,li_dias)
     dw_datos.modify("st_empresa.text ='"+ls_empresa+"'  t_10.text = ' "+ls_sucursal+" ' t_11.text = ' "+ls_seccion+ " ' ")
	dw_datos.Modify("DataWindow.Print.Preview=Yes")	
end if

call super::buttonclicked;
end event


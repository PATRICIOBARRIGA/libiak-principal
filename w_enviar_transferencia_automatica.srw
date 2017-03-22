HA$PBExportHeader$w_enviar_transferencia_automatica.srw
$PBExportComments$Si.Envio automatico de transferencias automatico
forward
global type w_enviar_transferencia_automatica from w_sheet_1_dw_maint
end type
type em_1 from editmask within w_enviar_transferencia_automatica
end type
type em_2 from editmask within w_enviar_transferencia_automatica
end type
type st_1 from statictext within w_enviar_transferencia_automatica
end type
type st_2 from statictext within w_enviar_transferencia_automatica
end type
type cb_1 from commandbutton within w_enviar_transferencia_automatica
end type
type dw_1 from datawindow within w_enviar_transferencia_automatica
end type
type dw_2 from datawindow within w_enviar_transferencia_automatica
end type
type dw_det from datawindow within w_enviar_transferencia_automatica
end type
type cb_2 from commandbutton within w_enviar_transferencia_automatica
end type
type dw_3 from datawindow within w_enviar_transferencia_automatica
end type
type st_3 from statictext within w_enviar_transferencia_automatica
end type
end forward

global type w_enviar_transferencia_automatica from w_sheet_1_dw_maint
integer width = 2985
integer height = 1512
string title = "Transferencia Autom$$HEX1$$e100$$ENDHEX$$tica"
long backcolor = 79741120
boolean ib_notautoretrieve = true
em_1 em_1
em_2 em_2
st_1 st_1
st_2 st_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
dw_det dw_det
cb_2 cb_2
dw_3 dw_3
st_3 st_3
end type
global w_enviar_transferencia_automatica w_enviar_transferencia_automatica

on w_enviar_transferencia_automatica.create
int iCurrent
call super::create
this.em_1=create em_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_det=create dw_det
this.cb_2=create cb_2
this.dw_3=create dw_3
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_det
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.dw_3
this.Control[iCurrent+11]=this.st_3
end on

on w_enviar_transferencia_automatica.destroy
call super::destroy
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_det)
destroy(this.cb_2)
destroy(this.dw_3)
destroy(this.st_3)
end on

event open;call super::open;string vecdatos[] = {'1','1','1','1','1','0'}

dw_3.insertrow(0)
f_recupera_empresa(dw_datos,"su_codenv")
f_recupera_empresa(dw_datos,"bo_codenv")
f_recupera_empresa(dw_datos,"su_codigo")
f_recupera_empresa(dw_datos,"bo_codigo")
f_recupera_datos(dw_datos,"tf_ticket",vecdatos,6)
f_recupera_empresa(dw_3,"sucursal")
dw_det.settransobject(sqlca)
dw_2.settransobject(sqlca)

call super::open
end event

event ue_retrieve;date    ld_fini,ld_ffin
string  ls_sucursal_destino

ld_fini = date(em_1.text)
ld_ffin = date(em_2.text)

ls_sucursal_destino = dw_3.getitemstring(1,"sucursal")

if ld_fini > ld_ffin then
Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","Rango de fechas incorrecto")
return
end if

dw_datos.retrieve(ld_fini,ld_ffin,str_appgeninfo.sucursal,ls_sucursal_destino)
end event

event closequery;return
end event

event resize;return 1
end event

type dw_datos from w_sheet_1_dw_maint`dw_datos within w_enviar_transferencia_automatica
integer x = 9
integer y = 256
integer width = 2409
integer height = 1148
integer taborder = 50
string dataobject = "d_transferencia_automatica"
boolean hscrollbar = false
end type

event dw_datos::doubleclicked;call super::doubleclicked;string ls_sucursal_origen,ls_bodega_origen,&
           ls_sucursal_destino,ls_bodega_destino,&
		 ls_ticket,ls_numero

ls_sucursal_origen = dw_datos.GetItemString(row,"su_codenv")
ls_bodega_origen = dw_datos.GetItemString(row,"bo_codenv")
ls_sucursal_destino = dw_datos.GetItemString(row,"su_codigo")
ls_bodega_destino = dw_datos.GetItemString(row,"bo_codigo")
ls_ticket = dw_datos.GetItemString(row,"tf_ticket")
ls_numero = dw_datos.GetItemString(row,"tf_numero")

/*Recuperar el detalle */
dw_det.visible = true
dw_det.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,ls_sucursal_destino,ls_bodega_destino,ls_ticket)

end event

event dw_datos::clicked;call super::clicked;datawindowchild  ldwc_ticket
string ls_sucursal_origen,ls_bodega_origen,&
           ls_sucursal_destino,ls_bodega_destino,&
		 ls_ticket,ls_numero

dw_datos.getchild("tf_ticket",ldwc_ticket)
ldwc_ticket.settransobject(sqlca)
If dwo.name = "tf_ticket" Then
ls_sucursal_origen = dw_datos.GetItemString(row,"su_codenv")
ls_bodega_origen = dw_datos.GetItemString(row,"bo_codenv")
ls_sucursal_destino = dw_datos.GetItemString(row,"su_codigo")
ls_bodega_destino = dw_datos.GetItemString(row,"bo_codigo")
ls_ticket = dw_datos.GetItemString(row,"tf_ticket")
ldwc_ticket.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,ls_sucursal_destino,ls_bodega_destino,ls_ticket)
End if

end event

type dw_report from w_sheet_1_dw_maint`dw_report within w_enviar_transferencia_automatica
integer x = 2661
integer y = 1136
integer width = 201
integer height = 100
integer taborder = 100
boolean hsplitscroll = true
end type

type em_1 from editmask within w_enviar_transferencia_automatica
integer x = 1495
integer y = 112
integer width = 343
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_2 from editmask within w_enviar_transferencia_automatica
integer x = 2066
integer y = 112
integer width = 343
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_enviar_transferencia_automatica
integer x = 1298
integer y = 124
integer width = 183
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_enviar_transferencia_automatica
integer x = 1879
integer y = 124
integer width = 151
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_enviar_transferencia_automatica
integer x = 2533
integer y = 264
integer width = 315
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;Long   ll_nreg,i
string ls_enviar,ls_sucursal_origen,ls_bodega_origen,&
           ls_sucursal_destino,ls_bodega_destino,&
		 ls_ticket,ls_numero,ls_filename_c,ls_filename_d
datetime   ld_fecha		 


if  Messagebox ("Atenci$$HEX1$$f300$$ENDHEX$$n","Est$$HEX2$$e1002000$$ENDHEX$$seguro de generar los archivos para la transferencia autom$$HEX1$$e100$$ENDHEX$$tica.?",question!,YesNo!,1) = 2 &
then
return
end if 

ll_nreg = dw_datos.rowcount()
dw_1.reset()
dw_2.reset()

for i = 1 to ll_nreg
	ls_enviar = dw_datos.getitemstring(i,"tf_numenvio")	
	if ls_enviar = 'S' then
	     /*argumentos para recuperar el detalle de la transferencia*/	
		ls_sucursal_origen = dw_datos.GetItemString(i,"su_codenv")
		ls_bodega_origen = dw_datos.GetItemString(i,"bo_codenv")
		ls_sucursal_destino = dw_datos.GetItemString(i,"su_codigo")
		ls_bodega_destino = dw_datos.GetItemString(i,"bo_codigo")
		ls_ticket = dw_datos.GetItemString(i,"tf_ticket")
		ls_numero = dw_datos.GetItemString(i,"tf_numero")
		ld_fecha = dw_datos.GetItemDateTime(i,"tf_fecha")	
	     /**/
	     dw_datos.rowscopy(i,i,Primary!,dw_1,ll_nreg,Primary!)
	     /*Recuperar el detalle */
  	     dw_det.retrieve(str_appgeninfo.empresa,ls_sucursal_origen,ls_bodega_origen,ls_sucursal_destino,ls_bodega_destino,ls_ticket)
        dw_det.rowscopy(1,dw_det.rowcount(),Primary!,dw_2,ll_nreg,Primary!)

	end if	
next

ls_filename_c = 'C:\LIBIAK\archivos\c_trf_'+ ls_sucursal_destino + '.txt'
ls_filename_d = 'C:\LIBIAK\archivos\d_trf_'+ ls_sucursal_destino + '.txt'
dw_1.saveas(ls_filename_c,Text!,FALSE)
dw_2.saveas(ls_filename_d,Text!,FALSE)
w_marco.setmicrohelp("Listo...El archivo cabecera se genero en: "+ ls_filename_c+&
                                           "   El archivo detalle se genero en: "+ls_filename_d)





end event

type dw_1 from datawindow within w_enviar_transferencia_automatica
boolean visible = false
integer x = 2729
integer y = 1268
integer width = 137
integer height = 112
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_transferencia_automatica"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_enviar_transferencia_automatica
boolean visible = false
integer x = 2944
integer y = 1000
integer width = 183
integer height = 100
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_archivo_plano_det_transferencia"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_det from datawindow within w_enviar_transferencia_automatica
boolean visible = false
integer x = 2990
integer y = 1148
integer width = 169
integer height = 128
integer taborder = 90
boolean bringtotop = true
string title = "Detalle Transferencia"
string dataobject = "d_archivo_plano_det_transferencia"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_enviar_transferencia_automatica
integer x = 2533
integer y = 132
integer width = 315
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
boolean default = true
end type

event clicked;parent.triggerevent("ue_retrieve")
end event

type dw_3 from datawindow within w_enviar_transferencia_automatica
integer x = 169
integer y = 100
integer width = 1029
integer height = 108
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_sel_sucursal"
boolean border = false
boolean livescroll = true
end type

type st_3 from statictext within w_enviar_transferencia_automatica
integer x = 23
integer y = 20
integer width = 2885
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 1090519039
long backcolor = 8388608
string text = "Para exportar, seleccione la sucursal de destino e ingrese el rango de fechas en el que se realiz$$HEX2$$f3002000$$ENDHEX$$el env$$HEX1$$ed00$$ENDHEX$$o de las transferencias."
alignment alignment = center!
boolean focusrectangle = false
end type


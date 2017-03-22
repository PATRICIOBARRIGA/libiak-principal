HA$PBExportHeader$w_exporta_tablas_sistema.srw
forward
global type w_exporta_tablas_sistema from w_response_basic
end type
type dw_nuevo from datawindow within w_exporta_tablas_sistema
end type
type st_1 from statictext within w_exporta_tablas_sistema
end type
type sle_1 from singlelineedit within w_exporta_tablas_sistema
end type
type rb_1 from radiobutton within w_exporta_tablas_sistema
end type
type rb_2 from radiobutton within w_exporta_tablas_sistema
end type
type gb_1 from groupbox within w_exporta_tablas_sistema
end type
end forward

global type w_exporta_tablas_sistema from w_response_basic
integer width = 1312
integer height = 868
string title = "Exportar Tablas"
dw_nuevo dw_nuevo
st_1 st_1
sle_1 sle_1
rb_1 rb_1
rb_2 rb_2
gb_1 gb_1
end type
global w_exporta_tablas_sistema w_exporta_tablas_sistema

on w_exporta_tablas_sistema.create
int iCurrent
call super::create
this.dw_nuevo=create dw_nuevo
this.st_1=create st_1
this.sle_1=create sle_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_nuevo
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.gb_1
end on

on w_exporta_tablas_sistema.destroy
call super::destroy
destroy(this.dw_nuevo)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_1)
end on

event open;DataWindowChild  ldw_aux

dw_response.InsertRow(0)
dw_response.GetChild("tabla",ldw_aux)
ldw_aux.SetTransObject(sqlca)
ldw_aux.Retrieve()
end event

type pb_cancel from w_response_basic`pb_cancel within w_exporta_tablas_sistema
integer x = 992
integer y = 560
integer taborder = 60
boolean originalsize = false
end type

event pb_cancel::clicked;close(parent)
end event

type pb_ok from w_response_basic`pb_ok within w_exporta_tablas_sistema
integer x = 494
integer y = 560
integer width = 183
integer height = 160
integer taborder = 50
end type

event pb_ok::clicked;integer i,li_aceptar
long j
string  ls_tabla,ls_columna,ls_columnas,ls_select,ls_dw_syntax,ls_error
string  ls_archivo,ls_where ,nula
string tablas[] = {'FA_VENTA','FA_DETVE','FA_RECPAG','FA_CIERRE','FA_CLIEN','FA_CTACLI','FA_GUIA','FA_MOVCAJA',+&
					'IN_AJUSTE','IN_CABAJUS','IN_CABPREP','IN_PREPARADO','IN_DETTOMA','IN_DETTRANS',+&
					'IN_MOVIM','IN_TOMFIS','IN_TRANSFER','IN_COMPRA','IN_DETCO',+&
					'CC_CHEQUE','CC_CRUCE','CC_MOVIM',+&					
					'CB_EGRESO','CB_DETEGR','CB_INGRESO','CB_DETING',+&
					'CO_CABCOM','CO_DETCOM',+&
					'CP_CABDEB','CP_CRUCE','CP_DETDEB','CP_MOVIM','CP_PAGO',+&
					'SG_ACCESO','SG_AUDIT','TS_DETING','TS_INGRESO',+&
					'XX_OBSEQUIO'}

setpointer(hourglass!)
If rb_1.checked = true then
	for i = 1 to upperbound(tablas)
	    w_marco.setmicrohelp("Exportando Tabla " + tablas[i] +" "+string(i)+" de " + string(upperbound(tablas)))
		ls_select = "SELECT * FROM "+tablas[i]+" WHERE ESTADO = 'E' OR ESTADO IS NULL ORDER BY 1,2,3,4"
		ls_dw_syntax = sqlca.SyntaxFromSQL(ls_select, "", ls_error)
		If ls_error <> "" Then
			rollback;
			MessageBox("Error al crear SQL", ls_error)
			Return
		End If
		ls_archivo = 'Datos\' + tablas[i] + ".sql"
		setnull(nula)
		dw_nuevo.Create(ls_dw_syntax)
		dw_nuevo.SetTransObject(sqlca)
		dw_nuevo.Retrieve()
		dw_nuevo.SaveAs(ls_archivo,SQLInsert!,False)
		w_marco.setmicrohelp("Tabla " + tablas[i] +" "+string(i)+" de " + string(upperbound(tablas))+ ' exportada...Actualizando estado...' )
		for j = 1 to dw_nuevo.RowCount()
			dw_nuevo.setitem(j,"estado",nula)
		next
		dw_nuevo.Update(FALSE, TRUE)
	next
	li_aceptar = MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro de grabar los datos exportados",Exclamation!,yesno!,2)
	If li_aceptar = 1 Then
		commit;
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Todos los Archivos se grabaron en el directorio:~n~rArchivos ")		
	Else
		rollback;
		return
	End if
	setpointer(arrow!)
End if

If rb_2.checked = true then
	ls_tabla = upper(dw_response.GetItemString(dw_response.GetRow(),"tabla"))
	ls_select = "SELECT * FROM "+ ls_tabla +" WHERE ESTADO <> 'E' OR ESTADO IS NULL ORDER BY 1,2,3,4"
	ls_dw_syntax = sqlca.SyntaxFromSQL(ls_select, "", ls_error)
	If ls_error <> "" Then
		rollback;
		MessageBox("Error al crear SQL", ls_error)
		Return
	End If
	ls_archivo = 'Datos\' + ls_tabla + ".sql"
	dw_nuevo.Create(ls_dw_syntax)
	dw_nuevo.SetTransObject(sqlca)
	dw_nuevo.Retrieve()
	dw_nuevo.SaveAs(ls_archivo,SQLInsert!,False)
	for j = 1 to dw_nuevo.RowCount()
		dw_nuevo.setitem(j,"estado",'E')
	next
	dw_nuevo.Update(FALSE, TRUE)		
	li_aceptar = MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta seguro de grabar los datos exportados",Exclamation!,yesno!,2)
	If li_aceptar = 1 Then
		commit;
	     MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","El archivo se grab$$HEX2$$f3002000$$ENDHEX$$en el directorio:~n"+ls_archivo+ " con $$HEX1$$e900$$ENDHEX$$xito.")
	Else
		rollback;
		return
	End if
	setpointer(arrow!)
End if
tablas[] ={''} 
w_marco.setmicrohelp("Proceso Terminado")


end event

type dw_response from w_response_basic`dw_response within w_exporta_tablas_sistema
integer x = 206
integer y = 384
integer width = 1051
integer height = 88
integer taborder = 40
string dataobject = "d_sel_tabla_a_exportar"
end type

type dw_nuevo from datawindow within w_exporta_tablas_sistema
boolean visible = false
integer x = 91
integer y = 848
integer width = 178
integer height = 132
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
boolean livescroll = true
end type

type st_1 from statictext within w_exporta_tablas_sistema
integer x = 32
integer y = 276
integer width = 398
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
string text = "Usuario (Owner):"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_exporta_tablas_sistema
integer x = 434
integer y = 276
integer width = 416
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_owner
DataWindowChild  ldw_aux

ls_owner = sle_1.text
dw_response.GetChild("tabla",ldw_aux)
ldw_aux.SetTransObject(sqlca)
If not isnull(ls_owner) and ls_owner<> "TODOS"  then
	ldw_aux.setfilter("owner = '"+ls_owner+"'")
else
	ldw_aux.setfilter('')
End if
ldw_aux.SetRedraw(false)
ldw_aux.Filter()
ldw_aux.SetRedraw(true)





end event

type rb_1 from radiobutton within w_exporta_tablas_sistema
integer x = 325
integer y = 92
integer width = 238
integer height = 80
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
string text = "Todas"
end type

event clicked;sle_1.text = ''
sle_1.enabled = false
dw_response.setitem(1,"Tabla",'')
dw_response.enabled = false

end event

type rb_2 from radiobutton within w_exporta_tablas_sistema
integer x = 663
integer y = 96
integer width = 306
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
string text = "Individual"
end type

event clicked;sle_1.enabled = true
dw_response.enabled = true

end event

type gb_1 from groupbox within w_exporta_tablas_sistema
integer x = 256
integer y = 12
integer width = 750
integer height = 204
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

